.PHONY: all clean

all: build

build:
	dub build

test: build
	./test.sh

clean:
	$(RM) 9cc tmp*
