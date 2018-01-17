class driver extends uvm_driver #(command_transaction);
   `uvm_component_utils(driver)

   virtual command_if cmd_if;
   command_transaction tr;

   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new
   
   function void build_phase(uvm_phase phase);
      if(!uvm_config_db #(virtual command_if)::get(this, "","command_interface", cmd_if))
        `uvm_fatal("DRIVER", "Failed to get interface");
		
	  if(!uvm_config_db #(int)::get(this, "","delay", delay))
        `uvm_fatal("DRIVER", "Failed to get delay");
   endfunction : build_phase
  
    task init_driver();
	    cmd_if.write_en    <= 0;
	    cmd_if.read_en     <= 0;
	    cmd_if.op          <= 0;
	    cmd_if.address     <= 0;
	    cmd_if.write_data  <= 0;
    endtask : init_driver
 
	task drive_transaction();
		@(posedge cmd_if.clk);
			  
		for (brojac = 0; brojac < delay; brojac++) begin
			@(posedge cmd_if.clk);
		end
			
		if (cmd_if.reset_n === 1'b1) begin
			cmd_if.operand_A <= tr.operand_A;
			cmd_if.operand_B <= tr.operand_B;
			cmd_if.valid 	  <= tr.valid;
			//tr.print();
		end
	endtask : drive_transaction
	
    task run_phase(uvm_phase phase);
		init_driver;
		
		forever begin
			seq_item_port.get_next_item(tr);
			drive_transaction;
			seq_item_port.item_done();
		end
    endtask : run_phase
   
   
endclass : driver
