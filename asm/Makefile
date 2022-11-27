LIBS = asmlib_ng/io.o asmlib_ng/str.o asmlib_ng/array.o asmlib_ng/time.o asmlib_ng/rand.o asmlib_ng/math.o
.PHONY: default compile build run debug
default: build run
compile: asmlib_ng/io.s
	as asmlib_ng/io.s -o asmlib_ng/io.o
	as asmlib_ng/str.s -o asmlib_ng/str.o
	as asmlib_ng/array.s -o asmlib_ng/array.o
	as asmlib_ng/time.s -o asmlib_ng/time.o
	as asmlib_ng/rand.s -o asmlib_ng/rand.o
	as asmlib_ng/math.s -o asmlib_ng/math.o
build: main.s
	as main.s -o main.o
	ld main.o $(LIBS) -o main
run: main
	./main $(ARGS)
debug: main.s
	as --gstabs -o main.o main.s
	ld main.o $(LIBS) -o main
	gdb main
