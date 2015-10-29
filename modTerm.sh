gcc -c menu.s
gcc -c problem1.s
gcc -c problem2.s
gcc -c problem3.s
gcc -o combine menu.o problem1.o problem2.o problem3.o
./combine
