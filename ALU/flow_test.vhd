library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.tip.all;

entity flow_test is
	port(
	CLK1:in std_logic;
	BUTON1	: in std_logic;
	BUTON2	: in std_logic;
	BUTON3	: in std_logic;
	led     : out std_logic_vector(3 downto 0);
	--ANODE_ENABLE : out std_logic_vector(3 downto 0);
	--SEGMENT_ENABLE: out std_logic_vector(6 downto 0);
	call,jump,returnn: out std_logic;
	pop,push : out std_logic);
end flow_test;

architecture nope of flow_test is

component Flow 	  
	port(FLOW_K : in std_logic_vector(7 downto 0);
			 COM: in std_logic_vector(3 downto 0);
			COND: in std_logic_vector(3 downto 0);
		   CARRY: in std_logic;
		   
		   ZERO : in std_logic;
	COUNTER_LOAD: out std_logic_vector(7 downto 0);
	STACK_POP	: out STD_LOGIC;
	STACK_PUSH  : out STD_LOGIC;
	jump,call,returnn:out std_logic;
			CLK : in STD_LOGIC);
end component;

--component program_stack 
--	port(STACK_IN: in std_logic_vector(7 downto 0);
--	    STACK_OUT: out std_logic_vector(7 downto 0);
--		EN_IN: in std_logic;
--		EN_OUT:in std_logic;
--		CLK   :in std_logic);
--end component;
--
--component PROGRAM_COUNTER 
--	port(jump,call,returnn: in STD_LOGIC;
--	STACK_IN: in STD_LOGIC_VECTOR(7 downto 0);
--	FLOW_IN : in STD_LOGIC_VECTOR(7 downto 0);
--	COUNT   : out STD_LOGIC_VECTOR(7 downto 0);
--	DELAY_C : out STD_LOGIC_VECTOR(7 downto 0);
--	CLK     : in STD_LOGIC);
--end component;

signal pop1,push1: std_logic;
signal flow_load1: std_logic_vector(7 downto 0);
signal stack_load1: std_logic_vector(7 downto 0);
signal jump1,call1,returnn1:std_logic;
signal adress1 : std_logic_vector(7 downto 0);
signal delayed_count: std_logic_vector(7 downto 0);
signal CLK_27: std_logic;
signal FLOW_CONST : std_logic_vector(7 downto 0):=(others => '0');
signal FLOW_COMMAND : std_logic_vector(3 downto 0):=(others => '0');
signal FLOW_SELECT : std_logic_vector(3 downto 0):=(others => '0');
signal ADR_OUTPUT : std_logic_vector(15 downto 0);
begin	
	
	stimul: process(BUTON1,BUTON2,BUTON3,CLK_27)
	variable leds: std_logic_vector(3 downto 0);
	begin
		--if(RISING_EDGE(CLK_27)) then
            if(BUTON1 = '1') then
                FLOW_CONST<="00000000";
                FLOW_COMMAND<="1000";
                FLOW_SELECT<="1111";
                leds := "0010";
            elsif(BUTON2 = '1') then
                FLOW_CONST<="00000100";
                FLOW_COMMAND<="1000";
                FLOW_SELECT<="1111";
                leds := "0100";
            elsif(BUTON3 = '1') then
                FLOW_CONST<="00000000";
                FLOW_COMMAND<="1000";
                FLOW_SELECT<="1100";
                leds := "1000";
            else
                FLOW_CONST<="00000000";
                FLOW_COMMAND<="0000";
                FLOW_SELECT<="0000";
                leds := "0001";
          --  end if; 
            end if;
		led <= leds;
	end process;
    div: entity work.divizor
        generic map(Divider => 2)
           port map(CLK => CLK1,
                 EN  => '1',
                RESET=> '0',
                CLK_OUT => CLK_27); 
	--                FLOW_K         ,COM,       COND,  CARRY,ZERO,COUNTER_LOAD,STACK_POP,STACK_PUSH,jump,call,returnn
	l0: Flow port map(FLOW_CONST,FLOW_COMMAND,FLOW_SELECT,'0','0',flow_load1,pop1,push1,jump1,call1,returnn1,CLK_27);
	                           --jump  ,call,returnn, STACK_IN,   FLOW_IN,  COUNT,  CLK
--	l1: PROGRAM_COUNTER port map(jump1,call1,returnn1,flow_load1,flow_load1,adress1,delayed_count,CLK_27);
						--   STACK_IN, STACK_OUT,EN_IN,EN_OUT
--	l2: program_stack port map(delayed_count,stack_load1,push1,pop1,CLK_27);
	call<= call1;
	jump<= jump1;
	returnn <= returnn1;
	pop<= pop1;
	push<=push1;
	
	--ADR_OUTPUT <="00000000" & adress1;
	
--	l6: entity work.afisor
--    	Port map( clock => CLK1,
--			reset => '0',  
--			displayed_number=> ADR_OUTPUT,
--            Anode_Activate => ANODE_ENABLE,
--            LED_out => SEGMENT_ENABLE);
			
end architecture;