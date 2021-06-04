library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity CU is
  port (
    instruction : in std_logic_vector(31 downto 0);
    signals : out std_logic_vector(12 downto 0)
  );
end entity CU;

architecture CUarc of CU is
    signal Imm_Shift ,Branch, Memory_Read, Memory_Write,Register_Write, MemoryToRegister ,   out_port : std_logic;
    signal ALU_Op : std_logic_vector(5 downto 0);
    begin
        ALU_Op <= instruction(31 downto 26);

        With instruction(31 downto 27) select
        Imm_Shift <= '1' when "01110",
        '1' when "01111",
        '0' when others;

        With instruction(31 downto 30) select
        Branch <= '1' when "11",
        '0' when others;

        With instruction(31 downto 27) select
        Memory_Read <= '1' when "10001",
        '1' when "10011",
        '1' when "11101",
        '1' when "11110",
        '0' when others;

        With instruction(31 downto 27) select
        Memory_Write <= '1' when "10000",
        '1' when "10100",
        '0' when others;

        With instruction(31 downto 27) select
        Register_Write <= '0' when "00000",
        '0' when "00001",
        '0' when "00100",
        '0' when "10000",
        '0' when "10100",
        '0' when "11000",
        '0' when "11001",
        '0' when "11010",
        '0' when "11011",
        '0' when "11100",
        '0' when "11101",
        '0' when "11110",
        '1' when others;

        With instruction(31 downto 27) select
        MemoryToRegister <= '1' when "10001",
        '1' when "10011",
        '0' when others;

        With instruction(31 downto 26) select
        out_port <= '1' when "001000",
        '0' when others;

        signals <= (ALU_Op & Imm_Shift & Branch & Memory_Read & Memory_Write & Register_Write & MemoryToRegister & out_port);
end architecture;