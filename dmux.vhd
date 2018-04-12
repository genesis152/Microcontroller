use tip.all	 ;
entity DMUX1la16 is
 port( IN_REG: in BIT_VECTOR(7 DOWNTO 0);
      S: in BIT_VECTOR(3 downto 0);
      Y: out VEC);
end;

architecture Dmux1 of DMUX1la16 is
 
begin

process	(S) 
begin
 case S is
   when "0000" => Y(0) <= IN_REG;
   when "0001" => Y(1) <= IN_REG;
   when "0010" => Y(2) <= IN_REG;
   when "0011" => Y(3) <= IN_REG;
   when "0100" => Y(4) <= IN_REG;
   when "0101" => Y(5) <= IN_REG;
   when "0110" => Y(6) <= IN_REG;
   when "0111" => Y(7) <= IN_REG;
   when "1000" => Y(8) <= IN_REG;
   when "1001" => Y(9) <= IN_REG;
   when "1010" => Y(10) <= IN_REG;
   when "1011" => Y(11) <= IN_REG;
   when "1100" => Y(12) <= IN_REG;
   when "1101" => Y(13) <= IN_REG;
   when "1110" => Y(14) <= IN_REG;
   when "1111" => Y(15) <= IN_REG;

  end case;
end process;
end Dmux1;
   