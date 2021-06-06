
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity registerFile is
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
end entity registerFile;

architecture registerFilearc of registerFile is
  component reg is
    port (
      clk : in std_logic;
      en  : in std_logic;
      reset : in std_logic;
      d   : in std_logic_vector(31 downto 0);
      q   : out std_logic_vector(31 downto 0) := (others => '0')
    );
  end component;
  signal R0data,R1data,R2data,R3data,R4data,R5data,R6data,R7data : std_logic_vector(31 downto 0); 
  signal R0dataOut,R1dataOut,R2dataOut,R3dataOut,R4dataOut,R5dataOut,R6dataOut,R7dataOut : std_logic_vector(31 downto 0); 
  signal Rsrc1ValueS, Rsrc2ValueS : std_logic_vector(31 downto 0); 
  signal not_clk : std_logic;
  begin
    not_clk <= not clk;
    --------registers------------------
    R0 : reg port map (clk,'1',reset,R0data,R0dataOut);
    R1 : reg port map (clk,'1',reset,R1data,R1dataOut);
    R2 : reg port map (clk,'1',reset,R2data,R2dataOut);
    R3 : reg port map (clk,'1',reset,R3data,R3dataOut);
    R4 : reg port map (clk,'1',reset,R4data,R4dataOut);
    R5 : reg port map (clk,'1',reset,R5data,R5dataOut);
    R6 : reg port map (clk,'1',reset,R6data,R6dataOut);
    R7 : reg port map (clk,'1',reset,R7data,R7dataOut);
    --------------------------------------
    --------getting values of sources--------------
    With Rsrc1 select
    Rsrc1ValueS <= R0dataOut when "000",
    R1dataOut when "001",
    R2dataOut when "010",
    R3dataOut when "011",
    R4dataOut when "100",
    R5dataOut when "101",
    R6dataOut when "110",
    R7dataOut when "111",
    (others => '0') when others;
    With Rsrc2 select
    Rsrc2ValueS <= R0dataOut when "000",
    R1dataOut when "001",
    R2dataOut when "010",
    R3dataOut when "011",
    R4dataOut when "100",
    R5dataOut when "101",
    R6dataOut when "110",
    R7dataOut when "111",
    (others => '0') when others;

    R0data <= writeData when Rdst = "000" and registerWrite = '1'else
    R0dataOUT;
    R1data <= writeData when Rdst = "001" and registerWrite = '1'else
    R1dataOUT;
    R2data <= writeData when Rdst = "010" and registerWrite = '1'else
    R2dataOUT;
    R3data <= writeData when Rdst = "011" and registerWrite = '1'else
    R3dataOUT;
    R4data <= writeData when Rdst = "100" and registerWrite = '1'else
    R4dataOUT;
    R5data <= writeData when Rdst = "101" and registerWrite = '1'else
    R5dataOUT;
    R6data <= writeData when Rdst = "110" and registerWrite = '1'else
    R6dataOUT;
    R7data <= writeData when Rdst = "111" and registerWrite = '1'else
    R7dataOUT;
    -- process(clk)
    -- begin
    --   if rising_edge(clk) then
    --     Rsrc1Value <= Rsrc1ValueS;
    --     Rsrc2Value <= Rsrc2ValueS;
    --   end if;
    -- end process;
    Rsrc1Value <= Rsrc1ValueS;
    Rsrc2Value <= Rsrc2ValueS;
end architecture;
							