% Import the CSV file
data = readtable('FIR_Filter/signal_values.csv');

% Display the table (optional)
disp(data);

% Assuming your CSV has columns named 'Time' and 'Signal'
time = data.Var1;
signal = data.Var4;

% Create the plot
plot(time, signal);

% Add labels and title
xlabel('Time');
ylabel('Signal Value');
title('Signal vs. Time');

% Add a grid (optional)
grid on;