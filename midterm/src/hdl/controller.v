`define S0  4'b0000
`define S1  4'b0001
`define S2  4'b0010
`define S3  4'b0011
`define S4  4'b0100
`define S5  4'b0101
`define S6  4'b0110
`define S7  4'b0111
`define S8  4'b1000
`define S9  4'b1001
`define S10 4'b1010

module controller(clk, rst, start, co, co2, co3, co4, mw_en, bw_en, w_en, fw_en, macrst, 
		  cntrst, cntrst2, cntrst3, cntrst4, cnten3, cnten4, sel, sel2, conrst, done);
input clk, rst, start, co, co2, co3, co4;
output reg mw_en, bw_en, w_en, fw_en, macrst, cntrst, cntrst2, cntrst3, cntrst4, cnten3, cnten4, sel, 
       conrst, done;
output reg [1:0] sel2;
reg [3:0] ns, ps = `S0;
always@(posedge clk) begin
	if(rst) ps = 4'b0;
	else ps = ns;
end
always@(ps, start, co, co2, co3, co4) begin
	ns = `S0;
	case(ps)
		`S0:  ns = start? `S1: `S0;
		`S1:  ns = start? `S1: `S2;
		`S2:  ns = co? `S3: `S2;
		`S3:  ns = co2? `S4: `S3;
		`S4:  ns = co2? `S5: `S4;
		`S5:  ns = co? `S6: `S5;
		`S6:  ns = `S7;
		`S7:  ns = co3? `S8: `S4;
		`S8:  ns = `S9;
		`S9:  ns = co4? `S10: `S2;
		`S10: ns = `S10;
	endcase
end
always@(ps) begin
	{mw_en, bw_en, w_en, fw_en, macrst, cntrst, cntrst2, cntrst3, cntrst4, cnten3, cnten4, sel, 
        conrst, done, sel2} = 16'b0;
	case(ps)
		`S1: conrst = 1'b1;
		`S2: begin cntrst2 = 1'b1; bw_en = 1'b1; cntrst3 = 1'b1; end
		`S3: begin fw_en = 1'b1; sel2 = 2'b01; end
		`S4: begin sel = 1'b1; w_en = 1'b1; macrst = 1'b1; cntrst = 1'b1; end
		`S6: begin sel2 = 2'b10; mw_en = 1'b1; cnten3 = 1'b1; end
		`S7: cntrst2 = 1'b1;
		`S8: cnten4 = 1'b1;
		`S9: cntrst = 1'b1;
		`S10: done = 1'b1;
	endcase
end
endmodule