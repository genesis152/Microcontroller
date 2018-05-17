	 library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity num is
Port ( CLK,Reset,CU_D,PL: in std_logic;
cnt : 	out std_logic_vector(3 downto 0);
load_in: in std_logic_vector(3 downto 0));
end num;

architecture Numarator of num is 
begin
process (Reset,CLK,CU_D,PL)
begin
if reset='1' then
cnt <="0000";
elsif (clk'event and clk ='1') then
	if CU_D ='0' then
		cnt <= cnt+1;
	else
		cnt <= cnt-1;
	end if;
end if;
if(PL= '1') then cnt <= load_in;
	end if;
end process;
end Numarator;