
#include "types.h"
#include "defs.h"
#include "mmu.h"

// Bootstrap processor starts running C code here.
int main()
{
    //console_init();
    //console_putc('W');
    printf("TEST = %d\n", 10);
    while(1);
    return 0;
}


// The boot page table used in cstart.S
// Page directories (and page tables) must start on page boundaries,
// hence the __aligned__ attribrute.
// PTE_PS in a page directory entry enables 1Gbyte pages.

__attribute__((__aligned__(PGSIZE)))
unsigned long entrypgdir[1] = {
    // Map VA's [0,1GB) to PA's [0,1GB)
    [0] = 0x1e7 | (0 << 30),
}; 

__attribute__((__aligned__(PGSIZE)))
unsigned long entrypml4e[1] = {
    // Point to page directory table
    [0] = (unsigned long)entrypgdir + 7,
};



