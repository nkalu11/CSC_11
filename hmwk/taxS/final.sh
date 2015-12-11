gcc -c menu.s
gcc -c prob1.s
gcc -c prob2.s
gcc -c prob3.s
gcc -c prob4.s
gcc -o combine menu.o prob1.o prob2.o prob3.o prob4.o
./combine
