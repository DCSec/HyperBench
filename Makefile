BASEDIR	:= $(shell pwd)
ARCH    := $(shell uname -m)
HYPERBENCH_DIRS         := $(ARCH) lib benchmark

HYPERBENCH64 := hyperbench.64
HYPERBENCH32 := hyperbench.32


CC = gcc
AS = gas
LD = ld
AR = ar

OBJS += \
	lib/printf.o\
	lib/string.o\
	lib/stack.o\
	lib/abort.o

include $(ARCH)/Makefile

autodepend-flags = -MMD -MF $(dir $*).$(notdir $*).d

#CFLAGS = -fno-builtin -fno-pic -static -fno-strict-aliasing -O0 -Wall -MD -ggdb -m64 -Werror -fno-omit-frame-pointer -I $(BASEDIR)/include -nostdlib

CFLAGS += -mno-red-zone -mno-sse -mno-sse2
CFLAGS += -m64 
CFLAGS += -O0
# auto depend flags 
CFLAGS += -g $(autodepend-flags)
#CFLAGS += -Wall -Wwrite-strings -Wclobbered -Wempty-body -Wuninitialized
#CFLAGS += -Wignored-qualifiers -Wunused-but-set-parameter
#CFLAGS += -Wmissing-prototypes -Wstrict-prototypes
CFLAGS += -Werror
CFLAGS += -fno-omit-frame-pointer
CFLAGS += -Wno-frame-address
CFLAGS += -fno-pic
CFLAGS += -fno-builtin
CFLAGS += -static
CFLAGS += -nostdlib
CFLAGS += -std=gnu99
CFLAGS += -I $(BASEDIR)/include


ASFLAGS = -m64 -I $(BASEDIR)/include

kernel: $(OBJS) $(ARCH)/cstart.o
	$(LD) $(LDFLAGS) -T $(ARCH)/kernel.ld -o hyperbench.64 $(ARCH)/cstart.o $(OBJS)
	objcopy --input-target=elf64-x86-64 --output-target=elf32-i386 $(HYPERBENCH64) $(HYPERBENCH32)


clean:
	rm -f $(ARCH)/*.o $(ARCH)/.*.d lib/*.o lib/.*.d hyperbench.*


