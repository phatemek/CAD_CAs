module buffer16(clk, rst, inp, addr, wen, out);
input clk, rst, wen;
input [31:0] inp;
input [6:0] addr;
output wire [0:127] out;
reg [0:127] buff;
always@(posedge clk) begin
	if(wen) buff[addr +: 32] = inp;
end
assign out = buff[0:127];
endmodule