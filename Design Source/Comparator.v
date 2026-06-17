module comparator(
    input wire [7:0] exp_a, exp_b,
    input wire [7:0] mant_a, mant_b,
    output wire [7:0] larger_exp, exp_diff,
    output wire [7:0] larger_mant, smaller_mant,
    output wire a_is_larger
);
    assign a_is_larger = (exp_a > exp_b) || (exp_a == exp_b && mant_a >= mant_b); // finding the larger input 
    assign larger_exp = a_is_larger ? exp_a : exp_b;
    assign exp_diff = a_is_larger ? (exp_a - exp_b) : (exp_b - exp_a); // exp_diff is (exp_a-exp_b) if a is greater thean b vice versa
    assign larger_mant = a_is_larger ? mant_a : mant_b;
    assign smaller_mant = a_is_larger ? mant_b : mant_a;
    // finding larger and smaller mantissa 
endmodule
