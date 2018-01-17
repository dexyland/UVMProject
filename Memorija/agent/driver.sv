class driver extends uvm_driver #(command_transaction);
   `uvm_component_utils(driver)

    virtual command_if cmd_if;
    command_transaction tr;

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new
   
    function void build_phase(uvm_phase phase);
        if(!uvm_config_db #(virtual command_if)::get(this, "","command_interface", cmd_if))
            `uvm_fatal("DRIVER", "Failed to get interface");
        
/*      if(!uvm_config_db #(int)::get(this, "","delay", delay))
        `uvm_fatal("DRIVER", "Failed to get delay");*/
    endfunction : build_phase
  
    task init_driver();
        cmd_if.write_en    <= 0;
        cmd_if.read_en     <= 0;
        cmd_if.op          <= 0;
        cmd_if.address     <= 0;
        cmd_if.write_data  <= 0;
    endtask : init_driver
 
    task drive_transaction();
        @(posedge cmd_if.clk);
            
        //if (cmd_if.reset_n === 1 && cmd_if.ready === 1) begin
            cmd_if.write_en    <= tr.write_en;
            cmd_if.read_en     <= tr.read_en;
            cmd_if.op          <= tr.op;
            cmd_if.address     <= tr.address;
            cmd_if.write_data  <= tr.write_data;
            //tr.print();
        //end
    endtask : drive_transaction
    
    task run_phase(uvm_phase phase);
        init_driver;
        
        forever begin
			if (cmd_if.reset_n === 1 && cmd_if.ready === 1) begin
                seq_item_port.get_next_item(tr);
                drive_transaction;
                seq_item_port.item_done();
			end
		end
    endtask : run_phase

endclass : driver
