module top;
import uvm_pkg::*;
import   adder_pkg::*;
`include "uvm_macros.svh"

bit clk; 
bit reset_n; 
command_if       command_interface();
   
adder       dut (.A(command_interface.operand_A), .B(command_interface.operand_B), 
                 .clk(command_interface.clk), .reset_n(command_interface.reset_n), 
                 .valid(command_interface.valid),
                 .result(command_interface.result));

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
    reset_n = 1'b1;  // comment
    #10;
    reset_n = 1'b0;
    #40;
    reset_n = 1'b1;  // comment
 end 
 
assign command_interface.clk = clk;
assign command_interface.reset_n = reset_n; 
 
endmodule : top

     
   