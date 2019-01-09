#include "benchmark.h"
#include "processor.h"

#define ITERATION HOT_ACCESS

int i;
uintptr_t address = 0x100000;

static void init()
{
    /*
    */

//    write_cr0(0x80000011);
//    printf("cr0 = %lx\ncr4 = %lx\n", read_cr0(), read_cr4());
//    setup_pt();
    setup_mmu(1ul << 32);

    address = 0x100000;
    for(i = 0; i < ITERATION; i++){
        (*(volatile uint8_t *)(address));
        address += 0x1000;
        //address += 4;
        address = address % (1 << 30);
    }


}

static inline void ALIGN kernel()
{
    address = 0x100000;
    for(i = 0; i < ITERATION; i++){
        (*(volatile uint8_t *)(address));
	address += 0x1000;
        //address += 4;
        address = address % (1 << 30);
    }
}

static inline void control()
{
    address = 0;
    for(i = 0; i < ITERATION; i++){
        //(*(volatile uint8_t *)(address));
        asm volatile (" ");
        address += 0x1000;
        //address += 4;
        address = address % (1 << 30);
    }
}

static void cleanup()
{
    switch_to_start_cr3();
//    write_cr0(0xC0000011);
}

DEFINE_BENCHMARK(memory_hot) = 
{
    .name = "hot-access",
    .category = "memory",
    .init = init,
    .benchmark = kernel,
    .benchmark_control = control,
    .cleanup = cleanup,
    .iteration_count = ITERATION
};


