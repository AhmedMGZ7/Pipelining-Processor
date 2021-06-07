library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity load_use_detection is
  port (
    Rdstold : in std_logic_vector(2 downto 0);
    branch : in std_logic;
    memory_read : in std_logic;
    Rsrc : in std_logic_vector(2 downto 0); 
    Rdst : in std_logic_vector(2 downto 0);
    PC_write : out std_logic;
    enable : out std_logic;
    fl : out std_logic
  );
end entity load_use_detection;
architecture load_use_detectionarc of load_use_detection is
    begin
      ---------------PC_write-----------------
      ---------------load use-----------------
      PC_write <= '0' when memory_read = '1' and (Rsrc = Rdstold or Rdst = Rdstold)else
      '1';
      ---------------control hazard------------
      -----------------------------------------
      ---------------fl-----------------------
      enable <= '0' when memory_read = '1' and (Rsrc = Rdstold or Rdst = Rdstold) else
      '1';
      ----------------------------------------
end architecture;