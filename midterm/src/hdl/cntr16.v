module cntr16(clk, rst, cnt, co);
input clk, rst;
output co;
output reg [3:0] cnt;
always@(posedge clk) begin
	if(rst) cnt = 4'b0;
	else cnt = cnt + 1;
end
assign co = &{cnt};
endmodule