library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity PCData is
  port (
    instruction : in std_logic_vector(31 downto 0);
    PCin : in std_logic_vector(31 downto 0);
    PC : out std_logic_vector(31 downto 0)
  );
end entity PCData;
architecture PCDataarc of PCData is
    component my_nadder IS
    PORT(a, b : IN std_logic_vector(31 DOWNTO 0) ;
            cin : IN std_logic;
            s : OUT std_logic_vector(31 DOWNTO 0);
            cout : OUT std_logic
        );
    END component;
    signal PC16,PC32 : std_logic_vector(31 downto 0);
    signal C16,C32 : std_logic;
    begin
        Inst16 : my_nadder port map(PCin,X"00000001",'0',PC16,C16);
        Inst32 : my_nadder port map(PCin,X"00000002",'0',PC32,C32);
        With instruction(31 downto 27) select
        PC <= PC32 when "01101",
        PC32    when    "10010",
        PC32    when    "10011",
        PC32    when    "10100",
        PC16 when others;
end architecture;