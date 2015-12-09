.data
/* First message */
.balign 4
message111: .asciz "Input an upper limit greater than 4 but not greater than 2209 for prime numbers. "
/* Second message */
.balign 4
message2: .asciz "Prime #%d: %d\n"
/* Second message */
.balign 4
message3: .asciz "%d\n"
/* Format pattern for scanf */
.balign 4
scan_pattern : .asciz "%d"
/* Where scanf will store the number read */
.balign 4
number_read: .word 0
.balign 4
return: .word 0
.balign 4
array: .word 0
.text
.global primeF


primeF:

 PUSH { r4, r5, r6, r7, r8, r9}
 ldr r1, address_of_return /* r1 ← &address_of_return */
 str lr, [r1] /* *r1 ← lr */

 ldr r0, address_of_message111 /* r0 ← &message1 */
 bl printf /* call to printf */
 
  
 ldr r0, address_of_scan_pattern /* r0 ← &scan_pattern */
 ldr r1, address_of_number_read /* r1 ← &number_read */
 bl scanf /* call to scanf */
  
  /*test to see if input is less than 4 and branch to end if it is*/
  ldr r1, address_of_number_read  
  ldr r1, [r1]
  cmp r1, #4
  blt end
 
/*prepare registers for array*/
  mov r8, #0
  mov r9, #4
  mov r7, #0
  mov r6, #0
  mov r5, #0 
  mov r1, #0
/*prepare stack for array*/
  ldr r5, address_of_number_read
  ldr r5, [r5]
  add r1, r1, r5 
  sub r1, r1, #2
  mov r6, #4
  mul r1, r1, r6 
  mov fp, sp            /* fp ← sp. Keep dynamic link in fp */
  sub sp, sp, r1        /* Enlarge the stack by 4*number of indices bytes */
  /*store 2 and three in indice 1 and 2 as the first two prime number*/
  mov r0, #2
  str r0, [sp]
  add sp, sp, #4
  mov r0, #3
  str r0, [sp]
  add sp, sp, #4
  mov r0, #0
  mov r1, #0
/*loop through until reach the upper bounds of prime numbers*/
/*compare each number from 4-n with prime numbers up to 47*/
/*Because it test multiples of prime numbers 2-47, the highest upper bound is 2209 (47^2)*/
/* they are not prime if their mod with these numbers is 0*/
/*how ever a number mod itself is 0 so r3 is used to make sure that*/
/*if a mod is returned as zero that is was the result of more than one subrtaction*/
/*prime numbers are saved as their value and non-prime numbers are saved as zero*/
 
  loop:
  cmp r9, r5
  moveq sp, fp
  beq stop

  /*test on 2*/
  mov r3, #0
  mov r1, #0
  add r1, r1, r9
  mov r2, #2
  mov r7, #0 
   _subtract:
      cmp r1, r2  @ check to see if r1>r2
      blt end2    @if not end
      add r3, r3, #1
      add r7, r7, #1  @else increment
      sub r1, r1, r2  @subract r2 from r1
      bl _subtract    @ branch back to beggining of loop

 end2:
 cmp r1, #0
 bne s3
 cmp r3, #1
 bgt zero
 /*test on 3*/
  s3:
  mov r3, #0
  mov r1, #0
  add r1, r1, r9
  mov r2, #3
  mov r7, #0
 _subtract3:
      cmp r1, r2  @ check to see if r1>r2
      blt end3    @if not end
      add r3, r3, #1
      add r7, r7, #1  @else increment
      sub r1, r1, r2  @subract r2 from r1
      bl _subtract3    @ branch back to beggining of loop
end3:
  cmp r1, #0
bne s4
 cmp r3, #1
 bgt zero
/*test on 7*/
s4:

  mov r3, #0
  mov r1, #0
  add r1, r1, r9
  mov r2, #7
  mov r7, #0
 _subtract4:
      cmp r1, r2  @ check to see if r1>r2
      blt end4    @if not end
      add r3, r3, #1
      add r7, r7, #1  @else increment
      sub r1, r1, r2  @subract r2 from r1
      bl _subtract4    @ branch back to beggining of loop
end4:
 cmp r1, #0
bne s5
 cmp r3, #1
 bgt zero
/*test on 5*/
s5:
  mov r1, #0
  add r1, r1, r9
  mov r2, #5
  mov r7, #0
 _subtract5:
      cmp r1, r2  @ check to see if r1>r2
      blt end5    @if not end
      add r3, r3, #1
      add r7, r7, #1  @else increment
      sub r1, r1, r2  @subract r2 from r1
      bl _subtract5    @ branch back to beggining of loop
end5:
 cmp r1, #0
 bne s6
 cmp r3, #1
 bgt zero
/*test on 13*/
s6:
 mov r3, #0
 mov r1, #0
  add r1, r1, r9
  mov r2, #13
  mov r7, #0
 _subtract6:
      cmp r1, r2  @ check to see if r1>r2
      blt end6    @if not end
      add r3, r3, #1
      add r7, r7, #1  @else increment
      sub r1, r1, r2  @subract r2 from r1
      bl _subtract6    @ branch back to beggining of loop
end6:
  cmp r1, #0
 bne s7
 cmp r3, #1
 bgt zero
/*test on 17*/
s7:
 mov r3, #0
 mov r1, #0
  add r1, r1, r9
  mov r2, #17
  mov r7, #0
 _subtract7:
      cmp r1, r2  @ check to see if r1>r2
      blt end7    @if not end
      add r3, r3, #1
      add r7, r7, #1  @else increment
      sub r1, r1, r2  @subract r2 from r1
      bl _subtract7    @ branch back to beggining of loop
end7:
  cmp r1, #0
 bne s15
 cmp r3, #1
 bgt zero
/*test on 19*/
s15:
 mov r3, #0
 mov r1, #0
  add r1, r1, r9
  mov r2, #19
  mov r7, #0
 _subtract15:
      cmp r1, r2  @ check to see if r1>r2
      blt end15    @if not end
      add r3, r3, #1
      add r7, r7, #1  @else increment
      sub r1, r1, r2  @subract r2 from r1
      bl _subtract15    @ branch back to beggining of loop
end15:
  cmp r1, #0
 bne s8
 cmp r3, #1
 bgt zero
/*test on 23*/
s8:
 mov r3, #0
 mov r1, #0
  add r1, r1, r9
  mov r2, #23
  mov r7, #0
 _subtract8:
      cmp r1, r2  @ check to see if r1>r2
      blt end8    @if not end
      add r3, r3, #1
      add r7, r7, #1  @else increment
      sub r1, r1, r2  @subract r2 from r1
      bl _subtract8    @ branch back to beggining of loop
end8:
  cmp r1, #0
 bne s9
 cmp r3, #1
 bgt zero
/*test on 29*/
s9:
 mov r3, #0


 mov r1, #0
  add r1, r1, r9
  mov r2, #29
  mov r7, #0
 _subtract9:
      cmp r1, r2  @ check to see if r1>r2
      blt end9    @if not end
      add r3, r3, #1
      add r7, r7, #1  @else increment
      sub r1, r1, r2  @subract r2 from r1
      bl _subtract9    @ branch back to beggining of loop
end9:
  cmp r1, #0
 bne s10
 cmp r3, #1
 bgt zero
/*test on 31*/
s10:
 mov r3, #0
 mov r1, #0
  add r1, r1, r9
  mov r2, #31
  mov r7, #0
 _subtract10:
      cmp r1, r2  @ check to see if r1>r2
      blt end10    @if not end
      add r3, r3, #1
      add r7, r7, #1  @else increment
      sub r1, r1, r2  @subract r2 from r1
      bl _subtract10    @ branch back to beggining of loop
end10:
  cmp r1, #0
 bne s11
 cmp r3, #1
 bgt zero
/*test on 37*/
s11:
 mov r3, #0

 mov r1, #0
  add r1, r1, r9
  mov r2, #37
  mov r7, #0
 _subtract11:
      cmp r1, r2  @ check to see if r1>r2
      blt end11    @if not end
      add r3, r3, #1
      add r7, r7, #1  @else increment
      sub r1, r1, r2  @subract r2 from r1
      bl _subtract11    @ branch back to beggining of loop
end11:
 cmp r1, #0
 bne s12
 cmp r3, #1
 bgt zero
/*test on 41*/
s12:
 mov r3, #0


 mov r1, #0
  add r1, r1, r9
  mov r2, #41
  mov r7, #0
 _subtract12:
      cmp r1, r2  @ check to see if r1>r2
      blt end12    @if not end
      add r3, r3, #1
      add r7, r7, #1  @else increment
      sub r1, r1, r2  @subract r2 from r1
      bl _subtract12    @ branch back to beggining of loop
end12:
  cmp r1, #0
 bne s13
 cmp r3, #1
 bgt zero
/*test on 43*/
s13:
 mov r3, #0

 mov r1, #0
  add r1, r1, r9
  mov r2, #43
  mov r7, #0
 _subtract13:
      cmp r1, r2  @ check to see if r1>r2
      blt end13    @if not end
      add r3, r3, #1
      add r7, r7, #1  @else increment
      sub r1, r1, r2  @subract r2 from r1
      bl _subtract13    @ branch back to beggining of loop
end13:
cmp r1, #0
 bne s16
 cmp r3, #1
 bgt zero
/*test on 11*/
s16:
 mov r3, #0


 mov r1, #0
  add r1, r1, r9
  mov r2, #11
  mov r7, #0
 _subtract16:
      cmp r1, r2  @ check to see if r1>r2
      blt end16    @if not end
      add r3, r3, #1
      add r7, r7, #1  @else increment
      sub r1, r1, r2  @subract r2 from r1
      bl _subtract16    @ branch back to beggining of loop
end16:
  cmp r1, #0
 bne s14
 cmp r3, #1
 bgt zero
/*test on 47*/
s14:
 mov r3, #0

 mov r1, #0
  add r1, r1, r9
  mov r2, #47
  mov r7, #0
 _subtract14:
      cmp r1, r2  @ check to see if r1>r2
      blt end14    @if not end
      add r3, r3, #1
      add r7, r7, #1  @else increment
      sub r1, r1, r2  @subract r2 from r1
      bl _subtract14    @ branch back to beggining of loop
end14:
  cmp r1, #0
 bne prime
 cmp r3, #1
 bgt zero
/*save a numbers value that is prime*/
prime:
  mov r2, #0
  add r2, r2, r9
  str r2, [sp]
  add sp, sp, #4
  add r9, r9, #1
  bal loop            /* sp ← fp. Restore dynamic link in fp */
/*save a non-prime number as zero*/
zero:
mov r2, #0
str r2, [sp]
  add sp, sp, #4
  add r9, r9, #1
bal loop



   /*prepare registers for print function after the array is complete*/
 stop:
 mov r7, #0
 mov r1, #0
 mov r4, #0
 ldr r2, address_of_number_read 
 ldr r2, [r2]
 sub r2, r2, #2
 mov r6, #4
 add r7, r7, r2

 mov r9, #0
 mul r2, r2, r6
 mov fp, sp            /* fp ← sp. Keep dynamic link in fp */
 sub sp, sp, r2        /* Enlarge the stack by 8 bytes */
  /*loop through array and print all non-zero values (these are the prime values from earlier*/
   loop2:
  cmp r9, r7
  moveq sp, fp
  beq end
  
  ldr r2, [sp]
  cmp r2, #0
  bne print3
  add sp, sp, #4
  add r9, r9, #1
  bal loop2      
/*after registers are prepared the print comenses*/
print3:
  add r4, r4, #1
  add r1, r4, #0
  ldr r0, address_of_message2
  bl printf
  add sp, sp, #4
  add r9, r9, #1
bal loop2
/*restore registers and leave subroutine*/
end:
 POP { r4, r5, r6, r7, r8, r9}
 ldr lr, address_of_return /* lr ← &address_of_return */
 ldr lr, [lr] /* lr ← *lr */
 bx lr /* return from main using lr */
//lables for all variables
address_of_message111 : .word message111
address_of_message2 : .word message2
address_of_message3 : .word message3
address_of_scan_pattern : .word scan_pattern
address_of_number_read : .word number_read
address_of_return : .word return
addra: .word array
/* External */
.global printf
.global scanf
