.global _start

_start: 

       mov r1,#48
       ldr r2, #4
       mul r0, r1, r2
       lsr r0, #4
       
       mov r7, #1
       swi 0
