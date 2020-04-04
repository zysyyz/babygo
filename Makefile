# Run this on Linux

all: a.out

a.s: main.go t/a.go
	go run main.go > a.s

a.o: a.s runtime.s
	as -o a.o a.s runtime.s

a.out: a.o
	ld -o a.out a.o

test: a.out
	./test.sh

# to learn Go's assembly
sample/sample.s: sample/sample.go
	go tool compile -N -S sample/sample.go > sample/sample.s

t/a: t/a.go
	go build -o t/a t/a.go

t/expected.2: t/a
	t/a 2> t/expected.2 || echo ok

expect:
	make t/expected.2

clean:
	rm -f a.s a.o a.out

