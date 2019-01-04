#include "benchmark.h"

int i;

static void init()
{
    /*  
    */
//    printf("install page\n");
//    uintptr_t *cr3 = heap_alloc_page();
//    install_pages(cr3, 0, (1ul << 32), (void *)0);
//    printf("install page\n");
}

static inline void ALIGN kernel()
{
    for(i = 0; i < IDLE; i++){
          uintptr_t *cr3 = heap_alloc_page();
          install_pages(cr3, 0, (1ul << 32), (void *)0); 
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


