library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.ALL;
--XOR
entity XOR_8 is
	port(EN:in STD_LOGIC;
	A,B:in std_logic_vector(7 downto 0);
	X:out std_logic_vector(7 downto 0);
	ZERO,CARRY:inout std_logic);
end XOR_8;

architecture XOR_F of XOR_8 is
begin
	process(EN,A,B)
	variable XO: std_logic_vector(7 downto 0);
	begin
	if(EN='1') then
		XO := A xor B;
		ZERO <= not (XO(0) or XO(1) or XO(2) or XO(3) or XO(4) or XO(5) or XO(6) or XO(7)); 
		CARRY <='0';
	else
		XO := "ZZZZZZZZ";
		ZERO<=ZERO;
		CARRY<=CARRY;
	end if;
	X<=XO;
	end process;
end XOR_F;