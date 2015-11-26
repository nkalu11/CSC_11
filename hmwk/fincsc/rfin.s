/* -- randTest.s */
.data
/* First message */
.balign 4
message1: .asciz "I have a number between 1 and 1000\n\nCan you guess my number? You will be\n\ngiven a maximum of 10 guesses.\n\nPlease type your first guess. %d: "
/* Second message */
.balign 4
message2: .asciz "\nI read the number %d\n"
/* Format pattern for scanf */
/* Second message */
.balign 4
message5: .asciz "Too many tries \n"
/* Second message */
.balign 4
message4: .asciz "Congratulations, You guessed the number!\n Would you like to play again(y or n) \n"
/* Second message */
.balign 4
message3: .asciz "Too High. Try again.\n"
/* Second message */
.balign 4
message22: .asciz "Too Low. Try again.\n"
.balign 4
scan_pattern: .asciz "%d"
.balign 4
scan_pattern2: .asciz "%c"
/* Where scanf will store the number read */
.balign 4
number_read2: .word 0
/* Where scanf will store the number read */
.balign 4
number_read: .word 0
.balign 4
return: .word 0

messaget: .asciz "The random function returned %d\n"
 
.text
/*void scaleRight(int &r1,int &r3,int &r2) */
scaleRight:
	push {lr}             /* Push lr onto the stack */
	doWhile_r1_lt_r2:     /* Shift right until just under the remainder */
		mov r3,r3,ASR #1; /* Division counter */
		mov r2,r2,ASR #1  /* Mod/Remainder subtraction */
	cmp r1,r2
	blt doWhile_r1_lt_r2
	pop {lr}              /* Pop lr from the stack */
    bx lr                 /* Leave scaleRight */
/* end scaleRight */

/* void addSub(int &r3,int &r2,int &r0,int &r1) */
addSub:
	push {lr}       /* Push lr onto the stack */
	doWhile_r3_ge_1:
		add r0,r0,r3
		sub r1,r1,r2
		bl scaleRight
	cmp r3,#1
	bge doWhile_r3_ge_1
    pop {lr}       /* Pop lr from the stack */
    bx lr          /* Leave addSub */
/* end addSub */

/* void scaleLeft(int &r1,int &r3,int &r2) */
scaleLeft:
	push {lr}             /* Push lr onto the stack */
	doWhile_r1_ge_r2:     /* Scale left till overshoot with remainder */
		mov r3,r3,LSL #1  /* scale factor */
		mov r2,r2,LSL #1  /* subtraction factor */
		cmp r1,r2
	bge doWhile_r1_ge_r2  /* End loop at overshoot */
	mov r3,r3,ASR #1      /* Scale factor back */
	mov r2,r2,ASR #1      /* Scale subtraction factor back */
	pop {lr}              /* Pop lr from the stack */
    bx lr                 /* Leave addSub */
/* end scaleLeft */

/* void divMod(int &r2,int &r0,int &r1) */
divMod:
	push {lr}       /* Push lr onto the stack */
	/* Determine the quotient and remainder */
	mov r0,#0
	mov r3,#1
	cmp r1,r2
	blt enda
		bl scaleLeft
		bl addSub
	enda:
	pop {lr}       /* Pop lr from the stack */
    bx lr          /* Leave addSub */
/* end divMod */
ranf:
    push {r4,lr}                 /* Push lr onto the top of the stack */

	mov r0,#0                    /* Set time(0) */
    bl time                      /* Call time */
	bl srand                     /* Call srand */
	
	mov r4,#0                    /* Setup loop counter */
	
  loop_rand:                     /* Create a 2 digit random number */
	bl rand                      /* Call rand */
	mov r1,r0,ASR #1             /* In case random return is negative */
	mov r2,#90                   /* Move 90 to r2 */
		                         /* We want rand()%90+10 so cal divMod with rand()%90 */
	bl divMod                    /* Call divMod function to get remainder */
	add r1,#10                   /* Remainder in r1 so add 10 giving between 10 and 99 -> 2 digits */
	
	
 
    pop {r4,lr}                     /* Pop the top of the stack and put it in lr */
    bx lr                        /* Leave main */

.global main
main:
 PUSH {r4, r5, r6, r7, r9, lr}
 bloop:
 bl ranf
// ldr r0, address_of_message1 /* r0 ← &message1 */
// bl printf /* call to printf */

 mov r6, #0
 add r6, r6, r1
 mov r7, #0
 mov r7, #10
 
 ldr r0, address_of_message1 /* r0 ← &message1 */
 bl printf /* call to printf */
 loop:
 cmp r7, #0
 beq end1
 ldr r0, address_of_scan_pattern /* r0 ← &scan_pattern */
 ldr r1, address_of_number_read /* r1 ← &number_read */
 bl scanf /* call to scanf */
 ldr r1, address_of_number_read
 ldr r1, [r1]

 cmp r6, r1
 beq tmt
 
 cmp r1, r6
 blt lcont
 
 cmp r1, r6
 bgt gcont
 

 lcont:
 ldr r0, address_of_message22 /* r0 ← &message2 */
 sub r7, r7, #1
 bl printf
 bal loop

 gcont:
 ldr r0, address_of_message3 /* r0 ← &message2 */
 bl printf 
 sub r7, r7, #1
 bal loop
 
 tmt:
 ldr r0, address_of_message4 /* r0 ← &message1 */
 bl printf /* call to printf */
 ldr r0, address_of_scan_pattern2 /* r0 ← &scan_pattern */
 ldr r1, address_of_number_read2 /* r1 ← &number_read */
 bl scanf /* call to scanf */
 ldr r0, address_of_scan_pattern2 /* r0 ← &scan_pattern */
 ldr r1, address_of_number_read2 /* r1 ← &number_read */
 bl scanf /* call to scanf */
 ldr r1, address_of_number_read2
 ldr r1, [r1]
 cmp r1, #0x79
 beq bloop
 bal end

end1:
 ldr r0, address_of_message5
 bl printf
 POP {r4, r5, r6, r7, r9, lr}
 bx lr /* return from main using lr */


end:
 POP {r4, r5, r6, r7, r9, lr}
 bx lr /* return from main using lr */

address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_message22 : .word message22
address_of_message3 : .word message3
address_of_message5 : .word message5
address_of_message4 : .word message4
address_of_scan_pattern : .word scan_pattern
address_of_scan_pattern2 : .word scan_pattern2
address_of_number_read : .word number_read
address_of_number_read2 : .word number_read2
address_of_return : .word return 
address_of_messaget: .word messaget

/*External Functions*/
.global printf
.global time
.global srand
.global rand
.global scanf
