module DataPath(clk, rst, ix1, ix2, ix3, ix4, ieps, wen, wene, sel, zer, out);
input clk, rst, wen, wene, sel;
input [4:0] ix1, ix2, ix3, ix4, ieps;
output zer;
output [4:0] out;
wire [4:0] xp1, xp2, xp3, xp4, w1, w2, w3, w4, x1, x2, x3, x4, eps, initx1, initx2, initx3, initx4;
wire zx1, zx2, zx3, zx4, nsel;
//assign w1 = (sel?xp1:ix1);
//assign w2 = (sel?xp2:ix2);
//assign w3 = (sel?xp3:ix3);
//assign w4 = (sel?xp4:ix4);

Mux2to1 mux1(ix1, xp1, sel, w1);
Mux2to1 mux2(ix2, xp2, sel, w2);
Mux2to1 mux3(ix3, xp3, sel, w3);
Mux2to1 mux4(ix4, xp4, sel, w4);

Not Not1(sel, nsel);

reg5bit my_x1(w1, wen, clk, rst, x1);
reg5bit my_x2(w2, wen, clk, rst, x2);
reg5bit my_x3(w3, wen, clk, rst, x3);
reg5bit my_x4(w4, wen, clk, rst, x4);
reg5bit my_ix1(ix1, nsel, clk, rst, initx1);
reg5bit my_ix2(ix2, nsel, clk, rst, initx2);
reg5bit my_ix3(ix3, nsel, clk, rst, initx3);
reg5bit my_ix4(ix4, nsel, clk, rst, initx4);
reg5bit my_eps(ieps, wene, clk, rst, eps);
wire [4:0] one2c = 4'b01000;
PU PU1(x1, one2c, x2, eps, x3, eps, x4, eps, clk, rst, xp1);
PU PU2(x1, eps, x2, one2c, x3, eps, x4, eps, clk, rst, xp2);
PU PU3(x1, eps, x2, eps, x3, one2c, x4, eps, clk, rst, xp3);
PU PU4(x1, eps, x2, eps, x3, eps, x4, one2c, clk, rst, xp4);

iszer zerx1(x1, zx1);
iszer zerx2(x2, zx2);
iszer zerx3(x3, zx3);
iszer zerx4(x4, zx4);

wire [4:0] resx1, resx2, resx3, resx4;
And5bit myand1({5{zx1}}, initx1, resx1);
And5bit myand2({5{zx2}}, initx2, resx2);
And5bit myand3({5{zx3}}, initx3, resx3);
And5bit myand4({5{zx4}}, initx4, resx4);



/*assign out = (zx1 == 1)? initx1:
	(zx2 == 1)?initx2:
	(zx3 == 1)?initx3:initx4;
*/
Or1bit myor1(resx1[0], resx2[0], resx3[0], resx4[0], 1'b0, 1'b0, out[0]);
Or1bit myor2(resx1[1], resx2[1], resx3[1], resx4[1], 1'b0, 1'b0, out[1]);
Or1bit myor3(resx1[2], resx2[2], resx3[2], resx4[2], 1'b0, 1'b0, out[2]);
Or1bit myor4(resx1[3], resx2[3], resx3[3], resx4[3], 1'b0, 1'b0, out[3]);
Or1bit myor5(resx1[4], resx2[4], resx3[4], resx4[4], 1'b0, 1'b0, out[4]);

wire rega1, rega2, rega3, rega4, rega5, rega6;
And1bit myand5(zx1, zx2, rega1);
And1bit myand6(zx1, zx3, rega2);
And1bit myand7(zx1, zx4, rega3);
And1bit myand8(zx2, zx3, rega4);
And1bit myand9(zx2, zx4, rega5);
And1bit myand10(zx3, zx4, rega6);

Or1bit mynewor(rega1, rega2, rega3, rega4, rega5, rega6, zer);

//assign zer = ((zx1 & zx2) | (zx1 & zx3) | (zx1 & zx4) | (zx2 & zx3) | (zx2 & zx3) | (zx3 & zx4));
endmodule
