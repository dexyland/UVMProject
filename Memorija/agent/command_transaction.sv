class command_transaction extends uvm_sequence_item;
    //`uvm_object_utils(command_transaction)
    rand bit              write_en;
    rand bit              read_en;
    bit            	      ready;
    rand    logic [1:0]   op;
    rand    logic [2:0]   address;
    rand    byte          write_data;
    byte                  read_data;
    static  int           num_of_transaction;

   //constraint data_constraint { operand_A dist {8'h00:=1, [8'h01 : 8'hFE]:=1, 8'hFF:=1};
    //                                      operand_B dist {8'h00:=1, [8'h01 : 8'hFE]:=1, 8'hFF:=1};}
	
	constraint operation_implication1 { (write_en == 1) -> (read_en == 0);} 
	constraint operation_implication2 { (write_en == 0) -> (read_en == 1);}
     

     // UVM factory registracija
    `uvm_object_utils_begin(command_transaction)
        `uvm_field_int(write_en,        UVM_DEFAULT | UVM_NOCOMPARE)
        `uvm_field_int(read_en,         UVM_DEFAULT | UVM_NOCOMPARE)
        `uvm_field_int(ready,           UVM_DEFAULT | UVM_NOCOMPARE)
        `uvm_field_int(op,              UVM_DEFAULT | UVM_NOCOMPARE)
        `uvm_field_int(address,         UVM_DEFAULT | UVM_NOCOMPARE)
        `uvm_field_int(write_data,      UVM_DEFAULT | UVM_NOCOMPARE)
        `uvm_field_int(read_data,       UVM_DEFAULT | UVM_NOCOMPARE)
    `uvm_object_utils_end
    
   function new (string name = "command_transaction");
        super.new(name);
        num_of_transaction++;
        //$display("Transaction number %d created", num_of_transaction);
   endfunction : new

endclass : command_transaction

      
        