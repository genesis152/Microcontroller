library IEEE;
use IEEE.std_logic_1164.all;

entity LOAD is
	port(EN: in STD_LOGIC;
	LOAD_IN	: in std_logic_vector(7 downto 0);
	LOAD_OUT: out std_logic_vector(7 downto 0);
	CF: inout std_logic:='0';
	ZF: inout std_logic:='0');
end LOAD;

architecture arh of LOAD is
begin
	process(EN,LOAD_IN)
	begin
		if(EN='1') then
			LOAD_OUT<= LOAD_IN;
		else
			LOAD_OUT<= "ZZZZZZZZ";
		end if;
		CF<=CF;
		ZF<=ZF;
	end process;
end architecture;