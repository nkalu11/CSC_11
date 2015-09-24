.global _start

_start:

    ldr  r2, =0x7166 @wd16 bp-8
    ldr r1, =0x517d @wd16 bp-16
    mul r0, r1, r2
    lsr r0, #24  @shift 24 places right

    mov r7, #1
    swi 0
