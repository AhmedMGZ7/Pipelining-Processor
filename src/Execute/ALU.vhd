library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity ALU is
    generic (n :integer := 32);
    port (
        rsrc, rdst, inport, shift_immediate,sp_in : in std_logic_vector(n-1 downto 0);
        flag_reg : in std_logic_vector(2 downto 0);
        opCode: in std_logic_vector (5 downto 0);
        result,sp_new : out std_logic_vector (n-1 downto 0);
        fcout, fneg, fzero: out std_logic
    ) ;
end ALU;

architecture ALUarc of ALU is
  signal temp_cout, temp_neg, temp_zero:  std_logic;
  signal shift_left_result,shift_right_result,add_result,sub_result,iadd_result : std_logic_vector (n downto 0);
  signal rsrc_tow_complement,rdst_tow_complement, temp_result : std_logic_vector (n-1 downto 0);

    begin

      -- calculating the result
      result <= temp_result;
      lblResult: temp_result <= (others => '0' ) when (opCode(5 downto 0) = "000000") -- NOP
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
      else (add_result(n-1 downto 0)) when (opCode(5 downto 0) = "010010") -- Add rdst
      else (add_result(n-1 downto 0)) when (opCode(5 downto 0) = "010011") -- Add rdst
      else (sub_result(n-1 downto 0)) when (opCode(5 downto 0) = "010100") -- SUB rdst
      else (sub_result(n-1 downto 0)) when (opCode(5 downto 0) = "010101") -- SUB rdst
      else (rdst and rsrc) when (opCode(5 downto 0) = "010110") -- AND rdst
      else (rdst and rsrc) when (opCode(5 downto 0) = "010111") -- AND rdst
      else (rdst or rsrc) when (opCode(5 downto 0) = "011000") -- OR rdst
      else (rdst or rsrc) when (opCode(5 downto 0) = "011001") -- OR rdst
      else (rdst+shift_immediate) when (opCode(5 downto 0) = "011010") -- IAdd rdst
      else (rdst+shift_immediate) when (opCode(5 downto 0) = "011011") -- IAdd rdst
      else (shift_left_result(n-1 downto 0)) when (opCode(5 downto 0) = "011100") -- SHL rdst
      else (shift_left_result(n-1 downto 0)) when (opCode(5 downto 0) = "011101") -- SHL rdst
      else (shift_right_result(n downto 1)) when (opCode(5 downto 0) = "011110") -- SHR rdst
      else (shift_right_result(n downto 1)) when (opCode(5 downto 0) = "011111") -- SHR rdst
      else (rdst(30 downto 0)&flag_reg(0)) when (opCode(5 downto 0) = "001010") -- RLC rdst
      else (flag_reg(0) & rdst(31 downto 1)) when (opCode(5 downto 0) = "001011") -- RRC rdst
      else (sp_in) when (opCode(5 downto 0) = "100000") -- push rdst
      else (sp_in+2) when (opCode(5 downto 0) = "100010") -- pop rdst
      else (shift_immediate) when (opCode(5 downto 0) = "100100") -- LDM rdst
      else (rsrc + shift_immediate) when (opCode(5 downto 0) = "100110") -- LDD rdst
      else (rsrc + shift_immediate) when (opCode(5 downto 0) = "101000") -- STD rdst
      else (others => '0');

      lblStackPointer : sp_new <= sp_in-2 when (opCode(5 downto 0) = "100000")
      else sp_in+2 when (opCode(5 downto 0) = "100010")
      else (others => '0');

      -- the shift left and right
      lblShiftLef: shift_left_result <=  std_logic_vector(shift_left(unsigned('0' & rdst), to_integer(unsigned(shift_immediate))));
      lblShiftRight: shift_right_result <=  std_logic_vector(shift_right(unsigned(rdst & '0'), to_integer(unsigned(shift_immediate))));

      -- add and subtract
      -- rsrc_tow_complement <= not(rsrc)+1;
      rdst_tow_complement <= not(rdst)+1;
      add_result <= '0' & rdst + rsrc;
      -- sub_result <= '0' & rdst + rsrc_tow_complement;
      sub_result <= '0' & rsrc + rdst_tow_complement;
      iadd_result <= '0' & rdst + shift_immediate;
      
      -- zero flag
      temp_zero <= ('1') when (temp_result = 0)
      else ('0');


      -- calculating the carry
      fcout <= temp_cout;
      lblCarry: temp_cout <= flag_reg(0) when (opCode(5 downto 0) = "000000") -- NOP
      else ('1') when (opCode(5 downto 0) = "000001") -- setC
      else ('0') when (opCode(5 downto 0) = "000010") -- CLRC
      else ('0') when (opCode(5 downto 0) = "001111") -- CLR rdst
      else ('0') when (opCode(5 downto 0) = "000100") -- NOT rdst
      else ('0') when (opCode(5 downto 0) = "000101") -- inc rdst
      else ('0') when (opCode(5 downto 0) = "000110") -- dec rdst
      else ('0') when (opCode(5 downto 0) = "000111") -- NEG rdst
      else ('0') when (opCode(5 downto 0) = "001000") -- OUT rdst
      else ('0') when (opCode(5 downto 0) = "001101") -- IN rdst
      else ('0') when (opCode(5 downto 0) = "010000") -- MOV rdst
      else (add_result(n)) when (opCode(5 downto 0) = "010010") -- Add rdst
      else (sub_result(n)) when (opCode(5 downto 0) = "010100") -- SUB rdst
      else ('0') when (opCode(5 downto 0) = "010110") -- AND rdst
      else ('0') when (opCode(5 downto 0) = "011000") -- OR rdst
      else (iadd_result(n)) when (opCode(5 downto 0) = "011010") -- IAdd rdst
      else (shift_left_result(n)) when (opCode(5 downto 0) = "011100") -- SHL rdst
      else (shift_left_result(0)) when (opCode(5 downto 0) = "011110") -- SHR rdst
      else (rdst(n-1)) when (opCode(5 downto 0) = "001010") -- RLC rdst
      else (rdst(0)) when (opCode(5 downto 0) = "001011") -- RRC rdst
      else ('0') when (opCode(5 downto 0) = "100000") -- push rdst
      else ('0') when (opCode(5 downto 0) = "100010") -- pop rdst
      else ('0') when (opCode(5 downto 0) = "100100") -- LDM rdst
      else ('0') when (opCode(5 downto 0) = "100110") -- LDD rdst
      else ('0') when (opCode(5 downto 0) = "101000") -- STD rdst
      else ( '0');

      -- calculating the zero
      lblZero: fzero <= flag_reg(2) when (opCode(5 downto 0) = "000000") -- NOP
      else ('0') when (opCode(5 downto 0) = "000001") -- setC
      else ('0') when (opCode(5 downto 0) = "000010") -- CLRC
      else ('1') when (opCode(5 downto 0) = "001111") -- CLR rdst
      else (temp_zero) when (opCode(5 downto 0) = "000100") -- NOT rdst
      else (temp_zero) when (opCode(5 downto 0) = "000101") -- inc rdst
      else (temp_zero) when (opCode(5 downto 0) = "000110") -- dec rdst
      else (temp_zero) when (opCode(5 downto 0) = "000111") -- NEG rdst
      else ('0') when (opCode(5 downto 0) = "001000") -- OUT rdst
      else ('0') when (opCode(5 downto 0) = "001101") -- IN rdst
      else ('0') when (opCode(5 downto 0) = "010000") -- MOV rdst
      else (temp_zero) when (opCode(5 downto 0) = "010010") -- Add rdst
      else (temp_zero) when (opCode(5 downto 0) = "010100") -- SUB rdst
      else (temp_zero) when (opCode(5 downto 0) = "010110") -- AND rdst
      else (temp_zero) when (opCode(5 downto 0) = "011000") -- OR rdst
      else (temp_zero) when (opCode(5 downto 0) = "011010") -- IAdd rdst
      else ('0') when (opCode(5 downto 0) = "011100") -- SHL rdst
      else ('0') when (opCode(5 downto 0) = "011110") -- SHR rdst
      else ('0') when (opCode(5 downto 0) = "001010") -- RLC rdst
      else ('0') when (opCode(5 downto 0) = "001011") -- RRC rdst
      else ('0') when (opCode(5 downto 0) = "100000") -- push rdst
      else ('0') when (opCode(5 downto 0) = "100010") -- pop rdst
      else ('0') when (opCode(5 downto 0) = "100100") -- LDM rdst
      else ('0') when (opCode(5 downto 0) = "100110") -- LDD rdst
      else ('0') when (opCode(5 downto 0) = "101000") -- STD rdst
      else ( '0');

      -- calculating the negative
      lblNeg: fneg <= flag_reg(1) when (opCode(5 downto 0) = "000000") -- NOP
      else ('0') when (opCode(5 downto 0) = "000001") -- setC
      else ('0') when (opCode(5 downto 0) = "000010") -- CLRC
      else ('0') when (opCode(5 downto 0) = "001111") -- CLR rdst
      else (temp_result(n-1)) when (opCode(5 downto 0) = "000100") -- NOT rdst
      else (temp_result(n-1)) when (opCode(5 downto 0) = "000101") -- inc rdst
      else (temp_result(n-1)) when (opCode(5 downto 0) = "000110") -- dec rdst
      else (temp_result(n-1)) when (opCode(5 downto 0) = "000111") -- NEG rdst
      else ('0') when (opCode(5 downto 0) = "001000") -- OUT rdst
      else ('0') when (opCode(5 downto 0) = "001101") -- IN rdst
      else ('0') when (opCode(5 downto 0) = "010000") -- MOV rdst
      else (temp_result(n-1)) when (opCode(5 downto 0) = "010010") -- Add rdst
      else (temp_result(n-1)) when (opCode(5 downto 0) = "010100") -- SUB rdst
      else (temp_result(n-1)) when (opCode(5 downto 0) = "010110") -- AND rdst
      else (temp_result(n-1)) when (opCode(5 downto 0) = "011000") -- OR rdst
      else (temp_result(n-1)) when (opCode(5 downto 0) = "011010") -- IAdd rdst
      else ('0') when (opCode(5 downto 0) = "011100") -- SHL rdst
      else ('0') when (opCode(5 downto 0) = "011110") -- SHR rdst
      else ('0') when (opCode(5 downto 0) = "001010") -- RLC rdst
      else ('0') when (opCode(5 downto 0) = "001011") -- RRC rdst
      else ('0') when (opCode(5 downto 0) = "100000") -- push rdst
      else ('0') when (opCode(5 downto 0) = "100010") -- pop rdst
      else ('0') when (opCode(5 downto 0) = "100100") -- LDM rdst
      else ('0') when (opCode(5 downto 0) = "100110") -- LDD rdst
      else ('0') when (opCode(5 downto 0) = "101000") -- STD rdst
      else ( '0');

  end architecture;