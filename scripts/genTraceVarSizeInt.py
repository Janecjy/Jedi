import os
import random
import sys
import numpy as np

size_table = {} # id: size

def multiply_files(input_file_path, output_file_path, ratio):
    choices = np.arange(1, 2*ratio, 1)

    with open(input_file_path, 'r') as input_file, open(output_file_path, 'w') as output_file:
        print(input_file_path)
        print(output_file_path)
        for line in input_file:
            # Split the line into three columns
            columns = line.strip().split(',')

            # Get the values from the first two columns
            column1 = columns[0]
            column2 = columns[1]
            
            if column2 in size_table.keys():
                multiplied_value = size_table[column2]
            else:

                # Generate a random int value between 1 and 2x-1
                random_value = np.random.choice(choices, 1)[0]

                # Multiply the value in the third column by the random value
                multiplied_value = str(int(float(columns[2]) * random_value))
                size_table[column2] = multiplied_value

            # Write the modified row to the output file
            output_file.write(f'{column1},{column2},{multiplied_value}\n')

# Example usage
ratio = int(sys.argv[1])
input_file_path = sys.argv[2]
output_file_path = sys.argv[3]

multiply_files(input_file_path, output_file_path, ratio)