module Abs #(parameter N = 5) (a, signbit, out);
    input[N-1:0] a;
    input signbit;
    output[N-1:0] out;
    wire [10:0] tmpout;
    wire[N-1:0] not_a;
    wire co;

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin
            Xor xor_ins(a[i], signbit, 1'b0, not_a[i]);
        end
    endgenerate

   Adder11 adder1 ({{(10-N){1'b0}}, not_a}, {{9{1'b0}}, signbit}, tmpout);
   assign out = tmpout[N-1:0];
endmodule

