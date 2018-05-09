library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity Poarta_SI is
port(EN: in STD_LOGIC;
A,B: in STD_LOGIC_VECTOR(7 downto 0);
Y: out STD_LOGIC_VECTOR(7 downto 0);
CF,ZF: inout STD_LOGIC);
end;  

architecture SI of Poarta_SI is

begin
	process(EN,A,B)
	variable K: STD_LOGIC_VECTOR(7 downto 0);
	begin  
		if(EN='1') then
			K := A and B;
			CF <= '0';
			ZF <= not(K(0) or K(1) or K(2) or K(3) or K(4) or K(5) or K(6) or K(7));
		else
			K:="ZZZZZZZZ";
			CF<= CF;
			ZF<= ZF;
		end if;
	Y <= K;
	end process;
end; 