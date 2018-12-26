#include "types.h"
#include "multiboot.h"

uintptr_t heap_base, heap_end; 
size_t heap_size;

void early_mem_init(struct mbi_bootinfo *bootinfo)
{
    u64 end_of_memory = bootinfo->mem_upper * 1024ull;
    printf("mb->mem_upper = %x\n", end_of_memory);
    printf("mb->mem_upper = %x\n", end_of_memory);
}


void phys_alloc_init(uintptr_t base_addr, uintptr_t size)
{
        heap_base = base_addr;
        heap_size = (size_t)size;
        heap_end = heap_base + heap_size;
        //get_free_pages();
}


