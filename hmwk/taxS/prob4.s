.data
/* First message */
.balign 4
message1: .asciz "Input x for ax^2+bx : "
/* Second message */
.balign 4
message2: .asciz "%f\n"
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
first: .float 0.073
//variable value
.balign 4
second: .float 0.876
//variable value
.balign 4
zero: .float 0.000



.text
.global problem4 
problem4:

   ldr r1, address_of_return
   str lr, [r1] /* *r1 ← lr */
   ldr r0, address_of_message1 /* r0 ← &message1 */
   bl printf /* call to printf */

   ldr r0, address_of_scan_pattern /* r0 ← &scan_pattern */
   ldr r1, addnr /* r1 ← &number_read */
   bl scanf /* call to scanf */


   //initialize rgisters
   ldr r1, addnr
   VLDR s1, [r1]
  
   ldr r1, zer
   VLDR s0, [r1]

   //copy x into s0
   VADD.F32 s0, s0, s1
  //x*2
   VMUL.F32 s1, s1, s0   
 //load .073 into s7
    ldr r1, fir
   VLDR s7, [r1]
//.073*x^2
   VMUL.F32 s1, s1, s7
//load .876 into s2
   ldr r1, sec
   VLDR s2, [r1]
//x*.876
   VMUL.F32 s0, s0, s2
//add the prducts
   VADD.F32 s1, s1, s0

//contvert value to 64 bit
   VCVT.F64.F32 d5, s1
   
   //prepare registers to print
   ldr r0, address_of_message2

   VMOV r2, r3, d5
      

   bl printf /* call to printf */
   ldr lr, address_of_return /* lr ← &address_of_return */
   ldr lr, [lr] /* lr ← *lr */
   bx lr /* return from main using lr */

fir: .word first
sec: .word second
zer: .word zero
address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_scan_pattern : .word scan_pattern
addnr : .word number_read
address_of_return : .word return
/* External */
.global printf
.global scanf
