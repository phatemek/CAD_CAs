module MAC(rst, macrst, clk, buff16, filter, out);
input rst, macrst, clk;
input [127:0] buff16, filter;
output reg [7:0] out;
reg [3:0] cnt;
reg [15:0] mult16;
reg [7:0] mult;
reg [11:0] sum;
always@(posedge clk) begin
	if(macrst | rst) cnt = 0;
	else cnt = cnt + 1;
end
always@(posedge clk) begin
	if(macrst | rst) sum = 8'b0;
	else begin
		mult16 = buff16[8*cnt+:8]*filter[8*cnt+:8];
	 	sum = sum + mult16[15:8];
		out = sum[11:4];
	end
end
endmodule