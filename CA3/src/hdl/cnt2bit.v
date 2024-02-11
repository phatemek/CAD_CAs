module cnt2bit(clk, rst, en, u, cnt, co);
	input clk, rst, en;
	input [1:0] u;
	output reg [1:0] cnt;
	output wire co;
	assign co = (u == cnt)?1:0;
	always @(posedge clk, posedge rst)begin
		if (rst) cnt <= 0;
		else if(en == 0) cnt <= cnt;
		else if(cnt == u) cnt <= 0;
		else cnt <= cnt + 1;
	end
endmodule
