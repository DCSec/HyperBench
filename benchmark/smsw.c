#include "benchmark.h"
#include "processor.h"

#define ITERATION SMSW

int i;

unsigned short msw, msw_orig;

static void init()
{
    /*
    */
    msw_orig = read_cr0();
    //printf("%d\n", msw_orig);
}

static inline void ALIGN kernel()
{
    for(i = 0; i < ITERATION; i++){
        asm volatile("smsw %0 \n\t" 
                     "smsw %0 \n\t"
                     "smsw %0 \n\t"
                     "smsw %0 \n\t"
                     "smsw %0 \n\t"
                     "smsw %0 \n\t" 
                     "smsw %0 \n\t"
                     "smsw %0 \n\t"
                     "smsw %0 \n\t"
                     "smsw %0 \n\t"
                     : "=r"(msw));
	
    }
    //printf("%d\n", msw);
}

static inline void control()
{
    for(i = 0; i < ITERATION; i++){
    //    asm("smsw %0" : "=r"(msw));
        asm volatile(" ");
    }
}

static void cleanup()
{

}

DEFINE_BENCHMARK(smsw) = 
{
    .name = "smsw",
    .category = "critical",
    .init = init,
    .benchmark = kernel,
    .benchmark_control = control,
    .cleanup = cleanup,
    .iteration_count = ITERATION * 10
};

