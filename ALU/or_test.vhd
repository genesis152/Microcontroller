entity test is
end test

architecture behaviour of test is
	component OR_8
		port(A,B:in bit_vector(7 downto 0);
		O:out bit_vector(7 downto 0);
		CARRY,ZERO: out bit);
	end component
	--in
	signal A: bit_vector(7 downto 0);
	signal B: bit_vector(7 downto 0);
	signal O: bit_vector(7 downto 0);
	SIGNAL CARRY: bit;
	SIGNAL ZERO: bit;
	begin
		uut: OR_8 PORT MAP(
		A=>A,
		B=>B,
		O=>O,
		CARRY=>CARRY,
		ZERO=>ZERO);
		ORR: process
		begin 
			A<="00000110";
			B<="00100100";
		wait for C;
			A<=transport "00011100" after 10 ns;
			B<=transport "11001110" after 10 ns;
		wait for C;
		end process;
	end;
		
		
	
