Mlibrary ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


Entity EXMBuffer is
	port(
        Clk : in std_logic;
        ALUresultin : in std_logic_vector(31 downto 0);
        CCRin : in std_logic_vector(2 downto 0);
        PCin : in std_logic_vector(31 downto 0);
        RdstValuein : in std_logic_vector(31 downto 0);
        Rdstin : in std_logic_vector(2 downto 0);
        MemoryToRegisterin : in std_logic;
        RegisterWritein : in std_logic;
        Memory_Readin : in std_logic;
        Memory_Writein : in std_logic;
        out_portin : in std_logic;
        ALUresult : out std_logic_vector(31 downto 0);
        CCR : out std_logic_vector(2 downto 0);
        PC : out std_logic_vector(31 downto 0);
        RdstValue : out std_logic_vector(31 downto 0);
        Rdst : out std_logic_vector(2 downto 0);
        MemoryToRegister : out std_logic;
        RegisterWrite : out std_logic;
        Memory_Read : out std_logic;
        Memory_Write : out std_logic;
        out_port : out std_logic
	);
end entity;


ARCHITECTURE EXMBufferArc of EXMBuffer is 
begin
    process(clk)
	begin
		IF falling_edge(clk) THEN
            ALUresult <= ALUresultin;
            CCR <= CCRin;
            PC <= PCin;
            RdstValue <= RdstValuein;
            Rdst <= Rdstin;
            MemoryToRegister <= MemoryToRegisterin;
            RegisterWrite <= RegisterWritein;
            Memory_Read <= Memory_Readin;
            Memory_Write <= Memory_Writein;
            out_port <= out_portin;
        end if;
    end process;
end ARCHITECTURE;