module Cell(input xn, am, Sin, Cin, output Cout, Sout);

  wire t;
  And1bit myand1(xn, am, t);
  wire xortmp;
  Xor myxor(t, Sin, Cin, Sout);
  Xor myxor3(Sin, Cin, 1'b0, t1);
  And1bit myand2(t, t1, t2);
  And1bit myand3(Cin, Sin, t3);
  Or1bit myor1(t2, t3, 1'b0, 1'b0, 1'b0, 1'b0, Cout);
  
endmodule

