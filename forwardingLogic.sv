`timescale 1ns/10ps

module forwardingLogic (Rm_Decode, Rn_Decode, Rd_Decode, Rd_DecodeRegister, Rd_EXRegister, forwardingSelA_forward, 
                        forwardingSelB_forward, forwardingSelWr_forward, RegWrite_MEM, RegWrite_EX, 
                        ALUResult_MEM, dataFromMem_MEM, MemToReg_MEM);
    input logic [4:0] Rm_Decode, Rn_Decode, Rd_Decode, Rd_DecodeRegister, Rd_EXRegister;
    input logic RegWrite_MEM, RegWrite_EX, MemToReg_MEM;
    input logic [63:0] ALUResult_MEM, dataFromMem_MEM;
    output logic [1:0] forwardingSelA_forward, forwardingSelB_forward, forwardingSelWr_forward;

    always_comb begin
        forwardingSelA_forward = 2'b00; // Use REGFILE value
        forwardingSelB_forward = 2'b00; // Use REGFILE value
        forwardingSelWr_forward = 2'b00; // Use REGFILE value

        // Use ALU (Checking if Rn is the same as Rd in DECODE/EXECUTE)
        if ((Rd_DecodeRegister == Rn_Decode) && (RegWrite_EX) && (Rd_DecodeRegister != 5'd31)) begin
            forwardingSelA_forward = 2'b01;
        end

        // Use MEM (Checking if Rn is the same as Rd in EXECUTE/MEM)
        else if ((Rd_EXRegister == Rn_Decode) && (RegWrite_MEM) && (Rd_EXRegister != 5'd31)) begin
            forwardingSelA_forward = 2'b10;
        end

        // Use ALU (Checking if Rm is the same as Rd in DECODE/EXECUTE)
        if ((Rd_DecodeRegister == Rm_Decode) && (RegWrite_EX) && (Rd_DecodeRegister != 5'd31)) begin
            forwardingSelB_forward = 2'b01;
        end

        // Use MEM (Checking if Rm is the same as Rd in EXECUTE/MEM)
        else if ((Rd_EXRegister == Rm_Decode) && (RegWrite_MEM) && (Rd_EXRegister != 5'd31)) begin
            forwardingSelB_forward = 2'b10;
        end

        // STUR
        if ((Rd_DecodeRegister == Rd_Decode) && (RegWrite_EX) && (Rd_DecodeRegister != 5'd31)) begin
            forwardingSelWr_forward = 2'b01;
        end

        // STUR 
        else if ((Rd_EXRegister == Rd_Decode) && (RegWrite_MEM) && (Rd_EXRegister != 5'd31)) begin
            forwardingSelWr_forward = 2'b10;
        end
        // (Rd_EXRegister == Rd_Decode) 
    end
endmodule