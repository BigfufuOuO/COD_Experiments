module register_new(
    input clk,
    input [2:0] ra0, //读端口0地址
    output [3:0] rd0, //读端口0数据
    input [2:0] ra1, //读端口1地址
    output [3:0] rd1, //读端口1数据
    input [2:0] wa, //写端口地址
    input we, //写使能
    input [3:0] wd //写端口数据
);

reg [3:0] regfile[0:7];
assign rd0 = regfile[ra0];
assign rd1 = regfile[ra1];
initial begin
    regfile[0] = 0;
end

always @(posedge clk) begin
    if(we && (wa != 0)) regfile[wa] <= wd;
end
endmodule