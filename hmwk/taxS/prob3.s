.data
/* First message */
.balign 4
message1: .asciz "Input x for ax^2+bx : "
/* Second message */
.balign 4
message2: .asciz "Result = %d\n"
/* Format pattern for scanf */
.balign 4
scan_pattern : .asciz "%d"
/* Where scanf will store the number read */
.balign 4
number_read: .word 0
.balign 4
return: .word 0
.text
.global problem3
problem3:
 ldr r1, address_of_return /* r1 ← &address_of_return */
 str lr, [r1] /* *r1 ← lr */

 ldr r0, address_of_message1 /* r0 ← &message1 */
 bl printf /* call to printf */

 ldr r0, address_of_scan_pattern /* r0 ← &scan_pattern */
 ldr r1, address_of_number_read /* r1 ← &number_read */
 bl scanf /* call to scanf */
//store user input in r1
 ldr r1, address_of_number_read 
 ldr r1, [r1]


//compare users input with outter bounds for bit width 
//then branch to appropriate sub routine
 cmp r1, #36
 blt less36
 cmp r1, #162
 blt less162
 cmp r1, #206
 blt less206
 cmp r1, #260
 blt less260

//if x<36
 less36:
 ldr r2, =0x12b020
 ldr r3, =0xe04189

//multiply x with coeficients
 mov r0, #0
 add r0, r0, r1
 mul r1, r1, r0
 mul r1, r1, r2
 mul r0, r0, r3

//add products
 add r1, r1, r0
//shift back appropriate places
 lsr r1, #24
 bal quit
 //if x<162
 less162:
 ldr r2, =0x12b02
 ldr r3, =0xe0418
//multiply x with coeficients
 mov r0, #0
 add r0, r0, r1
 mul r1, r1, r0
 mul r1, r1, r2
 mul r0, r0, r3
//add products
 add r1, r1, r0
//shift back appropriate places
 lsr r1, #20
 bal quit
//if x<206
 less206:
 ldr r2, =0x12b0
 ldr r3, =0xe041
//multiply x with coeficients
 mov r0, #0
 add r0, r0, r1
 mul r1, r1, r0
 mul r1, r1, r2
 mul r0, r0, r3
//add products
 add r1, r1, r0
//shift back appropriate places
 lsr r1, #16
 bal quit
 //if x<206
 less260:
 ldr r2, =0x12b
 ldr r3, =0xe04
//multiply x with coeficients
 mov r0, #0
 add r0, r0, r1
 mul r1, r1, r0
 mul r1, r1, r2
 mul r0, r0, r3
//add products
 add r1, r1, r0
//shift back appropriate places
 lsr r1, #12
 bal quit

//end routine
 quit:
 ldr r0, address_of_message2 /* r0 ← &message2 */
 
 bl printf /* call to printf */

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
