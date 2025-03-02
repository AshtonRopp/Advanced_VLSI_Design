import csv

def convert_list_to_csv(input_file, output_file):
    with open(input_file, 'r') as infile, open(output_file, 'w', newline='') as outfile:
        csv_writer = csv.writer(outfile)
        for line in infile:
            line = line.strip()
            if line: #skip empty lines
                parts = line.split()  # Split by whitespace
                csv_writer.writerow(parts)

# Usage:
convert_list_to_csv('fir_filter_output.txt', 'signal_values.csv')