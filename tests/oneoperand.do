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
mem load -i {C:/Users/Compu Tech/Desktop/Arc Project/Pipelining-Processor/assembler/OneOperand.mem} /cpu/FetchStage/ram_inst/ram
run
force -freeze sim:/cpu/reset 0 0
force -freeze sim:/cpu/in_port_register 00000000000000000000000000000101 0
run
run
run
run
run
run
run
force -freeze sim:/cpu/in_port_register 00000000000000000000000000010000 0
run
run
run
run
run
run