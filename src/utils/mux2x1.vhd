LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY mux2x1 IS 
	PORT (
		sel : IN std_logic; 
		in0,in1 : IN std_logic_vector (31 DOWNTO 0);
		out1 : OUT std_logic_vector (31 DOWNTO 0)
		);
END mux2x1;

ARCHITECTURE with_select_mux OF mux2x1 is
begin
	With sel select
    out1 <= in0 when '0',
    in1 when others;
END with_select_mux;
