.data
/* First message */
.balign 4
message1: .asciz "Input the ammount of numbers you want to average "
/* First message */
.balign 4
message4: .asciz "Now input the values "
/* Second message */
.balign 4
message2: .asciz "Average = %d\n"
/* Second message */
.balign 4
message3: .asciz "%d\n"
/* Format pattern for scanf */
.balign 4
scan_pattern: .asciz "%d"
/* Format pattern for scanf */
.balign 4
scan_pattern2: .asciz "%d"
/* Where scanf will store the number read */
.balign 4
number_read2: .word 0
/* Where scanf will store the number read */
.balign 4
number_read: .word 0
.balign 4
return: .word 0
.balign 4
array: .word 0
.text
.global avg

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
        blt end2   @ if r1<r2 go to end
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
        end2: @print results
        add r1, r6, #0
        POP {r5, r6, r9, lr}
        bx lr /* return from main using lr */


avg:

 PUSH { r4, r5, r6, r7, r8, r9, r10, r11}
 ldr r1, address_of_return /* r1 ← &address_of_return */
 str lr, [r1] /* *r1 ← lr */
 ldr r0, address_of_message1 /* r0 ← &message1 */
 bl printf /* call to printf */
 ldr r0, address_of_scan_pattern /* r0 ← &scan_pattern */
 ldr r1, address_of_number_read /* r1 ← &number_read */
 bl scanf /* call to scanf */


//load the address of the number inputted by user and 
//compare it to 45
 ldr r9, address_of_number_read
 ldr r9, [r9]
 cmp r9, #44
 bgt end22
 cmp r9, #1
 blt end22 

 

 ldr r0, address_of_message4 /* r0 ← &message1 */
 bl printf /* call to printf */

//input is less than 45 so we prepare the registers for array
//function
 ldr r4, addra

 mov r2, #0
 mov r3, #0
 mov r5, #0
 mov r6, #0
 mov r2, #2
 mov r7, #0
 mov r10, #0
 //array is crated and incemented with
//r2, once it is full we branch to print routine
 loop:
    cmp r10, r9
    beq  stop
    add r7, r4, r10, lsl #2  
    

    ldr r0, address_of_scan_pattern2 /* r0 ← &scan_pattern */
    ldr r1, address_of_number_read2 /* r1 ← &number_read */
    bl scanf /* call to scanf */

    ldr r5, address_of_number_read2
    ldr r5, [r5]
    str r5, [r7]
    add r10, r10, #1
    bal loop   
//this function gets the registers ready for the print routine
stop:
 ldr r7, addra
 mov r1, #0
 mov r2, #0
 mov r3, #0
 mov r5, #0
 mov r9, #0
 mov r2, #0
 mov r4, #0
 ldr r6, address_of_number_read
 ldr r6, [r6]
//this fnction 
//starts at the first item in an array and prints all itema 
//by incrementing r5 and adding multiples of 4 to r7, which
//contains the address to the array
 print_array:
    cmp r5, r6
    beq end
    add r9, r7, r5, lsl #2
    ldr r2, [r9]
    
    add r3, r3, r2 
    add r5, r5, #1
    bal print_array



//this function pops back
//registers to their original values and restores the link register
end:

  mov r1, #0
  add r1, r1, r3
  ldr r2, address_of_number_read 
  ldr r2,[r2]
  bl divideF
  ldr r0, address_of_message2 /* r0 ← &message1 */
  bl printf /* call to printf */

  

 POP { r4, r5, r6, r7, r8, r9, r10, r11}
 ldr lr, address_of_return /* lr ← &address_of_return */
 ldr lr, [lr] /* lr ← *lr */
 bx lr /* return from main using lr */
//this function pops back
//registers to their original values and restores the link register
end22:

  mov r1, #0
  
  ldr r0, address_of_message2 /* r0 ← &message1 */
  bl printf /* call to printf */



 POP { r4, r5, r6, r7, r8, r9, r10, r11}
 ldr lr, address_of_return /* lr ← &address_of_return */
 ldr lr, [lr] /* lr ← *lr */
 bx lr /* return from main using lr */

//lables for all variables
address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_message3 : .word message3
address_of_message4 : .word message4
address_of_scan_pattern2 : .word scan_pattern2
address_of_scan_pattern : .word scan_pattern
address_of_number_read : .word number_read
address_of_number_read2 : .word number_read2
address_of_return : .word return
addra: .word array
/* External */
.global printf
.global scanf
