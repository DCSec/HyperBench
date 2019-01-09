#include "benchmark.h"

#define ITERATION PUSHF_POPF

int i;

static inline void test_pushf_popf()
{
    asm volatile("pushf \n\t"
		 "popf \n\t"
		 "pushf \n\t"
                 "popf \n\t"
		 "pushf \n\t"
                 "popf \n\t"
		 "pushf \n\t"
                 "popf \n\t"
		 "pushf \n\t"
                 "popf \n\t"

		 "pushf \n\t"
                 "popf \n\t"
		 "pushf \n\t"
                 "popf \n\t"
		 "pushf \n\t"
                 "popf \n\t"
		 "pushf \n\t"
                 "popf \n\t"
		 "pushf \n\t"
                 "popf \n\t"

		    );

}

static void init()
{
    /*
    */

}

static inline void ALIGN kernel()
{
    for(i = 0; i < ITERATION; i++){
        test_pushf_popf();
    }
}

static inline void control()
{
    for(i = 0; i < ITERATION; i++){
//        test_pushf_popf();
    }
}

static void cleanup()
{

}

DEFINE_BENCHMARK(pushf_popf) = 
{
    .name = "pushf-popf",
    .category = "critical",
    .init = init,
    .benchmark = kernel,
    .benchmark_control = control,
    .cleanup = cleanup,
    .iteration_count = ITERATION * 10
};

