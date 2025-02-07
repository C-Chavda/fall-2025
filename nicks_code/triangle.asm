;****************************************************************************************************************************
;Program name: "Triangle".  This program calculates the average driving speed and time it took to go a certain distance based on user input
; Copyright (C) 2024  Nicholas Perez.          *
;                                                                                                                           *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
;but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
;the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
;<https://www.gnu.org/licenses/>.                                                                                           *
;****************************************************************************************************************************




;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Nicholas Perez
;  Author email: NicholasPerez8@csu.fullerton.edu
;  CWID: 886730910
;  Class: 240-03 Section 03
;
;Program information
;  Program name: Triangle
;  Programming languages: One module in C, one in X86, and one in bash.
;  Date program began: 2024-Jan-30
;  Date of last update: 2024-Feb-4
;  Files in this program: geometry.c, triangle.asm, r.sh.
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program is a driving time, speed, and distance calculator based on the user's input
;
;This file:
;  File name: average.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l avg.lis -o avg.o average.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -l avg.lis -o avg.o average.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: unsigned long helloword();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declarations
extern printf
extern scanf
extern fgets
extern stdin
extern strlen
extern cos
global triangle
string_size equ 48


segment .data
;declare initialized arrays

program_greeting db "Welcome to the triangle program maintained by Nicholas Perez.", 0
prompt_person_title db 10, "Please enter your title (Mr, Mrs, Nurse, Aunt, etc.): ",0
prompt_name db 10, "Please enter your name: ", 0
side_input_format db "%lf %lf", 0
prompt_sides db 10, "Please enter two side lenghts seperated by WS: ", 0
degree_input_format db "%lf", 0
prompt_degree db 10, "Please enter your angle in degrees: ", 0
third_side_format db 10, "The computed third length is: %lf ", 0
pi dq 3.141592653589793
two dq 2.0
one_eighty dq 180.0
goodbye db 10, "please enjoy your triangles %s %s", 0

segment .bss
;declare empty arrays
name resb 30
person_title resb 15
side_one resq 1
side_two resq 1
degree resq 1
cos_theta resq 1
third_side resq 1


segment .text
triangle:

;backup GPRs
push rbp
mov rbp, rsp
push rbx
push rcx
push rdx
push rdi
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf

;Prints greeting to user
mov rax, 0
mov rdi, program_greeting
call printf

;Prompts user for their name
mov rax, 0
mov rdi, prompt_name
call printf

;Keyboard input from the user
mov rax, 0
mov rdi, name
mov rsi, 20     
mov rdx, [stdin]
call fgets

;checks string length and removes null character
mov rax, 0
mov rdi, name
call strlen
mov [name+rax-1], byte 0

;prompts the user to input their title
mov rax, 0
mov rdi, prompt_person_title
call printf

;keyboard intput from user
mov rax, 0
mov rdi, person_title
mov rsi, 15
mov rdx, [stdin]
call fgets

;checks string length and removes null character
mov rax, 0
mov rdi, person_title
call strlen
mov [person_title+rax-1], byte 0

mov rax, 0
mov rdi, goodbye
mov rsi, name
mov rdx, person_title
call printf


;prompts user to input sides for triangle
mov rax, 0
mov rdi, prompt_sides
call printf

;gets the users keyboard input for the sides
mov rax, 0
mov rdi, side_input_format
mov rsi, side_one
mov rdx, side_two
call scanf

;prompts the user to input the angle (in degrees)
mov rax, 0
mov rdi, prompt_degree
call printf

;gets users keyboard input for the angle (in degrees)
mov rax, 0
mov rdi, degree_input_format
mov rsi, degree
call scanf


;Converting degree to radians
movsd xmm15, [degree]

mulsd xmm15, [pi]
divsd xmm15, [one_eighty]
movsd [degree], xmm15

;computes cos(0)
mov rax, 1
movsd xmm0, [degree]
call cos
movsd [cos_theta], xmm0

;computes 2ab*cos(0)
movsd xmm14, [two]
mulsd xmm14, [side_one]
mulsd xmm14, [side_two]
mulsd xmm14, [cos_theta]


;computing c^2 = a^2 + b^2
movsd xmm13, [side_one]
movsd xmm12, [side_two]
mulsd xmm13, [side_one]
mulsd xmm12, [side_two]
addsd xmm12, xmm13
subsd xmm12, xmm14
sqrtsd xmm12, xmm12

mov rax, 1
mov rdi, third_side_format
movsd xmm0, xmm12
call printf

movsd xmm0, xmm12

;Restore the GPRs
popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rsi
pop rdi
pop rdx
pop rcx
pop rbx
pop rbp   ;Restore rbp to the base of the activation record of the caller program
ret
;End of the function average ====================================================================

