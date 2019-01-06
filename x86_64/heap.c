#include "types.h"
#include "multiboot.h"
#include "mmu.h"
#include "page.h"
#include "processor.h"


uintptr_t heap_base, heap_end; 
static void *freelist = 0;

static bool first_mem_init = false;

uintptr_t start_cr3;


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
  if(!first_mem_init){
    first_mem_init = true;

    get_memory_map(bootinfo);
    
    heap_base = (base_addr + PAGE_SIZE - 1) & (-PAGE_SIZE);
    heap_end = heap_end & (-PAGE_SIZE);

    printf("Memory Start: %x B\n", heap_base);
    printf("Memory End: %x B\n", heap_end);
    printf("Total Memory: %d MB\n", heap_end >> 20);
  }
  
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

/**********************************************************************/
/*
* pte: the physical address of a page frame
*
*/
pteval_t *install_pte(pgd_t *cr3,
                      int pte_level,
                      void *virt,
                      pteval_t pte,
                      pteval_t *pt_page)
{
    int level;
    pteval_t *pt = cr3;
    unsigned offset;

    for(level = PAGE_LEVEL; level > pte_level; --level) {
        offset = PGDIR_OFFSET((uintptr_t)virt, level);
        if(!(pt[offset] & PT_PRESENT_MASK)) {
            pteval_t *new_pt = pt_page;
            if(!new_pt)
                new_pt = heap_alloc_page();
            else
                pt_page = 0;
            memset(new_pt, 0, PAGE_SIZE);
            pt[offset] = (unsigned long)new_pt | PT_PRESENT_MASK | PT_WRITABLE_MASK | PT_USER_MASK;
        }
        pt = (void *)((unsigned long)(pt[offset] & PT_ADDR_MASK));
    }
    offset = PGDIR_OFFSET((uintptr_t)virt, level);
    pt[offset] = pte;
    return &pt[offset];
}

pteval_t *install_large_page(pgd_t *cr3, phys_addr_t phys, void *virt)
{
    return install_pte(cr3, 2, virt,
                       phys | PT_PRESENT_MASK | PT_WRITABLE_MASK | PT_USER_MASK | PT_PAGE_SIZE_MASK, 0); 
}

pteval_t *install_page(pgd_t *cr3, phys_addr_t phys, void *virt)
{
    return install_pte(cr3, 1, virt, phys | PT_PRESENT_MASK | PT_WRITABLE_MASK | PT_USER_MASK, 0); 
}

void install_pages(pgd_t *cr3, phys_addr_t phys, size_t len, void *virt)
{
        phys_addr_t max = (u64)len + (u64)phys;
//        assert(phys % PAGE_SIZE == 0); 
//        assert((uintptr_t) virt % PAGE_SIZE == 0); 
//        assert(len % PAGE_SIZE == 0);

        while (phys + PAGE_SIZE <= max) {
                install_page(cr3, phys, virt);
                phys += PAGE_SIZE;
                virt = (char *) virt + PAGE_SIZE;
        }
}

void *setup_mmu(phys_addr_t end_of_memory)
{
    uintptr_t *cr3 = heap_alloc_page();
    
    if(end_of_memory == 0)
        end_of_memory = (1ul << 32);   /* map 1:1 */
    
    install_pages(cr3, 0, end_of_memory, (void *)0);
// save the original @cr3 and set the new page table root
    start_cr3 = read_cr3();
    write_cr3((uintptr_t)cr3);    

    return cr3;
}


void switch_to_start_cr3()
{
    write_cr3(start_cr3);
}

void reset_freelist()
{
    get_free_pages((void *)heap_base, 1ul << 31);
}


/******************************************************************************************************/


