LIBRARY IEEE;
use ieee.std_logic_1164.all;

entity rom_dcd_num is
	port(NUM_LD1 : in std_logic_vector(7 downto 0);
		 NUM_LD2 : in std_Logic_vector(7 downto 0);
jump,call,returnn: in std_logic;
			CLK  : in std_logic;
			RESET: in std_logic;
		COMMAND  : out std_logic_vector(3 downto 0);
			SEL	 : out std_logic_vector(3 downto 0);
			CONST: out std_logic_vector(7 downto 0));		
end;
		
architecture arh of rom_dcd_num is
component Mem_ROM 
	port(A_ROM:in std_logic_vector(7 downto 0);
		CS_ROM:in std_logic;  
		CLK	  :in std_logic;
		D_ROM:out std_logic_vector(15 downto 0));
end component;				 

component PROGRAM_COUNTER 
	port(jump,call,returnn: in STD_LOGIC;
	STACK_IN: in STD_LOGIC_VECTOR(7 downto 0);
	FLOW_IN : in STD_LOGIC_VECTOR(7 downto 0);
	COUNT   : out STD_LOGIC_VECTOR(7 downto 0);
	DELAY_C : out STD_LOGIC_VECTOR(7 downto 0);
	CLK     : in STD_LOGIC);
end component;	

component Clock_man 
	port(CLK : in STD_LOGIC;
		CLK2k: out STD_LOGIC;
	   CLK2K1: out STD_LOGIC);
end component;

component DECODER 
	port(
		--CLK   :in std_logic;
		RESET  :in std_logic;
		INSTR  :in std_logic_vector(15 downto 0);   
		COMAND :out std_logic_vector(3 downto 0);	--4 biti instructiunea
		CONST  :out std_logic_vector(7 downto 0);	--constant data
		OPERAND:out std_logic_vector(3 downto 0));	--4 biti pentru registru (exemplu LOAD sX,kk)
end component;

signal ADR : std_Logic_vector(7 downto 0);
signal DELAY_ADR : std_Logic_vector(7 downto 0);
signal CLK2,CLK21: std_logic;
signal INSTR1 : std_logic_vector(15 downto 0);

begin
	l0: Clock_man port map(CLK,CLK2,CLK21);
	l1: PROGRAM_COUNTER port map(jump,call,returnn, NUM_LD1,NUM_LD2,ADR,DELAY_ADR,CLK21); 
	l2: Mem_rom port map(ADR,'1',CLK2,INSTR1);
	l3: DECODER port map(RESET,INSTR1,COMMAND,CONST,SEL);

end architecture;
	