entity Semi_sumator is
port(A,B: in std_logic_vector(7 downto 0);
SUM: out std_logic_vector(7 downto 0);
CF,ZF:out std_logic);
end;

architecture ADD of Semi_sumator is	  
signal C_OUT: std_logic_vector(7 downto 0);
begin	
		process
	variable I: INTEGER;
	variable S: std_logic_vector(7 downto 0);
	begin
		for I in 0 to 7 loop
			S(I) := A(I) xor B(I);
			C_OUT(I) <= A(I) and B(I);
		end loop;	
 SUM <= S;
CF <= C_OUT(7);
if (S="00000000") then ZF <= '1';	
	end if;
wait;
end process;
end ADD;	




