module Pipelined_FIR (
    input logic clk,               // Clock signal
    input logic rst,               // Reset signal
    input logic signed [15:0] din, // Input sample
    output logic signed [31:0] dout // Filtered output
);

    localparam int TAPS = 100;

    logic signed [15:0] delay_line [TAPS]; // Delay line for input samples
    logic signed [31:0] mult_out [TAPS];   // Multiplication results
    logic signed [31:0] acc_pipe [TAPS-1]; // Pipeline registers for accumulation

    localparam signed [15:0] coeffs [100] = '{
        27, -184, -225, -288, -310, -268, -166, -29, 100, 178,
        177, 98, -27, -147, -209, -181, -69, 84, 214, 261,
        194, 33, -160, -301, -322, -200, 27, 269, 418, 396,
        190, -129, -434, -584, -487, -150, 313, 713, 855, 623,
        42, -704, -1315, -1468, -932, 337, 2155, 4147, 5841, 6814,
        6814, 5841, 4147, 2155, 337, -932, -1468, -1315, -704, 42,
        623, 855, 713, 313, -150, -487, -584, -434, -129, 190,
        396, 418, 269, 27, -200, -322, -301, -160, 33, 194,
        261, 214, 84, -69, -181, -209, -147, -27, 98, 177,
        178, 100, -29, -166, -268, -310, -288, -225, -184, 27
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

    always_ff @(posedge clk) begin
        acc_pipe[0] = mult_out[0];
        for (int i = 1; i < TAPS; i = i + 1) begin
            acc_pipe[i] <= acc_pipe[i-1] + mult_out[i];
        end
    end

    // Final sum output
    always_ff @(posedge clk) begin
        dout <= acc_pipe[TAPS-2];
    end

endmodule
