

library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;  

-----------------------------------------------------------------------------

entity memory is
  port (
    Clk:                          in std_logic;
    Reset_n:                      in std_logic;
    Address:                      in std_logic_vector (2 downto 0);
    Rd_Cs:                        in std_logic;
    Wr_Cs:                        in std_logic;
    op:                           in std_logic_vector (1 downto 0);
    Ready:                        out std_logic;
    Wr_Data:                      in std_logic_vector (7 downto 0);
    Rd_Data:                      out std_logic_vector (7 downto 0)
  );
end memory;

architecture beh of memory is

  type t_Memory is array (0 to 7) of std_logic_vector(7 downto 0);
  type t_State is (idle,r1,w1,w2,w3,w4,w5,w6);  
  
  signal state, next_state: t_State ;   
  signal r_Mem: t_Memory;
  


begin

  process (Clk, Reset_n)
  begin
    if (Reset_n = '0') then
      state <= idle;      
    elsif ((Clk = '1') and Clk'event) then
      state <= next_state;
    end if;
  end process;    
                     


                    
  
  process (state, Wr_Cs, Rd_Cs,op)
  begin
  ready <= '0';
   case (state) is
     when idle => 
		ready <= '1';
		if (Wr_Cs = '1' and Rd_Cs = '0') then
                    next_state <= w1;
                  elsif (RD_Cs = '1' and Wr_Cs = '0') then 
                    next_state <= r1;
                  else               
                    next_state <= idle;
						end if;
     when w1 => 
                  next_state <= w2;
     when w2 =>   if (op = "11") then
                    next_state <= idle;
                  else next_state <= w3;
						end if;
     when w3 =>   if (op = "00") then
                    next_state <= idle;
                  else next_state <= w4;
						end if;
     when w4 => 
                  next_state <= w5;
     when w5 => 
                  if (op = "01") then
                    next_state <= idle;
                  else next_state <= w6;
						end if;
     when w6 =>    
                  next_state <= idle;

     when r1 => 
                  next_state <= idle;
   end case;
 end process;
                  
                  
  process (Clk, Reset_n)
  begin
    if (Reset_n = '0') then
      for i in 0 to 7 loop
         r_Mem(i) <= (others => '0');
      end loop;			
    elsif ((Clk = '1') and Clk'event) then
	   case (state) is
		  when r1 => Rd_Data <= r_Mem(to_integer(unsigned(Address)));
		  when w2 => r_Mem(to_integer(unsigned(Address))) <= Wr_Data;                    -- op = "11"
		  when w3 => r_Mem(to_integer(unsigned(Address))) <= not (Wr_Data);              -- op = "00"
		  when w5 => r_Mem(to_integer(unsigned(Address))) <=  Wr_Data(6 downto 0)& '0';  -- op = "01" 
		  when w6 => r_Mem(to_integer(unsigned(Address))) <=  '0' & Wr_Data(7 downto 1); -- op = "10"
		  when others => null;
		end case; 		
    end if;
  end process;                    
                    
  

end beh;
