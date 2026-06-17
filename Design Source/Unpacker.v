module unpacker(
    input  wire [15:0] in,
    output wire sign,
    output wire [7:0] exp,
    output wire [7:0] mant,
    output wire is_zero,
    output wire is_inf
);
    assign sign = in[15];
    assign exp = in[14:7];
    assign mant = (exp == 8'b0) ? 8'b0 : {1'b1, in[6:0]};
    // if all bits in exponent are zero then input is zero. So mantissa = 0
    assign is_zero = (exp == 8'b0);
    assign is_inf = (exp == 8'hFF);
    // checking edge cases
endmodule
