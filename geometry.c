//****************************************************************************************************************************
//Program name: "Basic Float Operations".  This program demonstrates the input and output of a float number and demonstrates *
//some basic math operations using float numbers.  Copyright (C) 2020 Floyd Holliday.                                        *
//                                                                                                                           *
//This file is part of the software program "Basic Float Operations".                                                        *
//Basic Float Operations is free software: you can redistribute it and/or modify it under the terms of the GNU General Public*
//License version 3 as published by the Free Software Foundation.                                                            *
//Basic Float Operations is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the       *
//implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more      *
//details.  A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                  *
//****************************************************************************************************************************
//
//Comment to students: notice how the Copyright Notice is separated from the License Notice.  The copyright part establishes
//you as the legal owner.  The license notice states what rights are conveyed to the recipient of this program.  The GPL3 
//conveys these basic rights: permission to study the source code, modify the source code, run it on any platform, distribute
//it in any media.   The GPL3 prohibits the recipient from removing the license from the source code and it prohibits
//information about the previous author(s).  There are more details about what GPL3 allows and disallows, but this is not
//the place to enumerate everything.  Visit the GNU website to know more details.
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//===== Begin code area ============================================================================================================
//Modifications by:                                                                                                           *
//  Author name: Chandresh Chavda                                                                                             *
//  Author email: chav349@csu.fullerton.edu                                                                                   *
//  CWID: 885158899                                                                                                           *
//  Class: 240-11 Section 11                                                                                                  *
//  Date program modified: 2025-Feb-07                                                                                       *
//                                                                                                                           *
//License information                                                                                                         *
//  This program is free software: you can redistribute it and/or modify it under the terms of the                            *
//  GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or            *
//  (at your option) any later version.                                                                                        *
//  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied       *
//  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.    *
//  A copy of the GNU General Public License v3 is available at: https://www.gnu.org/licenses/                                  *
//****************************************************************************************************************************

//Program information                                                                                                         *
//  Program name: Triangle                                                                                             *
//  Programming languages: C and X86                                                                                           *
//  Purpose: This program calculates for the third side of a triangle based on user inputs and the angle between them.         *
//  Files in this program: geometry.c, triangle.asm, run.sh                                                                     *
//                                                                                                                           *
//Modifications by:                                                                                                           *
//  Author name: Chandresh Chavda                                                                                             *
//  Author email: chav349@csu.fullerton.edu                                                                                   *
//  CWID: 885158899                                                                                                           *
//  Class: 240-11 Section 11                                                                                                  *
//  Date program modified: 2025-Feb-07                                                                                        *
//                                                                                                                           *
//Original Author:                                                                                                            *
//  Author name: Floyd Holliday                                                                                               *
//  Author email: holliday@fullerton.edu                                                                                      *
//  Program name: Basic Float Operations                                                                                       *
//  Programming languages: One module in C++ and one module in X86                                                            *
//  Date program began: 2014-Aug-25                                                                                           *
//  Date of last update: 2014-Sep-29                                                                                           *
//  Date open source license added: 2020-Sep-20                                                                              *
//  Date Basic Float Operations 2.0 released: 2020-November-6                                                                *
//  Files in this program: fp-io-driver.cpp, fp-io.asm                                                                       *
//  Status: Finished.                                                                                                         *
//  References consulted: Seyfarth, Chapter 11                                                                                *
//  Future upgrade possible: software to validate inputs and reject non-float inputs                                          *
//                                                                                                                           *
//Purpose of this file:                                                                                                       *
//This file defines the main program that takes user input for triangle sides and calculates the third side using a formula.  *
//It includes external function calls from triangle.asm.                                                                     *
//
//This file                                                                                                                   *
//  File name: geometry.c                                                                                                     *
//  Language: C                                                                                                               *
//  Compile: gcc -m64 -Wall -no-pie -o geometry.o -std=c2x -c geometry.c                                                       *
//  Link: gcc -m64 -no-pie -o calc.out geometry.o triangle.o -std=c2x -Wall -z noexecstack 
//****************************************************************************************************************************

#include <stdio.h>
#include <math.h>
//#include <stdint.h>    //Library not used
//#include <ctime>
//#include <cstring>

extern double triangle();

int main(){

    printf("Welcome to the Triangle program maintained by Chandresh Chavda.\n");
    double count = 0;
    printf("\nIf errors are discovered please report them to Chandresh Chavda at chav349@csu.fullerton.edu for a quick fix.\n");
    count = triangle();
    printf("\nThe main function received this number %8lf and plans to keep it until needed. An integer zero will be returned to the operating system. Bye.\n", count);
    return 0;

}//End of main
