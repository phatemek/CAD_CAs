module TB();
reg clk = 1'b0;
reg rst = 1'b0;
reg start = 1'b0;
wire [8:0] x,y , z;
assign x = 9'd20;
assign y = 9'd296;
assign z = 9'd332;
top UUT(clk, rst, start, x, y, z);
always #5 clk = ~clk;
initial begin 
#16 start = 1;
#10 start = 0;
#50000 $stop;
end
endmodule