library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity Execute is
  port (
    clk   : in std_logic;
    reset : in std_logic;
    RsrcValue : in std_logic_vector(31 downto 0);
    RdstValue : in std_logic_vector(31 downto 0);
    Rdst_old : in std_logic_vector(31 downto 0);
    Rdst_old2 : in std_logic_vector(31 downto 0);
    RsrcSelect : in std_logic_vector(1 downto 0);
    RdstSelect : in std_logic_vector(1 downto 0);
    inport_reg : in std_logic_vector(31 downto 0);
    ALU_op : in std_logic_vector(5 downto 0);
    ShiftImmediate : in std_logic;
    Shmat : in std_logic_vector(31 downto 0);
    ImmediateValue : in std_logic_vector(31 downto 0);
    Branch : in std_logic;
    Branched : out std_logic;
    ALUresult : out std_logic_vector(31 downto 0)
  );
end entity Execute;

architecture Executearc of Execute is
  ------components-------------
    component ALU is
    generic (n :integer := 32);
    port (
        rsrc, rdst, inport, shift_immediate,sp_in : in std_logic_vector(n-1 downto 0);
        opCode: in std_logic_vector (5 downto 0);
        result,sp_new : out std_logic_vector (n-1 downto 0);
        fcout, fneg, fzero: out std_logic
    ) ;
    end component;
    component reg IS
	 PORT(
	 	clk : IN std_logic; 
		en : in std_logic;
		reset : in std_logic;
		d : IN std_logic_vector(31 DOWNTO 0);
		q : OUT std_logic_vector(31 DOWNTO 0)
		);
    END component;
    component mux2x1 IS 
	PORT (
		sel : IN std_logic; 
		in0,in1 : IN std_logic_vector (31 DOWNTO 0);
		out1 : OUT std_logic_vector (31 DOWNTO 0)
		);
    END component;
    component mux4x2 IS 
	PORT (
		sel : IN std_logic_vector(1 downto 0); 
		in0,in1,in2 : IN std_logic_vector (31 DOWNTO 0);
		out1 : OUT std_logic_vector (31 DOWNTO 0)
		);
    END component;
    component BranchDecision IS 
	PORT (
            Branch : in std_logic;
            ZeroFlag : in std_logic := '0';
            NegativeFlag : in std_logic := '0';
            CarryFlag : in std_logic := '0';
            ALU_op : in std_logic_vector(5 downto 0);
            Branching : out std_logic
		);
    END component;
    signal SOrImm,RsrcALU,RdstALU,Spin,SPout,ALUR :  std_logic_vector (31 DOWNTO 0);
    signal NotClk ,CarryFlag, NegativeFlag, ZeroFlag , BorNot: std_logic;
    begin
        NotClk <= not clk;
        shiftOrImm : mux2x1 port map(ShiftImmediate,ImmediateValue,Shmat,SOrImm);
        RsrcSetect : mux4x2 port map(RsrcSelect,RsrcValue, Rdst_old2,Rdst_old, RsrcALU);
        RdstSetect : mux4x2 port map(RdstSelect,RdstValue, Rdst_old2,Rdst_old, RdstALU);
        Decision : BranchDecision port map(Branch,ZeroFlag,NegativeFlag,CarryFlag,ALU_op,BorNot);
        SP : reg port map(NotClk, '1', reset,Spin, SPout);
        ALUPart : ALU port map(RsrcALU,RdstALU,inport_reg,SOrImm,SPout,ALU_op,ALUR,Spin,CarryFlag,NegativeFlag,ZeroFlag);
        process(clk)
        begin
            if rising_edge(clk) then
                ALUresult <= ALUR;
            end if;
        end process;
end architecture;
							