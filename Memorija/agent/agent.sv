typedef uvm_sequencer #(command_transaction) command_sequencer;

class agent extends uvm_agent;
   `uvm_component_utils(agent)

   driver                  m_driver;
   command_sequencer       m_sequencer;   
   monitor       		   m_monitor;  
	
   uvm_analysis_port #(command_transaction) aport;
	
function new (string name, uvm_component parent);
   super.new(name,parent);
   aport = new("aport", this);	
endfunction : new  


function void build_phase(uvm_phase phase);

   m_driver    = driver::type_id::create("m_driver",this);
   m_sequencer = command_sequencer::type_id::create("m_sequencer", this);
   m_monitor   = monitor::type_id::create("m_monitor", this);

endfunction : build_phase

function void connect_phase(uvm_phase phase);
    m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
	m_monitor.aport.connect(aport);	
endfunction : connect_phase

endclass : agent

