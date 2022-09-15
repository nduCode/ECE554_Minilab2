/**
* This is the dff module with an enable
*/
module register
	#(parameter BUS_WIDTH = 8)
	(
	// Input
	input clk,
	input rst_n,
	input logic signed [BUS_WIDTH - 1: 0] d,
	input en, // enable signal for flip flop
	// Output
	output logic signed [BUS_WIDTH - 1: 0] q
	); 
	
	// enabled DFF arrays
	dff_en [BUS_WIDTH - 1: 0] DFF1 ( .clk(clk),
																	.rst_n(rst_n),
																	.d(d),
																	.en(en),
																	.q(q)
																 );
endmodule
