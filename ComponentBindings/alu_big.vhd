library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use tip.all;

entity ALU is
	port(CLK  : in STD_LOGIC;
	COMMAND_IN:in std_logic_vector(3 downto 0);
	SELECT_IN:in std_logic_vector(3 downto 0);
	CONST_IN :in std_logic_vector(7 downto 0);
	OUT_ALU: out std_logic_vector(7 downto 0);
	Zero: inout std_logic:='0';
	Carry: inout std_logic:='0');
end;

architecture UAL of ALU is
 component Semi_sumator
port(EN: in std_logic;
A,B: in std_logic_vector(7 downto 0);
SUM: out std_logic_vector(7 downto 0);
CF,ZF:out std_logic);
end  component;

component Sumator_complet
port(EN: in std_logic;
A,B: in std_logic_VECTOR(7 downto 0);
SUM: out std_logic_VECTOR(7 downto 0);
CF: inout std_logic;
ZF: out std_logic);
end component;		

component Scazator 
port(EN: in std_logic;
A,B: in STD_LOGIC_VECTOR(7 downto 0);
DIF: out STD_LOGIC_VECTOR(7 downto 0);
CF,ZF: out STD_LOGIC);
end component;

component Scazator_complet 
port(EN: in std_logic;
A,B: in std_logic_VECTOR(7 downto 0);
DIF: out std_logic_VECTOR(7 downto 0);
CF:inout std_logic;
ZF: out std_logic);
end component; 

component Poarta_SI
port(EN: in std_logic;
A,B: in std_logic_VECTOR(7 downto 0);
Y: out std_logic_VECTOR(7 downto 0);
CF,ZF: out std_logic);
end component; 

component XOR_8 
	port(EN: in std_logic;
	A,B:in std_logic_vector(7 downto 0);
	X:out std_logic_vector(7 downto 0);
	CARRY,ZERO:out std_logic);
end component;	

component OR_8 
	port(EN: in std_logic;
	A,B:in std_logic_vector(7 downto 0);
	O:out std_logic_vector(7 downto 0);
	CARRY,ZERO: out std_logic);
end component;


component SHIFT
	PORT(EN: in std_logic;
	REG_IN:in std_logic_vector(7 downto 0); --input
	SEL:in std_logic_vector(3 downto 0);	--selectia de shift (SEE XAPP213.PDF)
	CARRY: inout std_logic;
	REG_OUT: out std_logic_vector(7 downto 0);
	ZERO: out std_logic);
end  component;  


 component Mux2la1 
	port (I0,I1: in std_logic_vector(7 downto 0);
	SEL2_1: in std_logic;
	O: out std_logic_vector(7 downto 0)); 
end component; 	

component Mux16la1
 port (
 --EN: in std_logic;
 MUX_IN: in M168;
 	      EN: in STD_LOGIC;
         SEL: in STD_LOGIC_VECTOR(3 downto 0);
     MUX_OUT: out STD_LOGIC_VECTOR(7 downto 0) );
end component;	 

component REGISTRII 
	port(CLK_R : in STD_LOGIC;
		CLK_W : in STD_LOGIC;
		IN_REG: in STD_LOGIC_VECTOR(7 downto 0);
		S_IO_A : in STD_LOGIC_VECTOR(3 downto 0);
		S_O_B  : in STD_LOGIC_VECTOR(3 downto 0);
		 OUT_A : out STD_LOGIC_VECTOR(7 downto 0);
		 OUT_B : out STD_LOGIC_VECTOR(7 downto 0));
end component;	 

component LOAD 
	port(EN: in std_logic;
	LOAD_IN	: in std_logic_vector(7 downto 0);
	LOAD_OUT: out std_logic_vector(7 downto 0);
	CF,ZF: out std_logic);
end component;

signal INPUT_REG: std_logic_vector(7 downto 0):="00000000";
signal sX,sY : std_logic_vector(3 downto 0);
signal MUX_SELECT: std_logic_vector(3 downto 0);
signal shift_command: std_logic_vector(3 downto 0);
signal REG_A,REG_B: std_logic_vector(7 downto 0):="00000000";
signal A,B: std_logic_vector(7 downto 0):="00000000";
signal REZULTATE : M168;
signal EN : std_logic;
signal EN_VEC : std_logic_vector(15 downto 0):=(others => '0');
signal WRITE_REG : std_logic;
begin
	process(COMMAND_IN,SELECT_IN,CONST_IN,CLK)
	variable EN_AUX: std_logic_vector(15 downto 0):="0000000000000000";
	variable EN_GENERAL: std_logic;
	begin
		--EN_AUX:=(others => '0');
		case COMMAND_IN is
			when "0001" | "0010" | "0011" | "0100" | "0101" | "0110" | "0111" | "0000" =>
				MUX_SELECT<= COMMAND_IN;
				sX <= SELECT_IN;
				sY <= "ZZZZ";
				if(CLK = '1' and CLK'EVENT) then
					EN_GENERAL := '0';
				end if;
				if(CLK = '0' and CLK'EVENT) then
					EN_GENERAL:= '1';
				end if;
				EN_AUX(to_integer(unsigned(COMMAND_IN))):=not EN_GENERAL;
			when "1100"	=>
				MUX_SELECT<=CONST_IN(3 downto 0);
				sX <= SELECT_IN;
				sY <= CONST_IN(7 downto 4);
				if(CLK = '1' and CLK'EVENT) then
					EN_GENERAL := '0';
				end if;
				if(CLK = '0' and CLK'EVENT) then
					EN_GENERAL:= '1';
				end if;
				EN_AUX(to_integer(unsigned(CONST_IN))):=not EN_GENERAL;
			when "1101" =>
				MUX_SELECT<=COMMAND_IN;
				sX<= SELECT_IN;
				shift_command<= CONST_IN(3 downto 0);	
				if(CLK = '1' and CLK'EVENT) then
					EN_GENERAL := '0';
				end if;
				if(CLK = '0' and CLK'EVENT) then
					EN_GENERAL:= '1';
				end if;
				EN_AUX(to_integer(unsigned(COMMAND_IN))):= EN_GENERAL;
			when others => NULL;
		end case;
		if(EN_GENERAL = '1') then
			WRITE_REG<='0';
		end if;
		if(EN_GENERAL = '0') then
			WRITE_REG<='1';
		end if;
		EN_VEC<=EN_AUX;
		EN<= EN_GENERAL;
	end process;
	ATR: B<=REG_B when COMMAND_IN = "1100" else
		 	CONST_IN;
	 REG   : REGISTRII        port map(EN,WRITE_REG,INPUT_REG,sX,sY,REG_A,REG_B);
	LOADD  : LOAD             port map(EN_VEC(0),B,REZULTATE(0),Carry,Zero); 			 --0000
	ANDD   : Poarta_SI        port map(EN_VEC(1),REG_A,B,REZULTATE(1),Carry,Zero);		 --0001
	ORR    : OR_8             port map(EN_VEC(2),REG_A,B,REZULTATE(2),Carry,Zero);		 --0010
	XORR   : XOR_8            port map(EN_VEC(3),REG_A,B,REZULTATE(3),Carry,Zero);		 --0011
	ADD    : Semi_sumator     port map(EN_VEC(4),REG_A,B,REZULTATE(4),Carry,Zero); 		 --0100
	ADDCY  : Sumator_complet  port map(EN_VEC(5),REG_A,B,REZULTATE(5),Carry,Zero);		 --0101
	SUB    : Scazator         port map(EN_VEC(6),REG_A,B,REZULTATE(6),Carry,Zero);		 --0110
	SUBCY  : Scazator_complet port map(EN_VEC(7),REG_A,B,REZULTATE(7),Carry,Zero); 		 --0111
	SHIFT1 : SHIFT            port map(EN_VEC(13),REG_A,shift_command,Carry,REZULTATE(13),Zero);--1101
	MUX_OUT: MUX16la1         port map(REZULTATE,'1',MUX_SELECT,INPUT_REG);
	REZULTATE(12 downto 8) <= (others =>"ZZZZZZZZ");
	REZULTATE(15 downto 14) <= (others =>"ZZZZZZZZ");
	OUT_ALU<= INPUT_REG;

end;