LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY sp IS
	 PORT(
	 	clk : IN std_logic; 
		en : in std_logic;
		reset : in std_logic;
		d : IN std_logic_vector(31 DOWNTO 0);
		q : OUT std_logic_vector(31 DOWNTO 0)
		);
END sp;

ARCHITECTURE sp_1 OF sp IS
BEGIN
	PROCESS(clk)
	BEGIN
		IF rising_edge(clk) and en = '1' and reset = '0' THEN     
			q <= d;
		END IF;
        IF rising_edge(clk) and reset = '1' then
            q <= X"000FFFFE";
        end if;
	END PROCESS;
END sp_1;


