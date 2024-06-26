module TB();
reg clk = 1'b0;
reg start = 1'b0;
reg [31:0] eps = 32'b00111110010011001100110011001101;
wire done;
wire [31:0] result;
reg [31:0] x1 = 32'b00111110001000000000000000000000;
reg [31:0] x2 = 32'b11000000011000000000000000000000;
reg [31:0] x3 = 32'b01000001000000000000000000000000;
reg [31:0] x4 = 32'b10111111001001110110110010001011;
maxfinder UUT(clk, start, x1, x2, x3, x4, eps, done, result);
always #5 clk = ~clk;
initial begin
#16 start = 1;
#10 start = 0;
#500 $stop;
end
endmodule