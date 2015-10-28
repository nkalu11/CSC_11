/* -- printf02.s */
.data
/* First message */
.balign 4
message1: .asciz "Type a temperature range to convert followed by \n 1 to convert to celsius or 2 to convert to fahrenheit : "
/* Second message */
.balign 4
message2: .asciz  "%d Fahrenheit is approx %d Celsius \n"
/* Third  message */
.balign 4
message3: .asciz "%d Celsius is approx %d Fahrenheit \n"
/* Third  message */
.balign 4
message5: .asciz "%Input 1 to convert to celsius or 2 to convert to fahrenheit \n"
/* fourth  message */
.balign 4
message4: .asciz "Input a range of temperatures to convert\n"
/* Format pattern for scanf */
.balign 4
scan_pattern: .asciz "%d"
/* Format pattern for scanf */
.balign 4
scan_pattern2: .asciz "%d"
/* Format pattern for scanf */
.balign 4
scan_pattern3: .asciz "%d"
/* Where scanf will store the number read */
.balign 4
number_read3: .word 0
/* Where scanf will store the number read */
.balign 4
number_read2: .word 0
/* Where scanf will store the number read */
.balign 4
number_read: .word 0
.balign 4
return: .word 0
.text

.global main
main:

 push {r5,r6,r8,r9}
 ldr r1, address_of_return /* r1 ← &address_of_return */
 str lr, [r1] /* *r1 ← lr */
 ldr r0, address_of_message1 /* r0 ← &message1 */
 bl printf /* call to printf */

 ldr r0, address_of_scan_pattern /* r0 ← &scan_pattern */
 ldr r1, address_of_number_read /* r1 ← &number_read */
 bl scanf /* call to scanf */

 ldr r0, address_of_scan_pattern2 /* r0 ← &scan_pattern */
 ldr r1, address_of_number_read2 /* r1 ← &number_read */
 bl scanf /* call to scanf */

ldr r0, address_of_scan_pattern3 /* r0 ← &scan_pattern */
 ldr r1, address_of_number_read3 /* r1 ← &number_read */
 bl scanf /* call to scanf */
ldr r8, address_of_scan_pattern3
ldr r8, [r8]



 ldr r5, address_of_number_read2
 ldr r5, [r5] 
 mov r6, #-1
 mov r9, #0
cmp r8, #2
beq loop2
bal loop1
loop1:
 ldr r0, address_of_number_read /* r0 ← &number_read */ 
 ldr r0, [r0] /* r0 ← *r0 */
 add r0, r0, r6
 add r9, r0, r6 
bl to_C 


 mov r2, r0 /* r2 ← r0 */
 ldr r1, address_of_number_read /* r1 ← &number_read*/
 ldr r1, [r1] /* r1 ← *r1 */
 add r1, r6
 ldr r0, address_of_message2 /* r0 ← &message2 */
 bl printf /* call to printf */
add r6, r6, #1
 cmp r9,r5

 blt loop1
 pop {r5,r6,r8,r9}
bal end


loop2:
 ldr r0, address_of_number_read
 ldr r0, [r0] 
 add r0, r0, r6 
 bl to_F

 mov r2, r0 
 ldr r1, address_of_number_read /* r1 ← &number_read*/
 ldr r1, [r1] /* r1 ← *r1 */
 add r1, r6
 ldr r0, address_of_message3 /* r0 ← &message2 */
 bl printf /* call to printf */
add r6, r6, #1
 cmp r9,r5
 blt loop2
 pop {r5,r6,r8,r9}
bal end
end:
 ldr lr, address_of_return /* lr ← &address_of_return */
 ldr lr, [lr] /* lr ← *lr */
 bx lr /* return from main using lr */
address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_message3 : .word message3
address_of_message5 : .word message5

address_of_scan_pattern : .word scan_pattern
address_of_scan_pattern2 : .word scan_pattern2
address_of_scan_pattern3 : .word scan_pattern3
address_of_number_read : .word number_read
address_of_number_read2 : .word number_read2
address_of_number_read3 : .word number_read3
address_of_return : .word return
/* External */
.global printf
.global scanf
