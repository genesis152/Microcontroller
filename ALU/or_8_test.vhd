library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use tip.all;

entity DA is
end DA;

architecture TEST of DA is
	component DECODER
	port(CLK   :in std_logic;
		RESET  :in std_logic;
		INSTR  :in std_logic_vector(15 downto 0);   
		COMAND :out std_logic_vector(3 downto 0);	--2 biti groupa + 4 biti instructiunea
		CONST  :out std_logic_vector(7 downto 0);	--constant data
		OPERAND:out std_logic_vector(3 downto 0));	--4 biti pentru registru (exemplu LOAD sX,kk)
	end component;
	
	--in
	
	signal	CLK   : std_logic;
	signal	RESET  : std_logic;
	signal	INSTR  : std_logic_vector(15 downto 0);   
	signal	COMAND : std_logic_vector(3 downto 0);	--2 biti groupa + 4 biti instructiunea
	signal	CONST  : std_logic_vector(7 downto 0);	--constant data
	signal	OPERAND: std_logic_vector(3 downto 0);
	
	BEGIN
		uut: DECODER PORT MAP(
		CLK,RESET,INSTR,COMAND,CONST,OPERAND);
		TESTARE:process
		begin
			INSTR<= "0001101110000110";
			INSTR<= "1000111110010110" after 20 ns;
			INSTR<= "1000111110000000" after 40 ns;
			wait;
		end process;
	end;
			