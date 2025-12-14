`timescale 1ns/10ps

module executeRegister (clk, reset, ALUResult_EX, RdData2_EX, Rd_EX, MemWrite_EX, MemToReg_EX, RegWrite_EX, ALUResult_EXRegister, 
                        RdData2_EXRegister, Rd_EXRegister, MemWrite_EXRegister, MemToReg_EXRegister, RegWrite_EXRegister,
                        WrData_EX, WrData_EXRegister);
    input logic clk, reset, MemWrite_EX, MemToReg_EX, RegWrite_EX;
    input logic [63:0] ALUResult_EX, RdData2_EX, WrData_EX;
    input logic [4:0] Rd_EX;

    output logic [63:0] ALUResult_EXRegister, RdData2_EXRegister, WrData_EXRegister;
    output logic [4:0] Rd_EXRegister;
    output logic MemWrite_EXRegister, MemToReg_EXRegister, RegWrite_EXRegister;

    genvar i;
    generate
        for (i = 0; i < 64; i++) begin: pushingData
            D_FF_enable ALUResult (.q(ALUResult_EXRegister[i]), .d(ALUResult_EX[i]), .reset(reset), .clk(clk), .enable(1'b1));
            D_FF_enable rdData2 (.q(RdData2_EXRegister[i]), .d(RdData2_EX[i]), .reset(reset), .clk(clk), .enable(1'b1));
            D_FF_enable wrDataEX (.q(WrData_EXRegister[i]), .d(WrData_EX[i]), .reset(reset), .clk(clk), .enable(1'b1));
        end
    endgenerate
    
    genvar j;
    generate
        for (j = 0; j < 5; j++) begin: pushingRD
            D_FF_enable rdRegister (.q(Rd_EXRegister[j]), .d(Rd_EX[j]), .reset(reset), .clk(clk), .enable(1'b1));
        end
    endgenerate
    
    D_FF_enable memWriteEX (.q(MemWrite_EXRegister), .d(MemWrite_EX), .reset(reset), .clk(clk), .enable(1'b1));
    D_FF_enable memToRegEX (.q(MemToReg_EXRegister), .d(MemToReg_EX), .reset(reset), .clk(clk), .enable(1'b1));
    D_FF_enable regWriteEX (.q(RegWrite_EXRegister), .d(RegWrite_EX), .reset(reset), .clk(clk), .enable(1'b1));
endmodule