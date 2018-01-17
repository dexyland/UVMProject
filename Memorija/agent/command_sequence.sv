class command_sequence extends uvm_sequence #(command_transaction);
  `uvm_object_utils(command_sequence)
  
  function new (string name = "command_sequence");
    super.new(name);
  endfunction : new

  // A variable that specifies the number of transactions to
  // generate in the sequence
  int count = 15;
  int brojac = 0;
  int a_help = 1;
  int b_help = 0;
  int zbir = 0;

  task body;
    command_transaction tx;
    repeat(count)
    begin
		tx = command_transaction::type_id::create("tx");

		start_item(tx);
		if(!tx.randomize())
			`uvm_error(get_full_name(), "Randomization failed")
			
	/*	a_hist = tx.operand_A;
		b_hist = tx.operand_B;
		*/
		/*if(!tx.randomize() with {num_of_el inside {[5 : 15]};})
			`uvm_error(get_full_name(), "Randomization failed")
		*/
		//$display("Broj elemenata: %d", tx.num_of_el);
		
		/*for (brojac = 0; brojac < tx.num_of_el; brojac++) begin     
			if (brojac <= 1) begin
				zbir = brojac;
			end
			else begin
				zbir = a_help + b_help;
				a_help = b_help;
				b_help = zbir;
			end
			
			tx.result_queue.push_back(zbir);
		end*/

		tx.print();
      finish_item(tx);      
    end
	 
	/* start_item(tx);
	 if(!tx.randomize() with { operand_A != 0; operand_B > 2; valid == 0; } )
			`uvm_error(get_full_name(), "Randomization failed") 
	 finish_item(tx); */
  endtask: body

endclass: command_sequence

