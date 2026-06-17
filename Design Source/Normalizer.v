module normalizer(
    input wire[8:0] mantissa_result,
    input wire[7:0] larger_exp,
    output reg[7:0] norm_exp,
    output reg[6:0] norm_mant,
    output reg math_is_zero
);
    reg [3:0] zero_counter; 
    always @(*) begin
        math_is_zero = 0;
        if (mantissa_result == 9'b0) begin
            norm_exp = 0; norm_mant = 0; math_is_zero = 1; // if all bits in mantissa are zero then the ouput should display zero (zero in all 16 bits)
        end else if (mantissa_result[8]) begin
            norm_exp = larger_exp + 1; norm_mant = mantissa_result[7:1]; //  if mantiss_result[8] is we need to right shift one bit to store it in 8 bits 
        end else if (mantissa_result[7]) begin
            norm_exp = larger_exp; norm_mant = mantissa_result[6:0];     
        end else begin
            
            if(mantissa_result[6]) zero_counter=1; else if(mantissa_result[5]) zero_counter=2; else if(mantissa_result[4]) zero_counter=3;
            else if(mantissa_result[3]) zero_counter=4; else if(mantissa_result[2]) zero_counter=5; else if(mantissa_result[1]) zero_counter=6; else zero_counter=7;
            
            norm_mant = (mantissa_result[7:0] << zero_counter);  // shifting the mantissa_result to achieve a (1.something) form using zero_counter
            norm_exp  = (larger_exp > zero_counter) ? (larger_exp - zero_counter) : 8'b0;
            if (norm_exp == 0) math_is_zero = 1; 
        end
    end
endmodule
