library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Scazator is
port(EN: in STD_LOGIC;
A,B: in std_logic_vector(7 downto 0);
DIF: out std_logic_vector(7 downto 0);
CF,ZF: inout std_logic);
end;

architecture SUB of Scazator is	 
begin  
	process(A,B,EN)				
	variable AUX_B: std_logic_vector(7 downto 0);
	variable C: std_logic_vector(7 downto 0);
	variable D: std_logic_vector(7 downto 0);
	begin
	if(EN='1') then
		AUX_B:=not(B) + '1';
		D(0)  := A(0) xor AUX_B(0);
		C(0)  :=A(0) and AUX_B(0);
		for I in 1 to 7 loop
            D(I)  := (A(I) xor AUX_B(I)) xor C(I-1);
            C(I)  := (A(I) and AUX_B(I)) or (A(I) and C(I-1)) or (AUX_B(I) and C(I-1)); 
        end loop;
	else
		D:="ZZZZZZZZ";
		C:="ZZZZZZZZ";
	end if;
	DIF <= D;
	if(EN='1' and A<B) then
		CF<='1';
		D:=D+'1';
	elsif EN='1' then
		CF<='0';
	else
		CF<='Z';
	end if;
	if(D = "00000000") then ZF <='1';
	elsif EN='1' then
		ZF<='0';
	else
		ZF<=ZF;
    end if;
	end process;
end;