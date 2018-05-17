library IEEE;
use IEEE.std_logic_1164.all;

entity LOAD is
	port(EN: in STD_LOGIC;
	LOAD_IN	: in std_logic_vector(7 downto 0);
	LOAD_OUT: out std_logic_vector(7 downto 0);
	CF_I: in std_logic;
	ZF_I: in std_logic;
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
		if(CF_I = 'U') then
			CF<='0';
		else
			CF<=CF_I;
		end if;
		if(ZF_I = 'U') then
			ZF<='0';
		else
			ZF<=ZF_I; 
		end if;
	end process;
end architecture;