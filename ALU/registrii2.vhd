--registrii incercarea nr 2
--sub forma de RAM
--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
--use ieee.math_real.all;
--use work.tip.all;
--use std.textio.all;
--
--entity Registrii2 is
--	port(READ_WRITE : in std_logic;
--			ENABLE  : in std_logic;
--			RESET   : in std_logic;
--	   	INPUT_REG   : in std_logic_vector(7 downto 0);
--		  S_IO_A    : in std_logic_vector(3 downto 0);
--		  S_O_B     : in std_logic_vector(3 downto 0);
--		OUT_A		: out std_logic_vector(7 downto 0);
--		OUT_B       : out std_logic_vector(7 downto 0);
--		REG_DATA : out M168); 
--end Registrii2;
--
--		  
--architecture BEH of Registrii2 is
--begin		   
--	mem_ram   : process (ENABLE,READ_WRITE)
--	variable DATA_AUX : M168:=(others=> X"00");
--	variable A,B      : std_logic_vector(7 downto 0);
--	begin
--		if(RESET ='1') then
--			DATA_AUX := (others=>"00000000");
--		else
--			if(ENABLE = '1') then
--				if(READ_WRITE = '1') then --0 = read_from_reg
--					A:=DATA_AUX(to_integer(unsigned(S_IO_A)));
--					if(S_O_B /= "ZZZZ") then
--						B:=DATA_AUX(to_integer(unsigned(S_O_B)));
--					else
--						B:="ZZZZZZZZ";
--					end if;	--S_O_B
--				elsif(READ_WRITE = '0') then -- 1 = write_out 
--					DATA_AUX(to_integer(unsigned(S_IO_A))):= INPUT_REG;	
--				end if;	--READ_WRITE
--			elsif(ENABLE = '0') then
--				B:="ZZZZZZZZ";
--				A:="ZZZZZZZZ";
--			end if; --ENABLE
--		end if;--RESET
--		OUT_A<=A;
--		OUT_B<=B;
--		REG_DATA<=DATA_AUX;
--	end process mem_ram;
--end architecture;
--	
library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;
use work.tip.all;

entity REGISTERS_BLACK_BOX is
	port(CLK: in STD_LOGIC;
		ENABLE: in STD_LOGIC;
		RESET: in STD_LOGIC;
		
		
		
		REGISTER_UPDATE_INPUT: in STD_LOGIC_VECTOR(7 downto 0);
		
		FIRST_MUX_SEL: in  std_logic_vector(3 downto 0);
		SECOND_MUX_SEL: in  std_logic_vector(3 downto 0);
		
		FIRST_REGISTER_OUT: out STD_LOGIC_VECTOR(7 downto 0);
		SECOND_REGISTER_OUT: out STD_LOGIC_VECTOR(7 downto 0);
		
		REGISTER_MATRIX_OUT: out M168
	);
end entity REGISTERS_BLACK_BOX;

architecture REGISTERS_BLACK_BOX_ARCHITECTURE of REGISTERS_BLACK_BOX is

signal REGISTERS_MATRIX: M168:= 
("00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000");													

begin		 			
	
	MAIN_TAG:process(RESET, CLK, FIRST_MUX_SEL, SECOND_MUX_SEL, ENABLE)
	variable FIRST: INTEGER := 0;
	variable SECOND: INTEGER := 0;
	variable FIRST_VALUE: STD_LOGIC_VECTOR(7 downto 0) := "00000000";
	variable SECOND_VALUE: STD_LOGIC_VECTOR(7 downto 0) := "00000000";
	variable UPDATE_VALUE: STD_LOGIC_VECTOR(7 downto 0) := "00000000";											  								   
	begin		
		if(ENABLE = '1') then 
				FIRST_REGISTER_OUT <= REGISTERS_MATRIX(to_integer(unsigned(FIRST_MUX_SEL)));		   
				SECOND_REGISTER_OUT <= REGISTERS_MATRIX(to_integer(unsigned(SECOND_MUX_SEL)));		 
			
			if(RESET = '1') then
				REGISTERS_MATRIX <= (	"00000000",
										"00000000",
										"00000000",
										"00000000",
										"00000000",
										"00000000",
										"00000000",
										"00000000",
										"00000000",
										"00000000",
										"00000000",
										"00000000",
										"00000000",
										"00000000",
										"00000000",
										"00000000");
			else
				if(rising_edge(CLK)) then
					FIRST := to_integer(unsigned(FIRST_MUX_SEL));
					UPDATE_VALUE := REGISTER_UPDATE_INPUT;
					if(FIRST >= 0) then			   			
						REGISTERS_MATRIX(FIRST) <= UPDATE_VALUE;  
					end if;
				end if;	  
			end if;
		end if;
	end process MAIN_TAG;
	
	
	
	REGISTER_MATRIX_OUT <= REGISTERS_MATRIX;
end architecture REGISTERS_BLACK_BOX_ARCHITECTURE;