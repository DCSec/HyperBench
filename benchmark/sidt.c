#include "benchmark.h"
#include "ioram.h"
#include "processor.h"


#define ITERATION SIDT

int i;

void *mem;
static unsigned long t=0x0000;

static inline void test_sidt()
{
/*
    asm volatile("sidt (%[mem]) \n\t"
                 "mov (%[mem]), %[t]"
                 :[mem]"=r"(mem), [t]"=r"(t)
                 :
                 :"memory");

    printf("%lx", t);
*/

    asm volatile("sidt (%[mem])"
                 :[mem]"=r"(mem)
                 :
                 :"memory");

}

static void init()
{
    /*
    */
    setup_mmu(1ul << 32);
    mem = alloc_vpages(2);

    install_page((void *)read_cr3(), IORAM_BASE_PHYS, mem);
    install_page((void *)read_cr3(), IORAM_BASE_PHYS, mem + 4096);

    //mem = mem + 4096;
}

static inline void ALIGN kernel()
{
    for(i = 0; i < ITERATION; i++){
        test_sidt();
    }
}

static inline void control()
{
    for(i = 0; i < ITERATION; i++){
    
    }
}

static void cleanup()
{
    switch_to_start_cr3();
}

DEFINE_BENCHMARK(sidt) = 
{
    .name = "sidt",
    .category = "critical",
    .init = init,
    .benchmark = kernel,
    .benchmark_control = control,
    .cleanup = cleanup,
    .iteration_count = ITERATION
};

