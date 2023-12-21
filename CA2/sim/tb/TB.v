module TB();
reg clk = 1'b0;
reg start = 1'b0;
reg rst = 1'b1;
reg [4:0] eps = 5'b11110;
wire done;
wire [4:0] result;
reg [4:0] x1= 5'b00110; // 0.75
reg [4:0] x2 = 5'b01000; // 0.25
reg [4:0] x3 = 5'b00100; // 0.5
reg[4:0] x4 = 5'b00010; // 0.25

maxfinder UUT(clk, rst, start, x1, x2, x3, x4, eps, done, result);
always #5 clk = ~clk;
initial begin
#10 rst = 0;
#16 start = 1;
#10 start = 0;
#500 $stop;
end
endmodule
