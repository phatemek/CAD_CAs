module iszer(A, out);input [4:0] A;output out;Or1bit myOr1(A[4], A[3], A[2], A[1], A[0], 1'b0, out);endmodule
