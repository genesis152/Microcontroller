entity Sumator_complet is
port(A,B,C_IN: in BIT_VECTOR(7 downto 0);
Y: out BIT_VECTOR(7 downto 0);
CF,ZF: out BIT);
end;

architecture ADDCY of Sumator_complet is
 signal I,C_OUT: BIT_VECTOR(7 downto 0);
begin 	
	process
	variable J: INTEGER;
	variable S: BIT_VECTOR(7 downto 0);
	begin
		for J in 0 to 7 loop
			I(J) <= A(J) xor B(J);
			S(J) := I(J) xor C_IN(J);
            C_OUT(J) <= (A(J) and B(J)) or (I(J) and C_IN(J));
        end loop;
  Y <= S;
if (not(C_OUT = "00000000")) then CF <= '1';
	end if;
if(S = "00000000") then ZF <='1';
end if;
wait;
end process;
end;