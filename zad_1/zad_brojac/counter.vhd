library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is
   port( 
	 in_start_number: 	in std_logic_vector(7 downto 0);
	 in_increment: 		in std_logic_vector(7 downto 0);
	 in_up_down: 			in std_logic;
	 in_cnt_number:		in std_logic_vector(7 downto 0);
	 in_enable : 			in std_logic;
	 o_valid : 				out std_logic;
	 o_ready : 				out std_logic;
 	 clk : 					in std_logic;
 	 rst : 					in std_logic;
 	 o_number: 				out std_logic_vector(7 downto 0));
end counter;
 
architecture Behavioral of counter is
	TYPE state_type IS (inputs, increment);  
	SIGNAL state, next_state : state_type;  
	signal r_increment, r_cnt_number : std_logic_vector(7 downto 0);
	signal rn_increment, rn_cnt_number : std_logic_vector(7 downto 0);
	signal r_result : std_logic_vector(7 downto 0);
	signal rn_result : std_logic_vector(7 downto 0);
	signal r_up_down, rn_up_down : std_logic;
	
	begin   
		process(clk, rst)
		begin
			if rst='0' then
				r_increment 	 <= 	(others => '0');
				r_up_down		 <= 	'0';
				r_cnt_number 	 <= 	(others => '0');
				r_result 	 	 <= 	(others => '0');
			elsif(rising_edge(clk)) then
					r_increment 	<= rn_increment;
					r_up_down 		<= rn_up_down;
					r_cnt_number 	<= rn_cnt_number;
					r_result			<= rn_result;
					state 			<= next_state;
			end if;
		end process;
		
		process(state, r_cnt_number, r_up_down, in_enable) begin
			next_state <= inputs;
			rn_increment <= r_increment;
			rn_up_down <= r_up_down;
			rn_cnt_number <= r_cnt_number;
			rn_result <= r_result;
			o_valid <= '0';
			o_ready <= '1';
			case state is
				when inputs =>
					if(in_enable = '1') then
						next_state <= increment;
						rn_increment <= in_increment;
						rn_up_down <= in_up_down;
						rn_cnt_number <= in_cnt_number;
						rn_result <= in_start_number;
					end if;
				when increment =>
					o_ready <= '0';
					if(r_cnt_number = 0) then
						next_state <= inputs;
						o_valid <= '1';
					else
						next_state <= increment;
						rn_cnt_number <= r_cnt_number - 1;
					end if;
					
					if(r_up_down = '1') then
						rn_result <= r_result + r_increment;
					else
						rn_result <= r_result - r_increment;
					end if;
			end case;
		end process;
		o_number <= r_result;
end Behavioral;
