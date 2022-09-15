module tpumac_tb;

logic clk, rst_n, en, WrEn;

initial begin
    
always @(posedge clk) begin
    clk = ~clk;
end