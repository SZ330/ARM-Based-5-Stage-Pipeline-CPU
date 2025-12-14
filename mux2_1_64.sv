`timescale 1ns/10ps

module mux2_1_64 (in, out, sel);
	input logic [1:0][63:0] in;
	output logic [63:0] out;
	input logic sel;
	
	genvar j;
	generate
		for (j = 0; j < 64; j++) begin : eachMuxes
			logic [1:0] muxInput;
            assign muxInput[0] = in[0][j];
            assign muxInput[1] = in[1][j];
			mux2_1 muxes (.i(muxInput), .out(out[j]), .sel(sel));
		end
	endgenerate
endmodule

module mux2_1_64_testbench ();
	logic [1:0][63:0] in;
	logic [63:0] out;
	logic sel;

	mux2_1_64 dut (.in(in), .out(out), .sel(sel));

	initial begin	
		integer i;
   			for (i = 0; i < 64; i = i + 1) begin
      		in[0][i] = (i % 2);       // 010101...
      		in[1][i] = ~in[0][i];     // 101010...
    	end

		// Apply a few selector values
		sel = 1'b0; #10000; 
		sel = 1'b1; #10000;;
		$finish;
	end
endmodule