/**
* Testbench for the TPUMAC module
*/
module tpumac_tb();
	// DUT parameters
	localparam BITS_AB=8; 
	localparam BITS_C=16;
	// Global Signals
	logic clk, rst_n, en, WrEn;
	// DUT Input
	logic signed [BITS_AB-1:0] Ain, Bin;
	logic signed [BITS_C-1:0] Cin;
	// DUT output
	logic signed [BITS_AB-1:0] Aout, Bout;
	logic signed [BITS_C-1:0] Cout;
	// Local variables
	logic signed [BITS_AB-1:0] Atest, Ain_extra;
	logic signed [BITS_AB-1:0] Btest, Bin_extra; // can be random or high Z for tests 3-7
	logic signed [BITS_C-1:0] Ctest, Cin_extra;; // can be random or high Z for tests 3-7
	integer i;
	integer cntr; // holds the number of accumulations to be made before exiting
	// Testing Enumeration
	typedef enum {TEST0 = 0, TEST1, TEST2, TEST3, TEST4, TEST5, TEST6, TEST7, BADTEST = -1} test_value; // integer
	

	// Create instance of test block
	tpumac #(.BITS_AB(BITS_AB), .BITS_C(BITS_C)) DUT_TPU_MAC
				(
					.clk(clk), 
					.rst_n(rst_n), 
					.WrEn(WrEn), 
					.en(en), 
					.Ain(Ain), 
					.Bin(Bin), 
					.Cin(Cin), 
					.Aout(Aout), 
					.Bout(Bout), 
					.Cout(Cout)
				);

	initial begin
		// Declare test variable
		test_value curr_test;
		
		clk = 1'b0;
		rst_n = 1'b1;
		en = 1'b0;
		WrEn = 1'b1;
		Ain_extra = {BITS_AB{1'b0}};
		Bin_extra = {BITS_AB{1'b0}};
		Cin_extra = {BITS_C{1'b0}};
		
		

		// Reset 
		@(negedge clk) 
			rst_n = 1'b0; // assert reset (async active low)

		// Wait
		@(negedge clk); 
		
		// deassert reset
		@(negedge clk)
			rst_n = 1'b1; 

		// Check mac computation
		for(i = 0; i < 8; i = i + 1) begin
				// Initialize variables at neg clk edge
				@(negedge clk) begin
					curr_test = (i === 0) ? curr_test.first() : curr_test.next(); // [0-7]
					{Ain_extra, Bin_extra} = $random; // for tests 3-7
					Atest = Ain;
					Btest = Bin;
					Ctest = Cin;
					en = 1'b1; // enable registers (register initialization)
					WrEn = 1'b1; // Assert register write enable
					cntr = $urandom_range(15, 1); // maximum of 15, min:1 accumulations in test 3-7
				end
				
				@(negedge clk) begin  
					en = 1'b0; // disable enable signal
					WrEn = 1'b0; // disable result register
					{Ain_extra, Bin_extra} = {{BITS_AB{1'bx}}, {BITS_AB{1'bx}}}; // all x's
					Cin_extra = {BITS_C{1'bx}};
				end
				
				@(negedge clk) begin
					// TESTA: Check Register stored correctly (and register holds value past clk high en)
					if(Atest !== Aout || Btest !== Bout || Ctest !== Cout)
							$display("Error @ %t: Values were not stored in register", $time);
					
					
					// TESTA1: Tests that computation is done with Ain and Bin not Aout and Bout
					// Random 
					Ain_extra = $random;
					Bin_extra = $random;
					// Update test values
					Atest = Ain;
					Btest = Bin;
							
					// Update Ctest to store result of the computation
					Ctest = (Atest * Btest) + Ctest;
					
					// Enable computation
					en = 1'b1;
				end
						
				do begin
					@(negedge clk) begin
						// TESTB: Check operation computed correctly
						if(Cout !== Ctest)
								$display("Error @ %t: Result not computed correctly", $time);
						
						// Disable computation
						en = 1'b0;
					end
							
					@(negedge clk) begin
						en = 1'b1; // enable for A and B inputs
						// Random 
						Ain_extra = $random;
						Bin_extra = $random;
						// Update test values
						Atest = Ain;
						Btest = Bin;
						Ctest = (Atest * Btest) + Ctest;
					end
					
					// Update counter
					cntr = cntr - 1;
					if(cntr === 0) break; // exit loop	
				end while(curr_test >= TEST3);
		end	
	end

	// Constantly assign values to Ain, Bin and Cin
	always @(Ain_extra, Bin_extra, Cin_extra) begin
		Ain = Ain_extra;
		Bin = Bin_extra;
		Cin = Cin_extra;
	end
	
	// Create clock
	always @(clk) begin
		clk <= #5 ~clk;
	end
					
endmodule