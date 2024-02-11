module reg64bit(a, addr, clk, rst, en, b, res);
	input [31:0] a;
	input clk, rst, en;
	input [3:0] addr;
	wire [8:0] naddr;
	assign naddr = (9'd511) - addr * 8;
	output reg [511:0] b;
	output [127:0]res;
	always @(posedge clk, posedge rst)begin
		if (rst) b = 0;
		else if (en) b <= {b[479:0], a};
	end
	assign res = {b[naddr -: 32], b[naddr - 128 -: 32], b[naddr - 256 -: 32], b[naddr - 384 -: 32]};
endmodule
