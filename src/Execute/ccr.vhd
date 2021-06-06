LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY ccr IS
	 PORT(
	 	clk : IN std_logic; 
		en : in std_logic;
		reset : in std_logic;
		d : IN std_logic_vector(2 DOWNTO 0) := "000";
		q : OUT std_logic_vector(2 DOWNTO 0)
		);
END ccr;

ARCHITECTURE ccrarc OF ccr IS
BEGIN
	PROCESS(clk)
	BEGIN
		IF falling_edge(clk) and en = '1' and reset = '0' THEN     
			q <= d;
		END IF;
		if rising_edge(clk) and reset = '1' then
			q <= (others => '0');
		end if;
	END PROCESS;
END ARCHITECTURE;


