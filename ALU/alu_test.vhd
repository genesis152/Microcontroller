LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use work.tip.all;

entity alu_test is
	port(BUTON :in std_logic_vector(3 downto 0);
	   SWITCH  :in std_logic;
		CLK : in std_logic;
		LED : out std_logic_vector(7 downto 0);
		ANODE_ENABLE : out std_logic_vector(3 downto 0);
		SEGMENT_ENABLE: out std_logic_vector(6 downto 0)
		--ZERO 	: out STD_LOGIC;
		--CARRY	: out STD_LOGIC
		);
end alu_test;

architecture test of alu_test is
--semnale
signal CLK_27 : std_logic;
signal COMMAND: std_logic_vector(3 downto 0);
signal SEL    : std_logic_vector(3 downto 0);
signal CONST  : std_logic_vector(7 downto 0);
signal OUTPUT : std_logic_vector(7 downto 0);
signal ZF,CF  : std_logic:='0';
signal OUTPUT_AUX: std_logic_vector(15 downto 0):=(others =>'0');
signal A,B : std_logic_vector(7 downto 0);
signal MATRIX : M168;
begin
	STIMULI:process(BUTON,CLK)
	begin
	--if(RISING_EDGE(CLK)) then
		if(BUTON(0) = '1') then
			COMMAND<="0000";
			SEL    <="0000";
			CONST  <="00000000";
		elsif(BUTON(1)='1') then
			COMMAND<="0000";
			SEL    <="0000";
			CONST  <="00000001";
		elsif(BUTON(2)='1') then
			COMMAND<="0000";
			SEL    <="0000";
			CONST  <="00000010";
		elsif(BUTON(3)='1') then
			COMMAND<="0100";
            SEL    <="0000";
            CONST  <="00000110";
		--elsif(BUTON(4)='1') then
			
		else 
		            COMMAND<="0000";
                    SEL    <="0100";
                    CONST  <="00000000";
		end if;
	--end if;
	end process;
	div: entity work.divizor
        generic map(Divider => 29)
           port map(CLK => CLK,
                 EN  => '1',
                RESET=> '0',
                CLK_OUT => CLK_27); 
	l6:entity work.ALU 
		port map(CLK => CLK_27,
		COMMAND_IN=> COMMAND,
		SELECT_IN=> SEL,
		CONST_IN=> CONST,
		OUT_ALU => OUTPUT,
		Zero => ZF,
		Carry=> CF,
		REG_DATA=> MATRIX);
		--A_OUT => A,
		--B_OUT => B); 
	LED <= MATRIX(0);	
	OUTPUT_AUX<="00000000" & OUTPUT when OUTPUT /= "ZZZZZZZZ" else OUTPUT_AUX;
	--OUTPUT_AUX<= "00000000" & A when SWITCH = '0' else "00000000" & B;
	l16: entity work.afisor
    	Port map( clock => CLK,
			reset => '0',  
			displayed_number=> OUTPUT_AUX,
            Anode_Activate => ANODE_ENABLE,
            LED_out => SEGMENT_ENABLE);		
end;
	