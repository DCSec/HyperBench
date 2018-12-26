#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "processor.h"
#include "proc.h"

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu* mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    printf("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  //apicid = apic_id();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  printf("unknown apicid\n");
}



