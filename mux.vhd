package	tip is
	type VEC is array(15 downto 0) of BIT_VECTOR(7 downto 0);
end package;

use tip.all;
entity Mux16la1 is
 port(I: in VEC;
      SEL: in BIT_VECTOR(3 downto 0);
      OUT_A: out BIT_VECTOR(7 downto 0) );
end  Mux16la1;

architecture Mux1 of Mux16la1 is

begin
 
process	(SEL)
begin
 case SEL is
   when "0000" => OUT_A <= I(0);
   when "0001" => OUT_A <= I(1);
   when "0010" => OUT_A <= I(2);
   when "0011" => OUT_A <= I(3);
   when "0100" => OUT_A <= I(4);
   when "0101" => OUT_A <= I(5);
   when "0110" => OUT_A <= I(6);
   when "0111" => OUT_A <= I(7);
   when "1000" => OUT_A <= I(8);
   when "1001" => OUT_A <= I(9);
   when "1010" => OUT_A <= I(10);
   when "1011" => OUT_A <= I(11);
   when "1100" => OUT_A <= I(12);
   when "1101" => OUT_A <= I(13);
   when "1110" => OUT_A <= I(14);
   when "1111" => OUT_A <= I(15);
 end case;
end process;
end Mux1;