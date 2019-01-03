BASEDIR	:= $(shell pwd)
ARCH    := $(shell uname -m)
OUT	:= $(BASEDIR)/out
HYPERBENCH_DIRS         := $(ARCH) lib benchmark

HYPERBENCH64 := hyperbench.64
HYPERBENCH32 := hyperbench.32
HOST	:= host/host

CC = gcc
AS = gas
LD = ld
AR = ar
OBJDUMP = objdump
OBJCOPY = objcopy

OBJS += \
	lib/printf.o\
	lib/string.o\
	lib/stack.o\
	lib/abort.o

include $(ARCH)/Makefile
include benchmark/Makefile
include harness/Makefile

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
#CFLAGS += -Wno-frame-address
CFLAGS += -fno-pic
CFLAGS += -fno-builtin
CFLAGS += -static
CFLAGS += -nostdlib
#CFLAGS += -std=gnu99
CFLAGS += -I $(BASEDIR)/include


ASFLAGS = -m64 -I $(BASEDIR)/include

#kernel: $(OBJS) $(ARCH)/cstart.o entryother
kernel: $(OBJS) $(ARCH)/cstart.o $(HOST)
	mkdir $(OUT)
#	$(LD) $(LDFLAGS) -T $(ARCH)/kernel.ld -o hyperbench.64 $(ARCH)/cstart.o $(OBJS) -b binary entryother
	$(LD) $(LDFLAGS) -T $(ARCH)/kernel.ld -o $(OUT)/hyperbench.64 $(ARCH)/cstart.o $(OBJS)
	objcopy --input-target=elf64-x86-64 --output-target=elf32-i386 $(OUT)/$(HYPERBENCH64) $(OUT)/$(HYPERBENCH32)
	$(OBJDUMP) -S $(OUT)/$(HYPERBENCH32) > $(OUT)/hyperbench32.asm
	$(OBJDUMP) -t $(OUT)/$(HYPERBENCH32) | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $(OUT)/hyperbench32.sym

$(HOST): 
	make -C host

clean:
	rm -f $(ARCH)/*.o $(ARCH)/.*.d lib/*.o lib/.*.d
	rm -f harness/*.o harness/.*.d
	rm -f benchmark/*.o benchmark/.*.d
	rm -rf $(OUT)
	make -C host/ clean

