module main(
    input wire[15:0] a, b,
    input wire[1:0] sel, 
    output wire[15:0] result
);
    wire sa, sb, za, zb, ia, ib, a_is_large, sum_zero;
    wire[7:0] ea, eb, ma, mb, exp_large, exp_diff, mant_large, mant_small, mant_shift, add_e, mul_e;
    wire[8:0] mantissa_result;
    wire[6:0] add_m, mul_m;
    wire mul_s;
    // instantiating every module 

    unpacker uA (.in(a), .sign(sa), .exp(ea), .mant(ma), .is_zero(za), .is_inf(ia));
    unpacker uB (.in(b), .sign(sb), .exp(eb), .mant(mb), .is_zero(zb), .is_inf(ib));

    comparator comp (.exp_a(ea), .exp_b(eb), .mant_a(ma), .mant_b(mb), .larger_exp(exp_large), .exp_diff(exp_diff), .larger_mant(mant_large), .smaller_mant(mant_small), .a_is_larger(a_is_large));
                         
    aligner aln (.smaller_mant(mant_small), .exp_diff(exp_diff), .shifted_mant(mant_shift));
    
    wire add_sub = (sel == 2'b01) ? (sa == sb) : (sa != sb);
    
    math math  (.larger_mant(mant_large), .shifted_mant(mant_shift), .add_sub(add_sub), .mantissa_result(mantissa_result));
    multiplier mul (.sign_a(sa), .sign_b(sb), .exp_a(ea), .exp_b(eb), .mant_a(ma), .mant_b(mb), .mul_sign(mul_s), .mul_exp(mul_e), .mul_mant(mul_m));

    normalizer norm (.mantissa_result(mantissa_result), .larger_exp(exp_large), .norm_exp(add_e), .norm_mant(add_m), .math_is_zero(sum_zero));

    packer packer (.a(a), .b(b), .sel(sel), .sign_a(sa), .sign_b(sb), .a_is_larger(a_is_large), .is_zero_a(za), .is_zero_b(zb), .is_inf_a(ia), .is_inf_b(ib), .add_exp(add_e), .mul_exp(mul_e), .add_mant(add_m), .mul_mant(mul_m), .add_is_zero(sum_zero), .final_result(result)); 
    // Packing the final result
endmodule
