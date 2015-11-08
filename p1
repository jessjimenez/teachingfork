/******************************************************************************
*Addition of two numbers - Jessica Jimenez
*input:
*5
*+
*15
*
*output:
*20
******************************************************************************/


    .global main
    .func main
   
main:
    BL  _getchar
    MOV R1, R0
    BL  _getchar            @ branch to scanf procedure with return
    MOV R3, R0              @ move return value R0 to argument register R3
    BL  _getchar
    MOV R2, R0
    BL  _op                 @ check the scanf input
    B _exit

_exit:  
    MOV R7, #4          @ write syscall, 4
    MOV R0, #1          @ output stream to monitor, 1
    MOV R2, #21         @ print string length
    LDR R1,=exit_str    @ string at label exit_str:
    SWI 0               @ execute syscall
    MOV R7, #1          @ terminate syscall, 1
    SWI 0               @ execute syscall  
 
_getchar:
    MOV R7, #3              @ write syscall, 3
    MOV R0, #0              @ input stream from monitor, 0
    MOV R2, #1              @ read a single character
    LDR R1, =read_char      @ store the character in data memory
    SWI 0                   @ execute the system call
    LDR R0, [R1]            @ move the character to the return register
    AND R0, #0xFF           @ mask out all but the lowest 8 bits
    MOV PC, LR              @ return
 
_op:
    CMP R3, #'+'            @ compare against the constant char '@'
    BEQ _sum                @ branch to equal handler
    MOV PC, R4
 
_sum:
    MOV R5, LR              @ store LR since printf call overwrites
    ADD R10, R1, R2
    LDR R0, =print_ans      @ R0 contains formatted string address
    MOV R11, R10
    BL printf               @ call printf
    MOV PC, R5              @ return


.data
read_char:      .ascii      " "
print_ans:      .asciz      "%d \n"
exit_str:       .ascii      "Terminating program.\n"
