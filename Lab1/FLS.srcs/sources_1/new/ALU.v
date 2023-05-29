module alu #(parameter WIDTH = 6)//数据宽度
(
    input [WIDTH-1:0] a,b, //量操作数
    input [3:0] func, //操作功能
    output reg [WIDTH-1:0] y, //运算结果
    output reg of //溢出标志, 溢出时置1
);

always @(*) begin
    of = 1'b0;
    y = 0;
    case (func)
        4'b0000: begin
            y = a + b;
            of = (a[WIDTH-1] & b[WIDTH-1] & ~y[WIDTH-1]) | (~a[WIDTH-1] & ~b[WIDTH-1] & y[WIDTH-1]);
        end
        4'b0001: begin
            y = a - b;
            of = (a[WIDTH-1] & ~b[WIDTH-1] & ~y[WIDTH-1]) | (~a[WIDTH-1] & b[WIDTH-1] & y[WIDTH-1]);
        end
        4'b0010: y = (a==b);
        4'b0011: y = (a<b);
        4'b0101: y = a&b;
        4'b0110: y = a|b;
        4'b0111: y = a^b;
        default: y = 0;
    endcase
end
    
endmodule