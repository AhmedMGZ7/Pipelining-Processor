-- TODO  Fetch write from beginning 
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity fetch is
  port (
    clk   : in std_logic;
    reset : in std_logic;
    PC_write : in std_logic;
    PC_Address : in std_logic_vector(31 downto 0);
    Branch : in std_logic := '0';
    PCUpdated : out std_logic_vector(31 downto 0);
    Instruction : out std_logic_vector(31 downto 0)
  );
end entity fetch;

architecture fetcharc of fetch is
  component ram is
    port (
      clk     : in std_logic;
      reset : in std_logic;
      en  : in std_logic;
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
  component PCData is
    port (
      instruction : in std_logic_vector(31 downto 0);
      PCin : in std_logic_vector(31 downto 0);
      PC : out std_logic_vector(31 downto 0)
    );
  end component;
  component mux2x1 IS 
	PORT (
		sel : IN std_logic; 
		in0,in1 : IN std_logic_vector (31 DOWNTO 0);
		out1 : OUT std_logic_vector (31 DOWNTO 0)
		);
    END component;
  signal PCdatain,PCdataOut,indata,instructionout : std_logic_vector(31 downto 0);
  signal PCnew : std_logic_vector(31 downto 0);
  signal clk_pc : std_logic;
  signal PCin : std_logic_vector(31 downto 0);
  begin
    clk_pc <= not clk;
    PCin <= instructionout when reset = '1'
    else PCdatain;
    PCmux : mux2x1 port map (Branch,PCnew,PC_Address,PCdatain);
    PC: reg port map (clk_pc,PC_write,'0',PCin,PCdataOut);
    PCINcrement : PCData port map (instructionout,PCdataOut,PCnew);
    ram_inst: ram port map(clk,reset,'1', '0', PCdataOut, indata, instructionout);
    process(clk)
    begin
      if rising_edge(clk) then
      PCUpdated <= PCnew;
      Instruction <= instructionout;
      end if;
    end process;
end architecture;
							