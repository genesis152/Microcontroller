--nu intra in starea 00000, nu face nimic la primul tact
--in rest functioneaza ok

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.tip.all;


entity test11 is
	port(CLK  : in std_logic;
	    SWITCH_IN: in std_logic_vector(3 downto 0);
		BUTTON1   : in std_logic;
		BUTTON2   : in std_logic;
		ANODE_ENABLE : out std_logic_vector(3 downto 0);
		SEGMENT_ENABLE: out std_logic_vector(6 downto 0)
		);
end test11;


architecture PROG of test11 is

component num8
Port ( CLK,Reset,CU_D,PL: in std_logic;
cnt : 	out std_logic_vector(7 downto 0);
load_in: in std_logic_vector(7 downto 0));
end component;

signal val : STD_LOGIC_VECTOR(7 downto 0):="00000000";
signal val_d: std_logic_vector(7 downto 0);
signal CLK_DEB: std_logic;	 
signal val_aux: std_logic_vector(15 downto 0);
signal CLK_27: std_logic;
signal LOAD_VALUE: std_logic_vector(7 downto 0);
begin 
    LOAD_VALUE <= "0000" & SWITCH_IN;
	l01: entity work.PROGRAM_COUNTER
	port map(jump => BUTTON1,
	call => BUTTON2,
	returnn => '0',
	STACK_IN => LOAD_VALUE,
	FLOW_IN => LOAD_VALUE,
	COUNT   => val,
	DELAY_C => val_d,
	CLK     => CLK_27);

--	l00: entity work.Debouncing_Button_VHDL  
--		generic map(
--			pulse => true,
--			active_low => true,
--			delay => 50000
--			)
--		port map(
--			clk => CLK,
--			reset => '1', --Active Low
--			input => BUTTON,
--			debounce => CLK_DEB
--			);
	val_aux<= "00000000" & val;
		l6: entity work.afisor
    	Port map( clock => CLK,
			reset => '0',  
			displayed_number=> val_aux,
            Anode_Activate => ANODE_ENABLE,
            LED_out => SEGMENT_ENABLE);
        div: entity work.divizor
               generic map(Divider => 27)
               port map(CLK => CLK,
                        EN  => '1',
                       RESET=> '0',
              CLK_OUT => CLK_27);   
end;
