library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.ALL;

--OR
entity OR_8 is
	port(EN: std_logic;
	A,B:in std_logic_vector(7 downto 0);
	O:out std_logic_vector(7 downto 0);
	CARRY,ZERO: out std_logic);
end OR_8;

architecture OR_F of OR_8 is
--signal ORR: std_logic_vector(7 downto 0);
begin
	process(EN,A,B)
	variable ORR:std_logic_vector(7 downto 0);
	begin
		if(EN = '1') then
			ORR := A or B;
			CARRY <= '0';
			ZERO <= not (ORR(0) or ORR(1) or ORR(2) or ORR(3) or ORR(4) or ORR(5) or ORR(6) or ORR(7));
		else
			ORR := "ZZZZZZZZ";
			CARRY <='Z';
			ZERO <= 'Z';
		end if;
	O<= ORR;
	end process;
end OR_F;