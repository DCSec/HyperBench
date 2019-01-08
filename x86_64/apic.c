#include "types.h"
#include "msr.h"
#include "processor.h"
#include "defs.h"
#include "apic.h"
#include "io.h"
#include "traps.h"

// Local APIC registers, divided by 4 for use as uint[] indices.
#define ID      (0x0020/4)   // ID
#define VER     (0x0030/4)   // Version
#define TPR     (0x0080/4)   // Task Priority
#define EOI     (0x00B0/4)   // EOI
#define SVR     (0x00F0/4)   // Spurious Interrupt Vector
  #define ENABLE     0x00000100   // Unit Enable
#define ESR     (0x0280/4)   // Error Status
#define ICRLO   (0x0300/4)   // Interrupt Command
  #define INIT       0x00000500   // INIT/RESET
  #define STARTUP    0x00000600   // Startup IPI
  #define DELIVS     0x00001000   // Delivery status
  #define ASSERT     0x00004000   // Assert interrupt (vs deassert)
  #define DEASSERT   0x00000000
  #define LEVEL      0x00008000   // Level triggered
  #define BCAST      0x00080000   // Send to all APICs, including self.
  #define BUSY       0x00001000
  #define FIXED      0x00000000
#define ICRHI   (0x0310/4)   // Interrupt Command [63:32]
#define TIMER   (0x0320/4)   // Local Vector Table 0 (TIMER)
  #define X1         0x0000000B   // divide counts by 1
  #define PERIODIC   0x00020000   // Periodic
#define PCINT   (0x0340/4)   // Performance Counter LVT
#define LINT0   (0x0350/4)   // Local Vector Table 1 (LINT0)
#define LINT1   (0x0360/4)   // Local Vector Table 2 (LINT1)
#define ERROR   (0x0370/4)   // Local Vector Table 3 (ERROR)
  #define MASKED     0x00010000   // Interrupt masked
#define TICR    (0x0380/4)   // Timer Initial Count
#define TCCR    (0x0390/4)   // Timer Current Count
#define TDCR    (0x03E0/4)   // Timer Divide Configuration

volatile uint *lapic;  // Initialized in mp.c

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
  if(!lapic)
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
  lapicw(TICR, 10000000);

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
    lapicw(PCINT, MASKED);
  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
  lapicw(ESR, 0);

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
/*
  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
    ;
*/
  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}


// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us) 
{
}

#define CMOS_PORT    0x70
#define CMOS_RETURN  0x71


// Start additional processor running entry code at addr.
void
lapicstartap(uchar apicid, uint addr)
{
  int i;
  ushort *wrv;
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(0xF, CMOS_PORT);  // offset 0xF is shutdown code
  outb(0x0A, CMOS_PORT+1);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
  microdelay(200);
  lapicw(ICRLO, INIT | LEVEL);
  microdelay(100);    // should be 10ms, but too slow in Bochs!

  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }

}



// Local APIC registers, divided by 4 for use as uint[] indices.
#define ID      (0x0020/4)   // ID


void *g_apic = (void *)0xfee00000;
void *g_ioapic = (void *)0xfec00000;


struct apic_ops {
    u32 (*reg_read)(unsigned reg);
    void (*reg_write)(unsigned reg, u32 val);
    void (*icr_write)(u32 val, u32 dest);
    u32 (*id)(void);
};
/*
static void outb(unsigned char data, unsigned short port)
{
    asm volatile ("out %0, %1" : : "a"(data), "d"(port));
}
*/
void eoi(void)
{
    apic_write(APIC_EOI, 0);
}

static u32 xapic_read(unsigned reg)
{
    return *(volatile u32 *)(g_apic + reg);
}

static void xapic_write(unsigned reg, u32 val)
{
    *(volatile u32 *)(g_apic + reg) = val;
}

static void xapic_icr_write(u32 val, u32 dest)
{
    while (xapic_read(APIC_ICR) & APIC_ICR_BUSY)
        ;
    xapic_write(APIC_ICR2, dest << 24);
    xapic_write(APIC_ICR, val);
}

static uint32_t xapic_id(void)
{
    return xapic_read(APIC_ID) >> 24;
}

static const struct apic_ops xapic_ops = {
    .reg_read = xapic_read,
    .reg_write = xapic_write,
    .icr_write = xapic_icr_write,
    .id = xapic_id,
};

static const struct apic_ops *apic_ops = &xapic_ops;

static u32 x2apic_read(unsigned reg)
{
    unsigned a, d;

    asm volatile ("rdmsr" : "=a"(a), "=d"(d) : "c"(APIC_BASE_MSR + reg/16));
    return a | (u64)d << 32;
}

static void x2apic_write(unsigned reg, u32 val)
{
    asm volatile ("wrmsr" : : "a"(val), "d"(0), "c"(APIC_BASE_MSR + reg/16));
}

static void x2apic_icr_write(u32 val, u32 dest)
{
    asm volatile ("wrmsr" : : "a"(val), "d"(dest),
                  "c"(APIC_BASE_MSR + APIC_ICR/16));
}

static uint32_t x2apic_id(void)
{
    return x2apic_read(APIC_ID);
}

static const struct apic_ops x2apic_ops = {
    .reg_read = x2apic_read,
    .reg_write = x2apic_write,
    .icr_write = x2apic_icr_write,
    .id = x2apic_id,
};

u32 apic_read(unsigned reg)
{
    return apic_ops->reg_read(reg);
}

void apic_write(unsigned reg, u32 val)
{
    apic_ops->reg_write(reg, val);
}

bool apic_read_bit(unsigned reg, int n)
{
    reg += (n >> 5) << 4;
    n &= 31;
    return (apic_read(reg) & (1 << n)) != 0;
}

void apic_icr_write(u32 val, u32 dest)
{
    apic_ops->icr_write(val, dest);
}

uint32_t apic_id(void)
{
    return apic_ops->id();
}

uint8_t apic_get_tpr(void)
{
	unsigned long tpr;

#ifdef __x86_64__
	asm volatile ("mov %%cr8, %0" : "=r"(tpr));
#else
	tpr = apic_read(APIC_TASKPRI) >> 4;
#endif
	return tpr;
}

void apic_set_tpr(uint8_t tpr)
{
#ifdef __x86_64__
	asm volatile ("mov %0, %%cr8" : : "r"((unsigned long) tpr));
#else
	apic_write(APIC_TASKPRI, tpr << 4);
#endif
}

int enable_x2apic(void)
{
    unsigned a, b, c, d;

    asm ("cpuid" : "=a"(a), "=b"(b), "=c"(c), "=d"(d) : "0"(1));

    if (c & (1 << 21)) {
        asm ("rdmsr" : "=a"(a), "=d"(d) : "c"(MSR_IA32_APICBASE));
        a |= 1 << 10;
        asm ("wrmsr" : : "a"(a), "d"(d), "c"(MSR_IA32_APICBASE));
        apic_ops = &x2apic_ops;
        return 1;
    } else {
        return 0;
    }
}

void disable_apic(void)
{
    wrmsr(MSR_IA32_APICBASE, rdmsr(MSR_IA32_APICBASE) & ~(APIC_EN | APIC_EXTD));
    apic_ops = &xapic_ops;
}

void reset_apic(void)
{
    disable_apic();
    wrmsr(MSR_IA32_APICBASE, rdmsr(MSR_IA32_APICBASE) | APIC_EN);
}

u32 ioapic_read_reg(unsigned reg)
{
    *(volatile u32 *)g_ioapic = reg;
    return *(volatile u32 *)(g_ioapic + 0x10);
}

void ioapic_write_reg(unsigned reg, u32 value)
{
    *(volatile u32 *)g_ioapic = reg;
    *(volatile u32 *)(g_ioapic + 0x10) = value;
}

void ioapic_write_redir(unsigned line, ioapic_redir_entry_t e)
{
    ioapic_write_reg(0x10 + line * 2 + 0, ((u32 *)&e)[0]);
    ioapic_write_reg(0x10 + line * 2 + 1, ((u32 *)&e)[1]);
}

ioapic_redir_entry_t ioapic_read_redir(unsigned line)
{
    ioapic_redir_entry_t e;

    ((u32 *)&e)[0] = ioapic_read_reg(0x10 + line * 2 + 0);
    ((u32 *)&e)[1] = ioapic_read_reg(0x10 + line * 2 + 1);
    return e;

}

void ioapic_set_redir(unsigned line, unsigned vec,
			     trigger_mode_t trig_mode)
{
	ioapic_redir_entry_t e = {
		.vector = vec,
		.delivery_mode = 0,
		.trig_mode = trig_mode,
	};

	ioapic_write_redir(line, e);
}

void set_mask(unsigned line, int mask)
{
    ioapic_redir_entry_t e = ioapic_read_redir(line);

    e.mask = mask;
    ioapic_write_redir(line, e);
}

void set_irq_line(unsigned line, int val)
{
	asm volatile("out %0, %1" : : "a"((u8)val), "d"((u16)(0x2000 + line)));
}

void enable_apic(void)
{
//    printf("enabling apic\n");
    xapic_write(0xf0, 0x1ff); /* spurious vector register */
}

/*
  PIC (8259A) 
  master port address 0x20, 0x21
  slave port address 0xA0, 0xA1
*/
void mask_pic_interrupts(void)
{
    outb(0xff, 0x21);
    outb(0xff, 0xa1);
}

int
lapicid(void)
{
  if (!lapic)
    return 0;
  //printf("lapicid = %d\n",lapic[ID]);
  return lapic[ID] >> 24; 
}


