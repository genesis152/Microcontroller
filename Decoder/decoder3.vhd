--MERGE

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.tip.all;

entity DECODER is
	port(
		--CLK   :in std_logic;
		RESET  :in std_logic;
		INSTR  :in std_logic_vector(15 downto 0);   
		COMAND :out std_logic_vector(3 downto 0):=(others=>'Z');	--4 biti instructiunea
		CONST  :out std_logic_vector(7 downto 0):=(others=>'Z');	--constant data
		OPERAND:out std_logic_vector(3 downto 0):=(others=>'Z'));	--4 biti pentru registru (exemplu LOAD sX,kk)
end DECODER;

architecture DECOD3 of DECODER is

begin
	process(INSTR) 
		
		variable sX: std_logic_vector(3 downto 0):=(others=>'Z');
		variable k : std_logic_vector(7 downto 0):=(others=>'Z');
		variable com:std_logic_vector(3 downto 0):=(others=>'Z');
	begin	
	--if(CLK'EVENT and CLK='1') then
	case INSTR(15 downto 12)  is  
		when "1000" | "1001" | "1010" | "1011" | "1110" | "1111" | "1101" | "0000" | "0001" | "0010" | "0011" | "0100" | "0101" | "0110" | "0111" | "1100"  => --instr sx,k & sx,sy & shi
			sX := INSTR(11 downto 8);
			k  := INSTR(7 downto 0);
			com:= INSTR(15 downto 12);
		when others => null;
	end case;
	if( RESET = '1' ) then
		sX:=(others=>'0');
		k:=(others=>'0');
		com:=(others=>'0');
	end if;
	OPERAND <= sX;
	CONST   <= k;
	COMAND  <= com;
	--end if;
	end process;
end architecture DECOD3;
