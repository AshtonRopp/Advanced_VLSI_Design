N = 99;  % Filter order (number of taps - 1)
Fs = 1;   % Assume normalized frequency (1 corresponds to π rad/sample)

% Define frequency bands
f = [0 0.2 0.23 1];  % Normalized frequency bands (π corresponds to 1)
a = [1 1 0 0];       % Desired amplitude response

% Weights for passband and stopband
w = [1 10];  % Higher weight in stopband for better attenuation

% Design the filter using Parks-McClellan algorithm
b = firpm(N, f, a, w);

word_length = 16;  % Total bits
frac_bits = 15;    % Fractional bits

% Convert to fixed-point (Q1.15 format)
quantized_b = fi(b, 1, word_length, frac_bits);

% Convert to integer representation (scaled to fit signed 16-bit)
int_coeffs = int16(quantized_b * (2^frac_bits)); ;

% Save quantized coefficients to csv
writematrix(int_coeffs, 'quantized_coefficients.csv');

% Plot frequency response of unquantized filter
fvtool(b, 1)
