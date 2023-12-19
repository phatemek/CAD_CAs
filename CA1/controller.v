`define S0 3'b000
`define S1 3'b001
`define S2 3'b010
`define S3 3'b011
`define S4 3'b100

module controller(clk, start, zer, wen, wenep, sel, done);
input clk, start, zer;
output reg wen, wenep, sel, done;
reg[2:0] ns, ps = `S0;

always@(posedge clk) begin
	ps = ns;
end

always@(ps or start or zer) begin
	ns = `S0;
	case(ps)
		`S0: ns = start? `S1:`S0;
		`S1: ns = start? `S1:`S2;
		`S2: ns = `S3;
		`S3: ns = zer? `S2:`S4;
		`S4: ns = `S0;
	endcase
end

always@(ps) begin
	{wen, wenep, sel, done} = 4'b0;
	case(ps)
		`S1: begin wen = 1; wenep = 1; sel = 0; end
		`S3: begin wen = 1; sel = 1; end
		`S4: done = 1;
	endcase
end
endmodule