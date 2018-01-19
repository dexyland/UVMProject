class command_sequence2 extends uvm_sequence #(command_transaction);
    `uvm_object_utils(command_sequence2)
  
    function new (string name = "command_sequence2");
        super.new(name);
    endfunction : new

    // A variable that specifies the number of transactions to
    // generate in the sequence
    int count = 10;
	int brojac = 0;
    byte wr_data = 3;

    task body;
        command_transaction tx;

		repeat(count)
		begin
			tx = command_transaction::type_id::create("tx");
			start_item(tx);

			tx.address    = 3'b011;
			tx.op         = 2'b11;
		    tx.read_en    = 1'b0;
		    tx.write_en   = 1'b1;
			
			if (brojac > 3 && brojac < 8) begin
				tx.write_data = wr_data;
			end else begin
				tx.read_en  = 1'b1;
				tx.write_en = 1'b0;
			end
			
			if (brojac > 4) begin
				wr_data = wr_data << 1;
			end
			
			$display("SHIFTSHIFT   %d", brojac);
			$display("wr_data  %d", wr_data);
			
			brojac += 1;

			finish_item(tx);
		end
         
        /* start_item(tx);
         if(!tx.randomize() with { operand_A != 0; operand_B > 2; valid == 0; } )
                `uvm_error(get_full_name(), "Randomization failed") 
         finish_item(tx); */
    endtask: body

endclass: command_sequence2

