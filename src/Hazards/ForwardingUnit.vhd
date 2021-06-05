library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity ForwardingUnit is
  port (
    Rdst : in std_logic_vector(2 downto 0);
    Rsrc : in std_logic_vector(2 downto 0);
    Rdst_old1 : in std_logic_vector(2 downto 0);
    Rdst_old2 : in std_logic_vector(2 downto 0);
    MtoR1 : in std_logic;
    MtoR2 : in std_logic;
    Rsrcnew : out std_logic_vector(1 downto 0) ;
    Rdstnew : out std_logic_vector(1 downto 0) 
  );
end entity ForwardingUnit;
architecture ForwardingUnitarc of ForwardingUnit is
    begin
      Rsrcnew <= "01" when Rsrc = Rdst_old2 and  MtoR1 = '0'else
      "10" when Rsrc = Rdst_old1  and  MtoR2 = '0'else
      "00" ;
      Rdstnew <= "01" when Rdst = Rdst_old2 and  MtoR1 = '0'else
      "10" when (Rdst = Rdst_old1  and  MtoR2 = '0')else
      "00";
end architecture;