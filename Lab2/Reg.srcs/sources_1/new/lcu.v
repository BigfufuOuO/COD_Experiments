module LCU (
    input clk, rst,
    input [3:0] in,
    input enq, deq,
    input [3:0]rd0, //读数据 4位
    output [2:0] ra0, //读地址 2^3位
    output reg [3:0] out,
    output full, 
    output emp,
    output [2:0] wa,//写地址 4位
    output [3:0] wd,//写数据 2^3位
    output we,
    output reg [7:0] valid
);
    
reg [2:0] RP;//read pointer
reg [2:0] WP;//write pointer

assign full = &valid;
assign emp = ~(|valid);

/*assign wa = WP;
assign wd = in;
assign we = enq & ~full & ~rst;
assign ra0 = RP;*/

wire [1:0] state;
fsm fsm1(
    .clk(clk),
    .rst(rst),
    .enq(enq),
    .deq(deq),
    .full(full),
    .emp(emp),
    .state(state)
);

assign we = enq & !full & !rst;
assign wa = WP;
assign wd = in;
assign ra0 = RP;

always@(*) begin
    case (state)
        2'b00:  begin
            valid <= 8'h0;
            out <= 3'h0;
            WP <= 3'h0;
            RP <= 3'h0;
        end
        2'b01: begin
            //if(enq & !full) begin
            //wa <= WP;
            //wd <= in;
            WP <= WP + 1;
            valid[WP] <= 1'b1;
            //end
        end
        2'b10: begin
            //if(deq & !emp) begin
            out <= rd0;
            RP <= RP + 1;
            valid [RP] <= 1'b0;
            //end
        end
        //default: 
    endcase    
end
endmodule