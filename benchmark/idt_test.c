#include "benchmark.h"
#include "desc.h"

#define ITERATION 1

int i;
unsigned long tmp;

static inline int test_gp(bool *rflags_rf)
{

/*
#define ASM_TRY(catch)                                  \
    "movl $0, %%gs:4 \n\t"                              \
    ".pushsection .data.ex \n\t"                        \
    ".quad 1111f, " catch "\n\t"                        \
    ".popsection \n\t"                                  \
    "1111:"
*/

    asm volatile(
                "mov $0xffffffff, %0 \n\t"
                 ASM_TRY("1f")
                 "mov %0, %%cr4\n\t"
                 "1:"
                 : "=a"(tmp));
    *rflags_rf = exception_rflags_rf();                                                      
    return exception_vector();
}

static inline int test_ud2(bool *rflags_rf)
{
    asm volatile(
                 ASM_TRY("1f")
                 "ud2 \n\t"
//		 "int $6 \n\t"
                 "1:" :); 
    *rflags_rf = exception_rflags_rf();
    return exception_vector();
}

static void init()
{
    //setup_idt();

}

static inline void ALIGN kernel()
{
    //setup_vm();
    int r;
    bool rflags_rf;

    setup_idt();    

    r = test_ud2(&rflags_rf);
//    if (r == UD_VECTOR)
//        fprintf(OUTPUT, "Invalid Opcode Exception!!!");

/*
    r = test_gp(&rflags_rf);
    if (r == GP_VECTOR)
        fprintf(OUTPUT, "General Protection Exception!!!");
*/
}

static inline void control()
{

}

static void cleanup()
{

}

DEFINE_BENCHMARK(ud2) = 
{
    .name = "ud2",
    .category = "exception",
    .init = init,
    .benchmark = kernel,
    .benchmark_control = control,
    .cleanup = cleanup,
    .iteration_count = ITERATION 
};

