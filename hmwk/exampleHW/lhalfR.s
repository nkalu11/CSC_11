.data
/*return*/
.balign 4
return3: .word 0

.text
.global to_C

to_C:
   ldr r1, address_of_return3 /* r1 ← &address_of_return */
   str lr, [r1] /* *r1 ← lr */
   sub r0, #32  /*r0 - 32*/
   ldr r1, =0x8E38E4 @wd6 bp-24
   mul r0, r1  /*r0* r1*/
   lsr r0, #24  @shift 24 places right
   ldr lr,  address_of_return3/* lr ← &address_of_return */
   ldr lr, [lr]/*lr  *[ lr] */

 end:
 ldr lr, address_of_return3 /* lr ← &address_of_return */
 ldr lr, [lr] /* lr ← *lr */
 bx lr /* return from main using lr */
 address_of_return3: .word return3

