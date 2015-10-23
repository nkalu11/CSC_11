
gcc -c fhalf.s
gcc -c shalf.s
gcc -o comb1 fhalf.o shalf.o
./comb1
