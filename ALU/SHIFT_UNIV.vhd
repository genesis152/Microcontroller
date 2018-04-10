entity SHIFT is
	PORT(REG_IN:in bit_vector(7 downto 0); --input
	SEL:in bit_vector(3 downto 0);	--selectia de shift (SEE XAPP213.PDF)
	CARRY: inout bit;
	REG_OUT: out bit_vector(7 downto 0);
	ZERO: out bit);
end SHIFT;

architecture SHIFT_F of SHIFT is
begin
	process(SEL)
		variable SH: bit_vector(7 downto 0); 	
		variable AUX: bit;
		begin
		case SEL is	 
			--SHIFT LEFT
			when "0110" | "0111" =>  --SL0,SL1
				AUX:=REG_IN(7);
				SH:=REG_IN sll 1;
				SH(0):= SEL(0);
			when "0100" => --SLX
				AUX:=REG_IN(7);
				SH:=REG_IN sll 1;
				SH(0):= CARRY;
			when "0000" => --SLA 
				AUX:=REG_IN(7);
				SH:=REG_IN sll 1;
				SH(0):= SH(1);
			when "0010" => --RL
				AUX:=REG_IN(7);
				SH:=REG_IN sll 1;
				SH(0):= AUX; 
			--SHIFT RIGHT
			when "1110" | "1111" => --SR0,SR1
				AUX:=REG_IN(0);
				SH:=REG_IN srl 1;
				SH(7):= SEL(0);
			when "1010" => --SRX
				AUX:=REG_IN(0);
				SH:=REG_IN srl 1;
				SH(7):= SH(6);
			when "1000" => --SRA
				AUX:=REG_IN(0);
				SH:=REG_IN srl 1;
				SH(7):= CARRY;
			when "1100" => --RR
				AUX:=REG_IN(0);
				SH:=REG_IN srl 1;
				SH(7):= AUX;
			when others	 =>
				AUX:= '0';
			   	SH:= "00000000";
		end case;
		REG_OUT<=SH;
		CARRY<=AUX;
	end process; 
end SHIFT_F;
				
			
			
		