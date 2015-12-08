/* -- printf02.s */
.data
/* First message */
.balign 4
message1: .asciz "Vt: %d "
/* Second message */
.balign 4
message2: .asciz "q: %d\n"
/* Format pattern for scanf */
.balign 4
scan_pattern : .asciz "%d"
/* Where scanf will store the number read */
.balign 4
number_read: .word 0
.balign 4
return: .word 0
.text



 /*initialize registers and save value of high registers*/
       divideF:
       PUSH {r5, r6, r9, lr}
   
        mov r5, #1
        mov r4, #0 @initialize r4
        add r4, r2 @store contents of r2 in r4
        mov r6, #0
        /*compare r1 and r2, if r2<r1 prepare r2 for shifted subtraction*/
        check:
        cmp r1, r2 @compare r1 and r2
        blt end   @ if r1<r2 go to end
        lsl r2, #1 @shift r1 once
        lsl r5, #1 @shift r1 to 1
        cmp r1, r2 @cmpare r1 and r2
        blt sub    @if r2 is less than r1 go to end
        bl check   @else branch to the end
        /*if r2>r1 shift it right once then subract it from r1 then go back to check*/
        sub:
        lsr r2, #1 @shift r2 right #1
        lsr r5, #1 @shift r5 right #1
        sub r1, r1, r2 @subtract r1 from r2
        add r6, r6, r5 @add r5 and r6
        mov r2, #0 @set r2 to original value
        add r2, r4 @store contents of r4 in r2
        mov r5, #1 @set r5 to #1
        bl check @go to the chech
       /*restore registers and output results*/
        end: @print results
        add r1, r6, #0
        POP {r5, r6, r9, lr}
        bx lr /* return from main using lr */

.global main
main:

 ldr r1, address_of_return /* r1 ← &address_of_return */
 str lr, [r1] /* *r1 ← lr */
 PUSH {r4, r5, r6, r7, r8, r9} 
//load values into registers
 ldr r1, =0x5
 ldr r2, =0x32
 ldr r3, =0x9b
 ldr r4, =0x80
 ldr r5, =0x19eb85
 ldr r6, =0x8

//first 4 multiplcations are for the denominator in vt function
 mov r0, #0

 mul r0, r1, r2
 mul r0, r0, r3
 mul r0, r0, r4
//shift denominator relative to numnerator
 lsr r0, #12
 
 //last two multiplications are for numerator
 mul r5, r5, r6 
//Initialize variables
 mov r1, #0
 mov r2, #0
 add r1, r1, r5
 add r2, r2, r0
//divide 8wt by denominator
 bl divideF
//Initialize variables
 mov r7, #0
 add r7, r7, r1
 mov r9, #0
 add r9, r9, r1
 mov r2, #0
 mov r3, #0
 add r2, r2, r1
 add r3, r3, r1
 mov r8, #0
 //babylonian square root
 loop:
   bl divideF
   add r9, r9, r1
   mov r1, #0
   mov r2, #2
   add r1, r1, r9
   bl divideF
   mov r9, #0
   add r9, r9, r1
   mov r1, #0
   add r1, r1, r3
    mov r2, #0
   add r2, r2, r9
   add r8, r8, #1
   cmp r8, #10
   blt loop 

   //store vt in r1
   mov r1, r9


   ldr r2, =0x9b
   //q function
   //load "roe"
   mul r2, r2, r7
   //shift q
   lsr r2, #17

   mov r9, r2  
//output
 ldr r0, address_of_message1 /* r0 ← &message2 */
 bl printf /* call to printf */

//store q in r1
 mov r1, r9
 //output
 ldr r0, address_of_message2 /* r0 ← &message2 */
 bl printf /* call to printf */

 POP {r4, r5, r6, r7, r8, r9}
 ldr lr, address_of_return /* lr ← &address_of_return */
 ldr lr, [lr] /* lr ← *lr */
 bx lr /* return from main using lr */
address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_scan_pattern : .word scan_pattern
address_of_number_read : .word number_read
address_of_return : .word return
/* External */
.global printf
.global scanf
