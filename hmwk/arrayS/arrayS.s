/* Local array */
.data
/* First message */
.balign 4
message1: .asciz "Hey, type a number: "
/* Second message */
.balign 4
message2: .asciz "F%d: %d\n"
/* Format pattern for scanf */
.balign 4
scan_pattern : .asciz "%d"
/* Where scanf will store the number read */
.balign 4
number_read: .word 0
.balign 4
return: .word 0
.text
.global main
main:
 ldr r1, address_of_return /* r1 ← &address_of_return */
 str lr, [r1] /* *r1 ← lr */
 ldr r0, address_of_message1 /* r0 ← &message1 */
 bl printf /* call to printf */
 ldr r0, address_of_scan_pattern /* r0 ← &scan_pattern */
 ldr r1, address_of_number_read /* r1 ← &number_read */
 bl scanf /* call to scanf */
 
push {r4, r5, r6, r7, r8, r9, r10} /* keep registers */
//get user input
ldr r8, address_of_number_read
ldr r8, [r8]
mov r10, #0

add r10, r8, #0
//decide if input is too big and if so return 0, or if it is 0 or 1, then return 1 if so
cmp r8, #2
movlt r1, #1
blt end2
cmp r8, #44
movgt r1, #0
bgt end2

//subract 2 from r8 since loop runs n-2 times
sub r8, r8, #2
//initialize registers
mov r1, #0
mov r5, #1
mov r6, #1
mov r7, #0
mov r9, #0
//push initial values of fn-1 and fn-2
push {r5, r6}


//This loop pops fn-2 and fn-1 onto the stack, 
//pops them off, and then adds them
//and then push fn and fn-1
loop:
pop {r5, r6}

cmp r9, r8
beq print

add r7, r5, r6
push {r6, r7}
add r9, r9, #1
bal loop

//print fn
print:
mov r1, r10
mov r2, r7
ldr r0, address_of_message2 /* r0 ← &number_read */
bl printf /* call to print*/


end:
 push {r4, r5, r6, r7, r8, r9, r10}
 ldr lr, address_of_return /* lr ← &address_of_return */
 ldr lr, [lr] /* lr ← *lr */
 bx lr /* return from main using lr */

//end routine for input less than 2
end2:
ldr r0, address_of_message2 /* r0 ← &number_read */
bl printf /* call to print*/

 push {r4, r5, r6, r7, r8, r9, r10}
 ldr lr, address_of_return /* lr ← &address_of_return */
 ldr lr, [lr] /* lr ← *lr */
//refrence to variables
address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_scan_pattern : .word scan_pattern
address_of_number_read : .word number_read
address_of_return : .word return
/* External */
.global printf
.global scanf
