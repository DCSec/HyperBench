
#include "types.h"
#include "defs.h"
#include "param.h"
#include "mmu.h"
#include "proc.h"
#include "processor.h"

// An address symbol in kernel.ld
extern char _HEAP_START; 

static void startothers(void);
//static void mpmain(void)  __attribute__((noreturn));
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
    harness_main();
    printf("sizeof(void *) = %d\n", (int)sizeof(void *));
//    while(1);        //hold the console, or it will restart infinitely
//    return 0;
}


// Other CPUs jump here from entryother.S.
//static void mpenter(void)
void mpenter(void)
{
  //switchkvm();
  //seginit();
  //lapicinit();
  //mpmain();
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
  printf("AP ");
}


// Start the non-boot (AP) processors.
static void startothers(void)
{
/*
CFLAG += -b binary entryother
When create *_start, *_end and _size symbols, corresponded to the binary data, the linker produces the prefix from its command-line argument as it is.

That is, the linker uses:

    a prefix _binary_entryother_ for argument entryother and
    a prefix _binary_img_entryother_ for argument img/entryother.
*/

//    extern uchar _binary_entryother_start[], _binary_entryother_size[];
//    uchar *code;
    struct cpu *c; 
    char *stack;
/*
    The BSP should place the BIOS AP initialization code at 000VV000H, 
    where VV is the vector contained in the SIPI message. 
    Write entry code to unused memory at 0x0000.
*/
    sipi_entry_mov();

    for(c = cpus; c < cpus+ncpu; c++){
      if(c == mycpu())  // We've started already.
          continue;
   
          lapicstartap(c->apicid, (void *)0x00);
          // wait for cpu to finish mpmain()
          while(c->started == 0);
     }

}

/*
  List the apic id of each processors.
*/
static void list_apicid(void)
{
    int i;
    printf("The number of processors : %d\n", ncpu);
    for(i = 0; i < ncpu; i++){
        printf("%5d ",cpus[i].apicid);
    }
    printf("\n");
}

void DEBUG()
{
    printf("move done!\n");
}

