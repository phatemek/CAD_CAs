module C2(d00, d01, d10, d11, a1, b1, a0, b0, out);
	input d00, d01, d10, d11, a1, b1, a0, b0;
	output out;
	wire s1, s0;
	assign s1 = a1 || b1;
	assign s0 = a0 && b0;
	assign out = {s1, s0} == 2'b00 ? d00:
	     	{s1, s0} == 2'b01 ? d01:
	     	{s1, s0} == 2'b10 ? d10: d11;
endmodule
