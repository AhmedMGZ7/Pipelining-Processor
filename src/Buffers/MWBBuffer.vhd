library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


Entity MWBBuff is
	port(
    clk, MemoryToRegisterin, RegisterWritein : in std_logic;
	ALUresultin : in std_logic_vector(31 downto 0);
	Rdstin : in std_logic_vector(2 downto 0);
	memory_Data : in std_logic_vector(31 downto 0);
    MemoryToRegister, RegisterWrite : out std_logic;
	ALUresult : out std_logic_vector(31 downto 0);
	Rdst : out std_logic_vector(2 downto 0);
	memory_Data_out : out std_logic_vector(31 downto 0)
	);
end entity;


ARCHITECTURE MWBBuffArc of MWBBuff is 
begin
	process(clk)
	begin
		IF falling_edge(clk) THEN
            MemoryToRegister <= MemoryToRegisterin;
			RegisterWrite <= RegisterWritein;
			ALUresult <= ALUresultin;
            Rdst <= Rdstin;
			memory_Data_out <= memory_Data;
		end if;
	end process;
end ARCHITECTURE;