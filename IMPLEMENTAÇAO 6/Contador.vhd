library ieee;
use ieee.std_logic_1164.all;

entity Contador is 
	port(  
		set: in std_logic;
		dir: in std_logic;
               cnt:  in std_logic;
             clear:  in std_logic;
             clock:  in std_logic;
                 S: out std_logic_vector(3 downto 0)
	);
end Contador;

architecture logic of Contador is

component Mux_2x1 is
	port( E0, E1:  in std_logic_vector(3 downto 0);
		 sel:  in std_logic;
		   S: out std_logic_vector(3 downto 0)
	);
end component;

component Reg_cont is
	port( 	    E: in std_logic_vector(3 downto 0);
		  set: in std_logic;
	         load: in std_logic;
		clear: in std_logic;
		clock: in std_logic;
		    S: out std_logic_vector(3 downto 0)
	);
end component;

component Incrementador is
	port( A:  in std_logic_vector(3 downto 0);
	      S: out std_logic_vector(3 downto 0)
	);
end component;

component Decrementador is 
	port( A:  in std_logic_vector(3 downto 0);
	      S: out std_logic_vector(3 downto 0)
	);
end component;

signal s_mux: std_logic_vector(3 downto 0);
signal s_reg: std_logic_vector(3 downto 0);
signal s_inc: std_logic_vector(3 downto 0);
signal s_dec: std_logic_vector(3 downto 0);

begin
	M : Mux_2x1 port map(s_inc, s_dec, dir, s_mux);
	R : Reg_cont port map(s_mux, set ,cnt, clear, clock, s_reg);
	I : Incrementador port map(s_reg, s_inc);
	D : Decrementador port map(s_reg, s_dec);
	S <= s_reg;

end logic;









