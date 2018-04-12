library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.ALL;
use tip.all;

entity Mux16la1 is
 port(I: in VEC;
 	  EN: in BIT;
      SEL: in STD_LOGIC_VECTOR(3 downto 0);
      OUT_A: out STD_LOGIC_VECTOR(7 downto 0) );
end  Mux16la1;

architecture Mux1 of Mux16la1 is
begin
 ENABLE: process(SEL,EN)
 begin
 	if EN='1' then
 		OUT_A<=I(to_integer(unsigned(SEL)));
	else
		OUT_A<="00000000";
	end if;
end process;
end Mux1;
