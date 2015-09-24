.global _start

_start:

    mov r3, #6 @wd4 
    mov r2, #6 @wd4 
    ldr r1, =0x3243f6 @wd24 bp-24
    mul r0, r2, r3
    mul r0, r1
    lsr r0, #20  @shift 20 places right

    mov r7, #1
    swi 0
