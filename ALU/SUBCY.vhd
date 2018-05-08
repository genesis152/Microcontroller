library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Scazator_complet is
port(EN: in STD_LOGIC;
A,B: in std_logic_vector(7 downto 0);
DIF: out std_logic_vector(7 downto 0);
CF: inout std_logic;
ZF: out std_logic);
end;

architecture SUBCY of Scazator_complet is 
begin
   process(A,B,CF,EN)				
	variable AUX_B: std_logic_vector(7 downto 0);
	variable C: std_logic_vector(7 downto 0);
	variable D: std_logic_vector(7 downto 0);
	begin
	if(EN='1') then
		AUX_B:=not(B+CF);
		D(0)  := A(0) xor AUX_B(0);
		C(0)  :=A(0) and AUX_B(0);
		for I in 1 to 7 loop
            D(I)  := (A(I) xor AUX_B(I)) xor C(I-1);
            C(I)  := (A(I) and B(I)) or (A(I) and C(I-1)) or (AUX_B(I) and C(I-1)); 
        end loop;
	else 
		D:="ZZZZZZZZ";
		C:="ZZZZZZZZ";
	end if;
	DIF <= D;
	if(A<B and EN='1') then
		CF<='1';
	elsif EN='1' then
		CF<='0';
	else
		CF<='Z';
	end if;
	if(D = "00000000" and EN='1') then 
		ZF <='1'; 
	elsif EN='1' then 
		ZF<='0';
	else
		ZF<='Z';
    end if;	
	end process;
end;		   