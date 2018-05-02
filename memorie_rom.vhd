--MERGE CU CITIRE DIN FISIER

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use tip.all;
use std.textio.all;

entity Mem_ROM is
	port(A_ROM:in std_logic_vector(7 downto 0);
		CS_ROM:in std_logic;  
		CLK	  :in std_logic;
		D_ROM:out std_logic_vector(15 downto 0));
end;
		  
architecture Memorie_ROM of Mem_ROM is
type Memo is array (0 to 255) of std_logic_vector(15 downto 0);
signal Mem: Memo;
signal END_READ: std_logic:='0'; 
begin		   
	citire: process
		file INFILE : text is in "Memorie_rom.txt";
		variable TEXT_LINE: line;
		variable I: integer:=-1;
		variable TEXT_VAR: bit_vector(15 downto 0);
		begin
			while not endfile(INFILE) loop
				I:=I+1;
				readline( INFILE, TEXT_LINE);
				read(TEXT_LINE, TEXT_VAR);
				Mem(I)<=to_stdlogicvector(TEXT_VAR);
			end loop;
		END_READ<='1';
		wait;
	end process citire;		
	mem_rom   : process (CS_ROM,CLK)
	begin
		if(END_READ = '1' and CS_ROM = '1' and CLK'EVENT and CLK = '1') then
			D_ROM<= Mem(to_integer(unsigned(A_ROM)));
		end if;								 
	end process mem_rom;
end architecture;
	