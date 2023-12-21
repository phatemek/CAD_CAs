module Adder11(a, b, out);
	input [9:0] a, b;
	output [10:0] out;
	wire [10:0] c;
	FA FA1(a[0], b[0], 1'b0, c[0], out[0]);
	FA FA2(a[1], b[1], c[0], c[1], out[1]);
	FA FA3(a[2], b[2], c[1], c[2], out[2]);
	FA FA4(a[3], b[3], c[2], c[3], out[3]);
	FA FA5(a[4], b[4], c[3], c[4], out[4]);
	FA FA6(a[5], b[5], c[4], c[5], out[5]);
	FA FA7(a[6], b[6], c[5], c[6], out[6]);
	FA FA8(a[7], b[7], c[6], c[7], out[7]);
	FA FA9(a[8], b[8], c[7], c[8], out[8]);
	FA FA10(a[9], b[9], c[8], c[9], out[9]);
	FA FA11(a[9], b[9], c[9], c[10], out[10]);
endmodule	 