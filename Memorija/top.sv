module top;
    import uvm_pkg::*;
    import mem_pkg::*;
    `include "uvm_macros.svh"

    bit clk; 
    bit reset_n; 
    command_if       command_interface();

    memory      dut (.Clk(command_interface.clk), .Reset_n(command_interface.reset_n), 
                    .Address(command_interface.address), .Rd_Cs(command_interface.read_en), 
                    .Wr_Cs(command_interface.write_en), .op(command_interface.op),
                    .Ready(command_interface.ready), .Wr_Data(command_interface.write_data),
                    .Rd_Data(command_interface.read_data));

    initial begin
        uvm_config_db #(virtual command_if)::set(null, "*", "command_interface", command_interface);
        run_test("test");
    end

    initial begin
        clk = 0;
        forever begin
           #10;
           clk = ~clk;
        end
    end

    initial begin
        reset_n = 1'b0;
        #40;
        reset_n = 1'b1;  // comment
    end 

    assign command_interface.clk = clk;
    assign command_interface.reset_n = reset_n; 

endmodule : top

     
   