library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


Entity FDBuff is
	port(
    clk, MemoryToRegisterin, RegisterWritein : in std_logic;
	ALUresultin : in std_logic_vector(31 downto 0);
	Rdstin : in std_logic_vector(2 downto 0);
    MemoryToRegister, RegisterWrite : in std_logic;
	ALUresult : in std_logic_vector(31 downto 0);
	Rdst : in std_logic_vector(2 downto 0)
	);
end entity;


ARCHITECTURE FDBuffArc of FDBuff is 
begin
	process(clk)
	begin
		IF rising_edge(clk) THEN
            MemoryToRegister <= MemoryToRegisterin;
			RegisterWrite <= RegisterWritein;
			ALUresult <= ALUresultin;
            Rdst <= Rdstin;
		end if;
	end process;
end ARCHITECTURE;