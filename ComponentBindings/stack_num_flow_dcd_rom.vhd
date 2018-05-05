--god bless

library IEEE;
use IEEE.std_logic_1164.all;

entity stack_num_flow_dcd_rom is
	port(CLK1 : in STD_LOGIC;
		RESET1: in STD_LOGIC;
		ZERO1 : in STD_LOGIC;
		CARRY1: in STD_LOGIC);
end stack_num_flow_dcd_rom;
		
architecture NOPENOPE of stack_num_flow_dcd_rom is

component program_stack 
	port(STACK_IN: in std_logic_vector(7 downto 0);
	    STACK_OUT: out std_logic_vector(7 downto 0);
		EN_IN: in std_logic;
		EN_OUT:in std_logic;
		CLK   :in std_logic);
end component;

component PROGRAM_COUNTER
	port(jump,call,returnn: in STD_LOGIC;
	STACK_IN: in STD_LOGIC_VECTOR(7 downto 0);
	FLOW_IN : in STD_LOGIC_VECTOR(7 downto 0);
	COUNT   : out STD_LOGIC_VECTOR(7 downto 0);
	DELAY_C : out STD_LOGIC_VECTOR(7 downto 0);
	CLK     : in STD_LOGIC);
end component;

component Flow   
	port(FLOW_K : in std_logic_vector(7 downto 0);
			 COM: in std_logic_vector(3 downto 0);
			COND: in std_logic_vector(3 downto 0);
		   CARRY: in std_logic;
		   ZERO : in std_logic;
	COUNTER_LOAD: out std_logic_vector(7 downto 0);
	STACK_POP	: out STD_LOGIC:='0';
	STACK_PUSH  : out STD_LOGIC:='0'; 
	jump,call,returnn: out STD_LOGIC;
			CLK : in STD_LOGIC);
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

component Mem_ROM 
	port(A_ROM:in std_logic_vector(7 downto 0);
		CS_ROM:in std_logic;  
		CLK	  :in std_logic;
		D_ROM:out std_logic_vector(15 downto 0));
end component;

component Clock_man 
	port(CLK : in STD_LOGIC;
		CLK2k: out STD_LOGIC;
	   CLK2K1: out STD_LOGIC);
end component;

signal CLK2,CLK21: std_logic;
signal ADR : std_logic_vector (7 downto 0);
signal INSTRUCT : std_logic_vector (15 downto 0);
signal D_COMAND,D_OPERAND : std_logic_vector (3 downto 0);
signal D_CONST :  std_logic_vector (7 downto 0);
signal FLOW_t_COUNTER : std_logic_vector( 7 downto 0);
signal Pop1,Push1,jump1,returnn1,call1: std_logic;
signal Stack_t_num: std_logic_vector(7 downto 0);
signal val,delayed_val: std_logic_vector(7 downto 0);

begin  
	l0: Clock_man port map(CLK1,CLK2,CLK21);
	l1: Mem_ROM port map(val,'1',CLK2,INSTRUCT);
	l2: DECODER port map(RESET1,INSTRUCT,D_COMAND,D_CONST,D_OPERAND);   
					--FLOW_K,      COM,   COND,    CARRY,  ZERO,COUNTER_LOAD,STACK_POP,STACK_PUSH,jump,call,returnn,CLK
	l3: Flow port map (D_CONST,D_COMAND,D_OPERAND,CARRY1,ZERO1,FLOW_t_COUNTER,pop1,push1,jump1,call1,returnn1,CLK21);
							--STACK_IN,STACK_OUT,EN_IN,EN_OUT,CLK
	l4: Program_stack port map(delayed_val,Stack_t_num,push1,pop1,CLK21);
										--jump,call,returnn,STACK_IN,FLOW_IN,COUNT,DELAY_C,CLK
	l5: Program_counter port map(jump1,call1,returnn1,Stack_t_num,Flow_t_counter,val,delayed_val,CLK21); 

end architecture;						   
