module TB();
	reg rst = 0, clk = 0, start = 0;
	wire done;
	reg [8:0] iX = 9'd64;
	reg [8:0] iY = 9'd0;
	topmodule #(4) UUT(clk, rst, iX, iY, start, done);
	always #5 clk = ~clk;
	initial begin
	#5 rst = 1;
	#10 rst = 0;
	#3 start = 1;
	#10 start = 0;
	end
	always @(done)begin
		if (done) $stop;
	end
endmodule