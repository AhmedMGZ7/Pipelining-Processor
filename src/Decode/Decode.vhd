
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity Decode is
  port (
    clk   : in std_logic;
    reset : in std_logic;
    instruction : in std_logic_vector(31 downto 0);
    registerWrite : in std_logic;
    writeData : in std_logic_vector(31 downto 0);
    Rdst : in std_logic_vector(2 downto 0); 
    Source1 : out std_logic_vector(31 downto 0);
    Source2 : out std_logic_vector(31 downto 0);
    shamt : out std_logic_vector(31 downto 0);
    immediateValue : out std_logic_vector(31 downto 0);
    controlsignals : out std_logic_vector(12 downto 0)
  );
end entity Decode;

architecture Decodearc of Decode is
  ------components-------------
  component registerFile is
    port (
      clk   : in std_logic;
      reset : in std_logic;
      registerWrite : in std_logic;
      Rsrc1 : in std_logic_vector(2 downto 0);
      Rsrc2 : in std_logic_vector(2 downto 0);--Rdst is a source and also a dest diff that Rdst comes from WB buffer to avoid hazard
      Rdst : in std_logic_vector(2 downto 0);
      writeData : in std_logic_vector(31 downto 0);
      Rsrc1Value : out std_logic_vector(31 downto 0);
      Rsrc2Value : out std_logic_vector(31 downto 0)
    );
  end component;
  -------CU-----------------
  component CU is
    port (
      instruction : in std_logic_vector(31 downto 0);
      signals : out std_logic_vector(12 downto 0)
    );
  end component;
  ---------------------------
  -------signals----------------
  signal Rs1Value,Rs2Value : std_logic_vector(31 downto 0);
  signal signals : std_logic_vector(12 downto 0);
  -----------------------------
  begin
    RegFile : registerFile port map(clk,reset,registerWrite,instruction(26 downto 24), instruction(23 downto 21),Rdst,writeData,Rs1Value,Rs2Value);
    ControlUnit : CU port map(instruction,signals);
    process(clk)
    begin
      if rising_edge(clk) then
        shamt <= (("000000000000000000000000000")&instruction(20 downto 16));
        immediateValue <= (("0000000000000000")&instruction(15 downto 0));
        controlsignals <= signals;
      end if;
    end process;
    Source1 <= Rs1Value;
    Source2 <= Rs2Value;
end architecture;
							