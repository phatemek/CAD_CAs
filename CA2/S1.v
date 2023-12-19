module S1(d00, d01, d10, d11, a1, b1, a0, clr, clk, out);
input d00, d01, d10, d11, a1, b1, a0, clr, clk;
output reg out;
wire s1, s0, d;
assign s1 = a1 || b1;
assign s0 = a0 && clr;
assign d = {s1, s0} == 2'b00 ? d00 :
	   {s1, s0} == 2'b01 ? d01 :
	   {s1, s0} == 2'b10 ? d10 : d11;
always@(posedge clk) begin
	if (clr) out = 1'b0;
	else out = d;
end
endmodule