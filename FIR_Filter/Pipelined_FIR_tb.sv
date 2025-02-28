module fir_filter_100tap_tb;

    // Testbench signals
    logic clk;               // Clock signal
    logic rst;               // Reset signal
    logic signed [15:0] din; // Input sample
    logic signed [31:0] dout; // Filtered output

    // Instantiate the DUT (Design Under Test)
    fir_filter_100tap uut (
        .clk(clk),
        .rst(rst),
        .din(din),
        .dout(dout)
    );

    // Clock generation
    always #5 clk = ~clk;  // Generate a clock with period of 10 units (100 MHz)

    // Stimulus generation
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        din = 16'sd0;

        // Reset the DUT
        #10 rst = 0;  // Deassert reset after 10 time units
        #10 din = 16'sd10;  // Provide a sample input
        #10 din = 16'sd20;  // Provide another sample input
        #10 din = 16'sd30;
        #10 din = 16'sd40;
        #10 din = 16'sd50;
        #10 din = 16'sd60;

        // Add more samples as needed for the test

        // Apply a few more cycles
        #50 din = 16'sd0;   // Provide zero input to see how the filter settles
        #50 $finish;         // End simulation
    end

    // Dump waveform for ModelSim
    initial begin
        $dumpfile("fir_filter_tb.vcd");   // Dump waveform to VCD file
        $dumpvars(0, fir_filter_100tap_tb);  // Dump all signals in the testbench and DUT
    end

endmodule
