/* menu.s */
.data
/* First message */
.balign 4
message1: .asciz "Input 1, 2, or 3 for the problem you want to see\n When youre done input 5: "
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
  POP {r6}
 loop:
 ldr r0, address_of_message1 /* r0 ← &message1 */
 bl printf /* call to printf */

 ldr r0, address_of_scan_pattern /* r0 ← &scan_pattern */
 ldr r1, address_of_number_read /* r1 ← &number_read */
 bl scanf /* call to scanf */

 ldr r1, address_of_number_read /* r1 ← &number_read */
 ldr r1, [r1] /* r1 ← *r1 */

 cmp r1, #1
 beq firstl
 cmp r1, #2
 beq secl
 cmp r1, #3
 beq thirl
 cmp r1, #5
 beq end
bal loop

firstl:
bl first
bal loop

secl:
 bl second
 bal loop

thirl:
 bl third
 bal loop




 end:
 PUSH {r6}
 ldr lr, address_of_return /* lr ← &address_of_return */
 ldr lr, [lr] /* lr ← *lr */
 bx lr /* return from main using lr */
address_of_message1 : .word message1
address_of_scan_pattern : .word scan_pattern
address_of_number_read : .word number_read
address_of_return : .word return
/* External */
.global printf
.global scanf
