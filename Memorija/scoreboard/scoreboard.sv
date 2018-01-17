class scoreboard  #(type T = uvm_object) extends uvm_scoreboard;
	`uvm_component_utils(scoreboard #(T))
	
	// Components
	uvm_tlm_analysis_fifo #(T) exp_fifo; // expected fifo
	uvm_tlm_analysis_fifo #(T) obs_fifo; // observed fifo
	
	// Ports
	uvm_analysis_export #(T)   exp_axport;
	uvm_analysis_export #(T)   obs_axport;
	
	// Variables
	int num_err, num_match;

  // Methods
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction : new
	
	extern virtual function void build_phase  (uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);
	extern virtual task          run_phase    (uvm_phase phase);
	extern virtual function void report_phase (uvm_phase phase);
  
endclass : scoreboard

//******************************************************************************
// Function/Task implementations
//******************************************************************************

	function void scoreboard::build_phase(uvm_phase phase);
		super.build_phase(phase);
    
		exp_axport = new("exp_axport", this);
		obs_axport = new("obs_axport", this);
		exp_fifo   = new("exp_fifo"  , this);
		obs_fifo   = new("obs_fifo"  , this);
	endfunction : build_phase
  
//------------------------------------------------------------------------------

	function void scoreboard::connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		exp_axport.connect(exp_fifo.analysis_export);
		obs_axport.connect(obs_fifo.analysis_export);
	endfunction : connect_phase

//------------------------------------------------------------------------------

	task scoreboard::run_phase(uvm_phase phase);
		T it_obs, it_exp;
		
		forever begin
			obs_fifo.get(it_obs);
			exp_fifo.get(it_exp);
			if (!it_exp.compare(it_obs)) begin
				num_err++;
				if(num_err == 1) begin
				it_exp.print();
				it_obs.print();
				end
			end else
			num_match++;
				
		end 
	endtask : run_phase

//------------------------------------------------------------------------------

	function void scoreboard::report_phase (uvm_phase phase);
		if (!obs_fifo.is_empty()) begin
			`uvm_error("SCBD", $sformatf("\nObserved FIFO is not empty. Number of items left: %0d\n",
							obs_fifo.used()))
		end
    
		if (!exp_fifo.is_empty()) begin
			`uvm_error("SCBD", $sformatf("\nExpected FIFO is not empty. Number of items left: %0d\n",
							exp_fifo.used()))
		end
    
		`uvm_info("SCBD", $sformatf("\nNumber of recorded missmatches : %0d", num_err), UVM_LOW)
		`uvm_info("SCBD", $sformatf("\nNumber of recorded matches : %0d", num_match), UVM_LOW)
  endfunction : report_phase
