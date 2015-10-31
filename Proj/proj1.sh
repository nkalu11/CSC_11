gcc -c project1.s
gcc -c divFunc.s
gcc -c modFunc.s
gcc -o comb11 project1.o divFunc.o modFunc.o
./comb11
