`timescale 1ns/10ps

module memStage (clk, reset, ALUResult_EXRegister, RdData2_EXRegister, Rd_EXRegister, 
                MemWrite_EXRegister, MemToReg_EXRegister, RegWrite_EXRegister, dataFromMem_MEM, 
                ALUResult_MEM, Rd_Mem, MemToReg_MEM, RegWrite_MEM, WrData_EXRegister, resultForward_MEM);
    input logic clk, reset;
    input logic [63:0] ALUResult_EXRegister, RdData2_EXRegister, WrData_EXRegister;
    input logic [4:0] Rd_EXRegister;
    input logic MemWrite_EXRegister, MemToReg_EXRegister, RegWrite_EXRegister;

    output logic [63:0] dataFromMem_MEM, ALUResult_MEM, resultForward_MEM;
    output logic [4:0] Rd_Mem;
    output logic MemToReg_MEM, RegWrite_MEM;

    assign ALUResult_MEM = ALUResult_EXRegister;
    assign Rd_Mem = Rd_EXRegister;
    assign MemToReg_MEM = MemToReg_EXRegister;
    assign RegWrite_MEM = RegWrite_EXRegister;


    mux2_1_64 muxMemToReg (.in({dataFromMem_MEM, ALUResult_MEM}), .out(resultForward_MEM), .sel(MemToReg_MEM));

//////////////// DATA MEMORY ///////////////////////////////////////////////////////////
    datamem dataMemory (.address(ALUResult_EXRegister), .write_enable(MemWrite_EXRegister), .read_enable(1'b1), .write_data(WrData_EXRegister), 
                        .clk(clk), .xfer_size(4'd8), .read_data(dataFromMem_MEM));
//////////////// DATA MEMORY ///////////////////////////////////////////////////////////
endmodule