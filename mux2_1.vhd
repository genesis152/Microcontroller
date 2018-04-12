entity Mux2la1 is
	port(I0,I1: in BIT_VECTOR(7 downto 0);
	SEL: in BIT;
	OUT_1: out BIT_VECTOR(7 downto 0));
end;

architecture Mux2 of Mux2la1 is
begin
	process(SEL)
	begin
	case SEL is
		when '0' => OUT_1 <= I0;
		when '1' => OUT_1 <= I1;
	end case;
	end process;
end;