LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY REG_C IS
	PORT(
		LOAD_C, CLK: IN STD_LOGIC;
		D: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		S: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
);
END REG_C;

ARCHITECTURE REG_C OF REG_C IS
	COMPONENT ffd is
   		PORT (ck, clr, set, d : in  std_logic; --NÃO ESQUECER QUE COLOCAR O CLOCK_DIV
                       q : out std_logic);
	END COMPONENT ffd;
	
	COMPONENT mux_2x1 is
	Port (
        	A, B : in  STD_LOGIC;
        	C    : in  STD_LOGIC;
        	Y    : out STD_LOGIC
   	);
	END COMPONENT mux_2x1;
	
	SIGNAL Q3, Q2, Q1, Q0: STD_LOGIC;
	SIGNAL EN3, EN2, EN1, EN0: STD_LOGIC;

BEGIN

EN_3 : MUX_2X1 PORT MAP (Q3, D(3), LOAD_C, EN3);
EN_2 : MUX_2X1 PORT MAP (Q2, D(2), LOAD_C, EN2);
EN_1 : MUX_2X1 PORT MAP (Q1, D(1), LOAD_C, EN1);
EN_0 : MUX_2X1 PORT MAP (Q0, D(0), LOAD_C, EN0);

S3: FFD PORT MAP (CLK, '1', '1', EN3,Q3);
S2: FFD PORT MAP (CLK, '1', '1', EN2,Q2);
S1: FFD PORT MAP (CLK, '1', '1', EN1,Q1);
S0: FFD PORT MAP (CLK, '1', '1', EN0,Q0);

S(3) <= Q3;
S(2) <= Q2;
S(1) <= Q1;
S(0) <= Q0;

END ARCHITECTURE;
