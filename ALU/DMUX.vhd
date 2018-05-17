--MERGE FARA BUGURI
--MERGE PREA BINE, PUNE ZZZZZZZZ peste tot

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.ALL;
use tip.all;

entity DMUX1la16_com is
 port( DMUX_IN: in STD_LOGIC_VECTOR(7 downto 0);
 	        EN: in STD_LOGIC;
           SEL: in STD_LOGIC_VECTOR(3 downto 0);
      DMUX_OUT: out M168:=(others =>"00000000"));
end  DMUX1la16_com;

architecture Dmux1 of Dmux1la16_com is 
 
--constant zeros: M168;

begin
	
	process(DMUX_IN,EN,SEL)
	variable DMUX_AUX:M168;
	begin
		--DMUX_AUX:=DMUX_OUT;
		if(EN='1') then
			DMUX_OUT(to_integer(unsigned(SEL)))<=DMUX_IN;
		end if;
		--DMUX_OUT<=DMUX_AUX;
	end process;
end Dmux1;