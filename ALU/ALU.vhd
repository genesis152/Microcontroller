library IEEE;
use IEEE.STD_LOGIC_1164.all;
use tip.all;

entity ALU is
	port(R1, R2, CT: in std_logic_vector(7 downto 0);
	SEL_I: in std_logic;
	SEL_O: in std_logic_vector(3 downto 0);
	OUT_ALU: out std_logic_vector(7 downto 0);
	ZeroF: out std_logic;
	CarryF: inout std_logic);
end;

architecture UAL of ALU is
 component Semi_sumator
port(A,B: in std_logic_vector(7 downto 0);
SUM: out std_logic_vector(7 downto 0);
CF,ZF:out std_logic);
end  component;

component Sumator_complet
port(A,B: in std_logic_VECTOR(7 downto 0);
C_IN: in std_logic;
Y: out std_logic_VECTOR(7 downto 0);
CF,ZF: out std_logic);
end component;		

component Scazator 
port(A,B: in STD_LOGIC_VECTOR(7 downto 0);
DIF: out STD_LOGIC_VECTOR(7 downto 0);
CF,ZF: out STD_LOGIC);
end component;

component Scazator_complet 
port(A,B: in std_logic_VECTOR(7 downto 0);
C_IN: in std_logic;
DIF: out std_logic_VECTOR(7 downto 0);
CF,ZF: out std_logic);
end component; 

component Poarta_SI
port(A,B: in std_logic_VECTOR(7 downto 0);
Y: out std_logic_VECTOR(7 downto 0);
CF,ZF: out std_logic);
end component; 

component XOR_8 
	port(A,B:in std_logic_vector(7 downto 0);
	X:out std_logic_vector(7 downto 0);
	CARRY,ZERO:out std_logic);
end component;	

component OR_8 
	port(A,B:in std_logic_vector(7 downto 0);
	O:out std_logic_vector(7 downto 0);
	CARRY,ZERO: out std_logic);
end component;


component SHIFT
	PORT(REG_IN:in std_logic_vector(7 downto 0); --input
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
 port (MUX_IN: in M16x8;
 	      EN: in BIT;
         SEL: in STD_LOGIC_VECTOR(3 downto 0);
     MUX_OUT: out STD_LOGIC_VECTOR(7 downto 0) );
end component;

signal Carry_F: std_logic_vector(7 downto 0);
signal Zero_F: std_logic_vector(7 downto 0);
signal C: std_logic; --pt carry in
signal SEL_S: std_logic_vector(3 downto 0);	--selectia pt shift
signal K: M16x8; 	 --matrice in care se salveaza rezultatele de la fiecare componenta	
signal SEL_M1: std_logic; -- sel pt mux2la1
signal R3: std_logic_vector(7 downto 0); --semnal pt a selecta daca se utilizeaza constanta sau o valoare dintr-un al doilea registru
--signal AND_OUT: std_logic_vector(7 downto 0);	
signal E: bit := '1';	 --enable pt mu16la1



begin 
   	l0: mux2la1	port map(R2, CT, SEL_M1, R3);
	
	l1: Poarta_SI port map(R1, R3, K(0), Carry_F(0), Zero_F(0)); 
	l2: OR_8 port map(R1, R3, K(1), Carry_F(1), Zero_F(1));
	l3: XOR_8 port map(R1,R3,K(2),Carry_F(2),Zero_F(2));
	l4: Semi_sumator port map(R1, R3,K(3), Carry_F(3),Zero_F(3));
	l5: Sumator_complet port map(R1, R3, C, K(4), Carry_F(4),Zero_F(4));
	l6: Scazator port map(R1, R3, K(5), Carry_F(5),Zero_F(5));
	l7: Scazator_complet port map(R1, R3, C, K(6), Carry_F(6),Zero_F(6));
	l8: SHIFT port map(R1,SEL_S,Carry_F(7), K(7), Zero_F(7));
	--process(SEL_O, K)	
	--begin
		--case SEL_O is
	--when "0001" => 	OUT_ALU <= K(0);
	--CarryF <= Carry_F(0);
	--ZeroF <= Zero_F(0);
	--when "0010" =>  OUT_ALU <= K(1);
	--CarryF <= Carry_F(1);
	--ZeroF <= Zero_F(1);
	--when "0011" =>  OUT_ALU <= K(2);
	--CarryF <= Carry_F(2);
	--ZeroF <= Zero_F(2);
	--when "0100" =>	OUT_ALU <= K(3);
	--CarryF <= Carry_F(3);
	--ZeroF <= Zero_F(3);
	--when "0101" => 	OUT_ALU <= K(4); 
	--CarryF <= Carry_F(4);
	--ZeroF <= Zero_F(4);
	--when "0110" => 	OUT_ALU <= K(5);
	--CarryF <= Carry_F(5);
	--ZeroF <= Zero_F(5);
	--when "0111" =>  OUT_ALU <= K(6);
	--CarryF <= Carry_F(6);
	--ZeroF <= Zero_F(6);
	--when "1101"	=>  OUT_ALU <= K(7);
	--CarryF <= Carry_F(7);
	--ZeroF <= Zero_F(7);
	--when others => OUT_ALU <="ZZZZZZZZ";
--end case; 
--end process;	
l9: mux16la1 port map(K, E, SEL_O, OUT_ALU);

	
	
end;
