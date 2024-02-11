module adder(a, b, out);
input [8:0] a;
input [8:0] b;
output [8:0] out;
assign out = a + b;
endmodule