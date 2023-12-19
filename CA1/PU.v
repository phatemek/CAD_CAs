module PU(x1, w1, x2, w2, x3, w3, x4, w4, clk, rst, out);
input [31:0] x1, x2, x3, x4, w1, w2, w3, w4;
input clk, rst;
output [31:0] out;
wire [31:0] mres1, mres2, mres3, mres4, mreg1, mreg2, mreg3, mreg4, addres1, addres2, addres3;
FloatingPointMultiplier mul1(x1, w1, mres1);
FloatingPointMultiplier mul2(x2, w2, mres2);
FloatingPointMultiplier mul3(x3, w3, mres3);
FloatingPointMultiplier mul4(x4, w4, mres4);

x_reg reg1(mres1, 1'b1, clk, rst, mreg1);
x_reg reg2(mres2, 1'b1, clk, rst, mreg2);
x_reg reg3(mres3, 1'b1, clk, rst, mreg3);
x_reg reg4(mres4, 1'b1, clk, rst, mreg4);
FloatingPointAdder add1(mreg1, mreg2, addres1);
FloatingPointAdder add2(mreg3, mreg4, addres2);
FloatingPointAdder add3(addres1, addres2, addres3);
assign out = (addres3[31]?32'b0: addres3);
endmodule