LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY mux2x1 IS 
	PORT (
		clk,sel : IN std_logic; 
		in0,in1 : IN std_logic_vector (31 DOWNTO 0);
		out1 : OUT std_logic_vector (31 DOWNTO 0)
		);
END mux2x1;

ARCHITECTURE with_select_mux OF mux2x1 is
	BEGIN
	process(clk)
	begin
		if rising_edge(clk) then
			if sel = '0' then
				out1 <= in0;
			else
				out1 <= in1;
			end if;
		end if;
	end process;
END with_select_mux;
