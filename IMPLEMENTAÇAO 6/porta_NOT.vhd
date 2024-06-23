library ieee;
use ieee.std_logic_1164.all;

entity porta_NOT is
	port (	A: in std_logic_vector(3 downto 0);
		O: out std_logic_vector(3 downto 0));
end porta_NOT;

architecture logic of porta_NOT is

begin
	O <= not(A);

end logic;









