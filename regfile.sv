
`timescale 1ns/10ps
module regfile (ReadData1, ReadData2, WriteData, ReadRegister1, ReadRegister2, WriteRegister, RegWrite, reset, clk);
	input logic clk, RegWrite, reset;
	input logic [4:0] WriteRegister;
	input logic [63:0] WriteData;
	output logic [63:0] ReadData1;
	output logic [63:0] ReadData2;
	input logic [4:0] ReadRegister1;
	input logic [4:0] ReadRegister2;
	
	
	logic [31:0] decoderOutput;
	decoder5_32 decoder (.in(WriteRegister), .out(decoderOutput), .enable(RegWrite));
	
	logic [31:0][63:0] registersInput;
	logic [31:0][63:0] registersOutput;

	always_ff @(posedge clk) begin 
	    if (RegWrite && WriteRegister == 5'd1)
			$display("Regfile WriteRegister: %0d, WriteData: %0h, RegWrite: %0b", WriteRegister, WriteData, RegWrite);
	end 

	genvar i;
	generate
		for (i = 0; i < 32; i++) begin : registers
			assign registersInput[i] = WriteData;
		end
	endgenerate
	
	registers_32 register32 (.in(registersInput), .out(registersOutput), .clk(clk), .reset(reset), .enables(decoderOutput));
	
	mux32_1_64 mux1 (.in(registersOutput), .out(ReadData1), .sel(ReadRegister1));
	mux32_1_64 mux2 (.in(registersOutput), .out(ReadData2), .sel(ReadRegister2));
endmodule
