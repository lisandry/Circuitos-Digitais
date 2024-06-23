library ieee;
use ieee.std_logic_1164.all;

entity MAIN is 
	port( 
	W_DATA: in std_logic_vector(12 downto 0);
	WR, RD, KEY, CLK: in std_logic;
	R_DATA_BCD: out std_logic_vector(23 downto 0);
	CHEIO, VAZIO: out std_logic
);
end MAIN;

ARCHITECTURE MAIN OF MAIN IS 

-- *COMPONENTES DATAPATH E MDE*
component Contador is 
	port(  
		set: in std_logic;
		dir: in std_logic;
               cnt:  in std_logic;
             clear:  in std_logic;
             clock:  in std_logic;
                 S: out std_logic_vector(3 downto 0)
	);
end component Contador;

COMPONENT COMPARADOR_4BIT is
	Port(
		A, B: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		EQ, GT, LT: OUT STD_LOGIC
);
END COMPONENT COMPARADOR_4BIT;

COMPONENT MDE IS
	PORT(
	     ck, rst : IN STD_LOGIC;
	     WR,RD,EQ0, EQ15: IN STD_LOGIC;
	     vazio, cheio, clear, set: OUT STD_LOGIC;
	     s : out STD_LOGIC_VECTOR (1 DOWNTO 0)
	);
END COMPONENT MDE;

COMPONENT MUX_2_ENTSEL IS
	PORT(
		A00, A01, A10, A11: IN STD_LOGIC; --ENTRADAS
		S0, S1: IN STD_LOGIC; --ENTRADA SELE��O
		Q: OUT STD_LOGIC --SAIDA
);
END COMPONENT MUX_2_ENTSEL;


-- *COMPONENTES BANCO DE REGISTRADORES*
COMPONENT REG_13BITS_ENABLE IS
	PORT(
		CLR, LOAD, CLK: IN STD_LOGIC;
		V: IN STD_LOGIC_VECTOR(12 DOWNTO 0);
		S: OUT STD_LOGIC_VECTOR (12 DOWNTO 0)
);
END COMPONENT REG_13BITS_ENABLE;

COMPONENT Decod is 
	port(sel : in  std_logic_vector(3 downto 0);
	       S : out std_logic_vector(15 downto 0)
        );
END COMPONENT Decod;

COMPONENT mux is 
    port (
        key_comp : in STD_LOGIC_VECTOR (3 downto 0);
        reg0, reg1 ,reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9,reg10,reg11, reg12,reg13,reg14,reg15: in STD_LOGIC_VECTOR (12 downto 0);
        S_sub : out STD_LOGIC_VECTOR (12 downto 0)
    );
END COMPONENT mux;

--*COMPONENTES BIN BCD*
COMPONENT Lab_02_bcd IS
    PORT(
            pin      : in std_logic_vector (7 downto 0);
            bcd      : out std_logic_vector (11 downto 0)
    );
END COMPONENT;

--SIGNALS DATAPATH
SIGNAL LOAD_CONT, CLEAR_S, CLR, CD, SETM: STD_LOGIC;
SIGNAL EQ_2, GT_2, LT_2: STD_LOGIC;
SIGNAL EQ_1, GT_1, LT_1: STD_LOGIC;
SIGNAL S: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL EDO: STD_LOGIC_VECTOR(1 DOWNTO 0);

--SIGNALS BANCO DE REG
SIGNAL LOAD_R: STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL R1, R2, R3, R4,R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R_DATA: STD_LOGIC_VECTOR(12 DOWNTO 0);
SIGNAL CLEAR_R: STD_LOGIC;

--SIGNALS BIN BCD
SIGNAL BCD1, BCD2: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL R_DATA_BCD1, R_DATA_BCD2: STD_LOGIC_VECTOR(11 DOWNTO 0);

BEGIN

------DATAPATH
CLR <= NOT(CLEAR_S);
CD <= EDO(0) AND EDO(1); -- SELECAO DO CRESCENTE E DESCRESCENTE

MUXEDO: MUX_2_ENTSEL PORT MAP ('0', '1', '0', '1', EDO(0), EDO(1), LOAD_CONT); --LOAD DO REGISTRADOR
CONTADOR_1: CONTADOR PORT MAP (SETM,CD, LOAD_CONT, CLR, CLK,S); --CONTADOR CRESCENTE E DECRESCENTE
COMPARADOR_1: COMPARADOR_4BIT PORT MAP (S, "0000", EQ_1, GT_1, LT_1); -- COMPARA COM 0 PARA VAZIO
COMPARADOR_2: COMPARADOR_4BIT PORT MAP (S, "1111", EQ_2, GT_2, LT_2); -- COMPARA COM 15 PARA CHEIO

------MDE
MDEF: MDE PORT MAP(CLK, KEY, WR, RD, EQ_1, EQ_2, VAZIO, CHEIO,CLEAR_S, SETM,EDO);

------BANCO DE REGISTRADORES
D1: Decod PORT MAP(S, LOAD_R); -- LOAD DOS REGISTRADORES

CLEAR_R <= NOT(KEY);

R1E:  REG_13BITS_ENABLE  PORT MAP(CLEAR_R, LOAD_R(0),CLK, W_DATA, R1); 
R2E:  REG_13BITS_ENABLE  PORT MAP(CLEAR_R, LOAD_R(1),CLK, W_DATA, R2); 
R3E:  REG_13BITS_ENABLE  PORT MAP(CLEAR_R, LOAD_R(2),CLK, W_DATA, R3); 
R4E:  REG_13BITS_ENABLE  PORT MAP(CLEAR_R, LOAD_R(3),CLK, W_DATA, R4); 
R5E:  REG_13BITS_ENABLE  PORT MAP(CLEAR_R, LOAD_R(4),CLK, W_DATA, R5); 
R6E:  REG_13BITS_ENABLE  PORT MAP(CLEAR_R, LOAD_R(5),CLK, W_DATA, R6);
R7E:  REG_13BITS_ENABLE  PORT MAP(CLEAR_R, LOAD_R(6),CLK, W_DATA, R7);
R8E:  REG_13BITS_ENABLE  PORT MAP(CLEAR_R, LOAD_R(7),CLK, W_DATA, R8);
R9E:  REG_13BITS_ENABLE  PORT MAP(CLEAR_R, LOAD_R(8),CLK, W_DATA, R9);
R10E: REG_13BITS_ENABLE  PORT MAP(CLEAR_R, LOAD_R(9),CLK, W_DATA, R10);
R11E: REG_13BITS_ENABLE  PORT MAP(CLEAR_R, LOAD_R(10),CLK, W_DATA, R11);
R12E: REG_13BITS_ENABLE  PORT MAP(CLEAR_R, LOAD_R(11),CLK, W_DATA, R12);
R13E: REG_13BITS_ENABLE  PORT MAP(CLEAR_R, LOAD_R(12),CLK, W_DATA, R13);
R14E: REG_13BITS_ENABLE  PORT MAP(CLEAR_R, LOAD_R(13),CLK, W_DATA, R14);
R15E: REG_13BITS_ENABLE  PORT MAP(CLEAR_R, LOAD_R(14),CLK, W_DATA, R15);
R16E: REG_13BITS_ENABLE  PORT MAP(CLEAR_R, LOAD_R(15),CLK, W_DATA, R16);

MUX_F: mux PORT MAP(S, R1, R2, R3, R4,R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R_DATA);

BCD1(0) <= R_DATA(0);
BCD1(1) <= R_DATA(1);
BCD1(2) <= R_DATA(2);
BCD1(3) <= R_DATA(3);
BCD1(4) <= R_DATA(4);
BCD1(5) <= R_DATA(5);
BCD1(6) <= R_DATA(6);
BCD1(7) <= R_DATA(7);

BCD2(0) <= R_DATA(8);
BCD2(1) <= R_DATA(9);
BCD2(2) <= R_DATA(10);
BCD2(3) <= R_DATA(11);
BCD2(4) <= R_DATA(12);
BCD2(5) <= '0';
BCD2(6) <= '0'; 
BCD2(7) <= '0';

-- BIN BCD
BB1: Lab_02_bcd PORT MAP(BCD1, R_DATA_BCD1);
BB2: Lab_02_bcd PORT MAP(BCD2, R_DATA_BCD2);

R_DATA_BCD(0) <= R_DATA_BCD1(0);
R_DATA_BCD(1) <= R_DATA_BCD1(1);
R_DATA_BCD(2) <= R_DATA_BCD1(2);
R_DATA_BCD(3) <= R_DATA_BCD1(3);
R_DATA_BCD(4) <= R_DATA_BCD1(4);
R_DATA_BCD(5) <= R_DATA_BCD1(5);
R_DATA_BCD(6) <= R_DATA_BCD1(6);
R_DATA_BCD(7) <= R_DATA_BCD1(7);
R_DATA_BCD(8) <= R_DATA_BCD1(8);
R_DATA_BCD(9) <= R_DATA_BCD1(9);
R_DATA_BCD(10)<= R_DATA_BCD1(10);
R_DATA_BCD(11)<= R_DATA_BCD1(11);
R_DATA_BCD(12)<= R_DATA_BCD2(0);
R_DATA_BCD(13)<= R_DATA_BCD2(1);
R_DATA_BCD(14)<= R_DATA_BCD2(2);
R_DATA_BCD(15)<= R_DATA_BCD2(3);
R_DATA_BCD(16)<= R_DATA_BCD2(4);
R_DATA_BCD(17)<= R_DATA_BCD2(5);
R_DATA_BCD(18)<= R_DATA_BCD2(6);
R_DATA_BCD(19)<= R_DATA_BCD2(7);
R_DATA_BCD(20)<= R_DATA_BCD2(8);
R_DATA_BCD(21)<= R_DATA_BCD2(9);
R_DATA_BCD(22)<= R_DATA_BCD2(10);
R_DATA_BCD(23)<= R_DATA_BCD2(11);

END ARCHITECTURE;