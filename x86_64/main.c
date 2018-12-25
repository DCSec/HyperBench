
#include "types.h"
#include "defs.h"
#include "mmu.h"

static void startothers(void);


// Bootstrap processor starts running C code here.
int main()
{
    printf("sizeof(void *) = %d\n", (int)sizeof(void *));
    //console_init();
    //console_putc('W');

    mask_pic_interrupts();
    enable_apic();
    mpinit();        // detect other processors

    printf("sizeof(int) = %d\n", (int)sizeof(int));
    while(1);
    return 0;
}

// Start the non-boot (AP) processors.
static void startothers(void)
{

}



