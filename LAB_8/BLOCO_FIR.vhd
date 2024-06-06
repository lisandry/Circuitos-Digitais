LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY BLOCO_FIR IS
	PORT(
		CLR_R, LD_R, CLK, EN_COD, LD_OUT: IN STD_LOGIC;
		Y_IN: IN STD_LOGIC_VECTOR(3 DOWNTO 0); --VALOR Y
		C_012: IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- CTE FILTRO
		S_COD: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		F_FIR: OUT STD_LOGIC_VECTOR (9 DOWNTO 0)

);
END BLOCO_FIR;

ARCHITECTURE BLOCO_FIR OF BLOCO_FIR IS

	COMPONENT BLOCO_RC IS
	PORT(
		CLR_R, LOAD_R, LOAD_C, CLK: IN STD_LOGIC;
		Y_IN, C: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		Y_OUT: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		PROD_YC: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
	END COMPONENT BLOCO_RC;

	COMPONENT COD_2X4 IS
	PORT(
		EN: IN STD_LOGIC;
		S1, S0: IN STD_LOGIC;
		Q3, Q2, Q1, Q0: OUT STD_LOGIC
	);
	END COMPONENT COD_2X4;

	COMPONENT Somador_Completo is
        PORT(
        	A_SC, B_SC, CI_SC: IN STD_LOGIC;
        	S_SC, CO_SC: OUT STD_LOGIC
        );
    	END COMPONENT Somador_Completo;

	COMPONENT REG_1BIT IS
	PORT(
		CLR_R, LOAD_R, CLK: IN STD_LOGIC;
		D: IN STD_LOGIC;
		S: OUT STD_LOGIC
	);
	END COMPONENT REG_1BIT;

	COMPONENT  binToBCD_MAIN is
	port(
		SW: in std_logic_vector(9 downto 0);
		Seg4: out std_logic_vector(3 downto 0);
		Seg3: out std_logic_vector(3 downto 0);
		Seg2: out std_logic_vector(3 downto 0);
		Seg1: out std_logic_vector(3 downto 0)
	);
	END COMPONENT;

	COMPONENT ck_div is	
	port (ck_in : in  std_logic;
		ck_out: out std_logic);
	END COMPONENT ck_div;

	COMPONENT conv_7seg is
    	 port (a,b,c,d: in std_logic;
		 sa,sb,sc,sd,se,sf,sg: out std_logic);
	END COMPONENT conv_7seg;



	SIGNAL S10, S11, S12, S13, S14, S15, S16, S17: STD_LOGIC;
	SIGNAL C10, C11, C12, C13, C14, C15, C16, C17: STD_LOGIC;

	SIGNAL S20, S21, S22, S23, S24, S25, S26, S27, S8: STD_LOGIC;
	SIGNAL C20, C21, C22, C23, C24, C25, C26, C27, C28: STD_LOGIC;
	
	SIGNAL F0, F1, F2, F3, F4, F5, F6, F7, F8, F9: STD_LOGIC;
	SIGNAL Y_OUT1, Y_OUT2, Y_OUT3: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL PY_1, PY_2, PY_3: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL PY_3_AUX: STD_LOGIC_VECTOR(8 DOWNTO 0);
	SIGNAL Q3, Q2, Q1, Q0: STD_LOGIC;

	SIGNAL F_7SEG: STD_LOGIC_VECTOR(9 DOWNTO 
	--SIGNAL CLK: STD_LOGIC;
	SIGNAL F: STD_LOGIC_VECTOR (9 DOWNTO 0);

	SIGNAL Seg4, Seg3, Seg2, Seg1, sa, sb, sc, sd, se, sf, sg: std_logic_vector (3 downto 0);

BEGIN
--CLOCK: ck_div PORT MAP(CLK_IN, CLK);

COD: COD_2X4 PORT MAP (EN_COD, S_COD(1), S_COD(0) , Q3, Q2, Q1, Q0);

BLOCO_RC1: BLOCO_RC PORT MAP (CLR_R, LD_R, Q0, CLK, Y_IN, C_012, Y_OUT1, PY_1);
BLOCO_RC2: BLOCO_RC PORT MAP (CLR_R, LD_R, Q1, CLK, Y_OUT1, C_012, Y_OUT2, PY_2);
BLOCO_RC3: BLOCO_RC PORT MAP (CLR_R, LD_R, Q2, CLK, Y_OUT2, C_012, Y_OUT3, PY_3);


-- PRIMEIRO SOMADOR (8 BITS -> 9 BITS)
S_10: Somador_Completo PORT MAP (PY_1(0), PY_2(0), '0', S10, C10);
S_11: Somador_Completo PORT MAP (PY_1(1), PY_2(1), C10, S11, C11);
S_12: Somador_Completo PORT MAP (PY_1(2), PY_2(2), C11, S12, C12);
S_13: Somador_Completo PORT MAP (PY_1(3), PY_2(3), C12, S13, C13);
S_14: Somador_Completo PORT MAP (PY_1(4), PY_2(4), C13, S14, C14);
S_15: Somador_Completo PORT MAP (PY_1(5), PY_2(5), C14, S15, C15);
S_16: Somador_Completo PORT MAP (PY_1(6), PY_2(6), C15, S16, C16);
S_17: Somador_Completo PORT MAP (PY_1(7), PY_2(7), C16, S17, C17);

PY_3_AUX(0) <= PY_3 (0);
PY_3_AUX(1) <= PY_3 (1);
PY_3_AUX(2) <= PY_3 (2);
PY_3_AUX(3) <= PY_3 (3);
PY_3_AUX(4) <= PY_3 (4);
PY_3_AUX(5) <= PY_3 (5);
PY_3_AUX(6) <= PY_3 (6);
PY_3_AUX(7) <= PY_3 (7);
PY_3_AUX(8) <= '0';



-- SEGUNDO SOMADOR(9 BITS -> 10 BITS)
S_20: Somador_Completo PORT MAP (PY_3_AUX(0), S10, '0', F0, C20);
S_21: Somador_Completo PORT MAP (PY_3_AUX(1), S11, C20, F1, C21);
S_22: Somador_Completo PORT MAP (PY_3_AUX(2), S12, C21, F2, C22);
S_23: Somador_Completo PORT MAP (PY_3_AUX(3), S13, C22, F3, C23);
S_24: Somador_Completo PORT MAP (PY_3_AUX(4), S14, C23, F4, C24);
S_25: Somador_Completo PORT MAP (PY_3_AUX(5), S15, C24, F5, C25);
S_26: Somador_Completo PORT MAP (PY_3_AUX(6), S16, C25, F6, C26);
S_27: Somador_Completo PORT MAP (PY_3_AUX(7), S17, C26, F7, C27);
S_28: Somador_Completo PORT MAP (PY_3_AUX(8), C17, C27, F8, C28);

-- REGISTRADOR F
REG_F0 : REG_1BIT PORT MAP ('1', LD_OUT, CLK, F0, F(0));
REG_F1 : REG_1BIT PORT MAP ('1', LD_OUT, CLK, F1, F(1));
REG_F2 : REG_1BIT PORT MAP ('1', LD_OUT, CLK, F2, F(2));
REG_F3 : REG_1BIT PORT MAP ('1', LD_OUT, CLK, F3, F(3));
REG_F4 : REG_1BIT PORT MAP ('1', LD_OUT, CLK, F4, F(4));
REG_F5 : REG_1BIT PORT MAP ('1', LD_OUT, CLK, F5, F(5));
REG_F6 : REG_1BIT PORT MAP ('1', LD_OUT, CLK, F6, F(6));
REG_F7 : REG_1BIT PORT MAP ('1', LD_OUT, CLK, F7, F(7));
REG_F8 : REG_1BIT PORT MAP ('1', LD_OUT, CLK, F8, F(8));
REG_F9 : REG_1BIT PORT MAP ('1', LD_OUT, CLK, C28, F(9));

F_7SEG(0)<= F(0);
F_7SEG(1)<= F(1);
F_7SEG(2)<= F(2);
F_7SEG(3)<= F(3);
F_7SEG(4)<= F(4);
F_7SEG(5)<= F(5);
F_7SEG(6)<= F(6);
F_7SEG(7)<= F(7);
F_7SEG(8)<= F(8);
F_7SEG(9)<= F(9);

---- Saída para os displays ----
saida_display : binToBCD_MAIN port map(F, Seg4, Seg3, Seg2, Seg1);  
  
---- Conversor 7 segmentos ----
conv_7segmentos1 : conv_7seg port map(Seg1(0), Seg1(1), Seg1(2), Seg1(3), sa(0), sb(0), sc(0), sd(0), se(0), sf(0), sg(0));
conv_7segmentos2 : conv_7seg port map(Seg2(0), Seg2(1), Seg2(2), Seg2(3), sa(1), sb(1), sc(1), sd(1), se(1), sf(1), sg(1));
conv_7segmentos3 : conv_7seg port map(Seg3(0), Seg3(1), Seg3(2), Seg3(3), sa(2), sb(2), sc(2), sd(2), se(2), sf(2), sg(2));
conv_7segmentos4 : conv_7seg port map(Seg4(0), Seg4(1), Seg4(2), Seg4(3), sa(3), sb(3), sc(3), sd(3), se(3), sf(3), sg(3));

END ARCHITECTURE BLOCO_FIR;
