

#ifdef __x86_64__
#  define R "r"
#  define W "q"
#  define S "8"
#else
#  define R "e"
#  define W "l"
#  define S "4"
#endif
/*
static inline uint64_t pt_pa(void)
{
    uint64_t val;
    asm volatile("mov %%cr3, %0" : "=r"(val) : : "memory");
    return val;
}
*/
static inline u16 read_cs(void)
{
    unsigned val;

    asm volatile ("mov %%cs, %0" : "=mr"(val));
    return val;
}

static inline void write_cr0(ulong val)
{
    asm volatile ("mov %0, %%cr0" : : "r"(val) : "memory");
}

static inline ulong read_cr0(void)
{
    ulong val;
    asm volatile ("mov %%cr0, %0" : "=r"(val) : : "memory");
    return val;
}

static inline void write_cr2(ulong val)
{
    asm volatile ("mov %0, %%cr2" : : "r"(val) : "memory");
}

static inline ulong read_cr2(void)
{
    ulong val;
    asm volatile ("mov %%cr2, %0" : "=r"(val) : : "memory");
    return val;
}


static inline void write_cr3(ulong val)
{
    asm volatile ("mov %0, %%cr3" : : "r"(val) : "memory");
}

static inline ulong read_cr3(void)
{
    ulong val;
    asm volatile ("mov %%cr3, %0" : "=r"(val) : : "memory");
    return val;
}


static inline void write_cr4(ulong val)
{
    asm volatile ("mov %0, %%cr4" : : "r"(val) : "memory");
}

static inline ulong read_cr4(void)
{
    ulong val;
    asm volatile ("mov %%cr4, %0" : "=r"(val) : : "memory");
    return val;
}

static inline void write_cr8(ulong val)
{
    asm volatile ("mov %0, %%cr8" : : "r"(val) : "memory");
}

static inline ulong read_cr8(void)
{
    ulong val;
    asm volatile ("mov %%cr8, %0" : "=r"(val) : : "memory");
    return val;
}

static inline u64 rdmsr(u32 index)
{
    u32 a, d;
    asm volatile ("rdmsr" : "=a"(a), "=d"(d) : "c"(index) : "memory");
    return a | ((u64)d << 32);
}

static inline void wrmsr(u32 index, u64 val)
{
    u32 a = val, d = val >> 32; 
    asm volatile ("wrmsr" : : "a"(a), "d"(d), "c"(index) : "memory");
}

static inline void pause(void)
{
    asm volatile ("pause");
}

static inline void cli(void)
{
    asm volatile ("cli");
}

static inline void sti(void)
{
    asm volatile ("sti");
}


