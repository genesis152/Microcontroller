library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.ALL;

package tip is
	type VEC is array(15 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
	type M256x16 is array(7 downto 0) of STD_LOGIC_vector(15 downto 0);
	type M168 is array(15 downto 0) of STD_LOGIC_vector(7 downto 0);
	type M816 is array(7 downto 0) of STD_LOGIC_VECTOR(15 downto 0);
end tip;
