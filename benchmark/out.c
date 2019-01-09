#include "benchmark.h"
#include "io.h"

#define ITERATION OUT_SERIAL_PORT

int i;
u8 lcr;

static void init()
{
    /*
    */
    lcr = inb(0x3f8 + 0x03);
}

static inline void ALIGN kernel()
{
    for(i = 0; i < ITERATION; i++){
/*
        do {
                lsr = inb(0x3f8 + 0x05);
        } while (!(lsr & 0x20));

        outb('x', 0x3f8 + 0x00);
*/
        outb(lcr, 0x3f8 + 0x03);
//        outb(lcr, 0x3fb);
    }

}

static inline void control()
{
    for(i = 0; i < ITERATION; i++){
        asm volatile(" ");
    /*
        do {
                lsr = inb(0x3f8 + 0x05);
        } while (!(lsr & 0x20));
    */
    }
}

static void cleanup()
{

}

DEFINE_BENCHMARK(out) = 
{
    .name = "out-serial",
    .category = "io",
    .init = init,
    .benchmark = kernel,
    .benchmark_control = control,
    .cleanup = cleanup,
    .iteration_count = ITERATION
};



