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
<<<<<<< HEAD
	dff_en DFF1 [BUS_WIDTH - 1: 0] ( .clk(clk),
									.rst_n(rst_n),
									.d(d),
									.en(en),
									.q(q)
									);
=======
	dff_en DFF_EN1 [BUS_WIDTH - 1: 0](  .clk(clk),
																			.rst_n(rst_n),
																			.d(d),
																			.en(en),
																			.q(q)
																		 );
>>>>>>> 2c9a8f26718f14085c4ab5370d68d5d539525719
endmodule
