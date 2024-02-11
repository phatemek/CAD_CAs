module sreg64bit(a, b, c, d, clk, rst, en, res);
	input [31:0] a, b, c, d;
	input clk, rst, en;
	reg [127:0] tmpa, tmpb, tmpc, tmpd;
	output [511:0] res;
	always @(posedge clk, posedge rst)begin
		if (rst)begin tmpa = 0; tmpb = 0; tmpc = 0; tmpd = 0;end
		else if (en)begin
			tmpa = {tmpa[127 - 32:0], a};
			tmpb = {tmpb[127 - 32:0], b};
			tmpc = {tmpc[127 - 32:0], c};
			tmpd = {tmpd[127 - 32:0], d};
		end
	end
	assign res = {tmpa, tmpb, tmpc, tmpd};
endmodule
