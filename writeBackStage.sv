`timescale 1ns/10ps

module writeBackStage (RegWrite_WBRegister, MemToReg_WBRegister, dataFromMem_WBRegister, ALUResult_WBRegister, Rd_WBRegister, 
                    WriteData_WB, RegWrite_WB, Rd_WriteRegister_WB);
    input logic RegWrite_WBRegister, MemToReg_WBRegister;
    input logic [63:0] dataFromMem_WBRegister, ALUResult_WBRegister;
    input logic [4:0]  Rd_WBRegister;

    output logic [63:0] WriteData_WB;
    output logic RegWrite_WB;
    output logic [4:0] Rd_WriteRegister_WB;

    assign RegWrite_WB = RegWrite_WBRegister;
    assign Rd_WriteRegister_WB = Rd_WBRegister;

    mux2_1_64 mux1 (.in({dataFromMem_WBRegister, ALUResult_WBRegister}), .out(WriteData_WB), .sel(MemToReg_WBRegister));
endmodule 