library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use tip.all;

entity alu_reg_decod is
	port( INT_R: in std_logic_vector(7 downto 0);
	O: out std_logic_vector(7 downto 0));
end;

architecture a_r_d of alu_reg_decod is

component REGISTRII
	port(IN_REG: in STD_LOGIC_VECTOR(7 downto 0);
		S_IO_A : in STD_LOGIC_VECTOR(3 downto 0);
		S_O_B  : in STD_LOGIC_VECTOR(3 downto 0);
		 OUT_A : out STD_LOGIC_VECTOR(7 downto 0);
		 OUT_B : out STD_LOGIC_VECTOR(7 downto 0));
end component;	

component ALU 
	port(R1, R2, CT: in std_logic_vector(7 downto 0);
	OUT_ALU: out std_logic_vector(7 downto 0);
	ZeroF: out std_logic;
	CarryF: inout std_logic);
end component;	  

component DECODER 
	port(
		RESET  :in std_logic;
		INSTR  :in std_logic_vector(15 downto 0);   
		COMAND :out std_logic_vector(3 downto 0);	--2 biti groupa + 4 biti instructiunea
		CONST  :out std_logic_vector(7 downto 0);	--constant data
		OPERAND:out std_logic_vector(3 downto 0));	--4 biti pentru registru (exemplu LOAD sX,kk)
end component;	
		
signal S: std_logic_vector(3 downto 0):="0000";		--semnal pt sle S_O_B
signal F,COMD: std_logic_vector(3 downto 0);  --F pt S_IO_A (OPERAND de la decoder) si COMD pt COMAND
signal I: std_logic_vector(15 downto 0); --pt INSTR
signal T1: std_logic_vector(7 downto 0);  --T1 si T2 pt iesirile de la registru
signal T2: std_logic_vector(7 downto 0);
signal C: std_logic_vector(7 downto 0);	 --C este constanta
signal CF, ZF, R: std_logic; 	--R reset de la decoder



begin  
	l0: DECODER port map (R, I, COMD, C, F);	 
	
	process(I) 
	begin
	if(I(15 downto 12) = "1100") then S <= I(7 downto 4); 
	end if;
	end process;
	
	l1: REGISTRII port map(INT_R, F, S, T1, T2);
	l2: ALU port map(T1, T1, C,  O, CF, ZF);
	
end;