.PHONY: all clean

all: build

build:
	dub build

test: build
	./test.sh

clean:
	dub clean
	$(RM) 9cc tmp*
