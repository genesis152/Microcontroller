--MERGE

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use tip.all;

--ENTITATE REGISTRII     
entity REGISTRII is 
	port(CLK_R : in STD_LOGIC;
		CLK_W  : in STD_LOGIC;
		IN_REG : in STD_LOGIC_VECTOR(7 downto 0);
		S_IO_A : in STD_LOGIC_VECTOR(3 downto 0);
		S_O_B  : in STD_LOGIC_VECTOR(3 downto 0);
		 OUT_A : out STD_LOGIC_VECTOR(7 downto 0);
		 OUT_B : out STD_LOGIC_VECTOR(7 downto 0));
end entity REGISTRII;							 

architecture REG of REGISTRII is

component Mux16la1
 port( MUX_IN: in M168;
 	       EN: in STD_LOGIC;
          SEL: in STD_LOGIC_VECTOR(3 downto 0);
      MUX_OUT: out STD_LOGIC_VECTOR(7 downto 0) );
end component;	  

component Dmux1la16_com
 port(DMUX_IN: in STD_LOGIC_VECTOR(7 downto 0);
 	  	   EN: in STD_LOGIC;
          SEL: in STD_LOGIC_VECTOR(3 downto 0);
     DMUX_OUT: out M168);
end component;

signal data: M168:=(others => "00000000");
signal EN1,EN2: std_logic;

begin
	cond: EN2 <= CLK_R when S_O_B /="ZZZZ"
		else '0';
	cond2: EN1 <= CLK_R when S_IO_A /="ZZZZ"
		else '0';
	l0: Dmux1la16_com PORT MAP(IN_REG,CLK_W,S_IO_A,data);					--deocamdata enable 1
	l1: MUX16la1 PORT MAP(data,EN1,S_IO_A,OUT_A); 					--deocamdata enable 1
	l12:MUX16la1 PORT MAP(data,EN2,S_O_B,OUT_B); 					--deocamdata enable 1
end;	