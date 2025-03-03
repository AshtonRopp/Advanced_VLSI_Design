`timescale 1ns/1ps

module Pipelined_FIR_tb;

    // Testbench signals
    logic clk;
    logic rst;
    logic signed [15:0] din;
    logic signed [31:0] dout;

    // Instantiate the DUT
    Pipelined_FIR uut (
        .clk(clk),
        .rst(rst),
        .din(din),
        .dout(dout)
    );

    // Test signal generation
    integer i;
    real freq = 2000;  // Low-frequency sinusoid input
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        din = 0;
        #20 rst = 0; // Deassert reset after 20ns

        // Generate sinusoidal input
        for (i = 0; i < 1000; i = i + 1) begin
            din = $rtoi(10000 * $sin(2 * 3.141592 * freq * i)); // Scale sine wave
            #10;  // Wait for one clock cycle
        end

        // Stop simulation
        #100;
        $finish;
    end

    // Dump waveform for ModelSim
    initial begin
        $dumpfile("Pipelined_FIR_tb.vcd");
        $dumpvars(0, Pipelined_FIR_tb);
    end

    // Clock generation: 100MHz clock (10ns period)
    always #5 clk = ~clk;


endmodule
