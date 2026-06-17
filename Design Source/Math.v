module math(
    input wire[7:0] larger_mant, shifted_mant,
    input wire add_sub,
    output wire[8:0] mantissa_result 
);
    assign mantissa_result = add_sub ? (larger_mant - shifted_mant) : (larger_mant + shifted_mant); // addition and subtraction 
endmodule
