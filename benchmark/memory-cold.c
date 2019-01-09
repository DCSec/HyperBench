#include "benchmark.h"
#include "processor.h"

#define ITERATION COLD_ACCESS

int i;
unsigned long ptr = 0;

static void init()
{
    /*
    */
//    write_cr0(0xC0000011);
//    setup_pt();
    setup_mmu(1ul << 33);
}

static inline void ALIGN kernel()
{
//    ptr = 0;
    ptr = 0x4000;
    for(i = 0; i < ITERATION; i++){
        (*(volatile uint8_t *)(ptr * 4096));
	ptr += 1;
        ptr = ptr % (1 << 30);
/*
        if(ptr >= (1<<24)){
            printf("Out of memory");
            while(1);
        }
*/
    }
}

static inline void control()
{
    ptr = 0;
    ptr = 0x4000;
    for(i = 0; i < ITERATION; i++){
        //(*(volatile uint8_t *)(ptr));
        asm volatile (" ");
        ptr += 1;
        ptr = ptr % (1 << 30);
    }
}

static void cleanup()
{
    switch_to_start_cr3();
}

DEFINE_BENCHMARK(memory_cold) = 
{
    .name = "cold-access",
    .category = "memory",
    .init = init,
    .benchmark = kernel,
    .benchmark_control = control,
    .cleanup = cleanup,
    .iteration_count = ITERATION
};


