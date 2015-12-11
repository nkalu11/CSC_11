.data
/* First message */
.balign 4
message1: .asciz "Input number of years (1 - 20).\n"
/* Second message */
.balign 4
message2: .asciz "Input present value. ($1000 - $5000)\n"
/* Second message */
.balign 4
message3: .asciz "Input interest rate (.05 - .1)\n"
/* Second message */
.balign 4
message4: .asciz "Year %d: %f\n"
/* Format pattern for scanf */
.balign 4
scan_pattern: .asciz "%d"
/* Format pattern for scanf */
.balign 4
scan_pattern2: .asciz "%f"
/* Format pattern for scanf */
.balign 4
scan_pattern3: .asciz "%f"
/* Where scanf will store the number read */
.balign 4
number_read: .word 0
/* Where scanf will store the number read */
.balign 4
number_read2: .word 0
/* Where scanf will store the number read */
.balign 4
number_read3: .word 0
.balign 4
//variable value
return: .word 0
.balign 4
one: .float 1.000
//variable value
.balign 4
zero: .float 0.000
//variable value
.balign 4
array: .word 0

.text
.global problem2
problem2:

 push {r4, r5, r6, r7, r8, r9, r10, lr}
// ldr r1, address_of_return /* r1 ← &address_of_return */
// str lr, [r1] /* *r1 ← lr */
 ldr r0, address_of_message1 /* r0 ← &message1 */
 bl printf /* call to printf */


 ldr r0, address_of_scan_pattern /* r0 ← &scan_pattern */
 ldr r1, address_of_number_read /* r1 ← &number_read */
 bl scanf /* call to scanf */

 ldr r0, address_of_message2 /* r0 ← &message1 */
 bl printf /* call to printf */

 ldr r0, address_of_scan_pattern2 /* r0 ← &scan_pattern */
 ldr r1, address_of_number_read2 /* r1 ← &number_read */
 bl scanf /* call to scanf */

 ldr r0, address_of_message3 /* r0 ← &message1 */
 bl printf /* call to printf */

 ldr r0, address_of_scan_pattern3 /* r0 ← &scan_pattern */
 ldr r1, address_of_number_read3 /* r1 ← &number_read */
 bl scanf /* call to scanf */


//initialize registers
 mov r10, #1
 ldr r9, address_of_number_read
 ldr r9, [r9]
 mov r2, #1
 mov r3, #0
 mov r5, #0
 ldr r6, addra
 mov r8, #1
 //array is crated and incemented with
//r2, outter loop for array inner loop for FV function
 loop:
    cmp r2, r9
    bgt  stop
//initiaialize registers
    mov r8, #1
    ldr r1, aone
   VLDR s1, [r1]
   ldr r1, address_of_number_read3
   VLDR s0, [r1]
   ldr r1, address_of_number_read2
   VLDR s3, [r1]
//1+rate
   VADD.F32 s1, s1, s0
   ldr r1, azero
   VLDR s4, [r1]
 //save value of 1+rate in s4  
 VADD.F32 s4, s4, s1
    //inner loop for rasing 1+rate to the j power
    loopi:
    cmp r8, r2
    beq end3
//(1+rate)*(1+rate)
   VMUL.F32 s1, s1, s4
   add r8, r8, #1
   bal loopi
   end3:
   mov r7, #0
   add r7, r7, r2
   sub r7, r7, #1
   //PV*(1+rate)^i
   VMUL.F32 s3, s3, s1

    add r3, r6, r7, lsl #2
//store value in array index
    VSTR s3, [r3]
    add r2, r2, #1
    bal loop


stop:
ldr r7, addra
 mov r1, #0
 mov r2, #0
 mov r3, #0
 mov r5, #0
 mov r9, #0
 mov r2, #0
 mov r4, #0
 ldr r6, address_of_number_read
ldr r6, [r6]
//this fnction
//starts at the first item in an array and prints all itema
//by incrementing r5 and adding multiples of 4 to r7, which
//contains the address to the array
 print_array:
    cmp r5, r6
    beq stop2
    add r9, r7, r5, lsl #2
    VLDR s1, [r9]
    add r4, r4, #1
    add r1, r4, #0

   VCVT.F64.F32 d5, s1

   VMOV r2, r3, d5

    ldr r0, address_of_message4 /* r0 ← &message2 */
    bl  printf
    add r5, r5, #1
    bal print_array



stop2:


pop {r4, r5, r6, r7, r8, r9, r10, lr}

 bx lr /* return from main using lr */
addra: .word array
aone: .word one
azero: .word zero
address_of_message1: .word message1
address_of_message2: .word message2
address_of_message3: .word message3
address_of_message4: .word message4
address_of_scan_pattern3: .word scan_pattern3
address_of_scan_pattern2: .word scan_pattern2
address_of_scan_pattern: .word scan_pattern
address_of_number_read: .word number_read
address_of_number_read2: .word number_read2
address_of_number_read3: .word number_read3
address_of_return: .word return
/* External */
.global printf
.global scanf

