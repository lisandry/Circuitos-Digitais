LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all; 

ENTITY DESLOCADOR IS
	PORT(
		CK, CLR: IN STD_LOGIC;
		SW: IN STD_LOGIC_VECTOR(3 downto 0); -- CHAVE DIREÇÃO DO DESLOCAMENTO S1 DIR E S2 LEFT
		D: OUT STD_LOGIC_VECTOR (7 DOWNTO 0) -- DESLOCAMENTO 
);
END DESLOCADOR;

  
ARCHITECTURE DESLOCADOR_F OF DESLOCADOR IS
	COMPONENT FFD is
  	port (ck, clr, set, d : in  std_logic;
              q : out std_logic);
	END COMPONENT FFD;

	
	COMPONENT MUX_2_ENTSEL IS
	PORT(
		A00, A01, A10, A11: IN STD_LOGIC; --ENTRADAS
		S0, S1: IN STD_LOGIC; --ENTRADA SELEÇÃO
		Q: OUT STD_LOGIC --SAIDA
	);
	END COMPONENT MUX_2_ENTSEL;

	COMPONENT Somador_Completo is
   	Port(
        	A_SC, B_SC, CI_SC: IN STD_LOGIC;
        	S_SC, CO_SC: OUT STD_LOGIC
    	);
	END COMPONENT Somador_Completo;
	
	
	
	SIGNAL QL: STD_LOGIC_VECTOR (7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL Q0_L: STD_LOGIC := '1';
	SIGNAL inic : std_logic_vector(6 downto 0);
	SIGNAL SM,SM1, SM2, SM3, SM4, SM5, SM6, SM7: STD_LOGIC; --SAIDA MUX
	SIGNAL soma1, COUT,and_L, or1: STD_LOGIC;




BEGIN	
	

	soma: Somador_Completo port map (QL(1),'1','0',soma1,cout);
	or1<= NOT(QL(7) OR QL(6) OR QL(5) OR QL(4) OR QL(3) OR QL(2));
	and_L<= soma1 and or1;

	MX01 : MUX_2_ENTSEL port map (QL(1),QL(2),and_L,Ql(1),SW(0),SW(3),SM1);
	ffd_01: FFD port map (CK,CLR,'1',SM1,QL(1));

	
	MX02 : MUX_2_ENTSEL port map (QL(2),QL(3),QL(1),QL(2),SW(0),SW(3),SM2);
	ffd_02: FFD port map (CK,CLR,'1',SM2,QL(2));

	MX03 : MUX_2_ENTSEL port map (QL(3),QL(4),QL(2),QL(3),SW(0),SW(3),SM3);
	ffd_03: FFD port map (CK,CLR,'1',SM3,QL(3));
	
	MX04 : MUX_2_ENTSEL port map (QL(4),QL(5),QL(3),QL(4),SW(0),SW(3),SM4);
	ffd_04: FFD port map (CK,CLR,'1',SM4,QL(4));
	
	MX05 : MUX_2_ENTSEL port map (QL(5),QL(6),QL(4),QL(5),SW(0),SW(3),SM5);
	ffd_05: FFD port map (CK,CLR,'1',SM5,QL(5));
	
	MX06 : MUX_2_ENTSEL port map (QL(6),QL(7),QL(5),QL(6),SW(0),SW(3),SM6);
	ffd_06: FFD port map (CK,CLR,'1',SM6,QL(6));

	MX07 : MUX_2_ENTSEL port map (QL(7),and_L,QL(6),QL(7),SW(0),SW(3),SM7);
	ffd_07: FFD port map (CK,CLR,'1',SM7,QL(7));
	
	Q0_L<= NOT(QL(7) OR QL(6) OR QL(5) OR QL(4) OR QL(3) OR QL(2) or QL(1));
	D <=(QL(7),QL(6),QL(5),QL(4),QL(3),QL(2),QL(1),Q0_L);

END DESLOCADOR_F;
