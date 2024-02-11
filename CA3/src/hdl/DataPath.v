module DataPath #(parameter N = 1) (clk, rst, iX, iY, enn, enX, enY, enZ, encnt16, en64, en16A, encnt4, en16B, rst16, rstmac, 
	enPX, enW, rst4, sel, CON, CO16, CO4, COPX, COPY, done);
	input clk, rst, enn, enX, enY, enZ, encnt16, en64, en16A, encnt4, en16B, rst16, rstmac, enPX, enW, rst4, done;
	input [1:0] sel;
	input [8:0] iX, iY;
	output  CON, CO16, CO4, COPX, COPY;
	wire enPY;
	assign enPY = COPX & enPX;
	wire [8:0] X, Y, XP, YP,  RD, Y3XP, Y3X;
	wire [511:0] reg64;
	wire [127:0]  reg16, out64;
	wire [3:0] posX, posY;
	wire [3:0] cnt16;
	wire [1:0] cnt4;
	wire [7:0] WR, YX;
	wire [31:0] memout;
	parameter n_log = $clog2(N);
	wire [n_log:0] cntn;
	assign YX = {posY, posX} - posY - posY - posY;
	assign Y3X = (({posY + 2'b11, posX}>>2) + cnt4)<<2;
	cntnbit #(N) mycntnbit(clk, rst, enn, cntn, CON);
	
	mem mymem(clk, rst, RD, memout, done);
	reg64bit myreg64(memout, posX, clk, rst, en64, reg64, out64);
	reg16bit myreg16(out64, clk, rst, en16B, reg16);
	cnt4bit mycnt1(clk, rst16 | rst, encnt16, 4'b1111, cnt16, CO16);
	cnt2bit mycnt2(clk, rst4 | rst, encnt4, 2'b11, cnt4, CO4);
	MUX4to1 mymux1(XP, YP, 0, Y3XP, sel, RD);
	reg9 myX(iX, clk, rst, enX, X);
	reg9 myY(iY, clk, rst, enX, Y);
	Adder myadder1(X, {3'b0, cnt16, 2'b0}, XP);
	Adder myadder2(Y, {5'b0, cntn - 1'b1, cnt4, 2'b0}, YP);
	Adder myadder4(X, Y3X, Y3XP);
	cnt4bit mycnt3(clk, rst, enPX, 4'b1100, posX, COPX);
	cnt4bit mycnt4(clk, rst, enPY, 4'b1100, posY, COPY);

	genvar i;
  	generate
    	for(i=1; i<= N; i=i+1)begin
      		PE #(i) myPE(memout, reg16, YX, en16A&(cntn == i), clk, rst, rstmac, cnt16, enW, done);
    	end
  	endgenerate

endmodule