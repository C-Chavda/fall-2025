#!/bin/bash


#Author: Floyd Holliday
#Program name: Basic Float Operations

rm *.o
rm *.out

echo "This is program <Demonstrate Numeric IO>"

echo "Assemble the module fp-io.asm"
nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm

echo "Compile the C module fp-io-driver.cpp"
gcc -c -m64 -Wall -o file1.o geometry.c -fno-pie -no-pie -std=c++17

echo "Link the two object files already created"
gcc -m64 -o fpio.out file1.o triangle.o -fno-pie -no-pie -std=c++17 -z noexecstack

echo "Run the program Basic Float Operations"
./fpio.out

echo "The bash script file is now closing."
