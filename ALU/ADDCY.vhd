entity Sumator_complet is
port(A,B,C_IN: in std_logic_vector(7 downto 0);
Y: out std_logic_vector(7 downto 0);
CF,ZF: out std_logic);
end;

architecture ADDCY of Sumator_complet is
 signal I,C_OUT: std_logic_vector(7 downto 0);
begin 	
	process
	variable J: INTEGER;
	variable S: std_logic_vector(7 downto 0);
	begin
		for J in 0 to 7 loop
			I(J) <= A(J) xor B(J);
			S(J) := I(J) xor C_IN(J);
            C_OUT(J) <= (A(J) and B(J)) or (I(J) and C_IN(J));
        end loop;
  Y <= S;
CF <= C_OUT(7);
if(S = "00000000") then ZF <='1';
end if;
wait;
end process;
end;
