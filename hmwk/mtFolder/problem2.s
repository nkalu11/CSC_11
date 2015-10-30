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


       /*store values of registers*/
       PUSH {r4, r5, r6, r7, r8}
       ldr r1, address_of_return /* r1 ← &address_of_return */
       str lr, [r1] /* *r1 ← lr */

       /*Loop used to ensure correct user input*/
       intro:
       /*get input of Isp pakage as well as hours used*/
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

       /*store isp package in r0*/
       ldr r0, address_of_number_read11
       ldr r0, [r0]
      
       /*store hours used in r1*/
       ldr r1, address_of_number_read22
       ldr r1, [r1]
        
       /*test r0 to determine subroutine branch based on letter input*/
       test:
       cmp r0, #0x61 @test to see if r1 is  #1
       beq planA
       cmp r0, #0x62
       beq planB
       cmp r0, #0x63
       beq planC
       bal error

       /*if r0 does not contain a, b, or c an error message prompts user that*/
       /*program will restart*/
       error:
       ldr r0, address_of_message33 /* r0 ← &message1 */
       bl printf /* call to printf */
       bal intro


      /*Determine range of hours used and branch to correct subroutine*/
      /*ISP package a*/
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

       /*if hours<=11*/
       /*set r1 to 30*/
       firstA:
       mov r1, #30
       bal end
       /*if hours <=22*/
       /*get hours over 11, multiply them by three, add 30*/
       secA:
       mov r2, #3
       mov r3, #0
       sub r3, r1, #11
       mul r3, r2
       mov r1, #30
       add r1, r1, r3
       bal end

       /*if hours >=22*/
       /*get hours over 22, multiply them by six, add 30, then add 3*11*/
       thirA:
       mov r2, #6
       mov r3, #0
       sub r3, r1, #22
       mul r3, r2
       mov r1, #30
       add r1, r1, r3
       add r1, r1, #33
       bal end

      /*Determine range of hours used and branch to correct subroutine*/
      /*ISP package b*/
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


       /*if hours <=22*/
       /*set r1 to 35*/
       firstB:
       mov r1, #35
       bal end

       /*if hours <=44*/
      /*get hours over 44, multiply them by two, add 35*/
       secB:
       mov r2, #2
       mov r3, #0
       sub r3, r1, #22
       mul r3, r2
       mov r1, #35
       add r1, r1, r3
       bal end

       /*if hours >44*/
       /*get hours over 44, multiply them by four, add 35, then add 2*22*/
       thirB:
       mov r2, #4
       mov r3, #0
       sub r3, r1, #44

       mul r3, r2
       mov r1, #35
       add r1, r1, r3
       add r1, r1, #44
       bal end

 
      /*Determine range of hours used and branch to correct subroutine*/
      /*ISP package c*/
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

       /*if hours <=33*/
       /*set r1 to 40*/
       firstC:
       mov r1, #40
       bal end

       /*if hours <=66*/
       /*get hours over 33, multiply them by 1,then  add 40*/
       secC: 
       mov r2, #1
       mov r3, #0
       sub r3, r1, #33
       mul r3, r2
       mov r1, #40
       add r1, r1, r3
       bal end

       /*if hours >=66*/
       /*get hours over 66, multiply them by two, add 40, then add 1*33*/
       thirC:
       mov r2, #2
       mov r3, #0
       sub r3, r1, #66
       mul r3, r2
       mov r1, #40
       add r1, r1, r3
       add r1, r1, #33
       bal end


       /*restore registers and branch to return address*/
        end:
        ldr r0, address_of_message22 /* r0 ← &message2 */
        bl printf /* call to printf */
        POP {r4, r5, r6, r7, r8}
        ldr lr, address_of_return /* lr ← &address_of_return */
        ldr lr, [lr] /* lr ← *lr */
        bx lr /* return from main using lr */

/*set labels to variables declared above*/
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
