LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use work.tip.all;

entity reg_test is
	port(
		BUTON : in std_logic_vector(3 downto 0);
		CLK1   : in std_logic;
		SWITCH: in std_logic;
		LED    : out std_logic_vector(7 downto 0);
		ANODE_ENABLE : out std_logic_vector(3 downto 0);
		SEGMENT_ENABLE: out std_logic_vector(6 downto 0));
end;

architecture  regi_test of reg_test is
--semnale
signal INPUT : std_logic_vector(7 downto 0);
signal S_IO_A,S_O_B : std_logic_vector(3 downto 0);
signal A,B  : std_logic_vector(7 downto 0);
signal C,D  : std_logic_vector(7 downto 0);
signal OUTPUT_AUX: std_logic_vector(15 downto 0):=X"0000";
signal data : M168;				
signal ENABLE: std_logic:='0';
signal CLK: std_logic:='0';
signal AUXI : std_logic:='1';
signal CLK_27:std_logic;
begin 
    l00: entity work.divizor
        generic map(Divider => 2)
        port map(CLK =>CLK1,
        EN  => '1',
        RESET => '0', 
        CLK_OUT => CLK_27);
	reg: entity work.REGISTERS_BLACK_BOX
		port map(CLK => CLK1,
			ENABLE => ENABLE,
			RESET => '0',
			REGISTER_UPDATE_INPUT => INPUT,
			FIRST_MUX_SEL => S_IO_A,
			SECOND_MUX_SEL  => S_O_B,
		 	 FIRST_REGISTER_OUT => A,
		 	 SECOND_REGISTER_OUT => B,
	   	  REGISTER_MATRIX_OUT => data);		
	
	STIMULI:process(BUTON,CLK1)
	begin
	--if(RISING_EDGE(CLK1)) then
		if(BUTON(0) = '1') then
			INPUT <= "00000001";
			S_IO_A<= "0001";
			S_O_B <= "0001";
			--CLK <= '0';	
			ENABLE<='1';
		elsif(BUTON(1)='1') then
			INPUT <= X"02";
			S_IO_A<= "0000";
			S_O_B <= "0011";
			--CLK <= '0';	
			ENABLE<='1';
		elsif(BUTON(2)='1') then
			INPUT <= X"03";
			S_IO_A<= X"1";
			S_O_B <= X"2";
			CLK <= '0';
			ENABLE<='1';
		elsif(BUTON(3)='1') then
			INPUT<= X"F0";
			S_IO_A<= X"0";
			S_O_B <= X"2";
			CLK <= '1';	
			ENABLE<='1';
--		elsif(BUTON(4)='1') then
--			INPUT <= "00011111";
--			S_IO_A<= "0010"	;
--			S_O_B <= "0001";
--			CLK <= '0';	 
--			ENABLE<='1';
--		elsif(BUTON(5)='1') then
--			S_IO_A<= "0010";
--			S_O_B <= "0010"; 
--			CLK <= '1';
--			ENABLE<='1';
		else
			S_IO_A<="0000";
			S_O_B <="0000";
			INPUT<= "00000000";
			ENABLE<='0';
		--end if;
	end if;
	end process;  
	C <= data(0);
	D <= data(1);
	process(C,D,SWITCH,CLK1)	
	begin
		
	
		if(SWITCH ='0' and C/="ZZZZZZZZ") then
			OUTPUT_AUX<= X"00" & C;
		elsif(SWITCH ='1' and D/="ZZZZZZZZ") then
			OUTPUT_AUX<= X"00" & D;
		else
			OUTPUT_AUX<=OUTPUT_AUX;
		end if;
		if(AUXI = '1') then
			OUTPUT_AUX<=X"0000";
			AUXI <= '0';   
				end if;
	end process;
	
	--OUTPUT_AUX<= "00000000" & A when (SWITCH = '0' and A/="ZZZZZZZZ") else "00000000" & B when (B/="ZZZZZZZZ" and SWITCH ='1')  else OUTPUT_AUX;

l16: entity work.afisor
    	Port map( clock => CLK1,
			reset => '0',  
			displayed_number=> OUTPUT_AUX,
            Anode_Activate => ANODE_ENABLE,
            LED_out => SEGMENT_ENABLE);
        LED <= data(1);

end;