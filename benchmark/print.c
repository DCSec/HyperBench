#include "benchmark.h"
#include "io.h"

#define ITERATION PRINTF

int i;
char a[] = "aaaaaaaaaaaaaaaaaaaaaaaaaa";

char *buf = a;
unsigned long len;

static void init()
{
    /*
    */
    len = strlen(buf);
}

static inline void ALIGN kernel()
{
    for(i = 0; i < ITERATION; i++){
        outbs(buf, len, 0x3f8);
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

DEFINE_BENCHMARK(print) = 
{
    .name = "print",
    .category = "io",
    .init = init,
    .benchmark = kernel,
    .benchmark_control = control,
    .cleanup = cleanup,
    .iteration_count = ITERATION
};


