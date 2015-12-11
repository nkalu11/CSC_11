/* menu.s */
.data
/* First message */
.balign 4
message1: .asciz "Input 1, 2, 3, or 4 for the problem you want to see : "
/* Format pattern for scanf */
.balign 4
scan_pattern : .asciz "%d"
/* Where scanf will store the number read */
.balign 4
number_read: .word 0
/*return*/
.balign 4
return: .word 0
.text
.global main
main:

 ldr r1, address_of_return /* r1 ← &address_of_return */
 str lr, [r1] /* *r1 ← lr */
 
 ldr r0, address_of_message1 /* r0 ← &message1 */
 bl printf /* call to printf */

 ldr r0, address_of_scan_pattern /* r0 ← &scan_pattern */
 ldr r1, address_of_number_read /* r1 ← &number_read */
 bl scanf /* call to scanf */

 ldr r1, address_of_number_read /* r1 ← &number_read */
 ldr r1, [r1] /* r1 ← *r1 */


/*Test user input and branch to a problem function*/
 cmp r1, #1
 beq firstl
 cmp r1, #2
 beq secl
 cmp r1, #3
 beq thirl
cmp r1, #4
 beq four1
bal loop

/*this is branched to and then branches problem1 function*/
firstl:
bl problem1
bal loop

/*this is branched to and then branches problem2 function*/
secl:
 bl problem2
 bal loop

/*this is branched to and then branches problem3 function*/
thirl:
 bl problem3
 bal loop

/*this is branched to and then branches problem4 function*/
four1:
 bl problem4
 bal loop

/*This function restores registers and branches to the return address*/
 
loop:
 ldr lr, address_of_return /* lr ← &address_of_return */
 ldr lr, [lr] /* lr ← *lr */
 bx lr /* return from main using lr */
address_of_message1 : .word message1
address_of_scan_pattern : .word scan_pattern
address_of_number_read : .word number_read
address_of_return : .word return
/* External */
.global printf
.global scanf
