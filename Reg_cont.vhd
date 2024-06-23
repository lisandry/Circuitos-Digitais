library ieee;
use ieee.std_logic_1164.all;

entity Reg_cont is
	port( 	    E: in std_logic_vector(3 downto 0);
		  set: in std_logic;
	         load: in std_logic;
		clear: in std_logic;
		clock: in std_logic;
		    S: out std_logic_vector(3 downto 0)
	);
end Reg_cont;

architecture logic of Reg_cont is
	
component FF_D is
	port(ck, clr, set, d :  in std_logic;
			   q : out std_logic
	);
end component;

component Mux_2x1 is
	port(E0, E1 :  in std_logic_vector(3 downto 0);
		sel :  in std_logic;
		  S : out std_logic_vector(3 downto 0)
	);
end component;

signal D, Q : std_logic_vector(3 downto 0);
--signal set  : std_logic := '1';
signal clr  : std_logic;

begin

	clr <= not(clear);
	
	M : Mux_2x1 port map(Q, E, load, D);
        F3 : FF_D port map(clock, clr, set, D(3), Q(3));
	
	F2 : FF_D port map(clock, clr, set, D(2), Q(2));

	F1 : FF_D port map(clock, clr, set, D(1), Q(1));

	F0 : FF_D port map(clock, clr, set, D(0), Q(0));

	S <= Q;

end logic;
