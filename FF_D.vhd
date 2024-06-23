library ieee;
use ieee.std_logic_1164.all;

entity FF_D is
	port(ck, clr, set, d :  in std_logic;
			   q : out std_logic
	);
end FF_D;

architecture logic of FF_D is

begin

  	process(ck, clr, set)
  	begin
	   if    (set = '0')            then q <= '1';
	   elsif (clr = '0')            then q <= '0';
	   elsif (ck'event and ck ='1') then q <= d;   
	   end if;   
	end process; 
  
end logic;