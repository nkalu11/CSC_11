.data
.balign 4
return2: .word 0

.text
.global to_F

to_F:
   ldr r1, address_of_return2 /* r1 ← &address_of_return */
   str lr, [r1] /* *r1 ← lr */
   ldr r1, =0x1ccccd @wd6 bp-20
   mul r0, r1   /*r0 * r1*/
   lsr r0, #20  @shift 24 places right
   add r0, #32  /*r0 +32*/
   ldr lr,  address_of_return2 /*lr ← &address_of_return*/ 
   ldr lr, [lr]   /*lr *[lr]*/
   
 end:
 ldr lr, address_of_return2 /* lr ← &address_of_return */
 ldr lr, [lr] /* lr ← *lr */
 bx lr /* return from main using lr */
 address_of_return2: .word return2
 
