.global _start

_start:
    
          mov r6, #15 
          mov r10, #1
          mov r9, r10, lsl #31
          ldr r1, = string
    

  _bits:

          tst r6, r9
          moveq r0, #48
          movne r0, #49
          str r0, [r1] 
          mov r8, r6
          bl _write 
          mov r6, r8 

          mov r9, r9, lsr #1
          bne _bits 


  _exit: 
          mov r7, #1
          SWI 0

  _write:
          mov r0, #1
          mov r2, #1
          mov r7, #4
          SWI 0
          bx lr

  .data
        string:  .ascii "Hi How are ya? "
