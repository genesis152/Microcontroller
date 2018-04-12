library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.ALL;

package my_package is
	type M256x16 is array(7 downto 0) of std_logic_vector(15 downto 0);
	type M16x8 is array(15 downto 0) of bit_vector(7 downto 0);
end my_package;