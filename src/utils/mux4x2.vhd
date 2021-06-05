LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY mux4x2 IS 
	PORT (
		sel : IN std_logic_vector(1 downto 0); 
		in0,in1,in2 : IN std_logic_vector (31 DOWNTO 0);
		out1 : OUT std_logic_vector (31 DOWNTO 0)
		);
END mux4x2;

ARCHITECTURE with_select_mux4x2 OF mux4x2 is
begin
	With sel select
    out1 <= in0 when "00",
    in1 when "01",
    in2 when "10",
    in0 when others;
END with_select_mux4x2;
