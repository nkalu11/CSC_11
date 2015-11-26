.data
/* First message */
.balign 4
message1: .asciz "Input size of array : "
/* Second message */
.balign 4
message2: .asciz " %d\n"
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
.global main


 modFunc:
       PUSH {r7, lr}
       mov r7, #0
       /*loop to subtract r2 from r1 until r1<r2*/
       _subtract:
      cmp r1, r2  @ check to see if r1>r2
      blt end2    @if not end
      add r7, r7, #1  @else increment
      sub r1, r1, r2  @subract r2 from r1
      bl _subtract    @ branch back to beggining of loop

        end2: @print results
        POP {r7, lr}
        bx lr /* return from main using lr */



main:

 PUSH { r4, r5, r6, r7, r8, r9}
 ldr r1, address_of_return /* r1 ← &address_of_return */
 str lr, [r1] /* *r1 ← lr */
 ldr r0, address_of_message1 /* r0 ← &message1 */
 bl printf /* call to printf */
 ldr r0, address_of_scan_pattern /* r0 ← &scan_pattern */
 ldr r1, address_of_number_read /* r1 ← &number_read */
 bl scanf /* call to scanf */

  
  mov r8, #0
  mov r9, #4
  mov r7, #0
  mov r6, #0
  mov r5, #0 
  mov r1, #0

  ldr r5, address_of_number_read
  ldr r5, [r5]
  add r1, r1, r5 
 // add r5, r5, #3
  sub r1, r1, #2
  mov r6, #4
  mul r1, r1, r6 
  mov fp, sp            /* fp ← sp. Keep dynamic link in fp */
  sub sp, sp, r1        /* Enlarge the stack by 8 bytes */
  mov r0, #2
  str r0, [sp]
  add sp, sp, #4
  mov r0, #3
  str r0, [sp]
  add sp, sp, #4
  mov r0, #0
  mov r1, #0
   loop:
  cmp r9, r5
  moveq sp, fp
  beq stop
  mov r1, #0
  add r1, r1, r9
  mov r2, #2 
  bl modFunc
 
 cmp r1, #0
 beq zero
 
  mov r1, #0
  add r1, r1, r9
  mov r2, #3
  bl modFunc

 cmp r1, #0
 beq zero

prime:
  mov r2, #0
  add r2, r2, r9
  str r2, [sp]
  add sp, sp, #4
  add r9, r9, #1
  bal loop            /* sp ← fp. Restore dynamic link in fp */
zero:
mov r2, #0
str r2, [sp]
  add sp, sp, #4
  add r9, r9, #1
bal loop



   
  stop:
 mov r7, #0
 ldr r1, address_of_number_read 
 ldr r1, [r1]
 mov r6, #4
 add r7, r7, r1
// sub r7, r7, #1
 mov r9, #0
 mul r1, r1, r6
 mov fp, sp            /* fp ← sp. Keep dynamic link in fp */
 sub sp, sp, r1        /* Enlarge the stack by 8 bytes */
  
   loop2:
  cmp r9, r7
  moveq sp, fp
  beq end
  ldr r1, [sp]
  ldr r0, address_of_message2 
  bl printf

  add sp, sp, #4
  add r9, r9, #1
  bal loop2      


end:
 POP { r4, r5, r6, r7, r8, r9}
 ldr lr, address_of_return /* lr ← &address_of_return */
 ldr lr, [lr] /* lr ← *lr */
 bx lr /* return from main using lr */
//lables for all variables
address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_message3 : .word message3
address_of_scan_pattern : .word scan_pattern
address_of_number_read : .word number_read
address_of_return : .word return
addra: .word array
/* External */
.global printf
.global scanf
