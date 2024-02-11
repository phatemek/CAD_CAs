module MUX4to1(a, b, c, d, sel, out);
	input [8:0] a, b, c, d;
	input[1:0] sel;
	output [8:0] out;
	assign out = (sel == 2'b00)?a:
		(sel == 2'b01)?b:
		(sel == 2'b10)?c:d;
endmodule 
