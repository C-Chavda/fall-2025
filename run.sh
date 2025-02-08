#!/bin/bash
# *************************************************************************************************************************
# Program name: "Triangle"                                                                                         *
# Author: Chandresh Chavda                                                                                                 *
# Program information:                                                                                                      *
# This file is the script file that accompanies the "Triangle" program.                                             *
# It prepares the necessary files for execution in normal mode.                                               *
#                                                                                                                           *
# License Information:                                                                                                      *
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
# as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.      *
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.       *
# A copy of the GNU General Public License v3 is available at: https://www.gnu.org/licenses/                                  *
# *************************************************************************************************************************

# Program: run.sh
# Purpose: This script compiles and runs the "Triangle" program
# Files: triangle.asm, geometry.c, run.sh
# Clean up old files


rm -f *.o
rm -f *.out

echo "This is program <Triangle>"

# Step 1: Assemble the module triangle.asm into triangle.o
echo "Assemble the module triangle.asm"
nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm

<<<<<<< HEAD
# Step 2: Compile the C module geometry.c into geometry.o
echo "Compile the C module geometry.c"
gcc -c -m64 -Wall -o geometry.o geometry.c -no-pie -std=c2x
=======
echo "Compile the C module fp-io-driver.cpp"
gcc -c -m64 -Wall -o file1.o geometry.c -fno-pie -no-pie -std=c2x
>>>>>>> 6c7c03e48c532ec8e343911ef3b48ce7153a940e


# Step 3: Link the two object files into triangle.out
echo "Link the two object files already created"
<<<<<<< HEAD
gcc -m64 -o triangle.out geometry.o triangle.o -no-pie -std=c2x -lm   # Link math library with -lm
=======
gcc -m64 -o fpio.out file1.o triangle.o -lm -fno-pie -no-pie -std=c2x -z noexecstack
>>>>>>> 6c7c03e48c532ec8e343911ef3b48ce7153a940e

# Step 4: Run the program Triangle
echo "Run the program Triangle"
chmod +x triangle.out
./triangle.out