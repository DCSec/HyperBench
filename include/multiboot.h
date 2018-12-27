#include "types.h"

struct mbi_bootinfo {
        u32 flags;
        u32 mem_lower;
        u32 mem_upper;
        u32 boot_device;
        u32 cmdline;
        u32 mods_count;
        u32 mods_addr;
        u32 reserved[4];   /* 28-39 */
	u32 mmap_length;
        u32 mmap_addr;
        u32 reserved0[3];  /* 52-63 */
        u32 bootloader;
        u32 reserved1[5];  /* 68-87 */
        u32 size;
};



typedef struct mmap_entry_t
{
    uint32_t size; 
    uint64_t base_addr;
    uint64_t length;
    uint32_t type;
}__attribute__((packed)) mmap_entry_t;



