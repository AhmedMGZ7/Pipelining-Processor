vsim -gui work.cpu
# vsim -gui work.cpu 
# Start time: 22:30:24 on Jun 05,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.cpu(cpuarc)
# Loading work.fetch(fetcharc)
# Loading work.mux2x1(with_select_mux)
# Loading work.reg(reg_1)
# Loading work.pcdata(pcdataarc)
# Loading work.my_nadder(a_my_nadder)
# Loading work.my_adder(a_my_adder)
# Loading work.ram(syncrama)
# Loading work.fdbuff(fdbuffarc)
# Loading work.decode(decodearc)
# Loading work.registerfile(registerfilearc)
# Loading work.cu(cuarc)
# Loading work.dexbuffer(dexbufferarc)
add wave -position insertpoint  \
sim:/cpu/clk \
sim:/cpu/reset \
sim:/cpu/in_port_register \
sim:/cpu/PC_writeS \
sim:/cpu/BranchS \
sim:/cpu/PCUpdatedS \
sim:/cpu/InstructionS \
sim:/cpu/PCoutS \
sim:/cpu/instructionOutS \
sim:/cpu/Source1S \
sim:/cpu/Source2S \
sim:/cpu/shamtS \
sim:/cpu/immediateValueS \
sim:/cpu/controlsignalsS \
sim:/cpu/DecodeStage/RegFile/R0data \
sim:/cpu/DecodeStage/RegFile/R1data \
sim:/cpu/DecodeStage/RegFile/R2data \
sim:/cpu/DecodeStage/RegFile/R3data \
sim:/cpu/DecodeStage/RegFile/R4data \
sim:/cpu/DecodeStage/RegFile/R5data \
sim:/cpu/DecodeStage/RegFile/R6data \
sim:/cpu/DecodeStage/RegFile/R7data \
sim:/cpu/MemoryStage/out_port_reg_out \
sim:/cpu/ExecuteStage/SPout \
sim:/cpu/ExecuteStage/CarryFlag \
sim:/cpu/ExecuteStage/NegativeFlag \
sim:/cpu/ExecuteStage/ZeroFlag \
sim:/cpu/ExecuteStage/flag_reg_out \
sim:/cpu/ExecuteStage/ALUPart/rsrc \
sim:/cpu/ExecuteStage/ALUPart/rdst \
sim:/cpu/ExecuteStage/ALUPart/flag_reg \
sim:/cpu/ExecuteStage/ALUPart/result
force -freeze sim:/cpu/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/cpu/reset 1 0
force -freeze sim:/cpu/PC_writeS 1 0
force -freeze sim:/cpu/BranchS 0 0
force -freeze sim:/cpu/in_port_register 00000000000000000000000000000101 0
mem load -filltype value -filldata  0011010000100000 -fillradix symbolic /cpu/FetchStage/ram_inst/ram(0)
mem load -filltype value -filldata {0011010001000000 } -fillradix symbolic /cpu/FetchStage/ram_inst/ram(1)
mem load -filltype value -filldata {0011010001100000 } -fillradix symbolic /cpu/FetchStage/ram_inst/ram(2)
mem load -filltype value -filldata {0011010010000000 } -fillradix symbolic /cpu/FetchStage/ram_inst/ram(3)
mem load -filltype value -filldata {0100001110100000 } -fillradix symbolic /cpu/FetchStage/ram_inst/ram(4)
mem load -filltype value -filldata {0100100110000000 } -fillradix symbolic /cpu/FetchStage/ram_inst/ram(5)
mem load -filltype value -filldata {0101010110000000 } -fillradix symbolic /cpu/FetchStage/ram_inst/ram(6)
mem load -filltype value -filldata {0101111010000000 } -fillradix symbolic /cpu/FetchStage/ram_inst/ram(7)
mem load -filltype value -filldata {0110001000100000 } -fillradix symbolic /cpu/FetchStage/ram_inst/ram(8)
mem load -filltype value -filldata {0111000001000010 } -fillradix symbolic /cpu/FetchStage/ram_inst/ram(9)
mem load -filltype value -filldata {0111100001000011 } -fillradix symbolic /cpu/FetchStage/ram_inst/ram(10)
mem load -filltype value -filldata {0110100001000000 } -fillradix symbolic /cpu/FetchStage/ram_inst/ram(11)
mem load -filltype value -filldata {1111111111111111 } -fillradix symbolic /cpu/FetchStage/ram_inst/ram(12)
mem load -filltype value -filldata {0100100101000000 } -fillradix symbolic /cpu/FetchStage/ram_inst/ram(13)
run
force -freeze sim:/cpu/reset 0 0
run
force -freeze sim:/cpu/in_port_register 00000000000000000000000000011001 0
run
force -freeze sim:/cpu/in_port_register 11111111111111111111111111111111 0
run
force -freeze sim:/cpu/in_port_register 11111111111111111111001100100000 0
run
run
run
run
run
run
run
run
run
run
run
