module multTB();
reg [31:0] x1 = 32'b11000000011000000000000000000000;
reg [31:0] x2 = 32'b00111110000110011001100110011010;
wire [31:0] out;
multiplier UUT(x1, x2, out);
initial begin
#50 $stop;
end
endmodule