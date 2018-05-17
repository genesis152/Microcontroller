library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.my_package.all;

entity content_shifter is
	port( 		CLK : in std_logic;
	              EN: in std_logic;
 SEGMENT_DISPLAY_MAT: inout Matrix;
	  SEGMENT_IN    : in std_logic_vector(6 downto 0));
end content_shifter;

architecture beh of content_shifter is 	 
begin
	
	process(CLK)
	variable AUX_MATRIX: Matrix:=SEGMENT_DISPLAY_MAT;
	variable I:integer:=0;
	begin
			--if(CLK='1' and CLK'EVENT) then
			--for I in 1 to 7	loop
				--AUX_MATRIX(7-I+1):=AUX_MATRIX(7-I);
			--end loop;
			--AUX_MATRIX:=(others=>"0000000");
			--AUX_MATRIX(I):=SEGMENT_IN;
			--if(I = 7) then
--			     I:=0;
--			else
--			     I:=I+1;
--			end if;
--						
			--end if;
			SEGMENT_DISPLAY_MAT<=AUX_MATRIX;
		end process;
			
end beh;
		
		