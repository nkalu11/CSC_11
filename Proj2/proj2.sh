gcc -c project2.s
gcc -c divFunc.s
gcc -c modFunc.s
gcc -o comb12 project2.o divFunc.o modFunc.o
./comb12
