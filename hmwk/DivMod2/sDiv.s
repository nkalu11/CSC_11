.global _start

       _start:
        mov r0, #0 @set r0 to 0
        mov r1, #1 @set R1 to #1
        mov r2, #16 @set r2 to 45
        mov r3, #3 @set r3 to 3
        mov r4, #0 @initialize r4
        add r4, r3 @put contents of r3 in r4

        check:
        cmp r2, r3 @compare r3 and r2
        blt end   @ if r3<r2 go to end
        lsl r3, #1 @shift r3 once
        lsl r1, #1 @shift r1 to 1
        cmp r2, r3 @cmpare r3 and r2
        blt sub    @if r2 is less than r3 go to end
        bl check   @else branch to the end

        sub:
        lsr r3, #1 @shift r3 right #1
        lsr r1, #1 @shift r1 right #1
        sub r2, r2, r3 @subtract r3 from r2
        add r0, r0, r1 @add r0 and r1
        mov r3, #0 @set r3 to #3
        add r3, r4 @store contents of r4 in r3
        mov r1, #1 @set r1 to #1
        bl check @go to the chech

        end: @print results
        mov r7, #1 @print result
        SWI 0




