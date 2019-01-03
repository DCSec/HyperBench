#include "benchmark.h"
#include "rdtsc.h"


#define STR_BENCHMARK_BEGIN "[BENCHMARKS BEGIN]\n"
#define STR_BENCHMARK_END   "[BENCHMARKS END]\n"

extern const benchmark_t _BENCHMARKS_START[], _BENCHMARKS_END[];


static void harness_execute(const benchmark_t *benchmark)
{
    unsigned cycles_low, cycles_high, cycles_low1, cycles_high1;
    unsigned cycles_low2, cycles_high2, cycles_low3, cycles_high3;
    uint64_t start, end, start1, end1;
    uint64_t time_control, time_kernel;

   // fprintf(OUTPUT, "%s -> %s", benchmark->category, benchmark->name);
    printf("%-15s%-15s", benchmark->category, benchmark->name);
    if(benchmark->init) benchmark->init();

    printf("%-10ld", benchmark->iteration_count);
    
    /* test begin */
#ifdef __BARE_METAL
    //before(cycles_low, cycles_high);
    rdtsc(cycles_low, cycles_high);

#else
    printf("{");
#endif
    benchmark->benchmark_control();
#ifdef __BARE_METAL
    //printf("bare metal");
    //after(cycles_low1, cycles_high1);
    rdtsc(cycles_low1, cycles_high1);
#else
    printf("}");
#endif

#ifdef __BARE_METAL
    //printf("bare metal");
    //before(cycles_low2, cycles_high2);
    rdtsc(cycles_low2, cycles_high2);
#else
    printf("[");
#endif
    benchmark->benchmark();
#ifdef __BARE_METAL
    //printf("bare metal");
    //after(cycles_low3, cycles_high3);
    rdtsc(cycles_low3, cycles_high3);
#else
    printf("]\r\n");
#endif

    benchmark->cleanup();

#ifdef __BARE_METAL
    start = ( ((uint64_t)cycles_high << 32) | cycles_low );
    end = ( ((uint64_t)cycles_high1 << 32) | cycles_low1 );
    start1 = ( ((uint64_t)cycles_high2 << 32) | cycles_low2 );
    end1 = ( ((uint64_t)cycles_high3 << 32) | cycles_low3 );
    time_control = (end - start);
    time_kernel = (end1 - start1);
    printf("%-15lu", time_control);
    printf("%-15lu", time_kernel);
    printf("%ld\n", time_kernel - time_control);
#endif


}


void harness_main()
{
    const benchmark_t *benchmark;    
    
    unsigned long long cycles1, cycles2;
     
    /* inform host to pin VCPUs */ 
    printf("*\n");
#ifdef __BARE_METAL

#else
    /* waiting until finished VCPUs pin */
    cycles2 = cycles1 = currentcycles();
    while(cycles2 - cycles1 < 60000000000){
        cycles2 = currentcycles(); 
    }
#endif
    
    printf("%-15s%-15s%-10s\n", "category","name","iteration");
    printf(STR_BENCHMARK_BEGIN);

    for(benchmark = &_BENCHMARKS_START[0]; benchmark < _BENCHMARKS_END; benchmark++)
    {
       
       harness_execute(benchmark);

    }

#ifdef __BARE_METAL
    while(1);
#endif

    printf(STR_BENCHMARK_END);    
    printf(STR_BENCHMARK_END);    
}


