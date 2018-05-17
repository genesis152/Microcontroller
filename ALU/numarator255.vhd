library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity num8 is
Port ( CLK,Reset,CU_D,PL: in std_logic;
cnt : 	out std_logic_vector(7 downto 0):=(others=>'0');
load_in: in std_logic_vector(7 downto 0));
end num8;

architecture Numarator255 of num8 is  
begin
process (Reset,CLK,CU_D,PL)
variable B:	std_logic_vector(7 downto 0):="00000000";
variable EN: bit:='0';
begin
--cnt<=B;
if reset='1' then
elsif (RISING_EDGE(CLK)) then	
	if(EN='1') then
		if(PL= '1') then 
			cnt <= load_in;
			B   := load_in;
		elsif (CU_D ='0') then
			B := B+1;
		else
			B := B-1;
		end if;
	end if;
	if(B = "00000000") then
		EN:= '1'; end if;
	cnt<= B;
	if(B = "11111111") then
		EN:='0';
	end if;
end if;
end process;
end Numarator255;
