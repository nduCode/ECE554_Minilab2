// Spec v1.1
module tpumac
 #(parameter BITS_AB=8,
   parameter BITS_C=16)
  (
   input clk, rst_n, WrEn, en,
   input signed [BITS_AB-1:0] Ain,
   input signed [BITS_AB-1:0] Bin,
   input signed [BITS_C-1:0] Cin,
   output reg signed [BITS_AB-1:0] Aout,
   output reg signed [BITS_AB-1:0] Bout,
   output reg signed [BITS_C-1:0] Cout
  );
// NOTE: added register enable in v1.1
// Also, Modelsim prefers "reg signed" over "signed reg"


	
	// enabled Register A
	register #(BUS_WIDTH = BITS_AB) REG8_A (.clk(clk),
																					.rst_n(rst_n),
																					.d(d),
																					.en(en),
																					.q(Aout)
																				 );
																		 
	// enabled Register B																	 
	register #(BUS_WIDTH = BITS_AB) REG8_B  ( .clk(clk),
																						.rst_n(rst_n),
																						.d(d),
																						.en(en),
																						.q(Bout)
																					 );
																					 
																					 
	// enabled Register C																				 																	 
	register #(BUS_WIDTH = BITS_C) REG16_C  (  .clk(clk),
																						.rst_n(rst_n),
																						.d(d),
																						.en(en),
																						.q(Cout)
																					 );

endmodule