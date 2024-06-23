library ieee;
use ieee.std_logic_1164.all;

entity mux is 
    port (
        key_comp : in STD_LOGIC_VECTOR (3 downto 0);
        reg0, reg1 ,reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9,reg10,reg11, reg12,reg13,reg14,reg15: in STD_LOGIC_VECTOR (12 downto 0);
        S_sub : out STD_LOGIC_VECTOR (12 downto 0)
    );
end entity ;
    
    architecture main of mux is 

    signal key_comp_v0 : STD_LOGIC_VECTOR (12 downto 0);
    signal key_comp_v1 : STD_LOGIC_VECTOR (12 downto 0);
    signal key_comp_v2  : STD_LOGIC_VECTOR (12 downto 0);
    signal key_comp_v3  : STD_LOGIC_VECTOR (12 downto 0);
    
    begin
       key_comp_v3 <= (key_comp(3),key_comp(3),key_comp(3),key_comp(3),key_comp(3),key_comp(3),key_comp(3),key_comp(3),key_comp(3),key_comp(3),key_comp(3),key_comp(3),key_comp(3));

        key_comp_v2 <= (key_comp(2),key_comp(2),key_comp(2),key_comp(2),key_comp(2),key_comp(2),key_comp(2),key_comp(2),key_comp(2),key_comp(2),key_comp(2),key_comp(2),key_comp(2));
        
        key_comp_v1 <= (key_comp(1),key_comp(1),key_comp(1),key_comp(1),key_comp(1),key_comp(1),key_comp(1),key_comp(1),key_comp(1),key_comp(1),key_comp(1),key_comp(1),key_comp(1));
        
        key_comp_v0 <= (key_comp(0),key_comp(0),key_comp(0),key_comp(0),key_comp(0),key_comp(0),key_comp(0),key_comp(0),key_comp(0),key_comp(0),key_comp(0),key_comp(0),key_comp(0));
       
	 S_sub <= (reg0  and (not (key_comp_v3) and not (key_comp_v2) and not (key_comp_v1) and  not (key_comp_v0))) or 
                 (reg1  and (not (key_comp_v3) and not (key_comp_v2) and not (key_comp_v1) and      (key_comp_v0))) or 
                 (reg2  and (not (key_comp_v3) and not (key_comp_v2) and     (key_comp_v1) and  not (key_comp_v0))) or 
                 (reg3  and (not (key_comp_v3) and not (key_comp_v2) and     (key_comp_v1) and      (key_comp_v0))) or 
                 (reg4  and (not (key_comp_v3) and     (key_comp_v2) and not (key_comp_v1) and  not (key_comp_v0))) or 
                 (reg5  and (not (key_comp_v3) and     (key_comp_v2) and not (key_comp_v1) and      (key_comp_v0))) or 
                 (reg6  and (not (key_comp_v3) and     (key_comp_v2) and     (key_comp_v1) and  not (key_comp_v0))) or 
                 (reg7  and (not (key_comp_v3) and     (key_comp_v2) and     (key_comp_v1) and      (key_comp_v0))) or 
                 (reg8  and (    (key_comp_v3) and not (key_comp_v2) and not (key_comp_v1) and  not (key_comp_v0))) or 
                 (reg9  and (    (key_comp_v3) and not (key_comp_v2) and not (key_comp_v1) and      (key_comp_v0))) or 
                 (reg10 and (    (key_comp_v3) and not (key_comp_v2) and     (key_comp_v1) and  not (key_comp_v0))) or 
                 (reg11 and (    (key_comp_v3) and not (key_comp_v2) and     (key_comp_v1) and      (key_comp_v0))) or 
                 (reg12 and (    (key_comp_v3) and     (key_comp_v2) and not (key_comp_v1) and  not (key_comp_v0))) or 
                 (reg13 and (    (key_comp_v3) and     (key_comp_v2) and not (key_comp_v1) and      (key_comp_v0))) or 
                 (reg14 and (    (key_comp_v3) and     (key_comp_v2) and     (key_comp_v1) and  not (key_comp_v0))) or 
                 (reg15 and (    (key_comp_v3) and     (key_comp_v2) and     (key_comp_v1) and      (key_comp_v0)));

    end architecture;
