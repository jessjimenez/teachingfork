/******************************************************************************
*Program 2: Count Partitions
*Jessica Jimenez
******************************************************************************/
 
    .global main
    .func main
   
main:
    BL  _scanf              @ scan n
    MOV R4, R0              @ store n in R4
    BL  _scanf              @ scan m
    MOV R5, R0              @ store m in R5
    MOV R1, R4              @ pass n to count partitions procedure
    MOV R2, R5              @ pass m to count partitions procedure
    BL  _cnt_part           @ branch to count partitions procedure with return
    MOV R1, R4              @ pass n to printf procedure
    MOV R2, R5              @ m to print f
    MOV R0, R0              @ pass result to printf procedure
    B  _printf              @ branch to print procedure without return
       
_printf:
    PUSH {LR}               @ store the return address
    LDR R0, =printf_str     @ R0 contains formatted string address
    BL printf               @ call printf
    POP {PC}                @ restore the stack pointer and return
   
_scanf:
    PUSH {LR}               @ store the return address
    PUSH {R1}               @ backup regsiter value
    LDR R0, =format_str     @ R0 contains address of format string
    SUB SP, SP, #4          @ make room on stack
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ remove value from stack
    POP {R1}                @ restore register value
    POP {PC}                @ restore the stack pointer and return
 
_cnt_part:
    PUSH {LR}               @ store the return address
    CMP R1, #0              @ compare the input argument to 1
    MOVEQ R0, #1            @ set return value to 1 if n equals 0
    POPEQ {PC}              @ restore stack pointer and return if equal
   
    MOVLT R0, #0            @ else if n<0, set return value to 0
    POPLT {PC}              @ restore stack pointer and return if less than
    
    CMP R2, #0              @ compare the input argument to 0
    MOVEQ R0, #0            @ set return value to 0 if n <  0
    POPEQ {PC}              @ restore stack pointer and return if equal
    @---else
    PUSH {LR}               @ store the return address
    PUSH {R1}               @ backup register value
    PUSH {R2}               @ backup regsiter value
    SUB R1, R1, R2          @ r1-r2=r1
    BL _cnt_part            @ call _cnt_part
    POP {R2}                @ restore register value
    POP {R1}                @ restore register value
    PUSH {R0}               @ backup register value
    POP {R7}                @ restore register value
    @PUSH {R2}              @ back up what we're messing up but we don't need it later so yeah
    
    SUB R2, R2, #1          @ r2-1=r2
    BL _cnt_part            @ call _cnt_part
    @POP {R2}               @ samesies
    PUSH {R0}               @ backup register value
    POP (R8}                @ restore register value
    ADD R0, R7, R8          @ r7+r8=r0
    POP {PC}                @ restore register value
    
 
.data
number:         .word       0
format_str:     .asciz      "%d"
printf_str:     .asciz      "%there are %d partitions of %d using integers up to %d\n\n"
