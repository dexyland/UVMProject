class command_sequence extends uvm_sequence #(command_transaction);
    `uvm_object_utils(command_sequence)
  
    function new (string name = "command_sequence");
        super.new(name);
    endfunction : new

    // A variable that specifies the number of transactions to
    // generate in the sequence
    int count = 7;
    byte wr_data = 1;

    task body;
        command_transaction tx;
        repeat(count)
        begin
            tx = command_transaction::type_id::create("tx");
			
            start_item(tx);
			
			tx.address  = 3'b101;
			tx.write_en = 1'b1;
			tx.read_en  = 1'b0;
			tx.op       = 2'b11;
			
			tx.write_data = wr_data;
			wr_data = wr_data << 1;
			
            finish_item(tx);
        end
		
		repeat(count + 1)
        begin
            tx = command_transaction::type_id::create("tx");
			
            start_item(tx);
			
			tx.address  = 3'b101;
			tx.write_en = 1'b1;
			tx.read_en  = 1'b0;
			tx.op       = 2'b11;
			
			tx.write_data = wr_data;
			wr_data = wr_data >> 1;

            finish_item(tx);
        end
		
		repeat(count)
		begin
			tx = command_transaction::type_id::create("tx");
			start_item(tx);
			
			if(!tx.randomize() with {address inside {3'b000, 3'b001, 3'b010, 3'b011};})
                `uvm_error(get_full_name(), "Randomization failed")
				
			tx.write_en = 1'b1;
			tx.read_en  = 1'b0;
			tx.op = 2'b11;

			finish_item(tx);
		end
         
        /* start_item(tx);
         if(!tx.randomize() with { operand_A != 0; operand_B > 2; valid == 0; } )
                `uvm_error(get_full_name(), "Randomization failed") 
         finish_item(tx); */
    endtask: body

endclass: command_sequence

