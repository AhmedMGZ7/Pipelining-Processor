
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity CPU is
  port (
    clk   : in std_logic;
    reset : in std_logic
  );
end entity CPU;

architecture CPUarc of CPU is
  component ram is
    port (
      clk     : in std_logic;
      we      : in std_logic;
      address : in std_logic_vector(31 downto 0);
      datain  : in std_logic_vector(31 downto 0);
      dataout : out std_logic_vector(31 downto 0)
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
  component FDBuff is
    port(
	    clk : in std_logic; 
	    PC : in std_logic_vector(31 downto 0);
	    instruction : in std_logic_vector(31 downto 0);
	    in_port : in std_logic_vector(31 downto 0);
	    PCout : out std_logic_vector(31 downto 0);
	    instructionOut : out std_logic_vector(31 downto 0);
	    in_portOut : out std_logic_vector(31 downto 0)
	);
  end component;
  signal PCdata1,indata,instruction,PcBuf,portinbuf,portin,instructionout : std_logic_vector(31 downto 0);
  begin
    PC: reg port map (clk,'1',reset,PCdata1,PCdata1);
    in_port: reg port map (clk,'1',reset,portin,portin);
    ram_inst: ram port map(clk, '0', PCdata1, indata, instruction);
    fetchDecodeBuffer : FDBuff port map(clk, PCdata1,portin, instruction, PcBuf, portinbuf, instructionout);
end architecture;
							