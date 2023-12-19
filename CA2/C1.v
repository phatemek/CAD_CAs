module C1(a0, a1, sa, b0, b1, sb, s0, s1, f);
input a0, a1, sa, b0, b1, sb, s0, s1;
output f;
wire f1, f2, s2;
assign f1 = sa ? a1 : a0;
assign f2 = sb ? b1 : b0;
assign s2 = s0 || s1;
assign f = s2 ? f2 : f1;
endmodule