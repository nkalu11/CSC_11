.data
/* First message */
.balign 4
message11: .asciz "Enter your ISP package letter\n(ONLY ENTER A LOWER CASE LETTER FROM a, b, or c!!) : "
/* Second message */
.balign 4
message22: .asciz "Your Monthly bill is $%d\n"
/* Second message */
.balign 4
message44: .asciz "Enter the hours you used : \n"
/* Second message */
.balign 4
message33: .asciz "Error invalid input. RE-RUN THE PROGRAM NOW.\n"
/* Where scanf will store the number read */
.balign 4
number_read11: .word 0
/* Where scanf will store the number read */
.balign 4
number_read22: .word 0
/* Format pattern for scanf */
.balign 4
scan_pattern11: .asciz "%c"
/* Format pattern for scanf */
.balign 4
scan_pattern22: .asciz "%d"
.balign 4
return: .word 0
.text
.global second
second:
       PUSH {r4, r5, r6, r7, r8}
       ldr r1, address_of_return /* r1 ← &address_of_return */
       str lr, [r1] /* *r1 ← lr */

       intro:
       ldr r0, address_of_message11 /* r0 ← &message1 */
       bl printf /* call to printf */

       ldr r0, address_of_scan_pattern11 /* r0 ← &scan_pattern */
       ldr r1, address_of_number_read11 /* r1 ← &number_read */
       bl scanf /* call to scanf */


       ldr r0, address_of_scan_pattern11 /* r0 ← &scan_pattern */
       ldr r1, address_of_number_read11 /* r1 ← &number_read */
       bl scanf /* call to scanf */


       ldr r0, address_of_message44 /* r0 ← &message1 */
       bl printf /* call to printf */


       ldr r0, address_of_scan_pattern22 /* r0 ← &scan_pattern */
       ldr r1, address_of_number_read22 /* r1 ← &number_read */
       bl scanf /* call to scanf */

       
       ldr r0, address_of_number_read11
       ldr r0, [r0]

       ldr r1, address_of_number_read22
       ldr r1, [r1]
        
       
       test:
       cmp r0, #0x61 @test to see if r1 is  #1
       beq planA
       cmp r0, #0x62
       beq planB
       cmp r0, #0x63
       beq planC
       bal error

       error:
       ldr r0, address_of_message33 /* r0 ← &message1 */
       bl printf /* call to printf */
       bal intro



       planA:
       cmp r1, #11
       blt firstA
       cmp r1, #11
       beq firstA

       cmp r1, #22
       blt secA
       cmp r1, #22
       beq secA
       cmp r1, #22
       bgt thirA

       firstA:
       mov r1, #30
       bal end

       secA:
       mov r2, #3
       mov r3, #0
       sub r3, r1, #11
       mul r3, r2
       mov r1, #30
       add r1, r1, r3
       bal end


       thirA:
       mov r2, #6
       mov r3, #0
       sub r3, r1, #22
       mul r3, r2
       mov r1, #30
       add r1, r1, r3
       add r1, r1, #33
       bal end

       planB:
       cmp r1, #22
       blt firstB
       cmp r1, #22
       beq firstB
       cmp r1, #44
       blt secB
       cmp r1, #44
       beq secB
       cmp r1, #44
       bgt thirB



       firstB:
       mov r1, #35
       bal end


       secB:
       mov r2, #2
       mov r3, #0
       sub r3, r1, #22
       mul r3, r2
       mov r1, #35
       add r1, r1, r3
       bal end


       thirB:
       mov r2, #4
       mov r3, #0
       sub r3, r1, #44

       mul r3, r2
       mov r1, #35
       add r1, r1, r3
       add r1, r1, #44
       bal end


       planC:
       cmp r1, #33
       beq firstC
       cmp r1, #33
       blt firstC
       cmp r1, #66
       beq secC
       cmp r1, #66
       blt secC
       cmp r1, #66
       bgt thirC

       firstC:
       mov r1, #40
       bal end

       secC:
       mov r2, #1
       mov r3, #0
       sub r3, r1, #33
       mul r3, r2
       mov r1, #40
       add r1, r1, r3
       bal end


       thirC:
       mov r2, #2
       mov r3, #0
       sub r3, r1, #66
       mul r3, r2
       mov r1, #40
       add r1, r1, r3
       add r1, r1, #33
       bal end



        end:
        ldr r0, address_of_message22 /* r0 ← &message2 */
        bl printf /* call to printf */
        POP {r4, r5, r6, r7, r8}
        ldr lr, address_of_return /* lr ← &address_of_return */
        ldr lr, [lr] /* lr ← *lr */
        bx lr /* return from main using lr */


address_of_message11: .word message11
address_of_message22: .word message22
address_of_message33: .word message33
address_of_message44: .word message44
address_of_scan_pattern11: .word scan_pattern11
address_of_scan_pattern22: .word scan_pattern22
address_of_number_read11: .word number_read11
address_of_number_read22: .word number_read22
address_of_return: .word return
/* External */
.global printf
.global scanf
