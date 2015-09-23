.global _start

_start: 

       mov r1,#88
       ldr r2,=0x010505
       mul r0, r1, r2
       lsr r0, #2
       
       mov r7, #1
       swi 0
