LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY REG_13BITS_ENABLE IS
	PORT(
		CLR, LOAD, CLK: IN STD_LOGIC;
		V: IN STD_LOGIC_VECTOR(12 DOWNTO 0);
		S: OUT STD_LOGIC_VECTOR (12 DOWNTO 0)
);
END REG_13BITS_ENABLE;

ARCHITECTURE REG_13BITS_ENABLE OF REG_13BITS_ENABLE IS
	COMPONENT ffd is
   		PORT (ck, clr, set, d : in  std_logic; --N�O ESQUECER QUE COLOCAR O CLOCK_DIV
                       q : out std_logic);
	END COMPONENT ffd;
	
	COMPONENT mux_2x1_l is
	Port (
        	A, B : in  STD_LOGIC;
        	C    : in  STD_LOGIC;
        	Y    : out STD_LOGIC
   	);
	END COMPONENT mux_2x1_l;
	
	SIGNAL  Q12, Q11, Q10, Q9, Q8, Q7, Q6, Q5, Q4, Q3, Q2, Q1, Q0: STD_LOGIC;
	SIGNAL  EN12, EN11, EN10, EN9, EN8, EN7, EN6, EN5, EN4, EN3, EN2, EN1, EN0: STD_LOGIC;

BEGIN
EN_12: mux_2x1_l PORT MAP (Q2, V(12),LOAD, EN12);
EN_11: mux_2x1_l PORT MAP (Q1, V(11),LOAD, EN11);
EN_10: mux_2x1_l PORT MAP (Q10,V(10),LOAD, EN10);
EN_9 : mux_2x1_l PORT MAP (Q9, V(9), LOAD, EN9);
EN_8 : mux_2x1_l PORT MAP (Q8, V(8), LOAD, EN8);
EN_7 : mux_2x1_l PORT MAP (Q7, V(7), LOAD, EN7);
EN_6 : mux_2x1_l PORT MAP (Q6, V(6), LOAD, EN6);
EN_5 : mux_2x1_l PORT MAP (Q5, V(5), LOAD, EN5);
EN_4 : mux_2x1_l PORT MAP (Q4, V(4), LOAD, EN4);
EN_3 : mux_2x1_l PORT MAP (Q3, V(3), LOAD, EN3);
EN_2 : mux_2x1_l PORT MAP (Q2, V(2), LOAD, EN2);
EN_1 : mux_2x1_l PORT MAP (Q1, V(1), LOAD, EN1);
EN_0 : mux_2x1_l PORT MAP (Q0, V(0), LOAD, EN0);

S12: FFD PORT MAP (CLK,CLR, '1', EN12, Q12);
S11: FFD PORT MAP (CLK,CLR, '1', EN11, Q11);
S10: FFD PORT MAP (CLK,CLR, '1', EN10, Q10);
S9:  FFD PORT MAP (CLK,CLR ,'1', EN9, Q9);
S8:  FFD PORT MAP (CLK,CLR ,'1', EN8, Q8);
S7:  FFD PORT MAP (CLK,CLR ,'1', EN7, Q7);
S6:  FFD PORT MAP (CLK,CLR ,'1', EN6, Q6);
S5:  FFD PORT MAP (CLK,CLR ,'1', EN5, Q5);
S4:  FFD PORT MAP (CLK,CLR ,'1', EN4, Q4);
S3:  FFD PORT MAP (CLK,CLR ,'1', EN3, Q3);
S2:  FFD PORT MAP (CLK,CLR ,'1', EN2, Q2);
S1:  FFD PORT MAP (CLK,CLR ,'1', EN1, Q1);
S0:  FFD PORT MAP (CLK,CLR ,'1', EN0, Q0);

S(12) <= Q12;
S(11) <= Q11;
S(10)<= Q10;
S(9) <= Q9;
S(8) <= Q8;
S(7) <= Q7;
S(6) <= Q6;
S(5) <= Q5;
S(4) <= Q4;
S(3) <= Q3;
S(2) <= Q2;
S(1) <= Q1;
S(0) <= Q0;

END ARCHITECTURE;
