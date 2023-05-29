`timescale 1ns/1ps
module testbench_fls ();
    reg clk, en, rst;
    reg [6:0] d;
    wire [6:0] f;

    fls fls1(
        .clk(clk),
        .en(en),
        .rst(rst),
        .d(d),
        .B(f)
    );

always #2 clk = ~clk;

initial begin
    clk = 0;
    en = 0;
    d = 7'h0;
    rst = 1'b1;
    #3 rst = 1'b0;
end

always #10 en = ~en;
initial begin
    d = 7'h2;
    #20 d = 7'h3;
    #20 d = 7'h4;
    #20 d = 7'h5;
    #20 $finish;
end

endmodule