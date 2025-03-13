create_clock -period 21276.000 -name clk -add [get_ports clk]
set_input_delay -clock clk 100.000 [get_ports din]
set_output_delay -clock clk 100.000 [get_ports dout]