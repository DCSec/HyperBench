#include "defs.h"
#include "benchmark.h"

#define ITERATION IPI

int i;

static inline void nop(void *junk)
{

}

static inline void ipi(void)
{
    on_cpu(1,nop,0);
}

static void init()
{
    /* */
    smp_init();
    setup_mmu(1ul << 32);
}

static inline void ALIGN kernel()
{
   for(i = 0; i < ITERATION; i++){
        ipi();
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

DEFINE_BENCHMARK(ipi) = 
{
    .name = "ipi",
    .category = "exception",
    .init = init,
    .benchmark = kernel,
    .benchmark_control = control,
    .cleanup = cleanup,
    .iteration_count = ITERATION
};

