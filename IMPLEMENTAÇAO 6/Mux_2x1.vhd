library ieee;
use ieee.std_logic_1164.all;

entity Mux_2x1 is
	port( E0, E1:  in std_logic_vector(3 downto 0);
		 sel:  in std_logic;
		   S: out std_logic_vector(3 downto 0)
	);
end Mux_2x1;

architecture logic of Mux_2x1 is

begin

	S(0) <= (E0(0) and not(sel)) or (E1(0) and sel);
	S(1) <= (E0(1) and not(sel)) or (E1(1) and sel);
	S(2) <= (E0(2) and not(sel)) or (E1(2) and sel);
	S(3) <= (E0(3) and not(sel)) or (E1(3) and sel);
	
end architecture logic;









