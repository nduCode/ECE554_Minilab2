module tpumac_tb;

logic clk, rst_n, en, WrEn;


always @(posedge clk) begin
    clk = ~clk;
end