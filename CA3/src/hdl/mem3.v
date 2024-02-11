module mem3 #(parameter N = 1) (clk, rst, addr, out);
	input clk, rst;
	input [8:0]addr;
	output [31:0] out;
	reg [63:0] hex_char;
	integer i, DataMemFile;
	reg[31:0] DataMem[127:0];
	assign out = DataMem[addr >> 2];
	always @(posedge clk, posedge rst) begin
		if (rst) $readmemh($sformatf("./file/Filter%0d_L2.txt", N), DataMem);
	end
endmodule
