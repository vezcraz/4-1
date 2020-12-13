float.out: driver.c stringToFloat.o
	gcc driver.c stringToFloat.o -o float.out

stringToFloat.o: stringToFloat.c stringToFloat.h
	gcc -c stringToFloat.c -o stringToFloat.o

clean:
	rm -f *.o *.out
