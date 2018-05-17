library IEEE;
use IEEE.std_logic_1164.all;

entity Clock_man is
	port(CLK : in STD_LOGIC;
		CLK2k: out STD_LOGIC;
	   CLK2K1: out STD_LOGIC);
end Clock_man;

architecture arh of Clock_man is
signal int:integer;
begin
	process (CLK)
	variable I:integer range 0 to 10:=0;
	variable C2: std_logic:='0';
	variable C21: std_logic:='0';
	variable C2_E,C21_E: bit:='0';
	begin
		if(CLK='1' and CLK'EVENT) then
			if(I=10) then
				I:=3;
			else
				I:=I+1;
			end if;--i=10
			
			if(C2_E='1') then
					if(C2 = '0') then
						C2 := '1';
					else
						C2 := '0';
					end if;--CLK2k
			end if;
			
			if(C21_E='1') then
				if(C21='0') then
					C21 :='1';
				else
					C21 :='0';
				end if;	 --CLK2k1
			end if;
			
			if(I = 1) then
				C21:='1';
				C21_E:='1';
			end if;
			if(I = 2) then
				C2 := '1';
				C2_E:='1';
			end if;
			
			
			--end if;--i mod 2
		end if;--clk
		CLK2k<=C2;
		CLK2k1<=C21;
		int<=I;
	end process;
end architecture;