class test extends uvm_test;
    `uvm_component_utils(test);

    env m_env;

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new


    function void build_phase(uvm_phase phase);

        m_env = env::type_id::create("env", this);

    endfunction : build_phase

    task run_phase(uvm_phase phase);
        command_sequence seq;

        phase.raise_objection(this);
        seq = command_sequence::type_id::create("seq");

        seq.start(m_env.m_agent.m_sequencer);

        #2us;
		
		/*seq1 = command_sequence1::type_id::create("seq1");
		
		seq.start(m_env.m_agent.m_sequencer);*/
        phase.drop_objection(this);
  endtask: run_phase

endclass: test