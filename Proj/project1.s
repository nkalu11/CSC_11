.data
/* First message */
.balign 4
message11: .asciz "Enter a number follwed by an arithmatic\n symbol followed by another number, eaxmple: 3 * 7\n or enter '0 q 0' to quit(*, /, +, -, %(mod)) : "
/* Second message */
.balign 4
message22: .asciz "%d * %d = %d\n"
/* Third message */
.balign 4
message44: .asciz "%d / %d = %d\n"
/* Fourth message */
.balign 4
message55: .asciz "%d - %d = %d\n"
/* fifth message */
.balign 4
message66: .asciz "%d + %d = %d\n"
/* sixth message */
.balign 4
message77: .asciz "%d (mod) %d = %d\n"
/* Seventh message */
.balign 4
message33: .asciz "Error invalid input. RE-RUN THE PROGRAM NOW.\n"
/* Where scanf will store the number read */
.balign 4
number_read11: .word 0
/* Where scanf will store the number read */
.balign 4
number_read22: .word 0
/* Where scanf will store the number read */
.balign 4
number_read33: .word 0
/* Format pattern for scanf */
.balign 4
scan_pattern11: .asciz "%c"
/* Format pattern for scanf */
.balign 4
scan_pattern22: .asciz "%d\n"
/* Format pattern for scanf */
.balign 4
scan_pattern33: .asciz "%d"
.balign 4
return: .word 0
.text
.global main
main:


       /*store values of registers*/
       PUSH {r4, r5, r6, r7, r8}
       ldr r1, address_of_return /* r1 ← &address_of_return */
       str lr, [r1] /* *r1 ← lr */

       /*Loop used to ensure correct user input and to run program as lon as user wants*/
       intro:
       /*Prompt user on correct input*/
        ldr r0, address_of_message11 /* r0 ← &message1 */
        bl printf /* call to printf */
        
       /*get first number from user*/ 
       ldr r0, address_of_scan_pattern22 /* r0 ← &scan_pattern */
       ldr r1, address_of_number_read22 /* r1 ← &number_read */
       bl scanf /* call to scanf */
    
       /*get character input from user*/
       ldr r0, address_of_scan_pattern11 /* r0 ← &scan_pattern */
       ldr r1, address_of_number_read11 /* r1 ← &number_read */
       bl scanf /* call to scanf */

       /*get second number input*/
       ldr r0, address_of_scan_pattern33 /* r0 ← &scan_pattern */
       ldr r1, address_of_number_read33 /* r1 ← &number_read */
       bl scanf /* call to scanf */
 
       /*put inputted character in r0*/
       ldr r0, address_of_number_read11
       ldr r0, [r0]
      
       /* store first number input in r1*/
       ldr r1, address_of_number_read22
       ldr r1, [r1]
        
       /*store second number input in r2*/
       ldr r2, address_of_number_read33
       ldr r2, [r2]

       /*test r0 to determine subroutine branch based on character input*/
       test:
       cmp r0, #0x2a @* 
       beq mult
       cmp r0, #0x2b @+
       beq addition
       cmp r0, #0x2d @-
       beq subtract
       cmp r0, #0x2f @/
       beq division
       cmp r0, #0x71 @q
       beq quit
       cmp r0, #0x25 @%
       beq mod
       bal error



     /*this routine branches to the mod function and then prints the returned value*/
      mod:
        bl  modFunc
      mov r3, r1
        /* store first number input in r1*/
       ldr r1, address_of_number_read22
       ldr r1, [r1]

       /*store second number input in r2**/
       ldr r2, address_of_number_read33
       ldr r2, [r2]

         bal endMod

       /*this routine multiplys both numbers and then prints the returned value*/
      mult:
        mul r1, r2
        mov r3, r1 
        /* store first number input in r1*/
       ldr r1, address_of_number_read22
       ldr r1, [r1]

       /* store second number input in r2*/
       ldr r2, address_of_number_read33
       ldr r2, [r2]

         bal endM

     /*add both numbers and print the result*/
      addition:
       add r1, r2
       
       mov r3, r1 
       /* store first number input in r1*/
       ldr r1, address_of_number_read22
       ldr r1, [r1]

       /* store second number input in r1*/
       ldr r2, address_of_number_read33
       ldr r2, [r2]

       bal endA
          /*Subtract second from first number and print result*/
      subtract:

        sub r1, r2
        mov r3, r1
       /* store first number input in r1*/
       ldr r1, address_of_number_read22
       ldr r1, [r1]

       /* store second number input in r2*/
       ldr r2, address_of_number_read33
       ldr r2, [r2]

         bal endS
        /*branch to divFunc and print result*/
      division:
         bl divideF
       
       mov r3, r1     
       /* store first number input in r1*/
       ldr r1, address_of_number_read22
       ldr r1, [r1]

       /* store second  number input in r1*/
       ldr r2, address_of_number_read33
       ldr r2, [r2]

         bal endD

       /*if r0 does not contain +, *, /, -, or % an error message prompts user that*/
       /*program will restart*/
       error:
       ldr r0, address_of_message33 /* r0 ← &message33 */
       bl printf /* call to printf */
       bal intro



        /*output mod result*/
        endMod:
        ldr r0, address_of_message77 /* r0 ← &message77 */
        bl printf /* call to printf */
        bal intro

       /*print product*/
        endM:
        ldr r0, address_of_message22 /* r0 ← &message22 */
        bl printf /* call to printf */
        bal intro

        /*print quotient*/
        endD:
        ldr r0, address_of_message44 /*r0 &message44 */
        bl printf /* call to printf */
        bal intro

        /*print difference*/
        endS:
        ldr r0, address_of_message55 /* r0 ← &message44 */
        bl printf /* call to printf */
        bal intro

        /*print after addtion*/
        endA:
        ldr r0, address_of_message66 /* r0 ← &message66 */
        bl printf /* call to printf */
        bal intro


/*restore registers and branch to return address*/
        quit:
        POP {r4, r5, r6, r7, r8}
        ldr lr, address_of_return /* lr ← &address_of_return */
        ldr lr, [lr] /* lr ← *lr */
        bx lr /* return from main using lr */

/*set labels to variables declared above*/
address_of_message11: .word message11
address_of_message22: .word message22
address_of_message33: .word message33
address_of_message44: .word message44
address_of_message55: .word message55
address_of_message66: .word message66
address_of_message77: .word message77
address_of_scan_pattern11: .word scan_pattern11
address_of_scan_pattern22: .word scan_pattern22
address_of_scan_pattern33: .word scan_pattern33
address_of_number_read11: .word number_read11
address_of_number_read22: .word number_read22
address_of_number_read33: .word number_read33
address_of_return: .word return
/* External */
.global printf
.global scanf
