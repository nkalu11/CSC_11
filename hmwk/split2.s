.data
.balign 4
return2: .word 0
.text

.global mult_by_5


mult_by_5:
 ldr r1, address_of_return2 /* r1 ← &address_of_return */
 str lr, [r1] /* *r1 ← lr */
 add r0, r0, r0, LSL #2 /* r0 ← r0 + 4*r0 */
 ldr lr, address_of_return2 /* lr ← &address_of_return */
 ldr lr, [lr] /* lr ← *lr */
 bx lr /* return from main using lr */
 address_of_return2 : .word return2

