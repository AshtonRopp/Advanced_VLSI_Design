module top (
    input logic clk,               // Clock signal
    input logic rst,               // Reset signal
    input logic signed [15:0] din0, // Input sample
    input logic signed [15:0] din1, // Input sample
    input logic signed [15:0] din2, // Input sample
    output logic signed [63:0] dout0, // Filtered output
    output logic signed [63:0] dout1, // Filtered output
    output logic signed [63:0] dout2 // Filtered output
);
    Three_Parallel_Pipelined F0 (
        .clk(clk),
        .rst(rst),
        .din(din0),
        .dout(dout0)
    );

    Three_Parallel_Pipelined F1 (
        .clk(clk),
        .rst(rst),
        .din(din1),
        .dout(dout1)
    );

    Three_Parallel_Pipelined F2 (
        .clk(clk),
        .rst(rst),
        .din(din2),
        .dout(dout2)
    );

endmodule