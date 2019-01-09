#include "defs.h"

#define IDLE		1
#define LGDT            100000
#define SET_CR3         100000
#define SGDT            100000
#define SIDT            100000
#define SLDT            100000
#define SMSW            100000
#define PUSHF_POPF      100000
#define IPI             100
#define HYPERCALL       1000
#define SET_PAGE_TABLE  1
#define COLD_ACCESS     100000
#define HOT_ACCESS      100000
#define IN_SERIAL_PORT  1000
#define OUT_SERIAL_PORT 1000
#define PRINTF          1000

#define ALIGN __attribute__((aligned(4096)))

typedef void (*function_t)();

typedef struct {
    const char *name;
    const char *category;
    function_t init;
    function_t benchmark;
    function_t benchmark_control;
    function_t cleanup;
    uint64_t iteration_count;
}benchmark_t;


#define DEFINE_BENCHMARK(__name) const benchmark_t __attribute__((section(".benchmarks"))) __attribute__((aligned(__alignof__(unsigned long))))  __benchmark_##__name


