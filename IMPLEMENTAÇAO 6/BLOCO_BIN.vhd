LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Lab_02_bloco IS
    PORT(
        A     : in std_logic_vector(3 downto 0);
        S  : out std_logic_vector (3 downto 0)
    );
END ENTITY;

ARCHITECTURE main OF Lab_02_bloco IS 

BEGIN 
    -- entrada na tabela 
    S(0)<=  ((NOT A(3)) AND (NOT A(2)) AND A(0)) OR ((NOT A(0)) AND A(1) AND A(2)) OR ((NOT A(0)) AND A(3));

    S(1)<= (A(1) AND (NOT A(2))) OR (A(0) AND A(1)) OR ((NOT A(0)) AND A(3));

    S(2)<= ((NOT A(0)) AND (NOT A(1)) AND A(2)) OR (A(0) AND A(3));
           
    S(3)<= (A(0) AND A(2)) OR (A(1) AND A(2)) OR A(3);

END ARCHITECTURE;
