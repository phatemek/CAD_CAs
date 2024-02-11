module cntr13(clk, rst, cnt_en, cnt, co);
input clk, rst, cnt_en;
output co;
output reg [3:0] cnt;
always@(posedge clk) begin
	if(rst | cnt == 4'b1101) cnt = 4'b0;
	else if(cnt_en) cnt = cnt + 1;
end
assign co = (cnt == 4'b1101);
endmodule