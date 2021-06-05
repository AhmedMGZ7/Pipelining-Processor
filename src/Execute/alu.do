
quit -sim
vsim work.alu
# vsim work.alu 
# Start time: 19:53:13 on Jun 05,2021
# ** Note: (vsim-8009) Loading existing optimized design _opt
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading work.alu(aluarc)#1
add wave -position end  sim:/alu/inport
add wave -position end  sim:/alu/sp_in
add wave -position end  sim:/alu/rdst
add wave -position end  sim:/alu/rsrc
add wave -position 4  sim:/alu/opCode
add wave -position 0  sim:/alu/shift_immediate
add wave -position end  sim:/alu/result
add wave -position end  sim:/alu/fzero
add wave -position end  sim:/alu/fneg
add wave -position end  sim:/alu/fcout
add wave -position end  sim:/alu/sp_new
force -freeze sim:/alu/shift_immediate 32'hA 0
force -freeze sim:/alu/shift_immediate 32'h00000002 0
force -freeze sim:/alu/inport 32'hF 0
force -freeze sim:/alu/sp_in 32'h8 0
force -freeze sim:/alu/rdst 32'h5 0
force -freeze sim:/alu/rsrc 32'h4 0
# NOP
force -freeze sim:/alu/opCode 6'h00 0
run
# SETC
force -freeze sim:/alu/opCode 6'h01 0
run
# CLRC
force -freeze sim:/alu/opCode 6'h02 0
run
# CLR Rdst
force -freeze sim:/alu/opCode 6'h0F 0
run
# NOT
force -freeze sim:/alu/opCode 6'h04 0
run
# INC
force -freeze sim:/alu/opCode 6'h05 0
run
# dec
force -freeze sim:/alu/opCode 6'h06 0
run
# NEG
force -freeze sim:/alu/opCode 6'h07 0
run
# OUT
force -freeze sim:/alu/opCode 6'h08 0
run
# IN
force -freeze sim:/alu/opCode 6'h0D 0
run
# Mov
force -freeze sim:/alu/opCode 6'h10 0
run
# Add
force -freeze sim:/alu/opCode 6'h12 0
run
# Sub
force -freeze sim:/alu/opCode 6'h14 0
run
# AND
force -freeze sim:/alu/opCode 6'h16 0
run
# OR
force -freeze sim:/alu/opCode 6'h18 0
run
# IAdd
force -freeze sim:/alu/opCode 6'h1A 0
run
# SHL
force -freeze sim:/alu/opCode 6'h1C 0
run
# SHR
force -freeze sim:/alu/opCode 6'h1E 0
run
# RLC
force -freeze sim:/alu/opCode 6'h0A 0
run
# RRC
force -freeze sim:/alu/opCode 6'h0B 0
run
# Push
force -freeze sim:/alu/opCode 6'h20 0
run
# Pop
force -freeze sim:/alu/opCode 6'h22 0
run
# LDM
force -freeze sim:/alu/opCode 6'h24 0
run
# LDD
force -freeze sim:/alu/opCode 6'h26 0
run
# STD
force -freeze sim:/alu/opCode 6'h28 0
run