.global _start

_start:

    ldr r3, =0x68 @wd8 
    ldr r2, =0x68 @wd8 
    ldr r1, =0x3243 @wd16 bp-16
    mul r0, r1, r2
    mul r0, r3
    lsr r0, #20  @shift 20 places right

    mov r7, #1
    swi 0
