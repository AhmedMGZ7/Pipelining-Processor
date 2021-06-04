library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity Memory is
  port (
    clkin   : in std_logic;
    resetin : in std_logic;
    MemoryReadin : in std_logic;
    MemoryWritein : in std_logic;
    ALUresultin : in std_logic_vector(31 downto 0);
    RdstValuein : in std_logic_vector(31 downto 0);
    outPortSignal : in std_logic;
    dataOut : out std_logic_vector(31 downto 0)
  );
end entity Memory;

architecture Memoryarc of Memory is
    component MemoryFile is
        port (
          clk   : in std_logic;
          reset : in std_logic;
          MemoryRead : in std_logic;
          MemoryWrite : in std_logic;
          ALUresult : in std_logic_vector(31 downto 0);
          RdstValue : in std_logic_vector(31 downto 0);
          data : out std_logic_vector(31 downto 0)
        );
      end component;
    component reg is
        port (
          clk : in std_logic;
          en  : in std_logic;
          reset : in std_logic;
          d   : in std_logic_vector(31 downto 0);
          q   : out std_logic_vector(31 downto 0) := (others => '0')
        );
    end component;

    signal dataoutS : std_logic_vector(31 downto 0);
    signal out_port_reg_out : std_logic_vector(31 downto 0);
    begin
    OUTPORT : reg port map (clkin,outPortSignal,'0',ALUresultin,out_port_reg_out);
    MemFile : MemoryFile port map (clkin,resetin,MemoryReadin, MemoryWritein, ALUresultin, RdstValuein , dataoutS);
    dataOut <= dataoutS;
end architecture;
							
							