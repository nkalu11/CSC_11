.data
/* First message */
.balign 4
message1: .asciz "Input a value to find the square root of: "
/* Second message */
.balign 4
message2: .asciz "sqrt: %f\n"
.balign 4
/* Format pattern for scanf */
.balign 4
scan_pattern: .asciz "%f"
/* Where scanf will store the number read */
.balign 4
number_read: .word 0
//variable value
.balign 4 
return: .word 0
//variable value
.balign 4
zero: .float 0.000
//variable value
.balign 4
two: .float 2.000
//variable value
.balign 4
six: .float 0.0001


.text
.global square 
square:
  
 //  push {r4, r5, r6, r7, r8}
     ldr r1, address_of_return
     str lr, [r1] /* *r1 ← lr */
   
     ldr r0, address_of_message1 /* r0 ← &message1 */
     bl printf /* call to printf */

       ldr r0, address_of_scan_pattern /* r0 ← &scan_pattern */
       ldr r1, addnr /* r1 ← &number_read */  
       bl scanf /* call to scanf */
   
   ldr r1, addnr
   VLDR s1, [r1]
   ldr r1, adzero
   VLDR s0, [r1]
   ldr r1, adzero
   VLDR s3, [r1]
   ldr r1, adzero
   VLDR s4, [r1]

   ldr r1, adtwo
   VLDR s2, [r1]
   ldr r1, adsix
   VLDR s6, [r1]
   ldr r1, adzero
   VLDR s8, [r1]
   ldr r1, adzero
   VLDR s7, [r1]

   VADD.F32 S7, S7, S1
  loop:
  
    VDIV.F32 S4, S1, S7
    VADD.F32 S7, S7, S4
    VDIV.F32 S7, S7, S2
  
   check:
    ldr r1, adzero
    VLDR s5, [r1]
    VSUB.F32 S5, S7, S4
    VCMP.F32 S5, S6
    VMRS APSR_nzcv, FPSCR
   bgt loop
  
   VMOV s14, s7

  // VCVT.F64.F32 d5, s14
   VCVT.F64.F32 d0, s14
   
   ldr r0, address_of_message2

   VMOV r2, r3, d0
      

   bl printf /* call to printf */
 
   // pop {r4, r5, r6, r7, r8}
   ldr lr, address_of_return /* lr ← &address_of_return */
   ldr lr, [lr] /* lr ← *lr */
   bx lr /* return from main using lr */

adtwo: .word two
adzero: .word zero
adsix: .word six
address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_scan_pattern : .word scan_pattern
addnr : .word number_read
address_of_return : .word return
/* External */
.global printf
.global scanf
