export BASEDIR	:= $(shell pwd)
export ARCH	:= $(shell uname -m)


HYPERBENCH64 := hyperbench.64
HYPERBENCH32 := hyperbench.32

OBJS = \
	console.o\
	main.o\

CC = gcc
AS = gas
LD = ld
AR = ar


CFLAGS = -fno-builtin -fno-pic -static -fno-strict-aliasing -O2 -Wall -MD -ggdb -m64 -Werror -fno-omit-frame-pointer -I $(BASEDIR)/include -nostdlib

ASFLAGS = -m64 -I $(BASEDIR)/include

kernel: $(OBJS) cstart.o kernel.ld
	$(LD) $(LDFLAGS) -T kernel.ld -o hyperbench.64 cstart.o $(OBJS)
	objcopy --input-target=elf64-x86-64 --output-target=elf32-i386 $(HYPERBENCH64) $(HYPERBENCH32)


clean:
	rm -f *.o *.d hyperbench.*


