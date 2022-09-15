module tpumac_tb;

logic clk, rst_n, en, WrEn;
logic signed [BITS_AB-1:0] Ain, Bin, Aout, Bout;
logic signed [BITS_C-1:0] Cin, Cout;

tpumac #(.BITS_AB(BITS_AB), .BITS_C(BITS_C))
(.clk(clk), .rst_n(rst_n), .WrEn(WrEn), .en(en), .Ain(Ain), .Bin(Bin), .Cin(Cin), .Aout(Aout), .Bout(Bout), .Cout(Cout));

initial begin
    rst_n = 0;
    clk <= 0;
    #5 rst_n = 1;
end

always @(posedge clk) begin
    clk <= ~clk;
    #5;
end



endmodule