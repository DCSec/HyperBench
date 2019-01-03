
#ifndef __DEFS_H
#define __DEFS_H

#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>
#include <string.h>
#include "types.h"

#define __BARE_METAL

#define __unused __attribute__((__unused__))

#define MIN(a, b)		((a) < (b) ? (a) : (b))
#define MAX(a, b)		((a) > (b) ? (a) : (b))

//mp.c
void mpinit(void);

//proc.c
struct cpu*     mycpu(void);

//heap.c
void *heap_alloc_page();

//abort.c
extern void exit(int code);
extern void abort(void);

//apic.c
extern volatile uint*    lapic;
int             lapicid(void);
void mask_pic_interrupts(void);
void enable_apic(void);


//stack.c
extern void dump_stack(void);

//printf.c
extern void puts(const char *s);

extern int printf(const char *fmt, ...)
					__attribute__((format(printf, 1, 2)));
extern int snprintf(char *buf, int size, const char *fmt, ...)
					__attribute__((format(printf, 3, 4)));
extern int vsnprintf(char *buf, int size, const char *fmt, va_list va)
					__attribute__((format(printf, 3, 0)));
extern int vprintf(const char *fmt, va_list va)
					__attribute__((format(printf, 1, 0)));

/*
 * One byte per bit, a ' between each group of 4 bits, and a null terminator.
 */
#define BINSTR_SZ (sizeof(unsigned long) * 8 + sizeof(unsigned long) * 2)
void binstr(unsigned long x, char out[BINSTR_SZ]);
void print_binstr(unsigned long x);

#define assert(cond)							\
do {									\
	if (!(cond)) {							\
		printf("%s:%d: assert failed: %s\n",			\
		       __FILE__, __LINE__, #cond);			\
		dump_stack();						\
		abort();						\
	}								\
} while (0)

//string.c
long atol(const char *ptr);

// console.c
void console_init(void);
void console_putc(char ch);
void console_puts(const char *buf);

#endif

