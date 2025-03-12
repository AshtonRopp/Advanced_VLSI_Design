# Clear previous simulation data
quit -sim
vlib work
vmap work work

# Compile the design and testbench
vlog Pipelined_FIR.sv Pipelined_FIR_tb.sv

# Load the simulation
vsim -voptargs="+acc" Pipelined_FIR_tb

# Add signals to the waveform viewer
add wave -radix decimal sim:/Pipelined_FIR_tb/clk
add wave -radix decimal sim:/Pipelined_FIR_tb/rst
add wave -radix signed -format analog sim:/Pipelined_FIR_tb/din
add wave -radix signed -format analog sim:/Pipelined_FIR_tb/dout

add list sim:/Pipelined_FIR_tb/din sim:/Pipelined_FIR_tb/dout

# Run the simulation for sufficient time
run 100ms

# Open the waveform window
view wave
wave zoom full
