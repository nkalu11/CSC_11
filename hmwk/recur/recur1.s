/* -- factorial01.s */
.data
 
message1: .asciz "Input a number in the sequence: "
format:   .asciz "%d"
message2: .asciz "F%d: %d\n"
 
.text
 
fibo:
    str lr, [sp,#-4]!  /* Push lr onto the top of the stack */
    str r9, [sp,#-4]!  /*keep 8 byte aligned*/                 
                       /* Note that after that, sp is 8 byte aligned */
    cmp r0, #1         /* compare r0 and 0 */
    bgt is_nonzero
    cmp r0, #1                   /* if r0 != 0 then branch */
    moveq r0, #1                 /*if r0 == 1 then mov r0, #1 and return*/   
    movlt r0, #0                 /* r0 == 0 then mov r0, #0. This is the return */
    b end
is_nonzero:
    str r0, [sp,#-4]!                    /* Prepare the call to factorial(n-1) */
    sub r0, r0, #1                       /* r0 ? r0 - 1 */
    bl fibo  
         
    str r0, [sp,#-4]!                     /* After the call r0 contains factorial(n-1) */
    ldr r0, [sp,#+4]
    sub r0, r0, #2     /* r0 ? r0 - 1 */
    bl fibo                   /* Load r0 (that we kept in th stack) into r1 */
    ldr r1, [sp]       /* r1 ? *sp */
    add r0, r0, r1 
    add sp, sp, #+8	                      /* r0 ? r0 * r1 */
    
end:
    add sp, sp, #+4             /* Discard the r0 we kept in the stack */
    ldr lr,[sp],#+4  /* Pop the top of the stack and put it in lr */
    bx lr              /* Leave factorial */
 
.globl main
main:
    str lr, [sp,#-4]!            /* Push lr onto the top of the stack */
    sub sp, sp, #4               /* Make room for one 4 byte integer in the s                               /* In these 4 bytes we will keep the number */
                                 /* entered by the user */
                                 /* Note that after that the stack is 8-byte aligned */
    ldr r0, address_of_message1  /* Set &message1 as the first parameter of printf */
    bl printf                    /* Call printf */
 
    ldr r0, address_of_format    /* Set &format as the first parameter of scanf */
    mov r1, sp                   /* Set the top of the stack as the second parameter */
                                 /* of scanf */
    bl scanf                     /* Call scanf */
    
    ldr r0, [sp]                 /* Load the integer read by scanf into r0 */
                                 /* So we set it as the first parameter of factorial */
    bl fibo                 /* Call factorial */
 
    mov r2, r0                   /* Get the result of fibonacci and move it to r2 */
                                 /* So we set it as the third parameter of printf */
    ldr r1, [sp]                 /* Load the integer read by scanf into r1 */
                                 /* So we set it as the second parameter of printf */
    ldr r0, address_of_message2  /* Set &message2 as the first parameter of printf */
    bl printf                    /* Call printf */
 
    
    add sp, sp, #+4              /* Discard the integer read by scanf */
    ldr lr, [sp], #+4            /* Pop the top of the stack and put it in lr */
    bx lr                        /* Leave main */
 
address_of_message1: .word message1
address_of_message2: .word message2
address_of_format: .word format
