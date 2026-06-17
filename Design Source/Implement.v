module implement(
    input wire[15:0] sw,              
    input wire clk, // addition button
    input wire sub_btn, // subtraction button
    input wire mul_btn, // multiplication button
    output wire[15:0] led              
);

    reg state = 1'b0;
    reg [15:0]reg_a = 16'b0;
    reg [15:0]reg_b = 16'b0;

    always @(posedge clk) begin
        if (state == 1'b0) begin
            reg_a <= sw;
            state <= 1'b1;
        end else begin
            reg_b <= sw;
            state <= 1'b0;
        end
    end

    wire [1:0] operation = mul_btn ? 2'b10 : (sub_btn ? 2'b01 : 2'b00);

    wire [15:0] fpu_output;
    main bfloat16 (
        .a(reg_a),
        .b(reg_b),
        .sel(operation),
        .result(fpu_output)
    );

    // assigning output to led's
    assign led = (state == 1'b1) ? sw : fpu_output;

endmodule
