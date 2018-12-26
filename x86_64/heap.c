#include "libcflat.h"
#include "heap.h"
#include "spinlock.h"
#include "processor.h"
#include "platform.h"


/*
* Use freelist & delete heap_cur
*/
uintptr_t heap_base, heap_end;
size_t heap_size;

static struct spinlock lock;
static void *vfree_top = 0;
static void *freelist = 0;
static void *page_root;
uintptr_t start_cr3;

void *alloc_vpages(ulong nr)
{
        spin_lock(&lock);
        vfree_top -= PAGE_SIZE * nr;
        spin_unlock(&lock);
        return vfree_top;
}

void phys_alloc_init(uintptr_t base_addr, uintptr_t size)
{
	heap_base = base_addr;
	heap_size = (size_t)size;
	heap_end = heap_base + heap_size;
        //get_free_pages();
}

void phys_alloc_get_unused(uintptr_t *base, uintptr_t *end)
{
    *base = heap_base;
    *end = heap_end;
}
/*
* set freelist first
*/
void *heap_alloc_page()
{
    void *page;
    //fprintf(OUTPUT, "%p ", freelist);
    if (!freelist) {
        printf("freelist uninitialized!\n");
        
        platform_shutdown();

        return 0;
    }
    
    page = freelist;
    freelist = *(void **)freelist;

    __fast_zero_page(page);
    return page;
}


/*
* Get the unused pages after _HEAP_START
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


#define PF_PRESENT		1
#define PF_WRITABLE		2
#define PF_USER			4

typedef uint64_t pte;

typedef struct{
    unsigned int pml, pdp, pd, pt;
}table_indicies;

static inline table_indicies calculate_indicies(uintptr_t virt_addr)
{
    table_indicies ret;
    
    ret.pt = (virt_addr >> 12) & 0x1ff;
    ret.pd = (virt_addr >> 21) & 0x1ff;
    ret.pdp = (virt_addr >> 30) & 0x1ff;
    ret.pml = (virt_addr >> 39) & 0x1ff; 
   
    return ret;
}

static inline void set_base_address(pte *pte, uintptr_t base_addr)
{
    *pte = (base_addr & ~0xfffULL) | ((*pte) & 0xfffULL);
}

static inline uintptr_t get_base_address(const pte *pte)
{
    return (*pte) & ~0xfffULL;
}


static inline void set_flags(pte *pte, uint64_t flags)
{
    *pte = (flags & 0xfffULL) | ((*pte) & ~0xfffULL);
}

static inline uint64_t get_flags(const pte *pte)
{
    return (*pte) & 0xfffULL;
}

static inline int is_present(const pte *pte)
{
    return !!(get_flags(pte) & PF_PRESENT); 
}


int __create_page_mapping(uintptr_t pml4, uintptr_t phys_addr, uintptr_t virt_addr)
{
    table_indicies idx = calculate_indicies(virt_addr);
/*    
    fprintf(OUTPUT,"mapping va = %p to pa=%p pml=%d,pdp=%d,pd=%d,pt=%d\n",
           virt_addr, phys_addr, idx.pml, idx.pdp, idx.pd, idx.pt);
*/    
    /* root_address = (pte *)pml4 */
    pte *pml = &((pte *)pml4)[idx.pml]; 
     
    //fprintf(OUTPUT, "root = %p\n", pml4);
    //fprintf(OUTPUT,"ptl4->%d = %p\n", idx.pml, *pml); 
    //fprintf(OUTPUT, "read_via_phys_ptl4->0 = %x\n", *(pte *)pml4);

    if (!is_present(pml)) {
        if (get_base_address(pml) == 0) {
            set_base_address(pml, (uintptr_t)heap_alloc_page());
        }
		
        set_flags(pml, PF_PRESENT | PF_WRITABLE | PF_USER);
    }
	
    pte *pdp = &((pte *)get_base_address(pml))[idx.pdp];
    if (!is_present(pdp)) {
        if (get_base_address(pdp) == 0) {
            set_base_address(pdp, (uintptr_t)heap_alloc_page());
        }
		
        set_flags(pdp, PF_PRESENT | PF_WRITABLE | PF_USER);
    }

    pte *pd = &((pte *)get_base_address(pdp))[idx.pd];
    if (!is_present(pd)) {
        if (get_base_address(pd) == 0) {
            set_base_address(pd, (uintptr_t)heap_alloc_page());
        }
		
        set_flags(pd, PF_PRESENT | PF_WRITABLE | PF_USER);
    }
	
    pte *pt = &((pte *)get_base_address(pd))[idx.pt];
    set_base_address(pt, phys_addr);
    set_flags(pt, PF_PRESENT | PF_WRITABLE | PF_USER);

    //fprintf(OUTPUT,"ptl4->%d = %p\n", idx.pml, *pml); 
 
}


/*
int mem_create_page_mapping_data(uintptr_t phys_addr, uintptr_t virt_addr)
{
    //uintptr_t root;
    //root = read_cr3();
   
    //fprintf(OUTPUT,"heap_root = %x\n", heap_root);    

    __create_page_mapping(heap_root, phys_addr, virt_addr);
}
*/

void mem_tlb_flush()
{
    write_cr3(read_cr3());
}

void mem_tlb_evict(uintptr_t ptr)
{
    asm volatile("invlpg (%0)\n" : : "r"(ptr));
}

void switch_to_start_cr3()
{
    write_cr3(start_cr3);
}
/*
void apic_mem_init()
{
    uintptr_t root;
    root = read_cr3();
    __create_page_mapping(root, (uintptr_t)LAPIC, (uintptr_t)LAPIC); 
    mem_tlb_flush();   
}
*/
static void setup_mmu_range(uintptr_t *cr3, uintptr_t start, size_t len)
{
    uint64_t max = start + len;
    uintptr_t phys = (uintptr_t)0;
    while (phys + PAGE_SIZE <= max) {
        //mem_create_page_mapping_data(cur, cur);
        __create_page_mapping((uintptr_t)cr3, phys, phys);
        phys += PAGE_SIZE;
        //fprintf(OUTPUT,"WS:%x ", phys);
    }

}

void *setup_mmu(uintptr_t end_of_memory)
{
    
    uintptr_t *cr3 = heap_alloc_page();
    //fprintf(OUTPUT,"cr3 = %x\n", (uintptr_t)cr3);
#ifdef __x86_64__
    if (end_of_memory < (1ul << 32))
        end_of_memory = (1ul << 32);  /* map mmio 1:1 */

    setup_mmu_range(cr3, 0, end_of_memory); 

#endif
   
    start_cr3 = read_cr3();   
 
    write_cr3((uintptr_t)cr3);
    //write_cr0(X86_CR0_PG |X86_CR0_PE | X86_CR0_WP);
  
    return cr3;
}

uintptr_t *install_pte(uintptr_t *cr3,
                      int pte_level,
                      void *virt,
                      uintptr_t pte,
                      uintptr_t *pt_page)
{
    int level;
    uintptr_t *pt = cr3;
    unsigned offset;

    for (level = 4; level > pte_level; --level) {
        offset = PGDIR_OFFSET((uintptr_t)virt, level);
        if (!(pt[offset] & PT_PRESENT_MASK)) {
            uintptr_t *new_pt = pt_page;
            if (!new_pt)
                new_pt = heap_alloc_page();
            else
                pt_page = 0;
            memset(new_pt, 0, PAGE_SIZE);
            pt[offset] = virt_to_phys(new_pt) | PT_PRESENT_MASK | PT_WRITABLE_MASK | PT_USER_MASK;
        }
        pt = phys_to_virt(pt[offset] & PT_ADDR_MASK);
    }
    offset = PGDIR_OFFSET((uintptr_t)virt, level);
    pt[offset] = pte;
    return &pt[offset];


}


uintptr_t *install_large_page(uintptr_t *cr3, uintptr_t phys, void *virt)
{
    return install_pte(cr3, 2, virt,
                       phys | PT_PRESENT_MASK | PT_WRITABLE_MASK | PT_USER_MASK | PT_PAGE_SIZE_MASK, 0);
}

uintptr_t *install_page(uintptr_t *cr3, uintptr_t phys, void *virt)
{
    return install_pte(cr3, 1, virt, phys | PT_PRESENT_MASK | PT_WRITABLE_MASK | PT_USER_MASK, 0);
}

void install_pages(uintptr_t *cr3, uintptr_t phys, size_t len, void *virt)
{
    uintptr_t max = (uintptr_t)len + (uintptr_t)phys;
    //assert(phys % PAGE_SIZE == 0);
    //assert((uintptr_t) virt % PAGE_SIZE == 0);
    //assert(len % PAGE_SIZE == 0);

    while (phys + PAGE_SIZE <= max) {
        install_page(cr3, phys, virt);
        phys += PAGE_SIZE;
        virt = (char *) virt + PAGE_SIZE;
    }

}


/*
static void setup_mmu_range(uintptr_t *cr3, uintptr_t start, size_t len)
{
        uintptr_t max = (uintptr_t)len + (uintptr_t)start;
        uintptr_t phys = start;

        while (phys + LARGE_PAGE_SIZE <= max) {
                install_large_page(cr3, phys, (void *)(ulong)phys);
                phys += LARGE_PAGE_SIZE;
        }
        install_pages(cr3, phys, max - phys, (void *)(ulong)phys);
}
*/

void setup_vm()
{
    uintptr_t base, top;
        
    base = heap_base;
    top = heap_end;
   
    freelist = 0;
    
    if(freelist == 0) {
        base = (base + PAGE_SIZE - 1) & -PAGE_SIZE; 
        top = top & -PAGE_SIZE;
        get_free_pages((void *)base, top - base);
    }
/*   
    uintptr_t addr = (uintptr_t *)freelist;
    while(addr + PAGE_SIZE < top) {
        fprintf(OUTPUT,"addr = %x\n", addr);
        addr = *((uintptr_t *)addr);
    }
*/  
    page_root = setup_mmu(top);
    
}

void setup_pt()
{
    page_root = setup_mmu(heap_end);
}
