library IEEE;
use IEEE.std_logic_1164.all;

entity LOAD is
	port(EN: in STD_LOGIC;
	LOAD_IN	: in std_logic_vector(7 downto 0);
	LOAD_OUT: out std_logic_vector(7 downto 0);
	CF: out std_logic;
	ZF: out std_logic);
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
	end process;
	CF<='0';
	ZF<='0';
end architecture;