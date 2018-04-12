entity Scazator_complet is
port(A,B,C_IN: in std_logic_vector(7 downto 0);
DIF: out std_logic_vector(7 downto 0);
CF,ZF: out std_logic);
end;

architecture SUBCY of Scazator_complet is 
signal C_OUT: std_logic_vector(7 downto 0);
begin
   process
	variable J: INTEGER;
	variable D: std_logic_vector(7 downto 0);
	begin
		for J in 0 to 7 loop
            D(J) := A(J) xor B(J) xor C_IN(J);
            C_OUT(J) <= (not A(J) and B(J)) or (not A(J) and C_IN(J)) or (B(J) and C_IN(J)); 
        end loop;
	DIF <= D;
	CF <= C_OUT(7);
	if(D = "00000000") then ZF <='1';
    end if;	
	wait;
	end process;
	
end;		   
