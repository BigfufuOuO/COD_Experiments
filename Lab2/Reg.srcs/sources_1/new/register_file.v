module register_file #(parameter WIDTH = 32) (
    input clk,
    input [4:0] ra0, //读端口0地址
    output [WIDTH-1:0] rd0, //读端口0数据
    input [4:0] ra1, //读端口1地址
    output [WIDTH-1:0] rd1, //读端口1数据
    input [4:0] wa, //写端口地址
    input we, //写使能
    input [WIDTH-1:0] wd //写端口数据
);

reg [WIDTH-1:0] regfile[0:31];
assign rd0 = regfile[ra0];
assign rd1 = regfile[ra1];
initial begin
    regfile[0] = 0;
end

always @(posedge clk) begin
    if(we && wa != 0) regfile[wa] <= wd;
end
endmodule