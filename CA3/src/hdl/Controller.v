`define S0 4'b0000
`define S1 4'b0001
`define S2 4'b0010
`define S3 4'b0011
`define S4 4'b0100
`define S5 4'b0101
`define S6 4'b0110
`define S7 4'b0111
`define S8 4'b1000
`define S9 4'b1001
`define S10 4'b1010
`define S11 4'b1011
`define S12 4'b1100
`define S13 4'b1101
`define S14 4'b1110

module controller(clk, rst, start, CO64, CON, CO16, CO4, COPX, COPY, COPXP, COPYP, encnt64, enn, enX, enY, enZ, encnt16, sel, en64, en16A, encnt4, en16B, rst16, enPX, rstmac, enW, rst4, donel1, done);
input clk, rst, start, CO64, CON, CO16, CO4, COPX, COPY, COPXP, COPYP;
output reg enn, enX, enY, enZ, encnt64, encnt16, en64, en16A, encnt4, en16B, rst16, rstmac, enPX, enW, rst4, donel1, done;
output reg [1:0] sel;
reg[3:0] ns, ps = `S0;

always@(posedge clk or posedge rst) begin
	if (rst) ps <= `S0;
	else ps = ns;
end

always@(ps or CO16 or CO4 or COPX or COPY or start or CON or CO64) begin
	ns = `S0;
	case(ps)
		`S0: ns = start? `S1:`S0;
		`S1: ns = start? `S1:`S2;
		`S9: ns = CON? `S4:`S3;
		`S2: ns = CO16? `S9:`S2;
		`S3: ns = CO4? `S9:`S3;
		`S4: ns = `S5;
		`S5: ns = CO16?`S6:`S5;
		`S6: ns = (COPX == 1'b0)?`S4:
			(COPY == 1'b1)?`S8:`S7;
		`S7: ns = CO4?`S4:`S7;
		`S8: ns = `S10;
		`S10: ns = CO16? `S11:`S10;
		`S11: ns = CO4?`S12:`S11;
		`S12: ns = CO64?`S13:`S12;
		`S13: ns = (COPXP == 1'b1 && COPYP == 1'b1)?`S14:`S11;
		`S14: ns = `S14;
	endcase
end

always@(ps) begin
	{enn, enX, enY, enZ, encnt16, en64, en16A, encnt4, en16B, rst16, rstmac, enPX, enW, rst4, done, sel, encnt64, donel1} = 19'b0;
	case(ps)
		`S1: begin enX = 1; enY = 1; enZ = 1; end
		`S2: begin encnt16 = 1; sel = 2'b00; en64 = 1; end
		`S3: begin en16A = 1; encnt4 = 1; sel = 2'b01;end
		`S4: begin en16B = 1; rst16 = 1; rstmac = 1; end
		`S5: begin encnt16 = 1; end
		`S6: begin enPX = 1; enW = 1; sel = 2'b10; rst4 = 1; end
		`S7: begin encnt4 = 1; sel = 2'b11; en64 = 1; end
		`S8: donel1 = 1; 
		`S9: enn = 1;
		`S10: begin encnt16 = 1; en16A = 1; rst4 = 1; end	
		`S11: begin encnt4 = 1; en16B = 1; rstmac = 1; end
		`S12: begin encnt64 = 1;end
		`S13: begin enPX = 1; enW = 1; sel = 2'b01; rst4 = 1;end
		`S14: done = 1;
	endcase
end
endmodule
