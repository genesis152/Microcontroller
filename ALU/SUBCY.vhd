entity Scazator_complet is
port(A,B,C_IN: in BIT_VECTOR(7 downto 0);
DIF: out BIT_VECTOR(7 downto 0);
CF,ZF: out BIT);
end;

architecture SUBCY of Scazator_complet is 
signal C_OUT: BIT_VECTOR(7 downto 0);
begin
   process
	variable J: INTEGER;
	variable D: BIT_VECTOR(7 downto 0);
	begin
		for J in 0 to 7 loop
            D(J) := A(J) xor B(J) xor C_IN(J);
            C_OUT(J) <= (not A(J) and B(J)) or (not A(J) and C_IN(J)) or (B(J) and C_IN(J)); 
        end loop;
	DIF <= D;
	if (not(C_OUT = "00000000")) then CF <= '1';
	end if;
	if(D = "00000000") then ZF <='1';
    end if;	
	wait;
	end process;
	
end;		   