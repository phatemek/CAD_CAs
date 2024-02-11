module mem2 #(parameter N = 1) (clk, rst, addr, out);
	input clk, rst;
	input [8:0]addr;
	output [31:0] out;
	wire [31:0] tmpout, tmpout2;
	reg [63:0] hex_char;
	integer i, DataMemFile;
	reg[31:0] DataMem[127:0];
	assign tmpout = DataMem[addr >> 2];
	assign tmpout2 = DataMem[(addr >> 2) + 1];
	wire [1:0] remi;
	assign remi = 3 - addr[1:0];
	assign out = (remi == 2'd3)? tmpout:
		(remi == 2'd2)?{tmpout[23:0], tmpout2[31:24]}:
		(remi == 2'd1)?{tmpout[15:0], tmpout2[31:16]}:{tmpout[7:0], tmpout2[31:8]};
	always @(posedge clk, posedge rst) begin
		if (rst) $readmemh($sformatf("./file/output%0d_L1.txt", N), DataMem);
	end
endmodule