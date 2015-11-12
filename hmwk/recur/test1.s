.data
/* First message */
.balign 4
message1: .asciz "Input size of array : "
/* Second message */
.balign 4
message2: .asciz "Term F%d: %d\n"
/* Second message */
.balign 4
message3: .asciz "%d\n"
/* Format pattern for scanf */
.balign 4
scan_pattern : .asciz "%d"
/* Where scanf will store the number read */
.balign 4
number_read: .word 0
.balign 4
return: .word 0
.balign 4
array: .word 0
.text
.global main
main:

 PUSH { r4, r5, r6, r7, r8, r9}
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
 //these comparisons test for invalid inputs
 cmp r9, #45
 bgt badinp
 cmp r9,#0
 beq badinp
 //this test is to see if input is 1 
 //and to brach to special routine to handle this
 cmp r9,#1
 beq for1


//input is less than 45 so we prepare the registers for array
//function
 ldr r1, addra

 mov r2, #1
 str r2, [r1]
 mov r2, #1
 str r2, [r1,#4]
 mov r3, #0
 mov r5, #0
 mov r6, #0
 mov r2, #2
 //array is crated and incemented with
//r2, once it is full we branch to print routine
 loop:
    cmp r2, r9
    beq  stop
    add r3, r1, r2, lsl #2  
    ldr r5, [r3,#-4]
    ldr r6, [r3,#-8]
    add r5, r5, r6
    str r5, [r3]
    add r2, r2, #1
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
    add r4, r4, #1
    add r1, r4, #0
    ldr r0, address_of_message2 /* r0 ← &message2 */
    bl  printf 

    add r5, r5, #1
    bal print_array

for1:
    mov r2, #1
    mov r1, #1
    ldr r0, address_of_message2 /* r0 ← &message2 */
    bl  printf
bal end

 badinp:
   mov r1, #0
   ldr r0, address_of_message3 /* r0 ← &message2 */
   bl  printf
  

//this function pops back
//registers to their original values and restores the link register
end:

 POP { r4, r5, r6, r7, r8, r9}
 ldr lr, address_of_return /* lr ← &address_of_return */
 ldr lr, [lr] /* lr ← *lr */
 bx lr /* return from main using lr */
//lables for all variables
address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_message3 : .word message3
address_of_scan_pattern : .word scan_pattern
address_of_number_read : .word number_read
address_of_return : .word return
addra: .word array
/* External */
.global printf
.global scanf
