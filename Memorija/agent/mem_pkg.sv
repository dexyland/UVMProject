package mem_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	`include "command_transaction.sv"
	`include "command_sequence.sv"
	`include "command_sequence1.sv"
	`include "command_sequence2.sv"
	`include "driver.sv"
	`include "monitor.sv"
	`include "../scoreboard/scoreboard.sv"
	`include "../predictor/predictor.sv"
	`include "agent.sv"
	`include "env.sv"
	`include "test.sv"
	`include "test1.sv"
	`include "test2.sv"
	

endpackage : mem_pkg
   