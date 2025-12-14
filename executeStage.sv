`timescale 1ns/10ps

module executeStage (clk, reset, RdData1_DecodeRegister, RdData2_DecodeRegister, ALUSrc_DecodeRegister, 
                    ALUOp_DecodeRegister, setFlag_DecodeRegister, UseShift_DecodeRegister,
                    MemWrite_DecodeRegister, MemToReg_DecodeRegister, RegWrite_DecodeRegister,
                    Imm9_DecodeRegister, Imm12_DecodeRegister, Rd_DecodeRegister, ALUResult_EX, shiftAmount_DecodeRegister,
                    RdData2_EX, Rd_EX, negativeFlag, overflowFlag, carry_outFlag, MemWrite_EX, MemToReg_EX, RegWrite_EX, negativeEX, overflowEX,
                    WrData_DecodeRegister, WrData_EX);
    input clk, reset;
    input logic setFlag_DecodeRegister;
    input logic UseShift_DecodeRegister, MemWrite_DecodeRegister, MemToReg_DecodeRegister, RegWrite_DecodeRegister;
    input logic [2:0] ALUOp_DecodeRegister;
    input logic [1:0] ALUSrc_DecodeRegister;
    input logic [63:0] RdData1_DecodeRegister, RdData2_DecodeRegister, WrData_DecodeRegister;
    input logic [63:0] Imm9_DecodeRegister, Imm12_DecodeRegister;

    input logic [4:0] Rd_DecodeRegister;
    input logic [5:0] shiftAmount_DecodeRegister; 

    output logic [63:0] ALUResult_EX, RdData2_EX, WrData_EX;
    output logic [4:0] Rd_EX;
    output logic negativeFlag, overflowFlag, carry_outFlag, negativeEX, overflowEX; // Flag register outputs   
    output logic MemWrite_EX, MemToReg_EX, RegWrite_EX;

    logic set_negative, set_zero, set_overflow, set_carry_out, zeroFlag;

    // Output RdData2 for Din in datamem
    assign RdData2_EX = RdData2_DecodeRegister;

    // Keep passing Rd throughout the pipeline
    assign Rd_EX = Rd_DecodeRegister;

    // Keep passing MemWrite, MemToReg, and RegWrite
    assign MemWrite_EX = MemWrite_DecodeRegister;
    assign MemToReg_EX = MemToReg_DecodeRegister;
    assign RegWrite_EX = RegWrite_DecodeRegister;

    assign WrData_EX = WrData_DecodeRegister;

    // Pick between immediates and ReadData2
    logic [63:0] muxOutput4_1;
    mux4_1_64 immediateSelect (.in({64'd0, Imm12_DecodeRegister, Imm9_DecodeRegister, RdData2_DecodeRegister}), 
                                .out(muxOutput4_1), .sel(ALUSrc_DecodeRegister));

////////////////////// ALU ///////////////////////////////////////////////////////////////////////////////////////////////
    // ALU for computation and shifter, picking between those outputs
    logic [63:0] shiftResult;
    logic [63:0] ALUResult;
    shifter logicalShiftRight (.value(RdData1_DecodeRegister), .direction(1'b1), .distance(shiftAmount_DecodeRegister), 
                                .result(shiftResult));
    alu bigALU (.A(RdData1_DecodeRegister), .B(muxOutput4_1), .cntrl(ALUOp_DecodeRegister), .result(ALUResult), 
                .negative(set_negative), .zero(set_zero), .overflow(set_overflow), .carry_out(set_carry_out)); 
    mux2_1_64 shifterOrALU (.in({shiftResult, ALUResult}), .out(ALUResult_EX), .sel(UseShift_DecodeRegister));     
     
    // Output the flags without it going through the flag register as they would be 1 cycle too late for SUBS and then B.LT
    assign negativeEX = set_negative;
    assign overflowEX = set_overflow;
    
    // Flag register
    // flagRegister flags (.negative(set_negative), .zero(set_zero), .overflow(set_overflow), 
    //                     .carry_out(set_carry_out), .negativeFlag(negativeFlag), .zeroFlag(zeroFlag), 
    //                     .overflowFlag(overflowFlag), .carry_outFlag(carry_outFlag), 
    //                     .setFlag(setFlag_DecodeRegister), .reset(reset), .clk(clk));

    flagRegister flags (.negative(set_negative), .zero(1'b0), .overflow(set_overflow), 
                        .carry_out(set_carry_out), .negativeFlag(negativeFlag), .zeroFlag(zeroFlag), 
                        .overflowFlag(overflowFlag), .carry_outFlag(carry_outFlag), 
                        .setFlag(setFlag_DecodeRegister), .reset(reset), .clk(clk));
endmodule