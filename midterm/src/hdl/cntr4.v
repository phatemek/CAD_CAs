module cntr4(clk, rst, cnt, co);
input clk, rst;
output co;
output reg [1:0] cnt;
always@(posedge clk) begin
	if(rst) cnt = 2'b0;
	else cnt = cnt + 1;
end
assign co = &{cnt};
endmodule