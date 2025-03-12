# Pipelined FIR Filter Optimization Project

## Highlights
- Designed 4 FIR filters using SystemVerilog using parallelism and pipelining
- Simulated and synthesized filters in Vivado to perform power and area analysis
- Used MATLAB filterDesigner to acquire filter coefficients

## MATLAB Filter Design
The goal of the project was to design a 102-tap low-pass filter with the transition region of 0.2pi-0.23pi radians/sample and stopband attenuation of at least 80dB. To acquire the coefficients, I used the MATLAB Filter Designer Tool, which can be launched in MATLAB with the command `filterDesigner`. Then, we construct the filter as shown below.

<center>

| ![](Images/MATLAB.png) |
|:--:|
| *Figure 1: MATLAB filter response* |
</center>

There are a few things of note.
1. The filter has a sampling frequency of 47 kHz. This can be set by right clicking the plot and entering the configuration as shown below in Figure 2.
2. Instead of showing the radians/sample in the plot, we can opt to show the frequency instead. We can configure this by right clicking the x-axis and choosing the options shown in Figure 2.
3. There is significant dB loss after ~5 Khz.
4. The quantized and reference responses are nearly identical. This is because I used 32 bit coefficients, with 31 bits allocated to the fraction. This allows near perfect performance from the quantized filter.

<center>

| ![](Images/Sampling_Frequency.png) |
|:--:|
| *Figure 2: setting sampling frequency* |
</center>


<center>

| ![](Images/Show_Frequency.png) |
|:--:|
| *Figure 3: show frequency on plot* |
</center>

After the filter has been designed, the coefficients must be extracted. This can be done by selecting `Targets-->Generate C header...`. We can then make the selections shown below in Figure 4, and save the results to [fdacoefs.h](fdacoefs.h)

After that, we paste the results into [coefs.py](coefs.py). Running the script will then output the coefficients line by line in signed binary. After adding the proper SystemVerilog tags, we can place the coefficients into the code as shown below.

    logic signed [31:0] coef [TAPS-1:0];

    initial begin
        coef = '{
            32'b11111111111110000101000100011100,
            32'b11111111111000110010100001001110,
            ....
        };

Since these coefficients are created by increasing the magnitude of the original values, we must account for this by shifting the output of our filters right by 31 digits.

## Simulation Inputs
We can generate the inputs for the testbench files by using a simple python script. The code written in [generate_sin.py](generate_sin.py) generates 50 signals with frequencies increasing logarithmically from log(500) to log(20000). This allows us to generate a frequency response graph similar to the one shown above from MATLAB. Running this file saves the configured data to `input.data`.


## Pipelined FIR Filter
![](Images/FIR_Pipelined.png)

<embed src="schematic.pdf" type ="application/pdf">


## MATLAB Library Requirements
- Signal Processing Toolbox
- Fixed-Point Designer Toolbox


## References
[1] https://people.ece.umn.edu/users/parhi/SLIDES/chap9.pdf
