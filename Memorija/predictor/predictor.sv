class predictor extends uvm_component;
	`uvm_component_utils(predictor)
	command_transaction tr;
	//input
	uvm_analysis_imp   #(command_transaction, predictor) i_operands;
   
	// output
	uvm_analysis_port       #(command_transaction) o_addr;
   
	function new(string name = "predictor", uvm_component parent);
		super.new(name, parent);
		i_operands    = new("i_operands"  , this);
		o_addr        = new("o_addr"       , this);
		tr = command_transaction::type_id::create("tr_in");		
	endfunction : new

	extern virtual task          run_phase    (uvm_phase phase);
	extern virtual function void write   (command_transaction t);

endclass : predictor

//******************************************************************************
// Function/Task implementations
//******************************************************************************
 function void predictor::write(command_transaction t);
	if(t.valid == 1) begin
		//$display("HELLO FROM PREDICTOR");
		tr.operand_A = t.operand_A;
		tr.operand_B = t.operand_B;
		tr.result_queue.push_back(t.operand_A + t.operand_B);
		//tr.print();
		o_addr.write(tr);
	end
 endfunction : write
//------------------------------------------------------------------------------

task predictor::run_phase(uvm_phase phase);
	//forever begin

	//end
endtask : run_phase
