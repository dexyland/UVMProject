interface command_if;

    bit                         clk;
    bit                         reset_n;
    bit                         write_en;
    bit                         read_en;
    bit                         ready;
    logic [1:0]                 op;
    logic [2:0]                 address;
    logic [7:0]                 write_data;
    logic [7:0]                 read_data;

endinterface : command_if
