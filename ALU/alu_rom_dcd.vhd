library IEEE;
use IEEE.std_logic_1164.all;
use work.tip.all;

entity alu_rom_dcd is
	port(CLK : in std_logic;
		ANODE_ENABLE : out std_logic_vector(3 downto 0);
	SEGMENT_ENABLE: out std_logic_vector(6 downto 0);
	       LED    : out std_logic_vector(7 downto 0));
end alu_rom_dcd;

architecture beh of alu_rom_dcd is
--signal			  
signal INSTR : std_logic_vector(15 downto 0);
signal COMM,SEL: std_logic_vector(3 downto 0);
signal CONST: std_logic_vector(7 downto 0);
signal OUT_ALU: std_logic_vector(7 downto 0);  
signal ZF,CF  : std_logic:='0';
signal DATA   : M168;  
signal COUNT  : std_logic_vector(7 downto 0);
signal CLK_27,CLK21,CLK2 : std_logic;
signal output :std_logic_vector(15 downto 0);

begin  
	
	
	
	div: entity work.divizor
        generic map(Divider => 27)
           port map(CLK => CLK,
                 EN  => '1',
                RESET=> '0',
                CLK_OUT => CLK_27);  
	
	l0: entity work.Clock_man port map(CLK_27,CLK2,CLK21);
				
	decod: entity work.DECODERX 
			port map(
				RESET => '0',
				INSTR => INSTR,   
				COMAND => COMM,	--4 biti instructiunea
				CONST  => CONST, --constant data
				OPERAND=> SEL );	--4 biti pentru registru (exemplu LOAD sX,kk)
	
	alu:    entity work.ALU 
			port map(CLK  => CLK21,
				COMMAND_IN=> COMM,
				SELECT_IN => SEL,
				CONST_IN  => CONST,
				OUT_ALU   => OUT_ALU,
				Zero      => ZF,
				Carry     => CF,
				REG_DATA  => DATA);	 
				
	mem:    entity work.Mem_ROM
			port map(A_ROM=> COUNT,
				CS_ROM => '1',  
				CLK	   => CLK2,
				D_ROM  => INSTR);

    counter: entity work.PROGRAM_COUNTER 
		port map(jump=>'0',
				call=>'0',
				returnn => '0',
				STACK_IN => "00000000",
				FLOW_IN  => "00000000",
				COUNT    => COUNT,
				DELAY_C  => open,
				CLK      => CLK21);
    output<="00000000" & OUT_ALU; 
    LED<= count;
	l6:       entity work.afisor
           Port map( clock => CLK,
                  reset => '0',  
                  displayed_number=> output,
                  Anode_Activate => ANODE_ENABLE,
                  LED_out => SEGMENT_ENABLE);
end;