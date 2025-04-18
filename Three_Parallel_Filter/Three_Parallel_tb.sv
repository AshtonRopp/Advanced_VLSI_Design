`timescale 1ns/1ps

module Three_Parallel_tb;

    // Testbench signals
    logic clk;
    logic rst;
    logic signed [15:0] din1, din2, din3;
    logic signed [63:0] dout1, dout2, dout3;

    parameter MEM_SIZE = 131072; // 2^17
    logic signed [15:0] sin [MEM_SIZE-1:0];
    int address;

    // Instantiate the DUT
    Three_Parallel uut (
        .clk(clk),
        .rst(rst),
        .din1(din1),
        .din2(din2),
        .din3(din3),
        .dout1(dout1),
        .dout2(dout2),
        .dout3(dout3)
    );

    // Test signal generation
    initial begin
        // Load mem
        $readmemb("input.data", sin);

        // Initialize signals
        clk = 0;
        rst = 1;
        address = 0;
        #21276 rst = 0;
    end

    assign din1 = sin[address];
    assign din2 = sin[address+1];
    assign din3 = sin[address+2];

    always @(posedge clk) begin
        if (address < MEM_SIZE) begin
            address += 3;
        end
    end

    // Clock generation: 47 KHz clock (21276ns period)
    always #10638 clk = ~clk;

endmodule
