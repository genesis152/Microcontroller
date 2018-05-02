--MERGE FARA BUGURI

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.ALL;
use tip.all;

entity DMUX1la16 is
 port( DMUX_IN: in STD_LOGIC_VECTOR(7 downto 0);
 	        EN: in BIT;
           SEL: in STD_LOGIC_VECTOR(3 downto 0);
      DMUX_OUT: out M168);
end  DMUX1la16;

architecture Dmux1 of Dmux1la16 is
constant zeros: M168:= (others=> "ZZZZZZZZ");

begin
	
 BLOCK_DMUX: block
 begin	  
 	dmux: for I in 0 to 15 generate
		 DMUX_OUT(I) <= DMUX_IN when (I=to_integer(unsigned(SEL)) and EN='1')
		 else "ZZZZZZZZ";
	end generate dmux;
 end block BLOCK_DMUX;
end Dmux1;
