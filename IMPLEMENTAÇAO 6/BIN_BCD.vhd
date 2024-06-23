LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Lab_02_bcd IS
    PORT(
            pin      : in std_logic_vector (7 downto 0);
            bcd      : out std_logic_vector (11 downto 0)
    );
END ENTITY;

ARCHITECTURE main OF Lab_02_bcd IS

COMPONENT Lab_02_bloco IS
    PORT(
        A  : in std_logic_vector(3 downto 0);
        S  : out std_logic_vector (3 downto 0)
    );
END COMPONENT Lab_02_bloco;

SIGNAL E1, E2, E3, E4, E5, E6, E7  : std_logic_vector (3 downto 0);
SIGNAL R1, R2, R3, R4, R5, R6, R7  : std_logic_vector (3 downto 0);

BEGIN
-- Circuito 1
E1(3) <= '0';
E1(2) <= pin(7);
E1(1) <= pin(6);
E1(0) <= pin(5);

U1: Lab_02_bloco PORT MAP (E1, R1);

-- Circuito 2
E2(3) <= R1(2);
E2(2) <= R1(1);
E2(1) <= R1(0);
E2(0) <= pin(4);

U2: Lab_02_bloco PORT MAP (E2, R2);

-- Circuito 3
E3(3) <= R2(2);
E3(2) <= R2(1);
E3(1) <= R2(0);
E3(0) <= pin(3);

U3: Lab_02_bloco PORT MAP (E3, R3);

-- Circuito 4
E4(3) <= R3(2);
E4(2) <= R3(1);
E4(1) <= R3(0);
E4(0) <= pin(2);

U4: Lab_02_bloco PORT MAP (E4, R4);

-- Circuito 5
E5(3) <= '0';
E5(2) <= R1(3);
E5(1) <= R2(3);
E5(0) <= R3(3);

U5: Lab_02_bloco PORT MAP (E5, R5);

-- Circuito 6
E6(3) <= R4(2);
E6(2) <= R4(1);
E6(1) <= R4(0);
E6(0) <= pin(1);

U6: Lab_02_bloco PORT MAP (E6, R6);

-- Circuito 7
E7(3) <= R5(2);
E7(2) <= R5(1);
E7(1) <= R5(0);
E7(0) <= R4(3);

U7: Lab_02_bloco PORT MAP (E7, R7);

bcd(11)<= '0';
bcd(10)<= '0';
bcd(9)<=  R5(3);
bcd(8)<=  R7(3);
bcd(7)<=  R7(2);
bcd(6)<=  R7(1);
bcd(5)<=  R7(0);
bcd(4)<=  R6(3);
bcd(3)<=  R6(2);
bcd(2)<=  R6(1);
bcd(1)<=  R6(0);
bcd(0)<=  pin(0);

END ARCHITECTURE;