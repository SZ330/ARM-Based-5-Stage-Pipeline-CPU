onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pipelineCPU_testbench/cpu/fetch/clk
add wave -noupdate /pipelineCPU_testbench/cpu/fetch/reset
add wave -noupdate -divider {decode instruction}
add wave -noupdate /pipelineCPU_testbench/cpu/decode/negativeEX
add wave -noupdate /pipelineCPU_testbench/cpu/decode/overflowEX
add wave -noupdate /pipelineCPU_testbench/cpu/decode/instruction_FetchRegister
add wave -noupdate -radix decimal /pipelineCPU_testbench/cpu/decode/programCounter_FetchRegister
add wave -noupdate /pipelineCPU_testbench/cpu/decode/controlUnit/BrTaken
add wave -noupdate /pipelineCPU_testbench/cpu/decode/controlUnit/UncondBr
add wave -noupdate /pipelineCPU_testbench/cpu/decode/controlUnit/Reg2Loc
add wave -noupdate /pipelineCPU_testbench/cpu/decode/adder1/finalResult
add wave -noupdate -divider {forwarding unit}
add wave -noupdate /pipelineCPU_testbench/cpu/forwarding/Rm_Decode
add wave -noupdate /pipelineCPU_testbench/cpu/forwarding/Rn_Decode
add wave -noupdate /pipelineCPU_testbench/cpu/forwarding/Rd_Decode
add wave -noupdate /pipelineCPU_testbench/cpu/forwarding/Rd_DecodeRegister
add wave -noupdate /pipelineCPU_testbench/cpu/forwarding/Rd_EXRegister
add wave -noupdate /pipelineCPU_testbench/cpu/forwarding/RegWrite_MEM
add wave -noupdate /pipelineCPU_testbench/cpu/forwarding/RegWrite_EX
add wave -noupdate /pipelineCPU_testbench/cpu/forwarding/MemToReg_MEM
add wave -noupdate /pipelineCPU_testbench/cpu/forwarding/ALUResult_MEM
add wave -noupdate /pipelineCPU_testbench/cpu/forwarding/dataFromMem_MEM
add wave -noupdate /pipelineCPU_testbench/cpu/forwarding/forwardingSelA_forward
add wave -noupdate /pipelineCPU_testbench/cpu/forwarding/forwardingSelB_forward
add wave -noupdate /pipelineCPU_testbench/cpu/forwarding/forwardingSelWr_forward
add wave -noupdate -divider forwarding
add wave -noupdate -radix hexadecimal /pipelineCPU_testbench/cpu/decode/ALUResult_EX
add wave -noupdate -radix hexadecimal /pipelineCPU_testbench/cpu/decode/ALUResult_MEM
add wave -noupdate -radix hexadecimal /pipelineCPU_testbench/cpu/decode/resultForward_MEM
add wave -noupdate /pipelineCPU_testbench/cpu/decode/forwardingSelA_forward
add wave -noupdate /pipelineCPU_testbench/cpu/decode/forwardingSelB_forward
add wave -noupdate /pipelineCPU_testbench/cpu/decode/forwardingSelWr_forward
add wave -noupdate -radix hexadecimal /pipelineCPU_testbench/cpu/decode/RdData1_Decode
add wave -noupdate -radix hexadecimal /pipelineCPU_testbench/cpu/decode/RdData2_Decode
add wave -noupdate /pipelineCPU_testbench/cpu/decode/BrTaken_Decode
add wave -noupdate /pipelineCPU_testbench/cpu/decode/ReadData2
add wave -noupdate /pipelineCPU_testbench/cpu/decode/zeroSignal
add wave -noupdate -divider regFile
add wave -noupdate /pipelineCPU_testbench/cpu/decode/WrData_Decode
add wave -noupdate /pipelineCPU_testbench/cpu/decodeReg/WrData_DecodeRegister
add wave -noupdate /pipelineCPU_testbench/cpu/execute/WrData_EX
add wave -noupdate /pipelineCPU_testbench/cpu/executeReg/WrData_EXRegister
add wave -noupdate /pipelineCPU_testbench/cpu/mem/WrData_EXRegister
add wave -noupdate /pipelineCPU_testbench/cpu/decode/registerFile/RegWrite
add wave -noupdate -radix decimal /pipelineCPU_testbench/cpu/decode/registerFile/WriteRegister
add wave -noupdate /pipelineCPU_testbench/cpu/decode/registerFile/WriteData
add wave -noupdate /pipelineCPU_testbench/cpu/decode/registerFile/ReadData1
add wave -noupdate /pipelineCPU_testbench/cpu/decode/registerFile/ReadData2
add wave -noupdate /pipelineCPU_testbench/cpu/decode/registerFile/ReadRegister1
add wave -noupdate /pipelineCPU_testbench/cpu/decode/registerFile/ReadRegister2
add wave -noupdate -childformat {{{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[25]} -radix decimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[24]} -radix decimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[23]} -radix decimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[22]} -radix decimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[21]} -radix decimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[20]} -radix decimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[19]} -radix decimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[18]} -radix decimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[17]} -radix decimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[16]} -radix decimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[15]} -radix decimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[14]} -radix decimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[13]} -radix decimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[12]} -radix decimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[11]} -radix decimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[10]} -radix decimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[9]} -radix hexadecimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[8]} -radix hexadecimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[7]} -radix hexadecimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[6]} -radix hexadecimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[5]} -radix binary} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[4]} -radix decimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[3]} -radix hexadecimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[2]} -radix hexadecimal} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[1]} -radix binary} {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[0]} -radix binary}} -expand -subitemconfig {{/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[25]} {-height 15 -radix decimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[24]} {-height 15 -radix decimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[23]} {-height 15 -radix decimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[22]} {-height 15 -radix decimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[21]} {-height 15 -radix decimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[20]} {-height 15 -radix decimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[19]} {-height 15 -radix decimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[18]} {-height 15 -radix decimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[17]} {-height 15 -radix decimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[16]} {-height 15 -radix decimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[15]} {-height 15 -radix decimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[14]} {-height 15 -radix decimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[13]} {-height 15 -radix decimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[12]} {-height 15 -radix decimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[11]} {-height 15 -radix decimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[10]} {-height 15 -radix decimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[9]} {-height 15 -radix hexadecimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[8]} {-height 15 -radix hexadecimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[7]} {-height 15 -radix hexadecimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[6]} {-height 15 -radix hexadecimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[5]} {-height 15 -radix binary} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[4]} {-height 15 -radix decimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[3]} {-height 15 -radix hexadecimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[2]} {-height 15 -radix hexadecimal} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[1]} {-height 15 -radix binary} {/pipelineCPU_testbench/cpu/decode/registerFile/registersOutput[0]} {-height 15 -radix binary}} /pipelineCPU_testbench/cpu/decode/registerFile/registersOutput
add wave -noupdate -divider mem
add wave -noupdate /pipelineCPU_testbench/cpu/mem/WrData_EXRegister
add wave -noupdate /pipelineCPU_testbench/cpu/mem/dataMemory/mem
add wave -noupdate -divider Flag
add wave -noupdate /pipelineCPU_testbench/cpu/decode/zeroSignal
add wave -noupdate /pipelineCPU_testbench/cpu/execute/negativeFlag
add wave -noupdate /pipelineCPU_testbench/cpu/execute/overflowFlag
add wave -noupdate /pipelineCPU_testbench/cpu/execute/carry_outFlag
add wave -noupdate /pipelineCPU_testbench/cpu/decode/controlUnit/zeroSignal
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1866366973 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 400
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 50
configure wave -gridperiod 100
configure wave -griddelta 2
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {1866175594 ps} {1900316738 ps}
