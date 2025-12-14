`timescale 1ns/10ps

module fetchStage (clk, reset, BrTaken_Decode, instruction_Fetch, programCounter_Fetch, branchAddress_Decode);
    input logic BrTaken_Decode, clk, reset;
    input logic [63:0] branchAddress_Decode;
    output logic [31:0] instruction_Fetch;
    output logic [63:0] programCounter_Fetch;

    // Grab the output of the program counter
    logic [63:0] nextPC;
    programCounter counter (.clk(clk), .reset(reset), .enable(1'b1), .nextPC(nextPC), .currentPC(programCounter_Fetch));

    // Access instruction memory
    instructmem memory (.address(programCounter_Fetch), .instruction(instruction_Fetch), .clk(clk));

    // Full adder used to compute PC + 4 (Branching considered later)
    logic [63:0] adder2Output;
    fullAdder_64 adder (.input1(programCounter_Fetch), .input2(64'd4), .finalResult(adder2Output)); 

    // Use a 2:1 mux to determine which PC address to output
    mux2_1_64 mux1 (.in({branchAddress_Decode, adder2Output}), .out(nextPC), .sel(BrTaken_Decode));
endmodule