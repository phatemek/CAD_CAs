module x_reg(d, en, clk, rst, y);
  input [31:0]d;
  input en, clk, rst;
  output reg [31:0]y = 32'b0;
  always @(posedge clk, posedge rst)begin
    if (rst) y <= 0;
    else if(en) y <= d;
  end
endmodule