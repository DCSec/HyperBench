#include "benchmark.h"
#include "io.h"

#define ITERATION IN_SERIAL_PORT

int i;
char c;

static void init()
{
    /*
    */
}

static inline void ALIGN kernel()
{
    for(i = 0; i < ITERATION; i++){
//        inb(0x3f8 + 0x05);
        inb(0x3f8 + 0x03);
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

}

DEFINE_BENCHMARK(in) = 
{
    .name = "in-serial",
    .category = "io",
    .init = init,
    .benchmark = kernel,
    .benchmark_control = control,
    .cleanup = cleanup,
    .iteration_count = ITERATION
};



