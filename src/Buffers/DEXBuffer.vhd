library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


Entity DEXBuffer is
	port(
	clk : in std_logic; 
    enable : in std_logic;
	PCin : in std_logic_vector(31 downto 0);
	Rsrc1Valuein : in std_logic_vector(31 downto 0);
	Rsrc2Valuein : in std_logic_vector(31 downto 0);
	immediateValuein : in std_logic_vector(31 downto 0);
	shmatin : in std_logic_vector(31 downto 0);
    Rsrcin : in std_logic_vector(2 downto 0);
    Rdstin : in std_logic_vector(2 downto 0);
    in_portin : in std_logic_vector(31 downto 0);
    controlsignals : in std_logic_vector(12 downto 0);
    PC : out std_logic_vector(31 downto 0);
	Rsrc1Value : out std_logic_vector(31 downto 0);
	Rsrc2Value : out std_logic_vector(31 downto 0);
	immediateValue : out std_logic_vector(31 downto 0);
	shmat : out std_logic_vector(31 downto 0);
    Rsrc : out std_logic_vector(2 downto 0);
    Rdst : out std_logic_vector(2 downto 0);
    in_port : out std_logic_vector(31 downto 0);
    ALU_Op : out std_logic_vector(5 downto 0);
    Imm_Shift : out std_logic;
    Branch : out std_logic;
    Memory_Read : out std_logic;
    Memory_Write : out std_logic;
    Register_Write  : out std_logic;
    MemoryToRegister : out std_logic;
    out_port : out std_logic
	);
end entity;


ARCHITECTURE DEXBufferArc of DEXBuffer is 
begin
	process(clk)
	begin
		IF falling_edge(clk)THEN
        PC <= PCin; 
        Rsrc1Value <= Rsrc1Valuein ;
        Rsrc2Value <= Rsrc2Valuein ;
        immediateValue <= immediateValuein;
        shmat <= shmatin;
        Rsrc <= Rsrcin;
        Rdst <= Rdstin;
        in_port <= in_portin;
        if enable = '0' then
            ALU_Op <= "000000";
            Imm_Shift <= '0';
            Branch <= '0';
            Memory_Read <= '0';
            Memory_Write <= '0';
            Register_Write  <= '0';
            MemoryToRegister <= '0';
            out_port <= '0';
        else
            ALU_Op <= controlsignals(12 downto 7);
            Imm_Shift <= controlsignals(6);
            Branch <= controlsignals(5);
            Memory_Read <= controlsignals(4);
            Memory_Write <= controlsignals(3);
            Register_Write  <= controlsignals(2);
            MemoryToRegister <= controlsignals(1);
            out_port <= controlsignals(0);
        end if;
		end if;
	end process;
end ARCHITECTURE;