module Layer2 #(parameter N = 1) (clk, rst, iX, encnt64, enn, enX, enY, enZ, encnt16, en64, en16A, encnt4, en16B, rst16, rstmac, 
	enPX, enW, rst4, sel, CO64, CON, CO16, CO4, COPX, COPY, done);
	input clk, rst, encnt64, enn, enX, enY, enZ, encnt16, en64, en16A, encnt4, en16B, rst16, rstmac, enPX, enW, rst4, done;
	input [1:0] sel;
	input [8:0] iX;
	output  CON, CO64, CO16, CO4, COPX, COPY;
	wire enPY;
	assign enPY = COPX & enPX;
	wire [8:0] X, Y, XP, YP,  RD, Y3XP, Y3X;
	wire [511:0] reg64;
	wire [3:0] posX, posY;
	wire [3:0] cnt16;
	wire [1:0] cnt4;
	wire [5:0] cnt64;
	wire [7:0] WR, YX, realYX;
	wire [31:0] kernel_out[N - 1:0];
	wire [31:0] memout[N - 1:0];
	assign YX = {posY, posX} - posY - posY - posY - posY - posY - posY;
	assign realYX = posX + (posY + cnt4) * 8'd13;
	cnt6bit mycnt6bit(clk, rst, encnt64, 6'd63, cnt64, CO64);
	sreg64bit mysreg64(memout[0], memout[1], memout[2], memout[3], clk, rst, en16B, reg64);
	cnt4bit mycnt1(clk, rst16 | rst, encnt16, 4'b1111, cnt16, CO16);
	cnt2bit mycnt2(clk, rst4 | rst, encnt4, 2'b11, cnt4, CO4);
	reg9 myX(iX, clk, rst, enX, X);
	Adder myadder1(X, {3'b0, cnt16, 2'b0}, XP);
	cnt4bit mycnt3(clk, rst, enPX, 4'b1001, posX, COPX);
	cnt4bit mycnt4(clk, rst, enPY, 4'b1001, posY, COPY);

	genvar i;
  	generate
    	for(i=1; i<= N; i=i+1)begin
		localparam PARAM_i = i;
		mem3 #(PARAM_i) mymem3(clk, rst, XP, kernel_out[i - 1]);
		mem2 #(PARAM_i) mymem2(clk, rst, {1'b0, realYX}, memout[i - 1]);
      		PE #(PARAM_i, 511) myPE(kernel_out[i - 1], reg64, YX, en16A, clk, rst, rstmac, cnt64, enW, done);
    	end
  	endgenerate

endmodule
