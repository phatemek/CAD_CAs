module Xor(a, b, c, out);input a, b, c;output out;wire nc;Not mynot(c, nc);C2 myc2(c, nc, nc, c, a, b, a, b, out);endmodule
