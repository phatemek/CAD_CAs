module cntnbit #(parameter N = 1) (clk, rst, en, cnt, co);
	input clk, rst, en;
	output reg [$clog2(N):0] cnt;
	output wire co;
	assign co = (cnt == N) ? 1:0;
	always @(posedge clk, posedge rst)begin
		if (rst) cnt <= 0;
		else if(en == 0) cnt <= cnt;
		else if(cnt == N) cnt <= 0;
		else cnt <= cnt + 1;
	end
endmodule
