.data
/* First message */
.balign 4
message1: .asciz "Vt: %f "
/* Second message */
.balign 4
message2: .asciz "q: %f\n"
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
first: .float .0196
//variable value
.balign 4
second: .float .0023679
//variable value
.balign 4
third: .float 0.5
//variable value
.balign 4
fourth: .float 3.14
//variable value
.balign 4
fifth: .float 8
//variable value
.balign 4
sixth: .float .10125
//variable value
.balign 4
zero: .float 0.00
//variable value
.balign 4
cmp1: .word 10000000


.text
.global main 
main:

   ldr r1, address_of_return
   str lr, [r1] /* *r1 ← lr */
   
   ldr r5, acmp1
   ldr r5, [r5]
   mov r4, #0
   
   loop:
       
   
//load values into registers   
   ldr r1, fir
   VLDR s1, [r1]
    ldr r1, sec
   VLDR s2, [r1]
   ldr r1, thir
   VLDR s3, [r1]
   ldr r1, for
   VLDR s4, [r1]

   ldr r1, zer
   VLDR s0, [r1]
    ldr r1, zer
   VLDR d5, [r1]

   ldr r1, fif
   VLDR s5, [r1]
   ldr r1, six
   VLDR s6, [r1]
     
  //first 4 multiplcations are for the denominator in vt function
   VMUL.F32 S0, S1, S2
   VMUL.F32 S0, S0, S3
   VMUL.F32 S0, S0, S4
   //last two multiplications are for numberator
   VMUL.F32 S5, S5, S6
   VDIV.F32 S0, S5, S0

  //Initialize variables
   ldr r1, zer
   VLDR s3, [r1]

   VADD.F32 S3, S3, s0
  //square root
   VSQRT.F32 S3, S3 
  //q function
   VMUL.F32 S0, S0, s2
   ldr r1, thir
   VLDR s4, [r1]

   VMUL.F32 S0, S0, s4

   add r4, r4, #1
   cmp r4, r5
   blt loop

  //get registers ready to print
   VMOV.F32 S20, S0

   VMOV s14, s3
  
   VCVT.F64.F32 d5, s14
  
   ldr r0, address_of_message1

   VMOV r2, r3, d5
   

   bl printf /* call to printf */
  
  //get registers ready to print

   VMOV s14, s20

   VCVT.F64.F32 d5, s14

   ldr r0, address_of_message2

   VMOV r2, r3, d5


   bl printf /* call to printf */
  
   ldr lr, address_of_return /* lr ← &address_of_return */
   ldr lr, [lr] /* lr ← *lr */
   bx lr /* return from main using lr */
//reference to variables
acmp1: .word cmp1
fir: .word first
sec: .word second
thir: .word third
for: .word fourth
fif: .word fifth
six: .word sixth
zer: .word zero
address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_scan_pattern : .word scan_pattern
addnr : .word number_read
address_of_return : .word return
/* External */
.global printf
.global scanf
