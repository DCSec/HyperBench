
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

//
void platform_shutdown();

// Bootstrap processor starts running C code here.
int main(void *mb_info, int magic)
{
#ifdef __BARE_METAL
    printf("magic = %x, mb_info = %p\n", magic, mb_info);
#endif
    early_mem_init((uintptr_t)&_HEAP_START, mb_info);
    mask_pic_interrupts();
    enable_apic();
    mpinit();        // detect other processors
    startothers();   // start Application Processors
    enable_x2apic();
    harness_main();  // run benchmarks
//    printf("sizeof(void *) = %d\r\n", (int)sizeof(void *));
#ifdef __BARE_METAL
    while(1);        //hold the physical machine, or it will restart infinitely
#else
    platform_shutdown();
#endif
}


// Other CPUs jump here from cstart.S.
//static void mpenter(void)
void mpenter(void)
{
  printf("cpu%d: starting %d\r\n", cpuid(), cpuid());
  lidt(boot_idt, sizeof(boot_idt)-1);
  enable_apic();
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
  enable_x2apic(); // This funciton must behind xchg(&(mycpu()->started), 1), why?
//  asm volatile("sti");
//  asm volatile("nop");
}

/*
  Start the non-boot (AP) processors.
*/
static void startothers(void)
{
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
   
          lapicstartap(c->apicid, 0x00);
          // wait for cpu to finish mpenter()
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

void platform_shutdown()
{
        asm volatile ("mov $0x80000b80, %eax");
        asm volatile ("movw $0xcf8, %dx");
        asm volatile ("outl %eax, %dx");
        asm volatile ("movw $0xcfc, %dx");
        asm volatile ("inb %dx, %al");
        asm volatile ("orb $1, %al");
        asm volatile ("outb %al, %dx");
    
        asm volatile ("movl $0x80000b40, %eax");
        asm volatile ("movw $0xcf8, %dx");
        asm volatile ("outl  %eax, %dx");
        asm volatile ("movl $0x7001, %eax");
        asm volatile ("movw $0xcfc, %dx");
        asm volatile ("outl  %eax, %dx");
        asm volatile ("movw $0x2000, %ax");
        asm volatile ("movw $0x7004, %dx");
        asm volatile ("outw  %ax, %dx");
}

