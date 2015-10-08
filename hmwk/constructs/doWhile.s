.global _start


_start:

mov r0, #0;@initialize r0
mov r1, #1;@intialize r1
mov r3, #55;@initialize r3

_dowhile:
add r0, r0, r1 @ add r0 to r1
add r1, r1, #1 @increment
cmp r0, r3     @do comparison at end
beq end        @ go to end
bal _dowhile   @ go back to top


end:        @output
mov r7, #1
SWI 0

