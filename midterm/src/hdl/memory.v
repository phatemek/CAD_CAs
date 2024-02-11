module memory(clk, rst, inp, wen, addr, out, done);
input clk, rst, wen, done;
input [7:0] inp;
input [8:0] addr;
output wire [31:0] out;
reg [63:0] hex;
reg [31:0] mem [127:0];
initial $readmemh("./file/input.txt", mem);
wire [1:0] mod;
assign mod = 2'b11 - addr[1:0];
always@(posedge clk) begin
	if(rst)$readmemh("./file/input.txt", mem);
	else if(wen) begin mem[addr[8:2]][mod*8 +: 8] = inp; end
end
integer output_file, i;
always@(posedge done) begin
	output_file = $fopen("./file/result.txt", "w");
	for(i = 0; i < 128; i = i+1) begin
		$sformat(hex, "%h", mem[i]);
		$fwrite(output_file, "%s\n", hex);
	end
	$fclose(output_file);
end
assign out = mem[addr[8:2]];
endmodule