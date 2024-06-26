module FloatingPointMultiplier(x1, x2, out);
input wire [31:0] x1, x2;
output reg [31:0] out;
reg [31:0] f, s;
reg [47:0] mult48;
wire [7:0] exp1 = x1[30:23];
wire [7:0] exp2 = x2[30:23];
wire sign1 = x1[31];
wire sign2 = x2[31];
wire sign = sign1 ^ sign2;
wire flag;
assign flag = mult48[47];
reg [22:0] frac;
reg [7:0] exp;
always@(x1 or x2) begin
     f = {1'b1, x1[22:0]};
     s = {1'b1, x2[22:0]};
 mult48 = f*s;

 if (flag == 1'b0) begin
  frac = mult48[45:23];
  exp = exp1 + exp2 - 127;
 end
 else begin
  frac = mult48[46:24];
  exp = exp1 + exp2 - 126;
 end
 out = {sign, exp, frac};
 if (x1 == 32'b0 | x2 == 32'b0) out = 32'b0;
end
endmodule