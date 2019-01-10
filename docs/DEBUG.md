# Debug HyperBench with gdb
Command
- c: continue
- n: next instruction
- break xxx: add a breakpoint at xxx

Terminal 1
```
# qemu-system-x86_64 -kernel out/hyperbench.32 -nographic -m 512 -s -S
```
Terminal 2
```
# gdb
(gdb) file ./out/vmmbench
(gdb) target remote:1234
(gdb) break start32
(gdb) info register				[查看所有寄存器内容]
(gdb) break main 			[报错，进入保护模式需要重新连接]
(gdb) disconnect
(gdb) set arch i386:x86-64:intel
(gdb) target remote:1234
(gdb) p/x [args]		[显示变量内容]
```


