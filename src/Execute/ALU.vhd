library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity ALU is
    generic (n :integer := 32);
    port (
        rsrc, rdst, inport, shift_immediate,sp_in : in std_logic_vector(n-1 downto 0);
        opCode: in std_logic_vector (5 downto 0);
        result,sp_new : out std_logic_vector (n-1 downto 0);
        fcout, fneg, fzero: out std_logic
    ) ;
end ALU;

architecture ALUarc of ALU is
  signal temp_cout, temp_neg, temp_zero:  std_logic;

    begin

      -- calculating the result
      lblResult: result <= (others => '0' ) when (opCode(5 downto 0) = "000000") -- NOP
      else (others => '0' ) when (opCode(5 downto 0) = "000001") -- setC
      else (others => '0' ) when (opCode(5 downto 0) = "000010") -- CLRC
      else (others => '0' ) when (opCode(5 downto 0) = "001111") -- CLR rdst
      else (not(rdst)) when (opCode(5 downto 0) = "000100") -- NOT rdst
      else (rdst+1) when (opCode(5 downto 0) = "000101") -- inc rdst
      else (rdst-1) when (opCode(5 downto 0) = "000110") -- dec rdst
      else (not(rdst)+1) when (opCode(5 downto 0) = "000111") -- NEG rdst
      else (rdst) when (opCode(5 downto 0) = "001000") -- OUT rdst
      else (inport) when (opCode(5 downto 0) = "001101") -- IN rdst
      else (rsrc) when (opCode(5 downto 0) = "010000") -- MOV rdst
      else (rdst+rsrc) when (opCode(5 downto 0) = "010010") -- Add rdst
      else (rdst-rsrc) when (opCode(5 downto 0) = "010100") -- SUB rdst
      else (rdst and rsrc) when (opCode(5 downto 0) = "010110") -- AND rdst
      else (rdst or rsrc) when (opCode(5 downto 0) = "011000") -- OR rdst
      else (rdst+shift_immediate) when (opCode(5 downto 0) = "011010") -- IAdd rdst
      -- else (rsrc << shift_immediate) when (opCode(5 downto 0) = "011100") -- SHL rdst
      -- else (rsrc >> shift_immediate) when (opCode(5 downto 0) = "011110") -- SHR rdst
      -- else ( shift_left(rsrc, 2) ) when (opCode(5 downto 0) = "011100") -- SHL rdst
      -- else (rsrc sll shift_immediate) when (opCode(5 downto 0) = "011110") -- SHR rdst
      else (rdst(30 downto 0)&temp_cout) when (opCode(5 downto 0) = "001010") -- RLC rdst
      else (temp_cout & rdst(31 downto 1)) when (opCode(5 downto 0) = "001011") -- RRC rdst
      else (sp_in) when (opCode(5 downto 0) = "100000") -- push rdst
      else (sp_in+2) when (opCode(5 downto 0) = "100010") -- pop rdst
      else (shift_immediate) when (opCode(5 downto 0) = "100100") -- LDM rdst
      else (rsrc + shift_immediate) when (opCode(5 downto 0) = "100110") -- LDD rdst
      else (rsrc + shift_immediate) when (opCode(5 downto 0) = "101000") -- STD rdst
      else (others => '0');

      lblStackPointer : sp_new <= sp_in-2 when (opCode(5 downto 0) = "100000")
      else sp_in+2 when (opCode(5 downto 0) = "100010")
      else (others => '0');



end architecture;