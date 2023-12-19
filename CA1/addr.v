module FloatingPointAdder (
  input [31:0] a,
  input [31:0] b,
  output reg [31:0] result 
);
reg [4:0] i;
reg [4:0] leftbit;
  reg [7:0] exponent_a, exponent_b, exponent_result;
  reg [24:0] mantissa_a, mantissa_b;
  reg [22:0] mantissa_result;
  reg[24:0] nmantissa_a, nmantissa_b;
  reg sign_a, sign_b, sign_res;
  reg [24:0] sum_res; 
  assign sign_a = a[31];
  assign exponent_a = a[30:23];
  assign mantissa_a = {2'b01, a[22:0]};

  assign sign_b = b[31];
  assign exponent_b = b[30:23];
  assign mantissa_b = {2'b01, b[22:0]};

  always @(a or b) begin
    if (exponent_a > exponent_b) begin
        nmantissa_b = (mantissa_b >> (exponent_a - exponent_b));
    nmantissa_a = mantissa_a;
    exponent_result = exponent_a;
    end 
    else begin
       nmantissa_a = (mantissa_a >> (exponent_b - exponent_a));
       nmantissa_b = mantissa_b;
       exponent_result = exponent_b;
    end  

   if (sign_b == sign_a)begin
    sign_res = sign_b;
    sum_res = nmantissa_b + nmantissa_a;
  end
  else begin
    if (nmantissa_b > nmantissa_a)begin
      sum_res = nmantissa_b - nmantissa_a;
      if (sign_b == 1'b1) sign_res = 1;
      else sign_res = 0;
    end
    else begin
      sum_res = nmantissa_a - nmantissa_b;
      if (sign_a == 1'b1) sign_res = 1;
      else sign_res = 0;
    end
  end
  leftbit = 0;
  for (i = 0; i <=24; i = i + 1) begin
    if (sum_res[i] == 1'b1)begin
      leftbit = i;
    end
  end    
  if (leftbit == 5'b0)begin
    exponent_result = 0;
    sign_res = 0;
    mantissa_result = sum_res;
  end
  else if(leftbit < 23)begin
    exponent_result = exponent_result - (23 - leftbit);
    mantissa_result = (sum_res << (23 - leftbit));
  end
  else if(leftbit > 23)begin
    exponent_result = exponent_result + 1;
    mantissa_result = {1'b0, sum_res[23:1]};
  end
  else
    mantissa_result = sum_res;
  if (a == 32'b0) result = b;  
  else if(b == 32'b0) result = a;
  else result = {sign_res, exponent_result, mantissa_result};
end
endmodule