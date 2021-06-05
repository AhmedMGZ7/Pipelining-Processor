library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity CPU is
  port (
    clk : in std_logic;
    reset : in std_logic
  );
end entity CPU;
architecture CPUarc of CPU is
    component fetch is
        port (
          clk   : in std_logic;
          reset : in std_logic;
          PC_write : in std_logic;
          PC_Address : in std_logic_vector(31 downto 0);
          Branch : in std_logic;
          PCUpdated : out std_logic_vector(31 downto 0);
          Instruction : out std_logic_vector(31 downto 0)
        );
    end component;
    component Decode is
        port (
          clk   : in std_logic;
          reset : in std_logic;
          instruction : in std_logic_vector(31 downto 0);
          registerWrite : in std_logic;
          writeData : in std_logic_vector(31 downto 0);
          Source1 : out std_logic_vector(31 downto 0);
          Source2 : out std_logic_vector(31 downto 0);
          shamt : out std_logic_vector(31 downto 0);
          immediateValue : out std_logic_vector(31 downto 0);
          controlsignals : out std_logic_vector(12 downto 0)
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
    signal registerWrite : std_logic;
    signal writeData : std_logic_vector(31 downto 0);
    signal PC_writeS , BranchS : std_logic;
    signal PCUpdatedS, PC_AddressS, InstructionS, in_portS, PCoutS, instructionOutS, in_portOutS : std_logic_vector(31 downto 0);
    signal Source1S, Source2S, shamtS, immediateValueS : std_logic_vector(31 downto 0);
    signal controlsignalsS : std_logic_vector(12 downto 0);
    begin
        FetchStage : fetch port map(clk, reset, PC_writeS, PC_AddressS, BranchS, PCUpdatedS, InstructionS);
        Fetch_Decode_Buffer: FDBuff port map(clk, PCUpdatedS, InstructionS, in_portS, PCoutS, instructionOutS, in_portOutS); 
        DecodeStage : Decode port map (clk, reset, instructionOutS,registerWrite,writeData, Source1S, Source2S, shamtS, immediateValueS, controlsignalsS);
end architecture;