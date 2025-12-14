`timescale 1ns/10ps

module memRegister (clk, reset, RegWrite_MEM, dataFromMem_MEM, ALUResult_MEM, Rd_Mem, MemToReg_MEM, 
                    RegWrite_WBRegister, MemToReg_WBRegister, dataFromMem_WBRegister, ALUResult_WBRegister, Rd_WBRegister);
    input logic clk, reset;
    input logic [63:0] dataFromMem_MEM, ALUResult_MEM;
    input logic [4:0] Rd_Mem;
    input logic MemToReg_MEM, RegWrite_MEM;

    output logic RegWrite_WBRegister, MemToReg_WBRegister;
    output logic [63:0] dataFromMem_WBRegister, ALUResult_WBRegister;
    output logic [4:0]  Rd_WBRegister;

    genvar i;
    generate
        for (i = 0; i < 64; i++) begin: pushingData
            D_FF_enable dataMem (.q(dataFromMem_WBRegister[i]), .d(dataFromMem_MEM[i]), .reset(reset), .clk(clk), .enable(1'b1));
            D_FF_enable aluResult (.q(ALUResult_WBRegister[i]), .d(ALUResult_MEM[i]), .reset(reset), .clk(clk), .enable(1'b1));
        end
    endgenerate

    genvar j;
    generate
        for (j = 0; j < 5; j++) begin: pushingRD
            D_FF_enable rdReg (.q(Rd_WBRegister[j]), .d(Rd_Mem[j]), .reset(reset), .clk(clk), .enable(1'b1));
        end
    endgenerate
    
    D_FF_enable memToRegMEM (.q(MemToReg_WBRegister), .d(MemToReg_MEM), .reset(reset), .clk(clk), .enable(1'b1));
    D_FF_enable regWriteMEM (.q(RegWrite_WBRegister), .d(RegWrite_MEM), .reset(reset), .clk(clk), .enable(1'b1));
endmodule