gcc -c project2.s
gcc -c divFunc.s
gcc -c modFunc.s
gcc -c square.s
gcc -c avg.s
gcc -c sarray.s
gcc -o comb project2.o divFunc.o modFunc.o square.o avg.o sarray.o
./comb
