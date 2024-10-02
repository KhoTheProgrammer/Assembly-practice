# File: PromptInt.asm
# Author: Kondwani Padyera
# Purpose: To illustrate implementing and calling a
# subprogram named PrintNewLine.
.text
main:
 # read an input value from the user
 la $a0, prompt
 jal PromptInt
 move $s0, $v0
 
 # print the value back to the user
 jal PrintNewLine
 la $a0, result
 move $a1, $s0
 jal PrintInt
 
 # call the Exit subprogram to exit
 jal Exit
 
.data
 prompt: .asciiz "Please enter an integer: "
 result: .asciiz "You entered: "
 
# subprogram: PrintNewLine
# author: Charles Kann
# purpose: to output a new line to the user console
# input: None
# output: None
# side effects: A new line character is printed to the 
# user's console
.text
PrintNewLine:
 li $v0, 4
 la $a0, __PNL_newline
 syscall 
 jr $ra
.data
 __PNL_newline: .asciiz "\n"
# subprogram: PrintInt
# author: Charles W. Kann
# purpose: To print a string to the console
# input: $a0 - The address of the string to print.
# $a1 - The value of the int to print
# returns: None
# side effects: The String is printed followed by the integer value.
.text
PrintInt: 
 # Print string. The string address is already in $a0
 li $v0, 4
 syscall
 
 # Print integer. The integer value is in $a1, and must
 # be first moved to $a0.
 move $a0, $a1
 li $v0, 1
 syscall
 
 #return
 jr $ra
# subprogram: PromptInt
# author: Charles W. Kann
# purpose: To print the user for an integer input, and
# to return that input value to the caller.
# input: $a0 - The address of the string to print.
# returns: $v0 - The value the user entered
# side effects: The String is printed followed by the integer value.
.text
PromptInt: 
 # Print the prompt, which is already in $a0
 li $v0, 4
 syscall
 
 # Read the integer value. Note that at the end of the 
 # syscall the value is already in $v0, so there is no 
 # need to move it anywhere.
 li $v0, 5
 syscall
 
 #return
 jr $ra
 
# subprogram: PrintString
# author: Charles W. Kann
# purpose: To print a string to the console
# input: $a0 - The address of the string to print.
# returns: None
# side effects: The String is printed to the console.
.text
PrintString: 
 addi $v0, $zero, 4
 syscall
 jr $ra
 
# subprogram: Exit
# author: Charles Kann
# purpose: to use syscall service 10 to exit a program
# input: None
# output: None
# side effects: The program is exited
.text
Exit:
 li $v0, 10
 syscall