module tpumac_tb;

logic clk, rst_n, en, WrEn;
logic signed [BITS_AB-1:0] Ain, Bin, Aout, Bout;
logic signed [BITS_C-1:0] Cin, Cout;
integer curr_test;
logic signed [BITS_AB-1:0] Atest, Btest, Ctest;
integer i;

tpumac #(.BITS_AB(BITS_AB), .BITS_C(BITS_C))
(.clk(clk), .rst_n(rst_n), .WrEn(WrEn), .en(en), .Ain(Ain), .Bin(Bin), .Cin(Cin), .Aout(Aout), .Bout(Bout), .Cout(Cout));

parameter   TEST0 = 0,
            TEST1 = 1,
            TEST2 = 2,
            TEST3 = 3,
            TEST4 = 4,
            TEST5 = 5,
            TEST6 = 6,
            TEST7 = 7;

logic [2:0] curr_test, nxt_test;

initial begin
    clk = 1'b0;
    rst_n = 1'b1;
    en = 1'b0;
    WrEn = 1'b1;
    Ain = 'b0;
    Bin = 'b0;
    Cin = 'b0;
    current_test = 0; // integer

    // Reset 
    @(negedge clk);
    rst_n = 1'b0; // assert reset (async active low)

    // Wait
    repeat(2) @(negedge clk); 

    rst_n = 1'b1; // deassert reset

    // Check mac computation
    for(i = 0; i < 8; i = i + 1) begin
        @(negedge clk);

        curr_test = i;
        Atest = Ain;
        Btest = Bin;
        Ctest = Cin;

        en = 1'b1; // enable registers

        // Assert register write enable
        WrEn = 1'b1;

        @(negedge) clk; 
        en = 1'b0; // disable enable signal
        WrEn = 1'b0; // disable result register

        // TEST1: Check Register stored correctly
        curr_test = -2;

        if(Atest !== Aout || Btest !== Bout || Ctest !== Cout)
            $display("Error: Values were not stored in register");
        
        // Check operation
        if(Cout !== (Atest * Btest) + Ctest) begin
            $display("Result not computed correctly")
        end
    end
    
    

    
    
end
    
always begin
    clk <= #5 ~clk;
end

always @(posedge clk) begin
    if (~rst_n) begin
        curr_test <= TEST0;
    end
    else curr_test <= nxt_test;
end

always @(curr_test) begin
    case (curr_test)
        TEST0: begin
            Cin = 1;
            Ain = 0;
            Bin = 1;
        end
        TEST1: begin
            Cin = 1;
            Ain = 0;
            Bin = 1;
        end
        TEST2: begin
            Cin = 1;
            Ain = 0;
            Bin = 1;
        end        
        TEST3: begin
            Cin = 1;
            Ain = 0;
            Bin = 1;
        end        
        TEST4: begin
            Cin = 1;
            Ain = 0;
            Bin = 1;
        end            
        TEST5: begin
            Cin = 1;
            Ain = 0;
            Bin = 1;
        end
        TEST6: begin
            Cin = 1;
            Ain = 0;
            Bin = 1;
        end
        TEST7: begin
            Cin = 1;
            Ain = 0;
            Bin = 1;
        end
        default: begin
            Cin = 1;
            Ain = 0;
            Bin = 1;
        end
endmodule