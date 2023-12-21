
module Multiplier(a_2, x_2, out);
  
  parameter m = 5;
  parameter n = 5;
  output [m+n-1:0] out;
  wire [m+n-1:0] product;
  input [m-1:0] a_2;
  input [n-1:0] x_2;
  wire [m-1:0] a;
  wire [n-1:0] x;
  Abs #m a1(a_2, a_2[m - 1], a);
  Abs #m a2(x_2, x_2[m - 1], x);
  
  wire c_partial[m*n:0] ;
  wire s_partial[m*n:0] ;
  
  genvar i;
  generate
    for(i=0; i<m; i=i+1)
    begin
      Cell mycell(x[0], a[i], 1'b0, 1'b0, c_partial[i], s_partial[i]);
    end
  endgenerate
  
  
  genvar j, k;
  generate
    for(k=0; k<n-1; k=k+1)
    begin
      for(j=0; j<m-1; j=j+1)
      begin
  	 Cell mycell2(x[k + 1], a[j], s_partial[m*(k + 1) + j - m + 1], c_partial[m*(k+1)+j-m], c_partial[m*(k+1)+j], s_partial[m*(k+1)+j]);
      end
    end
  endgenerate
  
  genvar z;
  generate
    for(z=0; z<n-1; z=z+1)
    begin
      Cell c_middle_last_col(x[z+1], a[+(m-1)], 1'b0, c_partial[m*(z+1)+(m-1)-m], c_partial[m*(z+1)+(m-1)], s_partial[m*(z+1)+(m-1)]);
    end
  endgenerate
  
  wire c_last_partial[m-1:0] ;
  wire s_last_partial[m-2:0] ;
  assign c_last_partial[0] = 1'b0;
  genvar l;
  generate
    for(l=0; l<m-1; l=l+1)
    begin
      FA c_last(c_partial[(n-1)*m+l], s_partial[(n-1)*m+l+1], c_last_partial[l], c_last_partial[l+1], s_last_partial[l]);
    end
  endgenerate
  
  generate
    for(i=0; i<n; i=i+1)
    begin
      assign product[i] = s_partial[m*i];
    end
  endgenerate
  generate
    for(i=n; i<n+m-1; i=i+1)
    begin
      assign product[i] = s_last_partial[i-n];
    end
  endgenerate
  assign product[m+n-1] = c_last_partial[m-2];
  wire signbit_res;
  Xor xor1(a_2[m-1], x_2[n-1], 1'b0, signbit_res);
  Abs #(m+n) newAbs(product, signbit_res, out);
  initial begin
	$display ("ASFDAF\n");
  end
endmodule

/*
module Multiplier(a, b, c);
	input signed[4:0] a, b;
	output signed[9:0] c;
	assign c = a * b;
endmodule
*/
