`timescale 1ns/10ps

module decodeStage (clk, reset, RegWrite_WB, instruction_FetchRegister, 
                    programCounter_FetchRegister, branchAddress_Decode, RdData1_Decode, RdData2_Decode, 
                    Imm9_Decode, Imm12_Decode, Rd_Decode, Rn_Decode, Rm_Decode, ALUResult_EX, ALUResult_MEM,
                    Rd_WriteRegister_WB, WriteData_WB, forwardingSelA_forward, forwardingSelB_forward, forwardingSelWr_forward,
                    negative_flagRegister, carryOut_flagRegister, overFlow_flagRegister,
                    MemWrite_Decode, BrTaken_Decode, MemToReg_Decode, RegWrite_Decode, UseShift_Decode, 
                    setFlag_Decode, ALUOp_Decode, ALUSrc_Decode, shiftAmount_Decode, negativeEX, overflowEX, setFlag_DecodeRegister, 
                    WrData_Decode, resultForward_MEM);
    input logic clk, reset, RegWrite_WB, negative_flagRegister, carryOut_flagRegister, overFlow_flagRegister;
    input logic negativeEX, overflowEX;
    input logic [31:0] instruction_FetchRegister;
    input logic [63:0] programCounter_FetchRegister, WriteData_WB, ALUResult_EX, ALUResult_MEM, resultForward_MEM;
    input logic [4:0] Rd_WriteRegister_WB;
    input logic [1:0] forwardingSelA_forward, forwardingSelB_forward, forwardingSelWr_forward;
    input logic setFlag_DecodeRegister;

    output logic [63:0] branchAddress_Decode, RdData1_Decode, RdData2_Decode, Imm9_Decode, Imm12_Decode, WrData_Decode;
    output logic [4:0] Rd_Decode, Rn_Decode, Rm_Decode;
    output logic MemWrite_Decode, BrTaken_Decode, MemToReg_Decode, RegWrite_Decode;
    output logic UseShift_Decode, setFlag_Decode;
    output logic [2:0] ALUOp_Decode;
    output logic [1:0] ALUSrc_Decode;
    output logic [5:0] shiftAmount_Decode;

////////// FOR ACCELERATED BRANCHING //////////////////////////////////////////////////////////////////////////////////////
    // Extending CondAddr19 and BrAddr26
    logic [63:0] condAddr19_64bits, brAddr26_64bits;
    logic [18:0] condAddr19;
    logic [25:0] brAddr26;

    // Grab immediates from instruction
    assign condAddr19 = instruction_FetchRegister[23:5];
    assign brAddr26 = instruction_FetchRegister[25:0];    

    // Sign extend the immediates
    condAddr19Extend extend1 (.condAddr19, .condAddr19Extended(condAddr19_64bits));
    brAddr26Extend extend2 (.brAddr26, .brAddr26Extended(brAddr26_64bits));

    // Use a 2:1 mux to determine which immediate will be used
    logic [63:0] muxOutput;
    logic UncondBr;
    mux2_1_64 mux1 (.in({brAddr26_64bits, condAddr19_64bits}), .out(muxOutput), .sel(UncondBr));

    // Shift the number that comes out of the 2:1 mux by 2 to the left
    logic [63:0] shifterOutput;
    shiftLeftByTwo shifting (.inputNum(muxOutput), .shiftedNum(shifterOutput));

    fullAdder_64 adder1 (.input1(shifterOutput), .input2(programCounter_FetchRegister), .finalResult(branchAddress_Decode));
////////////// FOR ACCELERATED BRANCHING //////////////////////////////////////////////////////////////////////////////////////

////////////// FOR REGFILE ///////////////////////////////////////////////////////////////////////////////////////////////////
    // Logic used for REGFILE
    logic [4:0] Rm, Rn, Rd;
    logic [4:0] ReadRegister1, ReadRegister2;
    logic [4:0] WriteRegister;
    logic [63:0] WriteData;
    logic [63:0] ReadData1, ReadData2;

    assign Rm = instruction_FetchRegister[20:16];
    assign Rn = instruction_FetchRegister[9:5];
    assign Rd = instruction_FetchRegister[4:0];
    assign ReadRegister1 = Rn;
    
    // WriteRegister, WriteData, RegWrite all come from the WB stage of the pipeline
    assign WriteRegister = Rd_WriteRegister_WB;
    assign WriteData = WriteData_WB;

    // Rm_Decode passed into DECODE REGISTER, Rn_Decode and Rm_Decode are passed into forwarding logic
    assign Rm_Decode = instruction_FetchRegister[20:16];
    assign Rn_Decode = instruction_FetchRegister[9:5];
    assign Rd_Decode = instruction_FetchRegister[4:0];

    // Pick between Rm and Rd for the ReadRegister2
    logic Reg2Loc;
    mux2_1_5 registerSelect (.in({Rm, Rd}), .out(ReadRegister2), .sel(Reg2Loc));

    // Invert the clock for write and read
    logic invertingClk;
    not #50 invertClock (invertingClk, clk);
    
    // Register file
    regfile registerFile (.ReadData1(ReadData1), .ReadData2(ReadData2), .WriteData(WriteData), .ReadRegister1(ReadRegister1), 
                            .ReadRegister2(ReadRegister2), .WriteRegister(WriteRegister), .RegWrite(RegWrite_WB), 
                            .reset(reset), .clk(invertingClk));
    mux4_1_64 muxA (.in({64'd0, resultForward_MEM, ALUResult_EX, ReadData1}), .out(RdData1_Decode), .sel(forwardingSelA_forward));
    mux4_1_64 muxB (.in({64'd0, resultForward_MEM, ALUResult_EX, ReadData2}), .out(RdData2_Decode), .sel(forwardingSelB_forward));
    mux4_1_64 muxWrData (.in({64'd0, resultForward_MEM, ALUResult_EX, ReadData2}), .out(WrData_Decode), .sel(forwardingSelWr_forward));

    // Check if the value at ReadData2 is zero or not
    logic zeroSignal;
    // largeOR determineZero (.in(RdData2_Decode), .zeroOutput(zeroSignal));
    largeOR determineZero (.in(WrData_Decode), .zeroOutput(zeroSignal));

    // Bit extensions for Imme12 and DAddr9 pushed into DECODE REGISTER for ALU
    logic [11:0] immediate12;
    logic [8:0] dAddress9;
    assign immediate12 = instruction_FetchRegister[21:10];
    assign dAddress9 = instruction_FetchRegister[20:12];
    zeroExtend extendingZeros (.imm12(immediate12), .zeroExtended(Imm12_Decode));
    dAddr9Extend extendDAddr9 (.dAddr9(dAddress9), .dAddr9Extended(Imm9_Decode));
////////////// FOR REGFILE ///////////////////////////////////////////////////////////////////////////////////////////////////

///////////// FOR CONTROL LOGIC /////////////////////////////////////////////////////////////////////////////////////////////
    controlLogic controlUnit (.instruction_fetchOut(instruction_FetchRegister), .zeroSignal(zeroSignal), 
                            .negativeFlag(negative_flagRegister), .overflowFlag(overFlow_flagRegister), 
                            .carry_outFlag(carryOut_flagRegister), .negativeEX(negativeEX), .overflowEX(overflowEX), .Reg2Loc(Reg2Loc), 
                            .ALUSrc(ALUSrc_Decode), .MemToReg(MemToReg_Decode), .RegWrite(RegWrite_Decode), .MemWrite(MemWrite_Decode), 
                            .BrTaken(BrTaken_Decode), .UncondBr(UncondBr), .UseShift(UseShift_Decode), 
                            .setFlag(setFlag_Decode), .ALUOp(ALUOp_Decode), .setFlag_DecodeRegister(setFlag_DecodeRegister));
    assign shiftAmount_Decode = instruction_FetchRegister[15:10];
///////////// FOR CONTROL LOGIC /////////////////////////////////////////////////////////////////////////////////////////////
endmodule