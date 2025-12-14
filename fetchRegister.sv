`timescale 1ns/10ps

module fetchRegister (clk, reset, instruction_Fetch, programCounter_Fetch, instruction_FetchRegister, programCounter_FetchRegister);
    input logic clk, reset;
    input logic [31:0] instruction_Fetch;
    input logic [63:0] programCounter_Fetch;
    output logic [31:0] instruction_FetchRegister;
    output logic [63:0] programCounter_FetchRegister;

    genvar i;
    generate
        for (i = 0; i < 32; i++) begin: instructionDFF
            D_FF_enable instructionDFF (.q(instruction_FetchRegister[i]), .d(instruction_Fetch[i]), .reset(reset), .clk(clk), .enable(1'b1));
        end
    endgenerate

    genvar j;
    generate
        for (j = 0; j < 64; j++) begin: pcDFF 
            D_FF_enable programCounterDFF (.q(programCounter_FetchRegister[j]), .d(programCounter_Fetch[j]), .reset(reset), 
                                        .clk(clk), .enable(1'b1));
        end
    endgenerate
endmodule