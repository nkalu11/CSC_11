gcc -c fhalfR.s
gcc -c shalfR.s
gcc -c lhalfR.s
gcc -o comb fhalfR.o shalfR.o lhalfR.o
./comb
