library ieee;
use ieee.std_logic_1164.all;

entity somador is 
	port( A, B, Cin: in std_logic;
	        O, Cout: out std_logic);
end somador;

architecture logic of somador is


begin
	
    O    <= ((A xor B) xor Cin);
    Cout <= (A and Cin) or (A and B) or (B and Cin);

end logic;
