N = 100;  % Filter order (number of taps - 1)
Fs = 1;   % Assume normalized frequency (1 corresponds to π rad/sample)

% Define frequency bands
f = [0 0.2 0.23 1];  % Normalized frequency bands (π corresponds to 1)
a = [1 1 0 0];       % Desired amplitude response

% Weights for passband and stopband
w = [1 10];  % Higher weight in stopband for better attenuation

% Design the filter using Parks-McClellan algorithm
b = firpm(N, f, a, w);

% Plot frequency response
fvtool(b, 1)
