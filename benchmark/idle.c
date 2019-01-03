#include "benchmark.h"

int i;

static void init()
{
    /*  
    */
}

static inline void ALIGN kernel()
{
    for(i = 0; i < IDLE; i++){
    
    }   
}

static inline void control()
{
    for(i = 0; i < IDLE; i++){
    
    }   
}

static void cleanup()
{

}

DEFINE_BENCHMARK(idle) =
{
    .name = "idle",
    .category = "idle",
    .init = init,
    .benchmark = kernel,
    .benchmark_control = control,
    .cleanup = cleanup,
    .iteration_count = IDLE
};


