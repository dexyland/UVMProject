class command_sequence extends uvm_sequence #(command_transaction);
    `uvm_object_utils(command_sequence)
  
    function new (string name = "command_sequence");
        super.new(name);
    endfunction : new

    // A variable that specifies the number of transactions to
    // generate in the sequence
    int count = 8;
    byte wr_data = 1;
	int data_set = 0;

    task body;
        command_transaction tx;
        repeat(count)
        begin
            tx = command_transaction::type_id::create("tx");
			
            start_item(tx);
			
            if(!tx.randomize() with {address == 5; op == 0; write_en == 1;}) begin
                `uvm_error(get_full_name(), "Randomization failed")
            end
			
			tx.write_data = wr_data;
			wr_data = wr_data << 1;
			
			$display("EEE %b", wr_data);
			
            tx.print();
            finish_item(tx);
        end
         
        /* start_item(tx);
         if(!tx.randomize() with { operand_A != 0; operand_B > 2; valid == 0; } )
                `uvm_error(get_full_name(), "Randomization failed") 
         finish_item(tx); */
    endtask: body

endclass: command_sequence

