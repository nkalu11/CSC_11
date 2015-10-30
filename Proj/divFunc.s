.data
/* return*/
.balign 4
return: .word 0
.text
.global divideF
  

     
       divideF:
       PUSH {r5, r6}
       ldr r3, address_of_return /* r1 ← &address_of_return */
       str lr, [r3] /* *r1 ← lr */
       /* mov r0, #0 @set r0 to 0
        mov r1, #1 @set R1 to #1
        mov r2, #16 @set r2 to 45*/
        mov r5, #1
        mov r3, #3 @set r3 to 3
        mov r4, #0 @initialize r4
        add r4, r2 @put contents of r3 in r4
        mov r6, #0
        check:
        cmp r1, r2 @compare r3 and r2
        blt end   @ if r3<r2 go to end
        lsl r2, #1 @shift r3 once
        lsl r5, #1 @shift r1 to 1
        cmp r1, r2 @cmpare r3 and r2
        blt sub    @if r2 is less than r3 go to end
        bl check   @else branch to the end

        sub:
        lsr r2, #1 @shift r3 right #1
        lsr r5, #1 @shift r1 right #1
        sub r1, r1, r2 @subtract r3 from r2
        add r6, r6, r5 @add r0 and r1
        mov r2, #0 @set r3 to #3
        add r2, r4 @store contents of r4 in r3
        mov r5, #1 @set r1 to #1
        bl check @go to the chech

        end: @print results
        mov r1, r6
        POP {r5, r6}
        ldr lr, address_of_return /* lr ← &address_of_return */
        ldr lr, [lr] /* lr ← *lr */
        bx lr /* return from main using lr */
address_of_return : .word return
/* External */
.global printf
.global scanf

