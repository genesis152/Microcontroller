library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Semi_sumator is
port(A,B: in std_logic_vector(7 downto 0);
SUM: out std_logic_vector(7 downto 0);
CF,ZF:out std_logic);
end;

architecture ADD of Semi_sumator is	  
begin	
		process	(A,B)
	variable S: std_logic_vector(7 downto 0);  
	variable C :std_logic;
	begin 
		C := A(0) and B(0);	 	-- pe bitul cel mai nesemnificativ nu intra carry	
		S(0) :=	A(0) xor B(0);
		for I in 1 to 7 loop
			S(I) := (A(I) xor B(I)) xor C;     -- C e un carry interior pt toti biti inafara de cel mai nesemnificativ
			C := A(I) and B(I);
	
		end loop;	
 SUM <= S;
CF <= C; -- Carry Flagul ia ultima valoare a lui C
if (S="00000000") then ZF <= '1';
	else ZF <= '0';
	end if;

end process;
end ADD;


