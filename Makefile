all:
	llc ir.ll -o ir.s
	clang -c runtime.c
	clang -c ir.s
	clang runtime.o ir.o -o main

clean:
	rm -rf *.o *.s main
