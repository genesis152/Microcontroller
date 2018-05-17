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
use work.my_package.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity big_clock is
   port(
	--RESET: in std_logic;
        CLK : in std_logic;
        OUTPUT : out std_logic_vector(6 downto 0);
	SEG_SELECT : out std_logic_vector(7 downto 0));
        --DISPLAY0 : out std_logic_vector(6 downto 0));
        --DISPLAY1 : out std_logic_vector(6 downto 0));
end big_clock;

architecture Behavioral of big_clock is	 

	signal TC_COUNT1: std_logic;  
	signal TC_COUNT2: std_logic;
	signal COUNT_1S: std_logic_vector(3 downto 0):=(others=>'0');
	signal COUNT_10S: std_logic_vector(3 downto 0):=(others=>'0');
	signal DISPLAY0 : std_logic_vector(6 downto 0):=(others=>'0');
	signal DISPLAY1 : std_logic_vector(6 downto 0):=(others=>'0');
	signal DISPLAY_MATRIX: Matrix:=("0111111","0000110","1011011","1001111","1100110","1101101","1111100","0000111");
	signal CLK_27,CLK_16 : std_logic;
	signal OUTPUT_AUX: std_logic_vector(6 downto 0):=(others=>'0');
	signal SEG_AUX   : std_logic_vector(7 downto 0):=(others=>'0');
	signal N_CLK_27 : std_logic;
	
begin
	
	SEG_SELECT <= not SEG_AUX;
	OUTPUT <= not OUTPUT_AUX;
	
	DIVIDER0: entity work.divizor
				generic map(Divider => 6) --27
				port map(CLK => CLK,
						EN   => '1',
						RESET=> '0',
					  CLK_OUT=> CLK_27);
	
	DIVIDER1: entity work.divizor
				generic map(Divider => 2) --16
				port map(CLK => CLK_27,
						EN   => '1',
						RESET=> '0',
					  CLK_OUT=> CLK_16);
		
	
--	CLK_1S: entity work.counter 
--			generic map( TCOUNT=> 10 ,
--						N_BITS=> 4)
--			port map(EN => '1',
--				CLK => CLK_27,
--				TC => TC_COUNT1,
--				OUTPUT => COUNT_1S);  
--				
--	CLK_10S: entity work.counter
--			generic map( TCOUNT=> 10 ,
--						N_BITS=> 4)
--			port map(EN => TC_COUNT1,
--				CLK => CLK_27,
--				TC => TC_COUNT2,
--				OUTPUT => COUNT_10S);  
--				
--	BCD_CONV1: entity work.bcd
--    			Port map ( BCD_IN  => COUNT_1S,
--          				LETTER_IN  => 'G',
--         			 	SEG_OUT    => DISPLAY0);
--						  
	--BCD_CONV2: entity work.bcd 					  
--    			Port map ( BCD_IN  => COUNT_10S,
--          				LETTER_IN  => 'G',
--         			 	SEG_OUT    => DISPLAY1);
						  
	SHIFT    : entity work.shifter
			port map(CLK => CLK,		  --clk16
	             	 EN => '1',
 	SEGMENT_DISPLAY_MAT => DISPLAY_MATRIX,
	  	SEGMENT_ENABLE	=> SEG_AUX,
     	SEGMENT_OUTPUT 	=> OUTPUT_AUX);

--	DISPLAY_MATRIX(0) <= DISPLAY0;
--	DISPLAY_MATRIX(1) <= DISPLAY1;
--	
	--N_CLK_27 <= not CLK_27; 
--	CONTENT_SHIFT: entity content_shifter
--			port map(CLK => N_CLK_27,		  --clk27
--	              	   EN => '1',
-- 	  SEGMENT_DISPLAY_MAT => DISPLAY_MATRIX,
--	  SEGMENT_DISPLAY_OUT => DISPLAY_MATRIX,
--	       	SEGMENT_IN    => DISPLAY0);             
	
end architecture;
