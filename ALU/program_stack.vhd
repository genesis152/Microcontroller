--MERGE BINE


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.tip.all;

entity program_stack is
	port(STACK_IN: in std_logic_vector(7 downto 0);
	    STACK_OUT: out std_logic_vector(7 downto 0);
		EN_IN: in std_logic;
		EN_OUT:in std_logic;
		CLK   :in std_logic);
end program_stack;

architecture prog_stack of program_stack is	
	
	begin
		IN_OUT: process(EN_IN,EN_OUT,CLK)
		variable INTRARE,IESIRE:std_logic_vector(7 downto 0);
		variable CARRY: M168;
		begin
			--IESIRE:=CARRY(0);
			if(EN_IN = '1' and EN_OUT='0') then --push
				if(RISING_EDGE(CLK)) then
					for i in 15 downto 1 loop
					   CARRY(i):=CARRY(i-1);
					end loop;
					--wait for 1 ns;
					--if(CLK='1' and CLK'EVENT) then
					INTRARE:=STACK_IN;
					CARRY(0):=INTRARE;
					IESIRE:=CARRY(0);
					--report "event";
					end if;
					
				elsif(EN_OUT='1' and EN_IN='0') then --pop
					IESIRE:=CARRY(0);
					--wait for 1 ns;
					for i in 1 to 15 loop
						CARRY(i-1):=CARRY(i);
					end loop;						 
				end if;
				--if(EN_OUT='0') then
					--IESIRE:="ZZZZZZZZ";
				--end if;
			STACK_OUT<=IESIRE;
		end process;
	end architecture;
				

	