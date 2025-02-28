module fir_filter_100tap (
    input logic clk,               // Clock signal
    input logic rst,               // Reset signal
    input logic signed [15:0] din, // Input sample
    output logic signed [31:0] dout // Filtered output
);

    localparam int TAPS = 100;

    logic signed [15:0] delay_line [TAPS]; // Delay line for input samples
    logic signed [31:0] mult_out [TAPS];   // Multiplication results
    logic signed [31:0] add_pipe [TAPS/2]; // Pipeline registers for accumulation

    localparam signed [15:0] coeffs [100] = '{
        27, -184, -225, -288, -310, -268, -166, -29, 100, 178, 
        219, 213, 157, 60, -54, -147, -184, -154, -61, 49, 
        127, 135, 74, -37, -137, -175, -132, -23, 104, 181, 
        177, 91, -37, -157, -206, -153, -14, 141, 215, 190, 
        71, -90, -203, -227, -142, 31, 186, 249, 205, 59, 
        -121, -245, -264, -168, 24, 211, 286, 234, 78, -112, 
        -271, -295, -180, 21, 224, 306, 243, 83, -110, -278, 
        -298, -184, 27, 224, 298, 243, 83, -112, -271, -286, 
        -180, 24, 211, 264, 234, 78, -121, -245, -227, -168, 
        31, 186, 205, 190, 59, -90, -203, -153, -142, -14, 
        141, 177, 215, 91, 71, -37, -206, -157, -37, 181, 
        104, -23, -132, -175, -137, -37, 74, 135, 127, 49, 
        -61, -154, -184, -147, -54, 60, 157, 213, 219, 178, 
        100, -29, -166, -268, -310, -288, -225, -184, 27
    };

    // Shift Register (Delay Line)
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            for (int i = 0; i < TAPS; i = i + 1) begin
                delay_line[i] <= 16'sd0;
            end
        end else begin
            for (int i = TAPS-1; i > 0; i = i - 1) begin
                delay_line[i] <= delay_line[i-1];
            end
            delay_line[0] <= din;
        end
    end

    // Multiply input samples with coefficients
    always_ff @(posedge clk) begin
        for (int i = 0; i < TAPS; i = i + 1) begin
            mult_out[i] <= delay_line[i] * coeffs[i];
        end
    end

    // Pipelined accumulation (binary tree structure)
    always_ff @(posedge clk) begin
        for (int i = 0; i < TAPS/2; i = i + 1) begin
            add_pipe[i] <= mult_out[2*i] + mult_out[2*i+1];
        end
    end

    generate
        genvar j;
        for (j = TAPS/4; j > 0; j = j / 2) begin : pipelined_sum
            always_ff @(posedge clk) begin
                for (int k = 0; k < j; k = k + 1) begin
                    add_pipe[k] <= add_pipe[2*k] + add_pipe[2*k+1];
                end
            end
        end
    endgenerate

    // Final sum output
    always_ff @(posedge clk) begin
        dout <= add_pipe[0];
    end

endmodule
