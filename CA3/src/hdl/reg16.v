module reg16bit(a, clk, rst, en, b);
	input [127:0] a;
	input clk, rst, en;
	output reg [127:0] b;
	always @(posedge clk, posedge rst)begin
		if (rst) b = 0;
		else if (en) b <= a;
	end
endmodule
