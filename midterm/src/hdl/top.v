module top(clk, rst, start, x, y, z);
input clk, rst, start;
input [8:0] x, y, z;
wire mw_en, bw_en, w_en, fw_en, macrst, cntrst, cntrst2, cntrst3, cntrst4, 
		cnten3, cnten4, co, co2, co3, co4, sel, done;
wire [1:0] sel2;
datapath Datapath(clk, rst | conrst, mw_en, bw_en, w_en, fw_en, macrst, cntrst, cntrst2, cntrst3, cntrst4, 
		cnten3, cnten4, co, co2, co3, co4, sel, sel2, x, y, z, done);
controller Controller(clk, rst, start, co, co2, co3, co4, mw_en, bw_en, w_en, fw_en, macrst, 
		  cntrst, cntrst2, cntrst3, cntrst4, cnten3, cnten4, sel, sel2, conrst, done);
endmodule