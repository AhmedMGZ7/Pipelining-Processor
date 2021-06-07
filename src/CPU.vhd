library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity CPU is
  port (
    clk : in std_logic;
    reset : in std_logic;
    in_port_register : in std_logic_vector(31 downto 0)
  );
end entity CPU;
architecture CPUarc of CPU is
    component fetch is
        port (
          clk   : in std_logic;
          reset : in std_logic;
          PC_write : in std_logic;
          PC_Address : in std_logic_vector(31 downto 0);
          Branch : in std_logic;
          PCUpdated : out std_logic_vector(31 downto 0);
          Instruction : out std_logic_vector(31 downto 0)
        );
    end component;
    component Decode is
        port (
          clk   : in std_logic;
          reset : in std_logic;
          instruction : in std_logic_vector(31 downto 0);
          registerWrite : in std_logic;
          writeData : in std_logic_vector(31 downto 0);
          Rdst : in std_logic_vector(2 downto 0);
          Source1 : out std_logic_vector(31 downto 0);
          Source2 : out std_logic_vector(31 downto 0);
          shamt : out std_logic_vector(31 downto 0);
          immediateValue : out std_logic_vector(31 downto 0);
          controlsignals : out std_logic_vector(12 downto 0)
        );
      end component;
    component FDBuff is
      port(
      clk : in std_logic; 
      enable : in std_logic;
      PC : in std_logic_vector(31 downto 0);
      instruction : in std_logic_vector(31 downto 0);
      in_port : in std_logic_vector(31 downto 0);
      PCout : out std_logic_vector(31 downto 0);
      instructionOut : out std_logic_vector(31 downto 0);
      in_portOut : out std_logic_vector(31 downto 0)
      );
    end component;
    component DEXBuffer is
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
  end component;
  component Execute is
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
      RdstALUE : out std_logic_vector(31 downto 0);
      ALUresult : out std_logic_vector(31 downto 0)
    );
  end component;
  component EXMBuffer is
    port(
          Clk : in std_logic;
          ALUresultin : in std_logic_vector(31 downto 0);
          PCin : in std_logic_vector(31 downto 0);
          RdstValuein : in std_logic_vector(31 downto 0);
          Rdstin : in std_logic_vector(2 downto 0);
          MemoryToRegisterin : in std_logic;
          RegisterWritein : in std_logic;
          Memory_Readin : in std_logic;
          Memory_Writein : in std_logic;
          out_portin : in std_logic;
          ALUresult : out std_logic_vector(31 downto 0);
          PC : out std_logic_vector(31 downto 0);
          RdstValue : out std_logic_vector(31 downto 0);
          Rdst : out std_logic_vector(2 downto 0);
          MemoryToRegister : out std_logic;
          RegisterWrite : out std_logic;
          Memory_Read : out std_logic;
          Memory_Write : out std_logic;
          out_port : out std_logic
    );
  end component;
  component Memory is
    port (
      clkin   : in std_logic;
      resetin : in std_logic;
      MemoryReadin : in std_logic;
      MemoryWritein : in std_logic;
      ALUresultin : in std_logic_vector(31 downto 0);
      RdstValuein : in std_logic_vector(31 downto 0);
      outPortSignal : in std_logic;
      dataOut : out std_logic_vector(31 downto 0)
    );
  end component;
  component MWBBuff is
    port(
    clk, MemoryToRegisterin, RegisterWritein : in std_logic;
	  ALUresultin : in std_logic_vector(31 downto 0);
	  Rdstin : in std_logic_vector(2 downto 0);
	  memory_Data : in std_logic_vector(31 downto 0);
    MemoryToRegister, RegisterWrite : out std_logic;
	  ALUresult : out std_logic_vector(31 downto 0);
	  Rdst : out std_logic_vector(2 downto 0);
	  memory_Data_out : out std_logic_vector(31 downto 0)
	);
  end component;
  component WB is
    port (
    MemoryToRegister : in std_logic;
    MemoryResult, ALUreslt   : in std_logic_vector(31 downto 0);
    WriteData : out std_logic_vector(31 downto 0)
  );
  end component;
  component ForwardingUnit is
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
  end component;
  component load_use_detection is
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
  end component;
    signal writeDataD : std_logic_vector(31 downto 0);
    signal PC_writeS , BranchS : std_logic;
    signal PCUpdatedS, PC_AddressS, InstructionS, PCoutS, instructionOutS, in_portOutS : std_logic_vector(31 downto 0);
    signal Source1S, Source2S, shamtS, immediateValueS : std_logic_vector(31 downto 0);
    signal controlsignalsS : std_logic_vector(12 downto 0);
    signal PCDEEX,Rsrc1ValueDEEX,Rsrc2ValueDEEX,immediateValueDEEX,shmatDEEX, in_portDEEX : std_logic_vector(31 downto 0);
    signal RsrcDEEX,RdstDEEX : std_logic_vector(2 downto 0);
    signal ALU_OpDEEX : std_logic_vector(5 downto 0);
    signal Imm_ShiftDEEX,BranchDEEX,Memory_ReadDEEX,Memory_WriteDEEX,Register_WriteDEEX,MemoryToRegisterDEEX,out_portDEEX : std_logic;
    signal Rdst_oldEx, Rdst_old2EX , ALUresultEX : std_logic_vector(31 downto 0);
    signal RsrcSelectEX, RdstSelectEX : std_logic_vector(1 downto 0); 
    signal BranchedEX : std_logic;
    signal ALUresultEXM, PCEXM, RdstValueEXM :  std_logic_vector(31 downto 0);
    signal RdstEXM : std_logic_vector(2 downto 0);
    signal MemoryToRegisterEXM, RegisterWriteEXM,Memory_ReadEXM, Memory_WriteEXM , out_portEXM: std_logic;
    signal dataMem : std_logic_vector(31 downto 0);
    signal MemoryToRegisterMWB, RegisterWriteMWB : std_logic;
	  signal ALUresultMWB : std_logic_vector(31 downto 0);
	  signal RdstMWB : std_logic_vector(2 downto 0);
	  signal memory_Data_outMWB : std_logic_vector(31 downto 0);
    signal enable,fl :  std_logic;
    signal RdstALUEx : std_logic_vector(31 downto 0);
    begin
      BranchS <= '0';
        LUse : load_use_detection port map(RdstDEEX,BranchedEX,Memory_ReadDEEX,instructionOutS(26 downto 24),instructionOutS(23 downto 21),PC_writeS,enable,fl);
        FetchStage : fetch port map(clk, reset, PC_writeS, PC_AddressS, BranchS, PCUpdatedS, InstructionS);
        Fetch_Decode_Buffer: FDBuff port map(clk,enable, PCUpdatedS, InstructionS, in_port_register, PCoutS, instructionOutS, in_portOutS); 
        DecodeStage : Decode port map (clk, reset, instructionOutS,RegisterWriteMWB,writeDataD,RdstMWB, Source1S, Source2S, shamtS, immediateValueS, controlsignalsS);
        Decode_execute_Buffer : DEXBuffer port map(clk,enable,PCoutS,Source1S,Source2S,immediateValueS,shamtS,instructionOutS(26 downto 24),instructionOutS(23 downto 21),in_portOutS,controlsignalsS,PCDEEX,Rsrc1ValueDEEX,Rsrc2ValueDEEX,immediateValueDEEX,shmatDEEX,RsrcDEEX,RdstDEEX,in_portDEEX,ALU_OpDEEX,Imm_ShiftDEEX,BranchDEEX,Memory_ReadDEEX,Memory_WriteDEEX,Register_WriteDEEX,MemoryToRegisterDEEX,out_portDEEX);
        ExecuteStage : Execute port map (clk, reset, Rsrc1ValueDEEX, Rsrc2ValueDEEX, writeDataD, ALUresultEXM, RsrcSelectEX, RdstSelectEX, in_portDEEX, ALU_OpDEEX,Imm_ShiftDEEX, shmatDEEX, immediateValueDEEX, BranchDEEX, BranchedEX,RdstALUEx, ALUresultEX );
        Execute_mem_Buffer: EXMBuffer port map (clk, ALUresultEX,PCDEEX, RdstALUEx, RdstDEEX, MemoryToRegisterDEEX,Register_WriteDEEX,Memory_ReadDEEX,Memory_WriteDEEX, out_portDEEX, ALUresultEXM, PCEXM, RdstValueEXM, RdstEXM, MemoryToRegisterEXM, RegisterWriteEXM,Memory_ReadEXM, Memory_WriteEXM , out_portEXM );
        MemoryStage : Memory port map(clk, reset, Memory_ReadEXM, Memory_WriteEXM, ALUresultEXM, RdstValueEXM, out_portEXM, dataMem);
        Mem_WB_Buffer : MWBBuff port map(clk, MemoryToRegisterEXM ,RegisterWriteEXM, ALUresultEXM, RdstEXM, dataMem, MemoryToRegisterMWB, RegisterWriteMWB, ALUresultMWB, RdstMWB, memory_Data_outMWB );
        WBStage : WB port map(MemoryToRegisterMWB,memory_Data_outMWB,ALUresultMWB,writeDataD);
        forwarding : ForwardingUnit port map(RdstDEEX,RsrcDEEX,RdstMWB,RdstEXM,MemoryToRegisterEXM,MemoryToRegisterMWB,RsrcSelectEX,RdstSelectEX);
end architecture;