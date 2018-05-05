--MERGE

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use tip.all;

--ENTITATE REGISTRII     
entity REGISTRII is 
	port(IN_REG: in STD_LOGIC_VECTOR(7 downto 0);
		S_IO_A : in STD_LOGIC_VECTOR(3 downto 0);
		S_O_B  : in STD_LOGIC_VECTOR(3 downto 0);
		 OUT_A : out STD_LOGIC_VECTOR(7 downto 0);
		 OUT_B : out STD_LOGIC_VECTOR(7 downto 0));
end entity REGISTRII;							 

architecture REG of REGISTRII is

component Mux16la1
 port( MUX_IN: in M168;
 	       EN: in BIT;
          SEL: in STD_LOGIC_VECTOR(3 downto 0);
      MUX_OUT: out STD_LOGIC_VECTOR(7 downto 0) );
end component;	  

component Dmux1la16_com
 port(DMUX_IN: in STD_LOGIC_VECTOR(7 downto 0);
 	  	   EN: in BIT;
          SEL: in STD_LOGIC_VECTOR(3 downto 0);
     DMUX_OUT: out M168);
end component;

signal data: M168;

begin
	l0: Dmux1la16_com PORT MAP(IN_REG,'1',S_IO_A,data);					--deocamdata enable 1
	l1: MUX16la1 PORT MAP(data,'1',S_IO_A,OUT_A); 					--deocamdata enable 1
	l12:MUX16la1 PORT MAP(data,'1',S_O_B,OUT_B); 					--deocamdata enable 1
end;	