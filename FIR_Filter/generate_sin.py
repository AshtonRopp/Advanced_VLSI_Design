# Generates input data

import math
import numpy as np

def generate_sine_waves():
    time_step_ns = 21276  # Hardcoded time step
    frequencies = [int(f) for f in np.logspace(math.log10(500), math.log10(20000), num=50)]  # Logarithmic spacing
    num_points = 200
    
    with open("input.data", "w") as f:
        for frequency in frequencies:
            for i in range(num_points):
                t = i * time_step_ns * 1e-9  # Convert ns to seconds
                sine_value = 10000 * math.sin(2.0 * math.pi * frequency * t)
                rounded_sine_value = int(sine_value)
                binary_sine_value = format(rounded_sine_value & 0xFFFF, '016b')  # Convert to 16-bit signed binary
                f.write(f"{binary_sine_value}\n")

if __name__ == "__main__":
    generate_sine_waves()
