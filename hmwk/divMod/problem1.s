.global _start

_start:

    mov r1, #16 @put #16 in r1 
    mov r2, #3  @put #3 in r2 
    mov r0, #0  @put 0 in r0
   
   _subtract:
    cmp r1, r2 @test to see if r1> r2
    blt _end   @if not end
    add r0, r0, #1 @if so continue
    sub r1, r1, r2 @subtract r2 from r1
    bl _subtract  @branch back to beginning of the function

   _end:
    mov r7, #1
    swi 0

