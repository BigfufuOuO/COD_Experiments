module fsm (
    input clk, en, rst,
    output [1:0] state
);
    
reg [1:0] curr_state;
reg [1:0] next_state;

parameter init = 2'b00;
parameter a_ld = 2'b01;//a装载完成
parameter b_ld = 2'b10;//b装载完成

//一周期按钮
wire button_edge;
reg button1, button2;
always@(posedge clk) button1 <= en;
always@(posedge clk) button2 <= button1;
assign button_edge = button1 & ~button2;

//三段式
always @(posedge clk) begin
    if(rst) curr_state <= init;
    else if(button_edge) curr_state <= next_state;
end

always @(*) begin
    case (curr_state)
        init: next_state = a_ld;
        a_ld: next_state = b_ld;
        b_ld: next_state = b_ld; 
        default: next_state = init;
    endcase
end

assign state = curr_state;
endmodule