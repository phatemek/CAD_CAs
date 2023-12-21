module controller(clk, rst, start, zer, wen, wenep, sel, done);
	input clk, rst, start, zer;
	output wen, wenep, sel, done;
	wire Q1, Q2, Q3, Q21, Q22, Q23, Q31, Q32, wen2;
	S2 newQ1(1'b0, 1'b1, 1'b0, 1'b0, Q1, zer, Q2, Q3, rst, clk, Q1);
	C2 newQ21(1'b0, 1'b0, 1'b1, 1'b0, Q2, Q2, Q3, Q3, Q21);
	C2 newQ22(1'b0, 1'b0, 1'b0, 1'b1, Q2, Q2, zer, zer, Q22);
	C2 newQ23(1'b0, 1'b1, 1'b0, 1'b0, Q2, start, Q3, Q3, Q23);
	S2 newQ2(Q23, Q23, 1'b1, 1'b1, Q21, Q22, 1'b1, 1'b1, rst, clk, Q2);
	C2 newQ31(1'b0, 1'b0, 1'b1, 1'b0, Q2, Q2, Q3, Q3, Q31);
	C2 newQ32(1'b0, 1'b1, 1'b0, 1'b0, Q1, Q2, start, start, Q32);
	S2 newQ3(1'b0, 1'b0, 1'b1, 1'b1, Q31, Q32, 1'b1, 1'b1, rst, clk, Q3);
	C2 newwen1(1'b0, 1'b1, 1'b0, 1'b0, Q1, Q2, Q3, Q3, wenep);
	C2 newwen2(1'b0, 1'b1, 1'b0, 1'b0, Q1, Q1, Q2, Q3, sel);
	C2 newwen(1'b0, 1'b0, 1'b1, 1'b1, wenep, sel, 1'b1, 1'b1, wen);
	C2 newdone(1'b0, 1'b1, 1'b0, 1'b0, Q2, Q3, Q1, Q1, done);
endmodule
