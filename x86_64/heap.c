#include "types.h"
#include "multiboot.h"
#include "mmu.h"

uintptr_t heap_base, heap_end; 
static void *freelist = 0;

/*
    Get the memory map of the machine provided by the BIOS.
*/
void get_memory_map(struct mbi_bootinfo *glb_mboot_ptr)
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

/*
* Place the pages after _HEAP_START on free list.
*/
void *get_free_pages(void *mem, unsigned long size)
{
    
    void *old_freelist;
    void *end;

    if(size == 0) {
    
        return 0;  
    }   

    old_freelist = freelist;
    freelist = mem;
    end = mem + size;
    
    while (mem + PAGE_SIZE != end) {
        *(void **)mem = (mem + PAGE_SIZE);
        mem += PAGE_SIZE;
    }   

    *(void **)mem = old_freelist;
 
    return freelist;
}

/*
    
*/
void early_mem_init(uintptr_t base_addr, struct mbi_bootinfo *bootinfo)
{
//    u64 end_of_memory = bootinfo->mem_upper * 1024ull;
//    printf("mbi->mmap_addr = %x\n", bootinfo->mmap_addr);
//    printf("mbi->mmap_length = %x\n", bootinfo->mmap_length);
    get_memory_map(bootinfo);
    
    heap_base = (base_addr + PAGE_SIZE - 1) & (-PAGE_SIZE);
    heap_end = heap_end & (-PAGE_SIZE);

    printf("Memory Start: %x B\n", heap_base);
    printf("Memory End: %x B\n", heap_end);
    printf("Total Memory: %d MB\n", heap_end >> 20);


    freelist = 0;
    if(freelist == 0){
//        get_free_pages((void *)heap_base, heap_end - heap_base);
        get_free_pages((void *)heap_base, 1ul << 31);
    }    

}

/* 
 Allocate one 4096-byte page of physical memory.
 Returns a pointer that the kernel can use.
 Returns 0 if the memory cannot be allocated.
*/
void *heap_alloc_page(void)
{
    void *page;
    //fprintf(OUTPUT, "%p ", freelist);
    if (!freelist) {
        printf("freelist uninitialized!\n");
        return 0;
    }   
    
    page = freelist;
    freelist = *(void **)freelist;

    __fast_zero_page(page);
    return page;
}




