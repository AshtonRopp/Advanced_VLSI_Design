# Clear previous simulation data
quit -sim
vlib work
vmap work work

# Compile the design and testbench
vlog Two_Parallel.sv Two_Parallel_tb.sv

# Load the simulation
vsim -voptargs="+acc" Two_Parallel_tb

# Add signals to the waveform viewer
add wave -radix decimal sim:/Two_Parallel_tb/clk
add wave -radix decimal sim:/Two_Parallel_tb/rst

# Define din and dout as signed analog signals
add wave -radix signed -format analog sim:/Two_Parallel_tb/din1
add wave -radix signed -format analog sim:/Two_Parallel_tb/din2
add wave -radix signed -format analog sim:/Two_Parallel_tb/dout1
add wave -radix signed -format analog sim:/Two_Parallel_tb/dout2

# Run the simulation for sufficient time
run 100ms

# Open the waveform window
view wave
wave zoom full

# Save waveform data
write list fir_filter_output.txt sim:/Two_Parallel_tb/din sim:/Two_Parallel_tb/dout1 sim:/Two_Parallel_tb/dout2
