`timescale 1ns/1ps
module tb_reg ();
    reg clk, we;
    reg [4:0] ra0, ra1, wa;
    reg [31:0] wd;

    wire [31:0] rd0, rd1;

register_file reg1(
    .clk(clk),
    .ra0(ra0),
    .rd0(rd0),
    .ra1(ra1),
    .rd1(rd1),
    .wa(wa),
    .we(we),
    .wd(wd)
);
reg [4:0] i;
always #5 clk = ~clk;
initial begin
    clk = 0;
    we = 0;
    wa = 5'b0;
    wd = 32'h1;
    ra1 = 5'b0;
    #10 we = 1'b1;
    for (i=0; i<32; i=i+1) begin
    #10 wd = i+1; wa = i; ra0 = i-1;
    end
    ra0 = i;
end




endmodule