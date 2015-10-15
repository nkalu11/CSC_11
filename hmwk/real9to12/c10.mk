#Makefile
all: c10
 
c10: c10.o
	gcc -o $@ $+
 
c10.o : c10.s
	as -o $@ $<

clean:
	rm -vf *.o













