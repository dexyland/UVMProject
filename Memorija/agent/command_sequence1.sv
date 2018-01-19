class command_sequence1 extends uvm_sequence #(command_transaction);
    `uvm_object_utils(command_sequence1)
  
    function new (string name = "command_sequence1");
        super.new(name);
    endfunction : new

    // A variable that specifies the number of transactions to
    // generate in the sequence
    int count = 10;
	int brojac = 0;

    task body;
        command_transaction tx;

		repeat(count)
		begin
			tx = command_transaction::type_id::create("tx");
			start_item(tx);
			
			if(!tx.randomize() with {address % 2 == 0; write_en != read_en;})
                `uvm_error(get_full_name(), "Randomization failed")
				
			if (brojac % 5 == 4) begin
				tx.write_en = tx.read_en;
			end
			
			brojac += 1;

			finish_item(tx);
		end

    endtask: body

endclass: command_sequence1
