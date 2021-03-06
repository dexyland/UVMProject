class test2 extends uvm_test;
    `uvm_component_utils(test2);

    env m_env;

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new


    function void build_phase(uvm_phase phase);

        m_env = env::type_id::create("env", this);

    endfunction : build_phase

    task run_phase(uvm_phase phase);
		command_sequence2 seq2;
		
		phase.raise_objection(this);
		
		seq2 = command_sequence2::type_id::create("seq2");
		
		seq2.start(m_env.m_agent.m_sequencer);
		
        #2us;
		
		phase.drop_objection(this);

  endtask: run_phase

endclass: test2