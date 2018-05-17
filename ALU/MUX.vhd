--MERGE FARA BUGURI

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.ALL;
use tip.all;

entity Mux16la1 is
 port(MUX_IN: in M168;
 	      EN: in STD_LOGIC;
         SEL: in STD_LOGIC_VECTOR(3 downto 0);
     MUX_OUT: out STD_LOGIC_VECTOR(7 downto 0) );
end  Mux16la1;

architecture Mux1 of Mux16la1 is
begin
	process(MUX_IN,EN,SEL)
	begin
	if(EN='1') then
		MUX_OUT<=MUX_IN(to_integer(unsigned(SEL)));
	end if;
	--else "ZZZZZZZZ";
	end process;
end Mux1;