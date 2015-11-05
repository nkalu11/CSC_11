.data
/* return*/
.balign 4
return: .word 0
.text
.global divideF
  

       /*initialize registers and save value of high registers*/
       divideF:
       PUSH {r5, r6, r9, lr}
   
        mov r5, #1
        mov r4, #0 @initialize r4
        add r4, r2 @store contents of r2 in r4
        mov r6, #0
        /*compare r1 and r2, if r2<r1 prepare r2 for shifted subtraction*/
        check:
        cmp r1, r2 @compare r1 and r2
        blt end   @ if r1<r2 go to end
        lsl r2, #1 @shift r1 once
        lsl r5, #1 @shift r1 to 1
        cmp r1, r2 @cmpare r1 and r2
        blt sub    @if r2 is less than r1 go to end
        bl check   @else branch to the end
        /*if r2>r1 shift it right once then subract it from r1 then go back to check*/
        sub:
        lsr r2, #1 @shift r2 right #1
        lsr r5, #1 @shift r5 right #1
        sub r1, r1, r2 @subtract r1 from r2
        add r6, r6, r5 @add r5 and r6
        mov r2, #0 @set r2 to original value
        add r2, r4 @store contents of r4 in r2
        mov r5, #1 @set r5 to #1
        bl check @go to the chech
       /*restore registers and output results*/
        end: @print results
        add r1, r6, #0
        POP {r5, r6, r9, lr}
        bx lr /* return from main using lr */
/*create varaible labels*/
address_of_return : .word return
/* External */
.global printf
.global scanf

