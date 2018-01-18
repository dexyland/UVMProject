class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)

    // Components
    virtual command_if cmd_if;
    
    // Ports
    uvm_analysis_port #(command_transaction) aport;

    // Constructor
    function new(string name = get_name(), uvm_component parent);
        super.new(name, parent);
        aport = new("aport", this);
    endfunction
    
    function void build_phase(uvm_phase phase);
        if(!uvm_config_db #(virtual command_if)::get(this, "","command_interface", cmd_if))
          `uvm_fatal("MONITOR", "Failed to get interface");
    endfunction : build_phase

    // Function/Task declarations
    extern virtual task          run_phase          (uvm_phase phase);

endclass: monitor

//******************************************************************************
// Function/Task implementations
//******************************************************************************

    task monitor::run_phase(uvm_phase phase);
        command_transaction tr_in;
        tr_in = command_transaction::type_id::create("tr_in");

        forever begin
            tr_in.ready   = cmd_if.ready;

            if (cmd_if.reset_n == 1) begin
                tr_in.write_en   = cmd_if.write_en;
                tr_in.read_en    = cmd_if.read_en;
                tr_in.op         = cmd_if.op;
                tr_in.address    = cmd_if.address;
                tr_in.write_data = cmd_if.write_data;
                tr_in.read_data  = cmd_if.read_data;
                @(posedge cmd_if.clk);
                //tr_in.print();
                aport.write(tr_in);
            end else
                @(posedge cmd_if.clk);
        end
    endtask: run_phase
