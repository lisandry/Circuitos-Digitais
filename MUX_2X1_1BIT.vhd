library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2x1_l is
    Port (
        A, B : in  STD_LOGIC;
        C    : in  STD_LOGIC;
        Y    : out STD_LOGIC
    );
end mux_2x1_l;

architecture mux_2x1_l of mux_2x1_l is
begin
    Y <= (not C and A) or (C and B);
end mux_2x1_l;
