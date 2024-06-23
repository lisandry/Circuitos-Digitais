library ieee;
use ieee.std_logic_1164.all;

entity Decrementador is 
	port( A:  in std_logic_vector(3 downto 0);
	      S: out std_logic_vector(3 downto 0)
	);
end Decrementador;

architecture logic of Decrementador is

component somador_4bits is
  port( A, B: in std_logic_vector(3 downto 0);
	O: out std_logic_vector(3 downto 0);
	Cout: out std_logic);
end component;

component porta_NOT is
  port (A: in std_logic_vector(3 downto 0);
	O: out std_logic_vector(3 downto 0));
end component;

  signal aux_Cout : std_logic;

  signal complemento : std_logic_vector(3 downto 0);
  signal B : std_logic_vector(3 downto 0);
  signal notB : std_logic_vector(3 downto 0);
  signal entradaFixa : std_logic_vector(3 downto 0);
  signal Cout : std_logic;

begin

    entradaFixa <= "0001";
    B <= "0001";
    U1: porta_NOT port map(B, notB);
    U2: somador_4bits port map(notB, entradaFixa, complemento, aux_Cout);

    X1: somador_4bits port map(A, complemento, S, Cout);

end logic;









