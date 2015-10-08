.global _start


_start:

mov r0, #0;  @initialize r0
mov r1, #1;  @initialize r1
mov r3, #55; @store 55 in r3
 
_forLoop:
cmp r0, r3  @do test
beq end     @leave depending on result
add r0, r0, r1 @ combine r1 and r0
add r1, r1, #1 @increment
bal _forLoop  @go back to top of loop


end:         @print results
mov r7, #1
SWI 0
