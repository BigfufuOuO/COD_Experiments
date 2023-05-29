module alu_test (
    input clk,
    input en,
    input [1:0]sel,
    input [5:0]x,
    output reg [5:0]y,
    output reg of
);

reg [3:0] F;
reg [5:0] A,B;
wire enf, ena, enb;

//例化decoder
decoder decoder1(
    .en(en),
    .sel(sel),
    .enf(enf),
    .ena(ena),
    .enb(enb)
);


//ALU
wire [5:0]Y;
wire O;
alu alu1(
    .a(A),
    .b(B),
    .func(F),
    .y(Y),
    .of(O)
);

//寄存器
always @(posedge clk) begin
    if(enf) F <= x[3:0];
    if(ena) A <= x;
    if(enb) B <= x;
    y <= Y;
    of <= O;
end

    
endmodule