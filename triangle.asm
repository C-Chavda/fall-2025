;****************************************************************************************************************************
;Program name: "Triangle"
;This program calculates the length of the third side of a triangle given two sides and the angle between them using the 
;Law of Cosines formula.
;Copyright (C) 2025 Chandresh Chavda.
;
;This file is part of the software program "Triangle".
;Triangle is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
;License version 3 as published by the Free Software Foundation.
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
;of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
;A copy of the GNU General Public License v3 is available at: https://www.gnu.org/licenses/
;***********************************************************************************************************************************************************************************************************************************************

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
; Author information
;   Author name: Chandresh Chavda
;   Author email: chav349@csu.fullerton.edu
;   CWID: 885158899
;   Class: 240-11 Section 11
;
; Program information
;   Program name: Triangle
;   Programming languages: One module in C, one in X86, and one in bash.
;   Date program began: 2025-Feb-01
;   Date of last update: 2025-Feb-07
;   Files in this program: geometry.c, triangle.asm, r.sh.
;   Testing: Alpha testing completed. All functions are correct.
;   Status: Ready for release to customers
;
; Purpose
;   This program calculates for the third side of a triangle based on the user's input for the other two sides and the angle between them
;
; This file:
;   File name: average.asm
;   Language: X86-64 Assembly
;   Max page width: 124 columns
;   Assemble (standard): nasm -f elf64 -l avg.lis -o avg.o average.asm
;   Assemble (debug): nasm -f elf64 -gdwarf -l avg.lis -o avg.o average.asm
;   Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;   Prototype of this function: unsigned long helloword();
;
; Notes:
;   This file contains the assembly module for the Triangle program which calculates the third side of a triangle.
;   The input is taken for the other two sides and the angle between them. The program then applies the law of cosines to find the third side.
;


;===== Begin code area ========================================================================================================

extern fgets

extern stdin

extern printf                                               ;External C++ function for writing to standard output device
extern scanf  
extern fgets
extern stdin
extern strlen
extern cos
global triangle                                    ;This makes floating_point_io callable by functions outside of this file.
string_size equ 48

last_name_prompt_size equ 40
title_prompt_size equ 40



segment .data                                               ;Place initialized data here
place_holder  dq 22.0

  ;  place_holder dq 22.0

last_name_prompt db "Please enter your last name: ", 0
title_prompt db "Please enter your title (Mr, Ms, Nurse, Engineer, etc): ", 0
sides_prompt db "Please enter the sides of your triangle separated by WS: ", 0
angle_size_prompt db "Please enter the size in degrees of the angle between those sides: ", 0

side_input_format db "%lf %lf", 0    
degree_input_format db "%lf", 0

third_side_format db "The length of the third side is: %lf units.", 0


enjoy_message db "Please enjoy your triangles %s %s.", 0


pi dq 3.141592653589793
one_eighty dq 180.0
two dq 2.0

segment .bss                                                ;Place un-initialized data here.

    align 64                                                    ;Insure that the inext data declaration starts on a 64-byte boundar.
    backuparea resb 832                                         ;Create an array for backup storage having 832 bytes.
    last_name resb 40
    title resb 40
    side_1 resq 1  ; Reserve space for the first side (double type)
    side_2 resq 1  ; Reserve space for the second side (double type)
    angle resq 1   ; Reserve space for the angle (double type)
    degree resq 1
    cos_theta resq 1
    third_side resq 1
   
;===== Begin executable instructions here =====================================================================================

segment .text                                               ;Place executable instructions in this segment.

triangle:                                          ;Entry point.  Execution begins here.

;=========== Back up all the GPRs whether used in this program or not =========================================================

    push       rbp                                              ;Save a copy of the stack base pointer
    mov        rbp, rsp                                         ;We do this in order to be 100% compatible with C and C++.
    push       rbx                                              ;Back up rbx
    push       rcx                                              ;Back up rcx
    push       rdx                                              ;Back up rdx
    push       rsi                                              ;Back up rsi
    push       rdi                                              ;Back up rdi
    push       r8                                               ;Back up r8
    push       r9                                               ;Back up r9
    push       r10                                              ;Back up r10
    push       r11                                              ;Back up r11
    push       r12                                              ;Back up r12
    push       r13                                              ;Back up r13
    push       r14                                              ;Back up r14
    push       r15                                              ;Back up r15
    pushf                                                       ;Back up rflags

    ; Promt for last name
    mov rax, 0
    mov rdi, last_name_prompt
    call printf
        

    ; Get the last name from user
  
    mov rdi, last_name
    mov rsi, last_name_prompt_size
    mov rdx, [stdin]
    call fgets

    ; remove \n
    mov rax, 0
    mov rdi, last_name
    mov rsi, 39
    call strlen
    mov byte[last_name + rax -1], 0 ;replace last character with null byte

    ; Promt for title
    mov rax, 0
    mov rdi, title_prompt
    call printf
        

    ; Get the title from user
    mov rdi, title
    mov rsi, title_prompt_size
    mov rdx, [stdin]
    call fgets

    ; remove \n
    mov rax, 0
    mov rdi, title
    mov rsi, 39
    call strlen
    mov byte[title + rax -1], 0


  ; Prompt for sides input
    mov rdi, sides_prompt
    call printf

    ; Read two floating-point numbers (sides of the triangle)
   ; Read two floating-point numbers (sides of the triangle)
    sub rsp, 16             ; Allocate space for two floats (aligned by 16 bytes)
    mov rdi, side_input_format  ; Format string for reading two doubles
    mov rsi, side_1        ; Address for the first side
    mov rdx, side_2        ; Address for the second side
    call scanf

    ; Move the input values into xmm registers
    movsd xmm14, [side_1]   ; Move first side into xmm14
    movsd xmm15, [side_2]   ; Move second side into xmm15
    add rsp, 16

;=========== Prompt for angle input ================================================================================

    ; Prompt for angle input
    mov rdi, angle_size_prompt      ; Load address of the prompt message into rdi
    call printf                    ; Call printf to display the prompt

    ; Allocate space for the angle input (double type, 8 bytes)
    sub rsp, 16                     ; Allocate space on the stack for the angle (double)

    ; Set up the format for scanf to read a floating-point value (%lf)
    mov rdi, degree_input_format   ; Load format string for reading a double
    mov rsi, degree                ; Load address of the 'degree' variable (where input will be stored)
    call scanf                     ; Call scanf to read the angle input

    ; Move the input value (angle) into xmm13 register
    movsd xmm13, [degree]          ; Move the angle value into xmm13 register (SSE register for double precision)


    ; Clean up the stack after reading the input
    add rsp, 16                     ; Restore the stack (8 bytes for the angle input)


    ; convert degree to radians
    movsd xmm13, [degree]

    mulsd xmm13, [pi]
    divsd xmm13, [one_eighty]
    movsd [degree], xmm13

    ;computes cos(0)
    mov rax, 1
    movsd xmm0, [degree]
    call cos
    movsd [cos_theta], xmm0

    ;computes 2ab*cos(0)
    movsd xmm14, [two]
    mulsd xmm14, [side_1]
    mulsd xmm14, [side_2]
    mulsd xmm14, [cos_theta]


    ;computing c^2 = a^2 + b^2
    movsd xmm13, [side_1]
    movsd xmm12, [side_2]
    mulsd xmm13, [side_1]
    mulsd xmm12, [side_2]
    addsd xmm12, xmm13
    subsd xmm12, xmm14
    sqrtsd xmm12, xmm12
 
  ; Print the length of the third side
    mov rax, 1
    mov rdi, third_side_format
    movsd xmm0, xmm12
    call printf

  
; Print the "Please enjoy your triangles" message
    mov rax, 0
    mov rdi, enjoy_message
    mov rsi, title
    mov rdx, last_name
    call printf

    movsd xmm0, xmm12
    ;Restore the original values to the GPRs
    popf                                                        ;Restore rflags
    pop        r15                                              ;Restore r15
    pop        r14                                              ;Restore r14
    pop        r13                                              ;Restore r13
    pop        r12                                              ;Restore r12
    pop        r11                                              ;Restore r11
    pop        r10                                              ;Restore r10
    pop        r9                                               ;Restore r9
    pop        r8                                               ;Restore r8
    pop        rdi                                              ;Restore rdi
    pop        rsi                                              ;Restore rsi
    pop        rdx                                              ;Restore rdx
    pop        rcx                                              ;Restore rcx
    pop        rbx                                              ;Restore rbx
    pop        rbp                                              ;Restore rbp

ret                                                         ;No parameter with this instruction.  This instruction will pop 8 bytes from
                                                            ;the integer stack, and jump to the address found on the stack.
;========== End of program fp-io.asm ======================================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
