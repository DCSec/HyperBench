#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "rdtsc.h"
#include <sys/time.h>

#define STR_BENCHMARK_BEGIN "[BENCHMARKS BEGIN]\r\n"
#define STR_BENCHMARK_END   "[BENCHMARKS END]\r\n"


typedef unsigned long long int uint64_t;

static char read_symbol()
{
    while(1){
        char c = fgetc(stdin);

        switch(c) {
            case '[':
            case '{':
            case '*':
                return c;
            default:
                return 0;
        }
    }
}

int read_start(const char *str)
{
    char *lineptr = NULL;
    size_t lineptrsize = 0;
    while(1)
    {
        if(getline(&lineptr, &lineptrsize, stdin) < 0) return 1;
        if(!strcmp(str, lineptr)) { break; } 
    }
    free(lineptr);
    printf("%s", str);
   
    return 0; 
}


static char read_time_start_char()
{
    while(1){
        char c = fgetc(stdin);

        switch(c) {
            case '[':
            case '{':
                return c;
            default:
                return 0;
        }
    }
}

static char read_time_end_char(char target)
{
   while(1){
        char c = fgetc(stdin);
        if(c == target) return target;
    } 
}


int read_benchmark()
{
    char category[128];
    char benchmark[128];
    uint64_t iterations;

    //if(fscanf(stdin, "%s -> %s %llx ", category, benchmark, &iterations) != 3) return 1;
    if(fscanf(stdin, "%s%s%lld ", category, benchmark, &iterations) != 3) return 1;
    printf("%-15s%-20s%-15llu", category, benchmark, iterations);
    
    return 0;

}

static char* do_command(const char *cmd)
{
    FILE *f;
    
    static char buf[512];
    
    f = popen(cmd, "r");
    if(!f)
        return 0;
    fread(buf, sizeof(char), sizeof(buf),f);
    pclose(f);
    printf("PIN:%s\n",buf);
    return buf;
}

int main(int argc, void **arg)
{
    unsigned cycles_low, cycles_high, cycles_low1, cycles_high1;
    unsigned cycles_low2, cycles_high2, cycles_low3, cycles_high3;
    uint64_t start, end, start1, end1;
    uint64_t time_control, time_kernel;
    char time_start_char, time_end_char;

    char str[128];    



    /* pin each VCPU to a specific PCPU */
//    if(read_symbol() == '*'){
//       do_command("./script/pin"); 
//    }
    if(!read_start("*\r\n")){
       do_command("./script/pin"); 
    }
    

    if(!read_start(STR_BENCHMARK_BEGIN)) {
        
        printf("%-15s%-20s%-15s%-15s%-15s%s\r\n", "category", "benchmark", "iterations","control-time","kernel-time","cycles");
        
        while(!read_benchmark()){
 
            time_start_char = read_time_start_char();
            if(time_start_char == '{') {
                before(cycles_low, cycles_high);
		//rdtsc(cycles_low, cycles_high);
                time_end_char = read_time_end_char('}');
                after(cycles_low1, cycles_high1);
		//rdtsc(cycles_low1, cycles_high1);
            }
        
            time_start_char = read_time_start_char();
            if(time_start_char == '['){
                before(cycles_low2, cycles_high2);
		//rdtsc(cycles_low2, cycles_high2);
                time_end_char = read_time_end_char(']');
                after(cycles_low3, cycles_high3);
		//rdtsc(cycles_low3, cycles_high3);
            }

            start = ( ((uint64_t)cycles_high << 32) | cycles_low );
            end = ( ((uint64_t)cycles_high1 << 32) | cycles_low1 );
            start1 = ( ((uint64_t)cycles_high2 << 32) | cycles_low2 );
            end1 = ( ((uint64_t)cycles_high3 << 32) | cycles_low3 );
            time_control = (end - start);
            time_kernel = (end1 - start1);
            printf("%-15llu", time_control);
            printf("%-15llu", time_kernel);
            printf("%lld\r\n", time_kernel - time_control);
        }

    }
    /* waiting until finished */
    read_start(STR_BENCHMARK_END);
    //printf("%s\n",str);
}


