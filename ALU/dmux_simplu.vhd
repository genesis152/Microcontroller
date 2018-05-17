--MERGE FARA BUGURI

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.ALL;
use tip.all;

entity DMUX is
 port( DMUX_IN: in STD_LOGIC_VECTOR(7 downto 0);
 	        EN: in BIT;
           SEL: in STD_LOGIC_VECTOR(3 downto 0);
      DMUX_OUT: out M168:=(others=>"ZZZZZZZZ"));
end  DMUX;

architecture Dmux1 of Dmux is
begin
process (SEL,EN,DMUX_IN) is
begin
	if(EN='1' and EN'LAST_VALUE='0') then
		DMUX_OUT(to_integer(unsigned(SEL)))<=DMUX_IN;	
	end if;
end process;
end Dmux1;