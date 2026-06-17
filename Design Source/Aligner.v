module aligner(
    input wire[7:0] smaller_mant, exp_diff,
    output wire[7:0] shifted_mant
);
    assign shifted_mant = smaller_mant >> exp_diff; //the smaller mantissa will shift right by exp_diff digits 
endmodule
