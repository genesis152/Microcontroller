entity Semi_sumator is
port(A,B: in BIT_VECTOR(7 downto 0);
SUM: out BIT_VECTOR(7 downto 0);
CF,ZF:out BIT);
end;

architecture ADD of Semi_sumator is	  
signal C_OUT: BIT_VECTOR(7 downto 0);
begin	
		process
	variable I: INTEGER;
	variable S: BIT_VECTOR(7 downto 0);
	begin
		for I in 0 to 7 loop
			S(I) := A(I) xor B(I);
			C_OUT(I) <= A(I) and B(I);
		end loop;	
 SUM <= S;
if (not(C_OUT = "00000000")) then CF <= '1';
	end if;
if (S="00000000") then ZF <= '1';	
	end if;
wait;
end process;
end ADD;	




