
#ifndef __RDTSC_H
#define __RDTSC_H


#define before(low,high) \
    asm volatile(       \
        "cpuid\n\t"       \
        "rdtscp\n\t"        \
        "mov %%edx, %0\n\t"   \
        "mov %%eax, %1\n\t": "=r" (high), "=r" (low)::  \
        "%rax", "%rbx", "%rcx", "%rdx")

#define after(low,high) \
    asm volatile(        \
        "rdtscp\n\t"       \
        "mov %%edx, %0\n\t"  \
        "mov %%eax, %1\n\t"  \
        "cpuid\n\t"     \
        : "=r" (high), "=r" (low)::  \
        "%rax", "%rbx", "%rcx", "%rdx")

#define rdtsc(low,high) \
        __asm__ __volatile__("rdtsc":"=a"(low),"=d"(high))

#define rdtscll(val) \
        __asm__ __volatile__("rdtsc":"=A"(val))

static inline unsigned long long currentcycles(){
    unsigned long long cycles;
    __asm__  __volatile__("rdtsc":"=A"(cycles));
    return cycles;
}


#endif


