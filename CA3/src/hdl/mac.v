module mac #(parameter N = 127) (regA, regB, clk, rst, cnt, res);
	parameter M = (N == 127)?3:5;
	parameter L = (N == 127)?11:13;
	input [N:0] regA, regB;
	input clk, rst;
	input [M:0] cnt;
	output[7:0] res;
	reg [15:0] tmp;
	reg [L:0] restmp;
	assign res = restmp[11:4];
	always @(posedge clk, posedge rst) begin
		if (rst == 1) begin
			restmp = 8'b0;
		end
		else begin
			tmp =  (regA[8 * cnt +: 8]) * (regB[8 * cnt +: 8]);
			restmp = restmp + (tmp[15:8]);
		end
	end
endmodule
