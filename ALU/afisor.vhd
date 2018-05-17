library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
entity afisor is
    Port ( clock : in STD_LOGIC;
	reset : in STD_LOGIC;  
	displayed_number:in STD_LOGIC_VECTOR (15 downto 0);
           Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);
           LED_out : out STD_LOGIC_VECTOR (6 downto 0));
end entity;

architecture Behavioral of afisor is
--signal one_second_counter: STD_LOGIC_VECTOR (27 downto 0);
--signal one_second_enable: std_logic;
signal LED_BCD: STD_LOGIC_VECTOR (3 downto 0);
signal refresh_counter: STD_LOGIC_VECTOR (19 downto 0):=(others => '0');
-- creating 10.5ms refresh period
signal LED_activating_counter: std_logic_vector(19 downto 18);

begin
process(LED_BCD)
begin
    case LED_BCD is
    when "0000" => LED_out <= "0000001"; -- "0"     
    when "0001" => LED_out <= "1001111"; -- "1" 
    when "0010" => LED_out <= "0010010"; -- "2" 
    when "0011" => LED_out <= "0000110"; -- "3" 
    when "0100" => LED_out <= "1001100"; -- "4" 
    when "0101" => LED_out <= "0100100"; -- "5" 
    when "0110" => LED_out <= "0100000"; -- "6" 
    when "0111" => LED_out <= "0001111"; -- "7" 
    when "1000" => LED_out <= "0000000"; -- "8"     
    when "1001" => LED_out <= "0000100"; -- "9" 
	when others => LED_out <="1111110" ;
    end case;
end process;

process(clock,reset)
begin 
    if(reset='1') then
        refresh_counter <= (others => '0');
    elsif(rising_edge(clock)) then
        refresh_counter <= refresh_counter + 1;
    end if;
end process; 

 LED_activating_counter <= refresh_counter(1 downto 0);
process(LED_activating_counter)
begin	   
    case LED_activating_counter is
    when "00" =>
        Anode_Activate <= "0111"; 
        LED_BCD <= displayed_number(15 downto 12);
    when "01" =>
        Anode_Activate <= "1011"; 
        LED_BCD <= displayed_number(11 downto 8);
    when "10" =>
        Anode_Activate <= "1101"; 
        LED_BCD <= displayed_number(7 downto 4);
    when "11" =>
        Anode_Activate <= "1110"; 
        LED_BCD <= displayed_number(3 downto 0);
		when others=> Anode_Activate <="1111" ;
    end case; 
end process;
end Behavioral;