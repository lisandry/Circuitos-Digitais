library ieee;
use ieee.std_logic_1164.all;

entity Decod is 
	port(sel : in  std_logic_vector(3 downto 0);
	       S : out std_logic_vector(15 downto 0)
        );
end Decod;

architecture logic of Decod is

begin

   S(0)  <= not(sel(3)) and not(sel(2)) and not(sel(1)) and not(sel(0));
   S(1)  <= not(sel(3)) and not(sel(2)) and not(sel(1)) and     sel(0) ;
   S(2)  <= not(sel(3)) and not(sel(2)) and     sel(1)  and not(sel(0));
   S(3)  <= not(sel(3)) and not(sel(2)) and     sel(1)  and     sel(0) ;
   S(4)  <= not(sel(3)) and     sel(2)  and not(sel(1)) and not(sel(0));
   S(5)  <= not(sel(3)) and     sel(2)  and not(sel(1)) and     sel(0) ;
   S(6)  <= not(sel(3)) and     sel(2)  and     sel(1)  and not(sel(0));
   S(7)  <= not(sel(3)) and     sel(2)  and     sel(1)  and     sel(0) ;
   S(8)  <=     sel(3)  and not(sel(2)) and not(sel(1)) and not(sel(0));
   S(9)  <=     sel(3)  and not(sel(2)) and not(sel(1)) and     sel(0) ;
   S(10) <=     sel(3)  and not(sel(2)) and     sel(1)  and not(sel(0));
   S(11) <=     sel(3)  and not(sel(2)) and     sel(1)  and     sel(0) ;
   S(12) <=     sel(3)  and     sel(2)  and not(sel(1)) and not(sel(0));
   S(13) <=     sel(3)  and     sel(2)  and not(sel(1)) and     sel(0) ;
   S(14) <=     sel(3)  and     sel(2)  and     sel(1)  and not(sel(0));
   S(15) <=     sel(3)  and     sel(2)  and     sel(1)  and     sel(0) ;

end logic;

