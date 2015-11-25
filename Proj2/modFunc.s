.data
/* return*/
.balign 4
return: .word 0
.text
.global modFunc


       /*initialization of registers and storing of high registers*/
       modFunc:
       PUSH {r5, r6, r9, lr}
       mov r5, #0
       /*loop to subtract r2 from r1 until r1<r2*/
       _subtract:
      cmp r1, r2  @ check to see if r1>r2
      blt end    @if not end
      add r5, r5, #1  @else increment
      sub r1, r1, r2  @subract r2 from r1
      bl _subtract    @ branch back to beggining of loop

        end: @print results
        POP {r5, r6, r9, lr}
        bx lr /* return from main using lr */
/*variable labels*/     
address_of_return : .word return
/* External */
.global printf
.global scanf
