module FA(a, b, ci, co, res);input a, b, ci;output co, res;Xor myxor(a, b, ci, res);Co myco(a, b, ci, co);endmodule
