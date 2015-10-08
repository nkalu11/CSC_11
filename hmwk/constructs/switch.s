.global _start

_start:
       mov r1, #3 @set r1 to day of week
       
       switch:
       cmp r1, #1 @test to see if r1 is  #1
       beq end11  @if so output 11
     
       cmp r1, #3 @test to see if r1 is #3
       beq end11  @if so output 11
    
       cmp r1, #2 @ test to see if r1 is #2
       beq end5   @if so output 5
 
       cmp r1, #4 @test to see if r1 is #4
       beq end5   @if so output #5

       bal end1   @default to 1

    end11:     @output 11
    mov r0, #11
    mov r7, #1
    SWI 0

    end5:     @output 5
    mov r0, #5
    mov r7, #1
    SWI 0

    end1:     @output 1
    mov r0, #1
    mov r7, #1
    SWI 0

