library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

package my_package is
type Matrix is array(0 to 7) of std_logic_vector(6 downto 0);
end package;	  

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.my_package.all;

entity shifter is
	port( 		CLK : in std_logic;
	              EN: in std_logic;
 SEGMENT_DISPLAY_MAT: in	Matrix;
	  SEGMENT_ENABLE: out std_logic_vector(7 downto 0);
     SEGMENT_OUTPUT : out std_logic_vector(6 downto 0));
end shifter;

architecture beh of shifter is
	 
begin
	process(CLK)
	variable SEG_EN: std_logic_vector(7 downto 0):="00000001";
	variable I: integer:= 0;
	begin
		if(CLK = '1' and CLK'EVENT) then
			SEG_EN := SEG_EN(6 downto 0)& SEG_EN(7);
			case SEG_EN is
				when "00000001" => I:=0;
				when "00000010" => I:=1;
				when "00000100" => I:=2;
				when "00001000" => I:=3;
				when "00010000" => I:=4;
				when "00100000" => I:=5;
				when "01000000" => I:=6;
				when "10000000" => I:=7;
				when others=> NULL;
			end case;
		end if;
	SEGMENT_OUTPUT<= SEGMENT_DISPLAY_MAT(I);
	SEGMENT_ENABLE<= SEG_EN;
	end process;
end beh;
		
		