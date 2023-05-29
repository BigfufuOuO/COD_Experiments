module fls (
    input clk, rst, en,
    input [6:0] d, //输入数列初始项
    output reg [6:0] B //输出数列，即为B
);

//一周期按钮
wire button_edge;
reg button1, button2;
always@(posedge clk) button1 <= en;
always@(posedge clk) button2 <= button1;
assign button_edge = button1 & ~button2;

//fsm
wire [1:0] sel;//选择信号，选择mux
fsm fsm1(
    .clk(clk),
    .en(en),
    .rst(rst),
    .state(sel)
);

//ALU
reg[6:0] A;//寄存器A
wire[6:0] o;
alu #7 alu1(
    .a(A),
    .b(B),
    .func(4'b0000),
    .y(o)
);


always@(posedge clk)
begin
    if (rst) A <= 7'h0;
    else if(button_edge) begin
    case (sel)
        2'b00: A <= d;
        2'b10: A <= B;//
        default: A <= A;
    endcase
    end
end

//寄存器F
always @(posedge clk) begin
    if(rst) B <= 7'b0;
    else if(button_edge) begin
    case (sel)
        2'b00: B <= d;
        2'b01: B <= d;
        2'b10: B <= o;
        default: B <= B;
    endcase
    end 
end
    
endmodule