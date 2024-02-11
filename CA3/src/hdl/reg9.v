module reg9(a, clk, rst, en, b);
	input [8:0] a;
	input clk, rst, en;
	output reg [8:0] b;
	always @(posedge clk, posedge rst)begin
		if (rst) b = 0;
		else if (en) b <= a;
	end
endmodule