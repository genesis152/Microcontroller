--nu intra in starea 00000, nu face nimic la primul tact
--in rest functioneaza ok

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.tip.all;

entity PROGRAM_COUNTER is
	port(jump,call,returnn: in STD_LOGIC;
	STACK_IN: in STD_LOGIC_VECTOR(7 downto 0);
	FLOW_IN : in STD_LOGIC_VECTOR(7 downto 0);
	COUNT   : out STD_LOGIC_VECTOR(7 downto 0);
	DELAY_C : out STD_LOGIC_VECTOR(7 downto 0);
	CLK     : in STD_LOGIC);
end entity;

architecture PROG of PROGRAM_COUNTER is

component num8
Port ( CLK,Reset,CU_D,PL: in std_logic;
cnt : 	out std_logic_vector(7 downto 0);
load_in: in std_logic_vector(7 downto 0));
end component;

signal LOAD: STD_LOGIC:=jump xor call xor returnn;
signal val : STD_LOGIC_VECTOR(7 downto 0):="00000000";
signal L_IN: STD_LOGIC_VECTOR(7 downto 0);

begin
	COUNT<=transport val;
	l1: num8 port map(CLK,'0','0',LOAD,val,L_IN);
	PROG_C: process
	variable AUX_LOAD: std_logic;
	variable delay   : std_logic_vector(7 downto 0);
	variable LOAD_IN : std_logic_vector(7 downto 0);
	begin
		delay:=val+'1';
		AUX_LOAD:=jump xor call xor returnn;
		if (AUX_LOAD='1') then
			if(returnn='1') then
				LOAD_IN:= STACK_IN;
			else
				LOAD_IN:= FLOW_IN;
			end if; 
		end if;
		L_IN<=LOAD_IN;
		LOAD<=AUX_LOAD;
		DELAY_C<=delay;
	wait on jump,call,returnn,CLK;
	end process;
end;
