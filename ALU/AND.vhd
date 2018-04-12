entity Poarta_SI is
port(A,B: in BIT_VECTOR(7 downto 0);
Y: out BIT_VECTOR(7 downto 0);
CF,ZF: out BIT);
end;  

architecture SI of Poarta_SI is
begin
Y <= A and B; 
CF <= '0';
end; 