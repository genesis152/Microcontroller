--OR
entity OR_8 is
	port(A,B:in bit_vector(7 downto 0);
	O:out bit_vector(7 downto 0);
	CARRY,ZERO: out bit);
end OR_8;

architecture OR_F of OR_8 is
signal ORR: bit_vector(7 downto 0);
begin
	ORR <= A or B;
	CARRY<= '0';
	ZERO <= not (ORR(0) or ORR(1) or ORR(2) or ORR(3) or ORR(4) or ORR(5) or ORR(6) or ORR(7));    
	O<= ORR;
end OR_F;