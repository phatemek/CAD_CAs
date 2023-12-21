module PU(x1, w1, x2, w2, x3, w3, x4, w4, clk, rst, out);
input [4:0] x1, x2, x3, x4, w1, w2, w3, w4;
input clk, rst;
output [4:0] out;
wire [9:0] mres1, mres2, mres3, mres4, mreg1, mreg2, mreg3, mreg4;
wire [10:0] addres1, addres2;
wire [11:0] addres3;
Multiplier mul1(x1, w1, mres1);
Multiplier mul2(x2, w2, mres2);
Multiplier mul3(x3, w3, mres3);
Multiplier mul4(x4, w4, mres4);

reg10bit reg1(mres1, clk, rst, mreg1);
reg10bit reg2(mres2, clk, rst, mreg2);
reg10bit reg3(mres3, clk, rst, mreg3);
reg10bit reg4(mres4, clk, rst, mreg4);
Adder11 add1(mreg1, mreg2, addres1);
Adder11 add2(mreg3, mreg4, addres2);
Adder12 add3(addres1, addres2, addres3);
Actfun myfun(addres3, out);
endmodule
