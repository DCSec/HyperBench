#include "benchmark.h"

int i;

static void init()
{
    /*  
    */
}

static inline void ALIGN kernel()
{
/*
    for(i = 0; i < IDLE; i++){
    
    } 
*/
    setup_mmu(1ul << 31);  
}

static inline void control()
{
/*
    for(i = 0; i < IDLE; i++){
        
    }
*/   
}

static void cleanup()
{
    switch_to_start_cr3();
    early_mem_init();
}

DEFINE_BENCHMARK(memory_pt) =
{
    .name = "set-pt",
    .category = "memory",
    .init = init,
    .benchmark = kernel,
    .benchmark_control = control,
    .cleanup = cleanup,
    .iteration_count = 1
};


