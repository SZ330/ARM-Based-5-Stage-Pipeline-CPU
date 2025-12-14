`timescale 1ns/10ps

module pipelineCPU (clk, reset);
    input logic clk, reset;

    // Fetch stage wires
    logic [31:0] instruction_Fetch;
    logic [63:0] programCounter_Fetch;

    // Fetch register wires
    logic [31:0] instruction_FetchRegister;
    logic [63:0] programCounter_FetchRegister;

    // Decode stage wires
    logic [63:0] RdData1_Decode, RdData2_Decode, Imm9_Decode, Imm12_Decode, WrData_Decode;
    logic [63:0] WriteData_WB;
    logic [63:0] ALUResult_EX;
    logic [63:0] dataFromMem_MEM;
    logic [5:0]  shiftAmount_Decode;
    logic [4:0] Rn_Decode, Rm_Decode, Rd_Decode, Rd_WriteRegister_WB;
    logic [1:0] forwardingSelA_forward, forwardingSelB_forward, forwardingSelWr_forward;
    logic [1:0] ALUSrc_Decode;
    logic [2:0] ALUOp_Decode;
    logic RegWrite_Decode, MemWrite_Decode, MemToReg_Decode;
    logic UseShift_Decode, setFlag_Decode;
    logic BrTaken_Decode;
    logic negative_flagRegister, overFlow_flagRegister, carryOut_flagRegister;
    logic [63:0] branchAddress_Decode, forwardedData;
    logic RegWrite_WB;

    // Decode register wires
    logic [63:0] RdData1_DecodeRegister, RdData2_DecodeRegister, Imm9_DecodeRegister, Imm12_DecodeRegister, WrData_DecodeRegister;
    logic [63:0] resultForward_MEM;
    logic [5:0]  shiftAmount_DecodeRegister;
    logic [4:0] Rd_DecodeRegister;
    logic [1:0] ALUSrc_DecodeRegister;
    logic [2:0] ALUOp_DecodeRegister;
    logic RegWrite_DecodeRegister, MemWrite_DecodeRegister, MemToReg_DecodeRegister;
    logic UseShift_DecodeRegister, setFlag_DecodeRegister;

    // Execute stage wires
    logic [63:0] RdData2_EX, WrData_EX;
    logic [4:0]  Rd_EX;
    logic negativeFlag, overflowFlag, carry_outFlag;
    logic RegWrite_EX, MemToReg_EX, MemWrite_EX;
    logic negativeEX, overflowEX;

    // Execute register wires
    logic [63:0] ALUResult_EXRegister, RdData2_EXRegister, WrData_EXRegister;
    logic MemWrite_EXRegister, MemToReg_EXRegister, RegWrite_EXRegister;
    logic [4:0] Rd_EXRegister;

    // Memory stage wires
    logic [63:0] ALUResult_MEM;
    logic [4:0]  Rd_Mem;
    logic MemToReg_MEM, RegWrite_MEM;

    // Memory register wires
    logic RegWrite_WBRegister, MemToReg_WBRegister;
    logic [63:0] dataFromMem_WBRegister, ALUResult_WBRegister;
    logic [4:0] Rd_WBRegister;


    // Fetch stage
    fetchStage fetch (.clk(clk), .reset(reset), .BrTaken_Decode(BrTaken_Decode), .instruction_Fetch(instruction_Fetch),
                    .programCounter_Fetch(programCounter_Fetch), .branchAddress_Decode(branchAddress_Decode));

    // Fetch register
    fetchRegister fetchReg (.clk(clk), .reset(reset), .instruction_Fetch(instruction_Fetch), .programCounter_Fetch(programCounter_Fetch),
                            .instruction_FetchRegister(instruction_FetchRegister), .programCounter_FetchRegister(programCounter_FetchRegister));

    // Decode stage
    decodeStage decode (.clk(clk), .reset(reset), .RegWrite_WB(RegWrite_WB), .instruction_FetchRegister(instruction_FetchRegister),
                        .programCounter_FetchRegister(programCounter_FetchRegister), .branchAddress_Decode(branchAddress_Decode),
                        .RdData1_Decode(RdData1_Decode), .RdData2_Decode(RdData2_Decode), .Imm9_Decode(Imm9_Decode), .Imm12_Decode(Imm12_Decode),
                        .Rd_Decode(Rd_Decode), .Rn_Decode(Rn_Decode), .Rm_Decode(Rm_Decode), .ALUResult_EX(ALUResult_EX),
                        .ALUResult_MEM(ALUResult_MEM), .Rd_WriteRegister_WB(Rd_WriteRegister_WB), .WriteData_WB(WriteData_WB),
                        .forwardingSelA_forward(forwardingSelA_forward), .forwardingSelB_forward(forwardingSelB_forward),
                        .forwardingSelWr_forward(forwardingSelWr_forward), .negative_flagRegister(negative_flagRegister), 
                        .carryOut_flagRegister(carryOut_flagRegister), .overFlow_flagRegister(overFlow_flagRegister), 
                        .MemWrite_Decode(MemWrite_Decode), .BrTaken_Decode(BrTaken_Decode), .MemToReg_Decode(MemToReg_Decode), .RegWrite_Decode(RegWrite_Decode), 
                        .UseShift_Decode(UseShift_Decode), .setFlag_Decode(setFlag_Decode), .ALUOp_Decode(ALUOp_Decode), .ALUSrc_Decode(ALUSrc_Decode),
                        .shiftAmount_Decode(shiftAmount_Decode), .negativeEX(negativeEX), .overflowEX(overflowEX), 
                        .setFlag_DecodeRegister(setFlag_DecodeRegister), .WrData_Decode(WrData_Decode), .resultForward_MEM(resultForward_MEM));

    // Decode register
    decodeRegister decodeReg (.clk(clk), .reset(reset), .RdData1_Decode(RdData1_Decode), .RdData2_Decode(RdData2_Decode),
                            .Imm9_Decode(Imm9_Decode), .Imm12_Decode(Imm12_Decode), .Rd_Decode(Rd_Decode), .ALUSrc_Decode(ALUSrc_Decode),
                            .ALUOp_Decode(ALUOp_Decode), .setFlag_Decode(setFlag_Decode), .UseShift_Decode(UseShift_Decode),
                            .MemWrite_Decode(MemWrite_Decode), .MemToReg_Decode(MemToReg_Decode), .RegWrite_Decode(RegWrite_Decode),
                            .shiftAmount_Decode(shiftAmount_Decode), .RdData1_DecodeRegister(RdData1_DecodeRegister),
                            .RdData2_DecodeRegister(RdData2_DecodeRegister), .Imm9_DecodeRegister(Imm9_DecodeRegister),
                            .Imm12_DecodeRegister(Imm12_DecodeRegister), .Rd_DecodeRegister(Rd_DecodeRegister),
                            .ALUSrc_DecodeRegister(ALUSrc_DecodeRegister), .ALUOp_DecodeRegister(ALUOp_DecodeRegister),
                            .setFlag_DecodeRegister(setFlag_DecodeRegister), .UseShift_DecodeRegister(UseShift_DecodeRegister),
                            .MemWrite_DecodeRegister(MemWrite_DecodeRegister), .MemToReg_DecodeRegister(MemToReg_DecodeRegister),
                            .RegWrite_DecodeRegister(RegWrite_DecodeRegister), .shiftAmount_DecodeRegister(shiftAmount_DecodeRegister), 
                            .WrData_Decode(WrData_Decode), .WrData_DecodeRegister(WrData_DecodeRegister));

    // Forwarding logic unit
    forwardingLogic forwarding (.Rm_Decode(Rm_Decode), .Rn_Decode(Rn_Decode), .Rd_Decode(Rd_Decode), .Rd_DecodeRegister(Rd_DecodeRegister), 
                                .Rd_EXRegister(Rd_EXRegister), .forwardingSelA_forward(forwardingSelA_forward),  
                                .forwardingSelB_forward(forwardingSelB_forward), .forwardingSelWr_forward(forwardingSelWr_forward), 
                                .RegWrite_MEM(RegWrite_MEM), .RegWrite_EX(RegWrite_EX), .ALUResult_MEM(ALUResult_MEM),  
                                .dataFromMem_MEM(dataFromMem_MEM), .MemToReg_MEM(MemToReg_MEM));

    // Execute stage
    executeStage execute (.clk(clk), .reset(reset), .RdData1_DecodeRegister(RdData1_DecodeRegister),
                            .RdData2_DecodeRegister(RdData2_DecodeRegister), .ALUSrc_DecodeRegister(ALUSrc_DecodeRegister),
                            .ALUOp_DecodeRegister(ALUOp_DecodeRegister), .setFlag_DecodeRegister(setFlag_DecodeRegister),
                            .UseShift_DecodeRegister(UseShift_DecodeRegister), .MemWrite_DecodeRegister(MemWrite_DecodeRegister),
                            .MemToReg_DecodeRegister(MemToReg_DecodeRegister), .RegWrite_DecodeRegister(RegWrite_DecodeRegister),
                            .Imm9_DecodeRegister(Imm9_DecodeRegister), .Imm12_DecodeRegister(Imm12_DecodeRegister),
                            .Rd_DecodeRegister(Rd_DecodeRegister), .shiftAmount_DecodeRegister(shiftAmount_DecodeRegister),
                            .ALUResult_EX(ALUResult_EX), .RdData2_EX(RdData2_EX), .Rd_EX(Rd_EX), .negativeFlag(negativeFlag),
                            .overflowFlag(overflowFlag), .carry_outFlag(carry_outFlag), .MemWrite_EX(MemWrite_EX),
                            .MemToReg_EX(MemToReg_EX), .RegWrite_EX(RegWrite_EX), .negativeEX(negativeEX), .overflowEX(overflowEX),
                            .WrData_DecodeRegister(WrData_DecodeRegister), .WrData_EX(WrData_EX));

    // Connecting flagRegister to its values
    assign negative_flagRegister = negativeFlag;
    assign overFlow_flagRegister = overflowFlag;
    assign carryOut_flagRegister = carry_outFlag;

    // Execute register
    executeRegister executeReg (.clk(clk), .reset(reset), .ALUResult_EX(ALUResult_EX), .RdData2_EX(RdData2_EX), .Rd_EX(Rd_EX),
                                .MemWrite_EX(MemWrite_EX), .MemToReg_EX(MemToReg_EX), .RegWrite_EX(RegWrite_EX),
                                .ALUResult_EXRegister(ALUResult_EXRegister), .RdData2_EXRegister(RdData2_EXRegister),
                                .Rd_EXRegister(Rd_EXRegister), .MemWrite_EXRegister(MemWrite_EXRegister),
                                .MemToReg_EXRegister(MemToReg_EXRegister),
                                .RegWrite_EXRegister(RegWrite_EXRegister), .WrData_EX(WrData_EX), .WrData_EXRegister(WrData_EXRegister));

    // Memory stage
    memStage mem (.clk(clk), .reset(reset), .ALUResult_EXRegister(ALUResult_EXRegister), .RdData2_EXRegister(RdData2_EXRegister),
                    .Rd_EXRegister(Rd_EXRegister), .MemWrite_EXRegister(MemWrite_EXRegister), .MemToReg_EXRegister(MemToReg_EXRegister),
                    .RegWrite_EXRegister(RegWrite_EXRegister), .dataFromMem_MEM(dataFromMem_MEM), .ALUResult_MEM(ALUResult_MEM),
                    .Rd_Mem(Rd_Mem), .MemToReg_MEM(MemToReg_MEM), .RegWrite_MEM(RegWrite_MEM), .WrData_EXRegister(WrData_EXRegister),
                    .resultForward_MEM(resultForward_MEM));

    // Memory register
    memRegister memReg (.clk(clk), .reset(reset), .RegWrite_MEM(RegWrite_MEM), .dataFromMem_MEM(dataFromMem_MEM),
                        .ALUResult_MEM(ALUResult_MEM), .Rd_Mem(Rd_Mem), .MemToReg_MEM(MemToReg_MEM), .RegWrite_WBRegister(RegWrite_WBRegister),
                        .MemToReg_WBRegister(MemToReg_WBRegister), .dataFromMem_WBRegister(dataFromMem_WBRegister),
                        .ALUResult_WBRegister(ALUResult_WBRegister), .Rd_WBRegister(Rd_WBRegister));

    // Writeback stage
    writeBackStage wb (.RegWrite_WBRegister(RegWrite_WBRegister), .MemToReg_WBRegister(MemToReg_WBRegister),
                        .dataFromMem_WBRegister(dataFromMem_WBRegister), .ALUResult_WBRegister(ALUResult_WBRegister),
                        .Rd_WBRegister(Rd_WBRegister), .WriteData_WB(WriteData_WB), .RegWrite_WB(RegWrite_WB),
                        .Rd_WriteRegister_WB(Rd_WriteRegister_WB));
endmodule

module pipelineCPU_testbench();
    logic clk, reset;

    pipelineCPU cpu (.clk, .reset);

    parameter CLOCK_PERIOD = 50000;
    initial begin
        clk <= 0;
        forever #(CLOCK_PERIOD/2) clk <= ~clk;
    end

    int i;
    initial begin
        reset <= 1; @(posedge clk);
                    @(posedge clk);
        reset <= 0; @(posedge clk);

        for (i = 0; i < 1500; i++) begin
            @(posedge clk);
        end
        $stop;
    end
endmodule