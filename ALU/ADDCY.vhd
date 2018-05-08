library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Sumator_complet is
port(EN: in STD_LOGIC;
A,B: in std_logic_VECTOR(7 downto 0);
SUM: out std_logic_VECTOR(7 downto 0);
CF:inout std_logic;
ZF: out std_logic);
end;

architecture ADDCY of Sumator_complet is
begin 	
	process(A,B,CF,EN)
	variable S: std_logic_VECTOR(7 downto 0); 
	
	variable C: std_logic_vector(7 downto 0);
	begin
		if(EN='1') then
		    	 					-- pe bitul cel mai nesemnificativ nu intra carry	
			S(0) :=	(A(0) xor B(0)) xor CF;
			C(0) := (A(0) and B(0)) or (B(0) and CF) or (CF and A(0));
			for I in 1 to 7 loop
			S(I) := (A(I) xor B(I)) xor C(I-1);     -- C e un carry interior pt toti biti inafara de cel mai nesemnificativ
			C(I) := (A(I) and B(I)) or (B(I) and C(I-1)) or (C(I-1) and A(I)) ;
			end loop;
		else
			S:="ZZZZZZZZ";
			C:="ZZZZZZZZ";
       	end if;
  SUM <= S; 
CF <= C(7);
if(S = "00000000") then ZF <= '1'; 
	  elsif EN='1' then ZF <= '0';
	                    ZF <= 'Z';
end if;
end process;
end;