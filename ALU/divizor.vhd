
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity divizor is
generic    (Divider : NATURAL);
port(CLK : in std_logic;
EN   : in std_logic;
RESET: in std_logic;
CLK_OUT: out std_logic);
end entity;          

architecture div of divizor is
begin
process(CLK)
variable OUT_CLK: std_logic_vector ( Divider-2 downto 0):=(others =>'0');
begin    
if(CLK='1' and CLK'EVENT) then
if(RESET = '1') then
OUT_CLK:=(others => '0');
elsif EN = '1' then
OUT_CLK:=OUT_CLK + '1';
end if;
end if;
CLK_OUT <= OUT_CLK(Divider-2);
end process;
end architecture;