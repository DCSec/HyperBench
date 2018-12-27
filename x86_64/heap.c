#include "types.h"
#include "multiboot.h"

uintptr_t heap_base, heap_end; 
size_t heap_size;

void show_memory_map(struct mbi_bootinfo *glb_mboot_ptr)
{
    uint32_t mmap_addr = glb_mboot_ptr->mmap_addr;
    uint32_t mmap_length = glb_mboot_ptr->mmap_length;
 
    mmap_entry_t *mmap = (mmap_entry_t *)(uint64_t) mmap_addr;

    heap_end = 0;    

    for ( ; (uint64_t)mmap < mmap_addr + mmap_length; mmap++)
    {
        heap_end = heap_end + mmap->length;
//        printf("%x\n",(uint64_t) mmap->length);
    }
}


void early_mem_init(struct mbi_bootinfo *bootinfo)
{
    u64 end_of_memory = bootinfo->mem_upper * 1024ull;
//    printf("mbi->mmap_addr = %x\n", bootinfo->mmap_addr);
//    printf("mbi->mmap_length = %x\n", bootinfo->mmap_length);
    show_memory_map(bootinfo);
    
    printf("Total Memory : %d MB\n", heap_end >> 20);

}


void phys_alloc_init(uintptr_t base_addr, uintptr_t size)
{
        heap_base = base_addr;
        heap_size = (size_t)size;
        heap_end = heap_base + heap_size;
        //get_free_pages();
}


