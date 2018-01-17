class env extends uvm_env;
   `uvm_component_utils(env);

   agent      m_agent;   
	scoreboard#(command_transaction) m_scoreboard;
	predictor	m_predictor;
   function void build_phase(uvm_phase phase);
    m_agent         = agent::type_id::create("m_agent",this);     
    m_scoreboard    = scoreboard#(command_transaction)::type_id::create("m_scoreboard",this);     
    m_predictor     = predictor::type_id::create("m_predictor",this);     
   endfunction : build_phase

   function void connect_phase(uvm_phase phase);
		m_agent.aport.connect(m_scoreboard.obs_axport);
		m_agent.aport.connect(m_predictor.i_operands);
		m_predictor.o_addr.connect(m_scoreboard.exp_axport);
   endfunction : connect_phase
   
   function new (string name, uvm_component parent);
      super.new(name,parent);
   endfunction : new

endclass
   