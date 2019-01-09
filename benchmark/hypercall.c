#ifndef __BARE_METAL

#include "benchmark.h"

#define ITERATION HYPERCALL

#define KVM_HYPERCALL_INTEL ".byte 0x0f,0x01,0xc1"
#define KVM_HYPERCALL_AMD ".byte 0x0f,0x01,0xd9"

static inline long kvm_hypercall0_intel(unsigned int nr) 
{
        long ret;
        asm volatile(KVM_HYPERCALL_INTEL
                     : "=a"(ret)
                     : "a"(nr));
        return ret;
}

static inline long kvm_hypercall0_amd(unsigned int nr) 
{
        long ret;
        asm volatile(KVM_HYPERCALL_AMD
                     : "=a"(ret)
                     : "a"(nr));
        return ret;
}

int i;

static void init()
{
    /*
    */
}

static inline void ALIGN kernel()
{
    unsigned long a = 0, b, c ,d;
    for(i = 0; i < ITERATION; i++){
//        asm volatile("vmcall" : "+a"(a), "=b"(b), "=c"(c), "=d"(d));
        kvm_hypercall0_intel(-1u);
    }
}

static inline void control()
{
    for(i = 0; i < ITERATION; i++){
    
    }
}

static void cleanup()
{

}

DEFINE_BENCHMARK(hypercall) = 
{
    .name = "hypercall",
    .category = "exception",
    .init = init,
    .benchmark = kernel,
    .benchmark_control = control,
    .cleanup = cleanup,
    .iteration_count = ITERATION
};

#endif

