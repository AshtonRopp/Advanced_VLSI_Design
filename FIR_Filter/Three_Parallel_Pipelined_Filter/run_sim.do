# Clear previous simulation data
quit -sim
vlib work
vmap work work

# Compile the design and testbench
vlog Three_Parallel_Pipelined.sv Three_Parallel_Pipelined_tb.sv top.sv

# Load the simulation
vsim -voptargs="+acc" Three_Parallel_Pipelined_tb

# Add signals to the waveform viewer
add wave -radix decimal sim:/Three_Parallel_Pipelined_tb/clk
add wave -radix decimal sim:/Three_Parallel_Pipelined_tb/rst

# Define din and dout as signed analog signals
add wave -radix signed -format analog sim:/Three_Parallel_Pipelined_tb/din1
add wave -radix signed -format analog sim:/Three_Parallel_Pipelined_tb/din2
add wave -radix signed -format analog sim:/Three_Parallel_Pipelined_tb/din3
add wave -radix signed -format analog sim:/Three_Parallel_Pipelined_tb/dout1
add wave -radix signed -format analog sim:/Three_Parallel_Pipelined_tb/dout2
add wave -radix signed -format analog sim:/Three_Parallel_Pipelined_tb/dout3

# Run the simulation for sufficient time
run 100ms

# Open the waveform window
view wave
wave zoom full
