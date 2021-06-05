LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY reg IS
	 PORT(
	 	clk : IN std_logic; 
		en : in std_logic;
		reset : in std_logic;
		d : IN std_logic_vector(31 DOWNTO 0);
		q : OUT std_logic_vector(31 DOWNTO 0)
		);
END reg;

ARCHITECTURE reg_1 OF reg IS
BEGIN
	PROCESS(clk)
	BEGIN
		IF rising_edge(clk) and en = '1' and reset = '0' THEN     
			q <= d;
		END IF;
		if rising_edge(clk) and reset = '1' then
			q <= (others => '0');
		end if;
	END PROCESS;
END reg_1;


