module datapath(clk, rst, mw_en, bw_en, w_en, fw_en, macrst, cntrst, cntrst2, cntrst3, cntrst4, 
		cnten3, cnten4, co, co2, co3, co4, sel, sel2, x, y, z, done);
input clk, rst, mw_en, bw_en, w_en, fw_en, macrst, cntrst, cntrst2, cntrst3, cntrst4, 
      cnten3, cnten4, sel, done;
input[1:0] sel2;
input [8:0] x, y, z;
output co, co2, co3, co4;
wire [7:0] macout;
wire [8:0] m_addr, b64_addr;
wire [31:0] m_out, b64_out;
wire [6:0] b16_addr, fltr_addr;
wire[127:0] b16_out, fltr_out;
wire [3:0] cnt1, cnt4, cnt3;
wire [1:0] cnt2;
wire [8:0] adder_out1, adder_out2, adder_out3, adder_out4, adder_out5, adder_out6;
wire [8:0] mult13;
assign mult13 = cnt4 * 4'b1101;
assign m_addr = (sel2 == 2'b00) ? adder_out2 : (sel2 == 2'b01)? adder_out3 : adder_out5;
assign b64_addr = (sel == 0) ? {cnt1, 5'b0} : adder_out4;
assign fltr_addr = {cnt2, 5'b0};
assign b16_addr = {cnt2, 5'b0};
memory Memory(clk, rst, macout, mw_en, m_addr, m_out, done);
buffer64 Buffer64(clk, rst, m_out, b64_addr, bw_en, b64_out);
buffer16 Buffer16(clk, rst, b64_out, b16_addr, w_en, b16_out);
buffer16 Filter(clk, rst, m_out, fltr_addr, fw_en, fltr_out);
MAC mac(rst, macrst, clk, b16_out, fltr_out, macout);
cntr16 cntr1(clk, rst | cntrst, cnt1, co);
cntr4 cntr2(clk, rst | cntrst2, cnt2, co2);
cntr13 cntr3(clk, rst | cntrst3, cnten3, cnt3, co3);
cntr13 cntr4(clk, rst | cntrst4, cnten4, cnt4, co4);
adder Adder1({5'b0, cnt1}, {3'b0, cnt4, 2'b0}, adder_out1);
adder Adder2({adder_out1, 2'b0}, x, adder_out2);
adder Adder3({5'b0, cnt2, 2'b0}, y, adder_out3);
adder Adder4({2'b0, cnt3, 3'b0}, {cnt2, 7'b0}, adder_out4);
adder Adder5(adder_out6, z, adder_out5);
adder Adder6(mult13, {5'b0, cnt3}, adder_out6);
endmodule