echo" Script from chapter 10 will run now"
as -o c10.o c10.s
ld -o c10 c10.o
./c10; echo $?
