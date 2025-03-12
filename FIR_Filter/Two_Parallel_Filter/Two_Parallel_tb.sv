`timescale 1ns/1ps

module Two_Parallel_tb;

    // Testbench signals
    logic clk;
    logic rst;
    logic signed [15:0] din1, din2;
    logic signed [63:0] dout1;
    logic signed [63:0] dout2;
    int fd;
    int scan;


    // Instantiate the DUT
    Two_Parallel uut (
        .clk(clk),
        .rst(rst),
        .din1(din1),
        .din2(din2),
        .dout1(dout1),
        .dout2(dout2)
    );

    // Test signal generation
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        din1 = 0;
        din2 = 0;
        #10638 rst = 0; // Deassert reset after 20ns


        // Open the fd for reading
        fd = $fopen("input.tv", "r");

        // Check if the fd opened successfully
        if (!fd) begin
            $display("Failed to open file.");
        end
    end


    always @(posedge clk) begin
        scan = $fscanf(fd,"%d\n",din1);
        scan = $fscanf(fd,"%d\n",din2);
        if ($feof(fd)) begin
            $fclose(fd);
        end
    end

    // Clock generation: 47 KHz clock (21276ns period)
    always #10638 clk = ~clk;

endmodule
