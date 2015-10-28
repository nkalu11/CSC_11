.data
/* First message */
.balign 4
message1: .asciz "Input a term in the fibonacci sequence: "
/* Second message */
.balign 4
message2: .asciz " %d\n"
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
 
 PUSH {r5,r6}
 ldr r1, address_of_return /* lr ← &address_of_return */
 str lr, [r1] /* lr ← *lr */
 
  ldr r0, address_of_message1 /* r0 ← &message1 */
 bl printf /* call to printf */
 ldr r0, address_of_scan_pattern /* r0 ← &scan_pattern */
 ldr r1, address_of_number_read /* r1 ← &number_read */
 bl scanf /* call to scanf*/

  ldr r5, address_of_number_read
  ldr r5, [r5]
  mov r6, #0
  mov r1, #1
  mov r0, #1
  bal test

  loop:
  mov r3, #0
  add r3, r1, #0
  add r1, r1, r0
  mov r0, r3
  add r6, r6, #1
  cmp r6, r5
  blt loop
  bal end




  test:
  cmp r5, #1
  beq end1
  cmp r5, #2
  beq end1
  sub r5, r5, #2
  bal loop

 
end:
 ldr r0, address_of_message2 /* r0 ← &message2 */
 bl printf /* call to printf*/
 POP {r5, r6}
 ldr lr, address_of_return /* lr ← &address_of_return */
 ldr lr, [lr] /* lr ← *lr */
 bx lr /* return from main using lr */

end1:
 ldr r0, address_of_message2 /* r0 ← &message2 */
 bl printf /* call to printf*/
 POP {r5, r6}
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
