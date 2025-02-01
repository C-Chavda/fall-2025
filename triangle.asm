;****************************************************************************************************************************
;Program name: "Basic Float Operations".  This program demonstrates the input and output of a float number and demonstrates *
;some basic math operations using float numbers.  Copyright (C) 2020 Floyd Holliday.                                        *
;                                                                                                                           *
;This file is part of the software program "Basic Float Operations".                                                        *
;Basic Float Operations is free software: you can redistribute it and/or modify it under the terms of the GNU General Public*
;License version 3 as published by the Free Software Foundation.                                                            *
;Basic Float Operations is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the       *
;implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more      *
;details.  A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                  *
;****************************************************************************************************************************

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Floyd Holliday
;  Author email: holliday@fullerton.edu
;
;Program information
;  Program name: Basic Float Operations
;  Programming languages: One modules in C++ and one module in X86
;  Date program began: 2014-Aug-25
;  Date of last update: 2014-Sep-29
;  Date comments upgraded: 2020-July-04
;  Date open source license added: 2020-Sep-20
;  Files in this program: fp-io-driver.cpp, fp-io.asm 
;  Status: Finished.
;  References consulted: Seyfarth, Chapter 11
;  Future upgrade possible: software to validate inputs and reject non-float inputs
;
;Purpose
;  This program will demonstrate how to input a single float number, multiply that inputted number by a floating point
;  constant and then output the results.
;  To students enrolled in 240 class: this program includes a secondary purpose, which is to demonstrate how to do a 
;     state component back up using instructions xsave and xrstor.  For the most part that is superflous material. You may
;     safely disregard the two sections on "state component backup".  By the way, you still have to save all the GPRs 
;     and restore them the long way.
;
;This file
;  File name: fp-io.asm
;  Language: X86 with Intel syntax.
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 -l fp-io.lis -o fp-io.o fp-io.asm


;===== Begin code area ========================================================================================================

extern fgets

extern stdin

extern printf                                               ;External C++ function for writing to standard output device

extern scanf                                                ;External C++ function for reading from the standard input device

global triangle                                    ;This makes floating_point_io callable by functions outside of this file.

segment .data                                               ;Place initialized data here
place_holder  dq 22.0

segment .bss                                                ;Place un-initialized data here.

align 64                                                    ;Insure that the inext data declaration starts on a 64-byte boundar.
backuparea resb 832                                         ;Create an array for backup storage having 832 bytes.

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



movsd xmm0, [place_holder]
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
