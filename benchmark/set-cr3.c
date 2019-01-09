#include "benchmark.h"
#include "ioram.h"
#include "processor.h"

#define ITERATION SET_CR3

int i;

unsigned long cr3;

static void init()
{
    /*
    */
    setup_mmu(1ul << 32);
    cr3 = read_cr3();
}

static inline void ALIGN kernel()
{
    for(i = 0; i < ITERATION; i++){
        asm volatile ("mov %0, %%cr3" : : "r"(cr3) : "memory");
    }
}

static inline void control()
{
    for(i = 0; i < ITERATION; i++){
        asm volatile(" ");
    }
}

static void cleanup()
{
    switch_to_start_cr3();
}

DEFINE_BENCHMARK(set_cr3) = 
{
    .name = "set-cr3",
    .category = "privileged",
    .init = init,
    .benchmark = kernel,
    .benchmark_control = control,
    .cleanup = cleanup,
    .iteration_count = ITERATION
};

