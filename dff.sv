/**
* This is the dff module
*/
module dff(
	// Input
	input clk,
	input rst_n,
	input d,
	// Output
	output q
	); 

	always @(posedge clk, negedge rst_n) 
		if(!rst_n)
			q <= 1'b0;
		else
			q <= d;

endmodule
