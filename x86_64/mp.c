// Multiprocessor support
// Search memory for MP description structures.
// http://developer.intel.com/design/pentium/datashts/24201606.pdf

#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mp.h"
//#include "x86.h"
#include "processor.h"
#include "mmu.h"
#include "proc.h"
#include "io.h"
#include "apic.h"
#include "atomic.h"
#include "spinlock.h"

#define IPI_VECTOR 0x20

struct cpu cpus[NCPU];
int ncpu;
uchar ioapicid;

/************************************************************************/
typedef void (*ipi_function_type)(void *data);

static struct spinlock ipi_lock;
static volatile ipi_function_type ipi_function;
static void *volatile ipi_data;
static volatile int ipi_done;
static volatile bool ipi_wait;
static int _cpu_count;
static atomic_t active_cpus;

static __attribute__((used)) void ipi()
{
/*
    void (*function)(void *data) = ipi_function;
    void *data = ipi_data;
    bool wait = ipi_wait;
    if (!wait) {
        ipi_done = 1;
        apic_write(APIC_EOI, 0); 
    }   
    function(data);
    atomic_dec(&active_cpus);
    if (wait) {
        ipi_done = 1;
        apic_write(APIC_EOI, 0); 
    }   
*/  
    ipi_done = 1;
    apic_write(APIC_EOI, 0);  
}

asm (
     "ipi_entry: \n"
     "   call ipi \n"
#ifndef __x86_64__
     "   iret"
#else
     "   iretq"
#endif
     );


static void setup_smp_id(void *data)
{
    asm ("mov %0, %%gs:0" : : "r"(apic_id()) : "memory");
}

int smp_id(void)
{
    unsigned id;

    asm ("mov %%gs:0, %0" : "=r"(id));
    return id;
}


//static void do_test(struct ex_regs *regs)
static void do_test()
{
    printf("STOP");
    while(1);
}


static void __on_cpu(int cpu, void (*function)(void *data), void *data,
                     int wait)
{
/*
    spin_lock(&ipi_lock);
    if (cpu == smp_id())
        function(data);
    else {
        atomic_inc(&active_cpus);
        ipi_done = 0;
        ipi_function = function;
        ipi_data = data;
        ipi_wait = wait;
        apic_icr_write(APIC_INT_ASSERT | APIC_DEST_PHYSICAL | APIC_DM_FIXED
                       | IPI_VECTOR,
                       cpu);
        while (!ipi_done);
    }   
    spin_unlock(&ipi_lock);
*/
    spin_lock(&ipi_lock);
    ipi_done = 0;
    apic_icr_write(APIC_INT_ASSERT | APIC_DEST_PHYSICAL | APIC_DM_FIXED
                       | IPI_VECTOR,
                       cpu); 
    while(!ipi_done);
    spin_unlock(&ipi_lock);
}

void on_cpu(int cpu, void (*function)(void *data), void *data)
{
//    __on_cpu(cpu, function, data, 1);
    __on_cpu(cpus[cpu].apicid, function, data, 1); 
}

/*
    Prepare idt needed for the ipi.
*/
void smp_init(void)
{
    int i;
    void ipi_entry(void);
    
    setup_idt();
    set_idt_entry(IPI_VECTOR, ipi_entry, 0);
/*    
    setup_smp_id(0);

    for (i = 1; i < ncpu; ++i){
        on_cpu(i, setup_smp_id, 0);
    }

    atomic_inc(&active_cpus);
*/
}



/**********************************************************************/

static uchar sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
  return sum;
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(phys_addr_t a, int len)
{
  uchar *e, *p, *addr;

//  addr = P2V(a);
  addr = (void *)((char *)(a));
//  printf("addr = %lx\n", a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      {
//        printf("_MP_\n");
        return (struct mp*)p;
      }
  return 0;
}

// Search for the MP Floating Pointer Structure, which according to the
// spec is in one of the following three locations:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
  uchar *bda;
//  uint p;
  phys_addr_t p;
  struct mp *mp;

//  bda = (uchar *) P2V(0x400);
  bda = (uchar *) (0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
#ifdef __BARE_METAL  
//    printf("bad[0x0F] = %x\n",bda[0x0F]);
//    printf("bad[0x0E] = %x\n",bda[0x0E]);
//    printf("p = %lx\n",p);
#endif
    if((mp = mpsearch1(p, 1024)))
      {
#ifdef __BARE_METAL
        printf("MP in the first KB of the EBDA\n");
#endif
        return mp;
      }
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
#ifdef __BARE_METAL  
//    printf("bad[0x14] = %x\n",bda[0x14]);
//    printf("bad[0x13] = %x\n",bda[0x13]);
//    printf("p = %lx\n",p);
#endif
    if((mp = mpsearch1(p-1024, 1024)))
      {
#ifdef __BARE_METAL
        printf("MP in the last KB of system base memory\n");
#endif
        return mp;
      }
  }
#ifdef __BARE_METAL
  printf("MP in the BIOS ROM between 0xE0000 and 0xFFFFF\n");
#endif
  return mpsearch1(0xF0000, 0x10000);
}

// Search for an MP configuration table.  For now,
// don't accept the default configurations (physaddr == 0).
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
    return 0;
//  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  conf = (struct mpconf*) ((uint64_t) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
    return 0;
  *pmp = mp;
  return conf;
}

/*
  apicid may differ from different chips
*/
void mpinit(void)
{
  uchar *p, *e;
  int ismp;
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    //panic("Expect to run on an SMP");
    printf("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)((uint64_t)(conf->lapicaddr));
//printf("lapic = %p\n", lapic);
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
        ncpu++;
#ifdef __HT__
	cpus[ncpu].apicid = proc->apicid + 1;  // HyperThread(Logical Processor)
	ncpu++;
#endif
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    //panic("Didn't find a suitable machine");
    printf("Didn't find a suitable machine");
/*
  if(mp->imcrp){
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    //outb(0x22, 0x70);   // Select IMCR
    outb(0x70, 0x22);   // Select IMCR
    //outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
    outb(inb(0x23) | 1, 0x23);  // Mask external interrupts.
  }
*/
}


