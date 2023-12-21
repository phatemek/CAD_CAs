module Mux2to1(a, b, sel, c);
	input [4:0] a, b;
	input sel;
	output [4:0] c;
	C2 myc2(a[0], a[0], b[0], b[0], sel, sel, sel, sel, c[0]); 
	C2 myc21(a[1], a[1], b[1], b[1], sel, sel, sel, sel, c[1]);
	C2 myc22(a[2], a[2], b[2], b[2], sel, sel, sel, sel, c[2]);
	C2 myc23(a[3], a[3], b[3], b[3], sel, sel, sel, sel, c[3]);
	C2 myc24(a[4], a[4], b[4], b[4], sel, sel, sel, sel, c[4]);
endmodule    