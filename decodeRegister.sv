`timescale 1ns/10ps

module decodeRegister (clk, reset, RdData1_Decode, RdData2_Decode, Imm9_Decode, Imm12_Decode, Rd_Decode, ALUSrc_Decode, 
                        ALUOp_Decode, setFlag_Decode, UseShift_Decode, MemWrite_Decode, MemToReg_Decode, RegWrite_Decode, 
                        shiftAmount_Decode, RdData1_DecodeRegister, RdData2_DecodeRegister, Imm9_DecodeRegister, 
                        Imm12_DecodeRegister, Rd_DecodeRegister, ALUSrc_DecodeRegister, ALUOp_DecodeRegister,
                        setFlag_DecodeRegister, UseShift_DecodeRegister, MemWrite_DecodeRegister, MemToReg_DecodeRegister,
                        RegWrite_DecodeRegister, shiftAmount_DecodeRegister, WrData_Decode, WrData_DecodeRegister);
    input logic clk, reset, setFlag_Decode, UseShift_Decode, MemWrite_Decode, MemToReg_Decode;
    input logic RegWrite_Decode;
    input logic [2:0] ALUOp_Decode;
    input logic [1:0] ALUSrc_Decode;
    input logic [63:0] RdData1_Decode, RdData2_Decode, Imm9_Decode, Imm12_Decode, WrData_Decode;
    input logic [4:0] Rd_Decode;
    input logic [5:0] shiftAmount_Decode;

    output logic setFlag_DecodeRegister;
    output logic UseShift_DecodeRegister, MemWrite_DecodeRegister, MemToReg_DecodeRegister, RegWrite_DecodeRegister;
    output logic [2:0] ALUOp_DecodeRegister;
    output logic [1:0] ALUSrc_DecodeRegister;
    output logic [63:0] RdData1_DecodeRegister, RdData2_DecodeRegister, Imm9_DecodeRegister, Imm12_DecodeRegister, WrData_DecodeRegister;
    output logic [4:0] Rd_DecodeRegister;
    output logic [5:0] shiftAmount_DecodeRegister;

    // D_FF_enable (.q(), .d(), .reset(reset), .clk(clk), .enable(1'b1));

    // Pass data that are 64 bits
    genvar i;
    generate 
        for (i = 0; i < 64; i++) begin: largebitDFF
            D_FF_enable RdData1 (.q(RdData1_DecodeRegister[i]), .d(RdData1_Decode[i]), .reset(reset), .clk(clk), .enable(1'b1));
            D_FF_enable RdData2 (.q(RdData2_DecodeRegister[i]), .d(RdData2_Decode[i]), .reset(reset), .clk(clk), .enable(1'b1));
            D_FF_enable Imm9 (.q(Imm9_DecodeRegister[i]), .d(Imm9_Decode[i]), .reset(reset), .clk(clk), .enable(1'b1));
            D_FF_enable Imm12 (.q(Imm12_DecodeRegister[i]), .d(Imm12_Decode[i]), .reset(reset), .clk(clk), .enable(1'b1));
            D_FF_enable wrData (.q(WrData_DecodeRegister[i]), .d(WrData_Decode[i]), .reset(reset), .clk(clk), .enable(1'b1));
        end
    endgenerate

    // Pass multiple bits for Rd
    genvar j;
    generate 
        for (j = 0; j < 5 ; j++) begin: rdDFF
            D_FF_enable Rd (.q(Rd_DecodeRegister[j]), .d(Rd_Decode[j]), .reset(reset), .clk(clk), .enable(1'b1));
        end
    endgenerate

    // Pass multiple bits for shift amount
    genvar k;
    generate 
        for (k = 0; k < 6; k++) begin: shiftDFF
            D_FF_enable shifting (.q(shiftAmount_DecodeRegister[k]), .d(shiftAmount_Decode[k]), .reset(reset), .clk(clk), .enable(1'b1));
        end
    endgenerate

    D_FF_enable aluSrc0 (.q(ALUSrc_DecodeRegister[0]), .d(ALUSrc_Decode[0]), .reset(reset), .clk(clk), .enable(1'b1));
    D_FF_enable aluSrc1 (.q(ALUSrc_DecodeRegister[1]), .d(ALUSrc_Decode[1]), .reset(reset), .clk(clk), .enable(1'b1));
    D_FF_enable aluOp0 (.q(ALUOp_DecodeRegister[0]), .d(ALUOp_Decode[0]), .reset(reset), .clk(clk), .enable(1'b1));
    D_FF_enable aluOp1 (.q(ALUOp_DecodeRegister[1]), .d(ALUOp_Decode[1]), .reset(reset), .clk(clk), .enable(1'b1));
    D_FF_enable aluOp2 (.q(ALUOp_DecodeRegister[2]), .d(ALUOp_Decode[2]), .reset(reset), .clk(clk), .enable(1'b1));
    D_FF_enable setFlag (.q(setFlag_DecodeRegister), .d(setFlag_Decode), .reset(reset), .clk(clk), .enable(1'b1));
    D_FF_enable useShift (.q(UseShift_DecodeRegister), .d(UseShift_Decode), .reset(reset), .clk(clk), .enable(1'b1));
    D_FF_enable memWrite(.q(MemWrite_DecodeRegister), .d(MemWrite_Decode), .reset(reset), .clk(clk), .enable(1'b1));
    D_FF_enable memToReg (.q(MemToReg_DecodeRegister), .d(MemToReg_Decode), .reset(reset), .clk(clk), .enable(1'b1));
    D_FF_enable regWrite (.q(RegWrite_DecodeRegister), .d(RegWrite_Decode), .reset(reset), .clk(clk), .enable(1'b1));
endmodule
