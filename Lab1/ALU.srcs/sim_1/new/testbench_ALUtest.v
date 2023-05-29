`timescale 1ns/1ps
module testbench_ALUtest();
reg clk, en;
reg [1:0] sel;
reg [5:0] x;

wire [5:0] y;
wire of;

alu_test tesbench(
    .clk(clk),
    .en(en),
    .sel(sel),
    .x(x),
    .y(y),
    .of(of)
);

always #10 clk = ~clk;
initial begin
    clk = 0;
    en = 0;
    sel = 2'b11;
    
    #30 sel = 2'b10; x = 6'h0;
    #30 sel = 2'b00; x = 6'b111111;
    #30 sel = 2'b01; x = 6'h2;
    #30 sel = 2'b10; x = 6'h1;
    #30 x = 6'h2;
    #30 x = 6'h3;
    #30 x = 6'h4;
    #30 x = 6'h5;
    #30 x = 6'h6;
    #30 x = 6'h7;
    #30 x = 6'h8;
    #30 x = 6'h9;
    //#30 $finish;
end

always #10 en = ~en;
endmodule