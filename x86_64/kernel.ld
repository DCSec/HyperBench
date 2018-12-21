
SECTIONS
{
    . = 4M + SIZEOF_HEADERS;
   
    _TEXT_START = .;
    .text : { *(.init) *(.text) *(.text.*) }
    _TEXT_END = .;    

    _DATA_START = .;
    . = ALIGN(4K);
    .data : { 
           *(.data) 
           exception_table_start = .;
           *(.data.ex)
           exception_table_end = .;
     }
    
    . = ALIGN(4K);
    .rodata : { *(.rodata) }
    
    . = ALIGN(4K);
    .bss : { *(.bss) }
    
    . = ALIGN(4K);
    .benchmarks :
    {
        . = ALIGN(8);
        _BENCHMARKS_START = .;
        KEEP(*(.benchmarks));
        _BENCHMARKS_END = .;
    }
    _DATA_END = .;

    . = ALIGN(4k);
    _HEAP_START = .;

}

ENTRY(entry)

