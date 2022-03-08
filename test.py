#!/usr/bin/env python3

file_name = '/Users/yamamotoryuuji/Documents/words.txt'
with open(file_name, mode='r') as f:
    data = f.readlines()
print(data)
