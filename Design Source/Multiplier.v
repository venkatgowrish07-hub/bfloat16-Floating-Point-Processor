module multiplier(
    input  wire sign_a, sign_b,
    input  wire[7:0] exp_a, exp_b,
    input  wire[7:0] mant_a, mant_b,
    output wire mul_sign,
    output wire[7:0] mul_exp,
    output wire[6:0] mul_mant
);
    assign mul_sign = sign_a ^ sign_b; // sign is positive if both signs are same 
    wire [15:0] prod = mant_a * mant_b; 
    wire overflow = prod[15]; // If bit 15 is 1, the product is >= 2.0
    wire [8:0] raw_exp = exp_a + exp_b - 127 + overflow; // 
    assign mul_exp  = (raw_exp > 254) ? 8'hFF : raw_exp[7:0]; // if raw_exponent is greater thaan 254 then output is infinity that is all 1's in exponent
    assign mul_mant = overflow ? prod[14:8] : prod[13:7];
endmodule
