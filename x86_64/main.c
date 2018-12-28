
#include "types.h"
#include "defs.h"
#include "param.h"
#include "mmu.h"
#include "proc.h"

// An address symbol in kernel.ld
extern char _HEAP_START; 

static void startothers(void);
static void list_apicid(void);

// Bootstrap processor starts running C code here.
int main(void *mb_info, int magic)
{
    printf("magic = %x, mb_info = %p\n", magic, mb_info);
    early_mem_init((uintptr_t)&_HEAP_START, mb_info);
    mask_pic_interrupts(); //close interrupt
    enable_apic();   // enable local apic
    mpinit();        // detect other processors
    list_apicid();   // list all apic id
    startothers();
    printf("sizeof(void *) = %d\n", (int)sizeof(void *));
    while(1);        //hold the console, or it will restart infinitely
    return 0;
}

// Start the non-boot (AP) processors.
static void startothers(void)
{
/*
When create *_start, *_end and _size symbols, corresponded to the binary data, the linker produces the prefix from its command-line argument as it is.

That is, the linker uses:

    a prefix _binary_entryother_ for argument entryother and
    a prefix _binary_img_entryother_ for argument img/entryother.
*/

    extern uchar _binary_entryother_start[], _binary_entryother_size[];
    uchar *code;
    struct cpu *c; 
    char *stack;
/* 
    Write entry code to unused memory at 0x7000.
    The linker has placed the image of entryother.S in
    _binary_entryother_start.
*/
    code = (void *)((char *)(0x7000));
    memmove(code, _binary_entryother_start, (uint64_t)_binary_entryother_size);    

    for(c = cpus; c < cpus+ncpu; c++){
        if(c == mycpu())  // We've started already.
            continue;
    }

}

static void list_apicid(void)
{
    int i;
    printf("The number of processors : %d\n", ncpu);
    for(i = 0; i < ncpu; i++){
        printf("%5d ",cpus[i].apicid);
    }
    printf("\n");
}

