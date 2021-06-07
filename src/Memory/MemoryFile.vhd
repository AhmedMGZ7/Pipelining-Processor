
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity MemoryFile is
  port (
    clk   : in std_logic;
    reset : in std_logic;
    MemoryRead : in std_logic;
    MemoryWrite : in std_logic;
    ALUresult : in std_logic_vector(31 downto 0);
    RdstValue : in std_logic_vector(31 downto 0);
    data : out std_logic_vector(31 downto 0)
  );
end entity MemoryFile;

architecture MemoryFilearc of MemoryFile is
    component memram is
      port(
        clk : in std_logic;
        en : in std_logic;
        we  : in std_logic;
        address : in  std_logic_vector(31 downto 0);
        datain  : in  std_logic_vector(31 downto 0);
        dataout : out std_logic_vector(31 downto 0)
        );
    end component;
    signal dataout : std_logic_vector(31 downto 0);
    signal enable : std_logic;
    begin
    enable <= MemoryWrite or MemoryRead;
    ram_inst_Data: memram port map(clk,enable, MemoryWrite , ALUresult, RdstValue, dataout);
    data <= dataout when MemoryRead = '1'else
    (others => '0');
end architecture;
							