module sreg16bit  #(parameter N = 127) (a, clk, rst, en, b);
	input [31:0] a;
	input clk, rst, en;
	output reg [N:0] b;
	always @(posedge clk, posedge rst)begin
		if (rst) b = 0;
		else if (en) b <= {b[N - 31 - 1:0], a};
	end
endmodule
