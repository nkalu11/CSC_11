.global _start

_start:
    
    mov r3, #1
    mov r0, #0
    

   change:
    cmp r0, #100
    beq end
    mov r2, #37  @wd8 bp0
    ldr r1, =0x1ccccc @wd6 bp-24
    mul r0, r1, r2
    lsr r0, #20  @shift 24 places right
    add r0, #32
    mov r0, #0
    add r3, #1
    add r0, r3
    bal change

 end:
  mov r7, #1
  SWI 0

