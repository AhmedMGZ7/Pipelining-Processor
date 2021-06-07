library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


Entity FDBuff is
	port(
	clk : in std_logic; 
	enable : in std_logic;
	PC : in std_logic_vector(31 downto 0);
	instruction : in std_logic_vector(31 downto 0);
	in_port : in std_logic_vector(31 downto 0);
	PCout : out std_logic_vector(31 downto 0);
	instructionOut : out std_logic_vector(31 downto 0);
	in_portOut : out std_logic_vector(31 downto 0)
	);
end entity;


ARCHITECTURE FDBuffArc of FDBuff is 
begin
	process(clk)
	begin
		IF falling_edge(clk) and enable = '1' THEN
			PCout <= PC;
			instructionOut <= instruction;
			in_portOut <= in_port;
		end if;
	end process;
end ARCHITECTURE;