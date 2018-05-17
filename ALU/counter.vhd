								  ----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2018 09:15:51 PM
-- Design Name: 
-- Module Name: big_clock - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
	generic( TCOUNT: natural:=10 ;
		N_BITS: natural:= 4);
	port(EN : in std_logic;
		CLK : in std_logic;
		TC : out std_logic:='0';
		OUTPUT : out std_logic_vector(N_BITS -1 downto 0));
end counter;

architecture Behavioral of counter is
begin

process(CLK)
variable COUNT_OUT : std_logic_vector(N_BITS-1 downto 0):=(others=>'0');
variable AUX_TC: std_logic :='0';
begin		   				 
	if(EN='1') then
		if(COUNT_OUT=TCOUNT - 1) then
			AUX_TC:='1';
		else
			AUX_TC:='0';
		end if;
		if(CLK'EVENT and CLK='1') then
			if(AUX_TC='1') then
				COUNT_OUT:=(OTHERS=>'0');
			else
				COUNT_OUT:=COUNT_OUT + '1';
			end if;
		end if;
	end if;
TC<=AUX_TC;
OUTPUT<= COUNT_OUT;	
end process;
end architecture;  
