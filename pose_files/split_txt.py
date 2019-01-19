import argparse
import os

parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('--file', default=None, type=str, help="path to txt file that we want to split")
parser.add_argument('--num', default=2, type=int, help="number of target files")
parser.add_argument('--output-dir', default='output', type=str, help='dir to store output files')

args = parser.parse_args()
assert args.file, "file path is nesserary."

if not os.path.exists(args.output_dir):
    os.makedirs(args.output_dir)

input_filename = args.file.split('/')[-1].split('.')[0]
output_filenames = [input_filename + '_' + str(i) for i in range(args.num)]

file_counter = 0
with open(args.file, 'r') as f_in:
    full_lines = f_in.readlines()
    assert len(full_lines) % args.num == 0, 'cannot split into %d files with %d lines input.' % (args.num, len(full_lines))
    each_num = len(full_lines) // args.num
    line_counter = 0
    for line in full_lines:
        line = line.strip()
        if line_counter >= each_num:
            file_counter += 1
            line_counter = 0
        output_file = os.path.join(args.output_dir, output_filenames[file_counter] + '.txt')
        with open(output_file, 'a') as f_out:
            f_out.writelines(line + '\n')
        line_counter += 1
