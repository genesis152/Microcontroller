library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Sumator_complet is
port(A,B: in std_logic_VECTOR(7 downto 0);
C_IN: in	 std_logic;
Y: out std_logic_VECTOR(7 downto 0);
CF,ZF: out std_logic);
end;

architecture ADDCY of Sumator_complet is
begin 	
	process(A,B)
	variable S: std_logic_VECTOR(7 downto 0); 
	
	variable C_I: std_logic;
	begin
	
		S(0) := (A(0) xor B(0)) xor C_IN;	-- se calc suma pe ultimul bit cu carry in
		for J in 1 to 7 loop
			
		    C_I := A(J-1) and B(J-1);	 --se foloseste C_I pt a retine carry-ul pt fiecare bit
			S(J) := (A(J) xor B(J)) xor C_I; --se aduna carry de la bitul anterior
           
        end loop;
  Y <= S; 
  
CF <= C_I;
if(S = "00000000") then ZF <='1'; 
	else ZF <= '0';
end if;
end process;
end;
