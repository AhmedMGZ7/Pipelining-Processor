LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY BranchDecision IS 
	PORT (
            Branch : in std_logic;
            ZeroFlag : in std_logic := '0';
            NegativeFlag : in std_logic := '0';
            CarryFlag : in std_logic := '0';
            ALU_op : in std_logic_vector(5 downto 0);
            Branching : out std_logic
		);
END BranchDecision;

ARCHITECTURE BranchDecisionarc OF BranchDecision is
begin
	Branching <= '1' when ZeroFlag = '1' and ALU_op(5 downto 1) = "11000"else
    '1' when   NegativeFlag = '1' and   ALU_op(5 downto 1) = "11001"else
    '1' when    CarryFlag = '1' and ALU_op(5 downto 1) = "11010"else
    '1' when ALU_op(5 downto 1) = "11011"else
    '0'   ;
END ARCHITECTURE;
