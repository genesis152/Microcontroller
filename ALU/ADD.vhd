library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Semi_sumator is
port(EN: in STD_LOGIC;
A,B: in std_logic_vector(7 downto 0);
SUM: out std_logic_vector(7 downto 0);
CF,ZF:out std_logic);
end;

architecture ADD of Semi_sumator is	  
begin	
		process	(A,B,EN)
	variable S: std_logic_vector(7 downto 0);  
	variable C :std_logic_vector(7 downto 0);
	begin
		if(EN='1') then
			C(0) := A(0) and B(0);	 	-- pe bitul cel mai nesemnificativ nu intra carry	
			S(0) :=	A(0) xor B(0);
			for I in 1 to 7 loop
				S(I) := (A(I) xor B(I)) xor C(I-1);     -- C e un carry interior pt toti biti inafara de cel mai nesemnificativ
				C(I) := (A(I) and B(I)) or (B(I) and C(I-1)) or (C(I-1) and A(I)) ;
			end loop;
		else
			S:="ZZZZZZZZ";
			C:="ZZZZZZZZ";
		end if;			
SUM <= S;
CF <= C(7); -- Carry Flagul ia ultima valoare a lui C
if (S="00000000") then ZF <= '1';
	elsif EN='1' then ZF <= '0';
	else ZF<='Z';
end if;

end process;
end ADD;

