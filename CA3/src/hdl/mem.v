module mem(clk, rst, addr, out, done);
	input clk, rst, done;
	input [8:0]addr;
	output [31:0] out;
	reg [63:0] hex_char;
	integer i, DataMemFile;
	reg[31:0] DataMem[127:0];
	assign out = DataMem[addr >> 2];
	wire [1:0] remi;
	assign remi = 3 - addr[1:0];
	always @(posedge clk, posedge rst) begin
		if (rst) $readmemh("./file/input.txt", DataMem);
	end
endmodule
