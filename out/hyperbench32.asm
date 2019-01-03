
/opt/HyperBench/out/hyperbench.32:     file format elf32-i386


Disassembly of section .text:

004000b0 <_TEXT_START>:
  4000b0:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  4000b6:	00 00                	add    %al,(%eax)
  4000b8:	fe 4f 52             	decb   0x52(%edi)
  4000bb:	e4 89                	in     $0x89,%al

004000bc <entry>:
  4000bc:	89 1d 08 40 40 00    	mov    %ebx,0x404008
  4000c2:	a3 10 40 40 00       	mov    %eax,0x404010
  4000c7:	bc 00 f0 44 00       	mov    $0x44f000,%esp
  4000cc:	e8 07 00 00 00       	call   4000d8 <prepare_64>
  4000d1:	ea 0d 01 40 00 08 00 	ljmp   $0x8,$0x40010d

004000d8 <prepare_64>:
  4000d8:	0f 01 15 00 b0 40 00 	lgdtl  0x40b000

004000df <enter_long_mode>:
  4000df:	0f 20 e0             	mov    %cr4,%eax
  4000e2:	0f ba e8 05          	bts    $0x5,%eax
  4000e6:	0f 22 e0             	mov    %eax,%cr4
  4000e9:	a1 00 40 40 00       	mov    0x404000,%eax
  4000ee:	0f 22 d8             	mov    %eax,%cr3
  4000f1:	b9 80 00 00 c0       	mov    $0xc0000080,%ecx
  4000f6:	0f 32                	rdmsr  
  4000f8:	0f ba e8 08          	bts    $0x8,%eax
  4000fc:	0f 30                	wrmsr  
  4000fe:	0f 20 c0             	mov    %cr0,%eax
  400101:	0f ba e8 00          	bts    $0x0,%eax
  400105:	0f ba e8 1f          	bts    $0x1f,%eax
  400109:	0f 22 c0             	mov    %eax,%cr0
  40010c:	c3                   	ret    

0040010d <start64>:
  40010d:	48                   	dec    %eax
  40010e:	8b 1d f4 3e 00 00    	mov    0x3ef4,%ebx
  400114:	48                   	dec    %eax
  400115:	89 df                	mov    %ebx,%edi
  400117:	48                   	dec    %eax
  400118:	8b 1d f2 3e 00 00    	mov    0x3ef2,%ebx
  40011e:	48                   	dec    %eax
  40011f:	89 de                	mov    %ebx,%esi
  400121:	e8 59 2f 00 00       	call   40307f <main>

00400126 <smp_stacktop>:
  400126:	00 00                	add    %al,(%eax)
  400128:	0a 00                	or     (%eax),%al

0040012a <sipi_entry>:
  40012a:	0f 20 c0             	mov    %cr0,%eax
  40012d:	66 83 c8 01          	or     $0x1,%ax
  400131:	0f 22 c0             	mov    %eax,%cr0
  400134:	66 0f 01 16          	lgdtw  (%esi)
  400138:	18 00                	sbb    %al,(%eax)
  40013a:	66 ea 60 01 40 00    	ljmpw  $0x40,$0x160
  400140:	08 00                	or     %al,(%eax)

00400142 <gdt32_descr>:
  400142:	17                   	pop    %ss
  400143:	00 48 01             	add    %cl,0x1(%eax)
  400146:	40                   	inc    %eax
	...

00400148 <gdt32>:
	...
  400150:	ff                   	(bad)  
  400151:	ff 00                	incl   (%eax)
  400153:	00 00                	add    %al,(%eax)
  400155:	9b                   	fwait
  400156:	cf                   	iret   
  400157:	00 ff                	add    %bh,%bh
  400159:	ff 00                	incl   (%eax)
  40015b:	00 00                	add    %al,(%eax)
  40015d:	93                   	xchg   %eax,%ebx
  40015e:	cf                   	iret   
	...

00400160 <ap_start32>:
  400160:	66 b8 10 00          	mov    $0x10,%ax
  400164:	8e d8                	mov    %eax,%ds
  400166:	8e c0                	mov    %eax,%es
  400168:	8e e0                	mov    %eax,%fs
  40016a:	8e e8                	mov    %eax,%gs
  40016c:	8e d0                	mov    %eax,%ss
  40016e:	bc 00 f0 ff ff       	mov    $0xfffff000,%esp
  400173:	f0 0f c1 25 26 01 40 	lock xadd %esp,0x400126
  40017a:	00 
  40017b:	e8 58 ff ff ff       	call   4000d8 <prepare_64>
  400180:	ea 87 01 40 00 08 00 	ljmp   $0x8,$0x400187

00400187 <ap_start64>:
  400187:	e8 62 2f 00 00       	call   4030ee <mpenter>
  40018c:	f4                   	hlt    
  40018d:	eb fd                	jmp    40018c <ap_start64+0x5>

0040018f <sipi_entry_mov>:
  40018f:	fc                   	cld    
  400190:	48                   	dec    %eax
  400191:	8d 34 25 2a 01 40 00 	lea    0x40012a(,%eiz,1),%esi
  400198:	48                   	dec    %eax
  400199:	31 ff                	xor    %edi,%edi
  40019b:	48                   	dec    %eax
  40019c:	c7 c1 36 00 00 00    	mov    $0x36,%ecx
  4001a2:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  4001a4:	e8 5b 30 00 00       	call   403204 <DEBUG>
  4001a9:	c3                   	ret    

004001aa <addchar>:
    int npad;
    bool alternate;
} strprops_t;

static void addchar(pstream_t *p, char c)
{
  4001aa:	55                   	push   %ebp
  4001ab:	48                   	dec    %eax
  4001ac:	89 e5                	mov    %esp,%ebp
  4001ae:	48                   	dec    %eax
  4001af:	83 ec 0c             	sub    $0xc,%esp
  4001b2:	48                   	dec    %eax
  4001b3:	89 7d f8             	mov    %edi,-0x8(%ebp)
  4001b6:	89 f0                	mov    %esi,%eax
  4001b8:	88 45 f4             	mov    %al,-0xc(%ebp)
    if (p->remain) {
  4001bb:	48                   	dec    %eax
  4001bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  4001bf:	8b 40 08             	mov    0x8(%eax),%eax
  4001c2:	85 c0                	test   %eax,%eax
  4001c4:	74 29                	je     4001ef <addchar+0x45>
	*p->buffer++ = c;
  4001c6:	48                   	dec    %eax
  4001c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  4001ca:	48                   	dec    %eax
  4001cb:	8b 00                	mov    (%eax),%eax
  4001cd:	48                   	dec    %eax
  4001ce:	8d 48 01             	lea    0x1(%eax),%ecx
  4001d1:	48                   	dec    %eax
  4001d2:	8b 55 f8             	mov    -0x8(%ebp),%edx
  4001d5:	48                   	dec    %eax
  4001d6:	89 0a                	mov    %ecx,(%edx)
  4001d8:	0f b6 55 f4          	movzbl -0xc(%ebp),%edx
  4001dc:	88 10                	mov    %dl,(%eax)
	--p->remain;
  4001de:	48                   	dec    %eax
  4001df:	8b 45 f8             	mov    -0x8(%ebp),%eax
  4001e2:	8b 40 08             	mov    0x8(%eax),%eax
  4001e5:	8d 50 ff             	lea    -0x1(%eax),%edx
  4001e8:	48                   	dec    %eax
  4001e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  4001ec:	89 50 08             	mov    %edx,0x8(%eax)
    }
    ++p->added;
  4001ef:	48                   	dec    %eax
  4001f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  4001f3:	8b 40 0c             	mov    0xc(%eax),%eax
  4001f6:	8d 50 01             	lea    0x1(%eax),%edx
  4001f9:	48                   	dec    %eax
  4001fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  4001fd:	89 50 0c             	mov    %edx,0xc(%eax)
}
  400200:	c9                   	leave  
  400201:	c3                   	ret    

00400202 <print_str>:

static void print_str(pstream_t *p, const char *s, strprops_t props)
{
  400202:	55                   	push   %ebp
  400203:	48                   	dec    %eax
  400204:	89 e5                	mov    %esp,%ebp
  400206:	53                   	push   %ebx
  400207:	48                   	dec    %eax
  400208:	83 ec 38             	sub    $0x38,%esp
  40020b:	48                   	dec    %eax
  40020c:	89 7d d8             	mov    %edi,-0x28(%ebp)
  40020f:	48                   	dec    %eax
  400210:	89 75 d0             	mov    %esi,-0x30(%ebp)
  400213:	89 c8                	mov    %ecx,%eax
  400215:	48                   	dec    %eax
  400216:	89 55 c0             	mov    %edx,-0x40(%ebp)
  400219:	89 45 c8             	mov    %eax,-0x38(%ebp)
    const char *s_orig = s;
  40021c:	48                   	dec    %eax
  40021d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  400220:	48                   	dec    %eax
  400221:	89 45 e0             	mov    %eax,-0x20(%ebp)
    int npad = props.npad;
  400224:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  400227:	89 45 ec             	mov    %eax,-0x14(%ebp)

    if (npad > 0) {
  40022a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  40022e:	7e 37                	jle    400267 <print_str+0x65>
	npad -= strlen(s_orig);
  400230:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  400233:	48                   	dec    %eax
  400234:	8b 45 e0             	mov    -0x20(%ebp),%eax
  400237:	48                   	dec    %eax
  400238:	89 c7                	mov    %eax,%edi
  40023a:	e8 a8 0c 00 00       	call   400ee7 <strlen>
  40023f:	29 c3                	sub    %eax,%ebx
  400241:	89 d8                	mov    %ebx,%eax
  400243:	89 45 ec             	mov    %eax,-0x14(%ebp)
	while (npad > 0) {
  400246:	eb 19                	jmp    400261 <print_str+0x5f>
	    addchar(p, props.pad);
  400248:	0f b6 45 c0          	movzbl -0x40(%ebp),%eax
  40024c:	0f be d0             	movsbl %al,%edx
  40024f:	48                   	dec    %eax
  400250:	8b 45 d8             	mov    -0x28(%ebp),%eax
  400253:	89 d6                	mov    %edx,%esi
  400255:	48                   	dec    %eax
  400256:	89 c7                	mov    %eax,%edi
  400258:	e8 4d ff ff ff       	call   4001aa <addchar>
	    --npad;
  40025d:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    const char *s_orig = s;
    int npad = props.npad;

    if (npad > 0) {
	npad -= strlen(s_orig);
	while (npad > 0) {
  400261:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  400265:	7f e1                	jg     400248 <print_str+0x46>
	    addchar(p, props.pad);
	    --npad;
	}
    }

    while (*s)
  400267:	eb 20                	jmp    400289 <print_str+0x87>
	addchar(p, *s++);
  400269:	48                   	dec    %eax
  40026a:	8b 45 d0             	mov    -0x30(%ebp),%eax
  40026d:	48                   	dec    %eax
  40026e:	8d 50 01             	lea    0x1(%eax),%edx
  400271:	48                   	dec    %eax
  400272:	89 55 d0             	mov    %edx,-0x30(%ebp)
  400275:	0f b6 00             	movzbl (%eax),%eax
  400278:	0f be d0             	movsbl %al,%edx
  40027b:	48                   	dec    %eax
  40027c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  40027f:	89 d6                	mov    %edx,%esi
  400281:	48                   	dec    %eax
  400282:	89 c7                	mov    %eax,%edi
  400284:	e8 21 ff ff ff       	call   4001aa <addchar>
	    addchar(p, props.pad);
	    --npad;
	}
    }

    while (*s)
  400289:	48                   	dec    %eax
  40028a:	8b 45 d0             	mov    -0x30(%ebp),%eax
  40028d:	0f b6 00             	movzbl (%eax),%eax
  400290:	84 c0                	test   %al,%al
  400292:	75 d5                	jne    400269 <print_str+0x67>
	addchar(p, *s++);

    if (npad < 0) {
  400294:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  400298:	79 3b                	jns    4002d5 <print_str+0xd3>
	props.pad = ' '; /* ignore '0' flag with '-' flag */
  40029a:	c6 45 c0 20          	movb   $0x20,-0x40(%ebp)
	npad += strlen(s_orig);
  40029e:	48                   	dec    %eax
  40029f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  4002a2:	48                   	dec    %eax
  4002a3:	89 c7                	mov    %eax,%edi
  4002a5:	e8 3d 0c 00 00       	call   400ee7 <strlen>
  4002aa:	89 c2                	mov    %eax,%edx
  4002ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
  4002af:	01 d0                	add    %edx,%eax
  4002b1:	89 45 ec             	mov    %eax,-0x14(%ebp)
	while (npad < 0) {
  4002b4:	eb 19                	jmp    4002cf <print_str+0xcd>
	    addchar(p, props.pad);
  4002b6:	0f b6 45 c0          	movzbl -0x40(%ebp),%eax
  4002ba:	0f be d0             	movsbl %al,%edx
  4002bd:	48                   	dec    %eax
  4002be:	8b 45 d8             	mov    -0x28(%ebp),%eax
  4002c1:	89 d6                	mov    %edx,%esi
  4002c3:	48                   	dec    %eax
  4002c4:	89 c7                	mov    %eax,%edi
  4002c6:	e8 df fe ff ff       	call   4001aa <addchar>
	    ++npad;
  4002cb:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
	addchar(p, *s++);

    if (npad < 0) {
	props.pad = ' '; /* ignore '0' flag with '-' flag */
	npad += strlen(s_orig);
	while (npad < 0) {
  4002cf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  4002d3:	78 e1                	js     4002b6 <print_str+0xb4>
	    addchar(p, props.pad);
	    ++npad;
	}
    }
}
  4002d5:	48                   	dec    %eax
  4002d6:	83 c4 38             	add    $0x38,%esp
  4002d9:	5b                   	pop    %ebx
  4002da:	5d                   	pop    %ebp
  4002db:	c3                   	ret    

004002dc <print_int>:

static char digits[16] = "0123456789abcdef";

static void print_int(pstream_t *ps, long long n, int base, strprops_t props)
{
  4002dc:	55                   	push   %ebp
  4002dd:	48                   	dec    %eax
  4002de:	89 e5                	mov    %esp,%ebp
  4002e0:	53                   	push   %ebx
  4002e1:	48                   	dec    %eax
  4002e2:	83 ec 68             	sub    $0x68,%esp
  4002e5:	48                   	dec    %eax
  4002e6:	89 7d b8             	mov    %edi,-0x48(%ebp)
  4002e9:	48                   	dec    %eax
  4002ea:	89 75 b0             	mov    %esi,-0x50(%ebp)
  4002ed:	89 55 ac             	mov    %edx,-0x54(%ebp)
  4002f0:	48                   	dec    %eax
  4002f1:	89 c8                	mov    %ecx,%eax
  4002f3:	44                   	inc    %esp
  4002f4:	89 c2                	mov    %eax,%edx
  4002f6:	48                   	dec    %eax
  4002f7:	89 45 98             	mov    %eax,-0x68(%ebp)
  4002fa:	89 55 a0             	mov    %edx,-0x60(%ebp)
    char buf[sizeof(long) * 3 + 2], *p = buf;
  4002fd:	48                   	dec    %eax
  4002fe:	8d 45 c5             	lea    -0x3b(%ebp),%eax
  400301:	48                   	dec    %eax
  400302:	89 45 e8             	mov    %eax,-0x18(%ebp)
    int s = 0, i;
  400305:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

    if (n < 0) {
  40030c:	48                   	dec    %eax
  40030d:	83 7d b0 00          	cmpl   $0x0,-0x50(%ebp)
  400311:	79 0d                	jns    400320 <print_int+0x44>
	n = -n;
  400313:	48                   	dec    %eax
  400314:	f7 5d b0             	negl   -0x50(%ebp)
	s = 1;
  400317:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
    }

    while (n) {
  40031e:	eb 3c                	jmp    40035c <print_int+0x80>
  400320:	eb 3a                	jmp    40035c <print_int+0x80>
	*p++ = digits[n % base];
  400322:	48                   	dec    %eax
  400323:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  400326:	48                   	dec    %eax
  400327:	8d 41 01             	lea    0x1(%ecx),%eax
  40032a:	48                   	dec    %eax
  40032b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  40032e:	8b 45 ac             	mov    -0x54(%ebp),%eax
  400331:	48                   	dec    %eax
  400332:	63 f0                	arpl   %si,%ax
  400334:	48                   	dec    %eax
  400335:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400338:	48                   	dec    %eax
  400339:	99                   	cltd   
  40033a:	48                   	dec    %eax
  40033b:	f7 fe                	idiv   %esi
  40033d:	48                   	dec    %eax
  40033e:	89 d0                	mov    %edx,%eax
  400340:	0f b6 80 00 c0 40 00 	movzbl 0x40c000(%eax),%eax
  400347:	88 01                	mov    %al,(%ecx)
	n /= base;
  400349:	8b 45 ac             	mov    -0x54(%ebp),%eax
  40034c:	48                   	dec    %eax
  40034d:	63 d8                	arpl   %bx,%ax
  40034f:	48                   	dec    %eax
  400350:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400353:	48                   	dec    %eax
  400354:	99                   	cltd   
  400355:	48                   	dec    %eax
  400356:	f7 fb                	idiv   %ebx
  400358:	48                   	dec    %eax
  400359:	89 45 b0             	mov    %eax,-0x50(%ebp)
    if (n < 0) {
	n = -n;
	s = 1;
    }

    while (n) {
  40035c:	48                   	dec    %eax
  40035d:	83 7d b0 00          	cmpl   $0x0,-0x50(%ebp)
  400361:	75 bf                	jne    400322 <print_int+0x46>
	*p++ = digits[n % base];
	n /= base;
    }

    if (s)
  400363:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  400367:	74 0f                	je     400378 <print_int+0x9c>
	*p++ = '-';
  400369:	48                   	dec    %eax
  40036a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  40036d:	48                   	dec    %eax
  40036e:	8d 50 01             	lea    0x1(%eax),%edx
  400371:	48                   	dec    %eax
  400372:	89 55 e8             	mov    %edx,-0x18(%ebp)
  400375:	c6 00 2d             	movb   $0x2d,(%eax)

    if (p == buf)
  400378:	48                   	dec    %eax
  400379:	8d 45 c5             	lea    -0x3b(%ebp),%eax
  40037c:	48                   	dec    %eax
  40037d:	39 45 e8             	cmp    %eax,-0x18(%ebp)
  400380:	75 0f                	jne    400391 <print_int+0xb5>
	*p++ = '0';
  400382:	48                   	dec    %eax
  400383:	8b 45 e8             	mov    -0x18(%ebp),%eax
  400386:	48                   	dec    %eax
  400387:	8d 50 01             	lea    0x1(%eax),%edx
  40038a:	48                   	dec    %eax
  40038b:	89 55 e8             	mov    %edx,-0x18(%ebp)
  40038e:	c6 00 30             	movb   $0x30,(%eax)

    for (i = 0; i < (p - buf) / 2; ++i) {
  400391:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  400398:	eb 41                	jmp    4003db <print_int+0xff>
	char tmp;

	tmp = buf[i];
  40039a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  40039d:	48                   	dec    %eax
  40039e:	98                   	cwtl   
  40039f:	0f b6 44 05 c5       	movzbl -0x3b(%ebp,%eax,1),%eax
  4003a4:	88 45 df             	mov    %al,-0x21(%ebp)
	buf[i] = p[-1-i];
  4003a7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  4003aa:	f7 d0                	not    %eax
  4003ac:	48                   	dec    %eax
  4003ad:	63 d0                	arpl   %dx,%ax
  4003af:	48                   	dec    %eax
  4003b0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4003b3:	48                   	dec    %eax
  4003b4:	01 d0                	add    %edx,%eax
  4003b6:	0f b6 10             	movzbl (%eax),%edx
  4003b9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  4003bc:	48                   	dec    %eax
  4003bd:	98                   	cwtl   
  4003be:	88 54 05 c5          	mov    %dl,-0x3b(%ebp,%eax,1)
	p[-1-i] = tmp;
  4003c2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  4003c5:	f7 d0                	not    %eax
  4003c7:	48                   	dec    %eax
  4003c8:	63 d0                	arpl   %dx,%ax
  4003ca:	48                   	dec    %eax
  4003cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4003ce:	48                   	dec    %eax
  4003cf:	01 c2                	add    %eax,%edx
  4003d1:	0f b6 45 df          	movzbl -0x21(%ebp),%eax
  4003d5:	88 02                	mov    %al,(%edx)
	*p++ = '-';

    if (p == buf)
	*p++ = '0';

    for (i = 0; i < (p - buf) / 2; ++i) {
  4003d7:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
  4003db:	8b 45 e0             	mov    -0x20(%ebp),%eax
  4003de:	48                   	dec    %eax
  4003df:	63 d0                	arpl   %dx,%ax
  4003e1:	48                   	dec    %eax
  4003e2:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  4003e5:	48                   	dec    %eax
  4003e6:	8d 45 c5             	lea    -0x3b(%ebp),%eax
  4003e9:	48                   	dec    %eax
  4003ea:	29 c1                	sub    %eax,%ecx
  4003ec:	48                   	dec    %eax
  4003ed:	89 c8                	mov    %ecx,%eax
  4003ef:	48                   	dec    %eax
  4003f0:	89 c1                	mov    %eax,%ecx
  4003f2:	48                   	dec    %eax
  4003f3:	c1 e9 3f             	shr    $0x3f,%ecx
  4003f6:	48                   	dec    %eax
  4003f7:	01 c8                	add    %ecx,%eax
  4003f9:	48                   	dec    %eax
  4003fa:	d1 f8                	sar    %eax
  4003fc:	48                   	dec    %eax
  4003fd:	39 c2                	cmp    %eax,%edx
  4003ff:	7c 99                	jl     40039a <print_int+0xbe>
	tmp = buf[i];
	buf[i] = p[-1-i];
	p[-1-i] = tmp;
    }

    *p = 0;
  400401:	48                   	dec    %eax
  400402:	8b 45 e8             	mov    -0x18(%ebp),%eax
  400405:	c6 00 00             	movb   $0x0,(%eax)

    print_str(ps, buf, props);
  400408:	48                   	dec    %eax
  400409:	8b 55 98             	mov    -0x68(%ebp),%edx
  40040c:	8b 4d a0             	mov    -0x60(%ebp),%ecx
  40040f:	48                   	dec    %eax
  400410:	8d 75 c5             	lea    -0x3b(%ebp),%esi
  400413:	48                   	dec    %eax
  400414:	8b 45 b8             	mov    -0x48(%ebp),%eax
  400417:	48                   	dec    %eax
  400418:	89 c7                	mov    %eax,%edi
  40041a:	e8 e3 fd ff ff       	call   400202 <print_str>
}
  40041f:	48                   	dec    %eax
  400420:	83 c4 68             	add    $0x68,%esp
  400423:	5b                   	pop    %ebx
  400424:	5d                   	pop    %ebp
  400425:	c3                   	ret    

00400426 <print_unsigned>:

static void print_unsigned(pstream_t *ps, unsigned long long n, int base,
			   strprops_t props)
{
  400426:	55                   	push   %ebp
  400427:	48                   	dec    %eax
  400428:	89 e5                	mov    %esp,%ebp
  40042a:	53                   	push   %ebx
  40042b:	48                   	dec    %eax
  40042c:	83 ec 68             	sub    $0x68,%esp
  40042f:	48                   	dec    %eax
  400430:	89 7d b8             	mov    %edi,-0x48(%ebp)
  400433:	48                   	dec    %eax
  400434:	89 75 b0             	mov    %esi,-0x50(%ebp)
  400437:	89 55 ac             	mov    %edx,-0x54(%ebp)
  40043a:	48                   	dec    %eax
  40043b:	89 c8                	mov    %ecx,%eax
  40043d:	44                   	inc    %esp
  40043e:	89 c2                	mov    %eax,%edx
  400440:	48                   	dec    %eax
  400441:	89 45 98             	mov    %eax,-0x68(%ebp)
  400444:	89 55 a0             	mov    %edx,-0x60(%ebp)
    char buf[sizeof(long) * 3 + 3], *p = buf;
  400447:	48                   	dec    %eax
  400448:	8d 45 c8             	lea    -0x38(%ebp),%eax
  40044b:	48                   	dec    %eax
  40044c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    int i;

    while (n) {
  40044f:	eb 40                	jmp    400491 <print_unsigned+0x6b>
	*p++ = digits[n % base];
  400451:	48                   	dec    %eax
  400452:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  400455:	48                   	dec    %eax
  400456:	8d 41 01             	lea    0x1(%ecx),%eax
  400459:	48                   	dec    %eax
  40045a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  40045d:	8b 45 ac             	mov    -0x54(%ebp),%eax
  400460:	48                   	dec    %eax
  400461:	63 f0                	arpl   %si,%ax
  400463:	48                   	dec    %eax
  400464:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400467:	ba 00 00 00 00       	mov    $0x0,%edx
  40046c:	48                   	dec    %eax
  40046d:	f7 f6                	div    %esi
  40046f:	48                   	dec    %eax
  400470:	89 d0                	mov    %edx,%eax
  400472:	0f b6 80 00 c0 40 00 	movzbl 0x40c000(%eax),%eax
  400479:	88 01                	mov    %al,(%ecx)
	n /= base;
  40047b:	8b 45 ac             	mov    -0x54(%ebp),%eax
  40047e:	48                   	dec    %eax
  40047f:	63 d8                	arpl   %bx,%ax
  400481:	48                   	dec    %eax
  400482:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400485:	ba 00 00 00 00       	mov    $0x0,%edx
  40048a:	48                   	dec    %eax
  40048b:	f7 f3                	div    %ebx
  40048d:	48                   	dec    %eax
  40048e:	89 45 b0             	mov    %eax,-0x50(%ebp)
			   strprops_t props)
{
    char buf[sizeof(long) * 3 + 3], *p = buf;
    int i;

    while (n) {
  400491:	48                   	dec    %eax
  400492:	83 7d b0 00          	cmpl   $0x0,-0x50(%ebp)
  400496:	75 b9                	jne    400451 <print_unsigned+0x2b>
	*p++ = digits[n % base];
	n /= base;
    }

    if (p == buf)
  400498:	48                   	dec    %eax
  400499:	8d 45 c8             	lea    -0x38(%ebp),%eax
  40049c:	48                   	dec    %eax
  40049d:	39 45 e8             	cmp    %eax,-0x18(%ebp)
  4004a0:	75 11                	jne    4004b3 <print_unsigned+0x8d>
	*p++ = '0';
  4004a2:	48                   	dec    %eax
  4004a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4004a6:	48                   	dec    %eax
  4004a7:	8d 50 01             	lea    0x1(%eax),%edx
  4004aa:	48                   	dec    %eax
  4004ab:	89 55 e8             	mov    %edx,-0x18(%ebp)
  4004ae:	c6 00 30             	movb   $0x30,(%eax)
  4004b1:	eb 72                	jmp    400525 <print_unsigned+0xff>
    else if (props.alternate && base == 16) {
  4004b3:	0f b6 45 a0          	movzbl -0x60(%ebp),%eax
  4004b7:	84 c0                	test   %al,%al
  4004b9:	74 6a                	je     400525 <print_unsigned+0xff>
  4004bb:	83 7d ac 10          	cmpl   $0x10,-0x54(%ebp)
  4004bf:	75 64                	jne    400525 <print_unsigned+0xff>
	if (props.pad == '0') {
  4004c1:	0f b6 45 98          	movzbl -0x68(%ebp),%eax
  4004c5:	3c 30                	cmp    $0x30,%al
  4004c7:	75 3e                	jne    400507 <print_unsigned+0xe1>
	    addchar(ps, '0');
  4004c9:	48                   	dec    %eax
  4004ca:	8b 45 b8             	mov    -0x48(%ebp),%eax
  4004cd:	be 30 00 00 00       	mov    $0x30,%esi
  4004d2:	48                   	dec    %eax
  4004d3:	89 c7                	mov    %eax,%edi
  4004d5:	e8 d0 fc ff ff       	call   4001aa <addchar>
	    addchar(ps, 'x');
  4004da:	48                   	dec    %eax
  4004db:	8b 45 b8             	mov    -0x48(%ebp),%eax
  4004de:	be 78 00 00 00       	mov    $0x78,%esi
  4004e3:	48                   	dec    %eax
  4004e4:	89 c7                	mov    %eax,%edi
  4004e6:	e8 bf fc ff ff       	call   4001aa <addchar>

	    if (props.npad > 0)
  4004eb:	8b 45 9c             	mov    -0x64(%ebp),%eax
  4004ee:	85 c0                	test   %eax,%eax
  4004f0:	7e 33                	jle    400525 <print_unsigned+0xff>
		props.npad = MAX(props.npad - 2, 0);
  4004f2:	8b 45 9c             	mov    -0x64(%ebp),%eax
  4004f5:	83 e8 02             	sub    $0x2,%eax
  4004f8:	ba 00 00 00 00       	mov    $0x0,%edx
  4004fd:	85 c0                	test   %eax,%eax
  4004ff:	0f 48 c2             	cmovs  %edx,%eax
  400502:	89 45 9c             	mov    %eax,-0x64(%ebp)
  400505:	eb 1e                	jmp    400525 <print_unsigned+0xff>
	} else {
	    *p++ = 'x';
  400507:	48                   	dec    %eax
  400508:	8b 45 e8             	mov    -0x18(%ebp),%eax
  40050b:	48                   	dec    %eax
  40050c:	8d 50 01             	lea    0x1(%eax),%edx
  40050f:	48                   	dec    %eax
  400510:	89 55 e8             	mov    %edx,-0x18(%ebp)
  400513:	c6 00 78             	movb   $0x78,(%eax)
	    *p++ = '0';
  400516:	48                   	dec    %eax
  400517:	8b 45 e8             	mov    -0x18(%ebp),%eax
  40051a:	48                   	dec    %eax
  40051b:	8d 50 01             	lea    0x1(%eax),%edx
  40051e:	48                   	dec    %eax
  40051f:	89 55 e8             	mov    %edx,-0x18(%ebp)
  400522:	c6 00 30             	movb   $0x30,(%eax)
	}
    }

    for (i = 0; i < (p - buf) / 2; ++i) {
  400525:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  40052c:	eb 41                	jmp    40056f <print_unsigned+0x149>
	char tmp;

	tmp = buf[i];
  40052e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  400531:	48                   	dec    %eax
  400532:	98                   	cwtl   
  400533:	0f b6 44 05 c8       	movzbl -0x38(%ebp,%eax,1),%eax
  400538:	88 45 e3             	mov    %al,-0x1d(%ebp)
	buf[i] = p[-1-i];
  40053b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  40053e:	f7 d0                	not    %eax
  400540:	48                   	dec    %eax
  400541:	63 d0                	arpl   %dx,%ax
  400543:	48                   	dec    %eax
  400544:	8b 45 e8             	mov    -0x18(%ebp),%eax
  400547:	48                   	dec    %eax
  400548:	01 d0                	add    %edx,%eax
  40054a:	0f b6 10             	movzbl (%eax),%edx
  40054d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  400550:	48                   	dec    %eax
  400551:	98                   	cwtl   
  400552:	88 54 05 c8          	mov    %dl,-0x38(%ebp,%eax,1)
	p[-1-i] = tmp;
  400556:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  400559:	f7 d0                	not    %eax
  40055b:	48                   	dec    %eax
  40055c:	63 d0                	arpl   %dx,%ax
  40055e:	48                   	dec    %eax
  40055f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  400562:	48                   	dec    %eax
  400563:	01 c2                	add    %eax,%edx
  400565:	0f b6 45 e3          	movzbl -0x1d(%ebp),%eax
  400569:	88 02                	mov    %al,(%edx)
	    *p++ = 'x';
	    *p++ = '0';
	}
    }

    for (i = 0; i < (p - buf) / 2; ++i) {
  40056b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
  40056f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  400572:	48                   	dec    %eax
  400573:	63 d0                	arpl   %dx,%ax
  400575:	48                   	dec    %eax
  400576:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  400579:	48                   	dec    %eax
  40057a:	8d 45 c8             	lea    -0x38(%ebp),%eax
  40057d:	48                   	dec    %eax
  40057e:	29 c1                	sub    %eax,%ecx
  400580:	48                   	dec    %eax
  400581:	89 c8                	mov    %ecx,%eax
  400583:	48                   	dec    %eax
  400584:	89 c1                	mov    %eax,%ecx
  400586:	48                   	dec    %eax
  400587:	c1 e9 3f             	shr    $0x3f,%ecx
  40058a:	48                   	dec    %eax
  40058b:	01 c8                	add    %ecx,%eax
  40058d:	48                   	dec    %eax
  40058e:	d1 f8                	sar    %eax
  400590:	48                   	dec    %eax
  400591:	39 c2                	cmp    %eax,%edx
  400593:	7c 99                	jl     40052e <print_unsigned+0x108>
	tmp = buf[i];
	buf[i] = p[-1-i];
	p[-1-i] = tmp;
    }

    *p = 0;
  400595:	48                   	dec    %eax
  400596:	8b 45 e8             	mov    -0x18(%ebp),%eax
  400599:	c6 00 00             	movb   $0x0,(%eax)

    print_str(ps, buf, props);
  40059c:	48                   	dec    %eax
  40059d:	8b 55 98             	mov    -0x68(%ebp),%edx
  4005a0:	8b 4d a0             	mov    -0x60(%ebp),%ecx
  4005a3:	48                   	dec    %eax
  4005a4:	8d 75 c8             	lea    -0x38(%ebp),%esi
  4005a7:	48                   	dec    %eax
  4005a8:	8b 45 b8             	mov    -0x48(%ebp),%eax
  4005ab:	48                   	dec    %eax
  4005ac:	89 c7                	mov    %eax,%edi
  4005ae:	e8 4f fc ff ff       	call   400202 <print_str>
}
  4005b3:	48                   	dec    %eax
  4005b4:	83 c4 68             	add    $0x68,%esp
  4005b7:	5b                   	pop    %ebx
  4005b8:	5d                   	pop    %ebp
  4005b9:	c3                   	ret    

004005ba <fmtnum>:

static int fmtnum(const char **fmt)
{
  4005ba:	55                   	push   %ebp
  4005bb:	48                   	dec    %eax
  4005bc:	89 e5                	mov    %esp,%ebp
  4005be:	48                   	dec    %eax
  4005bf:	83 ec 20             	sub    $0x20,%esp
  4005c2:	48                   	dec    %eax
  4005c3:	89 7d e8             	mov    %edi,-0x18(%ebp)
    const char *f = *fmt;
  4005c6:	48                   	dec    %eax
  4005c7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4005ca:	48                   	dec    %eax
  4005cb:	8b 00                	mov    (%eax),%eax
  4005cd:	48                   	dec    %eax
  4005ce:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int len = 0, num;
  4005d1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    if (*f == '-')
  4005d8:	48                   	dec    %eax
  4005d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  4005dc:	0f b6 00             	movzbl (%eax),%eax
  4005df:	3c 2d                	cmp    $0x2d,%al
  4005e1:	75 0b                	jne    4005ee <fmtnum+0x34>
	++f, ++len;
  4005e3:	48                   	dec    %eax
  4005e4:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  4005e8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

    while (*f >= '0' && *f <= '9')
  4005ec:	eb 0b                	jmp    4005f9 <fmtnum+0x3f>
  4005ee:	eb 09                	jmp    4005f9 <fmtnum+0x3f>
	++f, ++len;
  4005f0:	48                   	dec    %eax
  4005f1:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  4005f5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    int len = 0, num;

    if (*f == '-')
	++f, ++len;

    while (*f >= '0' && *f <= '9')
  4005f9:	48                   	dec    %eax
  4005fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  4005fd:	0f b6 00             	movzbl (%eax),%eax
  400600:	3c 2f                	cmp    $0x2f,%al
  400602:	7e 0b                	jle    40060f <fmtnum+0x55>
  400604:	48                   	dec    %eax
  400605:	8b 45 f8             	mov    -0x8(%ebp),%eax
  400608:	0f b6 00             	movzbl (%eax),%eax
  40060b:	3c 39                	cmp    $0x39,%al
  40060d:	7e e1                	jle    4005f0 <fmtnum+0x36>
	++f, ++len;

    num = atol(*fmt);
  40060f:	48                   	dec    %eax
  400610:	8b 45 e8             	mov    -0x18(%ebp),%eax
  400613:	48                   	dec    %eax
  400614:	8b 00                	mov    (%eax),%eax
  400616:	48                   	dec    %eax
  400617:	89 c7                	mov    %eax,%edi
  400619:	e8 e4 0c 00 00       	call   401302 <atol>
  40061e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    *fmt += len;
  400621:	48                   	dec    %eax
  400622:	8b 45 e8             	mov    -0x18(%ebp),%eax
  400625:	48                   	dec    %eax
  400626:	8b 10                	mov    (%eax),%edx
  400628:	8b 45 f4             	mov    -0xc(%ebp),%eax
  40062b:	48                   	dec    %eax
  40062c:	98                   	cwtl   
  40062d:	48                   	dec    %eax
  40062e:	01 c2                	add    %eax,%edx
  400630:	48                   	dec    %eax
  400631:	8b 45 e8             	mov    -0x18(%ebp),%eax
  400634:	48                   	dec    %eax
  400635:	89 10                	mov    %edx,(%eax)
    return num;
  400637:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  40063a:	c9                   	leave  
  40063b:	c3                   	ret    

0040063c <vsnprintf>:

int vsnprintf(char *buf, int size, const char *fmt, va_list va)
{
  40063c:	55                   	push   %ebp
  40063d:	48                   	dec    %eax
  40063e:	89 e5                	mov    %esp,%ebp
  400640:	48                   	dec    %eax
  400641:	83 ec 50             	sub    $0x50,%esp
  400644:	48                   	dec    %eax
  400645:	89 7d c8             	mov    %edi,-0x38(%ebp)
  400648:	89 75 c4             	mov    %esi,-0x3c(%ebp)
  40064b:	48                   	dec    %eax
  40064c:	89 55 b8             	mov    %edx,-0x48(%ebp)
  40064f:	48                   	dec    %eax
  400650:	89 4d b0             	mov    %ecx,-0x50(%ebp)
    pstream_t s;

    s.buffer = buf;
  400653:	48                   	dec    %eax
  400654:	8b 45 c8             	mov    -0x38(%ebp),%eax
  400657:	48                   	dec    %eax
  400658:	89 45 e8             	mov    %eax,-0x18(%ebp)
    s.remain = size - 1;
  40065b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  40065e:	83 e8 01             	sub    $0x1,%eax
  400661:	89 45 f0             	mov    %eax,-0x10(%ebp)
    s.added = 0;
  400664:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (*fmt) {
  40066b:	e9 2c 06 00 00       	jmp    400c9c <vsnprintf+0x660>
	char f = *fmt++;
  400670:	48                   	dec    %eax
  400671:	8b 45 b8             	mov    -0x48(%ebp),%eax
  400674:	48                   	dec    %eax
  400675:	8d 50 01             	lea    0x1(%eax),%edx
  400678:	48                   	dec    %eax
  400679:	89 55 b8             	mov    %edx,-0x48(%ebp)
  40067c:	0f b6 00             	movzbl (%eax),%eax
  40067f:	88 45 fb             	mov    %al,-0x5(%ebp)
	int nlong = 0;
  400682:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	strprops_t props;
	memset(&props, 0, sizeof(props));
  400689:	48                   	dec    %eax
  40068a:	8d 45 dc             	lea    -0x24(%ebp),%eax
  40068d:	ba 0c 00 00 00       	mov    $0xc,%edx
  400692:	be 00 00 00 00       	mov    $0x0,%esi
  400697:	48                   	dec    %eax
  400698:	89 c7                	mov    %eax,%edi
  40069a:	e8 52 0a 00 00       	call   4010f1 <memset>
	props.pad = ' ';
  40069f:	c6 45 dc 20          	movb   $0x20,-0x24(%ebp)

	if (f != '%') {
  4006a3:	80 7d fb 25          	cmpb   $0x25,-0x5(%ebp)
  4006a7:	74 17                	je     4006c0 <vsnprintf+0x84>
	    addchar(&s, f);
  4006a9:	0f be 55 fb          	movsbl -0x5(%ebp),%edx
  4006ad:	48                   	dec    %eax
  4006ae:	8d 45 e8             	lea    -0x18(%ebp),%eax
  4006b1:	89 d6                	mov    %edx,%esi
  4006b3:	48                   	dec    %eax
  4006b4:	89 c7                	mov    %eax,%edi
  4006b6:	e8 ef fa ff ff       	call   4001aa <addchar>
  4006bb:	e9 dc 05 00 00       	jmp    400c9c <vsnprintf+0x660>
	    continue;
	}
    morefmt:
	f = *fmt++;
  4006c0:	48                   	dec    %eax
  4006c1:	8b 45 b8             	mov    -0x48(%ebp),%eax
  4006c4:	48                   	dec    %eax
  4006c5:	8d 50 01             	lea    0x1(%eax),%edx
  4006c8:	48                   	dec    %eax
  4006c9:	89 55 b8             	mov    %edx,-0x48(%ebp)
  4006cc:	0f b6 00             	movzbl (%eax),%eax
  4006cf:	88 45 fb             	mov    %al,-0x5(%ebp)
	switch (f) {
  4006d2:	0f be 45 fb          	movsbl -0x5(%ebp),%eax
  4006d6:	83 f8 7a             	cmp    $0x7a,%eax
  4006d9:	0f 87 aa 05 00 00    	ja     400c89 <vsnprintf+0x64d>
  4006df:	89 c0                	mov    %eax,%eax
  4006e1:	48                   	dec    %eax
  4006e2:	8b 04 c5 00 d0 40 00 	mov    0x40d000(,%eax,8),%eax
  4006e9:	ff e0                	jmp    *%eax
	case '%':
	    addchar(&s, '%');
  4006eb:	48                   	dec    %eax
  4006ec:	8d 45 e8             	lea    -0x18(%ebp),%eax
  4006ef:	be 25 00 00 00       	mov    $0x25,%esi
  4006f4:	48                   	dec    %eax
  4006f5:	89 c7                	mov    %eax,%edi
  4006f7:	e8 ae fa ff ff       	call   4001aa <addchar>
	    break;
  4006fc:	e9 9b 05 00 00       	jmp    400c9c <vsnprintf+0x660>
	case 'c':
            addchar(&s, va_arg(va, int));
  400701:	48                   	dec    %eax
  400702:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400705:	8b 00                	mov    (%eax),%eax
  400707:	83 f8 30             	cmp    $0x30,%eax
  40070a:	73 24                	jae    400730 <vsnprintf+0xf4>
  40070c:	48                   	dec    %eax
  40070d:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400710:	48                   	dec    %eax
  400711:	8b 50 10             	mov    0x10(%eax),%edx
  400714:	48                   	dec    %eax
  400715:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400718:	8b 00                	mov    (%eax),%eax
  40071a:	89 c0                	mov    %eax,%eax
  40071c:	48                   	dec    %eax
  40071d:	01 d0                	add    %edx,%eax
  40071f:	48                   	dec    %eax
  400720:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400723:	8b 12                	mov    (%edx),%edx
  400725:	8d 4a 08             	lea    0x8(%edx),%ecx
  400728:	48                   	dec    %eax
  400729:	8b 55 b0             	mov    -0x50(%ebp),%edx
  40072c:	89 0a                	mov    %ecx,(%edx)
  40072e:	eb 17                	jmp    400747 <vsnprintf+0x10b>
  400730:	48                   	dec    %eax
  400731:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400734:	48                   	dec    %eax
  400735:	8b 50 08             	mov    0x8(%eax),%edx
  400738:	48                   	dec    %eax
  400739:	89 d0                	mov    %edx,%eax
  40073b:	48                   	dec    %eax
  40073c:	8d 4a 08             	lea    0x8(%edx),%ecx
  40073f:	48                   	dec    %eax
  400740:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400743:	48                   	dec    %eax
  400744:	89 4a 08             	mov    %ecx,0x8(%edx)
  400747:	8b 00                	mov    (%eax),%eax
  400749:	0f be d0             	movsbl %al,%edx
  40074c:	48                   	dec    %eax
  40074d:	8d 45 e8             	lea    -0x18(%ebp),%eax
  400750:	89 d6                	mov    %edx,%esi
  400752:	48                   	dec    %eax
  400753:	89 c7                	mov    %eax,%edi
  400755:	e8 50 fa ff ff       	call   4001aa <addchar>
	    break;
  40075a:	e9 3d 05 00 00       	jmp    400c9c <vsnprintf+0x660>
	case '\0':
	    --fmt;
  40075f:	48                   	dec    %eax
  400760:	8b 45 b8             	mov    -0x48(%ebp),%eax
  400763:	48                   	dec    %eax
  400764:	83 e8 01             	sub    $0x1,%eax
  400767:	48                   	dec    %eax
  400768:	89 45 b8             	mov    %eax,-0x48(%ebp)
	    break;
  40076b:	e9 2c 05 00 00       	jmp    400c9c <vsnprintf+0x660>
	case '#':
	    props.alternate = true;
  400770:	c6 45 e4 01          	movb   $0x1,-0x1c(%ebp)
	    goto morefmt;
  400774:	e9 47 ff ff ff       	jmp    4006c0 <vsnprintf+0x84>
	case '0':
	    props.pad = '0';
  400779:	c6 45 dc 30          	movb   $0x30,-0x24(%ebp)
	    ++fmt;
  40077d:	48                   	dec    %eax
  40077e:	8b 45 b8             	mov    -0x48(%ebp),%eax
  400781:	48                   	dec    %eax
  400782:	83 c0 01             	add    $0x1,%eax
  400785:	48                   	dec    %eax
  400786:	89 45 b8             	mov    %eax,-0x48(%ebp)
	    /* fall through */
	case '1'...'9':
	case '-':
	    --fmt;
  400789:	48                   	dec    %eax
  40078a:	8b 45 b8             	mov    -0x48(%ebp),%eax
  40078d:	48                   	dec    %eax
  40078e:	83 e8 01             	sub    $0x1,%eax
  400791:	48                   	dec    %eax
  400792:	89 45 b8             	mov    %eax,-0x48(%ebp)
	    props.npad = fmtnum(&fmt);
  400795:	48                   	dec    %eax
  400796:	8d 45 b8             	lea    -0x48(%ebp),%eax
  400799:	48                   	dec    %eax
  40079a:	89 c7                	mov    %eax,%edi
  40079c:	e8 19 fe ff ff       	call   4005ba <fmtnum>
  4007a1:	89 45 e0             	mov    %eax,-0x20(%ebp)
	    goto morefmt;
  4007a4:	e9 17 ff ff ff       	jmp    4006c0 <vsnprintf+0x84>
	case 'l':
	    ++nlong;
  4007a9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
	    goto morefmt;
  4007ad:	e9 0e ff ff ff       	jmp    4006c0 <vsnprintf+0x84>
	    /* Here we only care that sizeof(size_t) == sizeof(long).
	     * On a 32-bit platform it doesn't matter that size_t is
	     * typedef'ed to int or long; va_arg will work either way.
	     * Same for ptrdiff_t (%td).
	     */
	    nlong = 1;
  4007b2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	    goto morefmt;
  4007b9:	e9 02 ff ff ff       	jmp    4006c0 <vsnprintf+0x84>
	case 'd':
	    switch (nlong) {
  4007be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  4007c1:	85 c0                	test   %eax,%eax
  4007c3:	74 0a                	je     4007cf <vsnprintf+0x193>
  4007c5:	83 f8 01             	cmp    $0x1,%eax
  4007c8:	74 73                	je     40083d <vsnprintf+0x201>
  4007ca:	e9 d7 00 00 00       	jmp    4008a6 <vsnprintf+0x26a>
	    case 0:
		print_int(&s, va_arg(va, int), 10, props);
  4007cf:	48                   	dec    %eax
  4007d0:	8b 45 b0             	mov    -0x50(%ebp),%eax
  4007d3:	8b 00                	mov    (%eax),%eax
  4007d5:	83 f8 30             	cmp    $0x30,%eax
  4007d8:	73 24                	jae    4007fe <vsnprintf+0x1c2>
  4007da:	48                   	dec    %eax
  4007db:	8b 45 b0             	mov    -0x50(%ebp),%eax
  4007de:	48                   	dec    %eax
  4007df:	8b 50 10             	mov    0x10(%eax),%edx
  4007e2:	48                   	dec    %eax
  4007e3:	8b 45 b0             	mov    -0x50(%ebp),%eax
  4007e6:	8b 00                	mov    (%eax),%eax
  4007e8:	89 c0                	mov    %eax,%eax
  4007ea:	48                   	dec    %eax
  4007eb:	01 d0                	add    %edx,%eax
  4007ed:	48                   	dec    %eax
  4007ee:	8b 55 b0             	mov    -0x50(%ebp),%edx
  4007f1:	8b 12                	mov    (%edx),%edx
  4007f3:	8d 4a 08             	lea    0x8(%edx),%ecx
  4007f6:	48                   	dec    %eax
  4007f7:	8b 55 b0             	mov    -0x50(%ebp),%edx
  4007fa:	89 0a                	mov    %ecx,(%edx)
  4007fc:	eb 17                	jmp    400815 <vsnprintf+0x1d9>
  4007fe:	48                   	dec    %eax
  4007ff:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400802:	48                   	dec    %eax
  400803:	8b 50 08             	mov    0x8(%eax),%edx
  400806:	48                   	dec    %eax
  400807:	89 d0                	mov    %edx,%eax
  400809:	48                   	dec    %eax
  40080a:	8d 4a 08             	lea    0x8(%edx),%ecx
  40080d:	48                   	dec    %eax
  40080e:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400811:	48                   	dec    %eax
  400812:	89 4a 08             	mov    %ecx,0x8(%edx)
  400815:	8b 00                	mov    (%eax),%eax
  400817:	48                   	dec    %eax
  400818:	63 f0                	arpl   %si,%ax
  40081a:	48                   	dec    %eax
  40081b:	8b 55 dc             	mov    -0x24(%ebp),%edx
  40081e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  400821:	48                   	dec    %eax
  400822:	8d 45 e8             	lea    -0x18(%ebp),%eax
  400825:	48                   	dec    %eax
  400826:	89 d1                	mov    %edx,%ecx
  400828:	41                   	inc    %ecx
  400829:	89 f8                	mov    %edi,%eax
  40082b:	ba 0a 00 00 00       	mov    $0xa,%edx
  400830:	48                   	dec    %eax
  400831:	89 c7                	mov    %eax,%edi
  400833:	e8 a4 fa ff ff       	call   4002dc <print_int>
		break;
  400838:	e9 d1 00 00 00       	jmp    40090e <vsnprintf+0x2d2>
	    case 1:
		print_int(&s, va_arg(va, long), 10, props);
  40083d:	48                   	dec    %eax
  40083e:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400841:	8b 00                	mov    (%eax),%eax
  400843:	83 f8 30             	cmp    $0x30,%eax
  400846:	73 24                	jae    40086c <vsnprintf+0x230>
  400848:	48                   	dec    %eax
  400849:	8b 45 b0             	mov    -0x50(%ebp),%eax
  40084c:	48                   	dec    %eax
  40084d:	8b 50 10             	mov    0x10(%eax),%edx
  400850:	48                   	dec    %eax
  400851:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400854:	8b 00                	mov    (%eax),%eax
  400856:	89 c0                	mov    %eax,%eax
  400858:	48                   	dec    %eax
  400859:	01 d0                	add    %edx,%eax
  40085b:	48                   	dec    %eax
  40085c:	8b 55 b0             	mov    -0x50(%ebp),%edx
  40085f:	8b 12                	mov    (%edx),%edx
  400861:	8d 4a 08             	lea    0x8(%edx),%ecx
  400864:	48                   	dec    %eax
  400865:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400868:	89 0a                	mov    %ecx,(%edx)
  40086a:	eb 17                	jmp    400883 <vsnprintf+0x247>
  40086c:	48                   	dec    %eax
  40086d:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400870:	48                   	dec    %eax
  400871:	8b 50 08             	mov    0x8(%eax),%edx
  400874:	48                   	dec    %eax
  400875:	89 d0                	mov    %edx,%eax
  400877:	48                   	dec    %eax
  400878:	8d 4a 08             	lea    0x8(%edx),%ecx
  40087b:	48                   	dec    %eax
  40087c:	8b 55 b0             	mov    -0x50(%ebp),%edx
  40087f:	48                   	dec    %eax
  400880:	89 4a 08             	mov    %ecx,0x8(%edx)
  400883:	48                   	dec    %eax
  400884:	8b 30                	mov    (%eax),%esi
  400886:	48                   	dec    %eax
  400887:	8b 55 dc             	mov    -0x24(%ebp),%edx
  40088a:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  40088d:	48                   	dec    %eax
  40088e:	8d 45 e8             	lea    -0x18(%ebp),%eax
  400891:	48                   	dec    %eax
  400892:	89 d1                	mov    %edx,%ecx
  400894:	41                   	inc    %ecx
  400895:	89 f8                	mov    %edi,%eax
  400897:	ba 0a 00 00 00       	mov    $0xa,%edx
  40089c:	48                   	dec    %eax
  40089d:	89 c7                	mov    %eax,%edi
  40089f:	e8 38 fa ff ff       	call   4002dc <print_int>
		break;
  4008a4:	eb 68                	jmp    40090e <vsnprintf+0x2d2>
	    default:
		print_int(&s, va_arg(va, long long), 10, props);
  4008a6:	48                   	dec    %eax
  4008a7:	8b 45 b0             	mov    -0x50(%ebp),%eax
  4008aa:	8b 00                	mov    (%eax),%eax
  4008ac:	83 f8 30             	cmp    $0x30,%eax
  4008af:	73 24                	jae    4008d5 <vsnprintf+0x299>
  4008b1:	48                   	dec    %eax
  4008b2:	8b 45 b0             	mov    -0x50(%ebp),%eax
  4008b5:	48                   	dec    %eax
  4008b6:	8b 50 10             	mov    0x10(%eax),%edx
  4008b9:	48                   	dec    %eax
  4008ba:	8b 45 b0             	mov    -0x50(%ebp),%eax
  4008bd:	8b 00                	mov    (%eax),%eax
  4008bf:	89 c0                	mov    %eax,%eax
  4008c1:	48                   	dec    %eax
  4008c2:	01 d0                	add    %edx,%eax
  4008c4:	48                   	dec    %eax
  4008c5:	8b 55 b0             	mov    -0x50(%ebp),%edx
  4008c8:	8b 12                	mov    (%edx),%edx
  4008ca:	8d 4a 08             	lea    0x8(%edx),%ecx
  4008cd:	48                   	dec    %eax
  4008ce:	8b 55 b0             	mov    -0x50(%ebp),%edx
  4008d1:	89 0a                	mov    %ecx,(%edx)
  4008d3:	eb 17                	jmp    4008ec <vsnprintf+0x2b0>
  4008d5:	48                   	dec    %eax
  4008d6:	8b 45 b0             	mov    -0x50(%ebp),%eax
  4008d9:	48                   	dec    %eax
  4008da:	8b 50 08             	mov    0x8(%eax),%edx
  4008dd:	48                   	dec    %eax
  4008de:	89 d0                	mov    %edx,%eax
  4008e0:	48                   	dec    %eax
  4008e1:	8d 4a 08             	lea    0x8(%edx),%ecx
  4008e4:	48                   	dec    %eax
  4008e5:	8b 55 b0             	mov    -0x50(%ebp),%edx
  4008e8:	48                   	dec    %eax
  4008e9:	89 4a 08             	mov    %ecx,0x8(%edx)
  4008ec:	48                   	dec    %eax
  4008ed:	8b 30                	mov    (%eax),%esi
  4008ef:	48                   	dec    %eax
  4008f0:	8b 55 dc             	mov    -0x24(%ebp),%edx
  4008f3:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  4008f6:	48                   	dec    %eax
  4008f7:	8d 45 e8             	lea    -0x18(%ebp),%eax
  4008fa:	48                   	dec    %eax
  4008fb:	89 d1                	mov    %edx,%ecx
  4008fd:	41                   	inc    %ecx
  4008fe:	89 f8                	mov    %edi,%eax
  400900:	ba 0a 00 00 00       	mov    $0xa,%edx
  400905:	48                   	dec    %eax
  400906:	89 c7                	mov    %eax,%edi
  400908:	e8 cf f9 ff ff       	call   4002dc <print_int>
		break;
  40090d:	90                   	nop
	    }
	    break;
  40090e:	e9 89 03 00 00       	jmp    400c9c <vsnprintf+0x660>
	case 'u':
	    switch (nlong) {
  400913:	8b 45 fc             	mov    -0x4(%ebp),%eax
  400916:	85 c0                	test   %eax,%eax
  400918:	74 0a                	je     400924 <vsnprintf+0x2e8>
  40091a:	83 f8 01             	cmp    $0x1,%eax
  40091d:	74 72                	je     400991 <vsnprintf+0x355>
  40091f:	e9 d6 00 00 00       	jmp    4009fa <vsnprintf+0x3be>
	    case 0:
		print_unsigned(&s, va_arg(va, unsigned), 10, props);
  400924:	48                   	dec    %eax
  400925:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400928:	8b 00                	mov    (%eax),%eax
  40092a:	83 f8 30             	cmp    $0x30,%eax
  40092d:	73 24                	jae    400953 <vsnprintf+0x317>
  40092f:	48                   	dec    %eax
  400930:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400933:	48                   	dec    %eax
  400934:	8b 50 10             	mov    0x10(%eax),%edx
  400937:	48                   	dec    %eax
  400938:	8b 45 b0             	mov    -0x50(%ebp),%eax
  40093b:	8b 00                	mov    (%eax),%eax
  40093d:	89 c0                	mov    %eax,%eax
  40093f:	48                   	dec    %eax
  400940:	01 d0                	add    %edx,%eax
  400942:	48                   	dec    %eax
  400943:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400946:	8b 12                	mov    (%edx),%edx
  400948:	8d 4a 08             	lea    0x8(%edx),%ecx
  40094b:	48                   	dec    %eax
  40094c:	8b 55 b0             	mov    -0x50(%ebp),%edx
  40094f:	89 0a                	mov    %ecx,(%edx)
  400951:	eb 17                	jmp    40096a <vsnprintf+0x32e>
  400953:	48                   	dec    %eax
  400954:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400957:	48                   	dec    %eax
  400958:	8b 50 08             	mov    0x8(%eax),%edx
  40095b:	48                   	dec    %eax
  40095c:	89 d0                	mov    %edx,%eax
  40095e:	48                   	dec    %eax
  40095f:	8d 4a 08             	lea    0x8(%edx),%ecx
  400962:	48                   	dec    %eax
  400963:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400966:	48                   	dec    %eax
  400967:	89 4a 08             	mov    %ecx,0x8(%edx)
  40096a:	8b 00                	mov    (%eax),%eax
  40096c:	89 c6                	mov    %eax,%esi
  40096e:	48                   	dec    %eax
  40096f:	8b 55 dc             	mov    -0x24(%ebp),%edx
  400972:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  400975:	48                   	dec    %eax
  400976:	8d 45 e8             	lea    -0x18(%ebp),%eax
  400979:	48                   	dec    %eax
  40097a:	89 d1                	mov    %edx,%ecx
  40097c:	41                   	inc    %ecx
  40097d:	89 f8                	mov    %edi,%eax
  40097f:	ba 0a 00 00 00       	mov    $0xa,%edx
  400984:	48                   	dec    %eax
  400985:	89 c7                	mov    %eax,%edi
  400987:	e8 9a fa ff ff       	call   400426 <print_unsigned>
		break;
  40098c:	e9 d1 00 00 00       	jmp    400a62 <vsnprintf+0x426>
	    case 1:
		print_unsigned(&s, va_arg(va, unsigned long), 10, props);
  400991:	48                   	dec    %eax
  400992:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400995:	8b 00                	mov    (%eax),%eax
  400997:	83 f8 30             	cmp    $0x30,%eax
  40099a:	73 24                	jae    4009c0 <vsnprintf+0x384>
  40099c:	48                   	dec    %eax
  40099d:	8b 45 b0             	mov    -0x50(%ebp),%eax
  4009a0:	48                   	dec    %eax
  4009a1:	8b 50 10             	mov    0x10(%eax),%edx
  4009a4:	48                   	dec    %eax
  4009a5:	8b 45 b0             	mov    -0x50(%ebp),%eax
  4009a8:	8b 00                	mov    (%eax),%eax
  4009aa:	89 c0                	mov    %eax,%eax
  4009ac:	48                   	dec    %eax
  4009ad:	01 d0                	add    %edx,%eax
  4009af:	48                   	dec    %eax
  4009b0:	8b 55 b0             	mov    -0x50(%ebp),%edx
  4009b3:	8b 12                	mov    (%edx),%edx
  4009b5:	8d 4a 08             	lea    0x8(%edx),%ecx
  4009b8:	48                   	dec    %eax
  4009b9:	8b 55 b0             	mov    -0x50(%ebp),%edx
  4009bc:	89 0a                	mov    %ecx,(%edx)
  4009be:	eb 17                	jmp    4009d7 <vsnprintf+0x39b>
  4009c0:	48                   	dec    %eax
  4009c1:	8b 45 b0             	mov    -0x50(%ebp),%eax
  4009c4:	48                   	dec    %eax
  4009c5:	8b 50 08             	mov    0x8(%eax),%edx
  4009c8:	48                   	dec    %eax
  4009c9:	89 d0                	mov    %edx,%eax
  4009cb:	48                   	dec    %eax
  4009cc:	8d 4a 08             	lea    0x8(%edx),%ecx
  4009cf:	48                   	dec    %eax
  4009d0:	8b 55 b0             	mov    -0x50(%ebp),%edx
  4009d3:	48                   	dec    %eax
  4009d4:	89 4a 08             	mov    %ecx,0x8(%edx)
  4009d7:	48                   	dec    %eax
  4009d8:	8b 30                	mov    (%eax),%esi
  4009da:	48                   	dec    %eax
  4009db:	8b 55 dc             	mov    -0x24(%ebp),%edx
  4009de:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  4009e1:	48                   	dec    %eax
  4009e2:	8d 45 e8             	lea    -0x18(%ebp),%eax
  4009e5:	48                   	dec    %eax
  4009e6:	89 d1                	mov    %edx,%ecx
  4009e8:	41                   	inc    %ecx
  4009e9:	89 f8                	mov    %edi,%eax
  4009eb:	ba 0a 00 00 00       	mov    $0xa,%edx
  4009f0:	48                   	dec    %eax
  4009f1:	89 c7                	mov    %eax,%edi
  4009f3:	e8 2e fa ff ff       	call   400426 <print_unsigned>
		break;
  4009f8:	eb 68                	jmp    400a62 <vsnprintf+0x426>
	    default:
		print_unsigned(&s, va_arg(va, unsigned long long), 10, props);
  4009fa:	48                   	dec    %eax
  4009fb:	8b 45 b0             	mov    -0x50(%ebp),%eax
  4009fe:	8b 00                	mov    (%eax),%eax
  400a00:	83 f8 30             	cmp    $0x30,%eax
  400a03:	73 24                	jae    400a29 <vsnprintf+0x3ed>
  400a05:	48                   	dec    %eax
  400a06:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400a09:	48                   	dec    %eax
  400a0a:	8b 50 10             	mov    0x10(%eax),%edx
  400a0d:	48                   	dec    %eax
  400a0e:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400a11:	8b 00                	mov    (%eax),%eax
  400a13:	89 c0                	mov    %eax,%eax
  400a15:	48                   	dec    %eax
  400a16:	01 d0                	add    %edx,%eax
  400a18:	48                   	dec    %eax
  400a19:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400a1c:	8b 12                	mov    (%edx),%edx
  400a1e:	8d 4a 08             	lea    0x8(%edx),%ecx
  400a21:	48                   	dec    %eax
  400a22:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400a25:	89 0a                	mov    %ecx,(%edx)
  400a27:	eb 17                	jmp    400a40 <vsnprintf+0x404>
  400a29:	48                   	dec    %eax
  400a2a:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400a2d:	48                   	dec    %eax
  400a2e:	8b 50 08             	mov    0x8(%eax),%edx
  400a31:	48                   	dec    %eax
  400a32:	89 d0                	mov    %edx,%eax
  400a34:	48                   	dec    %eax
  400a35:	8d 4a 08             	lea    0x8(%edx),%ecx
  400a38:	48                   	dec    %eax
  400a39:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400a3c:	48                   	dec    %eax
  400a3d:	89 4a 08             	mov    %ecx,0x8(%edx)
  400a40:	48                   	dec    %eax
  400a41:	8b 30                	mov    (%eax),%esi
  400a43:	48                   	dec    %eax
  400a44:	8b 55 dc             	mov    -0x24(%ebp),%edx
  400a47:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  400a4a:	48                   	dec    %eax
  400a4b:	8d 45 e8             	lea    -0x18(%ebp),%eax
  400a4e:	48                   	dec    %eax
  400a4f:	89 d1                	mov    %edx,%ecx
  400a51:	41                   	inc    %ecx
  400a52:	89 f8                	mov    %edi,%eax
  400a54:	ba 0a 00 00 00       	mov    $0xa,%edx
  400a59:	48                   	dec    %eax
  400a5a:	89 c7                	mov    %eax,%edi
  400a5c:	e8 c5 f9 ff ff       	call   400426 <print_unsigned>
		break;
  400a61:	90                   	nop
	    }
	    break;
  400a62:	e9 35 02 00 00       	jmp    400c9c <vsnprintf+0x660>
	case 'x':
	    switch (nlong) {
  400a67:	8b 45 fc             	mov    -0x4(%ebp),%eax
  400a6a:	85 c0                	test   %eax,%eax
  400a6c:	74 0a                	je     400a78 <vsnprintf+0x43c>
  400a6e:	83 f8 01             	cmp    $0x1,%eax
  400a71:	74 72                	je     400ae5 <vsnprintf+0x4a9>
  400a73:	e9 d6 00 00 00       	jmp    400b4e <vsnprintf+0x512>
	    case 0:
		print_unsigned(&s, va_arg(va, unsigned), 16, props);
  400a78:	48                   	dec    %eax
  400a79:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400a7c:	8b 00                	mov    (%eax),%eax
  400a7e:	83 f8 30             	cmp    $0x30,%eax
  400a81:	73 24                	jae    400aa7 <vsnprintf+0x46b>
  400a83:	48                   	dec    %eax
  400a84:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400a87:	48                   	dec    %eax
  400a88:	8b 50 10             	mov    0x10(%eax),%edx
  400a8b:	48                   	dec    %eax
  400a8c:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400a8f:	8b 00                	mov    (%eax),%eax
  400a91:	89 c0                	mov    %eax,%eax
  400a93:	48                   	dec    %eax
  400a94:	01 d0                	add    %edx,%eax
  400a96:	48                   	dec    %eax
  400a97:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400a9a:	8b 12                	mov    (%edx),%edx
  400a9c:	8d 4a 08             	lea    0x8(%edx),%ecx
  400a9f:	48                   	dec    %eax
  400aa0:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400aa3:	89 0a                	mov    %ecx,(%edx)
  400aa5:	eb 17                	jmp    400abe <vsnprintf+0x482>
  400aa7:	48                   	dec    %eax
  400aa8:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400aab:	48                   	dec    %eax
  400aac:	8b 50 08             	mov    0x8(%eax),%edx
  400aaf:	48                   	dec    %eax
  400ab0:	89 d0                	mov    %edx,%eax
  400ab2:	48                   	dec    %eax
  400ab3:	8d 4a 08             	lea    0x8(%edx),%ecx
  400ab6:	48                   	dec    %eax
  400ab7:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400aba:	48                   	dec    %eax
  400abb:	89 4a 08             	mov    %ecx,0x8(%edx)
  400abe:	8b 00                	mov    (%eax),%eax
  400ac0:	89 c6                	mov    %eax,%esi
  400ac2:	48                   	dec    %eax
  400ac3:	8b 55 dc             	mov    -0x24(%ebp),%edx
  400ac6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  400ac9:	48                   	dec    %eax
  400aca:	8d 45 e8             	lea    -0x18(%ebp),%eax
  400acd:	48                   	dec    %eax
  400ace:	89 d1                	mov    %edx,%ecx
  400ad0:	41                   	inc    %ecx
  400ad1:	89 f8                	mov    %edi,%eax
  400ad3:	ba 10 00 00 00       	mov    $0x10,%edx
  400ad8:	48                   	dec    %eax
  400ad9:	89 c7                	mov    %eax,%edi
  400adb:	e8 46 f9 ff ff       	call   400426 <print_unsigned>
		break;
  400ae0:	e9 d1 00 00 00       	jmp    400bb6 <vsnprintf+0x57a>
	    case 1:
		print_unsigned(&s, va_arg(va, unsigned long), 16, props);
  400ae5:	48                   	dec    %eax
  400ae6:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400ae9:	8b 00                	mov    (%eax),%eax
  400aeb:	83 f8 30             	cmp    $0x30,%eax
  400aee:	73 24                	jae    400b14 <vsnprintf+0x4d8>
  400af0:	48                   	dec    %eax
  400af1:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400af4:	48                   	dec    %eax
  400af5:	8b 50 10             	mov    0x10(%eax),%edx
  400af8:	48                   	dec    %eax
  400af9:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400afc:	8b 00                	mov    (%eax),%eax
  400afe:	89 c0                	mov    %eax,%eax
  400b00:	48                   	dec    %eax
  400b01:	01 d0                	add    %edx,%eax
  400b03:	48                   	dec    %eax
  400b04:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400b07:	8b 12                	mov    (%edx),%edx
  400b09:	8d 4a 08             	lea    0x8(%edx),%ecx
  400b0c:	48                   	dec    %eax
  400b0d:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400b10:	89 0a                	mov    %ecx,(%edx)
  400b12:	eb 17                	jmp    400b2b <vsnprintf+0x4ef>
  400b14:	48                   	dec    %eax
  400b15:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400b18:	48                   	dec    %eax
  400b19:	8b 50 08             	mov    0x8(%eax),%edx
  400b1c:	48                   	dec    %eax
  400b1d:	89 d0                	mov    %edx,%eax
  400b1f:	48                   	dec    %eax
  400b20:	8d 4a 08             	lea    0x8(%edx),%ecx
  400b23:	48                   	dec    %eax
  400b24:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400b27:	48                   	dec    %eax
  400b28:	89 4a 08             	mov    %ecx,0x8(%edx)
  400b2b:	48                   	dec    %eax
  400b2c:	8b 30                	mov    (%eax),%esi
  400b2e:	48                   	dec    %eax
  400b2f:	8b 55 dc             	mov    -0x24(%ebp),%edx
  400b32:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  400b35:	48                   	dec    %eax
  400b36:	8d 45 e8             	lea    -0x18(%ebp),%eax
  400b39:	48                   	dec    %eax
  400b3a:	89 d1                	mov    %edx,%ecx
  400b3c:	41                   	inc    %ecx
  400b3d:	89 f8                	mov    %edi,%eax
  400b3f:	ba 10 00 00 00       	mov    $0x10,%edx
  400b44:	48                   	dec    %eax
  400b45:	89 c7                	mov    %eax,%edi
  400b47:	e8 da f8 ff ff       	call   400426 <print_unsigned>
		break;
  400b4c:	eb 68                	jmp    400bb6 <vsnprintf+0x57a>
	    default:
		print_unsigned(&s, va_arg(va, unsigned long long), 16, props);
  400b4e:	48                   	dec    %eax
  400b4f:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400b52:	8b 00                	mov    (%eax),%eax
  400b54:	83 f8 30             	cmp    $0x30,%eax
  400b57:	73 24                	jae    400b7d <vsnprintf+0x541>
  400b59:	48                   	dec    %eax
  400b5a:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400b5d:	48                   	dec    %eax
  400b5e:	8b 50 10             	mov    0x10(%eax),%edx
  400b61:	48                   	dec    %eax
  400b62:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400b65:	8b 00                	mov    (%eax),%eax
  400b67:	89 c0                	mov    %eax,%eax
  400b69:	48                   	dec    %eax
  400b6a:	01 d0                	add    %edx,%eax
  400b6c:	48                   	dec    %eax
  400b6d:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400b70:	8b 12                	mov    (%edx),%edx
  400b72:	8d 4a 08             	lea    0x8(%edx),%ecx
  400b75:	48                   	dec    %eax
  400b76:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400b79:	89 0a                	mov    %ecx,(%edx)
  400b7b:	eb 17                	jmp    400b94 <vsnprintf+0x558>
  400b7d:	48                   	dec    %eax
  400b7e:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400b81:	48                   	dec    %eax
  400b82:	8b 50 08             	mov    0x8(%eax),%edx
  400b85:	48                   	dec    %eax
  400b86:	89 d0                	mov    %edx,%eax
  400b88:	48                   	dec    %eax
  400b89:	8d 4a 08             	lea    0x8(%edx),%ecx
  400b8c:	48                   	dec    %eax
  400b8d:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400b90:	48                   	dec    %eax
  400b91:	89 4a 08             	mov    %ecx,0x8(%edx)
  400b94:	48                   	dec    %eax
  400b95:	8b 30                	mov    (%eax),%esi
  400b97:	48                   	dec    %eax
  400b98:	8b 55 dc             	mov    -0x24(%ebp),%edx
  400b9b:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  400b9e:	48                   	dec    %eax
  400b9f:	8d 45 e8             	lea    -0x18(%ebp),%eax
  400ba2:	48                   	dec    %eax
  400ba3:	89 d1                	mov    %edx,%ecx
  400ba5:	41                   	inc    %ecx
  400ba6:	89 f8                	mov    %edi,%eax
  400ba8:	ba 10 00 00 00       	mov    $0x10,%edx
  400bad:	48                   	dec    %eax
  400bae:	89 c7                	mov    %eax,%edi
  400bb0:	e8 71 f8 ff ff       	call   400426 <print_unsigned>
		break;
  400bb5:	90                   	nop
	    }
	    break;
  400bb6:	e9 e1 00 00 00       	jmp    400c9c <vsnprintf+0x660>
	case 'p':
	    props.alternate = true;
  400bbb:	c6 45 e4 01          	movb   $0x1,-0x1c(%ebp)
	    print_unsigned(&s, (unsigned long)va_arg(va, void *), 16, props);
  400bbf:	48                   	dec    %eax
  400bc0:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400bc3:	8b 00                	mov    (%eax),%eax
  400bc5:	83 f8 30             	cmp    $0x30,%eax
  400bc8:	73 24                	jae    400bee <vsnprintf+0x5b2>
  400bca:	48                   	dec    %eax
  400bcb:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400bce:	48                   	dec    %eax
  400bcf:	8b 50 10             	mov    0x10(%eax),%edx
  400bd2:	48                   	dec    %eax
  400bd3:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400bd6:	8b 00                	mov    (%eax),%eax
  400bd8:	89 c0                	mov    %eax,%eax
  400bda:	48                   	dec    %eax
  400bdb:	01 d0                	add    %edx,%eax
  400bdd:	48                   	dec    %eax
  400bde:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400be1:	8b 12                	mov    (%edx),%edx
  400be3:	8d 4a 08             	lea    0x8(%edx),%ecx
  400be6:	48                   	dec    %eax
  400be7:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400bea:	89 0a                	mov    %ecx,(%edx)
  400bec:	eb 17                	jmp    400c05 <vsnprintf+0x5c9>
  400bee:	48                   	dec    %eax
  400bef:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400bf2:	48                   	dec    %eax
  400bf3:	8b 50 08             	mov    0x8(%eax),%edx
  400bf6:	48                   	dec    %eax
  400bf7:	89 d0                	mov    %edx,%eax
  400bf9:	48                   	dec    %eax
  400bfa:	8d 4a 08             	lea    0x8(%edx),%ecx
  400bfd:	48                   	dec    %eax
  400bfe:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400c01:	48                   	dec    %eax
  400c02:	89 4a 08             	mov    %ecx,0x8(%edx)
  400c05:	48                   	dec    %eax
  400c06:	8b 00                	mov    (%eax),%eax
  400c08:	48                   	dec    %eax
  400c09:	89 c6                	mov    %eax,%esi
  400c0b:	48                   	dec    %eax
  400c0c:	8b 55 dc             	mov    -0x24(%ebp),%edx
  400c0f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  400c12:	48                   	dec    %eax
  400c13:	8d 45 e8             	lea    -0x18(%ebp),%eax
  400c16:	48                   	dec    %eax
  400c17:	89 d1                	mov    %edx,%ecx
  400c19:	41                   	inc    %ecx
  400c1a:	89 f8                	mov    %edi,%eax
  400c1c:	ba 10 00 00 00       	mov    $0x10,%edx
  400c21:	48                   	dec    %eax
  400c22:	89 c7                	mov    %eax,%edi
  400c24:	e8 fd f7 ff ff       	call   400426 <print_unsigned>
	    break;
  400c29:	eb 71                	jmp    400c9c <vsnprintf+0x660>
	case 's':
	    print_str(&s, va_arg(va, const char *), props);
  400c2b:	48                   	dec    %eax
  400c2c:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400c2f:	8b 00                	mov    (%eax),%eax
  400c31:	83 f8 30             	cmp    $0x30,%eax
  400c34:	73 24                	jae    400c5a <vsnprintf+0x61e>
  400c36:	48                   	dec    %eax
  400c37:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400c3a:	48                   	dec    %eax
  400c3b:	8b 50 10             	mov    0x10(%eax),%edx
  400c3e:	48                   	dec    %eax
  400c3f:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400c42:	8b 00                	mov    (%eax),%eax
  400c44:	89 c0                	mov    %eax,%eax
  400c46:	48                   	dec    %eax
  400c47:	01 d0                	add    %edx,%eax
  400c49:	48                   	dec    %eax
  400c4a:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400c4d:	8b 12                	mov    (%edx),%edx
  400c4f:	8d 4a 08             	lea    0x8(%edx),%ecx
  400c52:	48                   	dec    %eax
  400c53:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400c56:	89 0a                	mov    %ecx,(%edx)
  400c58:	eb 17                	jmp    400c71 <vsnprintf+0x635>
  400c5a:	48                   	dec    %eax
  400c5b:	8b 45 b0             	mov    -0x50(%ebp),%eax
  400c5e:	48                   	dec    %eax
  400c5f:	8b 50 08             	mov    0x8(%eax),%edx
  400c62:	48                   	dec    %eax
  400c63:	89 d0                	mov    %edx,%eax
  400c65:	48                   	dec    %eax
  400c66:	8d 4a 08             	lea    0x8(%edx),%ecx
  400c69:	48                   	dec    %eax
  400c6a:	8b 55 b0             	mov    -0x50(%ebp),%edx
  400c6d:	48                   	dec    %eax
  400c6e:	89 4a 08             	mov    %ecx,0x8(%edx)
  400c71:	48                   	dec    %eax
  400c72:	8b 30                	mov    (%eax),%esi
  400c74:	48                   	dec    %eax
  400c75:	8b 55 dc             	mov    -0x24(%ebp),%edx
  400c78:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  400c7b:	48                   	dec    %eax
  400c7c:	8d 45 e8             	lea    -0x18(%ebp),%eax
  400c7f:	48                   	dec    %eax
  400c80:	89 c7                	mov    %eax,%edi
  400c82:	e8 7b f5 ff ff       	call   400202 <print_str>
	    break;
  400c87:	eb 13                	jmp    400c9c <vsnprintf+0x660>
	default:
	    addchar(&s, f);
  400c89:	0f be 55 fb          	movsbl -0x5(%ebp),%edx
  400c8d:	48                   	dec    %eax
  400c8e:	8d 45 e8             	lea    -0x18(%ebp),%eax
  400c91:	89 d6                	mov    %edx,%esi
  400c93:	48                   	dec    %eax
  400c94:	89 c7                	mov    %eax,%edi
  400c96:	e8 0f f5 ff ff       	call   4001aa <addchar>
	    break;
  400c9b:	90                   	nop
    pstream_t s;

    s.buffer = buf;
    s.remain = size - 1;
    s.added = 0;
    while (*fmt) {
  400c9c:	48                   	dec    %eax
  400c9d:	8b 45 b8             	mov    -0x48(%ebp),%eax
  400ca0:	0f b6 00             	movzbl (%eax),%eax
  400ca3:	84 c0                	test   %al,%al
  400ca5:	0f 85 c5 f9 ff ff    	jne    400670 <vsnprintf+0x34>
	default:
	    addchar(&s, f);
	    break;
	}
    }
    *s.buffer = 0;
  400cab:	48                   	dec    %eax
  400cac:	8b 45 e8             	mov    -0x18(%ebp),%eax
  400caf:	c6 00 00             	movb   $0x0,(%eax)
    return s.added;
  400cb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  400cb5:	c9                   	leave  
  400cb6:	c3                   	ret    

00400cb7 <snprintf>:


int snprintf(char *buf, int size, const char *fmt, ...)
{
  400cb7:	55                   	push   %ebp
  400cb8:	48                   	dec    %eax
  400cb9:	89 e5                	mov    %esp,%ebp
  400cbb:	48                   	dec    %eax
  400cbc:	83 ec 70             	sub    $0x70,%esp
  400cbf:	48                   	dec    %eax
  400cc0:	89 7d a8             	mov    %edi,-0x58(%ebp)
  400cc3:	89 75 a4             	mov    %esi,-0x5c(%ebp)
  400cc6:	48                   	dec    %eax
  400cc7:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  400cca:	4c                   	dec    %esp
  400ccb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  400cce:	4c                   	dec    %esp
  400ccf:	89 4d f8             	mov    %ecx,-0x8(%ebp)
  400cd2:	48                   	dec    %eax
  400cd3:	89 55 98             	mov    %edx,-0x68(%ebp)
    va_list va;
    int r;

    va_start(va, fmt);
  400cd6:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%ebp)
  400cdd:	48                   	dec    %eax
  400cde:	8d 45 10             	lea    0x10(%ebp),%eax
  400ce1:	48                   	dec    %eax
  400ce2:	89 45 b8             	mov    %eax,-0x48(%ebp)
  400ce5:	48                   	dec    %eax
  400ce6:	8d 45 d0             	lea    -0x30(%ebp),%eax
  400ce9:	48                   	dec    %eax
  400cea:	89 45 c0             	mov    %eax,-0x40(%ebp)
    r = vsnprintf(buf, size, fmt, va);
  400ced:	48                   	dec    %eax
  400cee:	8d 4d b0             	lea    -0x50(%ebp),%ecx
  400cf1:	48                   	dec    %eax
  400cf2:	8b 55 98             	mov    -0x68(%ebp),%edx
  400cf5:	8b 75 a4             	mov    -0x5c(%ebp),%esi
  400cf8:	48                   	dec    %eax
  400cf9:	8b 45 a8             	mov    -0x58(%ebp),%eax
  400cfc:	48                   	dec    %eax
  400cfd:	89 c7                	mov    %eax,%edi
  400cff:	e8 38 f9 ff ff       	call   40063c <vsnprintf>
  400d04:	89 45 cc             	mov    %eax,-0x34(%ebp)
    va_end(va);
    return r;
  400d07:	8b 45 cc             	mov    -0x34(%ebp),%eax
}
  400d0a:	c9                   	leave  
  400d0b:	c3                   	ret    

00400d0c <vprintf>:

int vprintf(const char *fmt, va_list va)
{
  400d0c:	55                   	push   %ebp
  400d0d:	48                   	dec    %eax
  400d0e:	89 e5                	mov    %esp,%ebp
  400d10:	48                   	dec    %eax
  400d11:	81 ec f0 07 00 00    	sub    $0x7f0,%esp
  400d17:	48                   	dec    %eax
  400d18:	89 bd 18 f8 ff ff    	mov    %edi,-0x7e8(%ebp)
  400d1e:	48                   	dec    %eax
  400d1f:	89 b5 10 f8 ff ff    	mov    %esi,-0x7f0(%ebp)
    char buf[BUFSZ];
    int r;

    r = vsnprintf(buf, sizeof(buf), fmt, va);
  400d25:	48                   	dec    %eax
  400d26:	8b 8d 10 f8 ff ff    	mov    -0x7f0(%ebp),%ecx
  400d2c:	48                   	dec    %eax
  400d2d:	8b 95 18 f8 ff ff    	mov    -0x7e8(%ebp),%edx
  400d33:	48                   	dec    %eax
  400d34:	8d 85 2c f8 ff ff    	lea    -0x7d4(%ebp),%eax
  400d3a:	be d0 07 00 00       	mov    $0x7d0,%esi
  400d3f:	48                   	dec    %eax
  400d40:	89 c7                	mov    %eax,%edi
  400d42:	e8 f5 f8 ff ff       	call   40063c <vsnprintf>
  400d47:	89 45 fc             	mov    %eax,-0x4(%ebp)
    puts(buf);
  400d4a:	48                   	dec    %eax
  400d4b:	8d 85 2c f8 ff ff    	lea    -0x7d4(%ebp),%eax
  400d51:	48                   	dec    %eax
  400d52:	89 c7                	mov    %eax,%edi
  400d54:	e8 58 15 00 00       	call   4022b1 <puts>
    return r;
  400d59:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  400d5c:	c9                   	leave  
  400d5d:	c3                   	ret    

00400d5e <printf>:

int printf(const char *fmt, ...)
{
  400d5e:	55                   	push   %ebp
  400d5f:	48                   	dec    %eax
  400d60:	89 e5                	mov    %esp,%ebp
  400d62:	48                   	dec    %eax
  400d63:	81 ec 30 08 00 00    	sub    $0x830,%esp
  400d69:	48                   	dec    %eax
  400d6a:	89 75 d8             	mov    %esi,-0x28(%ebp)
  400d6d:	48                   	dec    %eax
  400d6e:	89 55 e0             	mov    %edx,-0x20(%ebp)
  400d71:	48                   	dec    %eax
  400d72:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  400d75:	4c                   	dec    %esp
  400d76:	89 45 f0             	mov    %eax,-0x10(%ebp)
  400d79:	4c                   	dec    %esp
  400d7a:	89 4d f8             	mov    %ecx,-0x8(%ebp)
  400d7d:	48                   	dec    %eax
  400d7e:	89 bd d8 f7 ff ff    	mov    %edi,-0x828(%ebp)
    va_list va;
    char buf[BUFSZ];
    int r;

    va_start(va, fmt);
  400d84:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%ebp)
  400d8b:	48                   	dec    %eax
  400d8c:	8d 45 10             	lea    0x10(%ebp),%eax
  400d8f:	48                   	dec    %eax
  400d90:	89 45 b8             	mov    %eax,-0x48(%ebp)
  400d93:	48                   	dec    %eax
  400d94:	8d 45 d0             	lea    -0x30(%ebp),%eax
  400d97:	48                   	dec    %eax
  400d98:	89 45 c0             	mov    %eax,-0x40(%ebp)
    r = vsnprintf(buf, sizeof buf, fmt, va);
  400d9b:	48                   	dec    %eax
  400d9c:	8d 4d b0             	lea    -0x50(%ebp),%ecx
  400d9f:	48                   	dec    %eax
  400da0:	8b 95 d8 f7 ff ff    	mov    -0x828(%ebp),%edx
  400da6:	48                   	dec    %eax
  400da7:	8d 85 e0 f7 ff ff    	lea    -0x820(%ebp),%eax
  400dad:	be d0 07 00 00       	mov    $0x7d0,%esi
  400db2:	48                   	dec    %eax
  400db3:	89 c7                	mov    %eax,%edi
  400db5:	e8 82 f8 ff ff       	call   40063c <vsnprintf>
  400dba:	89 45 cc             	mov    %eax,-0x34(%ebp)
    va_end(va);
#ifdef __BARE_METAL
    console_puts(buf);
  400dbd:	48                   	dec    %eax
  400dbe:	8d 85 e0 f7 ff ff    	lea    -0x820(%ebp),%eax
  400dc4:	48                   	dec    %eax
  400dc5:	89 c7                	mov    %eax,%edi
  400dc7:	e8 d1 12 00 00       	call   40209d <console_puts>
#else
    puts(buf);
#endif
    return r;
  400dcc:	8b 45 cc             	mov    -0x34(%ebp),%eax
}
  400dcf:	c9                   	leave  
  400dd0:	c3                   	ret    

00400dd1 <binstr>:

void binstr(unsigned long x, char out[BINSTR_SZ])
{
  400dd1:	55                   	push   %ebp
  400dd2:	48                   	dec    %eax
  400dd3:	89 e5                	mov    %esp,%ebp
  400dd5:	48                   	dec    %eax
  400dd6:	83 ec 30             	sub    $0x30,%esp
  400dd9:	48                   	dec    %eax
  400dda:	89 7d d8             	mov    %edi,-0x28(%ebp)
  400ddd:	48                   	dec    %eax
  400dde:	89 75 d0             	mov    %esi,-0x30(%ebp)
	int i;
	char *c;
	int n;

	n = sizeof(unsigned long) * 8;
  400de1:	c7 45 ec 40 00 00 00 	movl   $0x40,-0x14(%ebp)
	i = 0;
  400de8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	c = &out[0];
  400def:	48                   	dec    %eax
  400df0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  400df3:	48                   	dec    %eax
  400df4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	for (;;) {
		*c++ = (x & (1ul << (n - i - 1))) ? '1' : '0';
  400df7:	48                   	dec    %eax
  400df8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  400dfb:	48                   	dec    %eax
  400dfc:	8d 50 01             	lea    0x1(%eax),%edx
  400dff:	48                   	dec    %eax
  400e00:	89 55 f0             	mov    %edx,-0x10(%ebp)
  400e03:	8b 55 fc             	mov    -0x4(%ebp),%edx
  400e06:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  400e09:	29 d1                	sub    %edx,%ecx
  400e0b:	89 ca                	mov    %ecx,%edx
  400e0d:	83 ea 01             	sub    $0x1,%edx
  400e10:	48                   	dec    %eax
  400e11:	8b 75 d8             	mov    -0x28(%ebp),%esi
  400e14:	89 d1                	mov    %edx,%ecx
  400e16:	48                   	dec    %eax
  400e17:	d3 ee                	shr    %cl,%esi
  400e19:	48                   	dec    %eax
  400e1a:	89 f2                	mov    %esi,%edx
  400e1c:	83 e2 01             	and    $0x1,%edx
  400e1f:	48                   	dec    %eax
  400e20:	85 d2                	test   %edx,%edx
  400e22:	74 07                	je     400e2b <binstr+0x5a>
  400e24:	ba 31 00 00 00       	mov    $0x31,%edx
  400e29:	eb 05                	jmp    400e30 <binstr+0x5f>
  400e2b:	ba 30 00 00 00       	mov    $0x30,%edx
  400e30:	88 10                	mov    %dl,(%eax)
		i++;
  400e32:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)

		if (i == n) {
  400e36:	8b 45 fc             	mov    -0x4(%ebp),%eax
  400e39:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  400e3c:	75 25                	jne    400e63 <binstr+0x92>
			*c = '\0';
  400e3e:	48                   	dec    %eax
  400e3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  400e42:	c6 00 00             	movb   $0x0,(%eax)
			break;
  400e45:	90                   	nop
		}
		if (i % 4 == 0)
			*c++ = '\'';
	}
	assert(c + 1 - &out[0] == BINSTR_SZ);
  400e46:	48                   	dec    %eax
  400e47:	8b 45 f0             	mov    -0x10(%ebp),%eax
  400e4a:	48                   	dec    %eax
  400e4b:	83 c0 01             	add    $0x1,%eax
  400e4e:	48                   	dec    %eax
  400e4f:	89 c2                	mov    %eax,%edx
  400e51:	48                   	dec    %eax
  400e52:	8b 45 d0             	mov    -0x30(%ebp),%eax
  400e55:	48                   	dec    %eax
  400e56:	29 c2                	sub    %eax,%edx
  400e58:	48                   	dec    %eax
  400e59:	89 d0                	mov    %edx,%eax
  400e5b:	48                   	dec    %eax
  400e5c:	83 f8 50             	cmp    $0x50,%eax
  400e5f:	74 4d                	je     400eae <binstr+0xdd>
  400e61:	eb 23                	jmp    400e86 <binstr+0xb5>

		if (i == n) {
			*c = '\0';
			break;
		}
		if (i % 4 == 0)
  400e63:	8b 45 fc             	mov    -0x4(%ebp),%eax
  400e66:	83 e0 03             	and    $0x3,%eax
  400e69:	85 c0                	test   %eax,%eax
  400e6b:	75 14                	jne    400e81 <binstr+0xb0>
			*c++ = '\'';
  400e6d:	48                   	dec    %eax
  400e6e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  400e71:	48                   	dec    %eax
  400e72:	8d 50 01             	lea    0x1(%eax),%edx
  400e75:	48                   	dec    %eax
  400e76:	89 55 f0             	mov    %edx,-0x10(%ebp)
  400e79:	c6 00 27             	movb   $0x27,(%eax)
	}
  400e7c:	e9 76 ff ff ff       	jmp    400df7 <binstr+0x26>
  400e81:	e9 71 ff ff ff       	jmp    400df7 <binstr+0x26>
	assert(c + 1 - &out[0] == BINSTR_SZ);
  400e86:	b9 d8 d3 40 00       	mov    $0x40d3d8,%ecx
  400e8b:	ba 41 01 00 00       	mov    $0x141,%edx
  400e90:	be f5 d3 40 00       	mov    $0x40d3f5,%esi
  400e95:	bf 02 d4 40 00       	mov    $0x40d402,%edi
  400e9a:	b8 00 00 00 00       	mov    $0x0,%eax
  400e9f:	e8 ba fe ff ff       	call   400d5e <printf>
  400ea4:	e8 9c 07 00 00       	call   401645 <dump_stack>
  400ea9:	e8 8c 0f 00 00       	call   401e3a <abort>
}
  400eae:	c9                   	leave  
  400eaf:	c3                   	ret    

00400eb0 <print_binstr>:

void print_binstr(unsigned long x)
{
  400eb0:	55                   	push   %ebp
  400eb1:	48                   	dec    %eax
  400eb2:	89 e5                	mov    %esp,%ebp
  400eb4:	48                   	dec    %eax
  400eb5:	83 ec 60             	sub    $0x60,%esp
  400eb8:	48                   	dec    %eax
  400eb9:	89 7d a8             	mov    %edi,-0x58(%ebp)
	char out[BINSTR_SZ];
	binstr(x, out);
  400ebc:	48                   	dec    %eax
  400ebd:	8d 55 b0             	lea    -0x50(%ebp),%edx
  400ec0:	48                   	dec    %eax
  400ec1:	8b 45 a8             	mov    -0x58(%ebp),%eax
  400ec4:	48                   	dec    %eax
  400ec5:	89 d6                	mov    %edx,%esi
  400ec7:	48                   	dec    %eax
  400ec8:	89 c7                	mov    %eax,%edi
  400eca:	e8 02 ff ff ff       	call   400dd1 <binstr>
	printf("%s", out);
  400ecf:	48                   	dec    %eax
  400ed0:	8d 45 b0             	lea    -0x50(%ebp),%eax
  400ed3:	48                   	dec    %eax
  400ed4:	89 c6                	mov    %eax,%esi
  400ed6:	bf 1c d4 40 00       	mov    $0x40d41c,%edi
  400edb:	b8 00 00 00 00       	mov    $0x0,%eax
  400ee0:	e8 79 fe ff ff       	call   400d5e <printf>
}
  400ee5:	c9                   	leave  
  400ee6:	c3                   	ret    

00400ee7 <strlen>:

#include "types.h"
#include "defs.h"

unsigned long strlen(const char *buf)
{
  400ee7:	55                   	push   %ebp
  400ee8:	48                   	dec    %eax
  400ee9:	89 e5                	mov    %esp,%ebp
  400eeb:	48                   	dec    %eax
  400eec:	83 ec 18             	sub    $0x18,%esp
  400eef:	48                   	dec    %eax
  400ef0:	89 7d e8             	mov    %edi,-0x18(%ebp)
    unsigned long len = 0;
  400ef3:	48                   	dec    %eax
  400ef4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    while (*buf++)
  400efb:	eb 05                	jmp    400f02 <strlen+0x1b>
	++len;
  400efd:	48                   	dec    %eax
  400efe:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)

unsigned long strlen(const char *buf)
{
    unsigned long len = 0;

    while (*buf++)
  400f02:	48                   	dec    %eax
  400f03:	8b 45 e8             	mov    -0x18(%ebp),%eax
  400f06:	48                   	dec    %eax
  400f07:	8d 50 01             	lea    0x1(%eax),%edx
  400f0a:	48                   	dec    %eax
  400f0b:	89 55 e8             	mov    %edx,-0x18(%ebp)
  400f0e:	0f b6 00             	movzbl (%eax),%eax
  400f11:	84 c0                	test   %al,%al
  400f13:	75 e8                	jne    400efd <strlen+0x16>
	++len;
    return len;
  400f15:	48                   	dec    %eax
  400f16:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  400f19:	c9                   	leave  
  400f1a:	c3                   	ret    

00400f1b <strcat>:

char *strcat(char *dest, const char *src)
{
  400f1b:	55                   	push   %ebp
  400f1c:	48                   	dec    %eax
  400f1d:	89 e5                	mov    %esp,%ebp
  400f1f:	48                   	dec    %eax
  400f20:	83 ec 20             	sub    $0x20,%esp
  400f23:	48                   	dec    %eax
  400f24:	89 7d e8             	mov    %edi,-0x18(%ebp)
  400f27:	48                   	dec    %eax
  400f28:	89 75 e0             	mov    %esi,-0x20(%ebp)
    char *p = dest;
  400f2b:	48                   	dec    %eax
  400f2c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  400f2f:	48                   	dec    %eax
  400f30:	89 45 f8             	mov    %eax,-0x8(%ebp)

    while (*p)
  400f33:	eb 05                	jmp    400f3a <strcat+0x1f>
	++p;
  400f35:	48                   	dec    %eax
  400f36:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)

char *strcat(char *dest, const char *src)
{
    char *p = dest;

    while (*p)
  400f3a:	48                   	dec    %eax
  400f3b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  400f3e:	0f b6 00             	movzbl (%eax),%eax
  400f41:	84 c0                	test   %al,%al
  400f43:	75 f0                	jne    400f35 <strcat+0x1a>
	++p;
    while ((*p++ = *src++) != 0)
  400f45:	90                   	nop
  400f46:	48                   	dec    %eax
  400f47:	8b 45 f8             	mov    -0x8(%ebp),%eax
  400f4a:	48                   	dec    %eax
  400f4b:	8d 50 01             	lea    0x1(%eax),%edx
  400f4e:	48                   	dec    %eax
  400f4f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  400f52:	48                   	dec    %eax
  400f53:	8b 55 e0             	mov    -0x20(%ebp),%edx
  400f56:	48                   	dec    %eax
  400f57:	8d 4a 01             	lea    0x1(%edx),%ecx
  400f5a:	48                   	dec    %eax
  400f5b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  400f5e:	0f b6 12             	movzbl (%edx),%edx
  400f61:	88 10                	mov    %dl,(%eax)
  400f63:	0f b6 00             	movzbl (%eax),%eax
  400f66:	84 c0                	test   %al,%al
  400f68:	75 dc                	jne    400f46 <strcat+0x2b>
	;
    return dest;
  400f6a:	48                   	dec    %eax
  400f6b:	8b 45 e8             	mov    -0x18(%ebp),%eax
}
  400f6e:	c9                   	leave  
  400f6f:	c3                   	ret    

00400f70 <strcpy>:

char *strcpy(char *dest, const char *src)
{
  400f70:	55                   	push   %ebp
  400f71:	48                   	dec    %eax
  400f72:	89 e5                	mov    %esp,%ebp
  400f74:	48                   	dec    %eax
  400f75:	83 ec 10             	sub    $0x10,%esp
  400f78:	48                   	dec    %eax
  400f79:	89 7d f8             	mov    %edi,-0x8(%ebp)
  400f7c:	48                   	dec    %eax
  400f7d:	89 75 f0             	mov    %esi,-0x10(%ebp)
    *dest = 0;
  400f80:	48                   	dec    %eax
  400f81:	8b 45 f8             	mov    -0x8(%ebp),%eax
  400f84:	c6 00 00             	movb   $0x0,(%eax)
    return strcat(dest, src);
  400f87:	48                   	dec    %eax
  400f88:	8b 55 f0             	mov    -0x10(%ebp),%edx
  400f8b:	48                   	dec    %eax
  400f8c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  400f8f:	48                   	dec    %eax
  400f90:	89 d6                	mov    %edx,%esi
  400f92:	48                   	dec    %eax
  400f93:	89 c7                	mov    %eax,%edi
  400f95:	e8 81 ff ff ff       	call   400f1b <strcat>
}
  400f9a:	c9                   	leave  
  400f9b:	c3                   	ret    

00400f9c <strncmp>:

int strncmp(const char *a, const char *b, size_t n)
{
  400f9c:	55                   	push   %ebp
  400f9d:	48                   	dec    %eax
  400f9e:	89 e5                	mov    %esp,%ebp
  400fa0:	48                   	dec    %eax
  400fa1:	83 ec 18             	sub    $0x18,%esp
  400fa4:	48                   	dec    %eax
  400fa5:	89 7d f8             	mov    %edi,-0x8(%ebp)
  400fa8:	48                   	dec    %eax
  400fa9:	89 75 f0             	mov    %esi,-0x10(%ebp)
  400fac:	48                   	dec    %eax
  400fad:	89 55 e8             	mov    %edx,-0x18(%ebp)
    for (; n--; ++a, ++b)
  400fb0:	eb 41                	jmp    400ff3 <strncmp+0x57>
        if (*a != *b || *a == '\0')
  400fb2:	48                   	dec    %eax
  400fb3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  400fb6:	0f b6 10             	movzbl (%eax),%edx
  400fb9:	48                   	dec    %eax
  400fba:	8b 45 f0             	mov    -0x10(%ebp),%eax
  400fbd:	0f b6 00             	movzbl (%eax),%eax
  400fc0:	38 c2                	cmp    %al,%dl
  400fc2:	75 0b                	jne    400fcf <strncmp+0x33>
  400fc4:	48                   	dec    %eax
  400fc5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  400fc8:	0f b6 00             	movzbl (%eax),%eax
  400fcb:	84 c0                	test   %al,%al
  400fcd:	75 1a                	jne    400fe9 <strncmp+0x4d>
            return *a - *b;
  400fcf:	48                   	dec    %eax
  400fd0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  400fd3:	0f b6 00             	movzbl (%eax),%eax
  400fd6:	0f be d0             	movsbl %al,%edx
  400fd9:	48                   	dec    %eax
  400fda:	8b 45 f0             	mov    -0x10(%ebp),%eax
  400fdd:	0f b6 00             	movzbl (%eax),%eax
  400fe0:	0f be c0             	movsbl %al,%eax
  400fe3:	29 c2                	sub    %eax,%edx
  400fe5:	89 d0                	mov    %edx,%eax
  400fe7:	eb 20                	jmp    401009 <strncmp+0x6d>
    return strcat(dest, src);
}

int strncmp(const char *a, const char *b, size_t n)
{
    for (; n--; ++a, ++b)
  400fe9:	48                   	dec    %eax
  400fea:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  400fee:	48                   	dec    %eax
  400fef:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  400ff3:	48                   	dec    %eax
  400ff4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  400ff7:	48                   	dec    %eax
  400ff8:	8d 50 ff             	lea    -0x1(%eax),%edx
  400ffb:	48                   	dec    %eax
  400ffc:	89 55 e8             	mov    %edx,-0x18(%ebp)
  400fff:	48                   	dec    %eax
  401000:	85 c0                	test   %eax,%eax
  401002:	75 ae                	jne    400fb2 <strncmp+0x16>
        if (*a != *b || *a == '\0')
            return *a - *b;

    return 0;
  401004:	b8 00 00 00 00       	mov    $0x0,%eax
}
  401009:	c9                   	leave  
  40100a:	c3                   	ret    

0040100b <strcmp>:

int strcmp(const char *a, const char *b)
{
  40100b:	55                   	push   %ebp
  40100c:	48                   	dec    %eax
  40100d:	89 e5                	mov    %esp,%ebp
  40100f:	48                   	dec    %eax
  401010:	83 ec 10             	sub    $0x10,%esp
  401013:	48                   	dec    %eax
  401014:	89 7d f8             	mov    %edi,-0x8(%ebp)
  401017:	48                   	dec    %eax
  401018:	89 75 f0             	mov    %esi,-0x10(%ebp)
    return strncmp(a, b, SIZE_MAX);
  40101b:	48                   	dec    %eax
  40101c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  40101f:	48                   	dec    %eax
  401020:	8b 45 f8             	mov    -0x8(%ebp),%eax
  401023:	48                   	dec    %eax
  401024:	c7 c2 ff ff ff ff    	mov    $0xffffffff,%edx
  40102a:	48                   	dec    %eax
  40102b:	89 ce                	mov    %ecx,%esi
  40102d:	48                   	dec    %eax
  40102e:	89 c7                	mov    %eax,%edi
  401030:	e8 67 ff ff ff       	call   400f9c <strncmp>
}
  401035:	c9                   	leave  
  401036:	c3                   	ret    

00401037 <strchr>:

char *strchr(const char *s, int c)
{
  401037:	55                   	push   %ebp
  401038:	48                   	dec    %eax
  401039:	89 e5                	mov    %esp,%ebp
  40103b:	48                   	dec    %eax
  40103c:	83 ec 0c             	sub    $0xc,%esp
  40103f:	48                   	dec    %eax
  401040:	89 7d f8             	mov    %edi,-0x8(%ebp)
  401043:	89 75 f4             	mov    %esi,-0xc(%ebp)
    while (*s != (char)c)
  401046:	eb 1a                	jmp    401062 <strchr+0x2b>
	if (*s++ == '\0')
  401048:	48                   	dec    %eax
  401049:	8b 45 f8             	mov    -0x8(%ebp),%eax
  40104c:	48                   	dec    %eax
  40104d:	8d 50 01             	lea    0x1(%eax),%edx
  401050:	48                   	dec    %eax
  401051:	89 55 f8             	mov    %edx,-0x8(%ebp)
  401054:	0f b6 00             	movzbl (%eax),%eax
  401057:	84 c0                	test   %al,%al
  401059:	75 07                	jne    401062 <strchr+0x2b>
	    return NULL;
  40105b:	b8 00 00 00 00       	mov    $0x0,%eax
  401060:	eb 12                	jmp    401074 <strchr+0x3d>
    return strncmp(a, b, SIZE_MAX);
}

char *strchr(const char *s, int c)
{
    while (*s != (char)c)
  401062:	48                   	dec    %eax
  401063:	8b 45 f8             	mov    -0x8(%ebp),%eax
  401066:	0f b6 10             	movzbl (%eax),%edx
  401069:	8b 45 f4             	mov    -0xc(%ebp),%eax
  40106c:	38 c2                	cmp    %al,%dl
  40106e:	75 d8                	jne    401048 <strchr+0x11>
	if (*s++ == '\0')
	    return NULL;
    return (char *)s;
  401070:	48                   	dec    %eax
  401071:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  401074:	c9                   	leave  
  401075:	c3                   	ret    

00401076 <strstr>:

char *strstr(const char *s1, const char *s2)
{
  401076:	55                   	push   %ebp
  401077:	48                   	dec    %eax
  401078:	89 e5                	mov    %esp,%ebp
  40107a:	48                   	dec    %eax
  40107b:	83 ec 20             	sub    $0x20,%esp
  40107e:	48                   	dec    %eax
  40107f:	89 7d e8             	mov    %edi,-0x18(%ebp)
  401082:	48                   	dec    %eax
  401083:	89 75 e0             	mov    %esi,-0x20(%ebp)
    size_t l1, l2;

    l2 = strlen(s2);
  401086:	48                   	dec    %eax
  401087:	8b 45 e0             	mov    -0x20(%ebp),%eax
  40108a:	48                   	dec    %eax
  40108b:	89 c7                	mov    %eax,%edi
  40108d:	e8 55 fe ff ff       	call   400ee7 <strlen>
  401092:	48                   	dec    %eax
  401093:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (!l2)
  401096:	48                   	dec    %eax
  401097:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  40109b:	75 06                	jne    4010a3 <strstr+0x2d>
	return (char *)s1;
  40109d:	48                   	dec    %eax
  40109e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4010a1:	eb 4c                	jmp    4010ef <strstr+0x79>
    l1 = strlen(s1);
  4010a3:	48                   	dec    %eax
  4010a4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4010a7:	48                   	dec    %eax
  4010a8:	89 c7                	mov    %eax,%edi
  4010aa:	e8 38 fe ff ff       	call   400ee7 <strlen>
  4010af:	48                   	dec    %eax
  4010b0:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (l1 >= l2) {
  4010b3:	eb 2b                	jmp    4010e0 <strstr+0x6a>
	l1--;
  4010b5:	48                   	dec    %eax
  4010b6:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
	if (!memcmp(s1, s2, l2))
  4010ba:	48                   	dec    %eax
  4010bb:	8b 55 f0             	mov    -0x10(%ebp),%edx
  4010be:	48                   	dec    %eax
  4010bf:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  4010c2:	48                   	dec    %eax
  4010c3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4010c6:	48                   	dec    %eax
  4010c7:	89 ce                	mov    %ecx,%esi
  4010c9:	48                   	dec    %eax
  4010ca:	89 c7                	mov    %eax,%edi
  4010cc:	e8 c8 00 00 00       	call   401199 <memcmp>
  4010d1:	85 c0                	test   %eax,%eax
  4010d3:	75 06                	jne    4010db <strstr+0x65>
	    return (char *)s1;
  4010d5:	48                   	dec    %eax
  4010d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4010d9:	eb 14                	jmp    4010ef <strstr+0x79>
	s1++;
  4010db:	48                   	dec    %eax
  4010dc:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)

    l2 = strlen(s2);
    if (!l2)
	return (char *)s1;
    l1 = strlen(s1);
    while (l1 >= l2) {
  4010e0:	48                   	dec    %eax
  4010e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  4010e4:	48                   	dec    %eax
  4010e5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  4010e8:	73 cb                	jae    4010b5 <strstr+0x3f>
	l1--;
	if (!memcmp(s1, s2, l2))
	    return (char *)s1;
	s1++;
    }
    return NULL;
  4010ea:	b8 00 00 00 00       	mov    $0x0,%eax
}
  4010ef:	c9                   	leave  
  4010f0:	c3                   	ret    

004010f1 <memset>:

void *memset(void *s, int c, size_t n)
{
  4010f1:	55                   	push   %ebp
  4010f2:	48                   	dec    %eax
  4010f3:	89 e5                	mov    %esp,%ebp
  4010f5:	48                   	dec    %eax
  4010f6:	83 ec 28             	sub    $0x28,%esp
  4010f9:	48                   	dec    %eax
  4010fa:	89 7d e8             	mov    %edi,-0x18(%ebp)
  4010fd:	89 75 e4             	mov    %esi,-0x1c(%ebp)
  401100:	48                   	dec    %eax
  401101:	89 55 d8             	mov    %edx,-0x28(%ebp)
    size_t i;
    char *a = s;
  401104:	48                   	dec    %eax
  401105:	8b 45 e8             	mov    -0x18(%ebp),%eax
  401108:	48                   	dec    %eax
  401109:	89 45 f0             	mov    %eax,-0x10(%ebp)

    for (i = 0; i < n; ++i)
  40110c:	48                   	dec    %eax
  40110d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  401114:	eb 15                	jmp    40112b <memset+0x3a>
        a[i] = c;
  401116:	48                   	dec    %eax
  401117:	8b 45 f8             	mov    -0x8(%ebp),%eax
  40111a:	48                   	dec    %eax
  40111b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  40111e:	48                   	dec    %eax
  40111f:	01 c2                	add    %eax,%edx
  401121:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  401124:	88 02                	mov    %al,(%edx)
void *memset(void *s, int c, size_t n)
{
    size_t i;
    char *a = s;

    for (i = 0; i < n; ++i)
  401126:	48                   	dec    %eax
  401127:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  40112b:	48                   	dec    %eax
  40112c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  40112f:	48                   	dec    %eax
  401130:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  401133:	72 e1                	jb     401116 <memset+0x25>
        a[i] = c;

    return s;
  401135:	48                   	dec    %eax
  401136:	8b 45 e8             	mov    -0x18(%ebp),%eax
}
  401139:	c9                   	leave  
  40113a:	c3                   	ret    

0040113b <memcpy>:

void *memcpy(void *dest, const void *src, size_t n)
{
  40113b:	55                   	push   %ebp
  40113c:	48                   	dec    %eax
  40113d:	89 e5                	mov    %esp,%ebp
  40113f:	48                   	dec    %eax
  401140:	83 ec 38             	sub    $0x38,%esp
  401143:	48                   	dec    %eax
  401144:	89 7d d8             	mov    %edi,-0x28(%ebp)
  401147:	48                   	dec    %eax
  401148:	89 75 d0             	mov    %esi,-0x30(%ebp)
  40114b:	48                   	dec    %eax
  40114c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    size_t i;
    char *a = dest;
  40114f:	48                   	dec    %eax
  401150:	8b 45 d8             	mov    -0x28(%ebp),%eax
  401153:	48                   	dec    %eax
  401154:	89 45 f0             	mov    %eax,-0x10(%ebp)
    const char *b = src;
  401157:	48                   	dec    %eax
  401158:	8b 45 d0             	mov    -0x30(%ebp),%eax
  40115b:	48                   	dec    %eax
  40115c:	89 45 e8             	mov    %eax,-0x18(%ebp)

    for (i = 0; i < n; ++i)
  40115f:	48                   	dec    %eax
  401160:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  401167:	eb 20                	jmp    401189 <memcpy+0x4e>
        a[i] = b[i];
  401169:	48                   	dec    %eax
  40116a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  40116d:	48                   	dec    %eax
  40116e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  401171:	48                   	dec    %eax
  401172:	01 c2                	add    %eax,%edx
  401174:	48                   	dec    %eax
  401175:	8b 45 f8             	mov    -0x8(%ebp),%eax
  401178:	48                   	dec    %eax
  401179:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  40117c:	48                   	dec    %eax
  40117d:	01 c8                	add    %ecx,%eax
  40117f:	0f b6 00             	movzbl (%eax),%eax
  401182:	88 02                	mov    %al,(%edx)
{
    size_t i;
    char *a = dest;
    const char *b = src;

    for (i = 0; i < n; ++i)
  401184:	48                   	dec    %eax
  401185:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  401189:	48                   	dec    %eax
  40118a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  40118d:	48                   	dec    %eax
  40118e:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  401191:	72 d6                	jb     401169 <memcpy+0x2e>
        a[i] = b[i];

    return dest;
  401193:	48                   	dec    %eax
  401194:	8b 45 d8             	mov    -0x28(%ebp),%eax
}
  401197:	c9                   	leave  
  401198:	c3                   	ret    

00401199 <memcmp>:

int memcmp(const void *s1, const void *s2, size_t n)
{
  401199:	55                   	push   %ebp
  40119a:	48                   	dec    %eax
  40119b:	89 e5                	mov    %esp,%ebp
  40119d:	48                   	dec    %eax
  40119e:	83 ec 38             	sub    $0x38,%esp
  4011a1:	48                   	dec    %eax
  4011a2:	89 7d d8             	mov    %edi,-0x28(%ebp)
  4011a5:	48                   	dec    %eax
  4011a6:	89 75 d0             	mov    %esi,-0x30(%ebp)
  4011a9:	48                   	dec    %eax
  4011aa:	89 55 c8             	mov    %edx,-0x38(%ebp)
    const unsigned char *a = s1, *b = s2;
  4011ad:	48                   	dec    %eax
  4011ae:	8b 45 d8             	mov    -0x28(%ebp),%eax
  4011b1:	48                   	dec    %eax
  4011b2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  4011b5:	48                   	dec    %eax
  4011b6:	8b 45 d0             	mov    -0x30(%ebp),%eax
  4011b9:	48                   	dec    %eax
  4011ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
    int ret = 0;
  4011bd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)

    while (n--) {
  4011c4:	eb 2d                	jmp    4011f3 <memcmp+0x5a>
	ret = *a - *b;
  4011c6:	48                   	dec    %eax
  4011c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  4011ca:	0f b6 00             	movzbl (%eax),%eax
  4011cd:	0f b6 d0             	movzbl %al,%edx
  4011d0:	48                   	dec    %eax
  4011d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  4011d4:	0f b6 00             	movzbl (%eax),%eax
  4011d7:	0f b6 c0             	movzbl %al,%eax
  4011da:	29 c2                	sub    %eax,%edx
  4011dc:	89 d0                	mov    %edx,%eax
  4011de:	89 45 ec             	mov    %eax,-0x14(%ebp)
	if (ret)
  4011e1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  4011e5:	74 02                	je     4011e9 <memcmp+0x50>
	    break;
  4011e7:	eb 1b                	jmp    401204 <memcmp+0x6b>
	++a, ++b;
  4011e9:	48                   	dec    %eax
  4011ea:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  4011ee:	48                   	dec    %eax
  4011ef:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
int memcmp(const void *s1, const void *s2, size_t n)
{
    const unsigned char *a = s1, *b = s2;
    int ret = 0;

    while (n--) {
  4011f3:	48                   	dec    %eax
  4011f4:	8b 45 c8             	mov    -0x38(%ebp),%eax
  4011f7:	48                   	dec    %eax
  4011f8:	8d 50 ff             	lea    -0x1(%eax),%edx
  4011fb:	48                   	dec    %eax
  4011fc:	89 55 c8             	mov    %edx,-0x38(%ebp)
  4011ff:	48                   	dec    %eax
  401200:	85 c0                	test   %eax,%eax
  401202:	75 c2                	jne    4011c6 <memcmp+0x2d>
	ret = *a - *b;
	if (ret)
	    break;
	++a, ++b;
    }
    return ret;
  401204:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
  401207:	c9                   	leave  
  401208:	c3                   	ret    

00401209 <memmove>:

void *memmove(void *dest, const void *src, size_t n)
{
  401209:	55                   	push   %ebp
  40120a:	48                   	dec    %eax
  40120b:	89 e5                	mov    %esp,%ebp
  40120d:	48                   	dec    %eax
  40120e:	83 ec 28             	sub    $0x28,%esp
  401211:	48                   	dec    %eax
  401212:	89 7d e8             	mov    %edi,-0x18(%ebp)
  401215:	48                   	dec    %eax
  401216:	89 75 e0             	mov    %esi,-0x20(%ebp)
  401219:	48                   	dec    %eax
  40121a:	89 55 d8             	mov    %edx,-0x28(%ebp)
    const unsigned char *s = src;
  40121d:	48                   	dec    %eax
  40121e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  401221:	48                   	dec    %eax
  401222:	89 45 f8             	mov    %eax,-0x8(%ebp)
    unsigned char *d = dest;
  401225:	48                   	dec    %eax
  401226:	8b 45 e8             	mov    -0x18(%ebp),%eax
  401229:	48                   	dec    %eax
  40122a:	89 45 f0             	mov    %eax,-0x10(%ebp)

    if (d <= s) {
  40122d:	48                   	dec    %eax
  40122e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401231:	48                   	dec    %eax
  401232:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  401235:	77 32                	ja     401269 <memmove+0x60>
	while (n--)
  401237:	eb 1d                	jmp    401256 <memmove+0x4d>
	    *d++ = *s++;
  401239:	48                   	dec    %eax
  40123a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  40123d:	48                   	dec    %eax
  40123e:	8d 50 01             	lea    0x1(%eax),%edx
  401241:	48                   	dec    %eax
  401242:	89 55 f0             	mov    %edx,-0x10(%ebp)
  401245:	48                   	dec    %eax
  401246:	8b 55 f8             	mov    -0x8(%ebp),%edx
  401249:	48                   	dec    %eax
  40124a:	8d 4a 01             	lea    0x1(%edx),%ecx
  40124d:	48                   	dec    %eax
  40124e:	89 4d f8             	mov    %ecx,-0x8(%ebp)
  401251:	0f b6 12             	movzbl (%edx),%edx
  401254:	88 10                	mov    %dl,(%eax)
{
    const unsigned char *s = src;
    unsigned char *d = dest;

    if (d <= s) {
	while (n--)
  401256:	48                   	dec    %eax
  401257:	8b 45 d8             	mov    -0x28(%ebp),%eax
  40125a:	48                   	dec    %eax
  40125b:	8d 50 ff             	lea    -0x1(%eax),%edx
  40125e:	48                   	dec    %eax
  40125f:	89 55 d8             	mov    %edx,-0x28(%ebp)
  401262:	48                   	dec    %eax
  401263:	85 c0                	test   %eax,%eax
  401265:	75 d2                	jne    401239 <memmove+0x30>
  401267:	eb 3a                	jmp    4012a3 <memmove+0x9a>
	    *d++ = *s++;
    } else {
	d += n, s += n;
  401269:	48                   	dec    %eax
  40126a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  40126d:	48                   	dec    %eax
  40126e:	01 45 f0             	add    %eax,-0x10(%ebp)
  401271:	48                   	dec    %eax
  401272:	8b 45 d8             	mov    -0x28(%ebp),%eax
  401275:	48                   	dec    %eax
  401276:	01 45 f8             	add    %eax,-0x8(%ebp)
	while (n--)
  401279:	eb 17                	jmp    401292 <memmove+0x89>
	    *--d = *--s;
  40127b:	48                   	dec    %eax
  40127c:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
  401280:	48                   	dec    %eax
  401281:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
  401285:	48                   	dec    %eax
  401286:	8b 45 f8             	mov    -0x8(%ebp),%eax
  401289:	0f b6 10             	movzbl (%eax),%edx
  40128c:	48                   	dec    %eax
  40128d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401290:	88 10                	mov    %dl,(%eax)
    if (d <= s) {
	while (n--)
	    *d++ = *s++;
    } else {
	d += n, s += n;
	while (n--)
  401292:	48                   	dec    %eax
  401293:	8b 45 d8             	mov    -0x28(%ebp),%eax
  401296:	48                   	dec    %eax
  401297:	8d 50 ff             	lea    -0x1(%eax),%edx
  40129a:	48                   	dec    %eax
  40129b:	89 55 d8             	mov    %edx,-0x28(%ebp)
  40129e:	48                   	dec    %eax
  40129f:	85 c0                	test   %eax,%eax
  4012a1:	75 d8                	jne    40127b <memmove+0x72>
	    *--d = *--s;
    }
    return dest;
  4012a3:	48                   	dec    %eax
  4012a4:	8b 45 e8             	mov    -0x18(%ebp),%eax
}
  4012a7:	c9                   	leave  
  4012a8:	c3                   	ret    

004012a9 <memchr>:

void *memchr(const void *s, int c, size_t n)
{
  4012a9:	55                   	push   %ebp
  4012aa:	48                   	dec    %eax
  4012ab:	89 e5                	mov    %esp,%ebp
  4012ad:	48                   	dec    %eax
  4012ae:	83 ec 28             	sub    $0x28,%esp
  4012b1:	48                   	dec    %eax
  4012b2:	89 7d e8             	mov    %edi,-0x18(%ebp)
  4012b5:	89 75 e4             	mov    %esi,-0x1c(%ebp)
  4012b8:	48                   	dec    %eax
  4012b9:	89 55 d8             	mov    %edx,-0x28(%ebp)
    const unsigned char *str = s, chr = (unsigned char)c;
  4012bc:	48                   	dec    %eax
  4012bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4012c0:	48                   	dec    %eax
  4012c1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  4012c4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  4012c7:	88 45 f7             	mov    %al,-0x9(%ebp)

    while (n--)
  4012ca:	eb 1e                	jmp    4012ea <memchr+0x41>
	if (*str++ == chr)
  4012cc:	48                   	dec    %eax
  4012cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  4012d0:	48                   	dec    %eax
  4012d1:	8d 50 01             	lea    0x1(%eax),%edx
  4012d4:	48                   	dec    %eax
  4012d5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  4012d8:	0f b6 00             	movzbl (%eax),%eax
  4012db:	3a 45 f7             	cmp    -0x9(%ebp),%al
  4012de:	75 0a                	jne    4012ea <memchr+0x41>
	    return (void *)(str - 1);
  4012e0:	48                   	dec    %eax
  4012e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  4012e4:	48                   	dec    %eax
  4012e5:	83 e8 01             	sub    $0x1,%eax
  4012e8:	eb 16                	jmp    401300 <memchr+0x57>

void *memchr(const void *s, int c, size_t n)
{
    const unsigned char *str = s, chr = (unsigned char)c;

    while (n--)
  4012ea:	48                   	dec    %eax
  4012eb:	8b 45 d8             	mov    -0x28(%ebp),%eax
  4012ee:	48                   	dec    %eax
  4012ef:	8d 50 ff             	lea    -0x1(%eax),%edx
  4012f2:	48                   	dec    %eax
  4012f3:	89 55 d8             	mov    %edx,-0x28(%ebp)
  4012f6:	48                   	dec    %eax
  4012f7:	85 c0                	test   %eax,%eax
  4012f9:	75 d1                	jne    4012cc <memchr+0x23>
	if (*str++ == chr)
	    return (void *)(str - 1);
    return NULL;
  4012fb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  401300:	c9                   	leave  
  401301:	c3                   	ret    

00401302 <atol>:

long atol(const char *ptr)
{
  401302:	55                   	push   %ebp
  401303:	48                   	dec    %eax
  401304:	89 e5                	mov    %esp,%ebp
  401306:	48                   	dec    %eax
  401307:	83 ec 28             	sub    $0x28,%esp
  40130a:	48                   	dec    %eax
  40130b:	89 7d d8             	mov    %edi,-0x28(%ebp)
    long acc = 0;
  40130e:	48                   	dec    %eax
  40130f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    const char *s = ptr;
  401316:	48                   	dec    %eax
  401317:	8b 45 d8             	mov    -0x28(%ebp),%eax
  40131a:	48                   	dec    %eax
  40131b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    int neg, c;

    while (*s == ' ' || *s == '\t')
  40131e:	eb 05                	jmp    401325 <atol+0x23>
        s++;
  401320:	48                   	dec    %eax
  401321:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
{
    long acc = 0;
    const char *s = ptr;
    int neg, c;

    while (*s == ' ' || *s == '\t')
  401325:	48                   	dec    %eax
  401326:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401329:	0f b6 00             	movzbl (%eax),%eax
  40132c:	3c 20                	cmp    $0x20,%al
  40132e:	74 f0                	je     401320 <atol+0x1e>
  401330:	48                   	dec    %eax
  401331:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401334:	0f b6 00             	movzbl (%eax),%eax
  401337:	3c 09                	cmp    $0x9,%al
  401339:	74 e5                	je     401320 <atol+0x1e>
        s++;
    if (*s == '-'){
  40133b:	48                   	dec    %eax
  40133c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  40133f:	0f b6 00             	movzbl (%eax),%eax
  401342:	3c 2d                	cmp    $0x2d,%al
  401344:	75 0e                	jne    401354 <atol+0x52>
        neg = 1;
  401346:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
        s++;
  40134d:	48                   	dec    %eax
  40134e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  401352:	eb 19                	jmp    40136d <atol+0x6b>
    } else {
        neg = 0;
  401354:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (*s == '+')
  40135b:	48                   	dec    %eax
  40135c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  40135f:	0f b6 00             	movzbl (%eax),%eax
  401362:	3c 2b                	cmp    $0x2b,%al
  401364:	75 07                	jne    40136d <atol+0x6b>
            s++;
  401366:	48                   	dec    %eax
  401367:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    }

    while (*s) {
  40136b:	eb 4d                	jmp    4013ba <atol+0xb8>
  40136d:	eb 4b                	jmp    4013ba <atol+0xb8>
        if (*s < '0' || *s > '9')
  40136f:	48                   	dec    %eax
  401370:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401373:	0f b6 00             	movzbl (%eax),%eax
  401376:	3c 2f                	cmp    $0x2f,%al
  401378:	7e 4b                	jle    4013c5 <atol+0xc3>
  40137a:	48                   	dec    %eax
  40137b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  40137e:	0f b6 00             	movzbl (%eax),%eax
  401381:	3c 39                	cmp    $0x39,%al
  401383:	7f 40                	jg     4013c5 <atol+0xc3>
            break;
        c = *s - '0';
  401385:	48                   	dec    %eax
  401386:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401389:	0f b6 00             	movzbl (%eax),%eax
  40138c:	0f be c0             	movsbl %al,%eax
  40138f:	83 e8 30             	sub    $0x30,%eax
  401392:	89 45 e8             	mov    %eax,-0x18(%ebp)
        acc = acc * 10 + c;
  401395:	48                   	dec    %eax
  401396:	8b 55 f8             	mov    -0x8(%ebp),%edx
  401399:	48                   	dec    %eax
  40139a:	89 d0                	mov    %edx,%eax
  40139c:	48                   	dec    %eax
  40139d:	c1 e0 02             	shl    $0x2,%eax
  4013a0:	48                   	dec    %eax
  4013a1:	01 d0                	add    %edx,%eax
  4013a3:	48                   	dec    %eax
  4013a4:	01 c0                	add    %eax,%eax
  4013a6:	48                   	dec    %eax
  4013a7:	89 c2                	mov    %eax,%edx
  4013a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4013ac:	48                   	dec    %eax
  4013ad:	98                   	cwtl   
  4013ae:	48                   	dec    %eax
  4013af:	01 d0                	add    %edx,%eax
  4013b1:	48                   	dec    %eax
  4013b2:	89 45 f8             	mov    %eax,-0x8(%ebp)
        s++;
  4013b5:	48                   	dec    %eax
  4013b6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
        neg = 0;
        if (*s == '+')
            s++;
    }

    while (*s) {
  4013ba:	48                   	dec    %eax
  4013bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  4013be:	0f b6 00             	movzbl (%eax),%eax
  4013c1:	84 c0                	test   %al,%al
  4013c3:	75 aa                	jne    40136f <atol+0x6d>
        c = *s - '0';
        acc = acc * 10 + c;
        s++;
    }

    if (neg)
  4013c5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  4013c9:	74 04                	je     4013cf <atol+0xcd>
        acc = -acc;
  4013cb:	48                   	dec    %eax
  4013cc:	f7 5d f8             	negl   -0x8(%ebp)

    return acc;
  4013cf:	48                   	dec    %eax
  4013d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  4013d3:	c9                   	leave  
  4013d4:	c3                   	ret    

004013d5 <simple_glob>:
    return NULL;
}
*/
/* Very simple glob matching. Allows '*' at beginning and end of pattern. */
bool simple_glob(const char *text, const char *pattern)
{
  4013d5:	55                   	push   %ebp
  4013d6:	48                   	dec    %eax
  4013d7:	89 e5                	mov    %esp,%ebp
  4013d9:	41                   	inc    %ecx
  4013da:	57                   	push   %edi
  4013db:	41                   	inc    %ecx
  4013dc:	56                   	push   %esi
  4013dd:	41                   	inc    %ecx
  4013de:	55                   	push   %ebp
  4013df:	41                   	inc    %ecx
  4013e0:	54                   	push   %esp
  4013e1:	53                   	push   %ebx
  4013e2:	48                   	dec    %eax
  4013e3:	83 ec 48             	sub    $0x48,%esp
  4013e6:	48                   	dec    %eax
  4013e7:	89 7d 98             	mov    %edi,-0x68(%ebp)
  4013ea:	48                   	dec    %eax
  4013eb:	89 75 90             	mov    %esi,-0x70(%ebp)
  4013ee:	48                   	dec    %eax
  4013ef:	89 e0                	mov    %esp,%eax
  4013f1:	48                   	dec    %eax
  4013f2:	89 c3                	mov    %eax,%ebx
	bool star_start = false;
  4013f4:	c6 45 cf 00          	movb   $0x0,-0x31(%ebp)
	bool star_end = false;
  4013f8:	c6 45 ce 00          	movb   $0x0,-0x32(%ebp)
	size_t n = strlen(pattern);
  4013fc:	48                   	dec    %eax
  4013fd:	8b 45 90             	mov    -0x70(%ebp),%eax
  401400:	48                   	dec    %eax
  401401:	89 c7                	mov    %eax,%edi
  401403:	e8 df fa ff ff       	call   400ee7 <strlen>
  401408:	48                   	dec    %eax
  401409:	89 45 c0             	mov    %eax,-0x40(%ebp)
	char copy[n + 1];
  40140c:	48                   	dec    %eax
  40140d:	8b 45 c0             	mov    -0x40(%ebp),%eax
  401410:	48                   	dec    %eax
  401411:	83 c0 01             	add    $0x1,%eax
  401414:	48                   	dec    %eax
  401415:	89 c2                	mov    %eax,%edx
  401417:	48                   	dec    %eax
  401418:	83 ea 01             	sub    $0x1,%edx
  40141b:	48                   	dec    %eax
  40141c:	89 55 b8             	mov    %edx,-0x48(%ebp)
  40141f:	49                   	dec    %ecx
  401420:	89 c6                	mov    %eax,%esi
  401422:	41                   	inc    %ecx
  401423:	bf 00 00 00 00       	mov    $0x0,%edi
  401428:	49                   	dec    %ecx
  401429:	89 c4                	mov    %eax,%esp
  40142b:	41                   	inc    %ecx
  40142c:	bd 00 00 00 00       	mov    $0x0,%ebp
  401431:	ba 10 00 00 00       	mov    $0x10,%edx
  401436:	48                   	dec    %eax
  401437:	83 ea 01             	sub    $0x1,%edx
  40143a:	48                   	dec    %eax
  40143b:	01 d0                	add    %edx,%eax
  40143d:	b9 10 00 00 00       	mov    $0x10,%ecx
  401442:	ba 00 00 00 00       	mov    $0x0,%edx
  401447:	48                   	dec    %eax
  401448:	f7 f1                	div    %ecx
  40144a:	48                   	dec    %eax
  40144b:	6b c0 10             	imul   $0x10,%eax,%eax
  40144e:	48                   	dec    %eax
  40144f:	29 c4                	sub    %eax,%esp
  401451:	48                   	dec    %eax
  401452:	89 e0                	mov    %esp,%eax
  401454:	48                   	dec    %eax
  401455:	83 c0 00             	add    $0x0,%eax
  401458:	48                   	dec    %eax
  401459:	89 45 b0             	mov    %eax,-0x50(%ebp)

	if (pattern[0] == '*') {
  40145c:	48                   	dec    %eax
  40145d:	8b 45 90             	mov    -0x70(%ebp),%eax
  401460:	0f b6 00             	movzbl (%eax),%eax
  401463:	3c 2a                	cmp    $0x2a,%al
  401465:	75 0e                	jne    401475 <simple_glob+0xa0>
		pattern += 1;
  401467:	48                   	dec    %eax
  401468:	83 45 90 01          	addl   $0x1,-0x70(%ebp)
		n -= 1;
  40146c:	48                   	dec    %eax
  40146d:	83 6d c0 01          	subl   $0x1,-0x40(%ebp)
		star_start = true;
  401471:	c6 45 cf 01          	movb   $0x1,-0x31(%ebp)
	}

	strcpy(copy, pattern);
  401475:	48                   	dec    %eax
  401476:	8b 45 b0             	mov    -0x50(%ebp),%eax
  401479:	48                   	dec    %eax
  40147a:	8b 55 90             	mov    -0x70(%ebp),%edx
  40147d:	48                   	dec    %eax
  40147e:	89 d6                	mov    %edx,%esi
  401480:	48                   	dec    %eax
  401481:	89 c7                	mov    %eax,%edi
  401483:	e8 e8 fa ff ff       	call   400f70 <strcpy>

	if (n > 0 && pattern[n - 1] == '*') {
  401488:	48                   	dec    %eax
  401489:	83 7d c0 00          	cmpl   $0x0,-0x40(%ebp)
  40148d:	74 2d                	je     4014bc <simple_glob+0xe7>
  40148f:	48                   	dec    %eax
  401490:	8b 45 c0             	mov    -0x40(%ebp),%eax
  401493:	48                   	dec    %eax
  401494:	8d 50 ff             	lea    -0x1(%eax),%edx
  401497:	48                   	dec    %eax
  401498:	8b 45 90             	mov    -0x70(%ebp),%eax
  40149b:	48                   	dec    %eax
  40149c:	01 d0                	add    %edx,%eax
  40149e:	0f b6 00             	movzbl (%eax),%eax
  4014a1:	3c 2a                	cmp    $0x2a,%al
  4014a3:	75 17                	jne    4014bc <simple_glob+0xe7>
		n -= 1;
  4014a5:	48                   	dec    %eax
  4014a6:	83 6d c0 01          	subl   $0x1,-0x40(%ebp)
		copy[n] = '\0';
  4014aa:	48                   	dec    %eax
  4014ab:	8b 55 b0             	mov    -0x50(%ebp),%edx
  4014ae:	48                   	dec    %eax
  4014af:	8b 45 c0             	mov    -0x40(%ebp),%eax
  4014b2:	48                   	dec    %eax
  4014b3:	01 d0                	add    %edx,%eax
  4014b5:	c6 00 00             	movb   $0x0,(%eax)
		star_end = true;
  4014b8:	c6 45 ce 01          	movb   $0x1,-0x32(%ebp)
	}

	if (star_start && star_end)
  4014bc:	80 7d cf 00          	cmpb   $0x0,-0x31(%ebp)
  4014c0:	74 24                	je     4014e6 <simple_glob+0x111>
  4014c2:	80 7d ce 00          	cmpb   $0x0,-0x32(%ebp)
  4014c6:	74 1e                	je     4014e6 <simple_glob+0x111>
		return strstr(text, copy);
  4014c8:	48                   	dec    %eax
  4014c9:	8b 55 b0             	mov    -0x50(%ebp),%edx
  4014cc:	48                   	dec    %eax
  4014cd:	8b 45 98             	mov    -0x68(%ebp),%eax
  4014d0:	48                   	dec    %eax
  4014d1:	89 d6                	mov    %edx,%esi
  4014d3:	48                   	dec    %eax
  4014d4:	89 c7                	mov    %eax,%edi
  4014d6:	e8 9b fb ff ff       	call   401076 <strstr>
  4014db:	48                   	dec    %eax
  4014dc:	85 c0                	test   %eax,%eax
  4014de:	0f 95 c0             	setne  %al
  4014e1:	e9 91 00 00 00       	jmp    401577 <simple_glob+0x1a2>

	if (star_end)
  4014e6:	80 7d ce 00          	cmpb   $0x0,-0x32(%ebp)
  4014ea:	74 1c                	je     401508 <simple_glob+0x133>
		return strstr(text, copy) == text;
  4014ec:	48                   	dec    %eax
  4014ed:	8b 55 b0             	mov    -0x50(%ebp),%edx
  4014f0:	48                   	dec    %eax
  4014f1:	8b 45 98             	mov    -0x68(%ebp),%eax
  4014f4:	48                   	dec    %eax
  4014f5:	89 d6                	mov    %edx,%esi
  4014f7:	48                   	dec    %eax
  4014f8:	89 c7                	mov    %eax,%edi
  4014fa:	e8 77 fb ff ff       	call   401076 <strstr>
  4014ff:	48                   	dec    %eax
  401500:	3b 45 98             	cmp    -0x68(%ebp),%eax
  401503:	0f 94 c0             	sete   %al
  401506:	eb 6f                	jmp    401577 <simple_glob+0x1a2>

	if (star_start) {
  401508:	80 7d cf 00          	cmpb   $0x0,-0x31(%ebp)
  40150c:	74 51                	je     40155f <simple_glob+0x18a>
		size_t text_len = strlen(text);
  40150e:	48                   	dec    %eax
  40150f:	8b 45 98             	mov    -0x68(%ebp),%eax
  401512:	48                   	dec    %eax
  401513:	89 c7                	mov    %eax,%edi
  401515:	e8 cd f9 ff ff       	call   400ee7 <strlen>
  40151a:	48                   	dec    %eax
  40151b:	89 45 a8             	mov    %eax,-0x58(%ebp)
		const char *suffix;

		if (n > text_len)
  40151e:	48                   	dec    %eax
  40151f:	8b 45 c0             	mov    -0x40(%ebp),%eax
  401522:	48                   	dec    %eax
  401523:	3b 45 a8             	cmp    -0x58(%ebp),%eax
  401526:	76 07                	jbe    40152f <simple_glob+0x15a>
			return false;
  401528:	b8 00 00 00 00       	mov    $0x0,%eax
  40152d:	eb 48                	jmp    401577 <simple_glob+0x1a2>
		suffix = text + text_len - n;
  40152f:	48                   	dec    %eax
  401530:	8b 45 c0             	mov    -0x40(%ebp),%eax
  401533:	48                   	dec    %eax
  401534:	8b 55 a8             	mov    -0x58(%ebp),%edx
  401537:	48                   	dec    %eax
  401538:	29 c2                	sub    %eax,%edx
  40153a:	48                   	dec    %eax
  40153b:	8b 45 98             	mov    -0x68(%ebp),%eax
  40153e:	48                   	dec    %eax
  40153f:	01 d0                	add    %edx,%eax
  401541:	48                   	dec    %eax
  401542:	89 45 a0             	mov    %eax,-0x60(%ebp)
		return !strcmp(suffix, copy);
  401545:	48                   	dec    %eax
  401546:	8b 55 b0             	mov    -0x50(%ebp),%edx
  401549:	48                   	dec    %eax
  40154a:	8b 45 a0             	mov    -0x60(%ebp),%eax
  40154d:	48                   	dec    %eax
  40154e:	89 d6                	mov    %edx,%esi
  401550:	48                   	dec    %eax
  401551:	89 c7                	mov    %eax,%edi
  401553:	e8 b3 fa ff ff       	call   40100b <strcmp>
  401558:	85 c0                	test   %eax,%eax
  40155a:	0f 94 c0             	sete   %al
  40155d:	eb 18                	jmp    401577 <simple_glob+0x1a2>
	}

	return !strcmp(text, copy);
  40155f:	48                   	dec    %eax
  401560:	8b 55 b0             	mov    -0x50(%ebp),%edx
  401563:	48                   	dec    %eax
  401564:	8b 45 98             	mov    -0x68(%ebp),%eax
  401567:	48                   	dec    %eax
  401568:	89 d6                	mov    %edx,%esi
  40156a:	48                   	dec    %eax
  40156b:	89 c7                	mov    %eax,%edi
  40156d:	e8 99 fa ff ff       	call   40100b <strcmp>
  401572:	85 c0                	test   %eax,%eax
  401574:	0f 94 c0             	sete   %al
  401577:	48                   	dec    %eax
  401578:	89 dc                	mov    %ebx,%esp
}
  40157a:	48                   	dec    %eax
  40157b:	8d 65 d8             	lea    -0x28(%ebp),%esp
  40157e:	5b                   	pop    %ebx
  40157f:	41                   	inc    %ecx
  401580:	5c                   	pop    %esp
  401581:	41                   	inc    %ecx
  401582:	5d                   	pop    %ebp
  401583:	41                   	inc    %ecx
  401584:	5e                   	pop    %esi
  401585:	41                   	inc    %ecx
  401586:	5f                   	pop    %edi
  401587:	5d                   	pop    %ebp
  401588:	c3                   	ret    

00401589 <backtrace_frame>:
			   int max_depth);
#else
static inline int
backtrace_frame(const void *frame __unused, const void **return_addrs __unused,
		int max_depth __unused)
{
  401589:	55                   	push   %ebp
  40158a:	48                   	dec    %eax
  40158b:	89 e5                	mov    %esp,%ebp
  40158d:	48                   	dec    %eax
  40158e:	83 ec 14             	sub    $0x14,%esp
  401591:	48                   	dec    %eax
  401592:	89 7d f8             	mov    %edi,-0x8(%ebp)
  401595:	48                   	dec    %eax
  401596:	89 75 f0             	mov    %esi,-0x10(%ebp)
  401599:	89 55 ec             	mov    %edx,-0x14(%ebp)
	return 0;
  40159c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  4015a1:	c9                   	leave  
  4015a2:	c3                   	ret    

004015a3 <print_stack>:

#define MAX_DEPTH 20

static void print_stack(const void **return_addrs, int depth,
			bool top_is_return_address)
{
  4015a3:	55                   	push   %ebp
  4015a4:	48                   	dec    %eax
  4015a5:	89 e5                	mov    %esp,%ebp
  4015a7:	48                   	dec    %eax
  4015a8:	83 ec 20             	sub    $0x20,%esp
  4015ab:	48                   	dec    %eax
  4015ac:	89 7d e8             	mov    %edi,-0x18(%ebp)
  4015af:	89 75 e4             	mov    %esi,-0x1c(%ebp)
  4015b2:	89 d0                	mov    %edx,%eax
  4015b4:	88 45 e0             	mov    %al,-0x20(%ebp)
	int i = 0;
  4015b7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)

	printf("\tSTACK:");
  4015be:	bf 1f d4 40 00       	mov    $0x40d41f,%edi
  4015c3:	b8 00 00 00 00       	mov    $0x0,%eax
  4015c8:	e8 91 f7 ff ff       	call   400d5e <printf>

	/* @addr indicates a non-return address, as expected by the stack
	 * pretty printer script. */
	if (depth > 0 && !top_is_return_address) {
  4015cd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  4015d1:	7e 2a                	jle    4015fd <print_stack+0x5a>
  4015d3:	0f b6 45 e0          	movzbl -0x20(%ebp),%eax
  4015d7:	83 f0 01             	xor    $0x1,%eax
  4015da:	84 c0                	test   %al,%al
  4015dc:	74 1f                	je     4015fd <print_stack+0x5a>
		printf(" @%lx", (unsigned long) return_addrs[0]);
  4015de:	48                   	dec    %eax
  4015df:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4015e2:	48                   	dec    %eax
  4015e3:	8b 00                	mov    (%eax),%eax
  4015e5:	48                   	dec    %eax
  4015e6:	89 c6                	mov    %eax,%esi
  4015e8:	bf 27 d4 40 00       	mov    $0x40d427,%edi
  4015ed:	b8 00 00 00 00       	mov    $0x0,%eax
  4015f2:	e8 67 f7 ff ff       	call   400d5e <printf>
		i++;
  4015f7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
	}

	for (; i < depth; i++) {
  4015fb:	eb 2f                	jmp    40162c <print_stack+0x89>
  4015fd:	eb 2d                	jmp    40162c <print_stack+0x89>
		printf(" %lx", (unsigned long) return_addrs[i]);
  4015ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  401602:	48                   	dec    %eax
  401603:	98                   	cwtl   
  401604:	48                   	dec    %eax
  401605:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  40160c:	48                   	dec    %eax
  40160d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  401610:	48                   	dec    %eax
  401611:	01 d0                	add    %edx,%eax
  401613:	48                   	dec    %eax
  401614:	8b 00                	mov    (%eax),%eax
  401616:	48                   	dec    %eax
  401617:	89 c6                	mov    %eax,%esi
  401619:	bf 2d d4 40 00       	mov    $0x40d42d,%edi
  40161e:	b8 00 00 00 00       	mov    $0x0,%eax
  401623:	e8 36 f7 ff ff       	call   400d5e <printf>
	if (depth > 0 && !top_is_return_address) {
		printf(" @%lx", (unsigned long) return_addrs[0]);
		i++;
	}

	for (; i < depth; i++) {
  401628:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  40162c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  40162f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  401632:	7c cb                	jl     4015ff <print_stack+0x5c>
		printf(" %lx", (unsigned long) return_addrs[i]);
	}
	printf("\n");
  401634:	bf 32 d4 40 00       	mov    $0x40d432,%edi
  401639:	b8 00 00 00 00       	mov    $0x0,%eax
  40163e:	e8 1b f7 ff ff       	call   400d5e <printf>
}
  401643:	c9                   	leave  
  401644:	c3                   	ret    

00401645 <dump_stack>:

void dump_stack(void)
{
  401645:	55                   	push   %ebp
  401646:	48                   	dec    %eax
  401647:	89 e5                	mov    %esp,%ebp
  401649:	48                   	dec    %eax
  40164a:	81 ec b0 00 00 00    	sub    $0xb0,%esp
	const void *return_addrs[MAX_DEPTH];
	int depth;

	depth = backtrace(return_addrs, MAX_DEPTH);
  401650:	48                   	dec    %eax
  401651:	8d 85 58 ff ff ff    	lea    -0xa8(%ebp),%eax
  401657:	be 14 00 00 00       	mov    $0x14,%esi
  40165c:	48                   	dec    %eax
  40165d:	89 c7                	mov    %eax,%edi
  40165f:	e8 9c 00 00 00       	call   401700 <backtrace>
  401664:	89 45 fc             	mov    %eax,-0x4(%ebp)
	print_stack(&return_addrs[1], depth ? depth - 1 : 0, true);
  401667:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  40166b:	74 08                	je     401675 <dump_stack+0x30>
  40166d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  401670:	83 e8 01             	sub    $0x1,%eax
  401673:	eb 05                	jmp    40167a <dump_stack+0x35>
  401675:	b8 00 00 00 00       	mov    $0x0,%eax
  40167a:	48                   	dec    %eax
  40167b:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  401681:	48                   	dec    %eax
  401682:	8d 4a 08             	lea    0x8(%edx),%ecx
  401685:	ba 01 00 00 00       	mov    $0x1,%edx
  40168a:	89 c6                	mov    %eax,%esi
  40168c:	48                   	dec    %eax
  40168d:	89 cf                	mov    %ecx,%edi
  40168f:	e8 0f ff ff ff       	call   4015a3 <print_stack>
}
  401694:	c9                   	leave  
  401695:	c3                   	ret    

00401696 <dump_frame_stack>:

void dump_frame_stack(const void *instruction, const void *frame)
{
  401696:	55                   	push   %ebp
  401697:	48                   	dec    %eax
  401698:	89 e5                	mov    %esp,%ebp
  40169a:	48                   	dec    %eax
  40169b:	81 ec c0 00 00 00    	sub    $0xc0,%esp
  4016a1:	48                   	dec    %eax
  4016a2:	89 bd 48 ff ff ff    	mov    %edi,-0xb8(%ebp)
  4016a8:	48                   	dec    %eax
  4016a9:	89 b5 40 ff ff ff    	mov    %esi,-0xc0(%ebp)
	const void *return_addrs[MAX_DEPTH];
	int depth;

	return_addrs[0] = instruction;
  4016af:	48                   	dec    %eax
  4016b0:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  4016b6:	48                   	dec    %eax
  4016b7:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
	depth = backtrace_frame(frame, &return_addrs[1], MAX_DEPTH - 1);
  4016bd:	48                   	dec    %eax
  4016be:	8d 85 58 ff ff ff    	lea    -0xa8(%ebp),%eax
  4016c4:	48                   	dec    %eax
  4016c5:	8d 48 08             	lea    0x8(%eax),%ecx
  4016c8:	48                   	dec    %eax
  4016c9:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  4016cf:	ba 13 00 00 00       	mov    $0x13,%edx
  4016d4:	48                   	dec    %eax
  4016d5:	89 ce                	mov    %ecx,%esi
  4016d7:	48                   	dec    %eax
  4016d8:	89 c7                	mov    %eax,%edi
  4016da:	e8 aa fe ff ff       	call   401589 <backtrace_frame>
  4016df:	89 45 fc             	mov    %eax,-0x4(%ebp)
	print_stack(return_addrs, depth + 1, false);
  4016e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  4016e5:	8d 48 01             	lea    0x1(%eax),%ecx
  4016e8:	48                   	dec    %eax
  4016e9:	8d 85 58 ff ff ff    	lea    -0xa8(%ebp),%eax
  4016ef:	ba 00 00 00 00       	mov    $0x0,%edx
  4016f4:	89 ce                	mov    %ecx,%esi
  4016f6:	48                   	dec    %eax
  4016f7:	89 c7                	mov    %eax,%edi
  4016f9:	e8 a5 fe ff ff       	call   4015a3 <print_stack>
}
  4016fe:	c9                   	leave  
  4016ff:	c3                   	ret    

00401700 <backtrace>:

#ifndef HAVE_ARCH_BACKTRACE
int backtrace(const void **return_addrs, int max_depth)
{
  401700:	55                   	push   %ebp
  401701:	48                   	dec    %eax
  401702:	89 e5                	mov    %esp,%ebp
  401704:	48                   	dec    %eax
  401705:	83 ec 20             	sub    $0x20,%esp
  401708:	48                   	dec    %eax
  401709:	89 7d e8             	mov    %edi,-0x18(%ebp)
  40170c:	89 75 e4             	mov    %esi,-0x1c(%ebp)
	static int walking;
	int depth = 0;
  40170f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	void *addr;

	if (walking) {
  401716:	8b 05 e4 e8 04 00    	mov    0x4e8e4,%eax
  40171c:	85 c0                	test   %eax,%eax
  40171e:	74 19                	je     401739 <backtrace+0x39>
		printf("RECURSIVE STACK WALK!!!\n");
  401720:	bf 34 d4 40 00       	mov    $0x40d434,%edi
  401725:	b8 00 00 00 00       	mov    $0x0,%eax
  40172a:	e8 2f f6 ff ff       	call   400d5e <printf>
		return 0;
  40172f:	b8 00 00 00 00       	mov    $0x0,%eax
  401734:	e9 ff 06 00 00       	jmp    401e38 <backtrace+0x738>
	}
	walking = 1;
  401739:	c7 05 bd e8 04 00 01 	movl   $0x1,0x4e8bd
  401740:	00 00 00 
	if (!addr)							\
		goto done;						\
	return_addrs[i] = __builtin_extract_return_addr(addr);		\
	depth = i + 1;							\

	GET_RETURN_ADDRESS(0)
  401743:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  401747:	75 05                	jne    40174e <backtrace+0x4e>
  401749:	e9 dd 06 00 00       	jmp    401e2b <backtrace+0x72b>
  40174e:	48                   	dec    %eax
  40174f:	8b 45 08             	mov    0x8(%ebp),%eax
  401752:	48                   	dec    %eax
  401753:	89 45 f0             	mov    %eax,-0x10(%ebp)
  401756:	48                   	dec    %eax
  401757:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  40175b:	75 05                	jne    401762 <backtrace+0x62>
  40175d:	e9 c9 06 00 00       	jmp    401e2b <backtrace+0x72b>
  401762:	48                   	dec    %eax
  401763:	8b 55 f0             	mov    -0x10(%ebp),%edx
  401766:	48                   	dec    %eax
  401767:	8b 45 e8             	mov    -0x18(%ebp),%eax
  40176a:	48                   	dec    %eax
  40176b:	89 10                	mov    %edx,(%eax)
  40176d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	GET_RETURN_ADDRESS(1)
  401774:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  401778:	75 05                	jne    40177f <backtrace+0x7f>
  40177a:	e9 ac 06 00 00       	jmp    401e2b <backtrace+0x72b>
  40177f:	48                   	dec    %eax
  401780:	8b 45 00             	mov    0x0(%ebp),%eax
  401783:	48                   	dec    %eax
  401784:	8b 40 08             	mov    0x8(%eax),%eax
  401787:	48                   	dec    %eax
  401788:	89 45 f0             	mov    %eax,-0x10(%ebp)
  40178b:	48                   	dec    %eax
  40178c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  401790:	75 05                	jne    401797 <backtrace+0x97>
  401792:	e9 94 06 00 00       	jmp    401e2b <backtrace+0x72b>
  401797:	48                   	dec    %eax
  401798:	8b 45 e8             	mov    -0x18(%ebp),%eax
  40179b:	48                   	dec    %eax
  40179c:	8d 50 08             	lea    0x8(%eax),%edx
  40179f:	48                   	dec    %eax
  4017a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  4017a3:	48                   	dec    %eax
  4017a4:	89 02                	mov    %eax,(%edx)
  4017a6:	c7 45 fc 02 00 00 00 	movl   $0x2,-0x4(%ebp)
	GET_RETURN_ADDRESS(2)
  4017ad:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
  4017b1:	75 05                	jne    4017b8 <backtrace+0xb8>
  4017b3:	e9 73 06 00 00       	jmp    401e2b <backtrace+0x72b>
  4017b8:	48                   	dec    %eax
  4017b9:	8b 45 00             	mov    0x0(%ebp),%eax
  4017bc:	48                   	dec    %eax
  4017bd:	8b 00                	mov    (%eax),%eax
  4017bf:	48                   	dec    %eax
  4017c0:	8b 40 08             	mov    0x8(%eax),%eax
  4017c3:	48                   	dec    %eax
  4017c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  4017c7:	48                   	dec    %eax
  4017c8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  4017cc:	75 05                	jne    4017d3 <backtrace+0xd3>
  4017ce:	e9 58 06 00 00       	jmp    401e2b <backtrace+0x72b>
  4017d3:	48                   	dec    %eax
  4017d4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4017d7:	48                   	dec    %eax
  4017d8:	8d 50 10             	lea    0x10(%eax),%edx
  4017db:	48                   	dec    %eax
  4017dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  4017df:	48                   	dec    %eax
  4017e0:	89 02                	mov    %eax,(%edx)
  4017e2:	c7 45 fc 03 00 00 00 	movl   $0x3,-0x4(%ebp)
	GET_RETURN_ADDRESS(3)
  4017e9:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  4017ed:	75 05                	jne    4017f4 <backtrace+0xf4>
  4017ef:	e9 37 06 00 00       	jmp    401e2b <backtrace+0x72b>
  4017f4:	48                   	dec    %eax
  4017f5:	8b 45 00             	mov    0x0(%ebp),%eax
  4017f8:	48                   	dec    %eax
  4017f9:	8b 00                	mov    (%eax),%eax
  4017fb:	48                   	dec    %eax
  4017fc:	8b 00                	mov    (%eax),%eax
  4017fe:	48                   	dec    %eax
  4017ff:	8b 40 08             	mov    0x8(%eax),%eax
  401802:	48                   	dec    %eax
  401803:	89 45 f0             	mov    %eax,-0x10(%ebp)
  401806:	48                   	dec    %eax
  401807:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  40180b:	75 05                	jne    401812 <backtrace+0x112>
  40180d:	e9 19 06 00 00       	jmp    401e2b <backtrace+0x72b>
  401812:	48                   	dec    %eax
  401813:	8b 45 e8             	mov    -0x18(%ebp),%eax
  401816:	48                   	dec    %eax
  401817:	8d 50 18             	lea    0x18(%eax),%edx
  40181a:	48                   	dec    %eax
  40181b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  40181e:	48                   	dec    %eax
  40181f:	89 02                	mov    %eax,(%edx)
  401821:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
	GET_RETURN_ADDRESS(4)
  401828:	83 7d e4 04          	cmpl   $0x4,-0x1c(%ebp)
  40182c:	75 05                	jne    401833 <backtrace+0x133>
  40182e:	e9 f8 05 00 00       	jmp    401e2b <backtrace+0x72b>
  401833:	48                   	dec    %eax
  401834:	8b 45 00             	mov    0x0(%ebp),%eax
  401837:	48                   	dec    %eax
  401838:	8b 00                	mov    (%eax),%eax
  40183a:	48                   	dec    %eax
  40183b:	8b 00                	mov    (%eax),%eax
  40183d:	48                   	dec    %eax
  40183e:	8b 00                	mov    (%eax),%eax
  401840:	48                   	dec    %eax
  401841:	8b 40 08             	mov    0x8(%eax),%eax
  401844:	48                   	dec    %eax
  401845:	89 45 f0             	mov    %eax,-0x10(%ebp)
  401848:	48                   	dec    %eax
  401849:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  40184d:	75 05                	jne    401854 <backtrace+0x154>
  40184f:	e9 d7 05 00 00       	jmp    401e2b <backtrace+0x72b>
  401854:	48                   	dec    %eax
  401855:	8b 45 e8             	mov    -0x18(%ebp),%eax
  401858:	48                   	dec    %eax
  401859:	8d 50 20             	lea    0x20(%eax),%edx
  40185c:	48                   	dec    %eax
  40185d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401860:	48                   	dec    %eax
  401861:	89 02                	mov    %eax,(%edx)
  401863:	c7 45 fc 05 00 00 00 	movl   $0x5,-0x4(%ebp)
	GET_RETURN_ADDRESS(5)
  40186a:	83 7d e4 05          	cmpl   $0x5,-0x1c(%ebp)
  40186e:	75 05                	jne    401875 <backtrace+0x175>
  401870:	e9 b6 05 00 00       	jmp    401e2b <backtrace+0x72b>
  401875:	48                   	dec    %eax
  401876:	8b 45 00             	mov    0x0(%ebp),%eax
  401879:	48                   	dec    %eax
  40187a:	8b 00                	mov    (%eax),%eax
  40187c:	48                   	dec    %eax
  40187d:	8b 00                	mov    (%eax),%eax
  40187f:	48                   	dec    %eax
  401880:	8b 00                	mov    (%eax),%eax
  401882:	48                   	dec    %eax
  401883:	8b 00                	mov    (%eax),%eax
  401885:	48                   	dec    %eax
  401886:	8b 40 08             	mov    0x8(%eax),%eax
  401889:	48                   	dec    %eax
  40188a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  40188d:	48                   	dec    %eax
  40188e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  401892:	75 05                	jne    401899 <backtrace+0x199>
  401894:	e9 92 05 00 00       	jmp    401e2b <backtrace+0x72b>
  401899:	48                   	dec    %eax
  40189a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  40189d:	48                   	dec    %eax
  40189e:	8d 50 28             	lea    0x28(%eax),%edx
  4018a1:	48                   	dec    %eax
  4018a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  4018a5:	48                   	dec    %eax
  4018a6:	89 02                	mov    %eax,(%edx)
  4018a8:	c7 45 fc 06 00 00 00 	movl   $0x6,-0x4(%ebp)
	GET_RETURN_ADDRESS(6)
  4018af:	83 7d e4 06          	cmpl   $0x6,-0x1c(%ebp)
  4018b3:	75 05                	jne    4018ba <backtrace+0x1ba>
  4018b5:	e9 71 05 00 00       	jmp    401e2b <backtrace+0x72b>
  4018ba:	48                   	dec    %eax
  4018bb:	8b 45 00             	mov    0x0(%ebp),%eax
  4018be:	48                   	dec    %eax
  4018bf:	8b 00                	mov    (%eax),%eax
  4018c1:	48                   	dec    %eax
  4018c2:	8b 00                	mov    (%eax),%eax
  4018c4:	48                   	dec    %eax
  4018c5:	8b 00                	mov    (%eax),%eax
  4018c7:	48                   	dec    %eax
  4018c8:	8b 00                	mov    (%eax),%eax
  4018ca:	48                   	dec    %eax
  4018cb:	8b 00                	mov    (%eax),%eax
  4018cd:	48                   	dec    %eax
  4018ce:	8b 40 08             	mov    0x8(%eax),%eax
  4018d1:	48                   	dec    %eax
  4018d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  4018d5:	48                   	dec    %eax
  4018d6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  4018da:	75 05                	jne    4018e1 <backtrace+0x1e1>
  4018dc:	e9 4a 05 00 00       	jmp    401e2b <backtrace+0x72b>
  4018e1:	48                   	dec    %eax
  4018e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4018e5:	48                   	dec    %eax
  4018e6:	8d 50 30             	lea    0x30(%eax),%edx
  4018e9:	48                   	dec    %eax
  4018ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
  4018ed:	48                   	dec    %eax
  4018ee:	89 02                	mov    %eax,(%edx)
  4018f0:	c7 45 fc 07 00 00 00 	movl   $0x7,-0x4(%ebp)
	GET_RETURN_ADDRESS(7)
  4018f7:	83 7d e4 07          	cmpl   $0x7,-0x1c(%ebp)
  4018fb:	75 05                	jne    401902 <backtrace+0x202>
  4018fd:	e9 29 05 00 00       	jmp    401e2b <backtrace+0x72b>
  401902:	48                   	dec    %eax
  401903:	8b 45 00             	mov    0x0(%ebp),%eax
  401906:	48                   	dec    %eax
  401907:	8b 00                	mov    (%eax),%eax
  401909:	48                   	dec    %eax
  40190a:	8b 00                	mov    (%eax),%eax
  40190c:	48                   	dec    %eax
  40190d:	8b 00                	mov    (%eax),%eax
  40190f:	48                   	dec    %eax
  401910:	8b 00                	mov    (%eax),%eax
  401912:	48                   	dec    %eax
  401913:	8b 00                	mov    (%eax),%eax
  401915:	48                   	dec    %eax
  401916:	8b 00                	mov    (%eax),%eax
  401918:	48                   	dec    %eax
  401919:	8b 40 08             	mov    0x8(%eax),%eax
  40191c:	48                   	dec    %eax
  40191d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  401920:	48                   	dec    %eax
  401921:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  401925:	75 05                	jne    40192c <backtrace+0x22c>
  401927:	e9 ff 04 00 00       	jmp    401e2b <backtrace+0x72b>
  40192c:	48                   	dec    %eax
  40192d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  401930:	48                   	dec    %eax
  401931:	8d 50 38             	lea    0x38(%eax),%edx
  401934:	48                   	dec    %eax
  401935:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401938:	48                   	dec    %eax
  401939:	89 02                	mov    %eax,(%edx)
  40193b:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
	GET_RETURN_ADDRESS(8)
  401942:	83 7d e4 08          	cmpl   $0x8,-0x1c(%ebp)
  401946:	75 05                	jne    40194d <backtrace+0x24d>
  401948:	e9 de 04 00 00       	jmp    401e2b <backtrace+0x72b>
  40194d:	48                   	dec    %eax
  40194e:	8b 45 00             	mov    0x0(%ebp),%eax
  401951:	48                   	dec    %eax
  401952:	8b 00                	mov    (%eax),%eax
  401954:	48                   	dec    %eax
  401955:	8b 00                	mov    (%eax),%eax
  401957:	48                   	dec    %eax
  401958:	8b 00                	mov    (%eax),%eax
  40195a:	48                   	dec    %eax
  40195b:	8b 00                	mov    (%eax),%eax
  40195d:	48                   	dec    %eax
  40195e:	8b 00                	mov    (%eax),%eax
  401960:	48                   	dec    %eax
  401961:	8b 00                	mov    (%eax),%eax
  401963:	48                   	dec    %eax
  401964:	8b 00                	mov    (%eax),%eax
  401966:	48                   	dec    %eax
  401967:	8b 40 08             	mov    0x8(%eax),%eax
  40196a:	48                   	dec    %eax
  40196b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  40196e:	48                   	dec    %eax
  40196f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  401973:	75 05                	jne    40197a <backtrace+0x27a>
  401975:	e9 b1 04 00 00       	jmp    401e2b <backtrace+0x72b>
  40197a:	48                   	dec    %eax
  40197b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  40197e:	48                   	dec    %eax
  40197f:	8d 50 40             	lea    0x40(%eax),%edx
  401982:	48                   	dec    %eax
  401983:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401986:	48                   	dec    %eax
  401987:	89 02                	mov    %eax,(%edx)
  401989:	c7 45 fc 09 00 00 00 	movl   $0x9,-0x4(%ebp)
	GET_RETURN_ADDRESS(9)
  401990:	83 7d e4 09          	cmpl   $0x9,-0x1c(%ebp)
  401994:	75 05                	jne    40199b <backtrace+0x29b>
  401996:	e9 90 04 00 00       	jmp    401e2b <backtrace+0x72b>
  40199b:	48                   	dec    %eax
  40199c:	8b 45 00             	mov    0x0(%ebp),%eax
  40199f:	48                   	dec    %eax
  4019a0:	8b 00                	mov    (%eax),%eax
  4019a2:	48                   	dec    %eax
  4019a3:	8b 00                	mov    (%eax),%eax
  4019a5:	48                   	dec    %eax
  4019a6:	8b 00                	mov    (%eax),%eax
  4019a8:	48                   	dec    %eax
  4019a9:	8b 00                	mov    (%eax),%eax
  4019ab:	48                   	dec    %eax
  4019ac:	8b 00                	mov    (%eax),%eax
  4019ae:	48                   	dec    %eax
  4019af:	8b 00                	mov    (%eax),%eax
  4019b1:	48                   	dec    %eax
  4019b2:	8b 00                	mov    (%eax),%eax
  4019b4:	48                   	dec    %eax
  4019b5:	8b 00                	mov    (%eax),%eax
  4019b7:	48                   	dec    %eax
  4019b8:	8b 40 08             	mov    0x8(%eax),%eax
  4019bb:	48                   	dec    %eax
  4019bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  4019bf:	48                   	dec    %eax
  4019c0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  4019c4:	75 05                	jne    4019cb <backtrace+0x2cb>
  4019c6:	e9 60 04 00 00       	jmp    401e2b <backtrace+0x72b>
  4019cb:	48                   	dec    %eax
  4019cc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4019cf:	48                   	dec    %eax
  4019d0:	8d 50 48             	lea    0x48(%eax),%edx
  4019d3:	48                   	dec    %eax
  4019d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  4019d7:	48                   	dec    %eax
  4019d8:	89 02                	mov    %eax,(%edx)
  4019da:	c7 45 fc 0a 00 00 00 	movl   $0xa,-0x4(%ebp)
	GET_RETURN_ADDRESS(10)
  4019e1:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
  4019e5:	75 05                	jne    4019ec <backtrace+0x2ec>
  4019e7:	e9 3f 04 00 00       	jmp    401e2b <backtrace+0x72b>
  4019ec:	48                   	dec    %eax
  4019ed:	8b 45 00             	mov    0x0(%ebp),%eax
  4019f0:	48                   	dec    %eax
  4019f1:	8b 00                	mov    (%eax),%eax
  4019f3:	48                   	dec    %eax
  4019f4:	8b 00                	mov    (%eax),%eax
  4019f6:	48                   	dec    %eax
  4019f7:	8b 00                	mov    (%eax),%eax
  4019f9:	48                   	dec    %eax
  4019fa:	8b 00                	mov    (%eax),%eax
  4019fc:	48                   	dec    %eax
  4019fd:	8b 00                	mov    (%eax),%eax
  4019ff:	48                   	dec    %eax
  401a00:	8b 00                	mov    (%eax),%eax
  401a02:	48                   	dec    %eax
  401a03:	8b 00                	mov    (%eax),%eax
  401a05:	48                   	dec    %eax
  401a06:	8b 00                	mov    (%eax),%eax
  401a08:	48                   	dec    %eax
  401a09:	8b 00                	mov    (%eax),%eax
  401a0b:	48                   	dec    %eax
  401a0c:	8b 40 08             	mov    0x8(%eax),%eax
  401a0f:	48                   	dec    %eax
  401a10:	89 45 f0             	mov    %eax,-0x10(%ebp)
  401a13:	48                   	dec    %eax
  401a14:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  401a18:	75 05                	jne    401a1f <backtrace+0x31f>
  401a1a:	e9 0c 04 00 00       	jmp    401e2b <backtrace+0x72b>
  401a1f:	48                   	dec    %eax
  401a20:	8b 45 e8             	mov    -0x18(%ebp),%eax
  401a23:	48                   	dec    %eax
  401a24:	8d 50 50             	lea    0x50(%eax),%edx
  401a27:	48                   	dec    %eax
  401a28:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401a2b:	48                   	dec    %eax
  401a2c:	89 02                	mov    %eax,(%edx)
  401a2e:	c7 45 fc 0b 00 00 00 	movl   $0xb,-0x4(%ebp)
	GET_RETURN_ADDRESS(11)
  401a35:	83 7d e4 0b          	cmpl   $0xb,-0x1c(%ebp)
  401a39:	75 05                	jne    401a40 <backtrace+0x340>
  401a3b:	e9 eb 03 00 00       	jmp    401e2b <backtrace+0x72b>
  401a40:	48                   	dec    %eax
  401a41:	8b 45 00             	mov    0x0(%ebp),%eax
  401a44:	48                   	dec    %eax
  401a45:	8b 00                	mov    (%eax),%eax
  401a47:	48                   	dec    %eax
  401a48:	8b 00                	mov    (%eax),%eax
  401a4a:	48                   	dec    %eax
  401a4b:	8b 00                	mov    (%eax),%eax
  401a4d:	48                   	dec    %eax
  401a4e:	8b 00                	mov    (%eax),%eax
  401a50:	48                   	dec    %eax
  401a51:	8b 00                	mov    (%eax),%eax
  401a53:	48                   	dec    %eax
  401a54:	8b 00                	mov    (%eax),%eax
  401a56:	48                   	dec    %eax
  401a57:	8b 00                	mov    (%eax),%eax
  401a59:	48                   	dec    %eax
  401a5a:	8b 00                	mov    (%eax),%eax
  401a5c:	48                   	dec    %eax
  401a5d:	8b 00                	mov    (%eax),%eax
  401a5f:	48                   	dec    %eax
  401a60:	8b 00                	mov    (%eax),%eax
  401a62:	48                   	dec    %eax
  401a63:	8b 40 08             	mov    0x8(%eax),%eax
  401a66:	48                   	dec    %eax
  401a67:	89 45 f0             	mov    %eax,-0x10(%ebp)
  401a6a:	48                   	dec    %eax
  401a6b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  401a6f:	75 05                	jne    401a76 <backtrace+0x376>
  401a71:	e9 b5 03 00 00       	jmp    401e2b <backtrace+0x72b>
  401a76:	48                   	dec    %eax
  401a77:	8b 45 e8             	mov    -0x18(%ebp),%eax
  401a7a:	48                   	dec    %eax
  401a7b:	8d 50 58             	lea    0x58(%eax),%edx
  401a7e:	48                   	dec    %eax
  401a7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401a82:	48                   	dec    %eax
  401a83:	89 02                	mov    %eax,(%edx)
  401a85:	c7 45 fc 0c 00 00 00 	movl   $0xc,-0x4(%ebp)
	GET_RETURN_ADDRESS(12)
  401a8c:	83 7d e4 0c          	cmpl   $0xc,-0x1c(%ebp)
  401a90:	75 05                	jne    401a97 <backtrace+0x397>
  401a92:	e9 94 03 00 00       	jmp    401e2b <backtrace+0x72b>
  401a97:	48                   	dec    %eax
  401a98:	8b 45 00             	mov    0x0(%ebp),%eax
  401a9b:	48                   	dec    %eax
  401a9c:	8b 00                	mov    (%eax),%eax
  401a9e:	48                   	dec    %eax
  401a9f:	8b 00                	mov    (%eax),%eax
  401aa1:	48                   	dec    %eax
  401aa2:	8b 00                	mov    (%eax),%eax
  401aa4:	48                   	dec    %eax
  401aa5:	8b 00                	mov    (%eax),%eax
  401aa7:	48                   	dec    %eax
  401aa8:	8b 00                	mov    (%eax),%eax
  401aaa:	48                   	dec    %eax
  401aab:	8b 00                	mov    (%eax),%eax
  401aad:	48                   	dec    %eax
  401aae:	8b 00                	mov    (%eax),%eax
  401ab0:	48                   	dec    %eax
  401ab1:	8b 00                	mov    (%eax),%eax
  401ab3:	48                   	dec    %eax
  401ab4:	8b 00                	mov    (%eax),%eax
  401ab6:	48                   	dec    %eax
  401ab7:	8b 00                	mov    (%eax),%eax
  401ab9:	48                   	dec    %eax
  401aba:	8b 00                	mov    (%eax),%eax
  401abc:	48                   	dec    %eax
  401abd:	8b 40 08             	mov    0x8(%eax),%eax
  401ac0:	48                   	dec    %eax
  401ac1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  401ac4:	48                   	dec    %eax
  401ac5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  401ac9:	75 05                	jne    401ad0 <backtrace+0x3d0>
  401acb:	e9 5b 03 00 00       	jmp    401e2b <backtrace+0x72b>
  401ad0:	48                   	dec    %eax
  401ad1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  401ad4:	48                   	dec    %eax
  401ad5:	8d 50 60             	lea    0x60(%eax),%edx
  401ad8:	48                   	dec    %eax
  401ad9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401adc:	48                   	dec    %eax
  401add:	89 02                	mov    %eax,(%edx)
  401adf:	c7 45 fc 0d 00 00 00 	movl   $0xd,-0x4(%ebp)
	GET_RETURN_ADDRESS(13)
  401ae6:	83 7d e4 0d          	cmpl   $0xd,-0x1c(%ebp)
  401aea:	75 05                	jne    401af1 <backtrace+0x3f1>
  401aec:	e9 3a 03 00 00       	jmp    401e2b <backtrace+0x72b>
  401af1:	48                   	dec    %eax
  401af2:	8b 45 00             	mov    0x0(%ebp),%eax
  401af5:	48                   	dec    %eax
  401af6:	8b 00                	mov    (%eax),%eax
  401af8:	48                   	dec    %eax
  401af9:	8b 00                	mov    (%eax),%eax
  401afb:	48                   	dec    %eax
  401afc:	8b 00                	mov    (%eax),%eax
  401afe:	48                   	dec    %eax
  401aff:	8b 00                	mov    (%eax),%eax
  401b01:	48                   	dec    %eax
  401b02:	8b 00                	mov    (%eax),%eax
  401b04:	48                   	dec    %eax
  401b05:	8b 00                	mov    (%eax),%eax
  401b07:	48                   	dec    %eax
  401b08:	8b 00                	mov    (%eax),%eax
  401b0a:	48                   	dec    %eax
  401b0b:	8b 00                	mov    (%eax),%eax
  401b0d:	48                   	dec    %eax
  401b0e:	8b 00                	mov    (%eax),%eax
  401b10:	48                   	dec    %eax
  401b11:	8b 00                	mov    (%eax),%eax
  401b13:	48                   	dec    %eax
  401b14:	8b 00                	mov    (%eax),%eax
  401b16:	48                   	dec    %eax
  401b17:	8b 00                	mov    (%eax),%eax
  401b19:	48                   	dec    %eax
  401b1a:	8b 40 08             	mov    0x8(%eax),%eax
  401b1d:	48                   	dec    %eax
  401b1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  401b21:	48                   	dec    %eax
  401b22:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  401b26:	75 05                	jne    401b2d <backtrace+0x42d>
  401b28:	e9 fe 02 00 00       	jmp    401e2b <backtrace+0x72b>
  401b2d:	48                   	dec    %eax
  401b2e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  401b31:	48                   	dec    %eax
  401b32:	8d 50 68             	lea    0x68(%eax),%edx
  401b35:	48                   	dec    %eax
  401b36:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401b39:	48                   	dec    %eax
  401b3a:	89 02                	mov    %eax,(%edx)
  401b3c:	c7 45 fc 0e 00 00 00 	movl   $0xe,-0x4(%ebp)
	GET_RETURN_ADDRESS(14)
  401b43:	83 7d e4 0e          	cmpl   $0xe,-0x1c(%ebp)
  401b47:	75 05                	jne    401b4e <backtrace+0x44e>
  401b49:	e9 dd 02 00 00       	jmp    401e2b <backtrace+0x72b>
  401b4e:	48                   	dec    %eax
  401b4f:	8b 45 00             	mov    0x0(%ebp),%eax
  401b52:	48                   	dec    %eax
  401b53:	8b 00                	mov    (%eax),%eax
  401b55:	48                   	dec    %eax
  401b56:	8b 00                	mov    (%eax),%eax
  401b58:	48                   	dec    %eax
  401b59:	8b 00                	mov    (%eax),%eax
  401b5b:	48                   	dec    %eax
  401b5c:	8b 00                	mov    (%eax),%eax
  401b5e:	48                   	dec    %eax
  401b5f:	8b 00                	mov    (%eax),%eax
  401b61:	48                   	dec    %eax
  401b62:	8b 00                	mov    (%eax),%eax
  401b64:	48                   	dec    %eax
  401b65:	8b 00                	mov    (%eax),%eax
  401b67:	48                   	dec    %eax
  401b68:	8b 00                	mov    (%eax),%eax
  401b6a:	48                   	dec    %eax
  401b6b:	8b 00                	mov    (%eax),%eax
  401b6d:	48                   	dec    %eax
  401b6e:	8b 00                	mov    (%eax),%eax
  401b70:	48                   	dec    %eax
  401b71:	8b 00                	mov    (%eax),%eax
  401b73:	48                   	dec    %eax
  401b74:	8b 00                	mov    (%eax),%eax
  401b76:	48                   	dec    %eax
  401b77:	8b 00                	mov    (%eax),%eax
  401b79:	48                   	dec    %eax
  401b7a:	8b 40 08             	mov    0x8(%eax),%eax
  401b7d:	48                   	dec    %eax
  401b7e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  401b81:	48                   	dec    %eax
  401b82:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  401b86:	75 05                	jne    401b8d <backtrace+0x48d>
  401b88:	e9 9e 02 00 00       	jmp    401e2b <backtrace+0x72b>
  401b8d:	48                   	dec    %eax
  401b8e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  401b91:	48                   	dec    %eax
  401b92:	8d 50 70             	lea    0x70(%eax),%edx
  401b95:	48                   	dec    %eax
  401b96:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401b99:	48                   	dec    %eax
  401b9a:	89 02                	mov    %eax,(%edx)
  401b9c:	c7 45 fc 0f 00 00 00 	movl   $0xf,-0x4(%ebp)
	GET_RETURN_ADDRESS(15)
  401ba3:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
  401ba7:	75 05                	jne    401bae <backtrace+0x4ae>
  401ba9:	e9 7d 02 00 00       	jmp    401e2b <backtrace+0x72b>
  401bae:	48                   	dec    %eax
  401baf:	8b 45 00             	mov    0x0(%ebp),%eax
  401bb2:	48                   	dec    %eax
  401bb3:	8b 00                	mov    (%eax),%eax
  401bb5:	48                   	dec    %eax
  401bb6:	8b 00                	mov    (%eax),%eax
  401bb8:	48                   	dec    %eax
  401bb9:	8b 00                	mov    (%eax),%eax
  401bbb:	48                   	dec    %eax
  401bbc:	8b 00                	mov    (%eax),%eax
  401bbe:	48                   	dec    %eax
  401bbf:	8b 00                	mov    (%eax),%eax
  401bc1:	48                   	dec    %eax
  401bc2:	8b 00                	mov    (%eax),%eax
  401bc4:	48                   	dec    %eax
  401bc5:	8b 00                	mov    (%eax),%eax
  401bc7:	48                   	dec    %eax
  401bc8:	8b 00                	mov    (%eax),%eax
  401bca:	48                   	dec    %eax
  401bcb:	8b 00                	mov    (%eax),%eax
  401bcd:	48                   	dec    %eax
  401bce:	8b 00                	mov    (%eax),%eax
  401bd0:	48                   	dec    %eax
  401bd1:	8b 00                	mov    (%eax),%eax
  401bd3:	48                   	dec    %eax
  401bd4:	8b 00                	mov    (%eax),%eax
  401bd6:	48                   	dec    %eax
  401bd7:	8b 00                	mov    (%eax),%eax
  401bd9:	48                   	dec    %eax
  401bda:	8b 00                	mov    (%eax),%eax
  401bdc:	48                   	dec    %eax
  401bdd:	8b 40 08             	mov    0x8(%eax),%eax
  401be0:	48                   	dec    %eax
  401be1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  401be4:	48                   	dec    %eax
  401be5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  401be9:	75 05                	jne    401bf0 <backtrace+0x4f0>
  401beb:	e9 3b 02 00 00       	jmp    401e2b <backtrace+0x72b>
  401bf0:	48                   	dec    %eax
  401bf1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  401bf4:	48                   	dec    %eax
  401bf5:	8d 50 78             	lea    0x78(%eax),%edx
  401bf8:	48                   	dec    %eax
  401bf9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401bfc:	48                   	dec    %eax
  401bfd:	89 02                	mov    %eax,(%edx)
  401bff:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%ebp)
	GET_RETURN_ADDRESS(16)
  401c06:	83 7d e4 10          	cmpl   $0x10,-0x1c(%ebp)
  401c0a:	75 05                	jne    401c11 <backtrace+0x511>
  401c0c:	e9 1a 02 00 00       	jmp    401e2b <backtrace+0x72b>
  401c11:	48                   	dec    %eax
  401c12:	8b 45 00             	mov    0x0(%ebp),%eax
  401c15:	48                   	dec    %eax
  401c16:	8b 00                	mov    (%eax),%eax
  401c18:	48                   	dec    %eax
  401c19:	8b 00                	mov    (%eax),%eax
  401c1b:	48                   	dec    %eax
  401c1c:	8b 00                	mov    (%eax),%eax
  401c1e:	48                   	dec    %eax
  401c1f:	8b 00                	mov    (%eax),%eax
  401c21:	48                   	dec    %eax
  401c22:	8b 00                	mov    (%eax),%eax
  401c24:	48                   	dec    %eax
  401c25:	8b 00                	mov    (%eax),%eax
  401c27:	48                   	dec    %eax
  401c28:	8b 00                	mov    (%eax),%eax
  401c2a:	48                   	dec    %eax
  401c2b:	8b 00                	mov    (%eax),%eax
  401c2d:	48                   	dec    %eax
  401c2e:	8b 00                	mov    (%eax),%eax
  401c30:	48                   	dec    %eax
  401c31:	8b 00                	mov    (%eax),%eax
  401c33:	48                   	dec    %eax
  401c34:	8b 00                	mov    (%eax),%eax
  401c36:	48                   	dec    %eax
  401c37:	8b 00                	mov    (%eax),%eax
  401c39:	48                   	dec    %eax
  401c3a:	8b 00                	mov    (%eax),%eax
  401c3c:	48                   	dec    %eax
  401c3d:	8b 00                	mov    (%eax),%eax
  401c3f:	48                   	dec    %eax
  401c40:	8b 00                	mov    (%eax),%eax
  401c42:	48                   	dec    %eax
  401c43:	8b 40 08             	mov    0x8(%eax),%eax
  401c46:	48                   	dec    %eax
  401c47:	89 45 f0             	mov    %eax,-0x10(%ebp)
  401c4a:	48                   	dec    %eax
  401c4b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  401c4f:	75 05                	jne    401c56 <backtrace+0x556>
  401c51:	e9 d5 01 00 00       	jmp    401e2b <backtrace+0x72b>
  401c56:	48                   	dec    %eax
  401c57:	8b 45 e8             	mov    -0x18(%ebp),%eax
  401c5a:	48                   	dec    %eax
  401c5b:	8d 90 80 00 00 00    	lea    0x80(%eax),%edx
  401c61:	48                   	dec    %eax
  401c62:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401c65:	48                   	dec    %eax
  401c66:	89 02                	mov    %eax,(%edx)
  401c68:	c7 45 fc 11 00 00 00 	movl   $0x11,-0x4(%ebp)
	GET_RETURN_ADDRESS(17)
  401c6f:	83 7d e4 11          	cmpl   $0x11,-0x1c(%ebp)
  401c73:	75 05                	jne    401c7a <backtrace+0x57a>
  401c75:	e9 b1 01 00 00       	jmp    401e2b <backtrace+0x72b>
  401c7a:	48                   	dec    %eax
  401c7b:	8b 45 00             	mov    0x0(%ebp),%eax
  401c7e:	48                   	dec    %eax
  401c7f:	8b 00                	mov    (%eax),%eax
  401c81:	48                   	dec    %eax
  401c82:	8b 00                	mov    (%eax),%eax
  401c84:	48                   	dec    %eax
  401c85:	8b 00                	mov    (%eax),%eax
  401c87:	48                   	dec    %eax
  401c88:	8b 00                	mov    (%eax),%eax
  401c8a:	48                   	dec    %eax
  401c8b:	8b 00                	mov    (%eax),%eax
  401c8d:	48                   	dec    %eax
  401c8e:	8b 00                	mov    (%eax),%eax
  401c90:	48                   	dec    %eax
  401c91:	8b 00                	mov    (%eax),%eax
  401c93:	48                   	dec    %eax
  401c94:	8b 00                	mov    (%eax),%eax
  401c96:	48                   	dec    %eax
  401c97:	8b 00                	mov    (%eax),%eax
  401c99:	48                   	dec    %eax
  401c9a:	8b 00                	mov    (%eax),%eax
  401c9c:	48                   	dec    %eax
  401c9d:	8b 00                	mov    (%eax),%eax
  401c9f:	48                   	dec    %eax
  401ca0:	8b 00                	mov    (%eax),%eax
  401ca2:	48                   	dec    %eax
  401ca3:	8b 00                	mov    (%eax),%eax
  401ca5:	48                   	dec    %eax
  401ca6:	8b 00                	mov    (%eax),%eax
  401ca8:	48                   	dec    %eax
  401ca9:	8b 00                	mov    (%eax),%eax
  401cab:	48                   	dec    %eax
  401cac:	8b 00                	mov    (%eax),%eax
  401cae:	48                   	dec    %eax
  401caf:	8b 40 08             	mov    0x8(%eax),%eax
  401cb2:	48                   	dec    %eax
  401cb3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  401cb6:	48                   	dec    %eax
  401cb7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  401cbb:	75 05                	jne    401cc2 <backtrace+0x5c2>
  401cbd:	e9 69 01 00 00       	jmp    401e2b <backtrace+0x72b>
  401cc2:	48                   	dec    %eax
  401cc3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  401cc6:	48                   	dec    %eax
  401cc7:	8d 90 88 00 00 00    	lea    0x88(%eax),%edx
  401ccd:	48                   	dec    %eax
  401cce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401cd1:	48                   	dec    %eax
  401cd2:	89 02                	mov    %eax,(%edx)
  401cd4:	c7 45 fc 12 00 00 00 	movl   $0x12,-0x4(%ebp)
	GET_RETURN_ADDRESS(18)
  401cdb:	83 7d e4 12          	cmpl   $0x12,-0x1c(%ebp)
  401cdf:	75 05                	jne    401ce6 <backtrace+0x5e6>
  401ce1:	e9 45 01 00 00       	jmp    401e2b <backtrace+0x72b>
  401ce6:	48                   	dec    %eax
  401ce7:	8b 45 00             	mov    0x0(%ebp),%eax
  401cea:	48                   	dec    %eax
  401ceb:	8b 00                	mov    (%eax),%eax
  401ced:	48                   	dec    %eax
  401cee:	8b 00                	mov    (%eax),%eax
  401cf0:	48                   	dec    %eax
  401cf1:	8b 00                	mov    (%eax),%eax
  401cf3:	48                   	dec    %eax
  401cf4:	8b 00                	mov    (%eax),%eax
  401cf6:	48                   	dec    %eax
  401cf7:	8b 00                	mov    (%eax),%eax
  401cf9:	48                   	dec    %eax
  401cfa:	8b 00                	mov    (%eax),%eax
  401cfc:	48                   	dec    %eax
  401cfd:	8b 00                	mov    (%eax),%eax
  401cff:	48                   	dec    %eax
  401d00:	8b 00                	mov    (%eax),%eax
  401d02:	48                   	dec    %eax
  401d03:	8b 00                	mov    (%eax),%eax
  401d05:	48                   	dec    %eax
  401d06:	8b 00                	mov    (%eax),%eax
  401d08:	48                   	dec    %eax
  401d09:	8b 00                	mov    (%eax),%eax
  401d0b:	48                   	dec    %eax
  401d0c:	8b 00                	mov    (%eax),%eax
  401d0e:	48                   	dec    %eax
  401d0f:	8b 00                	mov    (%eax),%eax
  401d11:	48                   	dec    %eax
  401d12:	8b 00                	mov    (%eax),%eax
  401d14:	48                   	dec    %eax
  401d15:	8b 00                	mov    (%eax),%eax
  401d17:	48                   	dec    %eax
  401d18:	8b 00                	mov    (%eax),%eax
  401d1a:	48                   	dec    %eax
  401d1b:	8b 00                	mov    (%eax),%eax
  401d1d:	48                   	dec    %eax
  401d1e:	8b 40 08             	mov    0x8(%eax),%eax
  401d21:	48                   	dec    %eax
  401d22:	89 45 f0             	mov    %eax,-0x10(%ebp)
  401d25:	48                   	dec    %eax
  401d26:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  401d2a:	75 05                	jne    401d31 <backtrace+0x631>
  401d2c:	e9 fa 00 00 00       	jmp    401e2b <backtrace+0x72b>
  401d31:	48                   	dec    %eax
  401d32:	8b 45 e8             	mov    -0x18(%ebp),%eax
  401d35:	48                   	dec    %eax
  401d36:	8d 90 90 00 00 00    	lea    0x90(%eax),%edx
  401d3c:	48                   	dec    %eax
  401d3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401d40:	48                   	dec    %eax
  401d41:	89 02                	mov    %eax,(%edx)
  401d43:	c7 45 fc 13 00 00 00 	movl   $0x13,-0x4(%ebp)
	GET_RETURN_ADDRESS(19)
  401d4a:	83 7d e4 13          	cmpl   $0x13,-0x1c(%ebp)
  401d4e:	75 05                	jne    401d55 <backtrace+0x655>
  401d50:	e9 d6 00 00 00       	jmp    401e2b <backtrace+0x72b>
  401d55:	48                   	dec    %eax
  401d56:	8b 45 00             	mov    0x0(%ebp),%eax
  401d59:	48                   	dec    %eax
  401d5a:	8b 00                	mov    (%eax),%eax
  401d5c:	48                   	dec    %eax
  401d5d:	8b 00                	mov    (%eax),%eax
  401d5f:	48                   	dec    %eax
  401d60:	8b 00                	mov    (%eax),%eax
  401d62:	48                   	dec    %eax
  401d63:	8b 00                	mov    (%eax),%eax
  401d65:	48                   	dec    %eax
  401d66:	8b 00                	mov    (%eax),%eax
  401d68:	48                   	dec    %eax
  401d69:	8b 00                	mov    (%eax),%eax
  401d6b:	48                   	dec    %eax
  401d6c:	8b 00                	mov    (%eax),%eax
  401d6e:	48                   	dec    %eax
  401d6f:	8b 00                	mov    (%eax),%eax
  401d71:	48                   	dec    %eax
  401d72:	8b 00                	mov    (%eax),%eax
  401d74:	48                   	dec    %eax
  401d75:	8b 00                	mov    (%eax),%eax
  401d77:	48                   	dec    %eax
  401d78:	8b 00                	mov    (%eax),%eax
  401d7a:	48                   	dec    %eax
  401d7b:	8b 00                	mov    (%eax),%eax
  401d7d:	48                   	dec    %eax
  401d7e:	8b 00                	mov    (%eax),%eax
  401d80:	48                   	dec    %eax
  401d81:	8b 00                	mov    (%eax),%eax
  401d83:	48                   	dec    %eax
  401d84:	8b 00                	mov    (%eax),%eax
  401d86:	48                   	dec    %eax
  401d87:	8b 00                	mov    (%eax),%eax
  401d89:	48                   	dec    %eax
  401d8a:	8b 00                	mov    (%eax),%eax
  401d8c:	48                   	dec    %eax
  401d8d:	8b 00                	mov    (%eax),%eax
  401d8f:	48                   	dec    %eax
  401d90:	8b 40 08             	mov    0x8(%eax),%eax
  401d93:	48                   	dec    %eax
  401d94:	89 45 f0             	mov    %eax,-0x10(%ebp)
  401d97:	48                   	dec    %eax
  401d98:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  401d9c:	75 05                	jne    401da3 <backtrace+0x6a3>
  401d9e:	e9 88 00 00 00       	jmp    401e2b <backtrace+0x72b>
  401da3:	48                   	dec    %eax
  401da4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  401da7:	48                   	dec    %eax
  401da8:	8d 90 98 00 00 00    	lea    0x98(%eax),%edx
  401dae:	48                   	dec    %eax
  401daf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401db2:	48                   	dec    %eax
  401db3:	89 02                	mov    %eax,(%edx)
  401db5:	c7 45 fc 14 00 00 00 	movl   $0x14,-0x4(%ebp)
	GET_RETURN_ADDRESS(20)
  401dbc:	83 7d e4 14          	cmpl   $0x14,-0x1c(%ebp)
  401dc0:	75 02                	jne    401dc4 <backtrace+0x6c4>
  401dc2:	eb 67                	jmp    401e2b <backtrace+0x72b>
  401dc4:	48                   	dec    %eax
  401dc5:	8b 45 00             	mov    0x0(%ebp),%eax
  401dc8:	48                   	dec    %eax
  401dc9:	8b 00                	mov    (%eax),%eax
  401dcb:	48                   	dec    %eax
  401dcc:	8b 00                	mov    (%eax),%eax
  401dce:	48                   	dec    %eax
  401dcf:	8b 00                	mov    (%eax),%eax
  401dd1:	48                   	dec    %eax
  401dd2:	8b 00                	mov    (%eax),%eax
  401dd4:	48                   	dec    %eax
  401dd5:	8b 00                	mov    (%eax),%eax
  401dd7:	48                   	dec    %eax
  401dd8:	8b 00                	mov    (%eax),%eax
  401dda:	48                   	dec    %eax
  401ddb:	8b 00                	mov    (%eax),%eax
  401ddd:	48                   	dec    %eax
  401dde:	8b 00                	mov    (%eax),%eax
  401de0:	48                   	dec    %eax
  401de1:	8b 00                	mov    (%eax),%eax
  401de3:	48                   	dec    %eax
  401de4:	8b 00                	mov    (%eax),%eax
  401de6:	48                   	dec    %eax
  401de7:	8b 00                	mov    (%eax),%eax
  401de9:	48                   	dec    %eax
  401dea:	8b 00                	mov    (%eax),%eax
  401dec:	48                   	dec    %eax
  401ded:	8b 00                	mov    (%eax),%eax
  401def:	48                   	dec    %eax
  401df0:	8b 00                	mov    (%eax),%eax
  401df2:	48                   	dec    %eax
  401df3:	8b 00                	mov    (%eax),%eax
  401df5:	48                   	dec    %eax
  401df6:	8b 00                	mov    (%eax),%eax
  401df8:	48                   	dec    %eax
  401df9:	8b 00                	mov    (%eax),%eax
  401dfb:	48                   	dec    %eax
  401dfc:	8b 00                	mov    (%eax),%eax
  401dfe:	48                   	dec    %eax
  401dff:	8b 00                	mov    (%eax),%eax
  401e01:	48                   	dec    %eax
  401e02:	8b 40 08             	mov    0x8(%eax),%eax
  401e05:	48                   	dec    %eax
  401e06:	89 45 f0             	mov    %eax,-0x10(%ebp)
  401e09:	48                   	dec    %eax
  401e0a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  401e0e:	75 02                	jne    401e12 <backtrace+0x712>
  401e10:	eb 19                	jmp    401e2b <backtrace+0x72b>
  401e12:	48                   	dec    %eax
  401e13:	8b 45 e8             	mov    -0x18(%ebp),%eax
  401e16:	48                   	dec    %eax
  401e17:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  401e1d:	48                   	dec    %eax
  401e1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401e21:	48                   	dec    %eax
  401e22:	89 02                	mov    %eax,(%edx)
  401e24:	c7 45 fc 15 00 00 00 	movl   $0x15,-0x4(%ebp)

#undef GET_RETURN_ADDRESS

done:
	walking = 0;
  401e2b:	c7 05 cb e1 04 00 00 	movl   $0x0,0x4e1cb
  401e32:	00 00 00 
	return depth;
  401e35:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  401e38:	c9                   	leave  
  401e39:	c3                   	ret    

00401e3a <abort>:
 * leaving the lower status codes for unit tests.
 */
#define ABORT_EXIT_STATUS 63    /* 127 exit status from qemu */

void abort(void)
{
  401e3a:	55                   	push   %ebp
  401e3b:	48                   	dec    %eax
  401e3c:	89 e5                	mov    %esp,%ebp
        exit(ABORT_EXIT_STATUS);
  401e3e:	bf 3f 00 00 00       	mov    $0x3f,%edi
  401e43:	e8 97 04 00 00       	call   4022df <exit>
}
  401e48:	5d                   	pop    %ebp
  401e49:	c3                   	ret    

00401e4a <spin_lock>:
struct spinlock {
    unsigned int v;
};

static inline void spin_lock(struct spinlock *lock)
{
  401e4a:	55                   	push   %ebp
  401e4b:	48                   	dec    %eax
  401e4c:	89 e5                	mov    %esp,%ebp
  401e4e:	48                   	dec    %eax
  401e4f:	83 ec 08             	sub    $0x8,%esp
  401e52:	48                   	dec    %eax
  401e53:	89 7d f8             	mov    %edi,-0x8(%ebp)
        while (__sync_lock_test_and_set(&lock->v, 1));
  401e56:	90                   	nop
  401e57:	48                   	dec    %eax
  401e58:	8b 55 f8             	mov    -0x8(%ebp),%edx
  401e5b:	b8 01 00 00 00       	mov    $0x1,%eax
  401e60:	87 02                	xchg   %eax,(%edx)
  401e62:	85 c0                	test   %eax,%eax
  401e64:	75 f1                	jne    401e57 <spin_lock+0xd>
}
  401e66:	c9                   	leave  
  401e67:	c3                   	ret    

00401e68 <spin_unlock>:

static inline void spin_unlock(struct spinlock *lock)
{
  401e68:	55                   	push   %ebp
  401e69:	48                   	dec    %eax
  401e6a:	89 e5                	mov    %esp,%ebp
  401e6c:	48                   	dec    %eax
  401e6d:	83 ec 08             	sub    $0x8,%esp
  401e70:	48                   	dec    %eax
  401e71:	89 7d f8             	mov    %edi,-0x8(%ebp)
        __sync_lock_release(&lock->v);
  401e74:	48                   	dec    %eax
  401e75:	8b 45 f8             	mov    -0x8(%ebp),%eax
  401e78:	ba 00 00 00 00       	mov    $0x0,%edx
  401e7d:	89 10                	mov    %edx,(%eax)
}
  401e7f:	c9                   	leave  
  401e80:	c3                   	ret    

00401e81 <slot_from_xy>:

static unsigned int cur_x, cur_y;
static uint16_t *vga = (uint16_t *)0xb8000;

static inline uint16_t *slot_from_xy(unsigned int x, unsigned int y)
{
  401e81:	55                   	push   %ebp
  401e82:	48                   	dec    %eax
  401e83:	89 e5                	mov    %esp,%ebp
  401e85:	48                   	dec    %eax
  401e86:	83 ec 08             	sub    $0x8,%esp
  401e89:	89 7d fc             	mov    %edi,-0x4(%ebp)
  401e8c:	89 75 f8             	mov    %esi,-0x8(%ebp)
        if (x >= COLUMNS) return 0;
  401e8f:	83 7d fc 4f          	cmpl   $0x4f,-0x4(%ebp)
  401e93:	76 07                	jbe    401e9c <slot_from_xy+0x1b>
  401e95:	b8 00 00 00 00       	mov    $0x0,%eax
  401e9a:	eb 30                	jmp    401ecc <slot_from_xy+0x4b>
        if (y >= ROWS) return 0;
  401e9c:	83 7d f8 18          	cmpl   $0x18,-0x8(%ebp)
  401ea0:	76 07                	jbe    401ea9 <slot_from_xy+0x28>
  401ea2:	b8 00 00 00 00       	mov    $0x0,%eax
  401ea7:	eb 23                	jmp    401ecc <slot_from_xy+0x4b>

        return &vga[x + (y * COLUMNS)];
  401ea9:	48                   	dec    %eax
  401eaa:	8b 0d 60 a1 00 00    	mov    0xa160,%ecx
  401eb0:	8b 55 f8             	mov    -0x8(%ebp),%edx
  401eb3:	89 d0                	mov    %edx,%eax
  401eb5:	c1 e0 02             	shl    $0x2,%eax
  401eb8:	01 d0                	add    %edx,%eax
  401eba:	c1 e0 04             	shl    $0x4,%eax
  401ebd:	89 c2                	mov    %eax,%edx
  401ebf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  401ec2:	01 d0                	add    %edx,%eax
  401ec4:	89 c0                	mov    %eax,%eax
  401ec6:	48                   	dec    %eax
  401ec7:	01 c0                	add    %eax,%eax
  401ec9:	48                   	dec    %eax
  401eca:	01 c8                	add    %ecx,%eax
}
  401ecc:	c9                   	leave  
  401ecd:	c3                   	ret    

00401ece <console_clear>:

void console_clear()
{
  401ece:	55                   	push   %ebp
  401ecf:	48                   	dec    %eax
  401ed0:	89 e5                	mov    %esp,%ebp
  401ed2:	48                   	dec    %eax
  401ed3:	83 ec 10             	sub    $0x10,%esp
        int i;

        for (i = 0; i < ROWS * COLUMNS; i++) {
  401ed6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  401edd:	eb 1c                	jmp    401efb <console_clear+0x2d>
                vga[i] = 0;
  401edf:	48                   	dec    %eax
  401ee0:	8b 05 2a a1 00 00    	mov    0xa12a,%eax
  401ee6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  401ee9:	48                   	dec    %eax
  401eea:	63 d2                	arpl   %dx,%dx
  401eec:	48                   	dec    %eax
  401eed:	01 d2                	add    %edx,%edx
  401eef:	48                   	dec    %eax
  401ef0:	01 d0                	add    %edx,%eax
  401ef2:	66 c7 00 00 00       	movw   $0x0,(%eax)

void console_clear()
{
        int i;

        for (i = 0; i < ROWS * COLUMNS; i++) {
  401ef7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  401efb:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%ebp)
  401f02:	7e db                	jle    401edf <console_clear+0x11>
                vga[i] = 0;
        }

        cur_x = 0;
  401f04:	c7 05 fe e0 04 00 00 	movl   $0x0,0x4e0fe
  401f0b:	00 00 00 
        cur_y = 0;
  401f0e:	c7 05 f8 e0 04 00 00 	movl   $0x0,0x4e0f8
  401f15:	00 00 00 
}
  401f18:	c9                   	leave  
  401f19:	c3                   	ret    

00401f1a <write_reg>:


static void write_reg(char reg, char val)
{
  401f1a:	55                   	push   %ebp
  401f1b:	48                   	dec    %eax
  401f1c:	89 e5                	mov    %esp,%ebp
  401f1e:	48                   	dec    %eax
  401f1f:	83 ec 08             	sub    $0x8,%esp
  401f22:	89 fa                	mov    %edi,%edx
  401f24:	89 f0                	mov    %esi,%eax
  401f26:	88 55 fc             	mov    %dl,-0x4(%ebp)
  401f29:	88 45 f8             	mov    %al,-0x8(%ebp)
        asm volatile("outb %0, %1\n" :: "a"(reg), "d"((unsigned short)0x3d4));
  401f2c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  401f30:	ba d4 03 00 00       	mov    $0x3d4,%edx
  401f35:	ee                   	out    %al,(%dx)
        asm volatile("outb %0, %1\n" :: "a"(val), "d"((unsigned short)0x3d5));
  401f36:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
  401f3a:	ba d5 03 00 00       	mov    $0x3d5,%edx
  401f3f:	ee                   	out    %al,(%dx)
}
  401f40:	c9                   	leave  
  401f41:	c3                   	ret    

00401f42 <console_init>:

void console_init()
{
  401f42:	55                   	push   %ebp
  401f43:	48                   	dec    %eax
  401f44:	89 e5                	mov    %esp,%ebp
        // Disable the cursor
        write_reg(0x0a, 0x20);
  401f46:	be 20 00 00 00       	mov    $0x20,%esi
  401f4b:	bf 0a 00 00 00       	mov    $0xa,%edi
  401f50:	e8 c5 ff ff ff       	call   401f1a <write_reg>
        console_clear();
  401f55:	b8 00 00 00 00       	mov    $0x0,%eax
  401f5a:	e8 6f ff ff ff       	call   401ece <console_clear>
}
  401f5f:	5d                   	pop    %ebp
  401f60:	c3                   	ret    

00401f61 <new_line>:

static void new_line()
{
  401f61:	55                   	push   %ebp
  401f62:	48                   	dec    %eax
  401f63:	89 e5                	mov    %esp,%ebp
  401f65:	53                   	push   %ebx
  401f66:	48                   	dec    %eax
  401f67:	83 ec 10             	sub    $0x10,%esp
        int y, x;

        cur_x = 0;
  401f6a:	c7 05 98 e0 04 00 00 	movl   $0x0,0x4e098
  401f71:	00 00 00 

        cur_y++;
  401f74:	8b 05 96 e0 04 00    	mov    0x4e096,%eax
  401f7a:	83 c0 01             	add    $0x1,%eax
  401f7d:	89 05 8d e0 04 00    	mov    %eax,0x4e08d
        if (cur_y >= ROWS) {
  401f83:	8b 05 87 e0 04 00    	mov    0x4e087,%eax
  401f89:	83 f8 18             	cmp    $0x18,%eax
  401f8c:	0f 86 83 00 00 00    	jbe    402015 <new_line+0xb4>
                cur_y = ROWS - 1;
  401f92:	c7 05 74 e0 04 00 18 	movl   $0x18,0x4e074
  401f99:	00 00 00 

                for (y = 0; y < ROWS - 1; y++) {
  401f9c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  401fa3:	eb 43                	jmp    401fe8 <new_line+0x87>
                        for (x = 0; x < COLUMNS; x++) {
  401fa5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  401fac:	eb 30                	jmp    401fde <new_line+0x7d>
                                *slot_from_xy(x, y) = *slot_from_xy(x, y + 1);
  401fae:	8b 55 f4             	mov    -0xc(%ebp),%edx
  401fb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401fb4:	89 d6                	mov    %edx,%esi
  401fb6:	89 c7                	mov    %eax,%edi
  401fb8:	e8 c4 fe ff ff       	call   401e81 <slot_from_xy>
  401fbd:	48                   	dec    %eax
  401fbe:	89 c3                	mov    %eax,%ebx
  401fc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  401fc3:	83 c0 01             	add    $0x1,%eax
  401fc6:	89 c2                	mov    %eax,%edx
  401fc8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401fcb:	89 d6                	mov    %edx,%esi
  401fcd:	89 c7                	mov    %eax,%edi
  401fcf:	e8 ad fe ff ff       	call   401e81 <slot_from_xy>
  401fd4:	0f b7 00             	movzwl (%eax),%eax
  401fd7:	66 89 03             	mov    %ax,(%ebx)
        cur_y++;
        if (cur_y >= ROWS) {
                cur_y = ROWS - 1;

                for (y = 0; y < ROWS - 1; y++) {
                        for (x = 0; x < COLUMNS; x++) {
  401fda:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  401fde:	83 7d f0 4f          	cmpl   $0x4f,-0x10(%ebp)
  401fe2:	7e ca                	jle    401fae <new_line+0x4d>

        cur_y++;
        if (cur_y >= ROWS) {
                cur_y = ROWS - 1;

                for (y = 0; y < ROWS - 1; y++) {
  401fe4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  401fe8:	83 7d f4 17          	cmpl   $0x17,-0xc(%ebp)
  401fec:	7e b7                	jle    401fa5 <new_line+0x44>
                        for (x = 0; x < COLUMNS; x++) {
                                *slot_from_xy(x, y) = *slot_from_xy(x, y + 1);
                        }
                }

                for (x = 0; x < COLUMNS; x++) {
  401fee:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  401ff5:	eb 18                	jmp    40200f <new_line+0xae>
                        *slot_from_xy(x, ROWS - 1) = 0;
  401ff7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  401ffa:	be 18 00 00 00       	mov    $0x18,%esi
  401fff:	89 c7                	mov    %eax,%edi
  402001:	e8 7b fe ff ff       	call   401e81 <slot_from_xy>
  402006:	66 c7 00 00 00       	movw   $0x0,(%eax)
                        for (x = 0; x < COLUMNS; x++) {
                                *slot_from_xy(x, y) = *slot_from_xy(x, y + 1);
                        }
                }

                for (x = 0; x < COLUMNS; x++) {
  40200b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  40200f:	83 7d f0 4f          	cmpl   $0x4f,-0x10(%ebp)
  402013:	7e e2                	jle    401ff7 <new_line+0x96>
                        *slot_from_xy(x, ROWS - 1) = 0;
                }
        }
}
  402015:	48                   	dec    %eax
  402016:	83 c4 10             	add    $0x10,%esp
  402019:	5b                   	pop    %ebx
  40201a:	5d                   	pop    %ebp
  40201b:	c3                   	ret    

0040201c <console_putc>:

void console_putc(char ch)
{
  40201c:	55                   	push   %ebp
  40201d:	48                   	dec    %eax
  40201e:	89 e5                	mov    %esp,%ebp
  402020:	48                   	dec    %eax
  402021:	83 ec 18             	sub    $0x18,%esp
  402024:	89 f8                	mov    %edi,%eax
  402026:	88 45 ec             	mov    %al,-0x14(%ebp)
        if (ch == '\n') {
  402029:	80 7d ec 0a          	cmpb   $0xa,-0x14(%ebp)
  40202d:	75 0c                	jne    40203b <console_putc+0x1f>
                new_line();
  40202f:	b8 00 00 00 00       	mov    $0x0,%eax
  402034:	e8 28 ff ff ff       	call   401f61 <new_line>
  402039:	eb 60                	jmp    40209b <console_putc+0x7f>
        } else if (ch == '\r') {
  40203b:	80 7d ec 0d          	cmpb   $0xd,-0x14(%ebp)
  40203f:	75 0c                	jne    40204d <console_putc+0x31>
                cur_x = 0;
  402041:	c7 05 c1 df 04 00 00 	movl   $0x0,0x4dfc1
  402048:	00 00 00 
  40204b:	eb 4e                	jmp    40209b <console_putc+0x7f>
        } else {
                uint16_t *slot = slot_from_xy(cur_x, cur_y);
  40204d:	8b 15 bd df 04 00    	mov    0x4dfbd,%edx
  402053:	8b 05 b3 df 04 00    	mov    0x4dfb3,%eax
  402059:	89 d6                	mov    %edx,%esi
  40205b:	89 c7                	mov    %eax,%edi
  40205d:	e8 1f fe ff ff       	call   401e81 <slot_from_xy>
  402062:	48                   	dec    %eax
  402063:	89 45 f8             	mov    %eax,-0x8(%ebp)
                *slot = 0x0700 | ch;
  402066:	66 0f be 45 ec       	movsbw -0x14(%ebp),%ax
  40206b:	80 cc 07             	or     $0x7,%ah
  40206e:	89 c2                	mov    %eax,%edx
  402070:	48                   	dec    %eax
  402071:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402074:	66 89 10             	mov    %dx,(%eax)

                cur_x++;
  402077:	8b 05 8f df 04 00    	mov    0x4df8f,%eax
  40207d:	83 c0 01             	add    $0x1,%eax
  402080:	89 05 86 df 04 00    	mov    %eax,0x4df86
                if (cur_x >= COLUMNS) {
  402086:	8b 05 80 df 04 00    	mov    0x4df80,%eax
  40208c:	83 f8 4f             	cmp    $0x4f,%eax
  40208f:	76 0a                	jbe    40209b <console_putc+0x7f>
                        new_line();
  402091:	b8 00 00 00 00       	mov    $0x0,%eax
  402096:	e8 c6 fe ff ff       	call   401f61 <new_line>
                }
        }
}
  40209b:	c9                   	leave  
  40209c:	c3                   	ret    

0040209d <console_puts>:

void console_puts(const char *buf)
{
  40209d:	55                   	push   %ebp
  40209e:	48                   	dec    %eax
  40209f:	89 e5                	mov    %esp,%ebp
  4020a1:	48                   	dec    %eax
  4020a2:	83 ec 20             	sub    $0x20,%esp
  4020a5:	48                   	dec    %eax
  4020a6:	89 7d e8             	mov    %edi,-0x18(%ebp)
    spin_lock(&lock);   
  4020a9:	bf 04 00 45 00       	mov    $0x450004,%edi
  4020ae:	e8 97 fd ff ff       	call   401e4a <spin_lock>
    unsigned long len = strlen(buf);
  4020b3:	48                   	dec    %eax
  4020b4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4020b7:	48                   	dec    %eax
  4020b8:	89 c7                	mov    %eax,%edi
  4020ba:	e8 28 ee ff ff       	call   400ee7 <strlen>
  4020bf:	48                   	dec    %eax
  4020c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    unsigned long i;
        
    if (!console_cleared) {
  4020c3:	8b 05 3f df 04 00    	mov    0x4df3f,%eax
  4020c9:	85 c0                	test   %eax,%eax
  4020cb:	75 0f                	jne    4020dc <console_puts+0x3f>
        console_init();
  4020cd:	e8 70 fe ff ff       	call   401f42 <console_init>
        console_cleared = 1;
  4020d2:	c7 05 2c df 04 00 01 	movl   $0x1,0x4df2c
  4020d9:	00 00 00 
    }   

    for(i = 0; i < len; i++){
  4020dc:	48                   	dec    %eax
  4020dd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  4020e4:	eb 1d                	jmp    402103 <console_puts+0x66>
        console_putc(buf[i]);
  4020e6:	48                   	dec    %eax
  4020e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  4020ea:	48                   	dec    %eax
  4020eb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  4020ee:	48                   	dec    %eax
  4020ef:	01 d0                	add    %edx,%eax
  4020f1:	0f b6 00             	movzbl (%eax),%eax
  4020f4:	0f be c0             	movsbl %al,%eax
  4020f7:	89 c7                	mov    %eax,%edi
  4020f9:	e8 1e ff ff ff       	call   40201c <console_putc>
    if (!console_cleared) {
        console_init();
        console_cleared = 1;
    }   

    for(i = 0; i < len; i++){
  4020fe:	48                   	dec    %eax
  4020ff:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  402103:	48                   	dec    %eax
  402104:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402107:	48                   	dec    %eax
  402108:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  40210b:	72 d9                	jb     4020e6 <console_puts+0x49>
        console_putc(buf[i]);
    }   
    spin_unlock(&lock);
  40210d:	bf 04 00 45 00       	mov    $0x450004,%edi
  402112:	e8 51 fd ff ff       	call   401e68 <spin_unlock>
}
  402117:	c9                   	leave  
  402118:	c3                   	ret    

00402119 <inb>:

#define __iomem

#define inb inb
static inline uint8_t inb(unsigned long port)
{
  402119:	55                   	push   %ebp
  40211a:	48                   	dec    %eax
  40211b:	89 e5                	mov    %esp,%ebp
  40211d:	48                   	dec    %eax
  40211e:	83 ec 18             	sub    $0x18,%esp
  402121:	48                   	dec    %eax
  402122:	89 7d e8             	mov    %edi,-0x18(%ebp)
    unsigned char value;
    asm volatile("inb %w1, %0" : "=a" (value) : "Nd" ((unsigned short)port));
  402125:	48                   	dec    %eax
  402126:	8b 45 e8             	mov    -0x18(%ebp),%eax
  402129:	89 c2                	mov    %eax,%edx
  40212b:	ec                   	in     (%dx),%al
  40212c:	88 45 ff             	mov    %al,-0x1(%ebp)
    return value;
  40212f:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
  402133:	c9                   	leave  
  402134:	c3                   	ret    

00402135 <outb>:
    return value;
}

#define outb outb
static inline void outb(uint8_t value, unsigned long port)
{
  402135:	55                   	push   %ebp
  402136:	48                   	dec    %eax
  402137:	89 e5                	mov    %esp,%ebp
  402139:	48                   	dec    %eax
  40213a:	83 ec 10             	sub    $0x10,%esp
  40213d:	89 f8                	mov    %edi,%eax
  40213f:	48                   	dec    %eax
  402140:	89 75 f0             	mov    %esi,-0x10(%ebp)
  402143:	88 45 fc             	mov    %al,-0x4(%ebp)
    asm volatile("outb %b0, %w1" : : "a"(value), "Nd"((unsigned short)port));
  402146:	48                   	dec    %eax
  402147:	8b 45 f0             	mov    -0x10(%ebp),%eax
  40214a:	89 c2                	mov    %eax,%edx
  40214c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  402150:	ee                   	out    %al,(%dx)
}
  402151:	c9                   	leave  
  402152:	c3                   	ret    

00402153 <spin_lock>:
struct spinlock {
    unsigned int v;
};

static inline void spin_lock(struct spinlock *lock)
{
  402153:	55                   	push   %ebp
  402154:	48                   	dec    %eax
  402155:	89 e5                	mov    %esp,%ebp
  402157:	48                   	dec    %eax
  402158:	83 ec 08             	sub    $0x8,%esp
  40215b:	48                   	dec    %eax
  40215c:	89 7d f8             	mov    %edi,-0x8(%ebp)
        while (__sync_lock_test_and_set(&lock->v, 1));
  40215f:	90                   	nop
  402160:	48                   	dec    %eax
  402161:	8b 55 f8             	mov    -0x8(%ebp),%edx
  402164:	b8 01 00 00 00       	mov    $0x1,%eax
  402169:	87 02                	xchg   %eax,(%edx)
  40216b:	85 c0                	test   %eax,%eax
  40216d:	75 f1                	jne    402160 <spin_lock+0xd>
}
  40216f:	c9                   	leave  
  402170:	c3                   	ret    

00402171 <spin_unlock>:

static inline void spin_unlock(struct spinlock *lock)
{
  402171:	55                   	push   %ebp
  402172:	48                   	dec    %eax
  402173:	89 e5                	mov    %esp,%ebp
  402175:	48                   	dec    %eax
  402176:	83 ec 08             	sub    $0x8,%esp
  402179:	48                   	dec    %eax
  40217a:	89 7d f8             	mov    %edi,-0x8(%ebp)
        __sync_lock_release(&lock->v);
  40217d:	48                   	dec    %eax
  40217e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402181:	ba 00 00 00 00       	mov    $0x0,%edx
  402186:	89 10                	mov    %edx,(%eax)
}
  402188:	c9                   	leave  
  402189:	c3                   	ret    

0040218a <serial_outb>:
static struct spinlock lock;
static int serial_iobase = 0x3f8;
static int serial_inited = 0;

static void serial_outb(char ch)
{
  40218a:	55                   	push   %ebp
  40218b:	48                   	dec    %eax
  40218c:	89 e5                	mov    %esp,%ebp
  40218e:	48                   	dec    %eax
  40218f:	83 ec 18             	sub    $0x18,%esp
  402192:	89 f8                	mov    %edi,%eax
  402194:	88 45 ec             	mov    %al,-0x14(%ebp)
        u8 lsr;

        do {
                lsr = inb(serial_iobase + 0x05);
  402197:	8b 05 7b 9e 00 00    	mov    0x9e7b,%eax
  40219d:	83 c0 05             	add    $0x5,%eax
  4021a0:	48                   	dec    %eax
  4021a1:	98                   	cwtl   
  4021a2:	48                   	dec    %eax
  4021a3:	89 c7                	mov    %eax,%edi
  4021a5:	e8 6f ff ff ff       	call   402119 <inb>
  4021aa:	88 45 ff             	mov    %al,-0x1(%ebp)
        } while (!(lsr & 0x20));
  4021ad:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
  4021b1:	83 e0 20             	and    $0x20,%eax
  4021b4:	85 c0                	test   %eax,%eax
  4021b6:	74 df                	je     402197 <serial_outb+0xd>

        outb(ch, serial_iobase + 0x00);
  4021b8:	8b 05 5a 9e 00 00    	mov    0x9e5a,%eax
  4021be:	48                   	dec    %eax
  4021bf:	63 d0                	arpl   %dx,%ax
  4021c1:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
  4021c5:	0f b6 c0             	movzbl %al,%eax
  4021c8:	48                   	dec    %eax
  4021c9:	89 d6                	mov    %edx,%esi
  4021cb:	89 c7                	mov    %eax,%edi
  4021cd:	e8 63 ff ff ff       	call   402135 <outb>
}
  4021d2:	c9                   	leave  
  4021d3:	c3                   	ret    

004021d4 <serial_init>:

//static void serial_init(void)
void serial_init(void)
{
  4021d4:	55                   	push   %ebp
  4021d5:	48                   	dec    %eax
  4021d6:	89 e5                	mov    %esp,%ebp
  4021d8:	48                   	dec    %eax
  4021d9:	83 ec 10             	sub    $0x10,%esp
        u8 lcr;

        /* set DLAB */
        lcr = inb(serial_iobase + 0x03);
  4021dc:	8b 05 36 9e 00 00    	mov    0x9e36,%eax
  4021e2:	83 c0 03             	add    $0x3,%eax
  4021e5:	48                   	dec    %eax
  4021e6:	98                   	cwtl   
  4021e7:	48                   	dec    %eax
  4021e8:	89 c7                	mov    %eax,%edi
  4021ea:	e8 2a ff ff ff       	call   402119 <inb>
  4021ef:	88 45 ff             	mov    %al,-0x1(%ebp)
        lcr |= 0x80;
  4021f2:	80 4d ff 80          	orb    $0x80,-0x1(%ebp)
        outb(lcr, serial_iobase + 0x03);
  4021f6:	8b 05 1c 9e 00 00    	mov    0x9e1c,%eax
  4021fc:	83 c0 03             	add    $0x3,%eax
  4021ff:	48                   	dec    %eax
  402200:	63 d0                	arpl   %dx,%ax
  402202:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
  402206:	48                   	dec    %eax
  402207:	89 d6                	mov    %edx,%esi
  402209:	89 c7                	mov    %eax,%edi
  40220b:	e8 25 ff ff ff       	call   402135 <outb>

        /* set baud rate to 115200 */
        outb(0x01, serial_iobase + 0x00);
  402210:	8b 05 02 9e 00 00    	mov    0x9e02,%eax
  402216:	48                   	dec    %eax
  402217:	98                   	cwtl   
  402218:	48                   	dec    %eax
  402219:	89 c6                	mov    %eax,%esi
  40221b:	bf 01 00 00 00       	mov    $0x1,%edi
  402220:	e8 10 ff ff ff       	call   402135 <outb>
        outb(0x00, serial_iobase + 0x01);
  402225:	8b 05 ed 9d 00 00    	mov    0x9ded,%eax
  40222b:	83 c0 01             	add    $0x1,%eax
  40222e:	48                   	dec    %eax
  40222f:	98                   	cwtl   
  402230:	48                   	dec    %eax
  402231:	89 c6                	mov    %eax,%esi
  402233:	bf 00 00 00 00       	mov    $0x0,%edi
  402238:	e8 f8 fe ff ff       	call   402135 <outb>

        /* clear DLAB */
        lcr = inb(serial_iobase + 0x03);
  40223d:	8b 05 d5 9d 00 00    	mov    0x9dd5,%eax
  402243:	83 c0 03             	add    $0x3,%eax
  402246:	48                   	dec    %eax
  402247:	98                   	cwtl   
  402248:	48                   	dec    %eax
  402249:	89 c7                	mov    %eax,%edi
  40224b:	e8 c9 fe ff ff       	call   402119 <inb>
  402250:	88 45 ff             	mov    %al,-0x1(%ebp)
        lcr &= ~0x80;
  402253:	80 65 ff 7f          	andb   $0x7f,-0x1(%ebp)
        outb(lcr, serial_iobase + 0x03);
  402257:	8b 05 bb 9d 00 00    	mov    0x9dbb,%eax
  40225d:	83 c0 03             	add    $0x3,%eax
  402260:	48                   	dec    %eax
  402261:	63 d0                	arpl   %dx,%ax
  402263:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
  402267:	48                   	dec    %eax
  402268:	89 d6                	mov    %edx,%esi
  40226a:	89 c7                	mov    %eax,%edi
  40226c:	e8 c4 fe ff ff       	call   402135 <outb>
}
  402271:	c9                   	leave  
  402272:	c3                   	ret    

00402273 <print_serial>:

static void print_serial(const char *buf)
{
  402273:	55                   	push   %ebp
  402274:	48                   	dec    %eax
  402275:	89 e5                	mov    %esp,%ebp
  402277:	48                   	dec    %eax
  402278:	83 ec 20             	sub    $0x20,%esp
  40227b:	48                   	dec    %eax
  40227c:	89 7d e8             	mov    %edi,-0x18(%ebp)
	unsigned long len = strlen(buf);
  40227f:	48                   	dec    %eax
  402280:	8b 45 e8             	mov    -0x18(%ebp),%eax
  402283:	48                   	dec    %eax
  402284:	89 c7                	mov    %eax,%edi
  402286:	e8 5c ec ff ff       	call   400ee7 <strlen>
  40228b:	48                   	dec    %eax
  40228c:	89 45 f8             	mov    %eax,-0x8(%ebp)
        }


        //asm volatile ("rep/outsb" : "+S"(buf), "+c"(len) : "d"(0x3f8));
#else
        asm volatile ("rep/outsb" : "+S"(buf), "+c"(len) : "d"(0x3f8));
  40228f:	ba f8 03 00 00       	mov    $0x3f8,%edx
  402294:	48                   	dec    %eax
  402295:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  402298:	48                   	dec    %eax
  402299:	8b 45 f8             	mov    -0x8(%ebp),%eax
  40229c:	48                   	dec    %eax
  40229d:	89 ce                	mov    %ecx,%esi
  40229f:	48                   	dec    %eax
  4022a0:	89 c1                	mov    %eax,%ecx
  4022a2:	f3 6e                	rep outsb %ds:(%esi),(%dx)
  4022a4:	48                   	dec    %eax
  4022a5:	89 c8                	mov    %ecx,%eax
  4022a7:	48                   	dec    %eax
  4022a8:	89 75 e8             	mov    %esi,-0x18(%ebp)
  4022ab:	48                   	dec    %eax
  4022ac:	89 45 f8             	mov    %eax,-0x8(%ebp)
#endif
}
  4022af:	c9                   	leave  
  4022b0:	c3                   	ret    

004022b1 <puts>:

void puts(const char *s)
{
  4022b1:	55                   	push   %ebp
  4022b2:	48                   	dec    %eax
  4022b3:	89 e5                	mov    %esp,%ebp
  4022b5:	48                   	dec    %eax
  4022b6:	83 ec 10             	sub    $0x10,%esp
  4022b9:	48                   	dec    %eax
  4022ba:	89 7d f8             	mov    %edi,-0x8(%ebp)
	spin_lock(&lock);
  4022bd:	bf 14 00 45 00       	mov    $0x450014,%edi
  4022c2:	e8 8c fe ff ff       	call   402153 <spin_lock>
	print_serial(s);
  4022c7:	48                   	dec    %eax
  4022c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  4022cb:	48                   	dec    %eax
  4022cc:	89 c7                	mov    %eax,%edi
  4022ce:	e8 a0 ff ff ff       	call   402273 <print_serial>
	spin_unlock(&lock);
  4022d3:	bf 14 00 45 00       	mov    $0x450014,%edi
  4022d8:	e8 94 fe ff ff       	call   402171 <spin_unlock>
}
  4022dd:	c9                   	leave  
  4022de:	c3                   	ret    

004022df <exit>:

void exit(int code)
{
  4022df:	55                   	push   %ebp
  4022e0:	48                   	dec    %eax
  4022e1:	89 e5                	mov    %esp,%ebp
  4022e3:	48                   	dec    %eax
  4022e4:	83 ec 04             	sub    $0x4,%esp
  4022e7:	89 7d fc             	mov    %edi,-0x4(%ebp)
        /* if that failed, try the Bochs poweroff port */
        for (i = 0; i < 8; i++) {
                outb(shutdown_str[i], 0x8900);
        }
#else
        asm volatile("out %0, %1" : : "a"(code), "d"((short)0xf4));
  4022ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  4022ed:	ba f4 00 00 00       	mov    $0xf4,%edx
  4022f2:	ef                   	out    %eax,(%dx)
#endif
}
  4022f3:	c9                   	leave  
  4022f4:	c3                   	ret    

004022f5 <wait>:

void wait()
{
  4022f5:	55                   	push   %ebp
  4022f6:	48                   	dec    %eax
  4022f7:	89 e5                	mov    %esp,%ebp
#ifdef __BARE_METAL
    while(1);
  4022f9:	eb fe                	jmp    4022f9 <wait+0x4>

004022fb <is_transmit_empty>:
//}

/**************************************************************************/

static inline int is_transmit_empty()
{
  4022fb:	55                   	push   %ebp
  4022fc:	48                   	dec    %eax
  4022fd:	89 e5                	mov    %esp,%ebp
        return !!(inb(serial_iobase + 5) & 0x20);
  4022ff:	8b 05 13 9d 00 00    	mov    0x9d13,%eax
  402305:	83 c0 05             	add    $0x5,%eax
  402308:	48                   	dec    %eax
  402309:	98                   	cwtl   
  40230a:	48                   	dec    %eax
  40230b:	89 c7                	mov    %eax,%edi
  40230d:	e8 07 fe ff ff       	call   402119 <inb>
  402312:	0f b6 c0             	movzbl %al,%eax
  402315:	83 e0 20             	and    $0x20,%eax
  402318:	85 c0                	test   %eax,%eax
  40231a:	0f 95 c0             	setne  %al
  40231d:	0f b6 c0             	movzbl %al,%eax
}
  402320:	5d                   	pop    %ebp
  402321:	c3                   	ret    

00402322 <serial_putc>:

void serial_putc(char ch) 
{
  402322:	55                   	push   %ebp
  402323:	48                   	dec    %eax
  402324:	89 e5                	mov    %esp,%ebp
  402326:	48                   	dec    %eax
  402327:	83 ec 08             	sub    $0x8,%esp
  40232a:	89 f8                	mov    %edi,%eax
  40232c:	88 45 fc             	mov    %al,-0x4(%ebp)
        while (!is_transmit_empty()) asm volatile("pause\n");
  40232f:	eb 02                	jmp    402333 <serial_putc+0x11>
  402331:	f3 90                	pause  
  402333:	b8 00 00 00 00       	mov    $0x0,%eax
  402338:	e8 be ff ff ff       	call   4022fb <is_transmit_empty>
  40233d:	85 c0                	test   %eax,%eax
  40233f:	74 f0                	je     402331 <serial_putc+0xf>

        outb(ch, serial_iobase);
  402341:	8b 05 d1 9c 00 00    	mov    0x9cd1,%eax
  402347:	48                   	dec    %eax
  402348:	63 d0                	arpl   %dx,%ax
  40234a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  40234e:	0f b6 c0             	movzbl %al,%eax
  402351:	48                   	dec    %eax
  402352:	89 d6                	mov    %edx,%esi
  402354:	89 c7                	mov    %eax,%edi
  402356:	e8 da fd ff ff       	call   402135 <outb>
}
  40235b:	c9                   	leave  
  40235c:	c3                   	ret    

0040235d <rdmsr>:
    asm volatile ("mov %%cr8, %0" : "=r"(val) : : "memory");
    return val;
}

static inline u64 rdmsr(u32 index)
{
  40235d:	55                   	push   %ebp
  40235e:	48                   	dec    %eax
  40235f:	89 e5                	mov    %esp,%ebp
  402361:	48                   	dec    %eax
  402362:	83 ec 14             	sub    $0x14,%esp
  402365:	89 7d ec             	mov    %edi,-0x14(%ebp)
    u32 a, d;
    asm volatile ("rdmsr" : "=a"(a), "=d"(d) : "c"(index) : "memory");
  402368:	8b 45 ec             	mov    -0x14(%ebp),%eax
  40236b:	89 c1                	mov    %eax,%ecx
  40236d:	0f 32                	rdmsr  
  40236f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  402372:	89 55 f8             	mov    %edx,-0x8(%ebp)
    return a | ((u64)d << 32);
  402375:	8b 45 fc             	mov    -0x4(%ebp),%eax
  402378:	8b 55 f8             	mov    -0x8(%ebp),%edx
  40237b:	48                   	dec    %eax
  40237c:	c1 e2 20             	shl    $0x20,%edx
  40237f:	48                   	dec    %eax
  402380:	09 d0                	or     %edx,%eax
}
  402382:	c9                   	leave  
  402383:	c3                   	ret    

00402384 <wrmsr>:

static inline void wrmsr(u32 index, u64 val)
{
  402384:	55                   	push   %ebp
  402385:	48                   	dec    %eax
  402386:	89 e5                	mov    %esp,%ebp
  402388:	48                   	dec    %eax
  402389:	83 ec 20             	sub    $0x20,%esp
  40238c:	89 7d ec             	mov    %edi,-0x14(%ebp)
  40238f:	48                   	dec    %eax
  402390:	89 75 e0             	mov    %esi,-0x20(%ebp)
    u32 a = val, d = val >> 32; 
  402393:	48                   	dec    %eax
  402394:	8b 45 e0             	mov    -0x20(%ebp),%eax
  402397:	89 45 fc             	mov    %eax,-0x4(%ebp)
  40239a:	48                   	dec    %eax
  40239b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  40239e:	48                   	dec    %eax
  40239f:	c1 e8 20             	shr    $0x20,%eax
  4023a2:	89 45 f8             	mov    %eax,-0x8(%ebp)
    asm volatile ("wrmsr" : : "a"(a), "d"(d), "c"(index) : "memory");
  4023a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  4023a8:	8b 55 f8             	mov    -0x8(%ebp),%edx
  4023ab:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  4023ae:	0f 30                	wrmsr  
}
  4023b0:	c9                   	leave  
  4023b1:	c3                   	ret    

004023b2 <outb>:
    return value;
}

#define outb outb
static inline void outb(uint8_t value, unsigned long port)
{
  4023b2:	55                   	push   %ebp
  4023b3:	48                   	dec    %eax
  4023b4:	89 e5                	mov    %esp,%ebp
  4023b6:	48                   	dec    %eax
  4023b7:	83 ec 10             	sub    $0x10,%esp
  4023ba:	89 f8                	mov    %edi,%eax
  4023bc:	48                   	dec    %eax
  4023bd:	89 75 f0             	mov    %esi,-0x10(%ebp)
  4023c0:	88 45 fc             	mov    %al,-0x4(%ebp)
    asm volatile("outb %b0, %w1" : : "a"(value), "Nd"((unsigned short)port));
  4023c3:	48                   	dec    %eax
  4023c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  4023c7:	89 c2                	mov    %eax,%edx
  4023c9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  4023cd:	ee                   	out    %al,(%dx)
}
  4023ce:	c9                   	leave  
  4023cf:	c3                   	ret    

004023d0 <lapicw>:
volatile uint *lapic;  // Initialized in mp.c

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  4023d0:	55                   	push   %ebp
  4023d1:	48                   	dec    %eax
  4023d2:	89 e5                	mov    %esp,%ebp
  4023d4:	48                   	dec    %eax
  4023d5:	83 ec 08             	sub    $0x8,%esp
  4023d8:	89 7d fc             	mov    %edi,-0x4(%ebp)
  4023db:	89 75 f8             	mov    %esi,-0x8(%ebp)
  lapic[index] = value;
  4023de:	48                   	dec    %eax
  4023df:	8b 05 43 dc 04 00    	mov    0x4dc43,%eax
  4023e5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  4023e8:	48                   	dec    %eax
  4023e9:	63 d2                	arpl   %dx,%dx
  4023eb:	48                   	dec    %eax
  4023ec:	c1 e2 02             	shl    $0x2,%edx
  4023ef:	48                   	dec    %eax
  4023f0:	01 c2                	add    %eax,%edx
  4023f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  4023f5:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
  4023f7:	48                   	dec    %eax
  4023f8:	8b 05 2a dc 04 00    	mov    0x4dc2a,%eax
  4023fe:	48                   	dec    %eax
  4023ff:	83 c0 20             	add    $0x20,%eax
  402402:	8b 00                	mov    (%eax),%eax
}
  402404:	c9                   	leave  
  402405:	c3                   	ret    

00402406 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us) 
{
  402406:	55                   	push   %ebp
  402407:	48                   	dec    %eax
  402408:	89 e5                	mov    %esp,%ebp
  40240a:	48                   	dec    %eax
  40240b:	83 ec 04             	sub    $0x4,%esp
  40240e:	89 7d fc             	mov    %edi,-0x4(%ebp)
}
  402411:	c9                   	leave  
  402412:	c3                   	ret    

00402413 <lapicstartap>:


// Start additional processor running entry code at addr.
void
lapicstartap(uchar apicid, uint addr)
{
  402413:	55                   	push   %ebp
  402414:	48                   	dec    %eax
  402415:	89 e5                	mov    %esp,%ebp
  402417:	48                   	dec    %eax
  402418:	83 ec 18             	sub    $0x18,%esp
  40241b:	89 f8                	mov    %edi,%eax
  40241d:	89 75 e8             	mov    %esi,-0x18(%ebp)
  402420:	88 45 ec             	mov    %al,-0x14(%ebp)
  int i;
  ushort *wrv;
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(0xF, CMOS_PORT);  // offset 0xF is shutdown code
  402423:	be 70 00 00 00       	mov    $0x70,%esi
  402428:	bf 0f 00 00 00       	mov    $0xf,%edi
  40242d:	e8 80 ff ff ff       	call   4023b2 <outb>
  outb(0x0A, CMOS_PORT+1);
  402432:	be 71 00 00 00       	mov    $0x71,%esi
  402437:	bf 0a 00 00 00       	mov    $0xa,%edi
  40243c:	e8 71 ff ff ff       	call   4023b2 <outb>
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  402441:	48                   	dec    %eax
  402442:	c7 45 f0 67 04 00 00 	movl   $0x467,-0x10(%ebp)
  wrv[0] = 0;
  402449:	48                   	dec    %eax
  40244a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  40244d:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
  402452:	48                   	dec    %eax
  402453:	8b 45 f0             	mov    -0x10(%ebp),%eax
  402456:	48                   	dec    %eax
  402457:	8d 50 02             	lea    0x2(%eax),%edx
  40245a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  40245d:	c1 e8 04             	shr    $0x4,%eax
  402460:	66 89 02             	mov    %ax,(%edx)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
  402463:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
  402467:	c1 e0 18             	shl    $0x18,%eax
  40246a:	89 c6                	mov    %eax,%esi
  40246c:	bf c4 00 00 00       	mov    $0xc4,%edi
  402471:	e8 5a ff ff ff       	call   4023d0 <lapicw>
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
  402476:	be 00 c5 00 00       	mov    $0xc500,%esi
  40247b:	bf c0 00 00 00       	mov    $0xc0,%edi
  402480:	e8 4b ff ff ff       	call   4023d0 <lapicw>
  microdelay(200);
  402485:	bf c8 00 00 00       	mov    $0xc8,%edi
  40248a:	e8 77 ff ff ff       	call   402406 <microdelay>
  lapicw(ICRLO, INIT | LEVEL);
  40248f:	be 00 85 00 00       	mov    $0x8500,%esi
  402494:	bf c0 00 00 00       	mov    $0xc0,%edi
  402499:	e8 32 ff ff ff       	call   4023d0 <lapicw>
  microdelay(100);    // should be 10ms, but too slow in Bochs!
  40249e:	bf 64 00 00 00       	mov    $0x64,%edi
  4024a3:	e8 5e ff ff ff       	call   402406 <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
  4024a8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  4024af:	eb 36                	jmp    4024e7 <lapicstartap+0xd4>
    lapicw(ICRHI, apicid<<24);
  4024b1:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
  4024b5:	c1 e0 18             	shl    $0x18,%eax
  4024b8:	89 c6                	mov    %eax,%esi
  4024ba:	bf c4 00 00 00       	mov    $0xc4,%edi
  4024bf:	e8 0c ff ff ff       	call   4023d0 <lapicw>
    lapicw(ICRLO, STARTUP | (addr>>12));
  4024c4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4024c7:	c1 e8 0c             	shr    $0xc,%eax
  4024ca:	80 cc 06             	or     $0x6,%ah
  4024cd:	89 c6                	mov    %eax,%esi
  4024cf:	bf c0 00 00 00       	mov    $0xc0,%edi
  4024d4:	e8 f7 fe ff ff       	call   4023d0 <lapicw>
    microdelay(200);
  4024d9:	bf c8 00 00 00       	mov    $0xc8,%edi
  4024de:	e8 23 ff ff ff       	call   402406 <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
  4024e3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  4024e7:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  4024eb:	7e c4                	jle    4024b1 <lapicstartap+0x9e>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }

}
  4024ed:	c9                   	leave  
  4024ee:	c3                   	ret    

004024ef <eoi>:
{
    asm volatile ("out %0, %1" : : "a"(data), "d"(port));
}
*/
void eoi(void)
{
  4024ef:	55                   	push   %ebp
  4024f0:	48                   	dec    %eax
  4024f1:	89 e5                	mov    %esp,%ebp
    apic_write(APIC_EOI, 0);
  4024f3:	be 00 00 00 00       	mov    $0x0,%esi
  4024f8:	bf b0 00 00 00       	mov    $0xb0,%edi
  4024fd:	e8 2e 01 00 00       	call   402630 <apic_write>
}
  402502:	5d                   	pop    %ebp
  402503:	c3                   	ret    

00402504 <xapic_read>:

static u32 xapic_read(unsigned reg)
{
  402504:	55                   	push   %ebp
  402505:	48                   	dec    %eax
  402506:	89 e5                	mov    %esp,%ebp
  402508:	48                   	dec    %eax
  402509:	83 ec 04             	sub    $0x4,%esp
  40250c:	89 7d fc             	mov    %edi,-0x4(%ebp)
    return *(volatile u32 *)(g_apic + reg);
  40250f:	48                   	dec    %eax
  402510:	8b 15 0a 9b 00 00    	mov    0x9b0a,%edx
  402516:	8b 45 fc             	mov    -0x4(%ebp),%eax
  402519:	48                   	dec    %eax
  40251a:	01 d0                	add    %edx,%eax
  40251c:	8b 00                	mov    (%eax),%eax
}
  40251e:	c9                   	leave  
  40251f:	c3                   	ret    

00402520 <xapic_write>:

static void xapic_write(unsigned reg, u32 val)
{
  402520:	55                   	push   %ebp
  402521:	48                   	dec    %eax
  402522:	89 e5                	mov    %esp,%ebp
  402524:	48                   	dec    %eax
  402525:	83 ec 08             	sub    $0x8,%esp
  402528:	89 7d fc             	mov    %edi,-0x4(%ebp)
  40252b:	89 75 f8             	mov    %esi,-0x8(%ebp)
    *(volatile u32 *)(g_apic + reg) = val;
  40252e:	48                   	dec    %eax
  40252f:	8b 15 eb 9a 00 00    	mov    0x9aeb,%edx
  402535:	8b 45 fc             	mov    -0x4(%ebp),%eax
  402538:	48                   	dec    %eax
  402539:	01 c2                	add    %eax,%edx
  40253b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  40253e:	89 02                	mov    %eax,(%edx)
}
  402540:	c9                   	leave  
  402541:	c3                   	ret    

00402542 <xapic_icr_write>:

static void xapic_icr_write(u32 val, u32 dest)
{
  402542:	55                   	push   %ebp
  402543:	48                   	dec    %eax
  402544:	89 e5                	mov    %esp,%ebp
  402546:	48                   	dec    %eax
  402547:	83 ec 08             	sub    $0x8,%esp
  40254a:	89 7d fc             	mov    %edi,-0x4(%ebp)
  40254d:	89 75 f8             	mov    %esi,-0x8(%ebp)
    while (xapic_read(APIC_ICR) & APIC_ICR_BUSY)
  402550:	90                   	nop
  402551:	bf 00 03 00 00       	mov    $0x300,%edi
  402556:	e8 a9 ff ff ff       	call   402504 <xapic_read>
  40255b:	25 00 10 00 00       	and    $0x1000,%eax
  402560:	85 c0                	test   %eax,%eax
  402562:	75 ed                	jne    402551 <xapic_icr_write+0xf>
        ;
    xapic_write(APIC_ICR2, dest << 24);
  402564:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402567:	c1 e0 18             	shl    $0x18,%eax
  40256a:	89 c6                	mov    %eax,%esi
  40256c:	bf 10 03 00 00       	mov    $0x310,%edi
  402571:	e8 aa ff ff ff       	call   402520 <xapic_write>
    xapic_write(APIC_ICR, val);
  402576:	8b 45 fc             	mov    -0x4(%ebp),%eax
  402579:	89 c6                	mov    %eax,%esi
  40257b:	bf 00 03 00 00       	mov    $0x300,%edi
  402580:	e8 9b ff ff ff       	call   402520 <xapic_write>
}
  402585:	c9                   	leave  
  402586:	c3                   	ret    

00402587 <xapic_id>:

static uint32_t xapic_id(void)
{
  402587:	55                   	push   %ebp
  402588:	48                   	dec    %eax
  402589:	89 e5                	mov    %esp,%ebp
    return xapic_read(APIC_ID) >> 24;
  40258b:	bf 20 00 00 00       	mov    $0x20,%edi
  402590:	e8 6f ff ff ff       	call   402504 <xapic_read>
  402595:	c1 e8 18             	shr    $0x18,%eax
}
  402598:	5d                   	pop    %ebp
  402599:	c3                   	ret    

0040259a <x2apic_read>:
};

static const struct apic_ops *apic_ops = &xapic_ops;

static u32 x2apic_read(unsigned reg)
{
  40259a:	55                   	push   %ebp
  40259b:	48                   	dec    %eax
  40259c:	89 e5                	mov    %esp,%ebp
  40259e:	48                   	dec    %eax
  40259f:	83 ec 14             	sub    $0x14,%esp
  4025a2:	89 7d ec             	mov    %edi,-0x14(%ebp)
    unsigned a, d;

    asm volatile ("rdmsr" : "=a"(a), "=d"(d) : "c"(APIC_BASE_MSR + reg/16));
  4025a5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  4025a8:	c1 e8 04             	shr    $0x4,%eax
  4025ab:	05 00 08 00 00       	add    $0x800,%eax
  4025b0:	89 c1                	mov    %eax,%ecx
  4025b2:	0f 32                	rdmsr  
  4025b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  4025b7:	89 55 f8             	mov    %edx,-0x8(%ebp)
    return a | (u64)d << 32;
  4025ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  4025bd:	c9                   	leave  
  4025be:	c3                   	ret    

004025bf <x2apic_write>:

static void x2apic_write(unsigned reg, u32 val)
{
  4025bf:	55                   	push   %ebp
  4025c0:	48                   	dec    %eax
  4025c1:	89 e5                	mov    %esp,%ebp
  4025c3:	48                   	dec    %eax
  4025c4:	83 ec 08             	sub    $0x8,%esp
  4025c7:	89 7d fc             	mov    %edi,-0x4(%ebp)
  4025ca:	89 75 f8             	mov    %esi,-0x8(%ebp)
    asm volatile ("wrmsr" : : "a"(val), "d"(0), "c"(APIC_BASE_MSR + reg/16));
  4025cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  4025d0:	c1 e8 04             	shr    $0x4,%eax
  4025d3:	8d 88 00 08 00 00    	lea    0x800(%eax),%ecx
  4025d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  4025dc:	ba 00 00 00 00       	mov    $0x0,%edx
  4025e1:	0f 30                	wrmsr  
}
  4025e3:	c9                   	leave  
  4025e4:	c3                   	ret    

004025e5 <x2apic_icr_write>:

static void x2apic_icr_write(u32 val, u32 dest)
{
  4025e5:	55                   	push   %ebp
  4025e6:	48                   	dec    %eax
  4025e7:	89 e5                	mov    %esp,%ebp
  4025e9:	48                   	dec    %eax
  4025ea:	83 ec 08             	sub    $0x8,%esp
  4025ed:	89 7d fc             	mov    %edi,-0x4(%ebp)
  4025f0:	89 75 f8             	mov    %esi,-0x8(%ebp)
    asm volatile ("wrmsr" : : "a"(val), "d"(dest),
  4025f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  4025f6:	8b 55 f8             	mov    -0x8(%ebp),%edx
  4025f9:	b9 30 08 00 00       	mov    $0x830,%ecx
  4025fe:	0f 30                	wrmsr  
                  "c"(APIC_BASE_MSR + APIC_ICR/16));
}
  402600:	c9                   	leave  
  402601:	c3                   	ret    

00402602 <x2apic_id>:

static uint32_t x2apic_id(void)
{
  402602:	55                   	push   %ebp
  402603:	48                   	dec    %eax
  402604:	89 e5                	mov    %esp,%ebp
    return x2apic_read(APIC_ID);
  402606:	bf 20 00 00 00       	mov    $0x20,%edi
  40260b:	e8 8a ff ff ff       	call   40259a <x2apic_read>
}
  402610:	5d                   	pop    %ebp
  402611:	c3                   	ret    

00402612 <apic_read>:
    .icr_write = x2apic_icr_write,
    .id = x2apic_id,
};

u32 apic_read(unsigned reg)
{
  402612:	55                   	push   %ebp
  402613:	48                   	dec    %eax
  402614:	89 e5                	mov    %esp,%ebp
  402616:	48                   	dec    %eax
  402617:	83 ec 10             	sub    $0x10,%esp
  40261a:	89 7d fc             	mov    %edi,-0x4(%ebp)
    return apic_ops->reg_read(reg);
  40261d:	48                   	dec    %eax
  40261e:	8b 05 0c 9a 00 00    	mov    0x9a0c,%eax
  402624:	48                   	dec    %eax
  402625:	8b 00                	mov    (%eax),%eax
  402627:	8b 55 fc             	mov    -0x4(%ebp),%edx
  40262a:	89 d7                	mov    %edx,%edi
  40262c:	ff d0                	call   *%eax
}
  40262e:	c9                   	leave  
  40262f:	c3                   	ret    

00402630 <apic_write>:

void apic_write(unsigned reg, u32 val)
{
  402630:	55                   	push   %ebp
  402631:	48                   	dec    %eax
  402632:	89 e5                	mov    %esp,%ebp
  402634:	48                   	dec    %eax
  402635:	83 ec 10             	sub    $0x10,%esp
  402638:	89 7d fc             	mov    %edi,-0x4(%ebp)
  40263b:	89 75 f8             	mov    %esi,-0x8(%ebp)
    apic_ops->reg_write(reg, val);
  40263e:	48                   	dec    %eax
  40263f:	8b 05 eb 99 00 00    	mov    0x99eb,%eax
  402645:	48                   	dec    %eax
  402646:	8b 40 08             	mov    0x8(%eax),%eax
  402649:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  40264c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  40264f:	89 ce                	mov    %ecx,%esi
  402651:	89 d7                	mov    %edx,%edi
  402653:	ff d0                	call   *%eax
}
  402655:	c9                   	leave  
  402656:	c3                   	ret    

00402657 <apic_read_bit>:

bool apic_read_bit(unsigned reg, int n)
{
  402657:	55                   	push   %ebp
  402658:	48                   	dec    %eax
  402659:	89 e5                	mov    %esp,%ebp
  40265b:	48                   	dec    %eax
  40265c:	83 ec 10             	sub    $0x10,%esp
  40265f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  402662:	89 75 f8             	mov    %esi,-0x8(%ebp)
    reg += (n >> 5) << 4;
  402665:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402668:	c1 f8 05             	sar    $0x5,%eax
  40266b:	c1 e0 04             	shl    $0x4,%eax
  40266e:	01 45 fc             	add    %eax,-0x4(%ebp)
    n &= 31;
  402671:	83 65 f8 1f          	andl   $0x1f,-0x8(%ebp)
    return (apic_read(reg) & (1 << n)) != 0;
  402675:	8b 45 fc             	mov    -0x4(%ebp),%eax
  402678:	89 c7                	mov    %eax,%edi
  40267a:	e8 93 ff ff ff       	call   402612 <apic_read>
  40267f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  402682:	be 01 00 00 00       	mov    $0x1,%esi
  402687:	89 d1                	mov    %edx,%ecx
  402689:	d3 e6                	shl    %cl,%esi
  40268b:	89 f2                	mov    %esi,%edx
  40268d:	21 d0                	and    %edx,%eax
  40268f:	85 c0                	test   %eax,%eax
  402691:	0f 95 c0             	setne  %al
}
  402694:	c9                   	leave  
  402695:	c3                   	ret    

00402696 <apic_icr_write>:

void apic_icr_write(u32 val, u32 dest)
{
  402696:	55                   	push   %ebp
  402697:	48                   	dec    %eax
  402698:	89 e5                	mov    %esp,%ebp
  40269a:	48                   	dec    %eax
  40269b:	83 ec 10             	sub    $0x10,%esp
  40269e:	89 7d fc             	mov    %edi,-0x4(%ebp)
  4026a1:	89 75 f8             	mov    %esi,-0x8(%ebp)
    apic_ops->icr_write(val, dest);
  4026a4:	48                   	dec    %eax
  4026a5:	8b 05 85 99 00 00    	mov    0x9985,%eax
  4026ab:	48                   	dec    %eax
  4026ac:	8b 40 10             	mov    0x10(%eax),%eax
  4026af:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  4026b2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  4026b5:	89 ce                	mov    %ecx,%esi
  4026b7:	89 d7                	mov    %edx,%edi
  4026b9:	ff d0                	call   *%eax
}
  4026bb:	c9                   	leave  
  4026bc:	c3                   	ret    

004026bd <apic_id>:

uint32_t apic_id(void)
{
  4026bd:	55                   	push   %ebp
  4026be:	48                   	dec    %eax
  4026bf:	89 e5                	mov    %esp,%ebp
    return apic_ops->id();
  4026c1:	48                   	dec    %eax
  4026c2:	8b 05 68 99 00 00    	mov    0x9968,%eax
  4026c8:	48                   	dec    %eax
  4026c9:	8b 40 18             	mov    0x18(%eax),%eax
  4026cc:	ff d0                	call   *%eax
}
  4026ce:	5d                   	pop    %ebp
  4026cf:	c3                   	ret    

004026d0 <apic_get_tpr>:

uint8_t apic_get_tpr(void)
{
  4026d0:	55                   	push   %ebp
  4026d1:	48                   	dec    %eax
  4026d2:	89 e5                	mov    %esp,%ebp
  4026d4:	48                   	dec    %eax
  4026d5:	83 ec 10             	sub    $0x10,%esp
	unsigned long tpr;

#ifdef __x86_64__
	asm volatile ("mov %%cr8, %0" : "=r"(tpr));
  4026d8:	44                   	inc    %esp
  4026d9:	0f 20 c0             	mov    %cr0,%eax
  4026dc:	48                   	dec    %eax
  4026dd:	89 45 f8             	mov    %eax,-0x8(%ebp)
#else
	tpr = apic_read(APIC_TASKPRI) >> 4;
#endif
	return tpr;
  4026e0:	48                   	dec    %eax
  4026e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  4026e4:	c9                   	leave  
  4026e5:	c3                   	ret    

004026e6 <apic_set_tpr>:

void apic_set_tpr(uint8_t tpr)
{
  4026e6:	55                   	push   %ebp
  4026e7:	48                   	dec    %eax
  4026e8:	89 e5                	mov    %esp,%ebp
  4026ea:	48                   	dec    %eax
  4026eb:	83 ec 04             	sub    $0x4,%esp
  4026ee:	89 f8                	mov    %edi,%eax
  4026f0:	88 45 fc             	mov    %al,-0x4(%ebp)
#ifdef __x86_64__
	asm volatile ("mov %0, %%cr8" : : "r"((unsigned long) tpr));
  4026f3:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  4026f7:	44                   	inc    %esp
  4026f8:	0f 22 c0             	mov    %eax,%cr0
#else
	apic_write(APIC_TASKPRI, tpr << 4);
#endif
}
  4026fb:	c9                   	leave  
  4026fc:	c3                   	ret    

004026fd <enable_x2apic>:

int enable_x2apic(void)
{
  4026fd:	55                   	push   %ebp
  4026fe:	48                   	dec    %eax
  4026ff:	89 e5                	mov    %esp,%ebp
  402701:	53                   	push   %ebx
  402702:	48                   	dec    %eax
  402703:	83 ec 10             	sub    $0x10,%esp
    unsigned a, b, c, d;

    asm ("cpuid" : "=a"(a), "=b"(b), "=c"(c), "=d"(d) : "0"(1));
  402706:	b8 01 00 00 00       	mov    $0x1,%eax
  40270b:	0f a2                	cpuid  
  40270d:	89 de                	mov    %ebx,%esi
  40270f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  402712:	89 75 f0             	mov    %esi,-0x10(%ebp)
  402715:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  402718:	89 55 e8             	mov    %edx,-0x18(%ebp)

    if (c & (1 << 21)) {
  40271b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  40271e:	25 00 00 20 00       	and    $0x200000,%eax
  402723:	85 c0                	test   %eax,%eax
  402725:	74 35                	je     40275c <enable_x2apic+0x5f>
        asm ("rdmsr" : "=a"(a), "=d"(d) : "c"(MSR_IA32_APICBASE));
  402727:	b8 1b 00 00 00       	mov    $0x1b,%eax
  40272c:	89 c1                	mov    %eax,%ecx
  40272e:	0f 32                	rdmsr  
  402730:	89 45 f4             	mov    %eax,-0xc(%ebp)
  402733:	89 55 e8             	mov    %edx,-0x18(%ebp)
        a |= 1 << 10;
  402736:	81 4d f4 00 04 00 00 	orl    $0x400,-0xc(%ebp)
        asm ("wrmsr" : : "a"(a), "d"(d), "c"(MSR_IA32_APICBASE));
  40273d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  402740:	8b 55 e8             	mov    -0x18(%ebp),%edx
  402743:	b9 1b 00 00 00       	mov    $0x1b,%ecx
  402748:	0f 30                	wrmsr  
        apic_ops = &x2apic_ops;
  40274a:	48                   	dec    %eax
  40274b:	c7 05 db 98 00 00 80 	movl   $0x40d480,0x98db
  402752:	d4 40 00 
        return 1;
  402755:	b8 01 00 00 00       	mov    $0x1,%eax
  40275a:	eb 05                	jmp    402761 <enable_x2apic+0x64>
    } else {
        return 0;
  40275c:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  402761:	48                   	dec    %eax
  402762:	83 c4 10             	add    $0x10,%esp
  402765:	5b                   	pop    %ebx
  402766:	5d                   	pop    %ebp
  402767:	c3                   	ret    

00402768 <disable_apic>:

void disable_apic(void)
{
  402768:	55                   	push   %ebp
  402769:	48                   	dec    %eax
  40276a:	89 e5                	mov    %esp,%ebp
    wrmsr(MSR_IA32_APICBASE, rdmsr(MSR_IA32_APICBASE) & ~(APIC_EN | APIC_EXTD));
  40276c:	bf 1b 00 00 00       	mov    $0x1b,%edi
  402771:	e8 e7 fb ff ff       	call   40235d <rdmsr>
  402776:	80 e4 f3             	and    $0xf3,%ah
  402779:	48                   	dec    %eax
  40277a:	89 c6                	mov    %eax,%esi
  40277c:	bf 1b 00 00 00       	mov    $0x1b,%edi
  402781:	e8 fe fb ff ff       	call   402384 <wrmsr>
    apic_ops = &xapic_ops;
  402786:	48                   	dec    %eax
  402787:	c7 05 9f 98 00 00 60 	movl   $0x40d460,0x989f
  40278e:	d4 40 00 
}
  402791:	5d                   	pop    %ebp
  402792:	c3                   	ret    

00402793 <reset_apic>:

void reset_apic(void)
{
  402793:	55                   	push   %ebp
  402794:	48                   	dec    %eax
  402795:	89 e5                	mov    %esp,%ebp
    disable_apic();
  402797:	e8 cc ff ff ff       	call   402768 <disable_apic>
    wrmsr(MSR_IA32_APICBASE, rdmsr(MSR_IA32_APICBASE) | APIC_EN);
  40279c:	bf 1b 00 00 00       	mov    $0x1b,%edi
  4027a1:	e8 b7 fb ff ff       	call   40235d <rdmsr>
  4027a6:	80 cc 08             	or     $0x8,%ah
  4027a9:	48                   	dec    %eax
  4027aa:	89 c6                	mov    %eax,%esi
  4027ac:	bf 1b 00 00 00       	mov    $0x1b,%edi
  4027b1:	e8 ce fb ff ff       	call   402384 <wrmsr>
}
  4027b6:	5d                   	pop    %ebp
  4027b7:	c3                   	ret    

004027b8 <ioapic_read_reg>:

u32 ioapic_read_reg(unsigned reg)
{
  4027b8:	55                   	push   %ebp
  4027b9:	48                   	dec    %eax
  4027ba:	89 e5                	mov    %esp,%ebp
  4027bc:	48                   	dec    %eax
  4027bd:	83 ec 04             	sub    $0x4,%esp
  4027c0:	89 7d fc             	mov    %edi,-0x4(%ebp)
    *(volatile u32 *)g_ioapic = reg;
  4027c3:	48                   	dec    %eax
  4027c4:	8b 05 5e 98 00 00    	mov    0x985e,%eax
  4027ca:	8b 55 fc             	mov    -0x4(%ebp),%edx
  4027cd:	89 10                	mov    %edx,(%eax)
    return *(volatile u32 *)(g_ioapic + 0x10);
  4027cf:	48                   	dec    %eax
  4027d0:	8b 05 52 98 00 00    	mov    0x9852,%eax
  4027d6:	48                   	dec    %eax
  4027d7:	83 c0 10             	add    $0x10,%eax
  4027da:	8b 00                	mov    (%eax),%eax
}
  4027dc:	c9                   	leave  
  4027dd:	c3                   	ret    

004027de <ioapic_write_reg>:

void ioapic_write_reg(unsigned reg, u32 value)
{
  4027de:	55                   	push   %ebp
  4027df:	48                   	dec    %eax
  4027e0:	89 e5                	mov    %esp,%ebp
  4027e2:	48                   	dec    %eax
  4027e3:	83 ec 08             	sub    $0x8,%esp
  4027e6:	89 7d fc             	mov    %edi,-0x4(%ebp)
  4027e9:	89 75 f8             	mov    %esi,-0x8(%ebp)
    *(volatile u32 *)g_ioapic = reg;
  4027ec:	48                   	dec    %eax
  4027ed:	8b 05 35 98 00 00    	mov    0x9835,%eax
  4027f3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  4027f6:	89 10                	mov    %edx,(%eax)
    *(volatile u32 *)(g_ioapic + 0x10) = value;
  4027f8:	48                   	dec    %eax
  4027f9:	8b 05 29 98 00 00    	mov    0x9829,%eax
  4027ff:	48                   	dec    %eax
  402800:	8d 50 10             	lea    0x10(%eax),%edx
  402803:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402806:	89 02                	mov    %eax,(%edx)
}
  402808:	c9                   	leave  
  402809:	c3                   	ret    

0040280a <ioapic_write_redir>:

void ioapic_write_redir(unsigned line, ioapic_redir_entry_t e)
{
  40280a:	55                   	push   %ebp
  40280b:	48                   	dec    %eax
  40280c:	89 e5                	mov    %esp,%ebp
  40280e:	48                   	dec    %eax
  40280f:	83 ec 10             	sub    $0x10,%esp
  402812:	89 7d fc             	mov    %edi,-0x4(%ebp)
  402815:	48                   	dec    %eax
  402816:	89 75 f4             	mov    %esi,-0xc(%ebp)
    ioapic_write_reg(0x10 + line * 2 + 0, ((u32 *)&e)[0]);
  402819:	48                   	dec    %eax
  40281a:	8d 45 f4             	lea    -0xc(%ebp),%eax
  40281d:	8b 00                	mov    (%eax),%eax
  40281f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  402822:	83 c2 08             	add    $0x8,%edx
  402825:	01 d2                	add    %edx,%edx
  402827:	89 c6                	mov    %eax,%esi
  402829:	89 d7                	mov    %edx,%edi
  40282b:	e8 ae ff ff ff       	call   4027de <ioapic_write_reg>
    ioapic_write_reg(0x10 + line * 2 + 1, ((u32 *)&e)[1]);
  402830:	48                   	dec    %eax
  402831:	8d 45 f4             	lea    -0xc(%ebp),%eax
  402834:	48                   	dec    %eax
  402835:	83 c0 04             	add    $0x4,%eax
  402838:	8b 00                	mov    (%eax),%eax
  40283a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  40283d:	83 c2 08             	add    $0x8,%edx
  402840:	01 d2                	add    %edx,%edx
  402842:	83 c2 01             	add    $0x1,%edx
  402845:	89 c6                	mov    %eax,%esi
  402847:	89 d7                	mov    %edx,%edi
  402849:	e8 90 ff ff ff       	call   4027de <ioapic_write_reg>
}
  40284e:	c9                   	leave  
  40284f:	c3                   	ret    

00402850 <ioapic_read_redir>:

ioapic_redir_entry_t ioapic_read_redir(unsigned line)
{
  402850:	55                   	push   %ebp
  402851:	48                   	dec    %eax
  402852:	89 e5                	mov    %esp,%ebp
  402854:	53                   	push   %ebx
  402855:	48                   	dec    %eax
  402856:	83 ec 18             	sub    $0x18,%esp
  402859:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    ioapic_redir_entry_t e;

    ((u32 *)&e)[0] = ioapic_read_reg(0x10 + line * 2 + 0);
  40285c:	48                   	dec    %eax
  40285d:	8d 5d f0             	lea    -0x10(%ebp),%ebx
  402860:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  402863:	83 c0 08             	add    $0x8,%eax
  402866:	01 c0                	add    %eax,%eax
  402868:	89 c7                	mov    %eax,%edi
  40286a:	e8 49 ff ff ff       	call   4027b8 <ioapic_read_reg>
  40286f:	89 03                	mov    %eax,(%ebx)
    ((u32 *)&e)[1] = ioapic_read_reg(0x10 + line * 2 + 1);
  402871:	48                   	dec    %eax
  402872:	8d 5d f0             	lea    -0x10(%ebp),%ebx
  402875:	48                   	dec    %eax
  402876:	83 c3 04             	add    $0x4,%ebx
  402879:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  40287c:	83 c0 08             	add    $0x8,%eax
  40287f:	01 c0                	add    %eax,%eax
  402881:	83 c0 01             	add    $0x1,%eax
  402884:	89 c7                	mov    %eax,%edi
  402886:	e8 2d ff ff ff       	call   4027b8 <ioapic_read_reg>
  40288b:	89 03                	mov    %eax,(%ebx)
    return e;
  40288d:	48                   	dec    %eax
  40288e:	8b 45 f0             	mov    -0x10(%ebp),%eax

}
  402891:	48                   	dec    %eax
  402892:	83 c4 18             	add    $0x18,%esp
  402895:	5b                   	pop    %ebx
  402896:	5d                   	pop    %ebp
  402897:	c3                   	ret    

00402898 <ioapic_set_redir>:

void ioapic_set_redir(unsigned line, unsigned vec,
			     trigger_mode_t trig_mode)
{
  402898:	55                   	push   %ebp
  402899:	48                   	dec    %eax
  40289a:	89 e5                	mov    %esp,%ebp
  40289c:	48                   	dec    %eax
  40289d:	83 ec 20             	sub    $0x20,%esp
  4028a0:	89 7d ec             	mov    %edi,-0x14(%ebp)
  4028a3:	89 75 e8             	mov    %esi,-0x18(%ebp)
  4028a6:	89 55 e4             	mov    %edx,-0x1c(%ebp)
	ioapic_redir_entry_t e = {
  4028a9:	48                   	dec    %eax
  4028aa:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  4028b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4028b4:	88 45 f8             	mov    %al,-0x8(%ebp)
  4028b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  4028ba:	83 e0 01             	and    $0x1,%eax
  4028bd:	c1 e0 07             	shl    $0x7,%eax
  4028c0:	89 c2                	mov    %eax,%edx
  4028c2:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  4028c6:	83 e0 7f             	and    $0x7f,%eax
  4028c9:	09 d0                	or     %edx,%eax
  4028cb:	88 45 f9             	mov    %al,-0x7(%ebp)
		.vector = vec,
		.delivery_mode = 0,
		.trig_mode = trig_mode,
	};

	ioapic_write_redir(line, e);
  4028ce:	48                   	dec    %eax
  4028cf:	8b 55 f8             	mov    -0x8(%ebp),%edx
  4028d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  4028d5:	48                   	dec    %eax
  4028d6:	89 d6                	mov    %edx,%esi
  4028d8:	89 c7                	mov    %eax,%edi
  4028da:	e8 2b ff ff ff       	call   40280a <ioapic_write_redir>
}
  4028df:	c9                   	leave  
  4028e0:	c3                   	ret    

004028e1 <set_mask>:

void set_mask(unsigned line, int mask)
{
  4028e1:	55                   	push   %ebp
  4028e2:	48                   	dec    %eax
  4028e3:	89 e5                	mov    %esp,%ebp
  4028e5:	48                   	dec    %eax
  4028e6:	83 ec 18             	sub    $0x18,%esp
  4028e9:	89 7d ec             	mov    %edi,-0x14(%ebp)
  4028ec:	89 75 e8             	mov    %esi,-0x18(%ebp)
    ioapic_redir_entry_t e = ioapic_read_redir(line);
  4028ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  4028f2:	89 c7                	mov    %eax,%edi
  4028f4:	e8 57 ff ff ff       	call   402850 <ioapic_read_redir>
  4028f9:	48                   	dec    %eax
  4028fa:	89 45 f8             	mov    %eax,-0x8(%ebp)

    e.mask = mask;
  4028fd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  402900:	83 e0 01             	and    $0x1,%eax
  402903:	83 e0 01             	and    $0x1,%eax
  402906:	89 c2                	mov    %eax,%edx
  402908:	0f b6 45 fa          	movzbl -0x6(%ebp),%eax
  40290c:	83 e0 fe             	and    $0xfffffffe,%eax
  40290f:	09 d0                	or     %edx,%eax
  402911:	88 45 fa             	mov    %al,-0x6(%ebp)
    ioapic_write_redir(line, e);
  402914:	48                   	dec    %eax
  402915:	8b 55 f8             	mov    -0x8(%ebp),%edx
  402918:	8b 45 ec             	mov    -0x14(%ebp),%eax
  40291b:	48                   	dec    %eax
  40291c:	89 d6                	mov    %edx,%esi
  40291e:	89 c7                	mov    %eax,%edi
  402920:	e8 e5 fe ff ff       	call   40280a <ioapic_write_redir>
}
  402925:	c9                   	leave  
  402926:	c3                   	ret    

00402927 <set_irq_line>:

void set_irq_line(unsigned line, int val)
{
  402927:	55                   	push   %ebp
  402928:	48                   	dec    %eax
  402929:	89 e5                	mov    %esp,%ebp
  40292b:	48                   	dec    %eax
  40292c:	83 ec 08             	sub    $0x8,%esp
  40292f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  402932:	89 75 f8             	mov    %esi,-0x8(%ebp)
	asm volatile("out %0, %1" : : "a"((u8)val), "d"((u16)(0x2000 + line)));
  402935:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402938:	8b 55 fc             	mov    -0x4(%ebp),%edx
  40293b:	66 81 c2 00 20       	add    $0x2000,%dx
  402940:	ee                   	out    %al,(%dx)
}
  402941:	c9                   	leave  
  402942:	c3                   	ret    

00402943 <enable_apic>:

void enable_apic(void)
{
  402943:	55                   	push   %ebp
  402944:	48                   	dec    %eax
  402945:	89 e5                	mov    %esp,%ebp
//    printf("enabling apic\n");
    xapic_write(0xf0, 0x1ff); /* spurious vector register */
  402947:	be ff 01 00 00       	mov    $0x1ff,%esi
  40294c:	bf f0 00 00 00       	mov    $0xf0,%edi
  402951:	e8 ca fb ff ff       	call   402520 <xapic_write>
}
  402956:	5d                   	pop    %ebp
  402957:	c3                   	ret    

00402958 <mask_pic_interrupts>:

void mask_pic_interrupts(void)
{
  402958:	55                   	push   %ebp
  402959:	48                   	dec    %eax
  40295a:	89 e5                	mov    %esp,%ebp
    outb(0xff, 0x21);
  40295c:	be 21 00 00 00       	mov    $0x21,%esi
  402961:	bf ff 00 00 00       	mov    $0xff,%edi
  402966:	e8 47 fa ff ff       	call   4023b2 <outb>
    outb(0xff, 0xa1);
  40296b:	be a1 00 00 00       	mov    $0xa1,%esi
  402970:	bf ff 00 00 00       	mov    $0xff,%edi
  402975:	e8 38 fa ff ff       	call   4023b2 <outb>
}
  40297a:	5d                   	pop    %ebp
  40297b:	c3                   	ret    

0040297c <lapicid>:

int
lapicid(void)
{
  40297c:	55                   	push   %ebp
  40297d:	48                   	dec    %eax
  40297e:	89 e5                	mov    %esp,%ebp
  if (!lapic)
  402980:	48                   	dec    %eax
  402981:	8b 05 a1 d6 04 00    	mov    0x4d6a1,%eax
  402987:	48                   	dec    %eax
  402988:	85 c0                	test   %eax,%eax
  40298a:	75 07                	jne    402993 <lapicid+0x17>
    return 0;
  40298c:	b8 00 00 00 00       	mov    $0x0,%eax
  402991:	eb 10                	jmp    4029a3 <lapicid+0x27>
  //printf("lapicid = %d\n",lapic[ID]);
  return lapic[ID] >> 24; 
  402993:	48                   	dec    %eax
  402994:	8b 05 8e d6 04 00    	mov    0x4d68e,%eax
  40299a:	48                   	dec    %eax
  40299b:	83 c0 20             	add    $0x20,%eax
  40299e:	8b 00                	mov    (%eax),%eax
  4029a0:	c1 e8 18             	shr    $0x18,%eax
}
  4029a3:	5d                   	pop    %ebp
  4029a4:	c3                   	ret    

004029a5 <inb>:

#define __iomem

#define inb inb
static inline uint8_t inb(unsigned long port)
{
  4029a5:	55                   	push   %ebp
  4029a6:	48                   	dec    %eax
  4029a7:	89 e5                	mov    %esp,%ebp
  4029a9:	48                   	dec    %eax
  4029aa:	83 ec 18             	sub    $0x18,%esp
  4029ad:	48                   	dec    %eax
  4029ae:	89 7d e8             	mov    %edi,-0x18(%ebp)
    unsigned char value;
    asm volatile("inb %w1, %0" : "=a" (value) : "Nd" ((unsigned short)port));
  4029b1:	48                   	dec    %eax
  4029b2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4029b5:	89 c2                	mov    %eax,%edx
  4029b7:	ec                   	in     (%dx),%al
  4029b8:	88 45 ff             	mov    %al,-0x1(%ebp)
    return value;
  4029bb:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
  4029bf:	c9                   	leave  
  4029c0:	c3                   	ret    

004029c1 <outb>:
    return value;
}

#define outb outb
static inline void outb(uint8_t value, unsigned long port)
{
  4029c1:	55                   	push   %ebp
  4029c2:	48                   	dec    %eax
  4029c3:	89 e5                	mov    %esp,%ebp
  4029c5:	48                   	dec    %eax
  4029c6:	83 ec 10             	sub    $0x10,%esp
  4029c9:	89 f8                	mov    %edi,%eax
  4029cb:	48                   	dec    %eax
  4029cc:	89 75 f0             	mov    %esi,-0x10(%ebp)
  4029cf:	88 45 fc             	mov    %al,-0x4(%ebp)
    asm volatile("outb %b0, %w1" : : "a"(value), "Nd"((unsigned short)port));
  4029d2:	48                   	dec    %eax
  4029d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  4029d6:	89 c2                	mov    %eax,%edx
  4029d8:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  4029dc:	ee                   	out    %al,(%dx)
}
  4029dd:	c9                   	leave  
  4029de:	c3                   	ret    

004029df <sum>:
int ncpu;
uchar ioapicid;

static uchar
sum(uchar *addr, int len)
{
  4029df:	55                   	push   %ebp
  4029e0:	48                   	dec    %eax
  4029e1:	89 e5                	mov    %esp,%ebp
  4029e3:	48                   	dec    %eax
  4029e4:	83 ec 1c             	sub    $0x1c,%esp
  4029e7:	48                   	dec    %eax
  4029e8:	89 7d e8             	mov    %edi,-0x18(%ebp)
  4029eb:	89 75 e4             	mov    %esi,-0x1c(%ebp)
  int i, sum;

  sum = 0;
  4029ee:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
  4029f5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  4029fc:	eb 1a                	jmp    402a18 <sum+0x39>
    sum += addr[i];
  4029fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  402a01:	48                   	dec    %eax
  402a02:	63 d0                	arpl   %dx,%ax
  402a04:	48                   	dec    %eax
  402a05:	8b 45 e8             	mov    -0x18(%ebp),%eax
  402a08:	48                   	dec    %eax
  402a09:	01 d0                	add    %edx,%eax
  402a0b:	0f b6 00             	movzbl (%eax),%eax
  402a0e:	0f b6 c0             	movzbl %al,%eax
  402a11:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
  402a14:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  402a18:	8b 45 fc             	mov    -0x4(%ebp),%eax
  402a1b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  402a1e:	7c de                	jl     4029fe <sum+0x1f>
    sum += addr[i];
  return sum;
  402a20:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  402a23:	c9                   	leave  
  402a24:	c3                   	ret    

00402a25 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(phys_addr_t a, int len)
{
  402a25:	55                   	push   %ebp
  402a26:	48                   	dec    %eax
  402a27:	89 e5                	mov    %esp,%ebp
  402a29:	48                   	dec    %eax
  402a2a:	83 ec 30             	sub    $0x30,%esp
  402a2d:	48                   	dec    %eax
  402a2e:	89 7d d8             	mov    %edi,-0x28(%ebp)
  402a31:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  uchar *e, *p, *addr;

//  addr = P2V(a);
  addr = (void *)((char *)(a));
  402a34:	48                   	dec    %eax
  402a35:	8b 45 d8             	mov    -0x28(%ebp),%eax
  402a38:	48                   	dec    %eax
  402a39:	89 45 f0             	mov    %eax,-0x10(%ebp)
//  printf("addr = %lx\n", a);
  e = addr+len;
  402a3c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  402a3f:	48                   	dec    %eax
  402a40:	63 d0                	arpl   %dx,%ax
  402a42:	48                   	dec    %eax
  402a43:	8b 45 f0             	mov    -0x10(%ebp),%eax
  402a46:	48                   	dec    %eax
  402a47:	01 d0                	add    %edx,%eax
  402a49:	48                   	dec    %eax
  402a4a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
  402a4d:	48                   	dec    %eax
  402a4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  402a51:	48                   	dec    %eax
  402a52:	89 45 f8             	mov    %eax,-0x8(%ebp)
  402a55:	eb 3a                	jmp    402a91 <mpsearch1+0x6c>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  402a57:	48                   	dec    %eax
  402a58:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402a5b:	ba 04 00 00 00       	mov    $0x4,%edx
  402a60:	be a0 d4 40 00       	mov    $0x40d4a0,%esi
  402a65:	48                   	dec    %eax
  402a66:	89 c7                	mov    %eax,%edi
  402a68:	e8 2c e7 ff ff       	call   401199 <memcmp>
  402a6d:	85 c0                	test   %eax,%eax
  402a6f:	75 1b                	jne    402a8c <mpsearch1+0x67>
  402a71:	48                   	dec    %eax
  402a72:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402a75:	be 10 00 00 00       	mov    $0x10,%esi
  402a7a:	48                   	dec    %eax
  402a7b:	89 c7                	mov    %eax,%edi
  402a7d:	e8 5d ff ff ff       	call   4029df <sum>
  402a82:	84 c0                	test   %al,%al
  402a84:	75 06                	jne    402a8c <mpsearch1+0x67>
      {
//        printf("_MP_\n");
        return (struct mp*)p;
  402a86:	48                   	dec    %eax
  402a87:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402a8a:	eb 14                	jmp    402aa0 <mpsearch1+0x7b>

//  addr = P2V(a);
  addr = (void *)((char *)(a));
//  printf("addr = %lx\n", a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
  402a8c:	48                   	dec    %eax
  402a8d:	83 45 f8 10          	addl   $0x10,-0x8(%ebp)
  402a91:	48                   	dec    %eax
  402a92:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402a95:	48                   	dec    %eax
  402a96:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  402a99:	72 bc                	jb     402a57 <mpsearch1+0x32>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      {
//        printf("_MP_\n");
        return (struct mp*)p;
      }
  return 0;
  402a9b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  402aa0:	c9                   	leave  
  402aa1:	c3                   	ret    

00402aa2 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
  402aa2:	55                   	push   %ebp
  402aa3:	48                   	dec    %eax
  402aa4:	89 e5                	mov    %esp,%ebp
  402aa6:	48                   	dec    %eax
  402aa7:	83 ec 20             	sub    $0x20,%esp
//  uint p;
  phys_addr_t p;
  struct mp *mp;

//  bda = (uchar *) P2V(0x400);
  bda = (uchar *) (0x400);
  402aaa:	48                   	dec    %eax
  402aab:	c7 45 f8 00 04 00 00 	movl   $0x400,-0x8(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
  402ab2:	48                   	dec    %eax
  402ab3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402ab6:	48                   	dec    %eax
  402ab7:	83 c0 0f             	add    $0xf,%eax
  402aba:	0f b6 00             	movzbl (%eax),%eax
  402abd:	0f b6 c0             	movzbl %al,%eax
  402ac0:	c1 e0 08             	shl    $0x8,%eax
  402ac3:	89 c2                	mov    %eax,%edx
  402ac5:	48                   	dec    %eax
  402ac6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402ac9:	48                   	dec    %eax
  402aca:	83 c0 0e             	add    $0xe,%eax
  402acd:	0f b6 00             	movzbl (%eax),%eax
  402ad0:	0f b6 c0             	movzbl %al,%eax
  402ad3:	09 d0                	or     %edx,%eax
  402ad5:	c1 e0 04             	shl    $0x4,%eax
  402ad8:	48                   	dec    %eax
  402ad9:	98                   	cwtl   
  402ada:	48                   	dec    %eax
  402adb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  402ade:	48                   	dec    %eax
  402adf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  402ae3:	74 34                	je     402b19 <mpsearch+0x77>
#ifdef __BARE_METAL  
//    printf("bad[0x0F] = %x\n",bda[0x0F]);
//    printf("bad[0x0E] = %x\n",bda[0x0E]);
//    printf("p = %lx\n",p);
#endif
    if((mp = mpsearch1(p, 1024)))
  402ae5:	48                   	dec    %eax
  402ae6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  402ae9:	be 00 04 00 00       	mov    $0x400,%esi
  402aee:	48                   	dec    %eax
  402aef:	89 c7                	mov    %eax,%edi
  402af1:	e8 2f ff ff ff       	call   402a25 <mpsearch1>
  402af6:	48                   	dec    %eax
  402af7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  402afa:	48                   	dec    %eax
  402afb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  402aff:	74 7b                	je     402b7c <mpsearch+0xda>
      {
        printf("MP in the first KB of the EBDA\n");
  402b01:	bf a8 d4 40 00       	mov    $0x40d4a8,%edi
  402b06:	b8 00 00 00 00       	mov    $0x0,%eax
  402b0b:	e8 4e e2 ff ff       	call   400d5e <printf>
        return mp;
  402b10:	48                   	dec    %eax
  402b11:	8b 45 e8             	mov    -0x18(%ebp),%eax
  402b14:	e9 81 00 00 00       	jmp    402b9a <mpsearch+0xf8>
      }
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
  402b19:	48                   	dec    %eax
  402b1a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402b1d:	48                   	dec    %eax
  402b1e:	83 c0 14             	add    $0x14,%eax
  402b21:	0f b6 00             	movzbl (%eax),%eax
  402b24:	0f b6 c0             	movzbl %al,%eax
  402b27:	c1 e0 08             	shl    $0x8,%eax
  402b2a:	89 c2                	mov    %eax,%edx
  402b2c:	48                   	dec    %eax
  402b2d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402b30:	48                   	dec    %eax
  402b31:	83 c0 13             	add    $0x13,%eax
  402b34:	0f b6 00             	movzbl (%eax),%eax
  402b37:	0f b6 c0             	movzbl %al,%eax
  402b3a:	09 d0                	or     %edx,%eax
  402b3c:	c1 e0 0a             	shl    $0xa,%eax
  402b3f:	48                   	dec    %eax
  402b40:	98                   	cwtl   
  402b41:	48                   	dec    %eax
  402b42:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifdef __BARE_METAL  
//    printf("bad[0x14] = %x\n",bda[0x14]);
//    printf("bad[0x13] = %x\n",bda[0x13]);
//    printf("p = %lx\n",p);
#endif
    if((mp = mpsearch1(p-1024, 1024)))
  402b45:	48                   	dec    %eax
  402b46:	8b 45 f0             	mov    -0x10(%ebp),%eax
  402b49:	48                   	dec    %eax
  402b4a:	2d 00 04 00 00       	sub    $0x400,%eax
  402b4f:	be 00 04 00 00       	mov    $0x400,%esi
  402b54:	48                   	dec    %eax
  402b55:	89 c7                	mov    %eax,%edi
  402b57:	e8 c9 fe ff ff       	call   402a25 <mpsearch1>
  402b5c:	48                   	dec    %eax
  402b5d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  402b60:	48                   	dec    %eax
  402b61:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  402b65:	74 15                	je     402b7c <mpsearch+0xda>
      {
        printf("MP in the last KB of system base memory\n");
  402b67:	bf c8 d4 40 00       	mov    $0x40d4c8,%edi
  402b6c:	b8 00 00 00 00       	mov    $0x0,%eax
  402b71:	e8 e8 e1 ff ff       	call   400d5e <printf>
        return mp;
  402b76:	48                   	dec    %eax
  402b77:	8b 45 e8             	mov    -0x18(%ebp),%eax
  402b7a:	eb 1e                	jmp    402b9a <mpsearch+0xf8>
      }
  }
  printf("MP in the BIOS ROM between 0xE0000 and 0xFFFFF\n");
  402b7c:	bf f8 d4 40 00       	mov    $0x40d4f8,%edi
  402b81:	b8 00 00 00 00       	mov    $0x0,%eax
  402b86:	e8 d3 e1 ff ff       	call   400d5e <printf>
  return mpsearch1(0xF0000, 0x10000);
  402b8b:	be 00 00 01 00       	mov    $0x10000,%esi
  402b90:	bf 00 00 0f 00       	mov    $0xf0000,%edi
  402b95:	e8 8b fe ff ff       	call   402a25 <mpsearch1>
}
  402b9a:	c9                   	leave  
  402b9b:	c3                   	ret    

00402b9c <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
  402b9c:	55                   	push   %ebp
  402b9d:	48                   	dec    %eax
  402b9e:	89 e5                	mov    %esp,%ebp
  402ba0:	48                   	dec    %eax
  402ba1:	83 ec 20             	sub    $0x20,%esp
  402ba4:	48                   	dec    %eax
  402ba5:	89 7d e8             	mov    %edi,-0x18(%ebp)
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  402ba8:	e8 f5 fe ff ff       	call   402aa2 <mpsearch>
  402bad:	48                   	dec    %eax
  402bae:	89 45 f8             	mov    %eax,-0x8(%ebp)
  402bb1:	48                   	dec    %eax
  402bb2:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  402bb6:	74 0b                	je     402bc3 <mpconfig+0x27>
  402bb8:	48                   	dec    %eax
  402bb9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402bbc:	8b 40 04             	mov    0x4(%eax),%eax
  402bbf:	85 c0                	test   %eax,%eax
  402bc1:	75 0a                	jne    402bcd <mpconfig+0x31>
    return 0;
  402bc3:	b8 00 00 00 00       	mov    $0x0,%eax
  402bc8:	e9 80 00 00 00       	jmp    402c4d <mpconfig+0xb1>
//  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  conf = (struct mpconf*) ((uint64_t) mp->physaddr);
  402bcd:	48                   	dec    %eax
  402bce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402bd1:	8b 40 04             	mov    0x4(%eax),%eax
  402bd4:	89 c0                	mov    %eax,%eax
  402bd6:	48                   	dec    %eax
  402bd7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
  402bda:	48                   	dec    %eax
  402bdb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  402bde:	ba 04 00 00 00       	mov    $0x4,%edx
  402be3:	be 28 d5 40 00       	mov    $0x40d528,%esi
  402be8:	48                   	dec    %eax
  402be9:	89 c7                	mov    %eax,%edi
  402beb:	e8 a9 e5 ff ff       	call   401199 <memcmp>
  402bf0:	85 c0                	test   %eax,%eax
  402bf2:	74 07                	je     402bfb <mpconfig+0x5f>
    return 0;
  402bf4:	b8 00 00 00 00       	mov    $0x0,%eax
  402bf9:	eb 52                	jmp    402c4d <mpconfig+0xb1>
  if(conf->version != 1 && conf->version != 4)
  402bfb:	48                   	dec    %eax
  402bfc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  402bff:	0f b6 40 06          	movzbl 0x6(%eax),%eax
  402c03:	3c 01                	cmp    $0x1,%al
  402c05:	74 13                	je     402c1a <mpconfig+0x7e>
  402c07:	48                   	dec    %eax
  402c08:	8b 45 f0             	mov    -0x10(%ebp),%eax
  402c0b:	0f b6 40 06          	movzbl 0x6(%eax),%eax
  402c0f:	3c 04                	cmp    $0x4,%al
  402c11:	74 07                	je     402c1a <mpconfig+0x7e>
    return 0;
  402c13:	b8 00 00 00 00       	mov    $0x0,%eax
  402c18:	eb 33                	jmp    402c4d <mpconfig+0xb1>
  if(sum((uchar*)conf, conf->length) != 0)
  402c1a:	48                   	dec    %eax
  402c1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  402c1e:	0f b7 40 04          	movzwl 0x4(%eax),%eax
  402c22:	0f b7 d0             	movzwl %ax,%edx
  402c25:	48                   	dec    %eax
  402c26:	8b 45 f0             	mov    -0x10(%ebp),%eax
  402c29:	89 d6                	mov    %edx,%esi
  402c2b:	48                   	dec    %eax
  402c2c:	89 c7                	mov    %eax,%edi
  402c2e:	e8 ac fd ff ff       	call   4029df <sum>
  402c33:	84 c0                	test   %al,%al
  402c35:	74 07                	je     402c3e <mpconfig+0xa2>
    return 0;
  402c37:	b8 00 00 00 00       	mov    $0x0,%eax
  402c3c:	eb 0f                	jmp    402c4d <mpconfig+0xb1>
  *pmp = mp;
  402c3e:	48                   	dec    %eax
  402c3f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  402c42:	48                   	dec    %eax
  402c43:	8b 55 f8             	mov    -0x8(%ebp),%edx
  402c46:	48                   	dec    %eax
  402c47:	89 10                	mov    %edx,(%eax)
  return conf;
  402c49:	48                   	dec    %eax
  402c4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  402c4d:	c9                   	leave  
  402c4e:	c3                   	ret    

00402c4f <mpinit>:

void
mpinit(void)
{
  402c4f:	55                   	push   %ebp
  402c50:	48                   	dec    %eax
  402c51:	89 e5                	mov    %esp,%ebp
  402c53:	48                   	dec    %eax
  402c54:	83 ec 40             	sub    $0x40,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
  402c57:	48                   	dec    %eax
  402c58:	8d 45 c8             	lea    -0x38(%ebp),%eax
  402c5b:	48                   	dec    %eax
  402c5c:	89 c7                	mov    %eax,%edi
  402c5e:	e8 39 ff ff ff       	call   402b9c <mpconfig>
  402c63:	48                   	dec    %eax
  402c64:	89 45 e8             	mov    %eax,-0x18(%ebp)
  402c67:	48                   	dec    %eax
  402c68:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  402c6c:	75 0f                	jne    402c7d <mpinit+0x2e>
    //panic("Expect to run on an SMP");
    printf("Expect to run on an SMP");
  402c6e:	bf 2d d5 40 00       	mov    $0x40d52d,%edi
  402c73:	b8 00 00 00 00       	mov    $0x0,%eax
  402c78:	e8 e1 e0 ff ff       	call   400d5e <printf>
  ismp = 1;
  402c7d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  lapic = (uint*)((uint64_t)(conf->lapicaddr));
  402c84:	48                   	dec    %eax
  402c85:	8b 45 e8             	mov    -0x18(%ebp),%eax
  402c88:	8b 40 24             	mov    0x24(%eax),%eax
  402c8b:	89 c0                	mov    %eax,%eax
  402c8d:	48                   	dec    %eax
  402c8e:	89 05 94 d3 04 00    	mov    %eax,0x4d394

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  402c94:	48                   	dec    %eax
  402c95:	8b 45 e8             	mov    -0x18(%ebp),%eax
  402c98:	48                   	dec    %eax
  402c99:	83 c0 2c             	add    $0x2c,%eax
  402c9c:	48                   	dec    %eax
  402c9d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  402ca0:	48                   	dec    %eax
  402ca1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  402ca4:	0f b7 40 04          	movzwl 0x4(%eax),%eax
  402ca8:	0f b7 d0             	movzwl %ax,%edx
  402cab:	48                   	dec    %eax
  402cac:	8b 45 e8             	mov    -0x18(%ebp),%eax
  402caf:	48                   	dec    %eax
  402cb0:	01 d0                	add    %edx,%eax
  402cb2:	48                   	dec    %eax
  402cb3:	89 45 e0             	mov    %eax,-0x20(%ebp)
  402cb6:	e9 91 00 00 00       	jmp    402d4c <mpinit+0xfd>
    switch(*p){
  402cbb:	48                   	dec    %eax
  402cbc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402cbf:	0f b6 00             	movzbl (%eax),%eax
  402cc2:	0f b6 c0             	movzbl %al,%eax
  402cc5:	83 f8 04             	cmp    $0x4,%eax
  402cc8:	77 7a                	ja     402d44 <mpinit+0xf5>
  402cca:	89 c0                	mov    %eax,%eax
  402ccc:	48                   	dec    %eax
  402ccd:	8b 04 c5 68 d5 40 00 	mov    0x40d568(,%eax,8),%eax
  402cd4:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
  402cd6:	48                   	dec    %eax
  402cd7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402cda:	48                   	dec    %eax
  402cdb:	89 45 d8             	mov    %eax,-0x28(%ebp)
      if(ncpu < NCPU) {
  402cde:	8b 05 7c 0d 05 00    	mov    0x50d7c,%eax
  402ce4:	83 f8 3f             	cmp    $0x3f,%eax
  402ce7:	7f 30                	jg     402d19 <mpinit+0xca>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
  402ce9:	8b 15 71 0d 05 00    	mov    0x50d71,%edx
  402cef:	48                   	dec    %eax
  402cf0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  402cf3:	0f b6 40 01          	movzbl 0x1(%eax),%eax
  402cf7:	48                   	dec    %eax
  402cf8:	63 d2                	arpl   %dx,%dx
  402cfa:	48                   	dec    %eax
  402cfb:	69 d2 e8 00 00 00    	imul   $0xe8,%edx,%edx
  402d01:	48                   	dec    %eax
  402d02:	81 c2 60 00 45 00    	add    $0x450060,%edx
  402d08:	88 02                	mov    %al,(%edx)
        ncpu++;
  402d0a:	8b 05 50 0d 05 00    	mov    0x50d50,%eax
  402d10:	83 c0 01             	add    $0x1,%eax
  402d13:	89 05 47 0d 05 00    	mov    %eax,0x50d47
      }
      p += sizeof(struct mpproc);
  402d19:	48                   	dec    %eax
  402d1a:	83 45 f8 14          	addl   $0x14,-0x8(%ebp)
      continue;
  402d1e:	eb 2c                	jmp    402d4c <mpinit+0xfd>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
  402d20:	48                   	dec    %eax
  402d21:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402d24:	48                   	dec    %eax
  402d25:	89 45 d0             	mov    %eax,-0x30(%ebp)
      ioapicid = ioapic->apicno;
  402d28:	48                   	dec    %eax
  402d29:	8b 45 d0             	mov    -0x30(%ebp),%eax
  402d2c:	0f b6 40 01          	movzbl 0x1(%eax),%eax
  402d30:	88 05 0a d3 04 00    	mov    %al,0x4d30a
      p += sizeof(struct mpioapic);
  402d36:	48                   	dec    %eax
  402d37:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
      continue;
  402d3b:	eb 0f                	jmp    402d4c <mpinit+0xfd>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
  402d3d:	48                   	dec    %eax
  402d3e:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
      continue;
  402d42:	eb 08                	jmp    402d4c <mpinit+0xfd>
    default:
      ismp = 0;
  402d44:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      break;
  402d4b:	90                   	nop
    //panic("Expect to run on an SMP");
    printf("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)((uint64_t)(conf->lapicaddr));

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  402d4c:	48                   	dec    %eax
  402d4d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402d50:	48                   	dec    %eax
  402d51:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  402d54:	0f 82 61 ff ff ff    	jb     402cbb <mpinit+0x6c>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
  402d5a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  402d5e:	75 0f                	jne    402d6f <mpinit+0x120>
    //panic("Didn't find a suitable machine");
    printf("Didn't find a suitable machine");
  402d60:	bf 48 d5 40 00       	mov    $0x40d548,%edi
  402d65:	b8 00 00 00 00       	mov    $0x0,%eax
  402d6a:	e8 ef df ff ff       	call   400d5e <printf>

  if(mp->imcrp){
  402d6f:	48                   	dec    %eax
  402d70:	8b 45 c8             	mov    -0x38(%ebp),%eax
  402d73:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
  402d77:	84 c0                	test   %al,%al
  402d79:	74 2b                	je     402da6 <mpinit+0x157>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    //outb(0x22, 0x70);   // Select IMCR
    outb(0x70, 0x22);   // Select IMCR
  402d7b:	be 22 00 00 00       	mov    $0x22,%esi
  402d80:	bf 70 00 00 00       	mov    $0x70,%edi
  402d85:	e8 37 fc ff ff       	call   4029c1 <outb>
    //outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
    outb(inb(0x23) | 1, 0x23);  // Mask external interrupts.
  402d8a:	bf 23 00 00 00       	mov    $0x23,%edi
  402d8f:	e8 11 fc ff ff       	call   4029a5 <inb>
  402d94:	83 c8 01             	or     $0x1,%eax
  402d97:	0f b6 c0             	movzbl %al,%eax
  402d9a:	be 23 00 00 00       	mov    $0x23,%esi
  402d9f:	89 c7                	mov    %eax,%edi
  402da1:	e8 1b fc ff ff       	call   4029c1 <outb>
  }

}
  402da6:	c9                   	leave  
  402da7:	c3                   	ret    

00402da8 <readeflags>:
    asm volatile ("sti");
}

static inline uint64_t
readeflags(void)
{
  402da8:	55                   	push   %ebp
  402da9:	48                   	dec    %eax
  402daa:	89 e5                	mov    %esp,%ebp
  402dac:	48                   	dec    %eax
  402dad:	83 ec 10             	sub    $0x10,%esp
  uint64_t eflags;
  asm volatile("pushf; pop %0" : "=r" (eflags));
  402db0:	9c                   	pushf  
  402db1:	58                   	pop    %eax
  402db2:	48                   	dec    %eax
  402db3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  return eflags;
  402db6:	48                   	dec    %eax
  402db7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  402dba:	c9                   	leave  
  402dbb:	c3                   	ret    

00402dbc <mycpu>:
#include "proc.h"

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu* mycpu(void)
{
  402dbc:	55                   	push   %ebp
  402dbd:	48                   	dec    %eax
  402dbe:	89 e5                	mov    %esp,%ebp
  402dc0:	48                   	dec    %eax
  402dc1:	83 ec 10             	sub    $0x10,%esp
  int apicid, i;
  
  if(readeflags()&FL_IF)
  402dc4:	e8 df ff ff ff       	call   402da8 <readeflags>
  402dc9:	25 00 02 00 00       	and    $0x200,%eax
  402dce:	48                   	dec    %eax
  402dcf:	85 c0                	test   %eax,%eax
  402dd1:	74 0f                	je     402de2 <mycpu+0x26>
    printf("mycpu called with interrupts enabled\n");
  402dd3:	bf 90 d5 40 00       	mov    $0x40d590,%edi
  402dd8:	b8 00 00 00 00       	mov    $0x0,%eax
  402ddd:	e8 7c df ff ff       	call   400d5e <printf>
  
  apicid = lapicid();
  402de2:	e8 95 fb ff ff       	call   40297c <lapicid>
  402de7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  //apicid = apic_id();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
  402dea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  402df1:	eb 35                	jmp    402e28 <mycpu+0x6c>
    if (cpus[i].apicid == apicid)
  402df3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  402df6:	48                   	dec    %eax
  402df7:	98                   	cwtl   
  402df8:	48                   	dec    %eax
  402df9:	69 c0 e8 00 00 00    	imul   $0xe8,%eax,%eax
  402dff:	48                   	dec    %eax
  402e00:	05 60 00 45 00       	add    $0x450060,%eax
  402e05:	0f b6 00             	movzbl (%eax),%eax
  402e08:	0f b6 c0             	movzbl %al,%eax
  402e0b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  402e0e:	75 14                	jne    402e24 <mycpu+0x68>
      return &cpus[i];
  402e10:	8b 45 fc             	mov    -0x4(%ebp),%eax
  402e13:	48                   	dec    %eax
  402e14:	98                   	cwtl   
  402e15:	48                   	dec    %eax
  402e16:	69 c0 e8 00 00 00    	imul   $0xe8,%eax,%eax
  402e1c:	48                   	dec    %eax
  402e1d:	05 60 00 45 00       	add    $0x450060,%eax
  402e22:	eb 1e                	jmp    402e42 <mycpu+0x86>
  
  apicid = lapicid();
  //apicid = apic_id();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
  402e24:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  402e28:	8b 05 32 0c 05 00    	mov    0x50c32,%eax
  402e2e:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  402e31:	7c c0                	jl     402df3 <mycpu+0x37>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  printf("unknown apicid\n");
  402e33:	bf b6 d5 40 00       	mov    $0x40d5b6,%edi
  402e38:	b8 00 00 00 00       	mov    $0x0,%eax
  402e3d:	e8 1c df ff ff       	call   400d5e <printf>
}
  402e42:	c9                   	leave  
  402e43:	c3                   	ret    

00402e44 <get_memory_map>:

/*
    Get the memory map of the machine provided by the BIOS.
*/
void get_memory_map(struct mbi_bootinfo *glb_mboot_ptr)
{
  402e44:	55                   	push   %ebp
  402e45:	48                   	dec    %eax
  402e46:	89 e5                	mov    %esp,%ebp
  402e48:	48                   	dec    %eax
  402e49:	83 ec 18             	sub    $0x18,%esp
  402e4c:	48                   	dec    %eax
  402e4d:	89 7d e8             	mov    %edi,-0x18(%ebp)
    uint32_t mmap_addr = glb_mboot_ptr->mmap_addr;
  402e50:	48                   	dec    %eax
  402e51:	8b 45 e8             	mov    -0x18(%ebp),%eax
  402e54:	8b 40 30             	mov    0x30(%eax),%eax
  402e57:	89 45 f4             	mov    %eax,-0xc(%ebp)
    uint32_t mmap_length = glb_mboot_ptr->mmap_length;
  402e5a:	48                   	dec    %eax
  402e5b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  402e5e:	8b 40 2c             	mov    0x2c(%eax),%eax
  402e61:	89 45 f0             	mov    %eax,-0x10(%ebp)
 
    mmap_entry_t *mmap = (mmap_entry_t *)(uint64_t) mmap_addr;
  402e64:	8b 45 f4             	mov    -0xc(%ebp),%eax
  402e67:	48                   	dec    %eax
  402e68:	89 45 f8             	mov    %eax,-0x8(%ebp)

    heap_end = 0;    
  402e6b:	48                   	dec    %eax
  402e6c:	c7 05 f2 0b 05 00 00 	movl   $0x0,0x50bf2
  402e73:	00 00 00 

    for ( ; (uint64_t)mmap < mmap_addr + mmap_length; mmap++)
  402e76:	eb 1e                	jmp    402e96 <get_memory_map+0x52>
    {
        heap_end = heap_end + mmap->length;
  402e78:	48                   	dec    %eax
  402e79:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402e7c:	48                   	dec    %eax
  402e7d:	8b 50 0c             	mov    0xc(%eax),%edx
  402e80:	48                   	dec    %eax
  402e81:	8b 05 e1 0b 05 00    	mov    0x50be1,%eax
  402e87:	48                   	dec    %eax
  402e88:	01 d0                	add    %edx,%eax
  402e8a:	48                   	dec    %eax
  402e8b:	89 05 d7 0b 05 00    	mov    %eax,0x50bd7
 
    mmap_entry_t *mmap = (mmap_entry_t *)(uint64_t) mmap_addr;

    heap_end = 0;    

    for ( ; (uint64_t)mmap < mmap_addr + mmap_length; mmap++)
  402e91:	48                   	dec    %eax
  402e92:	83 45 f8 18          	addl   $0x18,-0x8(%ebp)
  402e96:	48                   	dec    %eax
  402e97:	8b 55 f8             	mov    -0x8(%ebp),%edx
  402e9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  402e9d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  402ea0:	01 c8                	add    %ecx,%eax
  402ea2:	89 c0                	mov    %eax,%eax
  402ea4:	48                   	dec    %eax
  402ea5:	39 c2                	cmp    %eax,%edx
  402ea7:	72 cf                	jb     402e78 <get_memory_map+0x34>
    {
        heap_end = heap_end + mmap->length;
//        printf("%x\n",(uint64_t) mmap->length);
    }
}
  402ea9:	c9                   	leave  
  402eaa:	c3                   	ret    

00402eab <get_free_pages>:

/*
* Place the pages after _HEAP_START on free list.
*/
void *get_free_pages(void *mem, unsigned long size)
{
  402eab:	55                   	push   %ebp
  402eac:	48                   	dec    %eax
  402ead:	89 e5                	mov    %esp,%ebp
  402eaf:	48                   	dec    %eax
  402eb0:	83 ec 20             	sub    $0x20,%esp
  402eb3:	48                   	dec    %eax
  402eb4:	89 7d e8             	mov    %edi,-0x18(%ebp)
  402eb7:	48                   	dec    %eax
  402eb8:	89 75 e0             	mov    %esi,-0x20(%ebp)
    
    void *old_freelist;
    void *end;

    if(size == 0) {
  402ebb:	48                   	dec    %eax
  402ebc:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  402ec0:	75 07                	jne    402ec9 <get_free_pages+0x1e>
    
        return 0;  
  402ec2:	b8 00 00 00 00       	mov    $0x0,%eax
  402ec7:	eb 63                	jmp    402f2c <get_free_pages+0x81>
    }   

    old_freelist = freelist;
  402ec9:	48                   	dec    %eax
  402eca:	8b 05 50 d1 04 00    	mov    0x4d150,%eax
  402ed0:	48                   	dec    %eax
  402ed1:	89 45 f8             	mov    %eax,-0x8(%ebp)
    freelist = mem;
  402ed4:	48                   	dec    %eax
  402ed5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  402ed8:	48                   	dec    %eax
  402ed9:	89 05 41 d1 04 00    	mov    %eax,0x4d141
    end = mem + size;
  402edf:	48                   	dec    %eax
  402ee0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  402ee3:	48                   	dec    %eax
  402ee4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  402ee7:	48                   	dec    %eax
  402ee8:	01 d0                	add    %edx,%eax
  402eea:	48                   	dec    %eax
  402eeb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    while (mem + PAGE_SIZE != end) {
  402eee:	eb 1a                	jmp    402f0a <get_free_pages+0x5f>
        *(void **)mem = (mem + PAGE_SIZE);
  402ef0:	48                   	dec    %eax
  402ef1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  402ef4:	48                   	dec    %eax
  402ef5:	8d 90 00 10 00 00    	lea    0x1000(%eax),%edx
  402efb:	48                   	dec    %eax
  402efc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  402eff:	48                   	dec    %eax
  402f00:	89 10                	mov    %edx,(%eax)
        mem += PAGE_SIZE;
  402f02:	48                   	dec    %eax
  402f03:	81 45 e8 00 10 00 00 	addl   $0x1000,-0x18(%ebp)

    old_freelist = freelist;
    freelist = mem;
    end = mem + size;
    
    while (mem + PAGE_SIZE != end) {
  402f0a:	48                   	dec    %eax
  402f0b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  402f0e:	48                   	dec    %eax
  402f0f:	05 00 10 00 00       	add    $0x1000,%eax
  402f14:	48                   	dec    %eax
  402f15:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  402f18:	75 d6                	jne    402ef0 <get_free_pages+0x45>
        *(void **)mem = (mem + PAGE_SIZE);
        mem += PAGE_SIZE;
    }   

    *(void **)mem = old_freelist;
  402f1a:	48                   	dec    %eax
  402f1b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  402f1e:	48                   	dec    %eax
  402f1f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  402f22:	48                   	dec    %eax
  402f23:	89 10                	mov    %edx,(%eax)
 
    return freelist;
  402f25:	48                   	dec    %eax
  402f26:	8b 05 f4 d0 04 00    	mov    0x4d0f4,%eax
}
  402f2c:	c9                   	leave  
  402f2d:	c3                   	ret    

00402f2e <early_mem_init>:

/*
    
*/
void early_mem_init(uintptr_t base_addr, struct mbi_bootinfo *bootinfo)
{
  402f2e:	55                   	push   %ebp
  402f2f:	48                   	dec    %eax
  402f30:	89 e5                	mov    %esp,%ebp
  402f32:	48                   	dec    %eax
  402f33:	83 ec 10             	sub    $0x10,%esp
  402f36:	48                   	dec    %eax
  402f37:	89 7d f8             	mov    %edi,-0x8(%ebp)
  402f3a:	48                   	dec    %eax
  402f3b:	89 75 f0             	mov    %esi,-0x10(%ebp)
//    u64 end_of_memory = bootinfo->mem_upper * 1024ull;
//    printf("mbi->mmap_addr = %x\n", bootinfo->mmap_addr);
//    printf("mbi->mmap_length = %x\n", bootinfo->mmap_length);
    get_memory_map(bootinfo);
  402f3e:	48                   	dec    %eax
  402f3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  402f42:	48                   	dec    %eax
  402f43:	89 c7                	mov    %eax,%edi
  402f45:	e8 fa fe ff ff       	call   402e44 <get_memory_map>
    
    heap_base = (base_addr + PAGE_SIZE - 1) & (-PAGE_SIZE);
  402f4a:	48                   	dec    %eax
  402f4b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  402f4e:	48                   	dec    %eax
  402f4f:	05 ff 0f 00 00       	add    $0xfff,%eax
  402f54:	48                   	dec    %eax
  402f55:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  402f5a:	48                   	dec    %eax
  402f5b:	89 05 0f 0b 05 00    	mov    %eax,0x50b0f
    heap_end = heap_end & (-PAGE_SIZE);
  402f61:	48                   	dec    %eax
  402f62:	8b 05 00 0b 05 00    	mov    0x50b00,%eax
  402f68:	48                   	dec    %eax
  402f69:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  402f6e:	48                   	dec    %eax
  402f6f:	89 05 f3 0a 05 00    	mov    %eax,0x50af3

    printf("Memory Start: %x B\n", heap_base);
  402f75:	48                   	dec    %eax
  402f76:	8b 05 f4 0a 05 00    	mov    0x50af4,%eax
  402f7c:	48                   	dec    %eax
  402f7d:	89 c6                	mov    %eax,%esi
  402f7f:	bf c6 d5 40 00       	mov    $0x40d5c6,%edi
  402f84:	b8 00 00 00 00       	mov    $0x0,%eax
  402f89:	e8 d0 dd ff ff       	call   400d5e <printf>
    printf("Memory End: %x B\n", heap_end);
  402f8e:	48                   	dec    %eax
  402f8f:	8b 05 d3 0a 05 00    	mov    0x50ad3,%eax
  402f95:	48                   	dec    %eax
  402f96:	89 c6                	mov    %eax,%esi
  402f98:	bf da d5 40 00       	mov    $0x40d5da,%edi
  402f9d:	b8 00 00 00 00       	mov    $0x0,%eax
  402fa2:	e8 b7 dd ff ff       	call   400d5e <printf>
    printf("Total Memory: %d MB\n", heap_end >> 20);
  402fa7:	48                   	dec    %eax
  402fa8:	8b 05 ba 0a 05 00    	mov    0x50aba,%eax
  402fae:	48                   	dec    %eax
  402faf:	c1 e8 14             	shr    $0x14,%eax
  402fb2:	48                   	dec    %eax
  402fb3:	89 c6                	mov    %eax,%esi
  402fb5:	bf ec d5 40 00       	mov    $0x40d5ec,%edi
  402fba:	b8 00 00 00 00       	mov    $0x0,%eax
  402fbf:	e8 9a dd ff ff       	call   400d5e <printf>

    freelist = 0;
  402fc4:	48                   	dec    %eax
  402fc5:	c7 05 51 d0 04 00 00 	movl   $0x0,0x4d051
  402fcc:	00 00 00 
    if(freelist == 0){
  402fcf:	48                   	dec    %eax
  402fd0:	8b 05 4a d0 04 00    	mov    0x4d04a,%eax
  402fd6:	48                   	dec    %eax
  402fd7:	85 c0                	test   %eax,%eax
  402fd9:	75 14                	jne    402fef <early_mem_init+0xc1>
//        get_free_pages((void *)heap_base, heap_end - heap_base);
        get_free_pages((void *)heap_base, 2048 * 1024 * 1024ul);
  402fdb:	48                   	dec    %eax
  402fdc:	8b 05 8e 0a 05 00    	mov    0x50a8e,%eax
  402fe2:	be 00 00 00 80       	mov    $0x80000000,%esi
  402fe7:	48                   	dec    %eax
  402fe8:	89 c7                	mov    %eax,%edi
  402fea:	e8 bc fe ff ff       	call   402eab <get_free_pages>
    }    

}
  402fef:	c9                   	leave  
  402ff0:	c3                   	ret    

00402ff1 <heap_alloc_page>:
 Allocate one 4096-byte page of physical memory.
 Returns a pointer that the kernel can use.
 Returns 0 if the memory cannot be allocated.
*/
void *heap_alloc_page(void)
{
  402ff1:	55                   	push   %ebp
  402ff2:	48                   	dec    %eax
  402ff3:	89 e5                	mov    %esp,%ebp
  402ff5:	48                   	dec    %eax
  402ff6:	83 ec 10             	sub    $0x10,%esp
    void *page;
    //fprintf(OUTPUT, "%p ", freelist);
    if (!freelist) {
  402ff9:	48                   	dec    %eax
  402ffa:	8b 05 20 d0 04 00    	mov    0x4d020,%eax
  403000:	48                   	dec    %eax
  403001:	85 c0                	test   %eax,%eax
  403003:	75 16                	jne    40301b <heap_alloc_page+0x2a>
        printf("freelist uninitialized!\n");
  403005:	bf 01 d6 40 00       	mov    $0x40d601,%edi
  40300a:	b8 00 00 00 00       	mov    $0x0,%eax
  40300f:	e8 4a dd ff ff       	call   400d5e <printf>
        return 0;
  403014:	b8 00 00 00 00       	mov    $0x0,%eax
  403019:	eb 31                	jmp    40304c <heap_alloc_page+0x5b>
    }   
    
    page = freelist;
  40301b:	48                   	dec    %eax
  40301c:	8b 05 fe cf 04 00    	mov    0x4cffe,%eax
  403022:	48                   	dec    %eax
  403023:	89 45 f8             	mov    %eax,-0x8(%ebp)
    freelist = *(void **)freelist;
  403026:	48                   	dec    %eax
  403027:	8b 05 f3 cf 04 00    	mov    0x4cff3,%eax
  40302d:	48                   	dec    %eax
  40302e:	8b 00                	mov    (%eax),%eax
  403030:	48                   	dec    %eax
  403031:	89 05 e9 cf 04 00    	mov    %eax,0x4cfe9

    __fast_zero_page(page);
  403037:	48                   	dec    %eax
  403038:	8b 45 f8             	mov    -0x8(%ebp),%eax
  40303b:	48                   	dec    %eax
  40303c:	89 c7                	mov    %eax,%edi
  40303e:	b8 00 00 00 00       	mov    $0x0,%eax
  403043:	e8 06 00 00 00       	call   40304e <__fast_zero_page>
    return page;
  403048:	48                   	dec    %eax
  403049:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  40304c:	c9                   	leave  
  40304d:	c3                   	ret    

0040304e <__fast_zero_page>:
  40304e:	31 c0                	xor    %eax,%eax
  403050:	b9 00 02 00 00       	mov    $0x200,%ecx
  403055:	fc                   	cld    
  403056:	f3 48                	repz dec %eax
  403058:	ab                   	stos   %eax,%es:(%edi)
  403059:	c3                   	ret    

0040305a <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
  40305a:	55                   	push   %ebp
  40305b:	48                   	dec    %eax
  40305c:	89 e5                	mov    %esp,%ebp
  40305e:	48                   	dec    %eax
  40305f:	83 ec 1c             	sub    $0x1c,%esp
  403062:	48                   	dec    %eax
  403063:	89 7d e8             	mov    %edi,-0x18(%ebp)
  403066:	89 75 e4             	mov    %esi,-0x1c(%ebp)
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  403069:	48                   	dec    %eax
  40306a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  40306d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  403070:	48                   	dec    %eax
  403071:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  403074:	f0 87 02             	lock xchg %eax,(%edx)
  403077:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
  40307a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  40307d:	c9                   	leave  
  40307e:	c3                   	ret    

0040307f <main>:
//static void mpmain(void)  __attribute__((noreturn));
static void list_apicid(void);

// Bootstrap processor starts running C code here.
int main(void *mb_info, int magic)
{
  40307f:	55                   	push   %ebp
  403080:	48                   	dec    %eax
  403081:	89 e5                	mov    %esp,%ebp
  403083:	48                   	dec    %eax
  403084:	83 ec 10             	sub    $0x10,%esp
  403087:	48                   	dec    %eax
  403088:	89 7d f8             	mov    %edi,-0x8(%ebp)
  40308b:	89 75 f4             	mov    %esi,-0xc(%ebp)
    printf("magic = %x, mb_info = %p\n", magic, mb_info);
  40308e:	48                   	dec    %eax
  40308f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  403092:	8b 45 f4             	mov    -0xc(%ebp),%eax
  403095:	89 c6                	mov    %eax,%esi
  403097:	bf 20 d6 40 00       	mov    $0x40d620,%edi
  40309c:	b8 00 00 00 00       	mov    $0x0,%eax
  4030a1:	e8 b8 dc ff ff       	call   400d5e <printf>
    early_mem_init((uintptr_t)&_HEAP_START, mb_info);
  4030a6:	b8 00 40 45 00       	mov    $0x454000,%eax
  4030ab:	48                   	dec    %eax
  4030ac:	8b 55 f8             	mov    -0x8(%ebp),%edx
  4030af:	48                   	dec    %eax
  4030b0:	89 d6                	mov    %edx,%esi
  4030b2:	48                   	dec    %eax
  4030b3:	89 c7                	mov    %eax,%edi
  4030b5:	b8 00 00 00 00       	mov    $0x0,%eax
  4030ba:	e8 6f fe ff ff       	call   402f2e <early_mem_init>
    mask_pic_interrupts(); //close interrupt
  4030bf:	e8 94 f8 ff ff       	call   402958 <mask_pic_interrupts>
    enable_apic();   // enable local apic
  4030c4:	e8 7a f8 ff ff       	call   402943 <enable_apic>
    mpinit();        // detect other processors
  4030c9:	e8 81 fb ff ff       	call   402c4f <mpinit>
    list_apicid();   // list all apic id
  4030ce:	e8 c0 00 00 00       	call   403193 <list_apicid>
    startothers();
  4030d3:	e8 43 00 00 00       	call   40311b <startothers>
    printf("sizeof(void *) = %d\n", (int)sizeof(void *));
  4030d8:	be 08 00 00 00       	mov    $0x8,%esi
  4030dd:	bf 3a d6 40 00       	mov    $0x40d63a,%edi
  4030e2:	b8 00 00 00 00       	mov    $0x0,%eax
  4030e7:	e8 72 dc ff ff       	call   400d5e <printf>
    while(1);        //hold the console, or it will restart infinitely
  4030ec:	eb fe                	jmp    4030ec <main+0x6d>

004030ee <mpenter>:


// Other CPUs jump here from entryother.S.
//static void mpenter(void)
void mpenter(void)
{
  4030ee:	55                   	push   %ebp
  4030ef:	48                   	dec    %eax
  4030f0:	89 e5                	mov    %esp,%ebp
  //switchkvm();
  //seginit();
  //lapicinit();
  //mpmain();
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
  4030f2:	e8 c5 fc ff ff       	call   402dbc <mycpu>
  4030f7:	48                   	dec    %eax
  4030f8:	05 d0 00 00 00       	add    $0xd0,%eax
  4030fd:	be 01 00 00 00       	mov    $0x1,%esi
  403102:	48                   	dec    %eax
  403103:	89 c7                	mov    %eax,%edi
  403105:	e8 50 ff ff ff       	call   40305a <xchg>
  printf("AP ");
  40310a:	bf 4f d6 40 00       	mov    $0x40d64f,%edi
  40310f:	b8 00 00 00 00       	mov    $0x0,%eax
  403114:	e8 45 dc ff ff       	call   400d5e <printf>
}
  403119:	5d                   	pop    %ebp
  40311a:	c3                   	ret    

0040311b <startothers>:


// Start the non-boot (AP) processors.
static void startothers(void)
{
  40311b:	55                   	push   %ebp
  40311c:	48                   	dec    %eax
  40311d:	89 e5                	mov    %esp,%ebp
  40311f:	48                   	dec    %eax
  403120:	83 ec 10             	sub    $0x10,%esp
/*
    The BSP should place the BIOS AP initialization code at 000VV000H, 
    where VV is the vector contained in the SIPI message. 
    Write entry code to unused memory at 0x0000.
*/
    sipi_entry_mov();
  403123:	b8 00 00 00 00       	mov    $0x0,%eax
  403128:	e8 62 d0 ff ff       	call   40018f <sipi_entry_mov>

    for(c = cpus; c < cpus+ncpu; c++){
  40312d:	48                   	dec    %eax
  40312e:	c7 45 f8 60 00 45 00 	movl   $0x450060,-0x8(%ebp)
  403135:	eb 3f                	jmp    403176 <startothers+0x5b>
      if(c == mycpu())  // We've started already.
  403137:	e8 80 fc ff ff       	call   402dbc <mycpu>
  40313c:	48                   	dec    %eax
  40313d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  403140:	75 02                	jne    403144 <startothers+0x29>
          continue;
  403142:	eb 2a                	jmp    40316e <startothers+0x53>
   
          lapicstartap(c->apicid, (void *)0x00);
  403144:	48                   	dec    %eax
  403145:	8b 45 f8             	mov    -0x8(%ebp),%eax
  403148:	0f b6 00             	movzbl (%eax),%eax
  40314b:	0f b6 c0             	movzbl %al,%eax
  40314e:	be 00 00 00 00       	mov    $0x0,%esi
  403153:	89 c7                	mov    %eax,%edi
  403155:	b8 00 00 00 00       	mov    $0x0,%eax
  40315a:	e8 b4 f2 ff ff       	call   402413 <lapicstartap>
          // wait for cpu to finish mpmain()
          while(c->started == 0);
  40315f:	90                   	nop
  403160:	48                   	dec    %eax
  403161:	8b 45 f8             	mov    -0x8(%ebp),%eax
  403164:	8b 80 d0 00 00 00    	mov    0xd0(%eax),%eax
  40316a:	85 c0                	test   %eax,%eax
  40316c:	74 f2                	je     403160 <startothers+0x45>
    where VV is the vector contained in the SIPI message. 
    Write entry code to unused memory at 0x0000.
*/
    sipi_entry_mov();

    for(c = cpus; c < cpus+ncpu; c++){
  40316e:	48                   	dec    %eax
  40316f:	81 45 f8 e8 00 00 00 	addl   $0xe8,-0x8(%ebp)
  403176:	8b 05 e4 08 05 00    	mov    0x508e4,%eax
  40317c:	48                   	dec    %eax
  40317d:	98                   	cwtl   
  40317e:	48                   	dec    %eax
  40317f:	69 c0 e8 00 00 00    	imul   $0xe8,%eax,%eax
  403185:	48                   	dec    %eax
  403186:	05 60 00 45 00       	add    $0x450060,%eax
  40318b:	48                   	dec    %eax
  40318c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  40318f:	77 a6                	ja     403137 <startothers+0x1c>
          lapicstartap(c->apicid, (void *)0x00);
          // wait for cpu to finish mpmain()
          while(c->started == 0);
     }

}
  403191:	c9                   	leave  
  403192:	c3                   	ret    

00403193 <list_apicid>:

/*
  List the apic id of each processors.
*/
static void list_apicid(void)
{
  403193:	55                   	push   %ebp
  403194:	48                   	dec    %eax
  403195:	89 e5                	mov    %esp,%ebp
  403197:	48                   	dec    %eax
  403198:	83 ec 10             	sub    $0x10,%esp
    int i;
    printf("The number of processors : %d\n", ncpu);
  40319b:	8b 05 bf 08 05 00    	mov    0x508bf,%eax
  4031a1:	89 c6                	mov    %eax,%esi
  4031a3:	bf 58 d6 40 00       	mov    $0x40d658,%edi
  4031a8:	b8 00 00 00 00       	mov    $0x0,%eax
  4031ad:	e8 ac db ff ff       	call   400d5e <printf>
    for(i = 0; i < ncpu; i++){
  4031b2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  4031b9:	eb 2d                	jmp    4031e8 <list_apicid+0x55>
        printf("%5d ",cpus[i].apicid);
  4031bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  4031be:	48                   	dec    %eax
  4031bf:	98                   	cwtl   
  4031c0:	48                   	dec    %eax
  4031c1:	69 c0 e8 00 00 00    	imul   $0xe8,%eax,%eax
  4031c7:	48                   	dec    %eax
  4031c8:	05 60 00 45 00       	add    $0x450060,%eax
  4031cd:	0f b6 00             	movzbl (%eax),%eax
  4031d0:	0f b6 c0             	movzbl %al,%eax
  4031d3:	89 c6                	mov    %eax,%esi
  4031d5:	bf 77 d6 40 00       	mov    $0x40d677,%edi
  4031da:	b8 00 00 00 00       	mov    $0x0,%eax
  4031df:	e8 7a db ff ff       	call   400d5e <printf>
*/
static void list_apicid(void)
{
    int i;
    printf("The number of processors : %d\n", ncpu);
    for(i = 0; i < ncpu; i++){
  4031e4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  4031e8:	8b 05 72 08 05 00    	mov    0x50872,%eax
  4031ee:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  4031f1:	7c c8                	jl     4031bb <list_apicid+0x28>
        printf("%5d ",cpus[i].apicid);
    }
    printf("\n");
  4031f3:	bf 7c d6 40 00       	mov    $0x40d67c,%edi
  4031f8:	b8 00 00 00 00       	mov    $0x0,%eax
  4031fd:	e8 5c db ff ff       	call   400d5e <printf>
}
  403202:	c9                   	leave  
  403203:	c3                   	ret    

00403204 <DEBUG>:

void DEBUG()
{
  403204:	55                   	push   %ebp
  403205:	48                   	dec    %eax
  403206:	89 e5                	mov    %esp,%ebp
    printf("move done!\n");
  403208:	bf 7e d6 40 00       	mov    $0x40d67e,%edi
  40320d:	b8 00 00 00 00       	mov    $0x0,%eax
  403212:	e8 47 db ff ff       	call   400d5e <printf>
}
  403217:	5d                   	pop    %ebp
  403218:	c3                   	ret    
