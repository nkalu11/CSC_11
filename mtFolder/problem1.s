.data
/* First message */
.balign 4
message1: .asciz "Enter hours worked followed by pay rate "
/* Second message */
.balign 4
message2: .asciz "Your earnings are $%d\n"
/* Second message */
.balign 4
message3: .asciz "Error invalid input\n"
/* Where scanf will store the number read */
.balign 4
number_read: .word 0
/* Where scanf will store the number read */
.balign 4
number_read2: .word 0
/* Format pattern for scanf */
.balign 4
scan_pattern: .asciz "%d"
/* Format pattern for scanf */
.balign 4
scan_pattern2: .asciz "%d"
/*return*/
.balign 4
return: .word 0
.text
.global first
first:

       /*Save value of registers*/
       PUSH {r4, r5, r6, r7, r8}
       ldr r1, address_of_return /* r1 ← &address_of_return */
       str lr, [r1] /* *r1 ← lr */

       /*loop to ensure correct user input*/
       intro:
       ldr r0, address_of_message1 /* r0 ← &message1 */
       bl printf /* call to printf */
       ldr r0, address_of_scan_pattern /* r0 ← &scan_pattern */
       ldr r1, address_of_number_read /* r1 ← &number_read */
       bl scanf /* call to scanf */

       ldr r0, address_of_scan_pattern2 /* r0 ← &scan_pattern */
       ldr r1, address_of_number_read2 /* r1 ← &number_read */
       bl scanf /* call to scanf */

       /*store pay rate in r0*/
       ldr r0, address_of_number_read2
       ldr r0, [r0]

       /*store hours worked in r1*/
       ldr r1, address_of_number_read
       ldr r1, [r1]

       /*test used to determine range of hours worked*/
       /*and then determine the sub routine that will operate on it*/
       test:
       cmp r1, #40 @test to see if r1 is  #1
       blt normal
       cmp r1, #40
       beq normal
       cmp r1, #50
       blt fifty
       cmp r1, #50
       beq fifty
       cmp r1, #60
       blt sixty
       cmp r1, #60
       beq sixty
       bal error
       /*if hours worked>60 an error message will be displayed and user will*/
       /*have to re-enter*/
       error:
       ldr r0, address_of_message3 /* r0 ← &message1 */
       bl printf /* call to printf */
       bal intro


       /*hours <= 40*/
       normal:
       mul r1, r0
       bal end  

       /*40<hours<=50*/
       /*determine how many hours over 40 there are*/
       /*apply the double rate and then add it to the rate*40*/
       fifty:
       mov r4, #40
       mov r8, #2
       add r6, r0, #0
       sub r5, r1, #40
       mul r0, r0, r8
       mul r0, r5
       mov r1, #0
       mul r1, r6, r4
       add r1, r1, r0
       bal end

       /*50<hour<=60*/
       /*determine how many hours over 50 there are*/
       /*apply the triple to it rate and then add it to the rate*40*/
       /*and then add this to 10*double rate*/
       sixty:
       mov r6, #0
       mov r3, #0
       mov r2, #0
       mov r7, #3
       mul r7, r0
       sub r3, r1, #50
       mul r2, r3, r7
       mov r4, #40
       mov r8, #2
       add r6, r0, #0
       mov r5, #10
       mul r0, r0, r8
       mul r0, r5
       mov r1, #0
       mul r1, r6, r4
       add r1, r1, r0
       add r1, r1, r2
       bal end



       /*This function restores registers and branches to return*/
        end:
        ldr r0, address_of_message2 /* r0 ← &message2 */
        bl printf /* call to printf */
        POP {r4, r5, r6, r7, r8}
        ldr lr, address_of_return /* lr ← &address_of_return */
        ldr lr, [lr] /* lr ← *lr */
        bx lr /* return from main using lr */



/*Give lables to all variables declared above*/
address_of_message1: .word message1
address_of_message2: .word message2
address_of_message3: .word message3
address_of_scan_pattern: .word scan_pattern
address_of_scan_pattern2: .word scan_pattern2
address_of_number_read: .word number_read
address_of_number_read2: .word number_read2
address_of_return: .word return
/* External */
.global printf
.global scanf

