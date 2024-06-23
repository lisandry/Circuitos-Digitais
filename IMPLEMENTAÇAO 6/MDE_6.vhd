LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MDE IS
	PORT(
	     ck, rst : IN STD_LOGIC;
	     WR,RD,EQ0, EQ15: IN STD_LOGIC;
	     vazio, cheio, clear, set: OUT STD_LOGIC;
	     s : out STD_LOGIC_VECTOR (1 DOWNTO 0)
	);
END MDE;

ARCHITECTURE logic OF MDE IS 
	
	TYPE ST IS (INC, EV, FULL, SV);
	SIGNAL state: ST;
	
BEGIN
	
   PROCESS (ck, rst)
   BEGIN

    IF rst = '1' THEN                 
       state <= INC;
       vazio <= '1';
       cheio <= '0';
       clear <= '0';
       set <= '1';              
    ELSIF (ck'EVENT AND ck ='1') THEN    
       CASE state IS
        
        WHEN INC =>                         
           IF WR = '1' THEN state <= EV;
              vazio <= '0';
              cheio <= '0';
              clear <= '1'; 
       	      set <= '1'; 
           ELSE state <= INC;
           END IF;
          
        
        WHEN EV => 
           IF RD = '1' AND EQ15='0' THEN state <= SV;
              vazio <= '0';
	      cheio <= '0';
              clear <= '1';
       	      set <= '1'; 
           ELSIF EQ15='1' THEN state <= FULL;
              vazio <= '0';
              cheio <= '1';
              clear <= '1';
       	      set <= '0'; 
           ELSE state <= EV;
           END IF; 
			 
        
        WHEN FULL =>                         
           IF RD = '1' THEN state <= SV;
              vazio <= '0';
              cheio <= '0';
              clear <= '1';
       	      set <= '1'; 
           ELSE state <= FULL;
           END IF;
			 
        
        WHEN SV =>                         
           IF EQ0 ='1' THEN state <= INC;
              vazio <= '1';
              cheio <= '0';
              clear <= '0';
              set <= '1';
           ELSE state <= SV;
           END IF ;
            
       END CASE;
    END IF;
	
   END PROCESS;
	
    WITH state SELECT  
       s <="00" WHEN INC,
           "01" WHEN EV, 
           "10" WHEN FULL, 
           "11" WHEN SV;
	    
END logic;

