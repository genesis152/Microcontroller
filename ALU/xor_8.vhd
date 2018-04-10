--XOR
entity XOR_8 is
	port(A,B:in bit_vector(7 downto 0);
	X:out bit_vector(7 downto 0);
	ZERO,CARRY:out bit);
end XOR_8;

architecture XOR_F of XOR_8 is
signal XO: bit_vector(7 downto 0);
begin
	XO <= A xor B;
	ZERO <= not (XO(0) or XO(1) or XO(2) or XO(3) or XO(4) or XO(5) or XO(6) or XO(7)); 
	CARRY <='0';														 
	X<=XO;
end XOR_F;