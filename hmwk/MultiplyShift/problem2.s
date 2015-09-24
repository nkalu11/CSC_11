.global _start

_start:

    mov r2, #110  @wd8 bp0
    ldr r1, =0x517cc1 @wd6 bp-24
    mul r0, r1, r2
    lsr r0, #24  @shift 24 places right

    mov r7, #1
    swi 0
