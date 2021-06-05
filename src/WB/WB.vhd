-- todo 3adel el mux shelt mno el clk
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity WB is
  port (
    clk, RegisterWrite : in std_logic;
    MemoryResult, ALUreslt   : in std_logic_vector(31 downto 0);
    WriteData : out std_logic_vector(31 downto 0)
  );
end entity WB;
architecture WBarc of WB is
    component mux2x1 IS 
	PORT (
		clk,sel : IN std_logic; 
		in0,in1 : IN std_logic_vector (31 DOWNTO 0);
		out1 : OUT std_logic_vector (31 DOWNTO 0)
		);
    END component;
    signal Data : std_logic_vector(31 downto 0);
    begin
        WBMUX: mux2x1 port map(clk , MemoryToRegister, ALUreslt,MemoryResult, Data);
        WriteData <= Data;
end architecture;