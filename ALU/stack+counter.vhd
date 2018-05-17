library IEEE;
use IEEE.std_logic_1164.all;

entity stack_counter is
	port(
		push_led: out std_logic;
		pop_led	: out std_logic;
		CLK : in std_logic;
	jump,call,returnn:in std_logic;
	ANODE_ENABLE : out std_logic_vector(3 downto 0);
	SEGMENT_ENABLE: out std_logic_vector(6 downto 0));
end stack_counter;

architecture nop of stack_counter is

component PROGRAM_COUNTER 
	port(jump,call,returnn: in STD_LOGIC;
	STACK_IN: in STD_LOGIC_VECTOR(7 downto 0);
	FLOW_IN : in STD_LOGIC_VECTOR(7 downto 0);
	COUNT   : out STD_LOGIC_VECTOR(7 downto 0);
	DELAY_C : out STD_LOGIC_VECTOR(7 downto 0);
	CLK     : in STD_LOGIC);
end component;

component program_stack 
	port(STACK_IN: in std_logic_vector(7 downto 0);
	    STACK_OUT: out std_logic_vector(7 downto 0);
		EN_IN: in std_logic;
		EN_OUT:in std_logic;
		CLK : in std_logic);
end component;

signal STACK_LOAD,VAL:std_logic_vector(7 downto 0);
signal FLOW_LOAD: std_logic_vector(7 downto 0);
signal ADR: std_logic_vector(15 downto 0);
signal CLK_27 :std_logic;
signal push,pop : std_logic; 
signal D_VAL : std_logic_vector(7 downto 0);

begin
    push<=call and CLK_27;
    pop<=returnn and CLK_27;
	FLOW_LOAD<="00000000";
	div: entity work.divizor
        generic map(Divider => 2)
           port map(CLK => CLK,
                 EN  => '1',
                RESET=> '0',
                CLK_OUT => CLK_27); 
	l0: program_counter port map(jump,call,returnn,STACK_LOAD,FLOW_LOAD,VAL,D_VAL,CLK_27);
	l1: program_stack port map(D_VAL,STACK_LOAD,push,pop,CLK_27);
	ADR<="00000000" & VAL;
	l6: entity work.afisor
    	Port map( clock => CLK,
			reset => '0',  
			displayed_number=> ADR,
            Anode_Activate => ANODE_ENABLE,
            LED_out => SEGMENT_ENABLE);
	push_led<=push;
	pop_led<=pop;
end architecture;