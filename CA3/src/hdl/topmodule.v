module topmodule #(parameter N = 1) (clk, rst, iX, iY, start, done);
	input clk, rst, start;
	output done;
	wire encnt64, enn, enX, enY, enZ,encnt16, en64, en16A, encnt4, en16B, rst16, rstmac, enPX, enW, rst4, donel1;
	wire [1:0] sel;
	input [8:0] iX, iY;
	wire  CO64, CON, CO16, CO4, COPX, COPY, COPXP, COPXY;
 	DataPath #(N) mydata(clk, rst, iX, iY, enn, enX, enY, enZ, encnt16, en64, en16A, encnt4, en16B, rst16, rstmac, 
	enPX, enW, rst4, sel, CON, CO16, CO4, COPX, COPY, donel1);
	Layer2 #(N) myLayer2(clk, rst | donel1, 9'b0, encnt64, enn, enX, enY, enZ, encnt16, en64, en16A, encnt4, en16B, rst16, rstmac, 
	enPX, enW, rst4, sel, CO64, CON, CO16, CO4, COPXP, COPYP, done);
	controller mycon(clk, rst, start, CO64, CON, CO16, CO4, COPX, COPY, COPXP, COPYP, encnt64, enn, enX, enY, enZ, encnt16, sel, en64, en16A, encnt4, en16B, rst16, enPX, rstmac, enW, rst4, donel1, done);
endmodule