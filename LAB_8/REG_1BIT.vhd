LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY REG_1BIT IS
	PORT(
		CLR_R, LOAD_R, CLK: IN STD_LOGIC;
		D: IN STD_LOGIC;
		S: OUT STD_LOGIC
);
END REG_1BIT;

ARCHITECTURE REG_1BIT OF REG_1BIT IS
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
	
	SIGNAL Q1: STD_LOGIC;
	SIGNAL EN1: STD_LOGIC;

BEGIN
EN_1 : MUX_2X1 PORT MAP (Q1, D, LOAD_R, EN1);

S1: FFD PORT MAP (CLK,CLR_R ,'1', EN1,Q1);

S <= Q1;

END ARCHITECTURE;