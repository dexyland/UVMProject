class predictor extends uvm_component;
	`uvm_component_utils(predictor)
	command_transaction tr;
	//input
	uvm_analysis_imp    #(command_transaction, predictor) i_operands;
   
	// output
	uvm_analysis_port   #(command_transaction) o_mem;
   
	function new(string name = "predictor", uvm_component parent);
		super.new(name, parent);
		i_operands    = new("i_operands"  , this);
		o_mem         = new("o_mem"       , this);
		tr = command_transaction::type_id::create("tr_in");		
	endfunction : new

	extern virtual task          run_phase    (uvm_phase phase);
	extern virtual function void write   (command_transaction t);

endclass : predictor

//******************************************************************************
// Function/Task implementations
//******************************************************************************
 function void predictor::write(command_transaction t);
	if(t.ready == 1) begin
		//$display("HELLO FROM PREDICTOR");
		tr.write_en    <= t.write_en;
		tr.read_en     <= t.read_en;
		tr.ready       <= t.ready;
		tr.op          <= t.op;
		tr.address     <= t.address;
		tr.write_data  <= t.write_data;
		tr.read_data   <= t.read_data;
		//tr.print();
		o_addr.write(tr);
	end
 endfunction : write
//------------------------------------------------------------------------------

task predictor::run_phase(uvm_phase phase);
	//forever begin

	//end
endtask : run_phase
