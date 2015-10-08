.global _start
_start:

mov r0, #0; @initialize r0
mov r1, #1; @initialize r1
mov r3, #55;@store 55 in r3

_while:
cmp r0, r3 @test to see if r1 is less than r3
beq end    @go to end
add r0, r0, r1@add value in register 1 to register 0
add r1, r1, #1@ iterate register 1
bal _while @go back to top


end:      @output function
mov r7, #1 
SWI 0
