library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity SHIFT is
	PORT(EN: in STD_LOGIC;
	REG_IN:in std_logic_vector(7 downto 0); --input
	SEL:in std_logic_vector(3 downto 0);	--selectia de shift (SEE XAPP213.PDF)
	CARRY: inout std_logic;
	REG_OUT: out std_logic_vector(7 downto 0);
	ZERO: out std_logic);
end SHIFT;

architecture SHIFT_F of SHIFT is
begin
	process(SEL,EN,REG_IN,CARRY)
		variable SH: std_logic_vector(7 downto 0); 	
		variable AUX: std_logic;
		begin
		if(EN='1') then
			case SEL is	 
				--SHIFT LEFT
				when "0110" | "0111" =>  --SL0,SL1
					AUX:=REG_IN(7);
					SH:=REG_IN(6 downto 0)& '0';
					SH(0):= SEL(0);
				when "0100" => --SLX
					AUX:=REG_IN(7);
					SH:=REG_IN (6 downto 0) & '0';
					SH(0):= CARRY;
				when "0000" => --SLA 
					AUX:=REG_IN(7);
					SH:=REG_IN (6 downto 0) & '0';
					SH(0):= SH(1);
				when "0010" => --RL
					AUX:=REG_IN(7);
					SH:=REG_IN (6 downto 0) & '0';
					SH(0):= AUX; 
			--SHIFT RIGHT
				when "1110" | "1111" => --SR0,SR1
					AUX:=REG_IN(0);
					SH:='0' & REG_IN (7 downto 1) ;
					SH(7):= SEL(0);
				when "1010" => --SRX
					AUX:=REG_IN(0);
					SH:='0' & REG_IN (7 downto 1);
					SH(7):= SH(6);
				when "1000" => --SRA
					AUX:=REG_IN(0);
					SH:='0' & REG_IN (7 downto 1);
					SH(7):= CARRY;
				when "1100" => --RR
					AUX:=REG_IN(0);
					SH:='0' & REG_IN (7 downto 1);
					SH(7):= AUX;
				when others	 =>
					AUX:= '0';
			   		SH:= "00000000";
			end case;
		else
			SH:="ZZZZZZZZ";
			AUX:='Z';
		end if;
		REG_OUT<=SH;
		CARRY<=AUX;
	end process; 
end SHIFT_F;
				
			
			
		