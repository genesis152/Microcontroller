library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.ALL;
use tip.all;

entity DMUX1la16 is
 port(IN_REG: in STD_LOGIC_VECTOR(7 downto 0);
 	  EN: in BIT;
      SEL: in STD_LOGIC_VECTOR(3 downto 0);
      Y: out VEC);
end  DMUX1la16;

architecture Dmux1 of Dmux1la16 is
constant zeros: VEC:= (others=> "00000000");
begin
 ENABLE: process(SEL,EN)
 begin
 	if EN='1' then
		Y<=zeros;
 		Y(to_integer(unsigned(SEL)))<=IN_REG;
	else		 	
		Y<=zeros;
	end if;
end process;
end Dmux1;
