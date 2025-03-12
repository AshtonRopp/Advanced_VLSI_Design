module Two_Parallel (
    input logic clk,
    input logic rst,
    input logic signed [15:0] din1,
    input logic signed [15:0] din2,
    output logic signed [63:0] dout1,
    output logic signed [63:0] dout2
);

    localparam int TAPS = 102;

    // Buffers to store the most recent 102 samples (51 even, 51 odd)
    logic signed [15:0] buffer1 [TAPS/2-1:0];
    logic signed [15:0] buffer2 [TAPS/2-1:0];
    
    // Coefficients for the FIR filter
    logic signed [31:0] H0 [TAPS/2-1:0];
    logic signed [31:0] H1 [TAPS/2-1:0];
    logic signed [31:0] coef [TAPS-1:0];

    // Filter sums
    logic signed [63:0] sum_h0, sum_h1, sum_h01, sum_h1_reg;

    // Read coefficients from file
    initial begin
        $readmemb("coef.txt", coef);
        for (int i = 0; 2*i < TAPS; i++) begin
            // Even coefficients for H0
            H0[i] = coef[2*i];
            
            if (2*i+1 < TAPS) begin
                // Odd coefficients for H1
                H1[i] = coef[2*i+1];
            end
        end
    end

    // Process inputs
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            sum_h1_reg <= 0;
            for (int i = 0; i <= TAPS/2-; i++) begin
                buffer1[i] <= 0;
                buffer2[i] <= 0;
            end
        end else begin
            // Shift buffer and insert new input sample
            for (int i = TAPS/2-1; i > 0; i--) begin
                buffer1[i] <= buffer1[i - 1];
                buffer2[i] <= buffer2[i - 1];
            end
            buffer1[0] <= din1;
            buffer2[0] <= din2;
            sum_h1_reg <= sum_h1;
        end
    end
    
    always_comb begin
        sum_h0 = 0;
        sum_h1 = 0;
        sum_h01 = 0;

        for (int i = 0; i <= TAPS/2-1; i++) begin
            sum_h0 += buffer1[i] * H0[i];
            sum_h1 += buffer2[i] * H1[i];
            sum_h01 += (buffer1[i] + buffer2[i])*(H0[i] + H1[i]);
        end
    end

    // Assign final outputs
    assign dout1 = (sum_h0 + sum_h1_reg) >>> 31;
    assign dout2 = (sum_h01 - sum_h0 - sum_h1) >>> 31;

endmodule
