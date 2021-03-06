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
signal B:	std_logic_vector(3 downto 0):="0000"; 
begin
process (Reset,CLK,CU_D,PL)
begin		 
--cnt<=B;
if reset='1' then
cnt<="0000";
elsif (clk'event and clk ='1') then	
	if CU_D ='0' then
		B<= B+1;
	else
		B <=B-1;
	end if;
end if;
if(PL= '1') then cnt <= load_in;
end if;
cnt<=B;
end process;
end Numarator;