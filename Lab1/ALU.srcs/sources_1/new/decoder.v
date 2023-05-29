module decoder (
    input en, 
    input [1:0] sel,
    output ena, enb ,enf
);
    assign ena = en & (sel == 2'b00);
    assign enb = en & (sel == 2'b01);
    assign enf = en & (sel == 2'b10);
endmodule