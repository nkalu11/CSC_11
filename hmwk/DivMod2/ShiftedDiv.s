.global _start

_start:
      mov r0, #0
mov r1, #1
mov r2, #45
mov r3, #3
ldr r4, [r3]

check:
cmp r2, r3
blt end
lsl r3, 1
lsl r1, 1
cmp r2, r3
blt sub
bl check

sub:
lsr r3, 1
lsr r1, 1
sub r2, r2, r3
add r0, r0, r1
ldr r3, [r4]
mov r1, #1
bl check

end:
mov r7, #1
SWI 0
