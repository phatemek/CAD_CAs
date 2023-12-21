module maxfinder(clk, rst, start, x1, x2, x3, x4, eps, done, result);
input clk, start, rst;
input [4:0] x1, x2, x3, x4, eps;
output done;
output [4:0] result;
wire wen, wenep, sel, zer;
DataPath datapath(clk, rst, x1, x2, x3, x4, eps, wen, wenep, sel, zer, result);
controller con(clk, rst, start, zer, wen, wenep, sel, done);
endmodule
