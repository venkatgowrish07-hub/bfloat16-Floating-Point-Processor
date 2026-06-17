module packer(
    input wire[15:0] a, b,       
    input wire[1:0] sel,           
    input wire sign_a, sign_b, a_is_larger,
    input wire is_zero_a, is_zero_b, is_inf_a, is_inf_b,
    input wire[7:0]  add_exp, mul_exp,
    input wire[6:0]  add_mant, mul_mant,
    input wire add_is_zero,
    output reg[15:0] final_result
);
    wire is_mul = (sel == 2'b10);
    wire mul_sign = sign_a ^ sign_b;

    reg add_sign;
    always @(*) begin
    if (a_is_larger) begin
        add_sign = sign_a;
    end 
    else begin
        if (sel[0] == 1'b1)
            add_sign = ~sign_b;
        else
            add_sign = sign_b;
    end
   end
   
    always @(*) begin
        // intial assigned to zero
        final_result = 16'b0;

        // Handle infinity first
        if (is_inf_a || is_inf_b) begin
            if (is_mul)
                final_result = {mul_sign, 8'hFF, 7'b0};
            else
                final_result = {add_sign, 8'hFF, 7'b0};
        end

        // Multiplication zero case
        else if (is_mul) begin
            if (is_zero_a || is_zero_b)
                final_result = 16'b0;
            else
                final_result = {mul_sign, mul_exp, mul_mant};
        end

        // Addition/Subtraction cases
        else begin
            if (is_zero_a) begin
                final_result = {sel[0] ? ~b[15] : b[15], b[14:0]};
            end
            else if (is_zero_b) begin
                final_result = a;
            end
            else if (add_is_zero) begin
                final_result = 16'b0;
            end
            else begin
                final_result = {add_sign, add_exp, add_mant};
            end
        end
    end
endmodule
