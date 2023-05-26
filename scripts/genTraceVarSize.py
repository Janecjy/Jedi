import os
import random
import sys

def multiply_files(input_directory, output_directory, ratio):
    # Create the output directory if it doesn't exist
    if not os.path.exists(output_directory):
        os.makedirs(output_directory)

    # Get a list of all files in the input directory
    files = os.listdir(input_directory)

    for file_name in files:
        input_file_path = os.path.join(input_directory, file_name)
        output_file_path = os.path.join(output_directory, file_name)

        with open(input_file_path, 'r') as input_file, open(output_file_path, 'w') as output_file:
            for line in input_file:
                # Split the line into three columns
                columns = line.strip().split(',')

                # Get the values from the first two columns
                column1 = columns[0]
                column2 = columns[1]

                # Generate a random value between 1 and 2x-1
                random_value = random.randint(1, 2*ratio)

                # Multiply the value in the third column by the random value
                multiplied_value = str(float(columns[2]) * random_value)

                # Write the modified row to the output file
                output_file.write(f'{column1},{column2},{multiplied_value}\n')

# Example usage
ratio = sys.argv[1]
input_dir = "/mydata/traces"
output_dir = "/mydata/traces-"+str(ratio)+'x'

multiply_files(input_dir, output_dir, ratio)