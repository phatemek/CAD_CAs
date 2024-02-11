module buffer64(clk, rst, meminp, addr, wen, out);
input clk, rst, wen;
input [31:0] meminp;
input [8:0] addr;
output wire [31:0] out;
reg [0:511] buff;
always@(posedge clk) begin
	if(rst) buff = 512'b0;
	else if(wen) buff[addr +: 32] = meminp;
end
assign out = buff[addr +: 32];
endmodule