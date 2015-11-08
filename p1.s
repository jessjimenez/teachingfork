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
    BL  _scanf
    MOV R1, R0
    BL  _getchar            @ branch to scanf procedure with return
    MOV R3, R0              @ move return value R0 to argument register R3
    BL  _scanf
    MOV R2, R0
    BL  _op                 @ check the scanf input
    BL  _printf
    B _exit

_exit:  
    MOV R7, #4          @ write syscall, 4
    MOV R0, #1          @ output stream to monitor, 1
    MOV R2, #21         @ print string length
    LDR R1,=exit_str    @ string at label exit_str:
    SWI 0               @ execute syscall
    MOV R7, #1          @ terminate syscall, 1
    SWI 0               @ execute syscall  
 
_scanf:
    MOV R4, LR              @ store LR since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_str     @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    MOV PC, R4              @ return

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
    CMP R3, #'+'            @ compare against the constant char '+'
    BEQ _sum                @ branch to equal handler
    MOV PC, R4
 
_sum:
    ADD R10, R1, R2
    MOV PC, R8              @return?

_printf:
    MOV R6, LR              @ store LR since printf call overwrites
    LDR R0, =printf_ans     @ R0 contains formatted string address
    MOV R10, R10            @ R1 contains printf argument (redundant line)
    BL printf               @ call printf
    MOV PC, R6              @ return
    
.data
format_str:         .asciz      "%d"
read_char:          .ascii      " "
printf_ans:         .asciz      "%d \n"
exit_str:           .ascii      "Terminating program.\n"
