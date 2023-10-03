
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	a2010113          	addi	sp,sp,-1504 # 80008a20 <stack0>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	078000ef          	jal	ra,8000008e <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <timerinit>:
// at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    8000001c:	1141                	addi	sp,sp,-16
    8000001e:	e422                	sd	s0,8(sp)
    80000020:	0800                	addi	s0,sp,16
// which hart (core) is this?
static inline uint64
r_mhartid()
{
  uint64 x;
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80000022:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80000026:	0007869b          	sext.w	a3,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    8000002a:	0037979b          	slliw	a5,a5,0x3
    8000002e:	02004737          	lui	a4,0x2004
    80000032:	97ba                	add	a5,a5,a4
    80000034:	0200c737          	lui	a4,0x200c
    80000038:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000003c:	000f4637          	lui	a2,0xf4
    80000040:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80000044:	95b2                	add	a1,a1,a2
    80000046:	e38c                	sd	a1,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80000048:	00269713          	slli	a4,a3,0x2
    8000004c:	9736                	add	a4,a4,a3
    8000004e:	00371693          	slli	a3,a4,0x3
    80000052:	00009717          	auipc	a4,0x9
    80000056:	88e70713          	addi	a4,a4,-1906 # 800088e0 <timer_scratch>
    8000005a:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    8000005c:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    8000005e:	f310                	sd	a2,32(a4)
}

static inline void
w_mscratch(uint64 x)
{
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80000060:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80000064:	00006797          	auipc	a5,0x6
    80000068:	d4c78793          	addi	a5,a5,-692 # 80005db0 <timervec>
    8000006c:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80000070:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80000074:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80000078:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    8000007c:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80000080:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80000084:	30479073          	csrw	mie,a5
}
    80000088:	6422                	ld	s0,8(sp)
    8000008a:	0141                	addi	sp,sp,16
    8000008c:	8082                	ret

000000008000008e <start>:
{
    8000008e:	1141                	addi	sp,sp,-16
    80000090:	e406                	sd	ra,8(sp)
    80000092:	e022                	sd	s0,0(sp)
    80000094:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80000096:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    8000009a:	7779                	lui	a4,0xffffe
    8000009c:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffdcaaf>
    800000a0:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    800000a2:	6705                	lui	a4,0x1
    800000a4:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800000a8:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    800000aa:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    800000ae:	00001797          	auipc	a5,0x1
    800000b2:	dca78793          	addi	a5,a5,-566 # 80000e78 <main>
    800000b6:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    800000ba:	4781                	li	a5,0
    800000bc:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    800000c0:	67c1                	lui	a5,0x10
    800000c2:	17fd                	addi	a5,a5,-1
    800000c4:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    800000c8:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    800000cc:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    800000d0:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    800000d4:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    800000d8:	57fd                	li	a5,-1
    800000da:	83a9                	srli	a5,a5,0xa
    800000dc:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    800000e0:	47bd                	li	a5,15
    800000e2:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    800000e6:	00000097          	auipc	ra,0x0
    800000ea:	f36080e7          	jalr	-202(ra) # 8000001c <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800000ee:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    800000f2:	2781                	sext.w	a5,a5
}

static inline void
w_tp(uint64 x)
{
  asm volatile("mv tp, %0" : : "r" (x));
    800000f4:	823e                	mv	tp,a5
  asm volatile("mret");
    800000f6:	30200073          	mret
}
    800000fa:	60a2                	ld	ra,8(sp)
    800000fc:	6402                	ld	s0,0(sp)
    800000fe:	0141                	addi	sp,sp,16
    80000100:	8082                	ret

0000000080000102 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80000102:	715d                	addi	sp,sp,-80
    80000104:	e486                	sd	ra,72(sp)
    80000106:	e0a2                	sd	s0,64(sp)
    80000108:	fc26                	sd	s1,56(sp)
    8000010a:	f84a                	sd	s2,48(sp)
    8000010c:	f44e                	sd	s3,40(sp)
    8000010e:	f052                	sd	s4,32(sp)
    80000110:	ec56                	sd	s5,24(sp)
    80000112:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    80000114:	04c05663          	blez	a2,80000160 <consolewrite+0x5e>
    80000118:	8a2a                	mv	s4,a0
    8000011a:	84ae                	mv	s1,a1
    8000011c:	89b2                	mv	s3,a2
    8000011e:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80000120:	5afd                	li	s5,-1
    80000122:	4685                	li	a3,1
    80000124:	8626                	mv	a2,s1
    80000126:	85d2                	mv	a1,s4
    80000128:	fbf40513          	addi	a0,s0,-65
    8000012c:	00002097          	auipc	ra,0x2
    80000130:	570080e7          	jalr	1392(ra) # 8000269c <either_copyin>
    80000134:	01550c63          	beq	a0,s5,8000014c <consolewrite+0x4a>
      break;
    uartputc(c);
    80000138:	fbf44503          	lbu	a0,-65(s0)
    8000013c:	00000097          	auipc	ra,0x0
    80000140:	780080e7          	jalr	1920(ra) # 800008bc <uartputc>
  for(i = 0; i < n; i++){
    80000144:	2905                	addiw	s2,s2,1
    80000146:	0485                	addi	s1,s1,1
    80000148:	fd299de3          	bne	s3,s2,80000122 <consolewrite+0x20>
  }

  return i;
}
    8000014c:	854a                	mv	a0,s2
    8000014e:	60a6                	ld	ra,72(sp)
    80000150:	6406                	ld	s0,64(sp)
    80000152:	74e2                	ld	s1,56(sp)
    80000154:	7942                	ld	s2,48(sp)
    80000156:	79a2                	ld	s3,40(sp)
    80000158:	7a02                	ld	s4,32(sp)
    8000015a:	6ae2                	ld	s5,24(sp)
    8000015c:	6161                	addi	sp,sp,80
    8000015e:	8082                	ret
  for(i = 0; i < n; i++){
    80000160:	4901                	li	s2,0
    80000162:	b7ed                	j	8000014c <consolewrite+0x4a>

0000000080000164 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80000164:	7159                	addi	sp,sp,-112
    80000166:	f486                	sd	ra,104(sp)
    80000168:	f0a2                	sd	s0,96(sp)
    8000016a:	eca6                	sd	s1,88(sp)
    8000016c:	e8ca                	sd	s2,80(sp)
    8000016e:	e4ce                	sd	s3,72(sp)
    80000170:	e0d2                	sd	s4,64(sp)
    80000172:	fc56                	sd	s5,56(sp)
    80000174:	f85a                	sd	s6,48(sp)
    80000176:	f45e                	sd	s7,40(sp)
    80000178:	f062                	sd	s8,32(sp)
    8000017a:	ec66                	sd	s9,24(sp)
    8000017c:	e86a                	sd	s10,16(sp)
    8000017e:	1880                	addi	s0,sp,112
    80000180:	8aaa                	mv	s5,a0
    80000182:	8a2e                	mv	s4,a1
    80000184:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80000186:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    8000018a:	00011517          	auipc	a0,0x11
    8000018e:	89650513          	addi	a0,a0,-1898 # 80010a20 <cons>
    80000192:	00001097          	auipc	ra,0x1
    80000196:	a44080e7          	jalr	-1468(ra) # 80000bd6 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    8000019a:	00011497          	auipc	s1,0x11
    8000019e:	88648493          	addi	s1,s1,-1914 # 80010a20 <cons>
      if(killed(myproc())){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    800001a2:	00011917          	auipc	s2,0x11
    800001a6:	91690913          	addi	s2,s2,-1770 # 80010ab8 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];

    if(c == C('D')){  // end-of-file
    800001aa:	4b91                	li	s7,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    800001ac:	5c7d                	li	s8,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    800001ae:	4ca9                	li	s9,10
  while(n > 0){
    800001b0:	07305b63          	blez	s3,80000226 <consoleread+0xc2>
    while(cons.r == cons.w){
    800001b4:	0984a783          	lw	a5,152(s1)
    800001b8:	09c4a703          	lw	a4,156(s1)
    800001bc:	02f71763          	bne	a4,a5,800001ea <consoleread+0x86>
      if(killed(myproc())){
    800001c0:	00001097          	auipc	ra,0x1
    800001c4:	7ec080e7          	jalr	2028(ra) # 800019ac <myproc>
    800001c8:	00002097          	auipc	ra,0x2
    800001cc:	31e080e7          	jalr	798(ra) # 800024e6 <killed>
    800001d0:	e535                	bnez	a0,8000023c <consoleread+0xd8>
      sleep(&cons.r, &cons.lock);
    800001d2:	85a6                	mv	a1,s1
    800001d4:	854a                	mv	a0,s2
    800001d6:	00002097          	auipc	ra,0x2
    800001da:	e7e080e7          	jalr	-386(ra) # 80002054 <sleep>
    while(cons.r == cons.w){
    800001de:	0984a783          	lw	a5,152(s1)
    800001e2:	09c4a703          	lw	a4,156(s1)
    800001e6:	fcf70de3          	beq	a4,a5,800001c0 <consoleread+0x5c>
    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    800001ea:	0017871b          	addiw	a4,a5,1
    800001ee:	08e4ac23          	sw	a4,152(s1)
    800001f2:	07f7f713          	andi	a4,a5,127
    800001f6:	9726                	add	a4,a4,s1
    800001f8:	01874703          	lbu	a4,24(a4)
    800001fc:	00070d1b          	sext.w	s10,a4
    if(c == C('D')){  // end-of-file
    80000200:	077d0563          	beq	s10,s7,8000026a <consoleread+0x106>
    cbuf = c;
    80000204:	f8e40fa3          	sb	a4,-97(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80000208:	4685                	li	a3,1
    8000020a:	f9f40613          	addi	a2,s0,-97
    8000020e:	85d2                	mv	a1,s4
    80000210:	8556                	mv	a0,s5
    80000212:	00002097          	auipc	ra,0x2
    80000216:	434080e7          	jalr	1076(ra) # 80002646 <either_copyout>
    8000021a:	01850663          	beq	a0,s8,80000226 <consoleread+0xc2>
    dst++;
    8000021e:	0a05                	addi	s4,s4,1
    --n;
    80000220:	39fd                	addiw	s3,s3,-1
    if(c == '\n'){
    80000222:	f99d17e3          	bne	s10,s9,800001b0 <consoleread+0x4c>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80000226:	00010517          	auipc	a0,0x10
    8000022a:	7fa50513          	addi	a0,a0,2042 # 80010a20 <cons>
    8000022e:	00001097          	auipc	ra,0x1
    80000232:	a5c080e7          	jalr	-1444(ra) # 80000c8a <release>

  return target - n;
    80000236:	413b053b          	subw	a0,s6,s3
    8000023a:	a811                	j	8000024e <consoleread+0xea>
        release(&cons.lock);
    8000023c:	00010517          	auipc	a0,0x10
    80000240:	7e450513          	addi	a0,a0,2020 # 80010a20 <cons>
    80000244:	00001097          	auipc	ra,0x1
    80000248:	a46080e7          	jalr	-1466(ra) # 80000c8a <release>
        return -1;
    8000024c:	557d                	li	a0,-1
}
    8000024e:	70a6                	ld	ra,104(sp)
    80000250:	7406                	ld	s0,96(sp)
    80000252:	64e6                	ld	s1,88(sp)
    80000254:	6946                	ld	s2,80(sp)
    80000256:	69a6                	ld	s3,72(sp)
    80000258:	6a06                	ld	s4,64(sp)
    8000025a:	7ae2                	ld	s5,56(sp)
    8000025c:	7b42                	ld	s6,48(sp)
    8000025e:	7ba2                	ld	s7,40(sp)
    80000260:	7c02                	ld	s8,32(sp)
    80000262:	6ce2                	ld	s9,24(sp)
    80000264:	6d42                	ld	s10,16(sp)
    80000266:	6165                	addi	sp,sp,112
    80000268:	8082                	ret
      if(n < target){
    8000026a:	0009871b          	sext.w	a4,s3
    8000026e:	fb677ce3          	bgeu	a4,s6,80000226 <consoleread+0xc2>
        cons.r--;
    80000272:	00011717          	auipc	a4,0x11
    80000276:	84f72323          	sw	a5,-1978(a4) # 80010ab8 <cons+0x98>
    8000027a:	b775                	j	80000226 <consoleread+0xc2>

000000008000027c <consputc>:
{
    8000027c:	1141                	addi	sp,sp,-16
    8000027e:	e406                	sd	ra,8(sp)
    80000280:	e022                	sd	s0,0(sp)
    80000282:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80000284:	10000793          	li	a5,256
    80000288:	00f50a63          	beq	a0,a5,8000029c <consputc+0x20>
    uartputc_sync(c);
    8000028c:	00000097          	auipc	ra,0x0
    80000290:	55e080e7          	jalr	1374(ra) # 800007ea <uartputc_sync>
}
    80000294:	60a2                	ld	ra,8(sp)
    80000296:	6402                	ld	s0,0(sp)
    80000298:	0141                	addi	sp,sp,16
    8000029a:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    8000029c:	4521                	li	a0,8
    8000029e:	00000097          	auipc	ra,0x0
    800002a2:	54c080e7          	jalr	1356(ra) # 800007ea <uartputc_sync>
    800002a6:	02000513          	li	a0,32
    800002aa:	00000097          	auipc	ra,0x0
    800002ae:	540080e7          	jalr	1344(ra) # 800007ea <uartputc_sync>
    800002b2:	4521                	li	a0,8
    800002b4:	00000097          	auipc	ra,0x0
    800002b8:	536080e7          	jalr	1334(ra) # 800007ea <uartputc_sync>
    800002bc:	bfe1                	j	80000294 <consputc+0x18>

00000000800002be <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800002be:	1101                	addi	sp,sp,-32
    800002c0:	ec06                	sd	ra,24(sp)
    800002c2:	e822                	sd	s0,16(sp)
    800002c4:	e426                	sd	s1,8(sp)
    800002c6:	e04a                	sd	s2,0(sp)
    800002c8:	1000                	addi	s0,sp,32
    800002ca:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    800002cc:	00010517          	auipc	a0,0x10
    800002d0:	75450513          	addi	a0,a0,1876 # 80010a20 <cons>
    800002d4:	00001097          	auipc	ra,0x1
    800002d8:	902080e7          	jalr	-1790(ra) # 80000bd6 <acquire>

  switch(c){
    800002dc:	47d5                	li	a5,21
    800002de:	0af48663          	beq	s1,a5,8000038a <consoleintr+0xcc>
    800002e2:	0297ca63          	blt	a5,s1,80000316 <consoleintr+0x58>
    800002e6:	47a1                	li	a5,8
    800002e8:	0ef48763          	beq	s1,a5,800003d6 <consoleintr+0x118>
    800002ec:	47c1                	li	a5,16
    800002ee:	10f49a63          	bne	s1,a5,80000402 <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    800002f2:	00002097          	auipc	ra,0x2
    800002f6:	400080e7          	jalr	1024(ra) # 800026f2 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    800002fa:	00010517          	auipc	a0,0x10
    800002fe:	72650513          	addi	a0,a0,1830 # 80010a20 <cons>
    80000302:	00001097          	auipc	ra,0x1
    80000306:	988080e7          	jalr	-1656(ra) # 80000c8a <release>
}
    8000030a:	60e2                	ld	ra,24(sp)
    8000030c:	6442                	ld	s0,16(sp)
    8000030e:	64a2                	ld	s1,8(sp)
    80000310:	6902                	ld	s2,0(sp)
    80000312:	6105                	addi	sp,sp,32
    80000314:	8082                	ret
  switch(c){
    80000316:	07f00793          	li	a5,127
    8000031a:	0af48e63          	beq	s1,a5,800003d6 <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    8000031e:	00010717          	auipc	a4,0x10
    80000322:	70270713          	addi	a4,a4,1794 # 80010a20 <cons>
    80000326:	0a072783          	lw	a5,160(a4)
    8000032a:	09872703          	lw	a4,152(a4)
    8000032e:	9f99                	subw	a5,a5,a4
    80000330:	07f00713          	li	a4,127
    80000334:	fcf763e3          	bltu	a4,a5,800002fa <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    80000338:	47b5                	li	a5,13
    8000033a:	0cf48763          	beq	s1,a5,80000408 <consoleintr+0x14a>
      consputc(c);
    8000033e:	8526                	mv	a0,s1
    80000340:	00000097          	auipc	ra,0x0
    80000344:	f3c080e7          	jalr	-196(ra) # 8000027c <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80000348:	00010797          	auipc	a5,0x10
    8000034c:	6d878793          	addi	a5,a5,1752 # 80010a20 <cons>
    80000350:	0a07a683          	lw	a3,160(a5)
    80000354:	0016871b          	addiw	a4,a3,1
    80000358:	0007061b          	sext.w	a2,a4
    8000035c:	0ae7a023          	sw	a4,160(a5)
    80000360:	07f6f693          	andi	a3,a3,127
    80000364:	97b6                	add	a5,a5,a3
    80000366:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    8000036a:	47a9                	li	a5,10
    8000036c:	0cf48563          	beq	s1,a5,80000436 <consoleintr+0x178>
    80000370:	4791                	li	a5,4
    80000372:	0cf48263          	beq	s1,a5,80000436 <consoleintr+0x178>
    80000376:	00010797          	auipc	a5,0x10
    8000037a:	7427a783          	lw	a5,1858(a5) # 80010ab8 <cons+0x98>
    8000037e:	9f1d                	subw	a4,a4,a5
    80000380:	08000793          	li	a5,128
    80000384:	f6f71be3          	bne	a4,a5,800002fa <consoleintr+0x3c>
    80000388:	a07d                	j	80000436 <consoleintr+0x178>
    while(cons.e != cons.w &&
    8000038a:	00010717          	auipc	a4,0x10
    8000038e:	69670713          	addi	a4,a4,1686 # 80010a20 <cons>
    80000392:	0a072783          	lw	a5,160(a4)
    80000396:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    8000039a:	00010497          	auipc	s1,0x10
    8000039e:	68648493          	addi	s1,s1,1670 # 80010a20 <cons>
    while(cons.e != cons.w &&
    800003a2:	4929                	li	s2,10
    800003a4:	f4f70be3          	beq	a4,a5,800002fa <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    800003a8:	37fd                	addiw	a5,a5,-1
    800003aa:	07f7f713          	andi	a4,a5,127
    800003ae:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    800003b0:	01874703          	lbu	a4,24(a4)
    800003b4:	f52703e3          	beq	a4,s2,800002fa <consoleintr+0x3c>
      cons.e--;
    800003b8:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    800003bc:	10000513          	li	a0,256
    800003c0:	00000097          	auipc	ra,0x0
    800003c4:	ebc080e7          	jalr	-324(ra) # 8000027c <consputc>
    while(cons.e != cons.w &&
    800003c8:	0a04a783          	lw	a5,160(s1)
    800003cc:	09c4a703          	lw	a4,156(s1)
    800003d0:	fcf71ce3          	bne	a4,a5,800003a8 <consoleintr+0xea>
    800003d4:	b71d                	j	800002fa <consoleintr+0x3c>
    if(cons.e != cons.w){
    800003d6:	00010717          	auipc	a4,0x10
    800003da:	64a70713          	addi	a4,a4,1610 # 80010a20 <cons>
    800003de:	0a072783          	lw	a5,160(a4)
    800003e2:	09c72703          	lw	a4,156(a4)
    800003e6:	f0f70ae3          	beq	a4,a5,800002fa <consoleintr+0x3c>
      cons.e--;
    800003ea:	37fd                	addiw	a5,a5,-1
    800003ec:	00010717          	auipc	a4,0x10
    800003f0:	6cf72a23          	sw	a5,1748(a4) # 80010ac0 <cons+0xa0>
      consputc(BACKSPACE);
    800003f4:	10000513          	li	a0,256
    800003f8:	00000097          	auipc	ra,0x0
    800003fc:	e84080e7          	jalr	-380(ra) # 8000027c <consputc>
    80000400:	bded                	j	800002fa <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80000402:	ee048ce3          	beqz	s1,800002fa <consoleintr+0x3c>
    80000406:	bf21                	j	8000031e <consoleintr+0x60>
      consputc(c);
    80000408:	4529                	li	a0,10
    8000040a:	00000097          	auipc	ra,0x0
    8000040e:	e72080e7          	jalr	-398(ra) # 8000027c <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80000412:	00010797          	auipc	a5,0x10
    80000416:	60e78793          	addi	a5,a5,1550 # 80010a20 <cons>
    8000041a:	0a07a703          	lw	a4,160(a5)
    8000041e:	0017069b          	addiw	a3,a4,1
    80000422:	0006861b          	sext.w	a2,a3
    80000426:	0ad7a023          	sw	a3,160(a5)
    8000042a:	07f77713          	andi	a4,a4,127
    8000042e:	97ba                	add	a5,a5,a4
    80000430:	4729                	li	a4,10
    80000432:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80000436:	00010797          	auipc	a5,0x10
    8000043a:	68c7a323          	sw	a2,1670(a5) # 80010abc <cons+0x9c>
        wakeup(&cons.r);
    8000043e:	00010517          	auipc	a0,0x10
    80000442:	67a50513          	addi	a0,a0,1658 # 80010ab8 <cons+0x98>
    80000446:	00002097          	auipc	ra,0x2
    8000044a:	c72080e7          	jalr	-910(ra) # 800020b8 <wakeup>
    8000044e:	b575                	j	800002fa <consoleintr+0x3c>

0000000080000450 <consoleinit>:

void
consoleinit(void)
{
    80000450:	1141                	addi	sp,sp,-16
    80000452:	e406                	sd	ra,8(sp)
    80000454:	e022                	sd	s0,0(sp)
    80000456:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80000458:	00008597          	auipc	a1,0x8
    8000045c:	bb858593          	addi	a1,a1,-1096 # 80008010 <etext+0x10>
    80000460:	00010517          	auipc	a0,0x10
    80000464:	5c050513          	addi	a0,a0,1472 # 80010a20 <cons>
    80000468:	00000097          	auipc	ra,0x0
    8000046c:	6de080e7          	jalr	1758(ra) # 80000b46 <initlock>

  uartinit();
    80000470:	00000097          	auipc	ra,0x0
    80000474:	32a080e7          	jalr	810(ra) # 8000079a <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80000478:	00020797          	auipc	a5,0x20
    8000047c:	74078793          	addi	a5,a5,1856 # 80020bb8 <devsw>
    80000480:	00000717          	auipc	a4,0x0
    80000484:	ce470713          	addi	a4,a4,-796 # 80000164 <consoleread>
    80000488:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    8000048a:	00000717          	auipc	a4,0x0
    8000048e:	c7870713          	addi	a4,a4,-904 # 80000102 <consolewrite>
    80000492:	ef98                	sd	a4,24(a5)
}
    80000494:	60a2                	ld	ra,8(sp)
    80000496:	6402                	ld	s0,0(sp)
    80000498:	0141                	addi	sp,sp,16
    8000049a:	8082                	ret

000000008000049c <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    8000049c:	7179                	addi	sp,sp,-48
    8000049e:	f406                	sd	ra,40(sp)
    800004a0:	f022                	sd	s0,32(sp)
    800004a2:	ec26                	sd	s1,24(sp)
    800004a4:	e84a                	sd	s2,16(sp)
    800004a6:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    800004a8:	c219                	beqz	a2,800004ae <printint+0x12>
    800004aa:	08054663          	bltz	a0,80000536 <printint+0x9a>
    x = -xx;
  else
    x = xx;
    800004ae:	2501                	sext.w	a0,a0
    800004b0:	4881                	li	a7,0
    800004b2:	fd040693          	addi	a3,s0,-48

  i = 0;
    800004b6:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    800004b8:	2581                	sext.w	a1,a1
    800004ba:	00008617          	auipc	a2,0x8
    800004be:	b8660613          	addi	a2,a2,-1146 # 80008040 <digits>
    800004c2:	883a                	mv	a6,a4
    800004c4:	2705                	addiw	a4,a4,1
    800004c6:	02b577bb          	remuw	a5,a0,a1
    800004ca:	1782                	slli	a5,a5,0x20
    800004cc:	9381                	srli	a5,a5,0x20
    800004ce:	97b2                	add	a5,a5,a2
    800004d0:	0007c783          	lbu	a5,0(a5)
    800004d4:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    800004d8:	0005079b          	sext.w	a5,a0
    800004dc:	02b5553b          	divuw	a0,a0,a1
    800004e0:	0685                	addi	a3,a3,1
    800004e2:	feb7f0e3          	bgeu	a5,a1,800004c2 <printint+0x26>

  if(sign)
    800004e6:	00088b63          	beqz	a7,800004fc <printint+0x60>
    buf[i++] = '-';
    800004ea:	fe040793          	addi	a5,s0,-32
    800004ee:	973e                	add	a4,a4,a5
    800004f0:	02d00793          	li	a5,45
    800004f4:	fef70823          	sb	a5,-16(a4)
    800004f8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    800004fc:	02e05763          	blez	a4,8000052a <printint+0x8e>
    80000500:	fd040793          	addi	a5,s0,-48
    80000504:	00e784b3          	add	s1,a5,a4
    80000508:	fff78913          	addi	s2,a5,-1
    8000050c:	993a                	add	s2,s2,a4
    8000050e:	377d                	addiw	a4,a4,-1
    80000510:	1702                	slli	a4,a4,0x20
    80000512:	9301                	srli	a4,a4,0x20
    80000514:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80000518:	fff4c503          	lbu	a0,-1(s1)
    8000051c:	00000097          	auipc	ra,0x0
    80000520:	d60080e7          	jalr	-672(ra) # 8000027c <consputc>
  while(--i >= 0)
    80000524:	14fd                	addi	s1,s1,-1
    80000526:	ff2499e3          	bne	s1,s2,80000518 <printint+0x7c>
}
    8000052a:	70a2                	ld	ra,40(sp)
    8000052c:	7402                	ld	s0,32(sp)
    8000052e:	64e2                	ld	s1,24(sp)
    80000530:	6942                	ld	s2,16(sp)
    80000532:	6145                	addi	sp,sp,48
    80000534:	8082                	ret
    x = -xx;
    80000536:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    8000053a:	4885                	li	a7,1
    x = -xx;
    8000053c:	bf9d                	j	800004b2 <printint+0x16>

000000008000053e <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    8000053e:	1101                	addi	sp,sp,-32
    80000540:	ec06                	sd	ra,24(sp)
    80000542:	e822                	sd	s0,16(sp)
    80000544:	e426                	sd	s1,8(sp)
    80000546:	1000                	addi	s0,sp,32
    80000548:	84aa                	mv	s1,a0
  pr.locking = 0;
    8000054a:	00010797          	auipc	a5,0x10
    8000054e:	5807ab23          	sw	zero,1430(a5) # 80010ae0 <pr+0x18>
  printf("panic: ");
    80000552:	00008517          	auipc	a0,0x8
    80000556:	ac650513          	addi	a0,a0,-1338 # 80008018 <etext+0x18>
    8000055a:	00000097          	auipc	ra,0x0
    8000055e:	02e080e7          	jalr	46(ra) # 80000588 <printf>
  printf(s);
    80000562:	8526                	mv	a0,s1
    80000564:	00000097          	auipc	ra,0x0
    80000568:	024080e7          	jalr	36(ra) # 80000588 <printf>
  printf("\n");
    8000056c:	00008517          	auipc	a0,0x8
    80000570:	b5c50513          	addi	a0,a0,-1188 # 800080c8 <digits+0x88>
    80000574:	00000097          	auipc	ra,0x0
    80000578:	014080e7          	jalr	20(ra) # 80000588 <printf>
  panicked = 1; // freeze uart output from other CPUs
    8000057c:	4785                	li	a5,1
    8000057e:	00008717          	auipc	a4,0x8
    80000582:	32f72123          	sw	a5,802(a4) # 800088a0 <panicked>
  for(;;)
    80000586:	a001                	j	80000586 <panic+0x48>

0000000080000588 <printf>:
{
    80000588:	7131                	addi	sp,sp,-192
    8000058a:	fc86                	sd	ra,120(sp)
    8000058c:	f8a2                	sd	s0,112(sp)
    8000058e:	f4a6                	sd	s1,104(sp)
    80000590:	f0ca                	sd	s2,96(sp)
    80000592:	ecce                	sd	s3,88(sp)
    80000594:	e8d2                	sd	s4,80(sp)
    80000596:	e4d6                	sd	s5,72(sp)
    80000598:	e0da                	sd	s6,64(sp)
    8000059a:	fc5e                	sd	s7,56(sp)
    8000059c:	f862                	sd	s8,48(sp)
    8000059e:	f466                	sd	s9,40(sp)
    800005a0:	f06a                	sd	s10,32(sp)
    800005a2:	ec6e                	sd	s11,24(sp)
    800005a4:	0100                	addi	s0,sp,128
    800005a6:	8a2a                	mv	s4,a0
    800005a8:	e40c                	sd	a1,8(s0)
    800005aa:	e810                	sd	a2,16(s0)
    800005ac:	ec14                	sd	a3,24(s0)
    800005ae:	f018                	sd	a4,32(s0)
    800005b0:	f41c                	sd	a5,40(s0)
    800005b2:	03043823          	sd	a6,48(s0)
    800005b6:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    800005ba:	00010d97          	auipc	s11,0x10
    800005be:	526dad83          	lw	s11,1318(s11) # 80010ae0 <pr+0x18>
  if(locking)
    800005c2:	020d9b63          	bnez	s11,800005f8 <printf+0x70>
  if (fmt == 0)
    800005c6:	040a0263          	beqz	s4,8000060a <printf+0x82>
  va_start(ap, fmt);
    800005ca:	00840793          	addi	a5,s0,8
    800005ce:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800005d2:	000a4503          	lbu	a0,0(s4)
    800005d6:	14050f63          	beqz	a0,80000734 <printf+0x1ac>
    800005da:	4981                	li	s3,0
    if(c != '%'){
    800005dc:	02500a93          	li	s5,37
    switch(c){
    800005e0:	07000b93          	li	s7,112
  consputc('x');
    800005e4:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800005e6:	00008b17          	auipc	s6,0x8
    800005ea:	a5ab0b13          	addi	s6,s6,-1446 # 80008040 <digits>
    switch(c){
    800005ee:	07300c93          	li	s9,115
    800005f2:	06400c13          	li	s8,100
    800005f6:	a82d                	j	80000630 <printf+0xa8>
    acquire(&pr.lock);
    800005f8:	00010517          	auipc	a0,0x10
    800005fc:	4d050513          	addi	a0,a0,1232 # 80010ac8 <pr>
    80000600:	00000097          	auipc	ra,0x0
    80000604:	5d6080e7          	jalr	1494(ra) # 80000bd6 <acquire>
    80000608:	bf7d                	j	800005c6 <printf+0x3e>
    panic("null fmt");
    8000060a:	00008517          	auipc	a0,0x8
    8000060e:	a1e50513          	addi	a0,a0,-1506 # 80008028 <etext+0x28>
    80000612:	00000097          	auipc	ra,0x0
    80000616:	f2c080e7          	jalr	-212(ra) # 8000053e <panic>
      consputc(c);
    8000061a:	00000097          	auipc	ra,0x0
    8000061e:	c62080e7          	jalr	-926(ra) # 8000027c <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80000622:	2985                	addiw	s3,s3,1
    80000624:	013a07b3          	add	a5,s4,s3
    80000628:	0007c503          	lbu	a0,0(a5)
    8000062c:	10050463          	beqz	a0,80000734 <printf+0x1ac>
    if(c != '%'){
    80000630:	ff5515e3          	bne	a0,s5,8000061a <printf+0x92>
    c = fmt[++i] & 0xff;
    80000634:	2985                	addiw	s3,s3,1
    80000636:	013a07b3          	add	a5,s4,s3
    8000063a:	0007c783          	lbu	a5,0(a5)
    8000063e:	0007849b          	sext.w	s1,a5
    if(c == 0)
    80000642:	cbed                	beqz	a5,80000734 <printf+0x1ac>
    switch(c){
    80000644:	05778a63          	beq	a5,s7,80000698 <printf+0x110>
    80000648:	02fbf663          	bgeu	s7,a5,80000674 <printf+0xec>
    8000064c:	09978863          	beq	a5,s9,800006dc <printf+0x154>
    80000650:	07800713          	li	a4,120
    80000654:	0ce79563          	bne	a5,a4,8000071e <printf+0x196>
      printint(va_arg(ap, int), 16, 1);
    80000658:	f8843783          	ld	a5,-120(s0)
    8000065c:	00878713          	addi	a4,a5,8
    80000660:	f8e43423          	sd	a4,-120(s0)
    80000664:	4605                	li	a2,1
    80000666:	85ea                	mv	a1,s10
    80000668:	4388                	lw	a0,0(a5)
    8000066a:	00000097          	auipc	ra,0x0
    8000066e:	e32080e7          	jalr	-462(ra) # 8000049c <printint>
      break;
    80000672:	bf45                	j	80000622 <printf+0x9a>
    switch(c){
    80000674:	09578f63          	beq	a5,s5,80000712 <printf+0x18a>
    80000678:	0b879363          	bne	a5,s8,8000071e <printf+0x196>
      printint(va_arg(ap, int), 10, 1);
    8000067c:	f8843783          	ld	a5,-120(s0)
    80000680:	00878713          	addi	a4,a5,8
    80000684:	f8e43423          	sd	a4,-120(s0)
    80000688:	4605                	li	a2,1
    8000068a:	45a9                	li	a1,10
    8000068c:	4388                	lw	a0,0(a5)
    8000068e:	00000097          	auipc	ra,0x0
    80000692:	e0e080e7          	jalr	-498(ra) # 8000049c <printint>
      break;
    80000696:	b771                	j	80000622 <printf+0x9a>
      printptr(va_arg(ap, uint64));
    80000698:	f8843783          	ld	a5,-120(s0)
    8000069c:	00878713          	addi	a4,a5,8
    800006a0:	f8e43423          	sd	a4,-120(s0)
    800006a4:	0007b903          	ld	s2,0(a5)
  consputc('0');
    800006a8:	03000513          	li	a0,48
    800006ac:	00000097          	auipc	ra,0x0
    800006b0:	bd0080e7          	jalr	-1072(ra) # 8000027c <consputc>
  consputc('x');
    800006b4:	07800513          	li	a0,120
    800006b8:	00000097          	auipc	ra,0x0
    800006bc:	bc4080e7          	jalr	-1084(ra) # 8000027c <consputc>
    800006c0:	84ea                	mv	s1,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800006c2:	03c95793          	srli	a5,s2,0x3c
    800006c6:	97da                	add	a5,a5,s6
    800006c8:	0007c503          	lbu	a0,0(a5)
    800006cc:	00000097          	auipc	ra,0x0
    800006d0:	bb0080e7          	jalr	-1104(ra) # 8000027c <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800006d4:	0912                	slli	s2,s2,0x4
    800006d6:	34fd                	addiw	s1,s1,-1
    800006d8:	f4ed                	bnez	s1,800006c2 <printf+0x13a>
    800006da:	b7a1                	j	80000622 <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    800006dc:	f8843783          	ld	a5,-120(s0)
    800006e0:	00878713          	addi	a4,a5,8
    800006e4:	f8e43423          	sd	a4,-120(s0)
    800006e8:	6384                	ld	s1,0(a5)
    800006ea:	cc89                	beqz	s1,80000704 <printf+0x17c>
      for(; *s; s++)
    800006ec:	0004c503          	lbu	a0,0(s1)
    800006f0:	d90d                	beqz	a0,80000622 <printf+0x9a>
        consputc(*s);
    800006f2:	00000097          	auipc	ra,0x0
    800006f6:	b8a080e7          	jalr	-1142(ra) # 8000027c <consputc>
      for(; *s; s++)
    800006fa:	0485                	addi	s1,s1,1
    800006fc:	0004c503          	lbu	a0,0(s1)
    80000700:	f96d                	bnez	a0,800006f2 <printf+0x16a>
    80000702:	b705                	j	80000622 <printf+0x9a>
        s = "(null)";
    80000704:	00008497          	auipc	s1,0x8
    80000708:	91c48493          	addi	s1,s1,-1764 # 80008020 <etext+0x20>
      for(; *s; s++)
    8000070c:	02800513          	li	a0,40
    80000710:	b7cd                	j	800006f2 <printf+0x16a>
      consputc('%');
    80000712:	8556                	mv	a0,s5
    80000714:	00000097          	auipc	ra,0x0
    80000718:	b68080e7          	jalr	-1176(ra) # 8000027c <consputc>
      break;
    8000071c:	b719                	j	80000622 <printf+0x9a>
      consputc('%');
    8000071e:	8556                	mv	a0,s5
    80000720:	00000097          	auipc	ra,0x0
    80000724:	b5c080e7          	jalr	-1188(ra) # 8000027c <consputc>
      consputc(c);
    80000728:	8526                	mv	a0,s1
    8000072a:	00000097          	auipc	ra,0x0
    8000072e:	b52080e7          	jalr	-1198(ra) # 8000027c <consputc>
      break;
    80000732:	bdc5                	j	80000622 <printf+0x9a>
  if(locking)
    80000734:	020d9163          	bnez	s11,80000756 <printf+0x1ce>
}
    80000738:	70e6                	ld	ra,120(sp)
    8000073a:	7446                	ld	s0,112(sp)
    8000073c:	74a6                	ld	s1,104(sp)
    8000073e:	7906                	ld	s2,96(sp)
    80000740:	69e6                	ld	s3,88(sp)
    80000742:	6a46                	ld	s4,80(sp)
    80000744:	6aa6                	ld	s5,72(sp)
    80000746:	6b06                	ld	s6,64(sp)
    80000748:	7be2                	ld	s7,56(sp)
    8000074a:	7c42                	ld	s8,48(sp)
    8000074c:	7ca2                	ld	s9,40(sp)
    8000074e:	7d02                	ld	s10,32(sp)
    80000750:	6de2                	ld	s11,24(sp)
    80000752:	6129                	addi	sp,sp,192
    80000754:	8082                	ret
    release(&pr.lock);
    80000756:	00010517          	auipc	a0,0x10
    8000075a:	37250513          	addi	a0,a0,882 # 80010ac8 <pr>
    8000075e:	00000097          	auipc	ra,0x0
    80000762:	52c080e7          	jalr	1324(ra) # 80000c8a <release>
}
    80000766:	bfc9                	j	80000738 <printf+0x1b0>

0000000080000768 <printfinit>:
    ;
}

void
printfinit(void)
{
    80000768:	1101                	addi	sp,sp,-32
    8000076a:	ec06                	sd	ra,24(sp)
    8000076c:	e822                	sd	s0,16(sp)
    8000076e:	e426                	sd	s1,8(sp)
    80000770:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    80000772:	00010497          	auipc	s1,0x10
    80000776:	35648493          	addi	s1,s1,854 # 80010ac8 <pr>
    8000077a:	00008597          	auipc	a1,0x8
    8000077e:	8be58593          	addi	a1,a1,-1858 # 80008038 <etext+0x38>
    80000782:	8526                	mv	a0,s1
    80000784:	00000097          	auipc	ra,0x0
    80000788:	3c2080e7          	jalr	962(ra) # 80000b46 <initlock>
  pr.locking = 1;
    8000078c:	4785                	li	a5,1
    8000078e:	cc9c                	sw	a5,24(s1)
}
    80000790:	60e2                	ld	ra,24(sp)
    80000792:	6442                	ld	s0,16(sp)
    80000794:	64a2                	ld	s1,8(sp)
    80000796:	6105                	addi	sp,sp,32
    80000798:	8082                	ret

000000008000079a <uartinit>:

void uartstart();

void
uartinit(void)
{
    8000079a:	1141                	addi	sp,sp,-16
    8000079c:	e406                	sd	ra,8(sp)
    8000079e:	e022                	sd	s0,0(sp)
    800007a0:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    800007a2:	100007b7          	lui	a5,0x10000
    800007a6:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    800007aa:	f8000713          	li	a4,-128
    800007ae:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    800007b2:	470d                	li	a4,3
    800007b4:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    800007b8:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    800007bc:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    800007c0:	469d                	li	a3,7
    800007c2:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    800007c6:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    800007ca:	00008597          	auipc	a1,0x8
    800007ce:	88e58593          	addi	a1,a1,-1906 # 80008058 <digits+0x18>
    800007d2:	00010517          	auipc	a0,0x10
    800007d6:	31650513          	addi	a0,a0,790 # 80010ae8 <uart_tx_lock>
    800007da:	00000097          	auipc	ra,0x0
    800007de:	36c080e7          	jalr	876(ra) # 80000b46 <initlock>
}
    800007e2:	60a2                	ld	ra,8(sp)
    800007e4:	6402                	ld	s0,0(sp)
    800007e6:	0141                	addi	sp,sp,16
    800007e8:	8082                	ret

00000000800007ea <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    800007ea:	1101                	addi	sp,sp,-32
    800007ec:	ec06                	sd	ra,24(sp)
    800007ee:	e822                	sd	s0,16(sp)
    800007f0:	e426                	sd	s1,8(sp)
    800007f2:	1000                	addi	s0,sp,32
    800007f4:	84aa                	mv	s1,a0
  push_off();
    800007f6:	00000097          	auipc	ra,0x0
    800007fa:	394080e7          	jalr	916(ra) # 80000b8a <push_off>

  if(panicked){
    800007fe:	00008797          	auipc	a5,0x8
    80000802:	0a27a783          	lw	a5,162(a5) # 800088a0 <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80000806:	10000737          	lui	a4,0x10000
  if(panicked){
    8000080a:	c391                	beqz	a5,8000080e <uartputc_sync+0x24>
    for(;;)
    8000080c:	a001                	j	8000080c <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    8000080e:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80000812:	0207f793          	andi	a5,a5,32
    80000816:	dfe5                	beqz	a5,8000080e <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    80000818:	0ff4f513          	andi	a0,s1,255
    8000081c:	100007b7          	lui	a5,0x10000
    80000820:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    80000824:	00000097          	auipc	ra,0x0
    80000828:	406080e7          	jalr	1030(ra) # 80000c2a <pop_off>
}
    8000082c:	60e2                	ld	ra,24(sp)
    8000082e:	6442                	ld	s0,16(sp)
    80000830:	64a2                	ld	s1,8(sp)
    80000832:	6105                	addi	sp,sp,32
    80000834:	8082                	ret

0000000080000836 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    80000836:	00008797          	auipc	a5,0x8
    8000083a:	0727b783          	ld	a5,114(a5) # 800088a8 <uart_tx_r>
    8000083e:	00008717          	auipc	a4,0x8
    80000842:	07273703          	ld	a4,114(a4) # 800088b0 <uart_tx_w>
    80000846:	06f70a63          	beq	a4,a5,800008ba <uartstart+0x84>
{
    8000084a:	7139                	addi	sp,sp,-64
    8000084c:	fc06                	sd	ra,56(sp)
    8000084e:	f822                	sd	s0,48(sp)
    80000850:	f426                	sd	s1,40(sp)
    80000852:	f04a                	sd	s2,32(sp)
    80000854:	ec4e                	sd	s3,24(sp)
    80000856:	e852                	sd	s4,16(sp)
    80000858:	e456                	sd	s5,8(sp)
    8000085a:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    8000085c:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80000860:	00010a17          	auipc	s4,0x10
    80000864:	288a0a13          	addi	s4,s4,648 # 80010ae8 <uart_tx_lock>
    uart_tx_r += 1;
    80000868:	00008497          	auipc	s1,0x8
    8000086c:	04048493          	addi	s1,s1,64 # 800088a8 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    80000870:	00008997          	auipc	s3,0x8
    80000874:	04098993          	addi	s3,s3,64 # 800088b0 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80000878:	00594703          	lbu	a4,5(s2) # 10000005 <_entry-0x6ffffffb>
    8000087c:	02077713          	andi	a4,a4,32
    80000880:	c705                	beqz	a4,800008a8 <uartstart+0x72>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80000882:	01f7f713          	andi	a4,a5,31
    80000886:	9752                	add	a4,a4,s4
    80000888:	01874a83          	lbu	s5,24(a4)
    uart_tx_r += 1;
    8000088c:	0785                	addi	a5,a5,1
    8000088e:	e09c                	sd	a5,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    80000890:	8526                	mv	a0,s1
    80000892:	00002097          	auipc	ra,0x2
    80000896:	826080e7          	jalr	-2010(ra) # 800020b8 <wakeup>
    
    WriteReg(THR, c);
    8000089a:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    8000089e:	609c                	ld	a5,0(s1)
    800008a0:	0009b703          	ld	a4,0(s3)
    800008a4:	fcf71ae3          	bne	a4,a5,80000878 <uartstart+0x42>
  }
}
    800008a8:	70e2                	ld	ra,56(sp)
    800008aa:	7442                	ld	s0,48(sp)
    800008ac:	74a2                	ld	s1,40(sp)
    800008ae:	7902                	ld	s2,32(sp)
    800008b0:	69e2                	ld	s3,24(sp)
    800008b2:	6a42                	ld	s4,16(sp)
    800008b4:	6aa2                	ld	s5,8(sp)
    800008b6:	6121                	addi	sp,sp,64
    800008b8:	8082                	ret
    800008ba:	8082                	ret

00000000800008bc <uartputc>:
{
    800008bc:	7179                	addi	sp,sp,-48
    800008be:	f406                	sd	ra,40(sp)
    800008c0:	f022                	sd	s0,32(sp)
    800008c2:	ec26                	sd	s1,24(sp)
    800008c4:	e84a                	sd	s2,16(sp)
    800008c6:	e44e                	sd	s3,8(sp)
    800008c8:	e052                	sd	s4,0(sp)
    800008ca:	1800                	addi	s0,sp,48
    800008cc:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    800008ce:	00010517          	auipc	a0,0x10
    800008d2:	21a50513          	addi	a0,a0,538 # 80010ae8 <uart_tx_lock>
    800008d6:	00000097          	auipc	ra,0x0
    800008da:	300080e7          	jalr	768(ra) # 80000bd6 <acquire>
  if(panicked){
    800008de:	00008797          	auipc	a5,0x8
    800008e2:	fc27a783          	lw	a5,-62(a5) # 800088a0 <panicked>
    800008e6:	e7c9                	bnez	a5,80000970 <uartputc+0xb4>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800008e8:	00008717          	auipc	a4,0x8
    800008ec:	fc873703          	ld	a4,-56(a4) # 800088b0 <uart_tx_w>
    800008f0:	00008797          	auipc	a5,0x8
    800008f4:	fb87b783          	ld	a5,-72(a5) # 800088a8 <uart_tx_r>
    800008f8:	02078793          	addi	a5,a5,32
    sleep(&uart_tx_r, &uart_tx_lock);
    800008fc:	00010997          	auipc	s3,0x10
    80000900:	1ec98993          	addi	s3,s3,492 # 80010ae8 <uart_tx_lock>
    80000904:	00008497          	auipc	s1,0x8
    80000908:	fa448493          	addi	s1,s1,-92 # 800088a8 <uart_tx_r>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000090c:	00008917          	auipc	s2,0x8
    80000910:	fa490913          	addi	s2,s2,-92 # 800088b0 <uart_tx_w>
    80000914:	00e79f63          	bne	a5,a4,80000932 <uartputc+0x76>
    sleep(&uart_tx_r, &uart_tx_lock);
    80000918:	85ce                	mv	a1,s3
    8000091a:	8526                	mv	a0,s1
    8000091c:	00001097          	auipc	ra,0x1
    80000920:	738080e7          	jalr	1848(ra) # 80002054 <sleep>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80000924:	00093703          	ld	a4,0(s2)
    80000928:	609c                	ld	a5,0(s1)
    8000092a:	02078793          	addi	a5,a5,32
    8000092e:	fee785e3          	beq	a5,a4,80000918 <uartputc+0x5c>
  uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80000932:	00010497          	auipc	s1,0x10
    80000936:	1b648493          	addi	s1,s1,438 # 80010ae8 <uart_tx_lock>
    8000093a:	01f77793          	andi	a5,a4,31
    8000093e:	97a6                	add	a5,a5,s1
    80000940:	01478c23          	sb	s4,24(a5)
  uart_tx_w += 1;
    80000944:	0705                	addi	a4,a4,1
    80000946:	00008797          	auipc	a5,0x8
    8000094a:	f6e7b523          	sd	a4,-150(a5) # 800088b0 <uart_tx_w>
  uartstart();
    8000094e:	00000097          	auipc	ra,0x0
    80000952:	ee8080e7          	jalr	-280(ra) # 80000836 <uartstart>
  release(&uart_tx_lock);
    80000956:	8526                	mv	a0,s1
    80000958:	00000097          	auipc	ra,0x0
    8000095c:	332080e7          	jalr	818(ra) # 80000c8a <release>
}
    80000960:	70a2                	ld	ra,40(sp)
    80000962:	7402                	ld	s0,32(sp)
    80000964:	64e2                	ld	s1,24(sp)
    80000966:	6942                	ld	s2,16(sp)
    80000968:	69a2                	ld	s3,8(sp)
    8000096a:	6a02                	ld	s4,0(sp)
    8000096c:	6145                	addi	sp,sp,48
    8000096e:	8082                	ret
    for(;;)
    80000970:	a001                	j	80000970 <uartputc+0xb4>

0000000080000972 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80000972:	1141                	addi	sp,sp,-16
    80000974:	e422                	sd	s0,8(sp)
    80000976:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80000978:	100007b7          	lui	a5,0x10000
    8000097c:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80000980:	8b85                	andi	a5,a5,1
    80000982:	cb91                	beqz	a5,80000996 <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    80000984:	100007b7          	lui	a5,0x10000
    80000988:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
    8000098c:	0ff57513          	andi	a0,a0,255
  } else {
    return -1;
  }
}
    80000990:	6422                	ld	s0,8(sp)
    80000992:	0141                	addi	sp,sp,16
    80000994:	8082                	ret
    return -1;
    80000996:	557d                	li	a0,-1
    80000998:	bfe5                	j	80000990 <uartgetc+0x1e>

000000008000099a <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    8000099a:	1101                	addi	sp,sp,-32
    8000099c:	ec06                	sd	ra,24(sp)
    8000099e:	e822                	sd	s0,16(sp)
    800009a0:	e426                	sd	s1,8(sp)
    800009a2:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    800009a4:	54fd                	li	s1,-1
    800009a6:	a029                	j	800009b0 <uartintr+0x16>
      break;
    consoleintr(c);
    800009a8:	00000097          	auipc	ra,0x0
    800009ac:	916080e7          	jalr	-1770(ra) # 800002be <consoleintr>
    int c = uartgetc();
    800009b0:	00000097          	auipc	ra,0x0
    800009b4:	fc2080e7          	jalr	-62(ra) # 80000972 <uartgetc>
    if(c == -1)
    800009b8:	fe9518e3          	bne	a0,s1,800009a8 <uartintr+0xe>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    800009bc:	00010497          	auipc	s1,0x10
    800009c0:	12c48493          	addi	s1,s1,300 # 80010ae8 <uart_tx_lock>
    800009c4:	8526                	mv	a0,s1
    800009c6:	00000097          	auipc	ra,0x0
    800009ca:	210080e7          	jalr	528(ra) # 80000bd6 <acquire>
  uartstart();
    800009ce:	00000097          	auipc	ra,0x0
    800009d2:	e68080e7          	jalr	-408(ra) # 80000836 <uartstart>
  release(&uart_tx_lock);
    800009d6:	8526                	mv	a0,s1
    800009d8:	00000097          	auipc	ra,0x0
    800009dc:	2b2080e7          	jalr	690(ra) # 80000c8a <release>
}
    800009e0:	60e2                	ld	ra,24(sp)
    800009e2:	6442                	ld	s0,16(sp)
    800009e4:	64a2                	ld	s1,8(sp)
    800009e6:	6105                	addi	sp,sp,32
    800009e8:	8082                	ret

00000000800009ea <kfree>:
// Free the pig of physical memory pointed at by pa,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void kfree(void *pa)
{
    800009ea:	1101                	addi	sp,sp,-32
    800009ec:	ec06                	sd	ra,24(sp)
    800009ee:	e822                	sd	s0,16(sp)
    800009f0:	e426                	sd	s1,8(sp)
    800009f2:	e04a                	sd	s2,0(sp)
    800009f4:	1000                	addi	s0,sp,32
  struct run *r;

  if (((uint64)pa % PIGSIZE) != 0 || (char *)pa < end || (uint64)pa >= PHYSTOP)
    800009f6:	03451793          	slli	a5,a0,0x34
    800009fa:	ebb9                	bnez	a5,80000a50 <kfree+0x66>
    800009fc:	84aa                	mv	s1,a0
    800009fe:	00021797          	auipc	a5,0x21
    80000a02:	35278793          	addi	a5,a5,850 # 80021d50 <end>
    80000a06:	04f56563          	bltu	a0,a5,80000a50 <kfree+0x66>
    80000a0a:	47c5                	li	a5,17
    80000a0c:	07ee                	slli	a5,a5,0x1b
    80000a0e:	04f57163          	bgeu	a0,a5,80000a50 <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PIGSIZE);
    80000a12:	6605                	lui	a2,0x1
    80000a14:	4585                	li	a1,1
    80000a16:	00000097          	auipc	ra,0x0
    80000a1a:	2bc080e7          	jalr	700(ra) # 80000cd2 <memset>

  r = (struct run *)pa;

  acquire(&kmem.lock);
    80000a1e:	00010917          	auipc	s2,0x10
    80000a22:	10290913          	addi	s2,s2,258 # 80010b20 <kmem>
    80000a26:	854a                	mv	a0,s2
    80000a28:	00000097          	auipc	ra,0x0
    80000a2c:	1ae080e7          	jalr	430(ra) # 80000bd6 <acquire>
  r->next = kmem.freelist;
    80000a30:	01893783          	ld	a5,24(s2)
    80000a34:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000a36:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    80000a3a:	854a                	mv	a0,s2
    80000a3c:	00000097          	auipc	ra,0x0
    80000a40:	24e080e7          	jalr	590(ra) # 80000c8a <release>
}
    80000a44:	60e2                	ld	ra,24(sp)
    80000a46:	6442                	ld	s0,16(sp)
    80000a48:	64a2                	ld	s1,8(sp)
    80000a4a:	6902                	ld	s2,0(sp)
    80000a4c:	6105                	addi	sp,sp,32
    80000a4e:	8082                	ret
    panic("kfree");
    80000a50:	00007517          	auipc	a0,0x7
    80000a54:	61050513          	addi	a0,a0,1552 # 80008060 <digits+0x20>
    80000a58:	00000097          	auipc	ra,0x0
    80000a5c:	ae6080e7          	jalr	-1306(ra) # 8000053e <panic>

0000000080000a60 <freerange>:
{
    80000a60:	7179                	addi	sp,sp,-48
    80000a62:	f406                	sd	ra,40(sp)
    80000a64:	f022                	sd	s0,32(sp)
    80000a66:	ec26                	sd	s1,24(sp)
    80000a68:	e84a                	sd	s2,16(sp)
    80000a6a:	e44e                	sd	s3,8(sp)
    80000a6c:	e052                	sd	s4,0(sp)
    80000a6e:	1800                	addi	s0,sp,48
  p = (char *)PIGROUNDUP((uint64)pa_start);
    80000a70:	6785                	lui	a5,0x1
    80000a72:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80000a76:	94aa                	add	s1,s1,a0
    80000a78:	757d                	lui	a0,0xfffff
    80000a7a:	8ce9                	and	s1,s1,a0
  for (; p + PIGSIZE <= (char *)pa_end; p += PIGSIZE)
    80000a7c:	94be                	add	s1,s1,a5
    80000a7e:	0095ee63          	bltu	a1,s1,80000a9a <freerange+0x3a>
    80000a82:	892e                	mv	s2,a1
    kfree(p);
    80000a84:	7a7d                	lui	s4,0xfffff
  for (; p + PIGSIZE <= (char *)pa_end; p += PIGSIZE)
    80000a86:	6985                	lui	s3,0x1
    kfree(p);
    80000a88:	01448533          	add	a0,s1,s4
    80000a8c:	00000097          	auipc	ra,0x0
    80000a90:	f5e080e7          	jalr	-162(ra) # 800009ea <kfree>
  for (; p + PIGSIZE <= (char *)pa_end; p += PIGSIZE)
    80000a94:	94ce                	add	s1,s1,s3
    80000a96:	fe9979e3          	bgeu	s2,s1,80000a88 <freerange+0x28>
}
    80000a9a:	70a2                	ld	ra,40(sp)
    80000a9c:	7402                	ld	s0,32(sp)
    80000a9e:	64e2                	ld	s1,24(sp)
    80000aa0:	6942                	ld	s2,16(sp)
    80000aa2:	69a2                	ld	s3,8(sp)
    80000aa4:	6a02                	ld	s4,0(sp)
    80000aa6:	6145                	addi	sp,sp,48
    80000aa8:	8082                	ret

0000000080000aaa <kinit>:
{
    80000aaa:	1141                	addi	sp,sp,-16
    80000aac:	e406                	sd	ra,8(sp)
    80000aae:	e022                	sd	s0,0(sp)
    80000ab0:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    80000ab2:	00007597          	auipc	a1,0x7
    80000ab6:	5b658593          	addi	a1,a1,1462 # 80008068 <digits+0x28>
    80000aba:	00010517          	auipc	a0,0x10
    80000abe:	06650513          	addi	a0,a0,102 # 80010b20 <kmem>
    80000ac2:	00000097          	auipc	ra,0x0
    80000ac6:	084080e7          	jalr	132(ra) # 80000b46 <initlock>
  freerange(end, (void *)PHYSTOP);
    80000aca:	45c5                	li	a1,17
    80000acc:	05ee                	slli	a1,a1,0x1b
    80000ace:	00021517          	auipc	a0,0x21
    80000ad2:	28250513          	addi	a0,a0,642 # 80021d50 <end>
    80000ad6:	00000097          	auipc	ra,0x0
    80000ada:	f8a080e7          	jalr	-118(ra) # 80000a60 <freerange>
}
    80000ade:	60a2                	ld	ra,8(sp)
    80000ae0:	6402                	ld	s0,0(sp)
    80000ae2:	0141                	addi	sp,sp,16
    80000ae4:	8082                	ret

0000000080000ae6 <kalloc>:
// Allocate one 4096-byte pig of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000ae6:	1101                	addi	sp,sp,-32
    80000ae8:	ec06                	sd	ra,24(sp)
    80000aea:	e822                	sd	s0,16(sp)
    80000aec:	e426                	sd	s1,8(sp)
    80000aee:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000af0:	00010497          	auipc	s1,0x10
    80000af4:	03048493          	addi	s1,s1,48 # 80010b20 <kmem>
    80000af8:	8526                	mv	a0,s1
    80000afa:	00000097          	auipc	ra,0x0
    80000afe:	0dc080e7          	jalr	220(ra) # 80000bd6 <acquire>
  r = kmem.freelist;
    80000b02:	6c84                	ld	s1,24(s1)
  if (r)
    80000b04:	c885                	beqz	s1,80000b34 <kalloc+0x4e>
    kmem.freelist = r->next;
    80000b06:	609c                	ld	a5,0(s1)
    80000b08:	00010517          	auipc	a0,0x10
    80000b0c:	01850513          	addi	a0,a0,24 # 80010b20 <kmem>
    80000b10:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000b12:	00000097          	auipc	ra,0x0
    80000b16:	178080e7          	jalr	376(ra) # 80000c8a <release>

  if (r)
    memset((char *)r, 5, PIGSIZE); // fill with junk
    80000b1a:	6605                	lui	a2,0x1
    80000b1c:	4595                	li	a1,5
    80000b1e:	8526                	mv	a0,s1
    80000b20:	00000097          	auipc	ra,0x0
    80000b24:	1b2080e7          	jalr	434(ra) # 80000cd2 <memset>
  return (void *)r;
}
    80000b28:	8526                	mv	a0,s1
    80000b2a:	60e2                	ld	ra,24(sp)
    80000b2c:	6442                	ld	s0,16(sp)
    80000b2e:	64a2                	ld	s1,8(sp)
    80000b30:	6105                	addi	sp,sp,32
    80000b32:	8082                	ret
  release(&kmem.lock);
    80000b34:	00010517          	auipc	a0,0x10
    80000b38:	fec50513          	addi	a0,a0,-20 # 80010b20 <kmem>
    80000b3c:	00000097          	auipc	ra,0x0
    80000b40:	14e080e7          	jalr	334(ra) # 80000c8a <release>
  if (r)
    80000b44:	b7d5                	j	80000b28 <kalloc+0x42>

0000000080000b46 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80000b46:	1141                	addi	sp,sp,-16
    80000b48:	e422                	sd	s0,8(sp)
    80000b4a:	0800                	addi	s0,sp,16
  lk->name = name;
    80000b4c:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80000b4e:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80000b52:	00053823          	sd	zero,16(a0)
}
    80000b56:	6422                	ld	s0,8(sp)
    80000b58:	0141                	addi	sp,sp,16
    80000b5a:	8082                	ret

0000000080000b5c <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80000b5c:	411c                	lw	a5,0(a0)
    80000b5e:	e399                	bnez	a5,80000b64 <holding+0x8>
    80000b60:	4501                	li	a0,0
  return r;
}
    80000b62:	8082                	ret
{
    80000b64:	1101                	addi	sp,sp,-32
    80000b66:	ec06                	sd	ra,24(sp)
    80000b68:	e822                	sd	s0,16(sp)
    80000b6a:	e426                	sd	s1,8(sp)
    80000b6c:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80000b6e:	6904                	ld	s1,16(a0)
    80000b70:	00001097          	auipc	ra,0x1
    80000b74:	e20080e7          	jalr	-480(ra) # 80001990 <mycpu>
    80000b78:	40a48533          	sub	a0,s1,a0
    80000b7c:	00153513          	seqz	a0,a0
}
    80000b80:	60e2                	ld	ra,24(sp)
    80000b82:	6442                	ld	s0,16(sp)
    80000b84:	64a2                	ld	s1,8(sp)
    80000b86:	6105                	addi	sp,sp,32
    80000b88:	8082                	ret

0000000080000b8a <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80000b8a:	1101                	addi	sp,sp,-32
    80000b8c:	ec06                	sd	ra,24(sp)
    80000b8e:	e822                	sd	s0,16(sp)
    80000b90:	e426                	sd	s1,8(sp)
    80000b92:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000b94:	100024f3          	csrr	s1,sstatus
    80000b98:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80000b9c:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000b9e:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    80000ba2:	00001097          	auipc	ra,0x1
    80000ba6:	dee080e7          	jalr	-530(ra) # 80001990 <mycpu>
    80000baa:	5d3c                	lw	a5,120(a0)
    80000bac:	cf89                	beqz	a5,80000bc6 <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80000bae:	00001097          	auipc	ra,0x1
    80000bb2:	de2080e7          	jalr	-542(ra) # 80001990 <mycpu>
    80000bb6:	5d3c                	lw	a5,120(a0)
    80000bb8:	2785                	addiw	a5,a5,1
    80000bba:	dd3c                	sw	a5,120(a0)
}
    80000bbc:	60e2                	ld	ra,24(sp)
    80000bbe:	6442                	ld	s0,16(sp)
    80000bc0:	64a2                	ld	s1,8(sp)
    80000bc2:	6105                	addi	sp,sp,32
    80000bc4:	8082                	ret
    mycpu()->intena = old;
    80000bc6:	00001097          	auipc	ra,0x1
    80000bca:	dca080e7          	jalr	-566(ra) # 80001990 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80000bce:	8085                	srli	s1,s1,0x1
    80000bd0:	8885                	andi	s1,s1,1
    80000bd2:	dd64                	sw	s1,124(a0)
    80000bd4:	bfe9                	j	80000bae <push_off+0x24>

0000000080000bd6 <acquire>:
{
    80000bd6:	1101                	addi	sp,sp,-32
    80000bd8:	ec06                	sd	ra,24(sp)
    80000bda:	e822                	sd	s0,16(sp)
    80000bdc:	e426                	sd	s1,8(sp)
    80000bde:	1000                	addi	s0,sp,32
    80000be0:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80000be2:	00000097          	auipc	ra,0x0
    80000be6:	fa8080e7          	jalr	-88(ra) # 80000b8a <push_off>
  if(holding(lk))
    80000bea:	8526                	mv	a0,s1
    80000bec:	00000097          	auipc	ra,0x0
    80000bf0:	f70080e7          	jalr	-144(ra) # 80000b5c <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80000bf4:	4705                	li	a4,1
  if(holding(lk))
    80000bf6:	e115                	bnez	a0,80000c1a <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80000bf8:	87ba                	mv	a5,a4
    80000bfa:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80000bfe:	2781                	sext.w	a5,a5
    80000c00:	ffe5                	bnez	a5,80000bf8 <acquire+0x22>
  __sync_synchronize();
    80000c02:	0ff0000f          	fence
  lk->cpu = mycpu();
    80000c06:	00001097          	auipc	ra,0x1
    80000c0a:	d8a080e7          	jalr	-630(ra) # 80001990 <mycpu>
    80000c0e:	e888                	sd	a0,16(s1)
}
    80000c10:	60e2                	ld	ra,24(sp)
    80000c12:	6442                	ld	s0,16(sp)
    80000c14:	64a2                	ld	s1,8(sp)
    80000c16:	6105                	addi	sp,sp,32
    80000c18:	8082                	ret
    panic("acquire");
    80000c1a:	00007517          	auipc	a0,0x7
    80000c1e:	45650513          	addi	a0,a0,1110 # 80008070 <digits+0x30>
    80000c22:	00000097          	auipc	ra,0x0
    80000c26:	91c080e7          	jalr	-1764(ra) # 8000053e <panic>

0000000080000c2a <pop_off>:

void
pop_off(void)
{
    80000c2a:	1141                	addi	sp,sp,-16
    80000c2c:	e406                	sd	ra,8(sp)
    80000c2e:	e022                	sd	s0,0(sp)
    80000c30:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80000c32:	00001097          	auipc	ra,0x1
    80000c36:	d5e080e7          	jalr	-674(ra) # 80001990 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000c3a:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80000c3e:	8b89                	andi	a5,a5,2
  if(intr_get())
    80000c40:	e78d                	bnez	a5,80000c6a <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80000c42:	5d3c                	lw	a5,120(a0)
    80000c44:	02f05b63          	blez	a5,80000c7a <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    80000c48:	37fd                	addiw	a5,a5,-1
    80000c4a:	0007871b          	sext.w	a4,a5
    80000c4e:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80000c50:	eb09                	bnez	a4,80000c62 <pop_off+0x38>
    80000c52:	5d7c                	lw	a5,124(a0)
    80000c54:	c799                	beqz	a5,80000c62 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000c56:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80000c5a:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000c5e:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80000c62:	60a2                	ld	ra,8(sp)
    80000c64:	6402                	ld	s0,0(sp)
    80000c66:	0141                	addi	sp,sp,16
    80000c68:	8082                	ret
    panic("pop_off - interruptible");
    80000c6a:	00007517          	auipc	a0,0x7
    80000c6e:	40e50513          	addi	a0,a0,1038 # 80008078 <digits+0x38>
    80000c72:	00000097          	auipc	ra,0x0
    80000c76:	8cc080e7          	jalr	-1844(ra) # 8000053e <panic>
    panic("pop_off");
    80000c7a:	00007517          	auipc	a0,0x7
    80000c7e:	41650513          	addi	a0,a0,1046 # 80008090 <digits+0x50>
    80000c82:	00000097          	auipc	ra,0x0
    80000c86:	8bc080e7          	jalr	-1860(ra) # 8000053e <panic>

0000000080000c8a <release>:
{
    80000c8a:	1101                	addi	sp,sp,-32
    80000c8c:	ec06                	sd	ra,24(sp)
    80000c8e:	e822                	sd	s0,16(sp)
    80000c90:	e426                	sd	s1,8(sp)
    80000c92:	1000                	addi	s0,sp,32
    80000c94:	84aa                	mv	s1,a0
  if(!holding(lk))
    80000c96:	00000097          	auipc	ra,0x0
    80000c9a:	ec6080e7          	jalr	-314(ra) # 80000b5c <holding>
    80000c9e:	c115                	beqz	a0,80000cc2 <release+0x38>
  lk->cpu = 0;
    80000ca0:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80000ca4:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    80000ca8:	0f50000f          	fence	iorw,ow
    80000cac:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    80000cb0:	00000097          	auipc	ra,0x0
    80000cb4:	f7a080e7          	jalr	-134(ra) # 80000c2a <pop_off>
}
    80000cb8:	60e2                	ld	ra,24(sp)
    80000cba:	6442                	ld	s0,16(sp)
    80000cbc:	64a2                	ld	s1,8(sp)
    80000cbe:	6105                	addi	sp,sp,32
    80000cc0:	8082                	ret
    panic("release");
    80000cc2:	00007517          	auipc	a0,0x7
    80000cc6:	3d650513          	addi	a0,a0,982 # 80008098 <digits+0x58>
    80000cca:	00000097          	auipc	ra,0x0
    80000cce:	874080e7          	jalr	-1932(ra) # 8000053e <panic>

0000000080000cd2 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80000cd2:	1141                	addi	sp,sp,-16
    80000cd4:	e422                	sd	s0,8(sp)
    80000cd6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000cd8:	ca19                	beqz	a2,80000cee <memset+0x1c>
    80000cda:	87aa                	mv	a5,a0
    80000cdc:	1602                	slli	a2,a2,0x20
    80000cde:	9201                	srli	a2,a2,0x20
    80000ce0:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    80000ce4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000ce8:	0785                	addi	a5,a5,1
    80000cea:	fee79de3          	bne	a5,a4,80000ce4 <memset+0x12>
  }
  return dst;
}
    80000cee:	6422                	ld	s0,8(sp)
    80000cf0:	0141                	addi	sp,sp,16
    80000cf2:	8082                	ret

0000000080000cf4 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    80000cf4:	1141                	addi	sp,sp,-16
    80000cf6:	e422                	sd	s0,8(sp)
    80000cf8:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    80000cfa:	ca05                	beqz	a2,80000d2a <memcmp+0x36>
    80000cfc:	fff6069b          	addiw	a3,a2,-1
    80000d00:	1682                	slli	a3,a3,0x20
    80000d02:	9281                	srli	a3,a3,0x20
    80000d04:	0685                	addi	a3,a3,1
    80000d06:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    80000d08:	00054783          	lbu	a5,0(a0)
    80000d0c:	0005c703          	lbu	a4,0(a1)
    80000d10:	00e79863          	bne	a5,a4,80000d20 <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    80000d14:	0505                	addi	a0,a0,1
    80000d16:	0585                	addi	a1,a1,1
  while(n-- > 0){
    80000d18:	fed518e3          	bne	a0,a3,80000d08 <memcmp+0x14>
  }

  return 0;
    80000d1c:	4501                	li	a0,0
    80000d1e:	a019                	j	80000d24 <memcmp+0x30>
      return *s1 - *s2;
    80000d20:	40e7853b          	subw	a0,a5,a4
}
    80000d24:	6422                	ld	s0,8(sp)
    80000d26:	0141                	addi	sp,sp,16
    80000d28:	8082                	ret
  return 0;
    80000d2a:	4501                	li	a0,0
    80000d2c:	bfe5                	j	80000d24 <memcmp+0x30>

0000000080000d2e <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    80000d2e:	1141                	addi	sp,sp,-16
    80000d30:	e422                	sd	s0,8(sp)
    80000d32:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    80000d34:	c205                	beqz	a2,80000d54 <memmove+0x26>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    80000d36:	02a5e263          	bltu	a1,a0,80000d5a <memmove+0x2c>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    80000d3a:	1602                	slli	a2,a2,0x20
    80000d3c:	9201                	srli	a2,a2,0x20
    80000d3e:	00c587b3          	add	a5,a1,a2
{
    80000d42:	872a                	mv	a4,a0
      *d++ = *s++;
    80000d44:	0585                	addi	a1,a1,1
    80000d46:	0705                	addi	a4,a4,1
    80000d48:	fff5c683          	lbu	a3,-1(a1)
    80000d4c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    80000d50:	fef59ae3          	bne	a1,a5,80000d44 <memmove+0x16>

  return dst;
}
    80000d54:	6422                	ld	s0,8(sp)
    80000d56:	0141                	addi	sp,sp,16
    80000d58:	8082                	ret
  if(s < d && s + n > d){
    80000d5a:	02061693          	slli	a3,a2,0x20
    80000d5e:	9281                	srli	a3,a3,0x20
    80000d60:	00d58733          	add	a4,a1,a3
    80000d64:	fce57be3          	bgeu	a0,a4,80000d3a <memmove+0xc>
    d += n;
    80000d68:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    80000d6a:	fff6079b          	addiw	a5,a2,-1
    80000d6e:	1782                	slli	a5,a5,0x20
    80000d70:	9381                	srli	a5,a5,0x20
    80000d72:	fff7c793          	not	a5,a5
    80000d76:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000d78:	177d                	addi	a4,a4,-1
    80000d7a:	16fd                	addi	a3,a3,-1
    80000d7c:	00074603          	lbu	a2,0(a4)
    80000d80:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    80000d84:	fee79ae3          	bne	a5,a4,80000d78 <memmove+0x4a>
    80000d88:	b7f1                	j	80000d54 <memmove+0x26>

0000000080000d8a <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000d8a:	1141                	addi	sp,sp,-16
    80000d8c:	e406                	sd	ra,8(sp)
    80000d8e:	e022                	sd	s0,0(sp)
    80000d90:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000d92:	00000097          	auipc	ra,0x0
    80000d96:	f9c080e7          	jalr	-100(ra) # 80000d2e <memmove>
}
    80000d9a:	60a2                	ld	ra,8(sp)
    80000d9c:	6402                	ld	s0,0(sp)
    80000d9e:	0141                	addi	sp,sp,16
    80000da0:	8082                	ret

0000000080000da2 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000da2:	1141                	addi	sp,sp,-16
    80000da4:	e422                	sd	s0,8(sp)
    80000da6:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000da8:	ce11                	beqz	a2,80000dc4 <strncmp+0x22>
    80000daa:	00054783          	lbu	a5,0(a0)
    80000dae:	cf89                	beqz	a5,80000dc8 <strncmp+0x26>
    80000db0:	0005c703          	lbu	a4,0(a1)
    80000db4:	00f71a63          	bne	a4,a5,80000dc8 <strncmp+0x26>
    n--, p++, q++;
    80000db8:	367d                	addiw	a2,a2,-1
    80000dba:	0505                	addi	a0,a0,1
    80000dbc:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000dbe:	f675                	bnez	a2,80000daa <strncmp+0x8>
  if(n == 0)
    return 0;
    80000dc0:	4501                	li	a0,0
    80000dc2:	a809                	j	80000dd4 <strncmp+0x32>
    80000dc4:	4501                	li	a0,0
    80000dc6:	a039                	j	80000dd4 <strncmp+0x32>
  if(n == 0)
    80000dc8:	ca09                	beqz	a2,80000dda <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    80000dca:	00054503          	lbu	a0,0(a0)
    80000dce:	0005c783          	lbu	a5,0(a1)
    80000dd2:	9d1d                	subw	a0,a0,a5
}
    80000dd4:	6422                	ld	s0,8(sp)
    80000dd6:	0141                	addi	sp,sp,16
    80000dd8:	8082                	ret
    return 0;
    80000dda:	4501                	li	a0,0
    80000ddc:	bfe5                	j	80000dd4 <strncmp+0x32>

0000000080000dde <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000dde:	1141                	addi	sp,sp,-16
    80000de0:	e422                	sd	s0,8(sp)
    80000de2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000de4:	872a                	mv	a4,a0
    80000de6:	8832                	mv	a6,a2
    80000de8:	367d                	addiw	a2,a2,-1
    80000dea:	01005963          	blez	a6,80000dfc <strncpy+0x1e>
    80000dee:	0705                	addi	a4,a4,1
    80000df0:	0005c783          	lbu	a5,0(a1)
    80000df4:	fef70fa3          	sb	a5,-1(a4)
    80000df8:	0585                	addi	a1,a1,1
    80000dfa:	f7f5                	bnez	a5,80000de6 <strncpy+0x8>
    ;
  while(n-- > 0)
    80000dfc:	86ba                	mv	a3,a4
    80000dfe:	00c05c63          	blez	a2,80000e16 <strncpy+0x38>
    *s++ = 0;
    80000e02:	0685                	addi	a3,a3,1
    80000e04:	fe068fa3          	sb	zero,-1(a3)
  while(n-- > 0)
    80000e08:	fff6c793          	not	a5,a3
    80000e0c:	9fb9                	addw	a5,a5,a4
    80000e0e:	010787bb          	addw	a5,a5,a6
    80000e12:	fef048e3          	bgtz	a5,80000e02 <strncpy+0x24>
  return os;
}
    80000e16:	6422                	ld	s0,8(sp)
    80000e18:	0141                	addi	sp,sp,16
    80000e1a:	8082                	ret

0000000080000e1c <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    80000e1c:	1141                	addi	sp,sp,-16
    80000e1e:	e422                	sd	s0,8(sp)
    80000e20:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    80000e22:	02c05363          	blez	a2,80000e48 <safestrcpy+0x2c>
    80000e26:	fff6069b          	addiw	a3,a2,-1
    80000e2a:	1682                	slli	a3,a3,0x20
    80000e2c:	9281                	srli	a3,a3,0x20
    80000e2e:	96ae                	add	a3,a3,a1
    80000e30:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    80000e32:	00d58963          	beq	a1,a3,80000e44 <safestrcpy+0x28>
    80000e36:	0585                	addi	a1,a1,1
    80000e38:	0785                	addi	a5,a5,1
    80000e3a:	fff5c703          	lbu	a4,-1(a1)
    80000e3e:	fee78fa3          	sb	a4,-1(a5)
    80000e42:	fb65                	bnez	a4,80000e32 <safestrcpy+0x16>
    ;
  *s = 0;
    80000e44:	00078023          	sb	zero,0(a5)
  return os;
}
    80000e48:	6422                	ld	s0,8(sp)
    80000e4a:	0141                	addi	sp,sp,16
    80000e4c:	8082                	ret

0000000080000e4e <strlen>:

int
strlen(const char *s)
{
    80000e4e:	1141                	addi	sp,sp,-16
    80000e50:	e422                	sd	s0,8(sp)
    80000e52:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    80000e54:	00054783          	lbu	a5,0(a0)
    80000e58:	cf91                	beqz	a5,80000e74 <strlen+0x26>
    80000e5a:	0505                	addi	a0,a0,1
    80000e5c:	87aa                	mv	a5,a0
    80000e5e:	4685                	li	a3,1
    80000e60:	9e89                	subw	a3,a3,a0
    80000e62:	00f6853b          	addw	a0,a3,a5
    80000e66:	0785                	addi	a5,a5,1
    80000e68:	fff7c703          	lbu	a4,-1(a5)
    80000e6c:	fb7d                	bnez	a4,80000e62 <strlen+0x14>
    ;
  return n;
}
    80000e6e:	6422                	ld	s0,8(sp)
    80000e70:	0141                	addi	sp,sp,16
    80000e72:	8082                	ret
  for(n = 0; s[n]; n++)
    80000e74:	4501                	li	a0,0
    80000e76:	bfe5                	j	80000e6e <strlen+0x20>

0000000080000e78 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000e78:	1141                	addi	sp,sp,-16
    80000e7a:	e406                	sd	ra,8(sp)
    80000e7c:	e022                	sd	s0,0(sp)
    80000e7e:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    80000e80:	00001097          	auipc	ra,0x1
    80000e84:	b00080e7          	jalr	-1280(ra) # 80001980 <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000e88:	00008717          	auipc	a4,0x8
    80000e8c:	a3070713          	addi	a4,a4,-1488 # 800088b8 <started>
  if(cpuid() == 0){
    80000e90:	c139                	beqz	a0,80000ed6 <main+0x5e>
    while(started == 0)
    80000e92:	431c                	lw	a5,0(a4)
    80000e94:	2781                	sext.w	a5,a5
    80000e96:	dff5                	beqz	a5,80000e92 <main+0x1a>
      ;
    __sync_synchronize();
    80000e98:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    80000e9c:	00001097          	auipc	ra,0x1
    80000ea0:	ae4080e7          	jalr	-1308(ra) # 80001980 <cpuid>
    80000ea4:	85aa                	mv	a1,a0
    80000ea6:	00007517          	auipc	a0,0x7
    80000eaa:	21250513          	addi	a0,a0,530 # 800080b8 <digits+0x78>
    80000eae:	fffff097          	auipc	ra,0xfffff
    80000eb2:	6da080e7          	jalr	1754(ra) # 80000588 <printf>
    kvminithart();    // turn on paging
    80000eb6:	00000097          	auipc	ra,0x0
    80000eba:	0d8080e7          	jalr	216(ra) # 80000f8e <kvminithart>
    trapinithart();   // install kernel trap vector
    80000ebe:	00002097          	auipc	ra,0x2
    80000ec2:	974080e7          	jalr	-1676(ra) # 80002832 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000ec6:	00005097          	auipc	ra,0x5
    80000eca:	f2a080e7          	jalr	-214(ra) # 80005df0 <plicinithart>
  }

  scheduler();
    80000ece:	00001097          	auipc	ra,0x1
    80000ed2:	fd4080e7          	jalr	-44(ra) # 80001ea2 <scheduler>
    consoleinit();
    80000ed6:	fffff097          	auipc	ra,0xfffff
    80000eda:	57a080e7          	jalr	1402(ra) # 80000450 <consoleinit>
    printfinit();
    80000ede:	00000097          	auipc	ra,0x0
    80000ee2:	88a080e7          	jalr	-1910(ra) # 80000768 <printfinit>
    printf("\n");
    80000ee6:	00007517          	auipc	a0,0x7
    80000eea:	1e250513          	addi	a0,a0,482 # 800080c8 <digits+0x88>
    80000eee:	fffff097          	auipc	ra,0xfffff
    80000ef2:	69a080e7          	jalr	1690(ra) # 80000588 <printf>
    printf("xv6 kernel is booting\n");
    80000ef6:	00007517          	auipc	a0,0x7
    80000efa:	1aa50513          	addi	a0,a0,426 # 800080a0 <digits+0x60>
    80000efe:	fffff097          	auipc	ra,0xfffff
    80000f02:	68a080e7          	jalr	1674(ra) # 80000588 <printf>
    printf("\n");
    80000f06:	00007517          	auipc	a0,0x7
    80000f0a:	1c250513          	addi	a0,a0,450 # 800080c8 <digits+0x88>
    80000f0e:	fffff097          	auipc	ra,0xfffff
    80000f12:	67a080e7          	jalr	1658(ra) # 80000588 <printf>
    kinit();         // physical pig allocator
    80000f16:	00000097          	auipc	ra,0x0
    80000f1a:	b94080e7          	jalr	-1132(ra) # 80000aaa <kinit>
    kvminit();       // create kernel pig table
    80000f1e:	00000097          	auipc	ra,0x0
    80000f22:	326080e7          	jalr	806(ra) # 80001244 <kvminit>
    kvminithart();   // turn on paging
    80000f26:	00000097          	auipc	ra,0x0
    80000f2a:	068080e7          	jalr	104(ra) # 80000f8e <kvminithart>
    procinit();      // process table
    80000f2e:	00001097          	auipc	ra,0x1
    80000f32:	99e080e7          	jalr	-1634(ra) # 800018cc <procinit>
    trapinit();      // trap vectors
    80000f36:	00002097          	auipc	ra,0x2
    80000f3a:	8d4080e7          	jalr	-1836(ra) # 8000280a <trapinit>
    trapinithart();  // install kernel trap vector
    80000f3e:	00002097          	auipc	ra,0x2
    80000f42:	8f4080e7          	jalr	-1804(ra) # 80002832 <trapinithart>
    plicinit();      // set up interrupt controller
    80000f46:	00005097          	auipc	ra,0x5
    80000f4a:	e94080e7          	jalr	-364(ra) # 80005dda <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000f4e:	00005097          	auipc	ra,0x5
    80000f52:	ea2080e7          	jalr	-350(ra) # 80005df0 <plicinithart>
    binit();         // buffer cache
    80000f56:	00002097          	auipc	ra,0x2
    80000f5a:	042080e7          	jalr	66(ra) # 80002f98 <binit>
    iinit();         // inode table
    80000f5e:	00002097          	auipc	ra,0x2
    80000f62:	6e6080e7          	jalr	1766(ra) # 80003644 <iinit>
    fileinit();      // file table
    80000f66:	00003097          	auipc	ra,0x3
    80000f6a:	684080e7          	jalr	1668(ra) # 800045ea <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000f6e:	00005097          	auipc	ra,0x5
    80000f72:	f8a080e7          	jalr	-118(ra) # 80005ef8 <virtio_disk_init>
    userinit();      // first user process
    80000f76:	00001097          	auipc	ra,0x1
    80000f7a:	d0e080e7          	jalr	-754(ra) # 80001c84 <userinit>
    __sync_synchronize();
    80000f7e:	0ff0000f          	fence
    started = 1;
    80000f82:	4785                	li	a5,1
    80000f84:	00008717          	auipc	a4,0x8
    80000f88:	92f72a23          	sw	a5,-1740(a4) # 800088b8 <started>
    80000f8c:	b789                	j	80000ece <main+0x56>

0000000080000f8e <kvminithart>:
}

// Switch h/w pig table register to the kernel's pig table,
// and enable paging.
void kvminithart()
{
    80000f8e:	1141                	addi	sp,sp,-16
    80000f90:	e422                	sd	s0,8(sp)
    80000f92:	0800                	addi	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000f94:	12000073          	sfence.vma
  // wait for any previous writes to the pig table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pigtable));
    80000f98:	00008797          	auipc	a5,0x8
    80000f9c:	9287b783          	ld	a5,-1752(a5) # 800088c0 <kernel_pigtable>
    80000fa0:	83b1                	srli	a5,a5,0xc
    80000fa2:	577d                	li	a4,-1
    80000fa4:	177e                	slli	a4,a4,0x3f
    80000fa6:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    80000fa8:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    80000fac:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    80000fb0:	6422                	ld	s0,8(sp)
    80000fb2:	0141                	addi	sp,sp,16
    80000fb4:	8082                	ret

0000000080000fb6 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the pig.
pte_t *
walk(pigtable_t pigtable, uint64 va, int alloc)
{
    80000fb6:	7139                	addi	sp,sp,-64
    80000fb8:	fc06                	sd	ra,56(sp)
    80000fba:	f822                	sd	s0,48(sp)
    80000fbc:	f426                	sd	s1,40(sp)
    80000fbe:	f04a                	sd	s2,32(sp)
    80000fc0:	ec4e                	sd	s3,24(sp)
    80000fc2:	e852                	sd	s4,16(sp)
    80000fc4:	e456                	sd	s5,8(sp)
    80000fc6:	e05a                	sd	s6,0(sp)
    80000fc8:	0080                	addi	s0,sp,64
    80000fca:	84aa                	mv	s1,a0
    80000fcc:	89ae                	mv	s3,a1
    80000fce:	8ab2                	mv	s5,a2
  if (va >= MAXVA)
    80000fd0:	57fd                	li	a5,-1
    80000fd2:	83e9                	srli	a5,a5,0x1a
    80000fd4:	4a79                	li	s4,30
    panic("walk");

  for (int level = 2; level > 0; level--)
    80000fd6:	4b31                	li	s6,12
  if (va >= MAXVA)
    80000fd8:	04b7f263          	bgeu	a5,a1,8000101c <walk+0x66>
    panic("walk");
    80000fdc:	00007517          	auipc	a0,0x7
    80000fe0:	0f450513          	addi	a0,a0,244 # 800080d0 <digits+0x90>
    80000fe4:	fffff097          	auipc	ra,0xfffff
    80000fe8:	55a080e7          	jalr	1370(ra) # 8000053e <panic>
    {
      pigtable = (pigtable_t)PTE2PA(*pte);
    }
    else
    {
      if (!alloc || (pigtable = (pde_t *)kalloc()) == 0)
    80000fec:	060a8663          	beqz	s5,80001058 <walk+0xa2>
    80000ff0:	00000097          	auipc	ra,0x0
    80000ff4:	af6080e7          	jalr	-1290(ra) # 80000ae6 <kalloc>
    80000ff8:	84aa                	mv	s1,a0
    80000ffa:	c529                	beqz	a0,80001044 <walk+0x8e>
        return 0;
      memset(pigtable, 0, PIGSIZE);
    80000ffc:	6605                	lui	a2,0x1
    80000ffe:	4581                	li	a1,0
    80001000:	00000097          	auipc	ra,0x0
    80001004:	cd2080e7          	jalr	-814(ra) # 80000cd2 <memset>
      *pte = PA2PTE(pigtable) | PTE_V;
    80001008:	00c4d793          	srli	a5,s1,0xc
    8000100c:	07aa                	slli	a5,a5,0xa
    8000100e:	0017e793          	ori	a5,a5,1
    80001012:	00f93023          	sd	a5,0(s2)
  for (int level = 2; level > 0; level--)
    80001016:	3a5d                	addiw	s4,s4,-9
    80001018:	036a0063          	beq	s4,s6,80001038 <walk+0x82>
    pte_t *pte = &pigtable[PX(level, va)];
    8000101c:	0149d933          	srl	s2,s3,s4
    80001020:	1ff97913          	andi	s2,s2,511
    80001024:	090e                	slli	s2,s2,0x3
    80001026:	9926                	add	s2,s2,s1
    if (*pte & PTE_V)
    80001028:	00093483          	ld	s1,0(s2)
    8000102c:	0014f793          	andi	a5,s1,1
    80001030:	dfd5                	beqz	a5,80000fec <walk+0x36>
      pigtable = (pigtable_t)PTE2PA(*pte);
    80001032:	80a9                	srli	s1,s1,0xa
    80001034:	04b2                	slli	s1,s1,0xc
    80001036:	b7c5                	j	80001016 <walk+0x60>
    }
  }
  return &pigtable[PX(0, va)];
    80001038:	00c9d513          	srli	a0,s3,0xc
    8000103c:	1ff57513          	andi	a0,a0,511
    80001040:	050e                	slli	a0,a0,0x3
    80001042:	9526                	add	a0,a0,s1
}
    80001044:	70e2                	ld	ra,56(sp)
    80001046:	7442                	ld	s0,48(sp)
    80001048:	74a2                	ld	s1,40(sp)
    8000104a:	7902                	ld	s2,32(sp)
    8000104c:	69e2                	ld	s3,24(sp)
    8000104e:	6a42                	ld	s4,16(sp)
    80001050:	6aa2                	ld	s5,8(sp)
    80001052:	6b02                	ld	s6,0(sp)
    80001054:	6121                	addi	sp,sp,64
    80001056:	8082                	ret
        return 0;
    80001058:	4501                	li	a0,0
    8000105a:	b7ed                	j	80001044 <walk+0x8e>

000000008000105c <walkaddr>:
walkaddr(pigtable_t pigtable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if (va >= MAXVA)
    8000105c:	57fd                	li	a5,-1
    8000105e:	83e9                	srli	a5,a5,0x1a
    80001060:	00b7f463          	bgeu	a5,a1,80001068 <walkaddr+0xc>
    return 0;
    80001064:	4501                	li	a0,0
    return 0;
  if ((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80001066:	8082                	ret
{
    80001068:	1141                	addi	sp,sp,-16
    8000106a:	e406                	sd	ra,8(sp)
    8000106c:	e022                	sd	s0,0(sp)
    8000106e:	0800                	addi	s0,sp,16
  pte = walk(pigtable, va, 0);
    80001070:	4601                	li	a2,0
    80001072:	00000097          	auipc	ra,0x0
    80001076:	f44080e7          	jalr	-188(ra) # 80000fb6 <walk>
  if (pte == 0)
    8000107a:	c105                	beqz	a0,8000109a <walkaddr+0x3e>
  if ((*pte & PTE_V) == 0)
    8000107c:	611c                	ld	a5,0(a0)
  if ((*pte & PTE_U) == 0)
    8000107e:	0117f693          	andi	a3,a5,17
    80001082:	4745                	li	a4,17
    return 0;
    80001084:	4501                	li	a0,0
  if ((*pte & PTE_U) == 0)
    80001086:	00e68663          	beq	a3,a4,80001092 <walkaddr+0x36>
}
    8000108a:	60a2                	ld	ra,8(sp)
    8000108c:	6402                	ld	s0,0(sp)
    8000108e:	0141                	addi	sp,sp,16
    80001090:	8082                	ret
  pa = PTE2PA(*pte);
    80001092:	00a7d513          	srli	a0,a5,0xa
    80001096:	0532                	slli	a0,a0,0xc
  return pa;
    80001098:	bfcd                	j	8000108a <walkaddr+0x2e>
    return 0;
    8000109a:	4501                	li	a0,0
    8000109c:	b7fd                	j	8000108a <walkaddr+0x2e>

000000008000109e <mappigs>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be pig-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed pig-table pig.
int mappigs(pigtable_t pigtable, uint64 va, uint64 size, uint64 pa, int perm)
{
    8000109e:	715d                	addi	sp,sp,-80
    800010a0:	e486                	sd	ra,72(sp)
    800010a2:	e0a2                	sd	s0,64(sp)
    800010a4:	fc26                	sd	s1,56(sp)
    800010a6:	f84a                	sd	s2,48(sp)
    800010a8:	f44e                	sd	s3,40(sp)
    800010aa:	f052                	sd	s4,32(sp)
    800010ac:	ec56                	sd	s5,24(sp)
    800010ae:	e85a                	sd	s6,16(sp)
    800010b0:	e45e                	sd	s7,8(sp)
    800010b2:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if (size == 0)
    800010b4:	c639                	beqz	a2,80001102 <mappigs+0x64>
    800010b6:	8aaa                	mv	s5,a0
    800010b8:	8b3a                	mv	s6,a4
    panic("mappigs: size");

  a = PIGROUNDDOWN(va);
    800010ba:	77fd                	lui	a5,0xfffff
    800010bc:	00f5fa33          	and	s4,a1,a5
  last = PIGROUNDDOWN(va + size - 1);
    800010c0:	15fd                	addi	a1,a1,-1
    800010c2:	00c589b3          	add	s3,a1,a2
    800010c6:	00f9f9b3          	and	s3,s3,a5
  a = PIGROUNDDOWN(va);
    800010ca:	8952                	mv	s2,s4
    800010cc:	41468a33          	sub	s4,a3,s4
    if (*pte & PTE_V)                      // No?
      panic("mappigs: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if (a == last)
      break;
    a += PIGSIZE;
    800010d0:	6b85                	lui	s7,0x1
    800010d2:	012a04b3          	add	s1,s4,s2
    if ((pte = walk(pigtable, a, 1)) == 0) // Walk the table. Did we reach the end?
    800010d6:	4605                	li	a2,1
    800010d8:	85ca                	mv	a1,s2
    800010da:	8556                	mv	a0,s5
    800010dc:	00000097          	auipc	ra,0x0
    800010e0:	eda080e7          	jalr	-294(ra) # 80000fb6 <walk>
    800010e4:	cd1d                	beqz	a0,80001122 <mappigs+0x84>
    if (*pte & PTE_V)                      // No?
    800010e6:	611c                	ld	a5,0(a0)
    800010e8:	8b85                	andi	a5,a5,1
    800010ea:	e785                	bnez	a5,80001112 <mappigs+0x74>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800010ec:	80b1                	srli	s1,s1,0xc
    800010ee:	04aa                	slli	s1,s1,0xa
    800010f0:	0164e4b3          	or	s1,s1,s6
    800010f4:	0014e493          	ori	s1,s1,1
    800010f8:	e104                	sd	s1,0(a0)
    if (a == last)
    800010fa:	05390063          	beq	s2,s3,8000113a <mappigs+0x9c>
    a += PIGSIZE;
    800010fe:	995e                	add	s2,s2,s7
    if ((pte = walk(pigtable, a, 1)) == 0) // Walk the table. Did we reach the end?
    80001100:	bfc9                	j	800010d2 <mappigs+0x34>
    panic("mappigs: size");
    80001102:	00007517          	auipc	a0,0x7
    80001106:	fd650513          	addi	a0,a0,-42 # 800080d8 <digits+0x98>
    8000110a:	fffff097          	auipc	ra,0xfffff
    8000110e:	434080e7          	jalr	1076(ra) # 8000053e <panic>
      panic("mappigs: remap");
    80001112:	00007517          	auipc	a0,0x7
    80001116:	fd650513          	addi	a0,a0,-42 # 800080e8 <digits+0xa8>
    8000111a:	fffff097          	auipc	ra,0xfffff
    8000111e:	424080e7          	jalr	1060(ra) # 8000053e <panic>
      return -1;                           // Yes, so we fail.
    80001122:	557d                	li	a0,-1
    pa += PIGSIZE;
  }
  return 0;
}
    80001124:	60a6                	ld	ra,72(sp)
    80001126:	6406                	ld	s0,64(sp)
    80001128:	74e2                	ld	s1,56(sp)
    8000112a:	7942                	ld	s2,48(sp)
    8000112c:	79a2                	ld	s3,40(sp)
    8000112e:	7a02                	ld	s4,32(sp)
    80001130:	6ae2                	ld	s5,24(sp)
    80001132:	6b42                	ld	s6,16(sp)
    80001134:	6ba2                	ld	s7,8(sp)
    80001136:	6161                	addi	sp,sp,80
    80001138:	8082                	ret
  return 0;
    8000113a:	4501                	li	a0,0
    8000113c:	b7e5                	j	80001124 <mappigs+0x86>

000000008000113e <kvmmap>:
{
    8000113e:	1141                	addi	sp,sp,-16
    80001140:	e406                	sd	ra,8(sp)
    80001142:	e022                	sd	s0,0(sp)
    80001144:	0800                	addi	s0,sp,16
    80001146:	87b6                	mv	a5,a3
  if (mappigs(kpgtbl, va, sz, pa, perm) != 0)
    80001148:	86b2                	mv	a3,a2
    8000114a:	863e                	mv	a2,a5
    8000114c:	00000097          	auipc	ra,0x0
    80001150:	f52080e7          	jalr	-174(ra) # 8000109e <mappigs>
    80001154:	e509                	bnez	a0,8000115e <kvmmap+0x20>
}
    80001156:	60a2                	ld	ra,8(sp)
    80001158:	6402                	ld	s0,0(sp)
    8000115a:	0141                	addi	sp,sp,16
    8000115c:	8082                	ret
    panic("kvmmap");
    8000115e:	00007517          	auipc	a0,0x7
    80001162:	f9a50513          	addi	a0,a0,-102 # 800080f8 <digits+0xb8>
    80001166:	fffff097          	auipc	ra,0xfffff
    8000116a:	3d8080e7          	jalr	984(ra) # 8000053e <panic>

000000008000116e <kvmmake>:
{
    8000116e:	1101                	addi	sp,sp,-32
    80001170:	ec06                	sd	ra,24(sp)
    80001172:	e822                	sd	s0,16(sp)
    80001174:	e426                	sd	s1,8(sp)
    80001176:	e04a                	sd	s2,0(sp)
    80001178:	1000                	addi	s0,sp,32
  kpgtbl = (pigtable_t)kalloc();
    8000117a:	00000097          	auipc	ra,0x0
    8000117e:	96c080e7          	jalr	-1684(ra) # 80000ae6 <kalloc>
    80001182:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PIGSIZE);
    80001184:	6605                	lui	a2,0x1
    80001186:	4581                	li	a1,0
    80001188:	00000097          	auipc	ra,0x0
    8000118c:	b4a080e7          	jalr	-1206(ra) # 80000cd2 <memset>
  kvmmap(kpgtbl, UART0, UART0, PIGSIZE, PTE_R | PTE_W);
    80001190:	4719                	li	a4,6
    80001192:	6685                	lui	a3,0x1
    80001194:	10000637          	lui	a2,0x10000
    80001198:	100005b7          	lui	a1,0x10000
    8000119c:	8526                	mv	a0,s1
    8000119e:	00000097          	auipc	ra,0x0
    800011a2:	fa0080e7          	jalr	-96(ra) # 8000113e <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PIGSIZE, PTE_R | PTE_W);
    800011a6:	4719                	li	a4,6
    800011a8:	6685                	lui	a3,0x1
    800011aa:	10001637          	lui	a2,0x10001
    800011ae:	100015b7          	lui	a1,0x10001
    800011b2:	8526                	mv	a0,s1
    800011b4:	00000097          	auipc	ra,0x0
    800011b8:	f8a080e7          	jalr	-118(ra) # 8000113e <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    800011bc:	4719                	li	a4,6
    800011be:	004006b7          	lui	a3,0x400
    800011c2:	0c000637          	lui	a2,0xc000
    800011c6:	0c0005b7          	lui	a1,0xc000
    800011ca:	8526                	mv	a0,s1
    800011cc:	00000097          	auipc	ra,0x0
    800011d0:	f72080e7          	jalr	-142(ra) # 8000113e <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext - KERNBASE, PTE_R | PTE_X);
    800011d4:	00007917          	auipc	s2,0x7
    800011d8:	e2c90913          	addi	s2,s2,-468 # 80008000 <etext>
    800011dc:	4729                	li	a4,10
    800011de:	80007697          	auipc	a3,0x80007
    800011e2:	e2268693          	addi	a3,a3,-478 # 8000 <_entry-0x7fff8000>
    800011e6:	4605                	li	a2,1
    800011e8:	067e                	slli	a2,a2,0x1f
    800011ea:	85b2                	mv	a1,a2
    800011ec:	8526                	mv	a0,s1
    800011ee:	00000097          	auipc	ra,0x0
    800011f2:	f50080e7          	jalr	-176(ra) # 8000113e <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP - (uint64)etext, PTE_R | PTE_W);
    800011f6:	4719                	li	a4,6
    800011f8:	46c5                	li	a3,17
    800011fa:	06ee                	slli	a3,a3,0x1b
    800011fc:	412686b3          	sub	a3,a3,s2
    80001200:	864a                	mv	a2,s2
    80001202:	85ca                	mv	a1,s2
    80001204:	8526                	mv	a0,s1
    80001206:	00000097          	auipc	ra,0x0
    8000120a:	f38080e7          	jalr	-200(ra) # 8000113e <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PIGSIZE, PTE_R | PTE_X);
    8000120e:	4729                	li	a4,10
    80001210:	6685                	lui	a3,0x1
    80001212:	00006617          	auipc	a2,0x6
    80001216:	dee60613          	addi	a2,a2,-530 # 80007000 <_trampoline>
    8000121a:	040005b7          	lui	a1,0x4000
    8000121e:	15fd                	addi	a1,a1,-1
    80001220:	05b2                	slli	a1,a1,0xc
    80001222:	8526                	mv	a0,s1
    80001224:	00000097          	auipc	ra,0x0
    80001228:	f1a080e7          	jalr	-230(ra) # 8000113e <kvmmap>
  proc_mapstacks(kpgtbl);
    8000122c:	8526                	mv	a0,s1
    8000122e:	00000097          	auipc	ra,0x0
    80001232:	608080e7          	jalr	1544(ra) # 80001836 <proc_mapstacks>
}
    80001236:	8526                	mv	a0,s1
    80001238:	60e2                	ld	ra,24(sp)
    8000123a:	6442                	ld	s0,16(sp)
    8000123c:	64a2                	ld	s1,8(sp)
    8000123e:	6902                	ld	s2,0(sp)
    80001240:	6105                	addi	sp,sp,32
    80001242:	8082                	ret

0000000080001244 <kvminit>:
{
    80001244:	1141                	addi	sp,sp,-16
    80001246:	e406                	sd	ra,8(sp)
    80001248:	e022                	sd	s0,0(sp)
    8000124a:	0800                	addi	s0,sp,16
  kernel_pigtable = kvmmake();
    8000124c:	00000097          	auipc	ra,0x0
    80001250:	f22080e7          	jalr	-222(ra) # 8000116e <kvmmake>
    80001254:	00007797          	auipc	a5,0x7
    80001258:	66a7b623          	sd	a0,1644(a5) # 800088c0 <kernel_pigtable>
}
    8000125c:	60a2                	ld	ra,8(sp)
    8000125e:	6402                	ld	s0,0(sp)
    80001260:	0141                	addi	sp,sp,16
    80001262:	8082                	ret

0000000080001264 <uvmunmap>:

// Remove npigs of mappings starting from va. va must be
// pig-aligned. The mappings must exist.
// Optionally free the physical memory.
void uvmunmap(pigtable_t pigtable, uint64 va, uint64 npigs, int do_free)
{
    80001264:	715d                	addi	sp,sp,-80
    80001266:	e486                	sd	ra,72(sp)
    80001268:	e0a2                	sd	s0,64(sp)
    8000126a:	fc26                	sd	s1,56(sp)
    8000126c:	f84a                	sd	s2,48(sp)
    8000126e:	f44e                	sd	s3,40(sp)
    80001270:	f052                	sd	s4,32(sp)
    80001272:	ec56                	sd	s5,24(sp)
    80001274:	e85a                	sd	s6,16(sp)
    80001276:	e45e                	sd	s7,8(sp)
    80001278:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if ((va % PIGSIZE) != 0)
    8000127a:	03459793          	slli	a5,a1,0x34
    8000127e:	e795                	bnez	a5,800012aa <uvmunmap+0x46>
    80001280:	8a2a                	mv	s4,a0
    80001282:	892e                	mv	s2,a1
    80001284:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for (a = va; a < va + npigs * PIGSIZE; a += PIGSIZE)
    80001286:	0632                	slli	a2,a2,0xc
    80001288:	00b609b3          	add	s3,a2,a1
  {
    if ((pte = walk(pigtable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if ((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if (PTE_FLAGS(*pte) == PTE_V)
    8000128c:	4b85                	li	s7,1
  for (a = va; a < va + npigs * PIGSIZE; a += PIGSIZE)
    8000128e:	6b05                	lui	s6,0x1
    80001290:	0735e263          	bltu	a1,s3,800012f4 <uvmunmap+0x90>
      uint64 pa = PTE2PA(*pte);
      kfree((void *)pa);
    }
    *pte = 0;
  }
}
    80001294:	60a6                	ld	ra,72(sp)
    80001296:	6406                	ld	s0,64(sp)
    80001298:	74e2                	ld	s1,56(sp)
    8000129a:	7942                	ld	s2,48(sp)
    8000129c:	79a2                	ld	s3,40(sp)
    8000129e:	7a02                	ld	s4,32(sp)
    800012a0:	6ae2                	ld	s5,24(sp)
    800012a2:	6b42                	ld	s6,16(sp)
    800012a4:	6ba2                	ld	s7,8(sp)
    800012a6:	6161                	addi	sp,sp,80
    800012a8:	8082                	ret
    panic("uvmunmap: not aligned");
    800012aa:	00007517          	auipc	a0,0x7
    800012ae:	e5650513          	addi	a0,a0,-426 # 80008100 <digits+0xc0>
    800012b2:	fffff097          	auipc	ra,0xfffff
    800012b6:	28c080e7          	jalr	652(ra) # 8000053e <panic>
      panic("uvmunmap: walk");
    800012ba:	00007517          	auipc	a0,0x7
    800012be:	e5e50513          	addi	a0,a0,-418 # 80008118 <digits+0xd8>
    800012c2:	fffff097          	auipc	ra,0xfffff
    800012c6:	27c080e7          	jalr	636(ra) # 8000053e <panic>
      panic("uvmunmap: not mapped");
    800012ca:	00007517          	auipc	a0,0x7
    800012ce:	e5e50513          	addi	a0,a0,-418 # 80008128 <digits+0xe8>
    800012d2:	fffff097          	auipc	ra,0xfffff
    800012d6:	26c080e7          	jalr	620(ra) # 8000053e <panic>
      panic("uvmunmap: not a leaf");
    800012da:	00007517          	auipc	a0,0x7
    800012de:	e6650513          	addi	a0,a0,-410 # 80008140 <digits+0x100>
    800012e2:	fffff097          	auipc	ra,0xfffff
    800012e6:	25c080e7          	jalr	604(ra) # 8000053e <panic>
    *pte = 0;
    800012ea:	0004b023          	sd	zero,0(s1)
  for (a = va; a < va + npigs * PIGSIZE; a += PIGSIZE)
    800012ee:	995a                	add	s2,s2,s6
    800012f0:	fb3972e3          	bgeu	s2,s3,80001294 <uvmunmap+0x30>
    if ((pte = walk(pigtable, a, 0)) == 0)
    800012f4:	4601                	li	a2,0
    800012f6:	85ca                	mv	a1,s2
    800012f8:	8552                	mv	a0,s4
    800012fa:	00000097          	auipc	ra,0x0
    800012fe:	cbc080e7          	jalr	-836(ra) # 80000fb6 <walk>
    80001302:	84aa                	mv	s1,a0
    80001304:	d95d                	beqz	a0,800012ba <uvmunmap+0x56>
    if ((*pte & PTE_V) == 0)
    80001306:	6108                	ld	a0,0(a0)
    80001308:	00157793          	andi	a5,a0,1
    8000130c:	dfdd                	beqz	a5,800012ca <uvmunmap+0x66>
    if (PTE_FLAGS(*pte) == PTE_V)
    8000130e:	3ff57793          	andi	a5,a0,1023
    80001312:	fd7784e3          	beq	a5,s7,800012da <uvmunmap+0x76>
    if (do_free)
    80001316:	fc0a8ae3          	beqz	s5,800012ea <uvmunmap+0x86>
      uint64 pa = PTE2PA(*pte);
    8000131a:	8129                	srli	a0,a0,0xa
      kfree((void *)pa);
    8000131c:	0532                	slli	a0,a0,0xc
    8000131e:	fffff097          	auipc	ra,0xfffff
    80001322:	6cc080e7          	jalr	1740(ra) # 800009ea <kfree>
    80001326:	b7d1                	j	800012ea <uvmunmap+0x86>

0000000080001328 <uvmcreate>:

// create an empty user pig table.
// returns 0 if out of memory.
pigtable_t
uvmcreate()
{
    80001328:	1101                	addi	sp,sp,-32
    8000132a:	ec06                	sd	ra,24(sp)
    8000132c:	e822                	sd	s0,16(sp)
    8000132e:	e426                	sd	s1,8(sp)
    80001330:	1000                	addi	s0,sp,32
  pigtable_t pigtable;
  pigtable = (pigtable_t)kalloc();
    80001332:	fffff097          	auipc	ra,0xfffff
    80001336:	7b4080e7          	jalr	1972(ra) # 80000ae6 <kalloc>
    8000133a:	84aa                	mv	s1,a0
  if (pigtable == 0)
    8000133c:	c519                	beqz	a0,8000134a <uvmcreate+0x22>
    return 0;
  memset(pigtable, 0, PIGSIZE);
    8000133e:	6605                	lui	a2,0x1
    80001340:	4581                	li	a1,0
    80001342:	00000097          	auipc	ra,0x0
    80001346:	990080e7          	jalr	-1648(ra) # 80000cd2 <memset>
  return pigtable;
}
    8000134a:	8526                	mv	a0,s1
    8000134c:	60e2                	ld	ra,24(sp)
    8000134e:	6442                	ld	s0,16(sp)
    80001350:	64a2                	ld	s1,8(sp)
    80001352:	6105                	addi	sp,sp,32
    80001354:	8082                	ret

0000000080001356 <uvmfirst>:

// Load the user initcode into address 0 of pigtable,
// for the very first process.
// sz must be less than a pig.
void uvmfirst(pigtable_t pigtable, uchar *src, uint sz)
{
    80001356:	7179                	addi	sp,sp,-48
    80001358:	f406                	sd	ra,40(sp)
    8000135a:	f022                	sd	s0,32(sp)
    8000135c:	ec26                	sd	s1,24(sp)
    8000135e:	e84a                	sd	s2,16(sp)
    80001360:	e44e                	sd	s3,8(sp)
    80001362:	e052                	sd	s4,0(sp)
    80001364:	1800                	addi	s0,sp,48
  char *mem;

  if (sz >= PIGSIZE)
    80001366:	6785                	lui	a5,0x1
    80001368:	04f67863          	bgeu	a2,a5,800013b8 <uvmfirst+0x62>
    8000136c:	8a2a                	mv	s4,a0
    8000136e:	89ae                	mv	s3,a1
    80001370:	84b2                	mv	s1,a2
    panic("uvmfirst: more than a pig");
  mem = kalloc();
    80001372:	fffff097          	auipc	ra,0xfffff
    80001376:	774080e7          	jalr	1908(ra) # 80000ae6 <kalloc>
    8000137a:	892a                	mv	s2,a0
  memset(mem, 0, PIGSIZE);
    8000137c:	6605                	lui	a2,0x1
    8000137e:	4581                	li	a1,0
    80001380:	00000097          	auipc	ra,0x0
    80001384:	952080e7          	jalr	-1710(ra) # 80000cd2 <memset>
  mappigs(pigtable, 0, PIGSIZE, (uint64)mem, PTE_W | PTE_R | PTE_X | PTE_U);
    80001388:	4779                	li	a4,30
    8000138a:	86ca                	mv	a3,s2
    8000138c:	6605                	lui	a2,0x1
    8000138e:	4581                	li	a1,0
    80001390:	8552                	mv	a0,s4
    80001392:	00000097          	auipc	ra,0x0
    80001396:	d0c080e7          	jalr	-756(ra) # 8000109e <mappigs>
  memmove(mem, src, sz);
    8000139a:	8626                	mv	a2,s1
    8000139c:	85ce                	mv	a1,s3
    8000139e:	854a                	mv	a0,s2
    800013a0:	00000097          	auipc	ra,0x0
    800013a4:	98e080e7          	jalr	-1650(ra) # 80000d2e <memmove>
}
    800013a8:	70a2                	ld	ra,40(sp)
    800013aa:	7402                	ld	s0,32(sp)
    800013ac:	64e2                	ld	s1,24(sp)
    800013ae:	6942                	ld	s2,16(sp)
    800013b0:	69a2                	ld	s3,8(sp)
    800013b2:	6a02                	ld	s4,0(sp)
    800013b4:	6145                	addi	sp,sp,48
    800013b6:	8082                	ret
    panic("uvmfirst: more than a pig");
    800013b8:	00007517          	auipc	a0,0x7
    800013bc:	da050513          	addi	a0,a0,-608 # 80008158 <digits+0x118>
    800013c0:	fffff097          	auipc	ra,0xfffff
    800013c4:	17e080e7          	jalr	382(ra) # 8000053e <panic>

00000000800013c8 <uvmdealloc>:
// newsz.  oldsz and newsz need not be pig-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pigtable_t pigtable, uint64 oldsz, uint64 newsz)
{
    800013c8:	1101                	addi	sp,sp,-32
    800013ca:	ec06                	sd	ra,24(sp)
    800013cc:	e822                	sd	s0,16(sp)
    800013ce:	e426                	sd	s1,8(sp)
    800013d0:	1000                	addi	s0,sp,32
  if (newsz >= oldsz)
    return oldsz;
    800013d2:	84ae                	mv	s1,a1
  if (newsz >= oldsz)
    800013d4:	00b67d63          	bgeu	a2,a1,800013ee <uvmdealloc+0x26>
    800013d8:	84b2                	mv	s1,a2

  if (PIGROUNDUP(newsz) < PIGROUNDUP(oldsz))
    800013da:	6785                	lui	a5,0x1
    800013dc:	17fd                	addi	a5,a5,-1
    800013de:	00f60733          	add	a4,a2,a5
    800013e2:	767d                	lui	a2,0xfffff
    800013e4:	8f71                	and	a4,a4,a2
    800013e6:	97ae                	add	a5,a5,a1
    800013e8:	8ff1                	and	a5,a5,a2
    800013ea:	00f76863          	bltu	a4,a5,800013fa <uvmdealloc+0x32>
    int npigs = (PIGROUNDUP(oldsz) - PIGROUNDUP(newsz)) / PIGSIZE;
    uvmunmap(pigtable, PIGROUNDUP(newsz), npigs, 1);
  }

  return newsz;
}
    800013ee:	8526                	mv	a0,s1
    800013f0:	60e2                	ld	ra,24(sp)
    800013f2:	6442                	ld	s0,16(sp)
    800013f4:	64a2                	ld	s1,8(sp)
    800013f6:	6105                	addi	sp,sp,32
    800013f8:	8082                	ret
    int npigs = (PIGROUNDUP(oldsz) - PIGROUNDUP(newsz)) / PIGSIZE;
    800013fa:	8f99                	sub	a5,a5,a4
    800013fc:	83b1                	srli	a5,a5,0xc
    uvmunmap(pigtable, PIGROUNDUP(newsz), npigs, 1);
    800013fe:	4685                	li	a3,1
    80001400:	0007861b          	sext.w	a2,a5
    80001404:	85ba                	mv	a1,a4
    80001406:	00000097          	auipc	ra,0x0
    8000140a:	e5e080e7          	jalr	-418(ra) # 80001264 <uvmunmap>
    8000140e:	b7c5                	j	800013ee <uvmdealloc+0x26>

0000000080001410 <uvmalloc>:
  if (newsz < oldsz)
    80001410:	0ab66563          	bltu	a2,a1,800014ba <uvmalloc+0xaa>
{
    80001414:	7139                	addi	sp,sp,-64
    80001416:	fc06                	sd	ra,56(sp)
    80001418:	f822                	sd	s0,48(sp)
    8000141a:	f426                	sd	s1,40(sp)
    8000141c:	f04a                	sd	s2,32(sp)
    8000141e:	ec4e                	sd	s3,24(sp)
    80001420:	e852                	sd	s4,16(sp)
    80001422:	e456                	sd	s5,8(sp)
    80001424:	e05a                	sd	s6,0(sp)
    80001426:	0080                	addi	s0,sp,64
    80001428:	8aaa                	mv	s5,a0
    8000142a:	8a32                	mv	s4,a2
  oldsz = PIGROUNDUP(oldsz);
    8000142c:	6985                	lui	s3,0x1
    8000142e:	19fd                	addi	s3,s3,-1
    80001430:	95ce                	add	a1,a1,s3
    80001432:	79fd                	lui	s3,0xfffff
    80001434:	0135f9b3          	and	s3,a1,s3
  for (a = oldsz; a < newsz; a += PIGSIZE)
    80001438:	08c9f363          	bgeu	s3,a2,800014be <uvmalloc+0xae>
    8000143c:	894e                	mv	s2,s3
    if (mappigs(pigtable, a, PIGSIZE, (uint64)mem, PTE_R | PTE_U | xperm) != 0)
    8000143e:	0126eb13          	ori	s6,a3,18
    mem = kalloc();
    80001442:	fffff097          	auipc	ra,0xfffff
    80001446:	6a4080e7          	jalr	1700(ra) # 80000ae6 <kalloc>
    8000144a:	84aa                	mv	s1,a0
    if (mem == 0)
    8000144c:	c51d                	beqz	a0,8000147a <uvmalloc+0x6a>
    memset(mem, 0, PIGSIZE);
    8000144e:	6605                	lui	a2,0x1
    80001450:	4581                	li	a1,0
    80001452:	00000097          	auipc	ra,0x0
    80001456:	880080e7          	jalr	-1920(ra) # 80000cd2 <memset>
    if (mappigs(pigtable, a, PIGSIZE, (uint64)mem, PTE_R | PTE_U | xperm) != 0)
    8000145a:	875a                	mv	a4,s6
    8000145c:	86a6                	mv	a3,s1
    8000145e:	6605                	lui	a2,0x1
    80001460:	85ca                	mv	a1,s2
    80001462:	8556                	mv	a0,s5
    80001464:	00000097          	auipc	ra,0x0
    80001468:	c3a080e7          	jalr	-966(ra) # 8000109e <mappigs>
    8000146c:	e90d                	bnez	a0,8000149e <uvmalloc+0x8e>
  for (a = oldsz; a < newsz; a += PIGSIZE)
    8000146e:	6785                	lui	a5,0x1
    80001470:	993e                	add	s2,s2,a5
    80001472:	fd4968e3          	bltu	s2,s4,80001442 <uvmalloc+0x32>
  return newsz;
    80001476:	8552                	mv	a0,s4
    80001478:	a809                	j	8000148a <uvmalloc+0x7a>
      uvmdealloc(pigtable, a, oldsz);
    8000147a:	864e                	mv	a2,s3
    8000147c:	85ca                	mv	a1,s2
    8000147e:	8556                	mv	a0,s5
    80001480:	00000097          	auipc	ra,0x0
    80001484:	f48080e7          	jalr	-184(ra) # 800013c8 <uvmdealloc>
      return 0;
    80001488:	4501                	li	a0,0
}
    8000148a:	70e2                	ld	ra,56(sp)
    8000148c:	7442                	ld	s0,48(sp)
    8000148e:	74a2                	ld	s1,40(sp)
    80001490:	7902                	ld	s2,32(sp)
    80001492:	69e2                	ld	s3,24(sp)
    80001494:	6a42                	ld	s4,16(sp)
    80001496:	6aa2                	ld	s5,8(sp)
    80001498:	6b02                	ld	s6,0(sp)
    8000149a:	6121                	addi	sp,sp,64
    8000149c:	8082                	ret
      kfree(mem);
    8000149e:	8526                	mv	a0,s1
    800014a0:	fffff097          	auipc	ra,0xfffff
    800014a4:	54a080e7          	jalr	1354(ra) # 800009ea <kfree>
      uvmdealloc(pigtable, a, oldsz);
    800014a8:	864e                	mv	a2,s3
    800014aa:	85ca                	mv	a1,s2
    800014ac:	8556                	mv	a0,s5
    800014ae:	00000097          	auipc	ra,0x0
    800014b2:	f1a080e7          	jalr	-230(ra) # 800013c8 <uvmdealloc>
      return 0;
    800014b6:	4501                	li	a0,0
    800014b8:	bfc9                	j	8000148a <uvmalloc+0x7a>
    return oldsz;
    800014ba:	852e                	mv	a0,a1
}
    800014bc:	8082                	ret
  return newsz;
    800014be:	8532                	mv	a0,a2
    800014c0:	b7e9                	j	8000148a <uvmalloc+0x7a>

00000000800014c2 <freewalk>:

// Recursively free pig-table pigs.
// All leaf mappings must already have been removed.
void freewalk(pigtable_t pigtable)
{
    800014c2:	7179                	addi	sp,sp,-48
    800014c4:	f406                	sd	ra,40(sp)
    800014c6:	f022                	sd	s0,32(sp)
    800014c8:	ec26                	sd	s1,24(sp)
    800014ca:	e84a                	sd	s2,16(sp)
    800014cc:	e44e                	sd	s3,8(sp)
    800014ce:	e052                	sd	s4,0(sp)
    800014d0:	1800                	addi	s0,sp,48
    800014d2:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a pig table.
  for (int i = 0; i < 512; i++)
    800014d4:	84aa                	mv	s1,a0
    800014d6:	6905                	lui	s2,0x1
    800014d8:	992a                	add	s2,s2,a0
  {
    pte_t pte = pigtable[i];
    if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
    800014da:	4985                	li	s3,1
    800014dc:	a821                	j	800014f4 <freewalk+0x32>
    {
      // this PTE points to a lower-level pig table.
      uint64 child = PTE2PA(pte);
    800014de:	8129                	srli	a0,a0,0xa
      freewalk((pigtable_t)child);
    800014e0:	0532                	slli	a0,a0,0xc
    800014e2:	00000097          	auipc	ra,0x0
    800014e6:	fe0080e7          	jalr	-32(ra) # 800014c2 <freewalk>
      pigtable[i] = 0;
    800014ea:	0004b023          	sd	zero,0(s1)
  for (int i = 0; i < 512; i++)
    800014ee:	04a1                	addi	s1,s1,8
    800014f0:	03248163          	beq	s1,s2,80001512 <freewalk+0x50>
    pte_t pte = pigtable[i];
    800014f4:	6088                	ld	a0,0(s1)
    if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
    800014f6:	00f57793          	andi	a5,a0,15
    800014fa:	ff3782e3          	beq	a5,s3,800014de <freewalk+0x1c>
    }
    else if (pte & PTE_V)
    800014fe:	8905                	andi	a0,a0,1
    80001500:	d57d                	beqz	a0,800014ee <freewalk+0x2c>
    {
      panic("freewalk: leaf");
    80001502:	00007517          	auipc	a0,0x7
    80001506:	c7650513          	addi	a0,a0,-906 # 80008178 <digits+0x138>
    8000150a:	fffff097          	auipc	ra,0xfffff
    8000150e:	034080e7          	jalr	52(ra) # 8000053e <panic>
    }
  }
  kfree((void *)pigtable);
    80001512:	8552                	mv	a0,s4
    80001514:	fffff097          	auipc	ra,0xfffff
    80001518:	4d6080e7          	jalr	1238(ra) # 800009ea <kfree>
}
    8000151c:	70a2                	ld	ra,40(sp)
    8000151e:	7402                	ld	s0,32(sp)
    80001520:	64e2                	ld	s1,24(sp)
    80001522:	6942                	ld	s2,16(sp)
    80001524:	69a2                	ld	s3,8(sp)
    80001526:	6a02                	ld	s4,0(sp)
    80001528:	6145                	addi	sp,sp,48
    8000152a:	8082                	ret

000000008000152c <uvmfree>:

// Free user memory pigs,
// then free pig-table pigs.
void uvmfree(pigtable_t pigtable, uint64 sz)
{
    8000152c:	1101                	addi	sp,sp,-32
    8000152e:	ec06                	sd	ra,24(sp)
    80001530:	e822                	sd	s0,16(sp)
    80001532:	e426                	sd	s1,8(sp)
    80001534:	1000                	addi	s0,sp,32
    80001536:	84aa                	mv	s1,a0
  if (sz > 0)
    80001538:	e999                	bnez	a1,8000154e <uvmfree+0x22>
    uvmunmap(pigtable, 0, PIGROUNDUP(sz) / PIGSIZE, 1);
  freewalk(pigtable);
    8000153a:	8526                	mv	a0,s1
    8000153c:	00000097          	auipc	ra,0x0
    80001540:	f86080e7          	jalr	-122(ra) # 800014c2 <freewalk>
}
    80001544:	60e2                	ld	ra,24(sp)
    80001546:	6442                	ld	s0,16(sp)
    80001548:	64a2                	ld	s1,8(sp)
    8000154a:	6105                	addi	sp,sp,32
    8000154c:	8082                	ret
    uvmunmap(pigtable, 0, PIGROUNDUP(sz) / PIGSIZE, 1);
    8000154e:	6605                	lui	a2,0x1
    80001550:	167d                	addi	a2,a2,-1
    80001552:	962e                	add	a2,a2,a1
    80001554:	4685                	li	a3,1
    80001556:	8231                	srli	a2,a2,0xc
    80001558:	4581                	li	a1,0
    8000155a:	00000097          	auipc	ra,0x0
    8000155e:	d0a080e7          	jalr	-758(ra) # 80001264 <uvmunmap>
    80001562:	bfe1                	j	8000153a <uvmfree+0xe>

0000000080001564 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for (i = 0; i < sz; i += PIGSIZE)
    80001564:	c679                	beqz	a2,80001632 <uvmcopy+0xce>
{
    80001566:	715d                	addi	sp,sp,-80
    80001568:	e486                	sd	ra,72(sp)
    8000156a:	e0a2                	sd	s0,64(sp)
    8000156c:	fc26                	sd	s1,56(sp)
    8000156e:	f84a                	sd	s2,48(sp)
    80001570:	f44e                	sd	s3,40(sp)
    80001572:	f052                	sd	s4,32(sp)
    80001574:	ec56                	sd	s5,24(sp)
    80001576:	e85a                	sd	s6,16(sp)
    80001578:	e45e                	sd	s7,8(sp)
    8000157a:	0880                	addi	s0,sp,80
    8000157c:	8b2a                	mv	s6,a0
    8000157e:	8aae                	mv	s5,a1
    80001580:	8a32                	mv	s4,a2
  for (i = 0; i < sz; i += PIGSIZE)
    80001582:	4981                	li	s3,0
  {
    if ((pte = walk(old, i, 0)) == 0)
    80001584:	4601                	li	a2,0
    80001586:	85ce                	mv	a1,s3
    80001588:	855a                	mv	a0,s6
    8000158a:	00000097          	auipc	ra,0x0
    8000158e:	a2c080e7          	jalr	-1492(ra) # 80000fb6 <walk>
    80001592:	c531                	beqz	a0,800015de <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if ((*pte & PTE_V) == 0)
    80001594:	6118                	ld	a4,0(a0)
    80001596:	00177793          	andi	a5,a4,1
    8000159a:	cbb1                	beqz	a5,800015ee <uvmcopy+0x8a>
      panic("uvmcopy: pig not present");
    pa = PTE2PA(*pte);
    8000159c:	00a75593          	srli	a1,a4,0xa
    800015a0:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    800015a4:	3ff77493          	andi	s1,a4,1023
    if ((mem = kalloc()) == 0)
    800015a8:	fffff097          	auipc	ra,0xfffff
    800015ac:	53e080e7          	jalr	1342(ra) # 80000ae6 <kalloc>
    800015b0:	892a                	mv	s2,a0
    800015b2:	c939                	beqz	a0,80001608 <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char *)pa, PIGSIZE);
    800015b4:	6605                	lui	a2,0x1
    800015b6:	85de                	mv	a1,s7
    800015b8:	fffff097          	auipc	ra,0xfffff
    800015bc:	776080e7          	jalr	1910(ra) # 80000d2e <memmove>
    if (mappigs(new, i, PIGSIZE, (uint64)mem, flags) != 0)
    800015c0:	8726                	mv	a4,s1
    800015c2:	86ca                	mv	a3,s2
    800015c4:	6605                	lui	a2,0x1
    800015c6:	85ce                	mv	a1,s3
    800015c8:	8556                	mv	a0,s5
    800015ca:	00000097          	auipc	ra,0x0
    800015ce:	ad4080e7          	jalr	-1324(ra) # 8000109e <mappigs>
    800015d2:	e515                	bnez	a0,800015fe <uvmcopy+0x9a>
  for (i = 0; i < sz; i += PIGSIZE)
    800015d4:	6785                	lui	a5,0x1
    800015d6:	99be                	add	s3,s3,a5
    800015d8:	fb49e6e3          	bltu	s3,s4,80001584 <uvmcopy+0x20>
    800015dc:	a081                	j	8000161c <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    800015de:	00007517          	auipc	a0,0x7
    800015e2:	baa50513          	addi	a0,a0,-1110 # 80008188 <digits+0x148>
    800015e6:	fffff097          	auipc	ra,0xfffff
    800015ea:	f58080e7          	jalr	-168(ra) # 8000053e <panic>
      panic("uvmcopy: pig not present");
    800015ee:	00007517          	auipc	a0,0x7
    800015f2:	bba50513          	addi	a0,a0,-1094 # 800081a8 <digits+0x168>
    800015f6:	fffff097          	auipc	ra,0xfffff
    800015fa:	f48080e7          	jalr	-184(ra) # 8000053e <panic>
    {
      kfree(mem);
    800015fe:	854a                	mv	a0,s2
    80001600:	fffff097          	auipc	ra,0xfffff
    80001604:	3ea080e7          	jalr	1002(ra) # 800009ea <kfree>
    }
  }
  return 0;

err:
  uvmunmap(new, 0, i / PIGSIZE, 1);
    80001608:	4685                	li	a3,1
    8000160a:	00c9d613          	srli	a2,s3,0xc
    8000160e:	4581                	li	a1,0
    80001610:	8556                	mv	a0,s5
    80001612:	00000097          	auipc	ra,0x0
    80001616:	c52080e7          	jalr	-942(ra) # 80001264 <uvmunmap>
  return -1;
    8000161a:	557d                	li	a0,-1
}
    8000161c:	60a6                	ld	ra,72(sp)
    8000161e:	6406                	ld	s0,64(sp)
    80001620:	74e2                	ld	s1,56(sp)
    80001622:	7942                	ld	s2,48(sp)
    80001624:	79a2                	ld	s3,40(sp)
    80001626:	7a02                	ld	s4,32(sp)
    80001628:	6ae2                	ld	s5,24(sp)
    8000162a:	6b42                	ld	s6,16(sp)
    8000162c:	6ba2                	ld	s7,8(sp)
    8000162e:	6161                	addi	sp,sp,80
    80001630:	8082                	ret
  return 0;
    80001632:	4501                	li	a0,0
}
    80001634:	8082                	ret

0000000080001636 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard pig.
void uvmclear(pigtable_t pigtable, uint64 va)
{
    80001636:	1141                	addi	sp,sp,-16
    80001638:	e406                	sd	ra,8(sp)
    8000163a:	e022                	sd	s0,0(sp)
    8000163c:	0800                	addi	s0,sp,16
  pte_t *pte;

  pte = walk(pigtable, va, 0);
    8000163e:	4601                	li	a2,0
    80001640:	00000097          	auipc	ra,0x0
    80001644:	976080e7          	jalr	-1674(ra) # 80000fb6 <walk>
  if (pte == 0)
    80001648:	c901                	beqz	a0,80001658 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    8000164a:	611c                	ld	a5,0(a0)
    8000164c:	9bbd                	andi	a5,a5,-17
    8000164e:	e11c                	sd	a5,0(a0)
}
    80001650:	60a2                	ld	ra,8(sp)
    80001652:	6402                	ld	s0,0(sp)
    80001654:	0141                	addi	sp,sp,16
    80001656:	8082                	ret
    panic("uvmclear");
    80001658:	00007517          	auipc	a0,0x7
    8000165c:	b7050513          	addi	a0,a0,-1168 # 800081c8 <digits+0x188>
    80001660:	fffff097          	auipc	ra,0xfffff
    80001664:	ede080e7          	jalr	-290(ra) # 8000053e <panic>

0000000080001668 <copyout>:
// Return 0 on success, -1 on error.
int copyout(pigtable_t pigtable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while (len > 0)
    80001668:	c6bd                	beqz	a3,800016d6 <copyout+0x6e>
{
    8000166a:	715d                	addi	sp,sp,-80
    8000166c:	e486                	sd	ra,72(sp)
    8000166e:	e0a2                	sd	s0,64(sp)
    80001670:	fc26                	sd	s1,56(sp)
    80001672:	f84a                	sd	s2,48(sp)
    80001674:	f44e                	sd	s3,40(sp)
    80001676:	f052                	sd	s4,32(sp)
    80001678:	ec56                	sd	s5,24(sp)
    8000167a:	e85a                	sd	s6,16(sp)
    8000167c:	e45e                	sd	s7,8(sp)
    8000167e:	e062                	sd	s8,0(sp)
    80001680:	0880                	addi	s0,sp,80
    80001682:	8b2a                	mv	s6,a0
    80001684:	8c2e                	mv	s8,a1
    80001686:	8a32                	mv	s4,a2
    80001688:	89b6                	mv	s3,a3
  {
    va0 = PIGROUNDDOWN(dstva);
    8000168a:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pigtable, va0);
    if (pa0 == 0)
      return -1;
    n = PIGSIZE - (dstva - va0);
    8000168c:	6a85                	lui	s5,0x1
    8000168e:	a015                	j	800016b2 <copyout+0x4a>
    if (n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80001690:	9562                	add	a0,a0,s8
    80001692:	0004861b          	sext.w	a2,s1
    80001696:	85d2                	mv	a1,s4
    80001698:	41250533          	sub	a0,a0,s2
    8000169c:	fffff097          	auipc	ra,0xfffff
    800016a0:	692080e7          	jalr	1682(ra) # 80000d2e <memmove>

    len -= n;
    800016a4:	409989b3          	sub	s3,s3,s1
    src += n;
    800016a8:	9a26                	add	s4,s4,s1
    dstva = va0 + PIGSIZE;
    800016aa:	01590c33          	add	s8,s2,s5
  while (len > 0)
    800016ae:	02098263          	beqz	s3,800016d2 <copyout+0x6a>
    va0 = PIGROUNDDOWN(dstva);
    800016b2:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pigtable, va0);
    800016b6:	85ca                	mv	a1,s2
    800016b8:	855a                	mv	a0,s6
    800016ba:	00000097          	auipc	ra,0x0
    800016be:	9a2080e7          	jalr	-1630(ra) # 8000105c <walkaddr>
    if (pa0 == 0)
    800016c2:	cd01                	beqz	a0,800016da <copyout+0x72>
    n = PIGSIZE - (dstva - va0);
    800016c4:	418904b3          	sub	s1,s2,s8
    800016c8:	94d6                	add	s1,s1,s5
    if (n > len)
    800016ca:	fc99f3e3          	bgeu	s3,s1,80001690 <copyout+0x28>
    800016ce:	84ce                	mv	s1,s3
    800016d0:	b7c1                	j	80001690 <copyout+0x28>
  }
  return 0;
    800016d2:	4501                	li	a0,0
    800016d4:	a021                	j	800016dc <copyout+0x74>
    800016d6:	4501                	li	a0,0
}
    800016d8:	8082                	ret
      return -1;
    800016da:	557d                	li	a0,-1
}
    800016dc:	60a6                	ld	ra,72(sp)
    800016de:	6406                	ld	s0,64(sp)
    800016e0:	74e2                	ld	s1,56(sp)
    800016e2:	7942                	ld	s2,48(sp)
    800016e4:	79a2                	ld	s3,40(sp)
    800016e6:	7a02                	ld	s4,32(sp)
    800016e8:	6ae2                	ld	s5,24(sp)
    800016ea:	6b42                	ld	s6,16(sp)
    800016ec:	6ba2                	ld	s7,8(sp)
    800016ee:	6c02                	ld	s8,0(sp)
    800016f0:	6161                	addi	sp,sp,80
    800016f2:	8082                	ret

00000000800016f4 <copyin>:
// Return 0 on success, -1 on error.
int copyin(pigtable_t pigtable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while (len > 0)
    800016f4:	caa5                	beqz	a3,80001764 <copyin+0x70>
{
    800016f6:	715d                	addi	sp,sp,-80
    800016f8:	e486                	sd	ra,72(sp)
    800016fa:	e0a2                	sd	s0,64(sp)
    800016fc:	fc26                	sd	s1,56(sp)
    800016fe:	f84a                	sd	s2,48(sp)
    80001700:	f44e                	sd	s3,40(sp)
    80001702:	f052                	sd	s4,32(sp)
    80001704:	ec56                	sd	s5,24(sp)
    80001706:	e85a                	sd	s6,16(sp)
    80001708:	e45e                	sd	s7,8(sp)
    8000170a:	e062                	sd	s8,0(sp)
    8000170c:	0880                	addi	s0,sp,80
    8000170e:	8b2a                	mv	s6,a0
    80001710:	8a2e                	mv	s4,a1
    80001712:	8c32                	mv	s8,a2
    80001714:	89b6                	mv	s3,a3
  {
    va0 = PIGROUNDDOWN(srcva);
    80001716:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pigtable, va0);
    if (pa0 == 0)
      return -1;
    n = PIGSIZE - (srcva - va0);
    80001718:	6a85                	lui	s5,0x1
    8000171a:	a01d                	j	80001740 <copyin+0x4c>
    if (n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    8000171c:	018505b3          	add	a1,a0,s8
    80001720:	0004861b          	sext.w	a2,s1
    80001724:	412585b3          	sub	a1,a1,s2
    80001728:	8552                	mv	a0,s4
    8000172a:	fffff097          	auipc	ra,0xfffff
    8000172e:	604080e7          	jalr	1540(ra) # 80000d2e <memmove>

    len -= n;
    80001732:	409989b3          	sub	s3,s3,s1
    dst += n;
    80001736:	9a26                	add	s4,s4,s1
    srcva = va0 + PIGSIZE;
    80001738:	01590c33          	add	s8,s2,s5
  while (len > 0)
    8000173c:	02098263          	beqz	s3,80001760 <copyin+0x6c>
    va0 = PIGROUNDDOWN(srcva);
    80001740:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pigtable, va0);
    80001744:	85ca                	mv	a1,s2
    80001746:	855a                	mv	a0,s6
    80001748:	00000097          	auipc	ra,0x0
    8000174c:	914080e7          	jalr	-1772(ra) # 8000105c <walkaddr>
    if (pa0 == 0)
    80001750:	cd01                	beqz	a0,80001768 <copyin+0x74>
    n = PIGSIZE - (srcva - va0);
    80001752:	418904b3          	sub	s1,s2,s8
    80001756:	94d6                	add	s1,s1,s5
    if (n > len)
    80001758:	fc99f2e3          	bgeu	s3,s1,8000171c <copyin+0x28>
    8000175c:	84ce                	mv	s1,s3
    8000175e:	bf7d                	j	8000171c <copyin+0x28>
  }
  return 0;
    80001760:	4501                	li	a0,0
    80001762:	a021                	j	8000176a <copyin+0x76>
    80001764:	4501                	li	a0,0
}
    80001766:	8082                	ret
      return -1;
    80001768:	557d                	li	a0,-1
}
    8000176a:	60a6                	ld	ra,72(sp)
    8000176c:	6406                	ld	s0,64(sp)
    8000176e:	74e2                	ld	s1,56(sp)
    80001770:	7942                	ld	s2,48(sp)
    80001772:	79a2                	ld	s3,40(sp)
    80001774:	7a02                	ld	s4,32(sp)
    80001776:	6ae2                	ld	s5,24(sp)
    80001778:	6b42                	ld	s6,16(sp)
    8000177a:	6ba2                	ld	s7,8(sp)
    8000177c:	6c02                	ld	s8,0(sp)
    8000177e:	6161                	addi	sp,sp,80
    80001780:	8082                	ret

0000000080001782 <copyinstr>:
int copyinstr(pigtable_t pigtable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while (got_null == 0 && max > 0)
    80001782:	c6c5                	beqz	a3,8000182a <copyinstr+0xa8>
{
    80001784:	715d                	addi	sp,sp,-80
    80001786:	e486                	sd	ra,72(sp)
    80001788:	e0a2                	sd	s0,64(sp)
    8000178a:	fc26                	sd	s1,56(sp)
    8000178c:	f84a                	sd	s2,48(sp)
    8000178e:	f44e                	sd	s3,40(sp)
    80001790:	f052                	sd	s4,32(sp)
    80001792:	ec56                	sd	s5,24(sp)
    80001794:	e85a                	sd	s6,16(sp)
    80001796:	e45e                	sd	s7,8(sp)
    80001798:	0880                	addi	s0,sp,80
    8000179a:	8a2a                	mv	s4,a0
    8000179c:	8b2e                	mv	s6,a1
    8000179e:	8bb2                	mv	s7,a2
    800017a0:	84b6                	mv	s1,a3
  {
    va0 = PIGROUNDDOWN(srcva);
    800017a2:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pigtable, va0);
    if (pa0 == 0)
      return -1;
    n = PIGSIZE - (srcva - va0);
    800017a4:	6985                	lui	s3,0x1
    800017a6:	a035                	j	800017d2 <copyinstr+0x50>
    char *p = (char *)(pa0 + (srcva - va0));
    while (n > 0)
    {
      if (*p == '\0')
      {
        *dst = '\0';
    800017a8:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    800017ac:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PIGSIZE;
  }
  if (got_null)
    800017ae:	0017b793          	seqz	a5,a5
    800017b2:	40f00533          	neg	a0,a5
  }
  else
  {
    return -1;
  }
}
    800017b6:	60a6                	ld	ra,72(sp)
    800017b8:	6406                	ld	s0,64(sp)
    800017ba:	74e2                	ld	s1,56(sp)
    800017bc:	7942                	ld	s2,48(sp)
    800017be:	79a2                	ld	s3,40(sp)
    800017c0:	7a02                	ld	s4,32(sp)
    800017c2:	6ae2                	ld	s5,24(sp)
    800017c4:	6b42                	ld	s6,16(sp)
    800017c6:	6ba2                	ld	s7,8(sp)
    800017c8:	6161                	addi	sp,sp,80
    800017ca:	8082                	ret
    srcva = va0 + PIGSIZE;
    800017cc:	01390bb3          	add	s7,s2,s3
  while (got_null == 0 && max > 0)
    800017d0:	c8a9                	beqz	s1,80001822 <copyinstr+0xa0>
    va0 = PIGROUNDDOWN(srcva);
    800017d2:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pigtable, va0);
    800017d6:	85ca                	mv	a1,s2
    800017d8:	8552                	mv	a0,s4
    800017da:	00000097          	auipc	ra,0x0
    800017de:	882080e7          	jalr	-1918(ra) # 8000105c <walkaddr>
    if (pa0 == 0)
    800017e2:	c131                	beqz	a0,80001826 <copyinstr+0xa4>
    n = PIGSIZE - (srcva - va0);
    800017e4:	41790833          	sub	a6,s2,s7
    800017e8:	984e                	add	a6,a6,s3
    if (n > max)
    800017ea:	0104f363          	bgeu	s1,a6,800017f0 <copyinstr+0x6e>
    800017ee:	8826                	mv	a6,s1
    char *p = (char *)(pa0 + (srcva - va0));
    800017f0:	955e                	add	a0,a0,s7
    800017f2:	41250533          	sub	a0,a0,s2
    while (n > 0)
    800017f6:	fc080be3          	beqz	a6,800017cc <copyinstr+0x4a>
    800017fa:	985a                	add	a6,a6,s6
    800017fc:	87da                	mv	a5,s6
      if (*p == '\0')
    800017fe:	41650633          	sub	a2,a0,s6
    80001802:	14fd                	addi	s1,s1,-1
    80001804:	9b26                	add	s6,s6,s1
    80001806:	00f60733          	add	a4,a2,a5
    8000180a:	00074703          	lbu	a4,0(a4)
    8000180e:	df49                	beqz	a4,800017a8 <copyinstr+0x26>
        *dst = *p;
    80001810:	00e78023          	sb	a4,0(a5)
      --max;
    80001814:	40fb04b3          	sub	s1,s6,a5
      dst++;
    80001818:	0785                	addi	a5,a5,1
    while (n > 0)
    8000181a:	ff0796e3          	bne	a5,a6,80001806 <copyinstr+0x84>
      dst++;
    8000181e:	8b42                	mv	s6,a6
    80001820:	b775                	j	800017cc <copyinstr+0x4a>
    80001822:	4781                	li	a5,0
    80001824:	b769                	j	800017ae <copyinstr+0x2c>
      return -1;
    80001826:	557d                	li	a0,-1
    80001828:	b779                	j	800017b6 <copyinstr+0x34>
  int got_null = 0;
    8000182a:	4781                	li	a5,0
  if (got_null)
    8000182c:	0017b793          	seqz	a5,a5
    80001830:	40f00533          	neg	a0,a5
}
    80001834:	8082                	ret

0000000080001836 <proc_mapstacks>:

// Allocate a pig for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard pig.
void proc_mapstacks(pigtable_t kpgtbl)
{
    80001836:	7139                	addi	sp,sp,-64
    80001838:	fc06                	sd	ra,56(sp)
    8000183a:	f822                	sd	s0,48(sp)
    8000183c:	f426                	sd	s1,40(sp)
    8000183e:	f04a                	sd	s2,32(sp)
    80001840:	ec4e                	sd	s3,24(sp)
    80001842:	e852                	sd	s4,16(sp)
    80001844:	e456                	sd	s5,8(sp)
    80001846:	e05a                	sd	s6,0(sp)
    80001848:	0080                	addi	s0,sp,64
    8000184a:	89aa                	mv	s3,a0
  struct proc *p;

  for (p = proc; p < &proc[NPROC]; p++)
    8000184c:	0000f497          	auipc	s1,0xf
    80001850:	72448493          	addi	s1,s1,1828 # 80010f70 <proc>
  {
    char *pa = kalloc();
    if (pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int)(p - proc));
    80001854:	8b26                	mv	s6,s1
    80001856:	00006a97          	auipc	s5,0x6
    8000185a:	7aaa8a93          	addi	s5,s5,1962 # 80008000 <etext>
    8000185e:	04000937          	lui	s2,0x4000
    80001862:	197d                	addi	s2,s2,-1
    80001864:	0932                	slli	s2,s2,0xc
  for (p = proc; p < &proc[NPROC]; p++)
    80001866:	00015a17          	auipc	s4,0x15
    8000186a:	10aa0a13          	addi	s4,s4,266 # 80016970 <tickslock>
    char *pa = kalloc();
    8000186e:	fffff097          	auipc	ra,0xfffff
    80001872:	278080e7          	jalr	632(ra) # 80000ae6 <kalloc>
    80001876:	862a                	mv	a2,a0
    if (pa == 0)
    80001878:	c131                	beqz	a0,800018bc <proc_mapstacks+0x86>
    uint64 va = KSTACK((int)(p - proc));
    8000187a:	416485b3          	sub	a1,s1,s6
    8000187e:	858d                	srai	a1,a1,0x3
    80001880:	000ab783          	ld	a5,0(s5)
    80001884:	02f585b3          	mul	a1,a1,a5
    80001888:	2585                	addiw	a1,a1,1
    8000188a:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PIGSIZE, PTE_R | PTE_W);
    8000188e:	4719                	li	a4,6
    80001890:	6685                	lui	a3,0x1
    80001892:	40b905b3          	sub	a1,s2,a1
    80001896:	854e                	mv	a0,s3
    80001898:	00000097          	auipc	ra,0x0
    8000189c:	8a6080e7          	jalr	-1882(ra) # 8000113e <kvmmap>
  for (p = proc; p < &proc[NPROC]; p++)
    800018a0:	16848493          	addi	s1,s1,360
    800018a4:	fd4495e3          	bne	s1,s4,8000186e <proc_mapstacks+0x38>
  }
}
    800018a8:	70e2                	ld	ra,56(sp)
    800018aa:	7442                	ld	s0,48(sp)
    800018ac:	74a2                	ld	s1,40(sp)
    800018ae:	7902                	ld	s2,32(sp)
    800018b0:	69e2                	ld	s3,24(sp)
    800018b2:	6a42                	ld	s4,16(sp)
    800018b4:	6aa2                	ld	s5,8(sp)
    800018b6:	6b02                	ld	s6,0(sp)
    800018b8:	6121                	addi	sp,sp,64
    800018ba:	8082                	ret
      panic("kalloc");
    800018bc:	00007517          	auipc	a0,0x7
    800018c0:	91c50513          	addi	a0,a0,-1764 # 800081d8 <digits+0x198>
    800018c4:	fffff097          	auipc	ra,0xfffff
    800018c8:	c7a080e7          	jalr	-902(ra) # 8000053e <panic>

00000000800018cc <procinit>:

// initialize the proc table.
void procinit(void)
{
    800018cc:	7139                	addi	sp,sp,-64
    800018ce:	fc06                	sd	ra,56(sp)
    800018d0:	f822                	sd	s0,48(sp)
    800018d2:	f426                	sd	s1,40(sp)
    800018d4:	f04a                	sd	s2,32(sp)
    800018d6:	ec4e                	sd	s3,24(sp)
    800018d8:	e852                	sd	s4,16(sp)
    800018da:	e456                	sd	s5,8(sp)
    800018dc:	e05a                	sd	s6,0(sp)
    800018de:	0080                	addi	s0,sp,64
  struct proc *p;

  initlock(&pid_lock, "nextpid");
    800018e0:	00007597          	auipc	a1,0x7
    800018e4:	90058593          	addi	a1,a1,-1792 # 800081e0 <digits+0x1a0>
    800018e8:	0000f517          	auipc	a0,0xf
    800018ec:	25850513          	addi	a0,a0,600 # 80010b40 <pid_lock>
    800018f0:	fffff097          	auipc	ra,0xfffff
    800018f4:	256080e7          	jalr	598(ra) # 80000b46 <initlock>
  initlock(&wait_lock, "wait_lock");
    800018f8:	00007597          	auipc	a1,0x7
    800018fc:	8f058593          	addi	a1,a1,-1808 # 800081e8 <digits+0x1a8>
    80001900:	0000f517          	auipc	a0,0xf
    80001904:	25850513          	addi	a0,a0,600 # 80010b58 <wait_lock>
    80001908:	fffff097          	auipc	ra,0xfffff
    8000190c:	23e080e7          	jalr	574(ra) # 80000b46 <initlock>
  for (p = proc; p < &proc[NPROC]; p++)
    80001910:	0000f497          	auipc	s1,0xf
    80001914:	66048493          	addi	s1,s1,1632 # 80010f70 <proc>
  {
    initlock(&p->lock, "proc");
    80001918:	00007b17          	auipc	s6,0x7
    8000191c:	8e0b0b13          	addi	s6,s6,-1824 # 800081f8 <digits+0x1b8>
    p->state = UNUSED;
    p->kstack = KSTACK((int)(p - proc));
    80001920:	8aa6                	mv	s5,s1
    80001922:	00006a17          	auipc	s4,0x6
    80001926:	6dea0a13          	addi	s4,s4,1758 # 80008000 <etext>
    8000192a:	04000937          	lui	s2,0x4000
    8000192e:	197d                	addi	s2,s2,-1
    80001930:	0932                	slli	s2,s2,0xc
  for (p = proc; p < &proc[NPROC]; p++)
    80001932:	00015997          	auipc	s3,0x15
    80001936:	03e98993          	addi	s3,s3,62 # 80016970 <tickslock>
    initlock(&p->lock, "proc");
    8000193a:	85da                	mv	a1,s6
    8000193c:	8526                	mv	a0,s1
    8000193e:	fffff097          	auipc	ra,0xfffff
    80001942:	208080e7          	jalr	520(ra) # 80000b46 <initlock>
    p->state = UNUSED;
    80001946:	0004ac23          	sw	zero,24(s1)
    p->kstack = KSTACK((int)(p - proc));
    8000194a:	415487b3          	sub	a5,s1,s5
    8000194e:	878d                	srai	a5,a5,0x3
    80001950:	000a3703          	ld	a4,0(s4)
    80001954:	02e787b3          	mul	a5,a5,a4
    80001958:	2785                	addiw	a5,a5,1
    8000195a:	00d7979b          	slliw	a5,a5,0xd
    8000195e:	40f907b3          	sub	a5,s2,a5
    80001962:	e0bc                	sd	a5,64(s1)
  for (p = proc; p < &proc[NPROC]; p++)
    80001964:	16848493          	addi	s1,s1,360
    80001968:	fd3499e3          	bne	s1,s3,8000193a <procinit+0x6e>
  }
}
    8000196c:	70e2                	ld	ra,56(sp)
    8000196e:	7442                	ld	s0,48(sp)
    80001970:	74a2                	ld	s1,40(sp)
    80001972:	7902                	ld	s2,32(sp)
    80001974:	69e2                	ld	s3,24(sp)
    80001976:	6a42                	ld	s4,16(sp)
    80001978:	6aa2                	ld	s5,8(sp)
    8000197a:	6b02                	ld	s6,0(sp)
    8000197c:	6121                	addi	sp,sp,64
    8000197e:	8082                	ret

0000000080001980 <cpuid>:

// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int cpuid()
{
    80001980:	1141                	addi	sp,sp,-16
    80001982:	e422                	sd	s0,8(sp)
    80001984:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80001986:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80001988:	2501                	sext.w	a0,a0
    8000198a:	6422                	ld	s0,8(sp)
    8000198c:	0141                	addi	sp,sp,16
    8000198e:	8082                	ret

0000000080001990 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu *
mycpu(void)
{
    80001990:	1141                	addi	sp,sp,-16
    80001992:	e422                	sd	s0,8(sp)
    80001994:	0800                	addi	s0,sp,16
    80001996:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80001998:	2781                	sext.w	a5,a5
    8000199a:	079e                	slli	a5,a5,0x7
  return c;
}
    8000199c:	0000f517          	auipc	a0,0xf
    800019a0:	1d450513          	addi	a0,a0,468 # 80010b70 <cpus>
    800019a4:	953e                	add	a0,a0,a5
    800019a6:	6422                	ld	s0,8(sp)
    800019a8:	0141                	addi	sp,sp,16
    800019aa:	8082                	ret

00000000800019ac <myproc>:

// Return the current struct proc *, or zero if none.
struct proc *
myproc(void)
{
    800019ac:	1101                	addi	sp,sp,-32
    800019ae:	ec06                	sd	ra,24(sp)
    800019b0:	e822                	sd	s0,16(sp)
    800019b2:	e426                	sd	s1,8(sp)
    800019b4:	1000                	addi	s0,sp,32
  push_off();
    800019b6:	fffff097          	auipc	ra,0xfffff
    800019ba:	1d4080e7          	jalr	468(ra) # 80000b8a <push_off>
    800019be:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    800019c0:	2781                	sext.w	a5,a5
    800019c2:	079e                	slli	a5,a5,0x7
    800019c4:	0000f717          	auipc	a4,0xf
    800019c8:	17c70713          	addi	a4,a4,380 # 80010b40 <pid_lock>
    800019cc:	97ba                	add	a5,a5,a4
    800019ce:	7b84                	ld	s1,48(a5)
  pop_off();
    800019d0:	fffff097          	auipc	ra,0xfffff
    800019d4:	25a080e7          	jalr	602(ra) # 80000c2a <pop_off>
  return p;
}
    800019d8:	8526                	mv	a0,s1
    800019da:	60e2                	ld	ra,24(sp)
    800019dc:	6442                	ld	s0,16(sp)
    800019de:	64a2                	ld	s1,8(sp)
    800019e0:	6105                	addi	sp,sp,32
    800019e2:	8082                	ret

00000000800019e4 <forkret>:
}

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void forkret(void)
{
    800019e4:	1141                	addi	sp,sp,-16
    800019e6:	e406                	sd	ra,8(sp)
    800019e8:	e022                	sd	s0,0(sp)
    800019ea:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    800019ec:	00000097          	auipc	ra,0x0
    800019f0:	fc0080e7          	jalr	-64(ra) # 800019ac <myproc>
    800019f4:	fffff097          	auipc	ra,0xfffff
    800019f8:	296080e7          	jalr	662(ra) # 80000c8a <release>

  if (first)
    800019fc:	00007797          	auipc	a5,0x7
    80001a00:	e547a783          	lw	a5,-428(a5) # 80008850 <first.1>
    80001a04:	eb89                	bnez	a5,80001a16 <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    80001a06:	00001097          	auipc	ra,0x1
    80001a0a:	e44080e7          	jalr	-444(ra) # 8000284a <usertrapret>
}
    80001a0e:	60a2                	ld	ra,8(sp)
    80001a10:	6402                	ld	s0,0(sp)
    80001a12:	0141                	addi	sp,sp,16
    80001a14:	8082                	ret
    first = 0;
    80001a16:	00007797          	auipc	a5,0x7
    80001a1a:	e207ad23          	sw	zero,-454(a5) # 80008850 <first.1>
    fsinit(ROOTDEV);
    80001a1e:	4505                	li	a0,1
    80001a20:	00002097          	auipc	ra,0x2
    80001a24:	ba4080e7          	jalr	-1116(ra) # 800035c4 <fsinit>
    80001a28:	bff9                	j	80001a06 <forkret+0x22>

0000000080001a2a <allocpid>:
{
    80001a2a:	1101                	addi	sp,sp,-32
    80001a2c:	ec06                	sd	ra,24(sp)
    80001a2e:	e822                	sd	s0,16(sp)
    80001a30:	e426                	sd	s1,8(sp)
    80001a32:	e04a                	sd	s2,0(sp)
    80001a34:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80001a36:	0000f917          	auipc	s2,0xf
    80001a3a:	10a90913          	addi	s2,s2,266 # 80010b40 <pid_lock>
    80001a3e:	854a                	mv	a0,s2
    80001a40:	fffff097          	auipc	ra,0xfffff
    80001a44:	196080e7          	jalr	406(ra) # 80000bd6 <acquire>
  pid = nextpid;
    80001a48:	00007797          	auipc	a5,0x7
    80001a4c:	e0c78793          	addi	a5,a5,-500 # 80008854 <nextpid>
    80001a50:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80001a52:	0014871b          	addiw	a4,s1,1
    80001a56:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80001a58:	854a                	mv	a0,s2
    80001a5a:	fffff097          	auipc	ra,0xfffff
    80001a5e:	230080e7          	jalr	560(ra) # 80000c8a <release>
}
    80001a62:	8526                	mv	a0,s1
    80001a64:	60e2                	ld	ra,24(sp)
    80001a66:	6442                	ld	s0,16(sp)
    80001a68:	64a2                	ld	s1,8(sp)
    80001a6a:	6902                	ld	s2,0(sp)
    80001a6c:	6105                	addi	sp,sp,32
    80001a6e:	8082                	ret

0000000080001a70 <proc_pigtable>:
{
    80001a70:	1101                	addi	sp,sp,-32
    80001a72:	ec06                	sd	ra,24(sp)
    80001a74:	e822                	sd	s0,16(sp)
    80001a76:	e426                	sd	s1,8(sp)
    80001a78:	e04a                	sd	s2,0(sp)
    80001a7a:	1000                	addi	s0,sp,32
    80001a7c:	892a                	mv	s2,a0
  pigtable = uvmcreate();
    80001a7e:	00000097          	auipc	ra,0x0
    80001a82:	8aa080e7          	jalr	-1878(ra) # 80001328 <uvmcreate>
    80001a86:	84aa                	mv	s1,a0
  if (pigtable == 0)
    80001a88:	c121                	beqz	a0,80001ac8 <proc_pigtable+0x58>
  if (mappigs(pigtable, TRAMPOLINE, PIGSIZE,
    80001a8a:	4729                	li	a4,10
    80001a8c:	00005697          	auipc	a3,0x5
    80001a90:	57468693          	addi	a3,a3,1396 # 80007000 <_trampoline>
    80001a94:	6605                	lui	a2,0x1
    80001a96:	040005b7          	lui	a1,0x4000
    80001a9a:	15fd                	addi	a1,a1,-1
    80001a9c:	05b2                	slli	a1,a1,0xc
    80001a9e:	fffff097          	auipc	ra,0xfffff
    80001aa2:	600080e7          	jalr	1536(ra) # 8000109e <mappigs>
    80001aa6:	02054863          	bltz	a0,80001ad6 <proc_pigtable+0x66>
  if (mappigs(pigtable, TRAPFRAME, PIGSIZE,
    80001aaa:	4719                	li	a4,6
    80001aac:	05893683          	ld	a3,88(s2)
    80001ab0:	6605                	lui	a2,0x1
    80001ab2:	020005b7          	lui	a1,0x2000
    80001ab6:	15fd                	addi	a1,a1,-1
    80001ab8:	05b6                	slli	a1,a1,0xd
    80001aba:	8526                	mv	a0,s1
    80001abc:	fffff097          	auipc	ra,0xfffff
    80001ac0:	5e2080e7          	jalr	1506(ra) # 8000109e <mappigs>
    80001ac4:	02054163          	bltz	a0,80001ae6 <proc_pigtable+0x76>
}
    80001ac8:	8526                	mv	a0,s1
    80001aca:	60e2                	ld	ra,24(sp)
    80001acc:	6442                	ld	s0,16(sp)
    80001ace:	64a2                	ld	s1,8(sp)
    80001ad0:	6902                	ld	s2,0(sp)
    80001ad2:	6105                	addi	sp,sp,32
    80001ad4:	8082                	ret
    uvmfree(pigtable, 0);
    80001ad6:	4581                	li	a1,0
    80001ad8:	8526                	mv	a0,s1
    80001ada:	00000097          	auipc	ra,0x0
    80001ade:	a52080e7          	jalr	-1454(ra) # 8000152c <uvmfree>
    return 0;
    80001ae2:	4481                	li	s1,0
    80001ae4:	b7d5                	j	80001ac8 <proc_pigtable+0x58>
    uvmunmap(pigtable, TRAMPOLINE, 1, 0);
    80001ae6:	4681                	li	a3,0
    80001ae8:	4605                	li	a2,1
    80001aea:	040005b7          	lui	a1,0x4000
    80001aee:	15fd                	addi	a1,a1,-1
    80001af0:	05b2                	slli	a1,a1,0xc
    80001af2:	8526                	mv	a0,s1
    80001af4:	fffff097          	auipc	ra,0xfffff
    80001af8:	770080e7          	jalr	1904(ra) # 80001264 <uvmunmap>
    uvmfree(pigtable, 0);
    80001afc:	4581                	li	a1,0
    80001afe:	8526                	mv	a0,s1
    80001b00:	00000097          	auipc	ra,0x0
    80001b04:	a2c080e7          	jalr	-1492(ra) # 8000152c <uvmfree>
    return 0;
    80001b08:	4481                	li	s1,0
    80001b0a:	bf7d                	j	80001ac8 <proc_pigtable+0x58>

0000000080001b0c <proc_freepigtable>:
{
    80001b0c:	1101                	addi	sp,sp,-32
    80001b0e:	ec06                	sd	ra,24(sp)
    80001b10:	e822                	sd	s0,16(sp)
    80001b12:	e426                	sd	s1,8(sp)
    80001b14:	e04a                	sd	s2,0(sp)
    80001b16:	1000                	addi	s0,sp,32
    80001b18:	84aa                	mv	s1,a0
    80001b1a:	892e                	mv	s2,a1
  uvmunmap(pigtable, TRAMPOLINE, 1, 0);
    80001b1c:	4681                	li	a3,0
    80001b1e:	4605                	li	a2,1
    80001b20:	040005b7          	lui	a1,0x4000
    80001b24:	15fd                	addi	a1,a1,-1
    80001b26:	05b2                	slli	a1,a1,0xc
    80001b28:	fffff097          	auipc	ra,0xfffff
    80001b2c:	73c080e7          	jalr	1852(ra) # 80001264 <uvmunmap>
  uvmunmap(pigtable, TRAPFRAME, 1, 0);
    80001b30:	4681                	li	a3,0
    80001b32:	4605                	li	a2,1
    80001b34:	020005b7          	lui	a1,0x2000
    80001b38:	15fd                	addi	a1,a1,-1
    80001b3a:	05b6                	slli	a1,a1,0xd
    80001b3c:	8526                	mv	a0,s1
    80001b3e:	fffff097          	auipc	ra,0xfffff
    80001b42:	726080e7          	jalr	1830(ra) # 80001264 <uvmunmap>
  uvmfree(pigtable, sz);
    80001b46:	85ca                	mv	a1,s2
    80001b48:	8526                	mv	a0,s1
    80001b4a:	00000097          	auipc	ra,0x0
    80001b4e:	9e2080e7          	jalr	-1566(ra) # 8000152c <uvmfree>
}
    80001b52:	60e2                	ld	ra,24(sp)
    80001b54:	6442                	ld	s0,16(sp)
    80001b56:	64a2                	ld	s1,8(sp)
    80001b58:	6902                	ld	s2,0(sp)
    80001b5a:	6105                	addi	sp,sp,32
    80001b5c:	8082                	ret

0000000080001b5e <freeproc>:
{
    80001b5e:	1101                	addi	sp,sp,-32
    80001b60:	ec06                	sd	ra,24(sp)
    80001b62:	e822                	sd	s0,16(sp)
    80001b64:	e426                	sd	s1,8(sp)
    80001b66:	1000                	addi	s0,sp,32
    80001b68:	84aa                	mv	s1,a0
  if (p->trapframe)
    80001b6a:	6d28                	ld	a0,88(a0)
    80001b6c:	c509                	beqz	a0,80001b76 <freeproc+0x18>
    kfree((void *)p->trapframe);
    80001b6e:	fffff097          	auipc	ra,0xfffff
    80001b72:	e7c080e7          	jalr	-388(ra) # 800009ea <kfree>
  p->trapframe = 0;
    80001b76:	0404bc23          	sd	zero,88(s1)
  if (p->pigtable)
    80001b7a:	68a8                	ld	a0,80(s1)
    80001b7c:	c511                	beqz	a0,80001b88 <freeproc+0x2a>
    proc_freepigtable(p->pigtable, p->sz);
    80001b7e:	64ac                	ld	a1,72(s1)
    80001b80:	00000097          	auipc	ra,0x0
    80001b84:	f8c080e7          	jalr	-116(ra) # 80001b0c <proc_freepigtable>
  p->pigtable = 0;
    80001b88:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80001b8c:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80001b90:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80001b94:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    80001b98:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80001b9c:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80001ba0:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80001ba4:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80001ba8:	0004ac23          	sw	zero,24(s1)
}
    80001bac:	60e2                	ld	ra,24(sp)
    80001bae:	6442                	ld	s0,16(sp)
    80001bb0:	64a2                	ld	s1,8(sp)
    80001bb2:	6105                	addi	sp,sp,32
    80001bb4:	8082                	ret

0000000080001bb6 <allocproc>:
{
    80001bb6:	1101                	addi	sp,sp,-32
    80001bb8:	ec06                	sd	ra,24(sp)
    80001bba:	e822                	sd	s0,16(sp)
    80001bbc:	e426                	sd	s1,8(sp)
    80001bbe:	e04a                	sd	s2,0(sp)
    80001bc0:	1000                	addi	s0,sp,32
  for (p = proc; p < &proc[NPROC]; p++)
    80001bc2:	0000f497          	auipc	s1,0xf
    80001bc6:	3ae48493          	addi	s1,s1,942 # 80010f70 <proc>
    80001bca:	00015917          	auipc	s2,0x15
    80001bce:	da690913          	addi	s2,s2,-602 # 80016970 <tickslock>
    acquire(&p->lock);
    80001bd2:	8526                	mv	a0,s1
    80001bd4:	fffff097          	auipc	ra,0xfffff
    80001bd8:	002080e7          	jalr	2(ra) # 80000bd6 <acquire>
    if (p->state == UNUSED)
    80001bdc:	4c9c                	lw	a5,24(s1)
    80001bde:	cf81                	beqz	a5,80001bf6 <allocproc+0x40>
      release(&p->lock);
    80001be0:	8526                	mv	a0,s1
    80001be2:	fffff097          	auipc	ra,0xfffff
    80001be6:	0a8080e7          	jalr	168(ra) # 80000c8a <release>
  for (p = proc; p < &proc[NPROC]; p++)
    80001bea:	16848493          	addi	s1,s1,360
    80001bee:	ff2492e3          	bne	s1,s2,80001bd2 <allocproc+0x1c>
  return 0;
    80001bf2:	4481                	li	s1,0
    80001bf4:	a889                	j	80001c46 <allocproc+0x90>
  p->pid = allocpid();
    80001bf6:	00000097          	auipc	ra,0x0
    80001bfa:	e34080e7          	jalr	-460(ra) # 80001a2a <allocpid>
    80001bfe:	d888                	sw	a0,48(s1)
  p->state = USED;
    80001c00:	4785                	li	a5,1
    80001c02:	cc9c                	sw	a5,24(s1)
  if ((p->trapframe = (struct trapframe *)kalloc()) == 0)
    80001c04:	fffff097          	auipc	ra,0xfffff
    80001c08:	ee2080e7          	jalr	-286(ra) # 80000ae6 <kalloc>
    80001c0c:	892a                	mv	s2,a0
    80001c0e:	eca8                	sd	a0,88(s1)
    80001c10:	c131                	beqz	a0,80001c54 <allocproc+0x9e>
  p->pigtable = proc_pigtable(p);
    80001c12:	8526                	mv	a0,s1
    80001c14:	00000097          	auipc	ra,0x0
    80001c18:	e5c080e7          	jalr	-420(ra) # 80001a70 <proc_pigtable>
    80001c1c:	892a                	mv	s2,a0
    80001c1e:	e8a8                	sd	a0,80(s1)
  if (p->pigtable == 0)
    80001c20:	c531                	beqz	a0,80001c6c <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    80001c22:	07000613          	li	a2,112
    80001c26:	4581                	li	a1,0
    80001c28:	06048513          	addi	a0,s1,96
    80001c2c:	fffff097          	auipc	ra,0xfffff
    80001c30:	0a6080e7          	jalr	166(ra) # 80000cd2 <memset>
  p->context.ra = (uint64)forkret;
    80001c34:	00000797          	auipc	a5,0x0
    80001c38:	db078793          	addi	a5,a5,-592 # 800019e4 <forkret>
    80001c3c:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PIGSIZE;
    80001c3e:	60bc                	ld	a5,64(s1)
    80001c40:	6705                	lui	a4,0x1
    80001c42:	97ba                	add	a5,a5,a4
    80001c44:	f4bc                	sd	a5,104(s1)
}
    80001c46:	8526                	mv	a0,s1
    80001c48:	60e2                	ld	ra,24(sp)
    80001c4a:	6442                	ld	s0,16(sp)
    80001c4c:	64a2                	ld	s1,8(sp)
    80001c4e:	6902                	ld	s2,0(sp)
    80001c50:	6105                	addi	sp,sp,32
    80001c52:	8082                	ret
    freeproc(p);
    80001c54:	8526                	mv	a0,s1
    80001c56:	00000097          	auipc	ra,0x0
    80001c5a:	f08080e7          	jalr	-248(ra) # 80001b5e <freeproc>
    release(&p->lock);
    80001c5e:	8526                	mv	a0,s1
    80001c60:	fffff097          	auipc	ra,0xfffff
    80001c64:	02a080e7          	jalr	42(ra) # 80000c8a <release>
    return 0;
    80001c68:	84ca                	mv	s1,s2
    80001c6a:	bff1                	j	80001c46 <allocproc+0x90>
    freeproc(p);
    80001c6c:	8526                	mv	a0,s1
    80001c6e:	00000097          	auipc	ra,0x0
    80001c72:	ef0080e7          	jalr	-272(ra) # 80001b5e <freeproc>
    release(&p->lock);
    80001c76:	8526                	mv	a0,s1
    80001c78:	fffff097          	auipc	ra,0xfffff
    80001c7c:	012080e7          	jalr	18(ra) # 80000c8a <release>
    return 0;
    80001c80:	84ca                	mv	s1,s2
    80001c82:	b7d1                	j	80001c46 <allocproc+0x90>

0000000080001c84 <userinit>:
{
    80001c84:	1101                	addi	sp,sp,-32
    80001c86:	ec06                	sd	ra,24(sp)
    80001c88:	e822                	sd	s0,16(sp)
    80001c8a:	e426                	sd	s1,8(sp)
    80001c8c:	1000                	addi	s0,sp,32
  p = allocproc();
    80001c8e:	00000097          	auipc	ra,0x0
    80001c92:	f28080e7          	jalr	-216(ra) # 80001bb6 <allocproc>
    80001c96:	84aa                	mv	s1,a0
  initproc = p;
    80001c98:	00007797          	auipc	a5,0x7
    80001c9c:	c2a7b823          	sd	a0,-976(a5) # 800088c8 <initproc>
  uvmfirst(p->pigtable, initcode, sizeof(initcode));
    80001ca0:	03400613          	li	a2,52
    80001ca4:	00007597          	auipc	a1,0x7
    80001ca8:	bbc58593          	addi	a1,a1,-1092 # 80008860 <initcode>
    80001cac:	6928                	ld	a0,80(a0)
    80001cae:	fffff097          	auipc	ra,0xfffff
    80001cb2:	6a8080e7          	jalr	1704(ra) # 80001356 <uvmfirst>
  p->sz = PIGSIZE;
    80001cb6:	6785                	lui	a5,0x1
    80001cb8:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    80001cba:	6cb8                	ld	a4,88(s1)
    80001cbc:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PIGSIZE; // user stack pointer
    80001cc0:	6cb8                	ld	a4,88(s1)
    80001cc2:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001cc4:	4641                	li	a2,16
    80001cc6:	00006597          	auipc	a1,0x6
    80001cca:	53a58593          	addi	a1,a1,1338 # 80008200 <digits+0x1c0>
    80001cce:	15848513          	addi	a0,s1,344
    80001cd2:	fffff097          	auipc	ra,0xfffff
    80001cd6:	14a080e7          	jalr	330(ra) # 80000e1c <safestrcpy>
  p->cwd = namei("/");
    80001cda:	00006517          	auipc	a0,0x6
    80001cde:	53650513          	addi	a0,a0,1334 # 80008210 <digits+0x1d0>
    80001ce2:	00002097          	auipc	ra,0x2
    80001ce6:	304080e7          	jalr	772(ra) # 80003fe6 <namei>
    80001cea:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001cee:	478d                	li	a5,3
    80001cf0:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    80001cf2:	8526                	mv	a0,s1
    80001cf4:	fffff097          	auipc	ra,0xfffff
    80001cf8:	f96080e7          	jalr	-106(ra) # 80000c8a <release>
}
    80001cfc:	60e2                	ld	ra,24(sp)
    80001cfe:	6442                	ld	s0,16(sp)
    80001d00:	64a2                	ld	s1,8(sp)
    80001d02:	6105                	addi	sp,sp,32
    80001d04:	8082                	ret

0000000080001d06 <growproc>:
{
    80001d06:	1101                	addi	sp,sp,-32
    80001d08:	ec06                	sd	ra,24(sp)
    80001d0a:	e822                	sd	s0,16(sp)
    80001d0c:	e426                	sd	s1,8(sp)
    80001d0e:	e04a                	sd	s2,0(sp)
    80001d10:	1000                	addi	s0,sp,32
    80001d12:	892a                	mv	s2,a0
  struct proc *p = myproc();
    80001d14:	00000097          	auipc	ra,0x0
    80001d18:	c98080e7          	jalr	-872(ra) # 800019ac <myproc>
    80001d1c:	84aa                	mv	s1,a0
  sz = p->sz;
    80001d1e:	652c                	ld	a1,72(a0)
  if (n > 0)
    80001d20:	01204c63          	bgtz	s2,80001d38 <growproc+0x32>
  else if (n < 0)
    80001d24:	02094663          	bltz	s2,80001d50 <growproc+0x4a>
  p->sz = sz;
    80001d28:	e4ac                	sd	a1,72(s1)
  return 0;
    80001d2a:	4501                	li	a0,0
}
    80001d2c:	60e2                	ld	ra,24(sp)
    80001d2e:	6442                	ld	s0,16(sp)
    80001d30:	64a2                	ld	s1,8(sp)
    80001d32:	6902                	ld	s2,0(sp)
    80001d34:	6105                	addi	sp,sp,32
    80001d36:	8082                	ret
    if ((sz = uvmalloc(p->pigtable, sz, sz + n, PTE_W)) == 0)
    80001d38:	4691                	li	a3,4
    80001d3a:	00b90633          	add	a2,s2,a1
    80001d3e:	6928                	ld	a0,80(a0)
    80001d40:	fffff097          	auipc	ra,0xfffff
    80001d44:	6d0080e7          	jalr	1744(ra) # 80001410 <uvmalloc>
    80001d48:	85aa                	mv	a1,a0
    80001d4a:	fd79                	bnez	a0,80001d28 <growproc+0x22>
      return -1;
    80001d4c:	557d                	li	a0,-1
    80001d4e:	bff9                	j	80001d2c <growproc+0x26>
    sz = uvmdealloc(p->pigtable, sz, sz + n);
    80001d50:	00b90633          	add	a2,s2,a1
    80001d54:	6928                	ld	a0,80(a0)
    80001d56:	fffff097          	auipc	ra,0xfffff
    80001d5a:	672080e7          	jalr	1650(ra) # 800013c8 <uvmdealloc>
    80001d5e:	85aa                	mv	a1,a0
    80001d60:	b7e1                	j	80001d28 <growproc+0x22>

0000000080001d62 <fork>:
{
    80001d62:	7139                	addi	sp,sp,-64
    80001d64:	fc06                	sd	ra,56(sp)
    80001d66:	f822                	sd	s0,48(sp)
    80001d68:	f426                	sd	s1,40(sp)
    80001d6a:	f04a                	sd	s2,32(sp)
    80001d6c:	ec4e                	sd	s3,24(sp)
    80001d6e:	e852                	sd	s4,16(sp)
    80001d70:	e456                	sd	s5,8(sp)
    80001d72:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    80001d74:	00000097          	auipc	ra,0x0
    80001d78:	c38080e7          	jalr	-968(ra) # 800019ac <myproc>
    80001d7c:	8aaa                	mv	s5,a0
  if ((np = allocproc()) == 0)
    80001d7e:	00000097          	auipc	ra,0x0
    80001d82:	e38080e7          	jalr	-456(ra) # 80001bb6 <allocproc>
    80001d86:	10050c63          	beqz	a0,80001e9e <fork+0x13c>
    80001d8a:	8a2a                	mv	s4,a0
  if (uvmcopy(p->pigtable, np->pigtable, p->sz) < 0)
    80001d8c:	048ab603          	ld	a2,72(s5)
    80001d90:	692c                	ld	a1,80(a0)
    80001d92:	050ab503          	ld	a0,80(s5)
    80001d96:	fffff097          	auipc	ra,0xfffff
    80001d9a:	7ce080e7          	jalr	1998(ra) # 80001564 <uvmcopy>
    80001d9e:	04054863          	bltz	a0,80001dee <fork+0x8c>
  np->sz = p->sz;
    80001da2:	048ab783          	ld	a5,72(s5)
    80001da6:	04fa3423          	sd	a5,72(s4)
  *(np->trapframe) = *(p->trapframe);
    80001daa:	058ab683          	ld	a3,88(s5)
    80001dae:	87b6                	mv	a5,a3
    80001db0:	058a3703          	ld	a4,88(s4)
    80001db4:	12068693          	addi	a3,a3,288
    80001db8:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    80001dbc:	6788                	ld	a0,8(a5)
    80001dbe:	6b8c                	ld	a1,16(a5)
    80001dc0:	6f90                	ld	a2,24(a5)
    80001dc2:	01073023          	sd	a6,0(a4)
    80001dc6:	e708                	sd	a0,8(a4)
    80001dc8:	eb0c                	sd	a1,16(a4)
    80001dca:	ef10                	sd	a2,24(a4)
    80001dcc:	02078793          	addi	a5,a5,32
    80001dd0:	02070713          	addi	a4,a4,32
    80001dd4:	fed792e3          	bne	a5,a3,80001db8 <fork+0x56>
  np->trapframe->a0 = 0;
    80001dd8:	058a3783          	ld	a5,88(s4)
    80001ddc:	0607b823          	sd	zero,112(a5)
  for (i = 0; i < NOFILE; i++)
    80001de0:	0d0a8493          	addi	s1,s5,208
    80001de4:	0d0a0913          	addi	s2,s4,208
    80001de8:	150a8993          	addi	s3,s5,336
    80001dec:	a00d                	j	80001e0e <fork+0xac>
    freeproc(np);
    80001dee:	8552                	mv	a0,s4
    80001df0:	00000097          	auipc	ra,0x0
    80001df4:	d6e080e7          	jalr	-658(ra) # 80001b5e <freeproc>
    release(&np->lock);
    80001df8:	8552                	mv	a0,s4
    80001dfa:	fffff097          	auipc	ra,0xfffff
    80001dfe:	e90080e7          	jalr	-368(ra) # 80000c8a <release>
    return -1;
    80001e02:	597d                	li	s2,-1
    80001e04:	a059                	j	80001e8a <fork+0x128>
  for (i = 0; i < NOFILE; i++)
    80001e06:	04a1                	addi	s1,s1,8
    80001e08:	0921                	addi	s2,s2,8
    80001e0a:	01348b63          	beq	s1,s3,80001e20 <fork+0xbe>
    if (p->ofile[i])
    80001e0e:	6088                	ld	a0,0(s1)
    80001e10:	d97d                	beqz	a0,80001e06 <fork+0xa4>
      np->ofile[i] = filedup(p->ofile[i]);
    80001e12:	00003097          	auipc	ra,0x3
    80001e16:	86a080e7          	jalr	-1942(ra) # 8000467c <filedup>
    80001e1a:	00a93023          	sd	a0,0(s2)
    80001e1e:	b7e5                	j	80001e06 <fork+0xa4>
  np->cwd = idup(p->cwd);
    80001e20:	150ab503          	ld	a0,336(s5)
    80001e24:	00002097          	auipc	ra,0x2
    80001e28:	9de080e7          	jalr	-1570(ra) # 80003802 <idup>
    80001e2c:	14aa3823          	sd	a0,336(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001e30:	4641                	li	a2,16
    80001e32:	158a8593          	addi	a1,s5,344
    80001e36:	158a0513          	addi	a0,s4,344
    80001e3a:	fffff097          	auipc	ra,0xfffff
    80001e3e:	fe2080e7          	jalr	-30(ra) # 80000e1c <safestrcpy>
  pid = np->pid;
    80001e42:	030a2903          	lw	s2,48(s4)
  release(&np->lock);
    80001e46:	8552                	mv	a0,s4
    80001e48:	fffff097          	auipc	ra,0xfffff
    80001e4c:	e42080e7          	jalr	-446(ra) # 80000c8a <release>
  acquire(&wait_lock);
    80001e50:	0000f497          	auipc	s1,0xf
    80001e54:	d0848493          	addi	s1,s1,-760 # 80010b58 <wait_lock>
    80001e58:	8526                	mv	a0,s1
    80001e5a:	fffff097          	auipc	ra,0xfffff
    80001e5e:	d7c080e7          	jalr	-644(ra) # 80000bd6 <acquire>
  np->parent = p;
    80001e62:	035a3c23          	sd	s5,56(s4)
  release(&wait_lock);
    80001e66:	8526                	mv	a0,s1
    80001e68:	fffff097          	auipc	ra,0xfffff
    80001e6c:	e22080e7          	jalr	-478(ra) # 80000c8a <release>
  acquire(&np->lock);
    80001e70:	8552                	mv	a0,s4
    80001e72:	fffff097          	auipc	ra,0xfffff
    80001e76:	d64080e7          	jalr	-668(ra) # 80000bd6 <acquire>
  np->state = RUNNABLE;
    80001e7a:	478d                	li	a5,3
    80001e7c:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    80001e80:	8552                	mv	a0,s4
    80001e82:	fffff097          	auipc	ra,0xfffff
    80001e86:	e08080e7          	jalr	-504(ra) # 80000c8a <release>
}
    80001e8a:	854a                	mv	a0,s2
    80001e8c:	70e2                	ld	ra,56(sp)
    80001e8e:	7442                	ld	s0,48(sp)
    80001e90:	74a2                	ld	s1,40(sp)
    80001e92:	7902                	ld	s2,32(sp)
    80001e94:	69e2                	ld	s3,24(sp)
    80001e96:	6a42                	ld	s4,16(sp)
    80001e98:	6aa2                	ld	s5,8(sp)
    80001e9a:	6121                	addi	sp,sp,64
    80001e9c:	8082                	ret
    return -1;
    80001e9e:	597d                	li	s2,-1
    80001ea0:	b7ed                	j	80001e8a <fork+0x128>

0000000080001ea2 <scheduler>:
{
    80001ea2:	7139                	addi	sp,sp,-64
    80001ea4:	fc06                	sd	ra,56(sp)
    80001ea6:	f822                	sd	s0,48(sp)
    80001ea8:	f426                	sd	s1,40(sp)
    80001eaa:	f04a                	sd	s2,32(sp)
    80001eac:	ec4e                	sd	s3,24(sp)
    80001eae:	e852                	sd	s4,16(sp)
    80001eb0:	e456                	sd	s5,8(sp)
    80001eb2:	e05a                	sd	s6,0(sp)
    80001eb4:	0080                	addi	s0,sp,64
    80001eb6:	8792                	mv	a5,tp
  int id = r_tp();
    80001eb8:	2781                	sext.w	a5,a5
  c->proc = 0;
    80001eba:	00779a93          	slli	s5,a5,0x7
    80001ebe:	0000f717          	auipc	a4,0xf
    80001ec2:	c8270713          	addi	a4,a4,-894 # 80010b40 <pid_lock>
    80001ec6:	9756                	add	a4,a4,s5
    80001ec8:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    80001ecc:	0000f717          	auipc	a4,0xf
    80001ed0:	cac70713          	addi	a4,a4,-852 # 80010b78 <cpus+0x8>
    80001ed4:	9aba                	add	s5,s5,a4
      if (p->state == RUNNABLE)
    80001ed6:	498d                	li	s3,3
        p->state = RUNNING;
    80001ed8:	4b11                	li	s6,4
        c->proc = p;
    80001eda:	079e                	slli	a5,a5,0x7
    80001edc:	0000fa17          	auipc	s4,0xf
    80001ee0:	c64a0a13          	addi	s4,s4,-924 # 80010b40 <pid_lock>
    80001ee4:	9a3e                	add	s4,s4,a5
    for (p = proc; p < &proc[NPROC]; p++)
    80001ee6:	00015917          	auipc	s2,0x15
    80001eea:	a8a90913          	addi	s2,s2,-1398 # 80016970 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001eee:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001ef2:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001ef6:	10079073          	csrw	sstatus,a5
    80001efa:	0000f497          	auipc	s1,0xf
    80001efe:	07648493          	addi	s1,s1,118 # 80010f70 <proc>
    80001f02:	a811                	j	80001f16 <scheduler+0x74>
      release(&p->lock);
    80001f04:	8526                	mv	a0,s1
    80001f06:	fffff097          	auipc	ra,0xfffff
    80001f0a:	d84080e7          	jalr	-636(ra) # 80000c8a <release>
    for (p = proc; p < &proc[NPROC]; p++)
    80001f0e:	16848493          	addi	s1,s1,360
    80001f12:	fd248ee3          	beq	s1,s2,80001eee <scheduler+0x4c>
      acquire(&p->lock);
    80001f16:	8526                	mv	a0,s1
    80001f18:	fffff097          	auipc	ra,0xfffff
    80001f1c:	cbe080e7          	jalr	-834(ra) # 80000bd6 <acquire>
      if (p->state == RUNNABLE)
    80001f20:	4c9c                	lw	a5,24(s1)
    80001f22:	ff3791e3          	bne	a5,s3,80001f04 <scheduler+0x62>
        p->state = RUNNING;
    80001f26:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    80001f2a:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    80001f2e:	06048593          	addi	a1,s1,96
    80001f32:	8556                	mv	a0,s5
    80001f34:	00001097          	auipc	ra,0x1
    80001f38:	86c080e7          	jalr	-1940(ra) # 800027a0 <swtch>
        c->proc = 0;
    80001f3c:	020a3823          	sd	zero,48(s4)
    80001f40:	b7d1                	j	80001f04 <scheduler+0x62>

0000000080001f42 <sched>:
{
    80001f42:	7179                	addi	sp,sp,-48
    80001f44:	f406                	sd	ra,40(sp)
    80001f46:	f022                	sd	s0,32(sp)
    80001f48:	ec26                	sd	s1,24(sp)
    80001f4a:	e84a                	sd	s2,16(sp)
    80001f4c:	e44e                	sd	s3,8(sp)
    80001f4e:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001f50:	00000097          	auipc	ra,0x0
    80001f54:	a5c080e7          	jalr	-1444(ra) # 800019ac <myproc>
    80001f58:	84aa                	mv	s1,a0
  if (!holding(&p->lock))
    80001f5a:	fffff097          	auipc	ra,0xfffff
    80001f5e:	c02080e7          	jalr	-1022(ra) # 80000b5c <holding>
    80001f62:	c93d                	beqz	a0,80001fd8 <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001f64:	8792                	mv	a5,tp
  if (mycpu()->noff != 1)
    80001f66:	2781                	sext.w	a5,a5
    80001f68:	079e                	slli	a5,a5,0x7
    80001f6a:	0000f717          	auipc	a4,0xf
    80001f6e:	bd670713          	addi	a4,a4,-1066 # 80010b40 <pid_lock>
    80001f72:	97ba                	add	a5,a5,a4
    80001f74:	0a87a703          	lw	a4,168(a5)
    80001f78:	4785                	li	a5,1
    80001f7a:	06f71763          	bne	a4,a5,80001fe8 <sched+0xa6>
  if (p->state == RUNNING)
    80001f7e:	4c98                	lw	a4,24(s1)
    80001f80:	4791                	li	a5,4
    80001f82:	06f70b63          	beq	a4,a5,80001ff8 <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001f86:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001f8a:	8b89                	andi	a5,a5,2
  if (intr_get())
    80001f8c:	efb5                	bnez	a5,80002008 <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001f8e:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80001f90:	0000f917          	auipc	s2,0xf
    80001f94:	bb090913          	addi	s2,s2,-1104 # 80010b40 <pid_lock>
    80001f98:	2781                	sext.w	a5,a5
    80001f9a:	079e                	slli	a5,a5,0x7
    80001f9c:	97ca                	add	a5,a5,s2
    80001f9e:	0ac7a983          	lw	s3,172(a5)
    80001fa2:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    80001fa4:	2781                	sext.w	a5,a5
    80001fa6:	079e                	slli	a5,a5,0x7
    80001fa8:	0000f597          	auipc	a1,0xf
    80001fac:	bd058593          	addi	a1,a1,-1072 # 80010b78 <cpus+0x8>
    80001fb0:	95be                	add	a1,a1,a5
    80001fb2:	06048513          	addi	a0,s1,96
    80001fb6:	00000097          	auipc	ra,0x0
    80001fba:	7ea080e7          	jalr	2026(ra) # 800027a0 <swtch>
    80001fbe:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80001fc0:	2781                	sext.w	a5,a5
    80001fc2:	079e                	slli	a5,a5,0x7
    80001fc4:	97ca                	add	a5,a5,s2
    80001fc6:	0b37a623          	sw	s3,172(a5)
}
    80001fca:	70a2                	ld	ra,40(sp)
    80001fcc:	7402                	ld	s0,32(sp)
    80001fce:	64e2                	ld	s1,24(sp)
    80001fd0:	6942                	ld	s2,16(sp)
    80001fd2:	69a2                	ld	s3,8(sp)
    80001fd4:	6145                	addi	sp,sp,48
    80001fd6:	8082                	ret
    panic("sched p->lock");
    80001fd8:	00006517          	auipc	a0,0x6
    80001fdc:	24050513          	addi	a0,a0,576 # 80008218 <digits+0x1d8>
    80001fe0:	ffffe097          	auipc	ra,0xffffe
    80001fe4:	55e080e7          	jalr	1374(ra) # 8000053e <panic>
    panic("sched locks");
    80001fe8:	00006517          	auipc	a0,0x6
    80001fec:	24050513          	addi	a0,a0,576 # 80008228 <digits+0x1e8>
    80001ff0:	ffffe097          	auipc	ra,0xffffe
    80001ff4:	54e080e7          	jalr	1358(ra) # 8000053e <panic>
    panic("sched running");
    80001ff8:	00006517          	auipc	a0,0x6
    80001ffc:	24050513          	addi	a0,a0,576 # 80008238 <digits+0x1f8>
    80002000:	ffffe097          	auipc	ra,0xffffe
    80002004:	53e080e7          	jalr	1342(ra) # 8000053e <panic>
    panic("sched interruptible");
    80002008:	00006517          	auipc	a0,0x6
    8000200c:	24050513          	addi	a0,a0,576 # 80008248 <digits+0x208>
    80002010:	ffffe097          	auipc	ra,0xffffe
    80002014:	52e080e7          	jalr	1326(ra) # 8000053e <panic>

0000000080002018 <yield>:
{
    80002018:	1101                	addi	sp,sp,-32
    8000201a:	ec06                	sd	ra,24(sp)
    8000201c:	e822                	sd	s0,16(sp)
    8000201e:	e426                	sd	s1,8(sp)
    80002020:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80002022:	00000097          	auipc	ra,0x0
    80002026:	98a080e7          	jalr	-1654(ra) # 800019ac <myproc>
    8000202a:	84aa                	mv	s1,a0
  acquire(&p->lock);
    8000202c:	fffff097          	auipc	ra,0xfffff
    80002030:	baa080e7          	jalr	-1110(ra) # 80000bd6 <acquire>
  p->state = RUNNABLE;
    80002034:	478d                	li	a5,3
    80002036:	cc9c                	sw	a5,24(s1)
  sched();
    80002038:	00000097          	auipc	ra,0x0
    8000203c:	f0a080e7          	jalr	-246(ra) # 80001f42 <sched>
  release(&p->lock);
    80002040:	8526                	mv	a0,s1
    80002042:	fffff097          	auipc	ra,0xfffff
    80002046:	c48080e7          	jalr	-952(ra) # 80000c8a <release>
}
    8000204a:	60e2                	ld	ra,24(sp)
    8000204c:	6442                	ld	s0,16(sp)
    8000204e:	64a2                	ld	s1,8(sp)
    80002050:	6105                	addi	sp,sp,32
    80002052:	8082                	ret

0000000080002054 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void sleep(void *chan, struct spinlock *lk)
{
    80002054:	7179                	addi	sp,sp,-48
    80002056:	f406                	sd	ra,40(sp)
    80002058:	f022                	sd	s0,32(sp)
    8000205a:	ec26                	sd	s1,24(sp)
    8000205c:	e84a                	sd	s2,16(sp)
    8000205e:	e44e                	sd	s3,8(sp)
    80002060:	1800                	addi	s0,sp,48
    80002062:	89aa                	mv	s3,a0
    80002064:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80002066:	00000097          	auipc	ra,0x0
    8000206a:	946080e7          	jalr	-1722(ra) # 800019ac <myproc>
    8000206e:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock); // DOC: sleeplock1
    80002070:	fffff097          	auipc	ra,0xfffff
    80002074:	b66080e7          	jalr	-1178(ra) # 80000bd6 <acquire>
  release(lk);
    80002078:	854a                	mv	a0,s2
    8000207a:	fffff097          	auipc	ra,0xfffff
    8000207e:	c10080e7          	jalr	-1008(ra) # 80000c8a <release>

  // Go to sleep.
  p->chan = chan;
    80002082:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    80002086:	4789                	li	a5,2
    80002088:	cc9c                	sw	a5,24(s1)

  sched();
    8000208a:	00000097          	auipc	ra,0x0
    8000208e:	eb8080e7          	jalr	-328(ra) # 80001f42 <sched>

  // Tidy up.
  p->chan = 0;
    80002092:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    80002096:	8526                	mv	a0,s1
    80002098:	fffff097          	auipc	ra,0xfffff
    8000209c:	bf2080e7          	jalr	-1038(ra) # 80000c8a <release>
  acquire(lk);
    800020a0:	854a                	mv	a0,s2
    800020a2:	fffff097          	auipc	ra,0xfffff
    800020a6:	b34080e7          	jalr	-1228(ra) # 80000bd6 <acquire>
}
    800020aa:	70a2                	ld	ra,40(sp)
    800020ac:	7402                	ld	s0,32(sp)
    800020ae:	64e2                	ld	s1,24(sp)
    800020b0:	6942                	ld	s2,16(sp)
    800020b2:	69a2                	ld	s3,8(sp)
    800020b4:	6145                	addi	sp,sp,48
    800020b6:	8082                	ret

00000000800020b8 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void wakeup(void *chan)
{
    800020b8:	7139                	addi	sp,sp,-64
    800020ba:	fc06                	sd	ra,56(sp)
    800020bc:	f822                	sd	s0,48(sp)
    800020be:	f426                	sd	s1,40(sp)
    800020c0:	f04a                	sd	s2,32(sp)
    800020c2:	ec4e                	sd	s3,24(sp)
    800020c4:	e852                	sd	s4,16(sp)
    800020c6:	e456                	sd	s5,8(sp)
    800020c8:	0080                	addi	s0,sp,64
    800020ca:	8a2a                	mv	s4,a0
  struct proc *p;

  for (p = proc; p < &proc[NPROC]; p++)
    800020cc:	0000f497          	auipc	s1,0xf
    800020d0:	ea448493          	addi	s1,s1,-348 # 80010f70 <proc>
  {
    if (p != myproc())
    {
      acquire(&p->lock);
      if (p->state == SLEEPING && p->chan == chan)
    800020d4:	4989                	li	s3,2
      {
        p->state = RUNNABLE;
    800020d6:	4a8d                	li	s5,3
  for (p = proc; p < &proc[NPROC]; p++)
    800020d8:	00015917          	auipc	s2,0x15
    800020dc:	89890913          	addi	s2,s2,-1896 # 80016970 <tickslock>
    800020e0:	a811                	j	800020f4 <wakeup+0x3c>
      }
      release(&p->lock);
    800020e2:	8526                	mv	a0,s1
    800020e4:	fffff097          	auipc	ra,0xfffff
    800020e8:	ba6080e7          	jalr	-1114(ra) # 80000c8a <release>
  for (p = proc; p < &proc[NPROC]; p++)
    800020ec:	16848493          	addi	s1,s1,360
    800020f0:	03248663          	beq	s1,s2,8000211c <wakeup+0x64>
    if (p != myproc())
    800020f4:	00000097          	auipc	ra,0x0
    800020f8:	8b8080e7          	jalr	-1864(ra) # 800019ac <myproc>
    800020fc:	fea488e3          	beq	s1,a0,800020ec <wakeup+0x34>
      acquire(&p->lock);
    80002100:	8526                	mv	a0,s1
    80002102:	fffff097          	auipc	ra,0xfffff
    80002106:	ad4080e7          	jalr	-1324(ra) # 80000bd6 <acquire>
      if (p->state == SLEEPING && p->chan == chan)
    8000210a:	4c9c                	lw	a5,24(s1)
    8000210c:	fd379be3          	bne	a5,s3,800020e2 <wakeup+0x2a>
    80002110:	709c                	ld	a5,32(s1)
    80002112:	fd4798e3          	bne	a5,s4,800020e2 <wakeup+0x2a>
        p->state = RUNNABLE;
    80002116:	0154ac23          	sw	s5,24(s1)
    8000211a:	b7e1                	j	800020e2 <wakeup+0x2a>
    }
  }
}
    8000211c:	70e2                	ld	ra,56(sp)
    8000211e:	7442                	ld	s0,48(sp)
    80002120:	74a2                	ld	s1,40(sp)
    80002122:	7902                	ld	s2,32(sp)
    80002124:	69e2                	ld	s3,24(sp)
    80002126:	6a42                	ld	s4,16(sp)
    80002128:	6aa2                	ld	s5,8(sp)
    8000212a:	6121                	addi	sp,sp,64
    8000212c:	8082                	ret

000000008000212e <reparent>:
{
    8000212e:	7179                	addi	sp,sp,-48
    80002130:	f406                	sd	ra,40(sp)
    80002132:	f022                	sd	s0,32(sp)
    80002134:	ec26                	sd	s1,24(sp)
    80002136:	e84a                	sd	s2,16(sp)
    80002138:	e44e                	sd	s3,8(sp)
    8000213a:	e052                	sd	s4,0(sp)
    8000213c:	1800                	addi	s0,sp,48
    8000213e:	892a                	mv	s2,a0
  for (pp = proc; pp < &proc[NPROC]; pp++)
    80002140:	0000f497          	auipc	s1,0xf
    80002144:	e3048493          	addi	s1,s1,-464 # 80010f70 <proc>
      pp->parent = initproc;
    80002148:	00006a17          	auipc	s4,0x6
    8000214c:	780a0a13          	addi	s4,s4,1920 # 800088c8 <initproc>
  for (pp = proc; pp < &proc[NPROC]; pp++)
    80002150:	00015997          	auipc	s3,0x15
    80002154:	82098993          	addi	s3,s3,-2016 # 80016970 <tickslock>
    80002158:	a029                	j	80002162 <reparent+0x34>
    8000215a:	16848493          	addi	s1,s1,360
    8000215e:	01348d63          	beq	s1,s3,80002178 <reparent+0x4a>
    if (pp->parent == p)
    80002162:	7c9c                	ld	a5,56(s1)
    80002164:	ff279be3          	bne	a5,s2,8000215a <reparent+0x2c>
      pp->parent = initproc;
    80002168:	000a3503          	ld	a0,0(s4)
    8000216c:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    8000216e:	00000097          	auipc	ra,0x0
    80002172:	f4a080e7          	jalr	-182(ra) # 800020b8 <wakeup>
    80002176:	b7d5                	j	8000215a <reparent+0x2c>
}
    80002178:	70a2                	ld	ra,40(sp)
    8000217a:	7402                	ld	s0,32(sp)
    8000217c:	64e2                	ld	s1,24(sp)
    8000217e:	6942                	ld	s2,16(sp)
    80002180:	69a2                	ld	s3,8(sp)
    80002182:	6a02                	ld	s4,0(sp)
    80002184:	6145                	addi	sp,sp,48
    80002186:	8082                	ret

0000000080002188 <exit>:
{
    80002188:	7179                	addi	sp,sp,-48
    8000218a:	f406                	sd	ra,40(sp)
    8000218c:	f022                	sd	s0,32(sp)
    8000218e:	ec26                	sd	s1,24(sp)
    80002190:	e84a                	sd	s2,16(sp)
    80002192:	e44e                	sd	s3,8(sp)
    80002194:	e052                	sd	s4,0(sp)
    80002196:	1800                	addi	s0,sp,48
    80002198:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    8000219a:	00000097          	auipc	ra,0x0
    8000219e:	812080e7          	jalr	-2030(ra) # 800019ac <myproc>
    800021a2:	89aa                	mv	s3,a0
  if (p == initproc)
    800021a4:	00006797          	auipc	a5,0x6
    800021a8:	7247b783          	ld	a5,1828(a5) # 800088c8 <initproc>
    800021ac:	0d050493          	addi	s1,a0,208
    800021b0:	15050913          	addi	s2,a0,336
    800021b4:	02a79363          	bne	a5,a0,800021da <exit+0x52>
    panic("init exiting");
    800021b8:	00006517          	auipc	a0,0x6
    800021bc:	0a850513          	addi	a0,a0,168 # 80008260 <digits+0x220>
    800021c0:	ffffe097          	auipc	ra,0xffffe
    800021c4:	37e080e7          	jalr	894(ra) # 8000053e <panic>
      fileclose(f);
    800021c8:	00002097          	auipc	ra,0x2
    800021cc:	506080e7          	jalr	1286(ra) # 800046ce <fileclose>
      p->ofile[fd] = 0;
    800021d0:	0004b023          	sd	zero,0(s1)
  for (int fd = 0; fd < NOFILE; fd++)
    800021d4:	04a1                	addi	s1,s1,8
    800021d6:	01248563          	beq	s1,s2,800021e0 <exit+0x58>
    if (p->ofile[fd])
    800021da:	6088                	ld	a0,0(s1)
    800021dc:	f575                	bnez	a0,800021c8 <exit+0x40>
    800021de:	bfdd                	j	800021d4 <exit+0x4c>
  begin_op();
    800021e0:	00002097          	auipc	ra,0x2
    800021e4:	022080e7          	jalr	34(ra) # 80004202 <begin_op>
  iput(p->cwd);
    800021e8:	1509b503          	ld	a0,336(s3)
    800021ec:	00002097          	auipc	ra,0x2
    800021f0:	80e080e7          	jalr	-2034(ra) # 800039fa <iput>
  end_op();
    800021f4:	00002097          	auipc	ra,0x2
    800021f8:	08e080e7          	jalr	142(ra) # 80004282 <end_op>
  p->cwd = 0;
    800021fc:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    80002200:	0000f497          	auipc	s1,0xf
    80002204:	95848493          	addi	s1,s1,-1704 # 80010b58 <wait_lock>
    80002208:	8526                	mv	a0,s1
    8000220a:	fffff097          	auipc	ra,0xfffff
    8000220e:	9cc080e7          	jalr	-1588(ra) # 80000bd6 <acquire>
  reparent(p);
    80002212:	854e                	mv	a0,s3
    80002214:	00000097          	auipc	ra,0x0
    80002218:	f1a080e7          	jalr	-230(ra) # 8000212e <reparent>
  wakeup(p->parent);
    8000221c:	0389b503          	ld	a0,56(s3)
    80002220:	00000097          	auipc	ra,0x0
    80002224:	e98080e7          	jalr	-360(ra) # 800020b8 <wakeup>
  acquire(&p->lock);
    80002228:	854e                	mv	a0,s3
    8000222a:	fffff097          	auipc	ra,0xfffff
    8000222e:	9ac080e7          	jalr	-1620(ra) # 80000bd6 <acquire>
  p->xstate = status;
    80002232:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    80002236:	4795                	li	a5,5
    80002238:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    8000223c:	8526                	mv	a0,s1
    8000223e:	fffff097          	auipc	ra,0xfffff
    80002242:	a4c080e7          	jalr	-1460(ra) # 80000c8a <release>
  sched();
    80002246:	00000097          	auipc	ra,0x0
    8000224a:	cfc080e7          	jalr	-772(ra) # 80001f42 <sched>
  panic("zombie exit");
    8000224e:	00006517          	auipc	a0,0x6
    80002252:	02250513          	addi	a0,a0,34 # 80008270 <digits+0x230>
    80002256:	ffffe097          	auipc	ra,0xffffe
    8000225a:	2e8080e7          	jalr	744(ra) # 8000053e <panic>

000000008000225e <kill>:

// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int kill(int pid)
{
    8000225e:	7179                	addi	sp,sp,-48
    80002260:	f406                	sd	ra,40(sp)
    80002262:	f022                	sd	s0,32(sp)
    80002264:	ec26                	sd	s1,24(sp)
    80002266:	e84a                	sd	s2,16(sp)
    80002268:	e44e                	sd	s3,8(sp)
    8000226a:	1800                	addi	s0,sp,48
    8000226c:	892a                	mv	s2,a0
  struct proc *p;

  for (p = proc; p < &proc[NPROC]; p++)
    8000226e:	0000f497          	auipc	s1,0xf
    80002272:	d0248493          	addi	s1,s1,-766 # 80010f70 <proc>
    80002276:	00014997          	auipc	s3,0x14
    8000227a:	6fa98993          	addi	s3,s3,1786 # 80016970 <tickslock>
  {
    acquire(&p->lock);
    8000227e:	8526                	mv	a0,s1
    80002280:	fffff097          	auipc	ra,0xfffff
    80002284:	956080e7          	jalr	-1706(ra) # 80000bd6 <acquire>
    if (p->pid == pid)
    80002288:	589c                	lw	a5,48(s1)
    8000228a:	01278d63          	beq	a5,s2,800022a4 <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    8000228e:	8526                	mv	a0,s1
    80002290:	fffff097          	auipc	ra,0xfffff
    80002294:	9fa080e7          	jalr	-1542(ra) # 80000c8a <release>
  for (p = proc; p < &proc[NPROC]; p++)
    80002298:	16848493          	addi	s1,s1,360
    8000229c:	ff3491e3          	bne	s1,s3,8000227e <kill+0x20>
  }
  return -1;
    800022a0:	557d                	li	a0,-1
    800022a2:	a829                	j	800022bc <kill+0x5e>
      p->killed = 1;
    800022a4:	4785                	li	a5,1
    800022a6:	d49c                	sw	a5,40(s1)
      if (p->state == SLEEPING)
    800022a8:	4c98                	lw	a4,24(s1)
    800022aa:	4789                	li	a5,2
    800022ac:	00f70f63          	beq	a4,a5,800022ca <kill+0x6c>
      release(&p->lock);
    800022b0:	8526                	mv	a0,s1
    800022b2:	fffff097          	auipc	ra,0xfffff
    800022b6:	9d8080e7          	jalr	-1576(ra) # 80000c8a <release>
      return 0;
    800022ba:	4501                	li	a0,0
}
    800022bc:	70a2                	ld	ra,40(sp)
    800022be:	7402                	ld	s0,32(sp)
    800022c0:	64e2                	ld	s1,24(sp)
    800022c2:	6942                	ld	s2,16(sp)
    800022c4:	69a2                	ld	s3,8(sp)
    800022c6:	6145                	addi	sp,sp,48
    800022c8:	8082                	ret
        p->state = RUNNABLE;
    800022ca:	478d                	li	a5,3
    800022cc:	cc9c                	sw	a5,24(s1)
    800022ce:	b7cd                	j	800022b0 <kill+0x52>

00000000800022d0 <print_pigs>:

void print_pigs(pigtable_t pigtable, int pigdepth)
{
  if (pigdepth > 2)
    800022d0:	4789                	li	a5,2
    800022d2:	16b7d163          	bge	a5,a1,80002434 <print_pigs+0x164>
{
    800022d6:	7171                	addi	sp,sp,-176
    800022d8:	f506                	sd	ra,168(sp)
    800022da:	f122                	sd	s0,160(sp)
    800022dc:	ed26                	sd	s1,152(sp)
    800022de:	e94a                	sd	s2,144(sp)
    800022e0:	e54e                	sd	s3,136(sp)
    800022e2:	e152                	sd	s4,128(sp)
    800022e4:	fcd6                	sd	s5,120(sp)
    800022e6:	f8da                	sd	s6,112(sp)
    800022e8:	f4de                	sd	s7,104(sp)
    800022ea:	f0e2                	sd	s8,96(sp)
    800022ec:	ece6                	sd	s9,88(sp)
    800022ee:	1900                	addi	s0,sp,176
    800022f0:	8aae                	mv	s5,a1
    800022f2:	892a                	mv	s2,a0
    800022f4:	6a05                	lui	s4,0x1
    800022f6:	9a2a                	add	s4,s4,a0
    800022f8:	00058b1b          	sext.w	s6,a1
    800022fc:	fff58c9b          	addiw	s9,a1,-1
    80002300:	1c82                	slli	s9,s9,0x20
    80002302:	020cdc93          	srli	s9,s9,0x20
    80002306:	f5140793          	addi	a5,s0,-175
    8000230a:	019789b3          	add	s3,a5,s9
        for (; d < pigdepth; d++)
        {
          str[d] = '\t';
        }
        safestrcpy(str + d, "%d: %p ", 6);
        d += 6;
    8000230e:	00658b9b          	addiw	s7,a1,6
        str[d++] = (pte & PTE_R) ? 'r' : '-';
    80002312:	00758c1b          	addiw	s8,a1,7
    80002316:	fa040793          	addi	a5,s0,-96
    8000231a:	9bbe                	add	s7,s7,a5
        str[d++] = (pte & PTE_W) ? 'w' : '-';
    8000231c:	9c3e                	add	s8,s8,a5
    8000231e:	a059                	j	800023a4 <print_pigs+0xd4>
    80002320:	f5040793          	addi	a5,s0,-176
    80002324:	f5140713          	addi	a4,s0,-175
    80002328:	00ec86b3          	add	a3,s9,a4
          str[d] = '\t';
    8000232c:	4725                	li	a4,9
    8000232e:	00e78023          	sb	a4,0(a5)
        for (; d < pigdepth; d++)
    80002332:	0785                	addi	a5,a5,1
    80002334:	fed79de3          	bne	a5,a3,8000232e <print_pigs+0x5e>
        safestrcpy(str + d, "%d: %p ", 6);
    80002338:	4619                	li	a2,6
    8000233a:	00006597          	auipc	a1,0x6
    8000233e:	f4658593          	addi	a1,a1,-186 # 80008280 <digits+0x240>
    80002342:	f5040793          	addi	a5,s0,-176
    80002346:	01578533          	add	a0,a5,s5
    8000234a:	fffff097          	auipc	ra,0xfffff
    8000234e:	ad2080e7          	jalr	-1326(ra) # 80000e1c <safestrcpy>
        str[d++] = '\n';
    80002352:	47a9                	li	a5,10
    80002354:	fafb8823          	sb	a5,-80(s7) # ffffffffffffefb0 <end+0xffffffff7ffdd260>
        printf(str, pte);
    80002358:	85a6                	mv	a1,s1
    8000235a:	f5040513          	addi	a0,s0,-176
    8000235e:	ffffe097          	auipc	ra,0xffffe
    80002362:	22a080e7          	jalr	554(ra) # 80000588 <printf>
        pigtable_t child = (pigtable_t)PTE2PA(pte);
    80002366:	00a4d513          	srli	a0,s1,0xa
        print_pigs(child, pigdepth + 1);
    8000236a:	001a859b          	addiw	a1,s5,1
    8000236e:	0532                	slli	a0,a0,0xc
    80002370:	00000097          	auipc	ra,0x0
    80002374:	f60080e7          	jalr	-160(ra) # 800022d0 <print_pigs>
    80002378:	a01d                	j	8000239e <print_pigs+0xce>
        str[d++] = (pte & PTE_X) ? 'x' : '-';
    8000237a:	fa040713          	addi	a4,s0,-96
    8000237e:	97ba                	add	a5,a5,a4
    80002380:	fad78823          	sb	a3,-80(a5)
        str[d++] = '\n';
    80002384:	009b079b          	addiw	a5,s6,9
    80002388:	97ba                	add	a5,a5,a4
    8000238a:	4729                	li	a4,10
    8000238c:	fae78823          	sb	a4,-80(a5)

        printf(str, pte);
    80002390:	85a6                	mv	a1,s1
    80002392:	f5040513          	addi	a0,s0,-176
    80002396:	ffffe097          	auipc	ra,0xffffe
    8000239a:	1f2080e7          	jalr	498(ra) # 80000588 <printf>
    for (int i = 0; i < 512; i++)
    8000239e:	0921                	addi	s2,s2,8
    800023a0:	07490d63          	beq	s2,s4,8000241a <print_pigs+0x14a>
      pte_t pte = pigtable[i];
    800023a4:	00093483          	ld	s1,0(s2)
      if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
    800023a8:	00f4f713          	andi	a4,s1,15
    800023ac:	4785                	li	a5,1
    800023ae:	f6f709e3          	beq	a4,a5,80002320 <print_pigs+0x50>
      else if ((pte & PTE_V))
    800023b2:	0014f793          	andi	a5,s1,1
    800023b6:	d7e5                	beqz	a5,8000239e <print_pigs+0xce>
    800023b8:	f5040793          	addi	a5,s0,-176
          str[d] = '\t';
    800023bc:	4725                	li	a4,9
    800023be:	00e78023          	sb	a4,0(a5)
        for (; d < pigdepth; d++)
    800023c2:	0785                	addi	a5,a5,1
    800023c4:	ff379de3          	bne	a5,s3,800023be <print_pigs+0xee>
        safestrcpy(str + d, "%d: %p ", 6);
    800023c8:	4619                	li	a2,6
    800023ca:	00006597          	auipc	a1,0x6
    800023ce:	eb658593          	addi	a1,a1,-330 # 80008280 <digits+0x240>
    800023d2:	f5040793          	addi	a5,s0,-176
    800023d6:	01578533          	add	a0,a5,s5
    800023da:	fffff097          	auipc	ra,0xfffff
    800023de:	a42080e7          	jalr	-1470(ra) # 80000e1c <safestrcpy>
        str[d++] = (pte & PTE_R) ? 'r' : '-';
    800023e2:	0024f793          	andi	a5,s1,2
    800023e6:	07200713          	li	a4,114
    800023ea:	e399                	bnez	a5,800023f0 <print_pigs+0x120>
    800023ec:	02d00713          	li	a4,45
    800023f0:	faeb8823          	sb	a4,-80(s7)
        str[d++] = (pte & PTE_W) ? 'w' : '-';
    800023f4:	0044f793          	andi	a5,s1,4
    800023f8:	07700713          	li	a4,119
    800023fc:	e399                	bnez	a5,80002402 <print_pigs+0x132>
    800023fe:	02d00713          	li	a4,45
    80002402:	008b079b          	addiw	a5,s6,8
    80002406:	faec0823          	sb	a4,-80(s8)
        str[d++] = (pte & PTE_X) ? 'x' : '-';
    8000240a:	0084f713          	andi	a4,s1,8
    8000240e:	07800693          	li	a3,120
    80002412:	f725                	bnez	a4,8000237a <print_pigs+0xaa>
    80002414:	02d00693          	li	a3,45
    80002418:	b78d                	j	8000237a <print_pigs+0xaa>
      }
    }
  }
}
    8000241a:	70aa                	ld	ra,168(sp)
    8000241c:	740a                	ld	s0,160(sp)
    8000241e:	64ea                	ld	s1,152(sp)
    80002420:	694a                	ld	s2,144(sp)
    80002422:	69aa                	ld	s3,136(sp)
    80002424:	6a0a                	ld	s4,128(sp)
    80002426:	7ae6                	ld	s5,120(sp)
    80002428:	7b46                	ld	s6,112(sp)
    8000242a:	7ba6                	ld	s7,104(sp)
    8000242c:	7c06                	ld	s8,96(sp)
    8000242e:	6ce6                	ld	s9,88(sp)
    80002430:	614d                	addi	sp,sp,176
    80002432:	8082                	ret
    80002434:	8082                	ret

0000000080002436 <pigwalk>:

int pigwalk(int pid)
{
    80002436:	7179                	addi	sp,sp,-48
    80002438:	f406                	sd	ra,40(sp)
    8000243a:	f022                	sd	s0,32(sp)
    8000243c:	ec26                	sd	s1,24(sp)
    8000243e:	e84a                	sd	s2,16(sp)
    80002440:	e44e                	sd	s3,8(sp)
    80002442:	1800                	addi	s0,sp,48
    80002444:	892a                	mv	s2,a0
  struct proc *p;

  for (p = proc; p < &proc[NPROC]; p++)
    80002446:	0000f497          	auipc	s1,0xf
    8000244a:	b2a48493          	addi	s1,s1,-1238 # 80010f70 <proc>
    8000244e:	00014997          	auipc	s3,0x14
    80002452:	52298993          	addi	s3,s3,1314 # 80016970 <tickslock>
  {
    acquire(&p->lock);
    80002456:	8526                	mv	a0,s1
    80002458:	ffffe097          	auipc	ra,0xffffe
    8000245c:	77e080e7          	jalr	1918(ra) # 80000bd6 <acquire>
    if (p->pid == pid)
    80002460:	589c                	lw	a5,48(s1)
    80002462:	01278d63          	beq	a5,s2,8000247c <pigwalk+0x46>
      pigtable_t pigtable = p->pigtable;
      print_pigs(pigtable, 0);
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80002466:	8526                	mv	a0,s1
    80002468:	fffff097          	auipc	ra,0xfffff
    8000246c:	822080e7          	jalr	-2014(ra) # 80000c8a <release>
  for (p = proc; p < &proc[NPROC]; p++)
    80002470:	16848493          	addi	s1,s1,360
    80002474:	ff3491e3          	bne	s1,s3,80002456 <pigwalk+0x20>
  }
  return -1;
    80002478:	557d                	li	a0,-1
    8000247a:	a829                	j	80002494 <pigwalk+0x5e>
      print_pigs(pigtable, 0);
    8000247c:	4581                	li	a1,0
    8000247e:	68a8                	ld	a0,80(s1)
    80002480:	00000097          	auipc	ra,0x0
    80002484:	e50080e7          	jalr	-432(ra) # 800022d0 <print_pigs>
      release(&p->lock);
    80002488:	8526                	mv	a0,s1
    8000248a:	fffff097          	auipc	ra,0xfffff
    8000248e:	800080e7          	jalr	-2048(ra) # 80000c8a <release>
      return 0;
    80002492:	4501                	li	a0,0
}
    80002494:	70a2                	ld	ra,40(sp)
    80002496:	7402                	ld	s0,32(sp)
    80002498:	64e2                	ld	s1,24(sp)
    8000249a:	6942                	ld	s2,16(sp)
    8000249c:	69a2                	ld	s3,8(sp)
    8000249e:	6145                	addi	sp,sp,48
    800024a0:	8082                	ret

00000000800024a2 <pigs>:

int pigs(int pid)
{
    800024a2:	1141                	addi	sp,sp,-16
    800024a4:	e406                	sd	ra,8(sp)
    800024a6:	e022                	sd	s0,0(sp)
    800024a8:	0800                	addi	s0,sp,16
  return pigwalk(pid);
    800024aa:	00000097          	auipc	ra,0x0
    800024ae:	f8c080e7          	jalr	-116(ra) # 80002436 <pigwalk>
}
    800024b2:	60a2                	ld	ra,8(sp)
    800024b4:	6402                	ld	s0,0(sp)
    800024b6:	0141                	addi	sp,sp,16
    800024b8:	8082                	ret

00000000800024ba <setkilled>:

void setkilled(struct proc *p)
{
    800024ba:	1101                	addi	sp,sp,-32
    800024bc:	ec06                	sd	ra,24(sp)
    800024be:	e822                	sd	s0,16(sp)
    800024c0:	e426                	sd	s1,8(sp)
    800024c2:	1000                	addi	s0,sp,32
    800024c4:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800024c6:	ffffe097          	auipc	ra,0xffffe
    800024ca:	710080e7          	jalr	1808(ra) # 80000bd6 <acquire>
  p->killed = 1;
    800024ce:	4785                	li	a5,1
    800024d0:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    800024d2:	8526                	mv	a0,s1
    800024d4:	ffffe097          	auipc	ra,0xffffe
    800024d8:	7b6080e7          	jalr	1974(ra) # 80000c8a <release>
}
    800024dc:	60e2                	ld	ra,24(sp)
    800024de:	6442                	ld	s0,16(sp)
    800024e0:	64a2                	ld	s1,8(sp)
    800024e2:	6105                	addi	sp,sp,32
    800024e4:	8082                	ret

00000000800024e6 <killed>:

int killed(struct proc *p)
{
    800024e6:	1101                	addi	sp,sp,-32
    800024e8:	ec06                	sd	ra,24(sp)
    800024ea:	e822                	sd	s0,16(sp)
    800024ec:	e426                	sd	s1,8(sp)
    800024ee:	e04a                	sd	s2,0(sp)
    800024f0:	1000                	addi	s0,sp,32
    800024f2:	84aa                	mv	s1,a0
  int k;

  acquire(&p->lock);
    800024f4:	ffffe097          	auipc	ra,0xffffe
    800024f8:	6e2080e7          	jalr	1762(ra) # 80000bd6 <acquire>
  k = p->killed;
    800024fc:	0284a903          	lw	s2,40(s1)
  release(&p->lock);
    80002500:	8526                	mv	a0,s1
    80002502:	ffffe097          	auipc	ra,0xffffe
    80002506:	788080e7          	jalr	1928(ra) # 80000c8a <release>
  return k;
}
    8000250a:	854a                	mv	a0,s2
    8000250c:	60e2                	ld	ra,24(sp)
    8000250e:	6442                	ld	s0,16(sp)
    80002510:	64a2                	ld	s1,8(sp)
    80002512:	6902                	ld	s2,0(sp)
    80002514:	6105                	addi	sp,sp,32
    80002516:	8082                	ret

0000000080002518 <wait>:
{
    80002518:	715d                	addi	sp,sp,-80
    8000251a:	e486                	sd	ra,72(sp)
    8000251c:	e0a2                	sd	s0,64(sp)
    8000251e:	fc26                	sd	s1,56(sp)
    80002520:	f84a                	sd	s2,48(sp)
    80002522:	f44e                	sd	s3,40(sp)
    80002524:	f052                	sd	s4,32(sp)
    80002526:	ec56                	sd	s5,24(sp)
    80002528:	e85a                	sd	s6,16(sp)
    8000252a:	e45e                	sd	s7,8(sp)
    8000252c:	e062                	sd	s8,0(sp)
    8000252e:	0880                	addi	s0,sp,80
    80002530:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    80002532:	fffff097          	auipc	ra,0xfffff
    80002536:	47a080e7          	jalr	1146(ra) # 800019ac <myproc>
    8000253a:	892a                	mv	s2,a0
  acquire(&wait_lock);
    8000253c:	0000e517          	auipc	a0,0xe
    80002540:	61c50513          	addi	a0,a0,1564 # 80010b58 <wait_lock>
    80002544:	ffffe097          	auipc	ra,0xffffe
    80002548:	692080e7          	jalr	1682(ra) # 80000bd6 <acquire>
    havekids = 0;
    8000254c:	4b81                	li	s7,0
        if (pp->state == ZOMBIE)
    8000254e:	4a15                	li	s4,5
        havekids = 1;
    80002550:	4a85                	li	s5,1
    for (pp = proc; pp < &proc[NPROC]; pp++)
    80002552:	00014997          	auipc	s3,0x14
    80002556:	41e98993          	addi	s3,s3,1054 # 80016970 <tickslock>
    sleep(p, &wait_lock); // DOC: wait-sleep
    8000255a:	0000ec17          	auipc	s8,0xe
    8000255e:	5fec0c13          	addi	s8,s8,1534 # 80010b58 <wait_lock>
    havekids = 0;
    80002562:	875e                	mv	a4,s7
    for (pp = proc; pp < &proc[NPROC]; pp++)
    80002564:	0000f497          	auipc	s1,0xf
    80002568:	a0c48493          	addi	s1,s1,-1524 # 80010f70 <proc>
    8000256c:	a0bd                	j	800025da <wait+0xc2>
          pid = pp->pid;
    8000256e:	0304a983          	lw	s3,48(s1)
          if (addr != 0 && copyout(p->pigtable, addr, (char *)&pp->xstate,
    80002572:	000b0e63          	beqz	s6,8000258e <wait+0x76>
    80002576:	4691                	li	a3,4
    80002578:	02c48613          	addi	a2,s1,44
    8000257c:	85da                	mv	a1,s6
    8000257e:	05093503          	ld	a0,80(s2)
    80002582:	fffff097          	auipc	ra,0xfffff
    80002586:	0e6080e7          	jalr	230(ra) # 80001668 <copyout>
    8000258a:	02054563          	bltz	a0,800025b4 <wait+0x9c>
          freeproc(pp);
    8000258e:	8526                	mv	a0,s1
    80002590:	fffff097          	auipc	ra,0xfffff
    80002594:	5ce080e7          	jalr	1486(ra) # 80001b5e <freeproc>
          release(&pp->lock);
    80002598:	8526                	mv	a0,s1
    8000259a:	ffffe097          	auipc	ra,0xffffe
    8000259e:	6f0080e7          	jalr	1776(ra) # 80000c8a <release>
          release(&wait_lock);
    800025a2:	0000e517          	auipc	a0,0xe
    800025a6:	5b650513          	addi	a0,a0,1462 # 80010b58 <wait_lock>
    800025aa:	ffffe097          	auipc	ra,0xffffe
    800025ae:	6e0080e7          	jalr	1760(ra) # 80000c8a <release>
          return pid;
    800025b2:	a0b5                	j	8000261e <wait+0x106>
            release(&pp->lock);
    800025b4:	8526                	mv	a0,s1
    800025b6:	ffffe097          	auipc	ra,0xffffe
    800025ba:	6d4080e7          	jalr	1748(ra) # 80000c8a <release>
            release(&wait_lock);
    800025be:	0000e517          	auipc	a0,0xe
    800025c2:	59a50513          	addi	a0,a0,1434 # 80010b58 <wait_lock>
    800025c6:	ffffe097          	auipc	ra,0xffffe
    800025ca:	6c4080e7          	jalr	1732(ra) # 80000c8a <release>
            return -1;
    800025ce:	59fd                	li	s3,-1
    800025d0:	a0b9                	j	8000261e <wait+0x106>
    for (pp = proc; pp < &proc[NPROC]; pp++)
    800025d2:	16848493          	addi	s1,s1,360
    800025d6:	03348463          	beq	s1,s3,800025fe <wait+0xe6>
      if (pp->parent == p)
    800025da:	7c9c                	ld	a5,56(s1)
    800025dc:	ff279be3          	bne	a5,s2,800025d2 <wait+0xba>
        acquire(&pp->lock);
    800025e0:	8526                	mv	a0,s1
    800025e2:	ffffe097          	auipc	ra,0xffffe
    800025e6:	5f4080e7          	jalr	1524(ra) # 80000bd6 <acquire>
        if (pp->state == ZOMBIE)
    800025ea:	4c9c                	lw	a5,24(s1)
    800025ec:	f94781e3          	beq	a5,s4,8000256e <wait+0x56>
        release(&pp->lock);
    800025f0:	8526                	mv	a0,s1
    800025f2:	ffffe097          	auipc	ra,0xffffe
    800025f6:	698080e7          	jalr	1688(ra) # 80000c8a <release>
        havekids = 1;
    800025fa:	8756                	mv	a4,s5
    800025fc:	bfd9                	j	800025d2 <wait+0xba>
    if (!havekids || killed(p))
    800025fe:	c719                	beqz	a4,8000260c <wait+0xf4>
    80002600:	854a                	mv	a0,s2
    80002602:	00000097          	auipc	ra,0x0
    80002606:	ee4080e7          	jalr	-284(ra) # 800024e6 <killed>
    8000260a:	c51d                	beqz	a0,80002638 <wait+0x120>
      release(&wait_lock);
    8000260c:	0000e517          	auipc	a0,0xe
    80002610:	54c50513          	addi	a0,a0,1356 # 80010b58 <wait_lock>
    80002614:	ffffe097          	auipc	ra,0xffffe
    80002618:	676080e7          	jalr	1654(ra) # 80000c8a <release>
      return -1;
    8000261c:	59fd                	li	s3,-1
}
    8000261e:	854e                	mv	a0,s3
    80002620:	60a6                	ld	ra,72(sp)
    80002622:	6406                	ld	s0,64(sp)
    80002624:	74e2                	ld	s1,56(sp)
    80002626:	7942                	ld	s2,48(sp)
    80002628:	79a2                	ld	s3,40(sp)
    8000262a:	7a02                	ld	s4,32(sp)
    8000262c:	6ae2                	ld	s5,24(sp)
    8000262e:	6b42                	ld	s6,16(sp)
    80002630:	6ba2                	ld	s7,8(sp)
    80002632:	6c02                	ld	s8,0(sp)
    80002634:	6161                	addi	sp,sp,80
    80002636:	8082                	ret
    sleep(p, &wait_lock); // DOC: wait-sleep
    80002638:	85e2                	mv	a1,s8
    8000263a:	854a                	mv	a0,s2
    8000263c:	00000097          	auipc	ra,0x0
    80002640:	a18080e7          	jalr	-1512(ra) # 80002054 <sleep>
    havekids = 0;
    80002644:	bf39                	j	80002562 <wait+0x4a>

0000000080002646 <either_copyout>:

// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80002646:	7179                	addi	sp,sp,-48
    80002648:	f406                	sd	ra,40(sp)
    8000264a:	f022                	sd	s0,32(sp)
    8000264c:	ec26                	sd	s1,24(sp)
    8000264e:	e84a                	sd	s2,16(sp)
    80002650:	e44e                	sd	s3,8(sp)
    80002652:	e052                	sd	s4,0(sp)
    80002654:	1800                	addi	s0,sp,48
    80002656:	84aa                	mv	s1,a0
    80002658:	892e                	mv	s2,a1
    8000265a:	89b2                	mv	s3,a2
    8000265c:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    8000265e:	fffff097          	auipc	ra,0xfffff
    80002662:	34e080e7          	jalr	846(ra) # 800019ac <myproc>
  if (user_dst)
    80002666:	c08d                	beqz	s1,80002688 <either_copyout+0x42>
  {
    return copyout(p->pigtable, dst, src, len);
    80002668:	86d2                	mv	a3,s4
    8000266a:	864e                	mv	a2,s3
    8000266c:	85ca                	mv	a1,s2
    8000266e:	6928                	ld	a0,80(a0)
    80002670:	fffff097          	auipc	ra,0xfffff
    80002674:	ff8080e7          	jalr	-8(ra) # 80001668 <copyout>
  else
  {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    80002678:	70a2                	ld	ra,40(sp)
    8000267a:	7402                	ld	s0,32(sp)
    8000267c:	64e2                	ld	s1,24(sp)
    8000267e:	6942                	ld	s2,16(sp)
    80002680:	69a2                	ld	s3,8(sp)
    80002682:	6a02                	ld	s4,0(sp)
    80002684:	6145                	addi	sp,sp,48
    80002686:	8082                	ret
    memmove((char *)dst, src, len);
    80002688:	000a061b          	sext.w	a2,s4
    8000268c:	85ce                	mv	a1,s3
    8000268e:	854a                	mv	a0,s2
    80002690:	ffffe097          	auipc	ra,0xffffe
    80002694:	69e080e7          	jalr	1694(ra) # 80000d2e <memmove>
    return 0;
    80002698:	8526                	mv	a0,s1
    8000269a:	bff9                	j	80002678 <either_copyout+0x32>

000000008000269c <either_copyin>:

// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    8000269c:	7179                	addi	sp,sp,-48
    8000269e:	f406                	sd	ra,40(sp)
    800026a0:	f022                	sd	s0,32(sp)
    800026a2:	ec26                	sd	s1,24(sp)
    800026a4:	e84a                	sd	s2,16(sp)
    800026a6:	e44e                	sd	s3,8(sp)
    800026a8:	e052                	sd	s4,0(sp)
    800026aa:	1800                	addi	s0,sp,48
    800026ac:	892a                	mv	s2,a0
    800026ae:	84ae                	mv	s1,a1
    800026b0:	89b2                	mv	s3,a2
    800026b2:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800026b4:	fffff097          	auipc	ra,0xfffff
    800026b8:	2f8080e7          	jalr	760(ra) # 800019ac <myproc>
  if (user_src)
    800026bc:	c08d                	beqz	s1,800026de <either_copyin+0x42>
  {
    return copyin(p->pigtable, dst, src, len);
    800026be:	86d2                	mv	a3,s4
    800026c0:	864e                	mv	a2,s3
    800026c2:	85ca                	mv	a1,s2
    800026c4:	6928                	ld	a0,80(a0)
    800026c6:	fffff097          	auipc	ra,0xfffff
    800026ca:	02e080e7          	jalr	46(ra) # 800016f4 <copyin>
  else
  {
    memmove(dst, (char *)src, len);
    return 0;
  }
}
    800026ce:	70a2                	ld	ra,40(sp)
    800026d0:	7402                	ld	s0,32(sp)
    800026d2:	64e2                	ld	s1,24(sp)
    800026d4:	6942                	ld	s2,16(sp)
    800026d6:	69a2                	ld	s3,8(sp)
    800026d8:	6a02                	ld	s4,0(sp)
    800026da:	6145                	addi	sp,sp,48
    800026dc:	8082                	ret
    memmove(dst, (char *)src, len);
    800026de:	000a061b          	sext.w	a2,s4
    800026e2:	85ce                	mv	a1,s3
    800026e4:	854a                	mv	a0,s2
    800026e6:	ffffe097          	auipc	ra,0xffffe
    800026ea:	648080e7          	jalr	1608(ra) # 80000d2e <memmove>
    return 0;
    800026ee:	8526                	mv	a0,s1
    800026f0:	bff9                	j	800026ce <either_copyin+0x32>

00000000800026f2 <procdump>:

// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void procdump(void)
{
    800026f2:	715d                	addi	sp,sp,-80
    800026f4:	e486                	sd	ra,72(sp)
    800026f6:	e0a2                	sd	s0,64(sp)
    800026f8:	fc26                	sd	s1,56(sp)
    800026fa:	f84a                	sd	s2,48(sp)
    800026fc:	f44e                	sd	s3,40(sp)
    800026fe:	f052                	sd	s4,32(sp)
    80002700:	ec56                	sd	s5,24(sp)
    80002702:	e85a                	sd	s6,16(sp)
    80002704:	e45e                	sd	s7,8(sp)
    80002706:	0880                	addi	s0,sp,80
      [RUNNING] "run   ",
      [ZOMBIE] "zombie"};
  struct proc *p;
  char *state;

  printf("\n");
    80002708:	00006517          	auipc	a0,0x6
    8000270c:	9c050513          	addi	a0,a0,-1600 # 800080c8 <digits+0x88>
    80002710:	ffffe097          	auipc	ra,0xffffe
    80002714:	e78080e7          	jalr	-392(ra) # 80000588 <printf>
  for (p = proc; p < &proc[NPROC]; p++)
    80002718:	0000f497          	auipc	s1,0xf
    8000271c:	9b048493          	addi	s1,s1,-1616 # 800110c8 <proc+0x158>
    80002720:	00014917          	auipc	s2,0x14
    80002724:	3a890913          	addi	s2,s2,936 # 80016ac8 <bcache+0x140>
  {
    if (p->state == UNUSED)
      continue;
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002728:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    8000272a:	00006997          	auipc	s3,0x6
    8000272e:	b5e98993          	addi	s3,s3,-1186 # 80008288 <digits+0x248>
    printf("%d %s %s", p->pid, state, p->name);
    80002732:	00006a97          	auipc	s5,0x6
    80002736:	b5ea8a93          	addi	s5,s5,-1186 # 80008290 <digits+0x250>
    printf("\n");
    8000273a:	00006a17          	auipc	s4,0x6
    8000273e:	98ea0a13          	addi	s4,s4,-1650 # 800080c8 <digits+0x88>
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002742:	00006b97          	auipc	s7,0x6
    80002746:	b8eb8b93          	addi	s7,s7,-1138 # 800082d0 <states.0>
    8000274a:	a00d                	j	8000276c <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    8000274c:	ed86a583          	lw	a1,-296(a3)
    80002750:	8556                	mv	a0,s5
    80002752:	ffffe097          	auipc	ra,0xffffe
    80002756:	e36080e7          	jalr	-458(ra) # 80000588 <printf>
    printf("\n");
    8000275a:	8552                	mv	a0,s4
    8000275c:	ffffe097          	auipc	ra,0xffffe
    80002760:	e2c080e7          	jalr	-468(ra) # 80000588 <printf>
  for (p = proc; p < &proc[NPROC]; p++)
    80002764:	16848493          	addi	s1,s1,360
    80002768:	03248163          	beq	s1,s2,8000278a <procdump+0x98>
    if (p->state == UNUSED)
    8000276c:	86a6                	mv	a3,s1
    8000276e:	ec04a783          	lw	a5,-320(s1)
    80002772:	dbed                	beqz	a5,80002764 <procdump+0x72>
      state = "???";
    80002774:	864e                	mv	a2,s3
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002776:	fcfb6be3          	bltu	s6,a5,8000274c <procdump+0x5a>
    8000277a:	1782                	slli	a5,a5,0x20
    8000277c:	9381                	srli	a5,a5,0x20
    8000277e:	078e                	slli	a5,a5,0x3
    80002780:	97de                	add	a5,a5,s7
    80002782:	6390                	ld	a2,0(a5)
    80002784:	f661                	bnez	a2,8000274c <procdump+0x5a>
      state = "???";
    80002786:	864e                	mv	a2,s3
    80002788:	b7d1                	j	8000274c <procdump+0x5a>
  }
}
    8000278a:	60a6                	ld	ra,72(sp)
    8000278c:	6406                	ld	s0,64(sp)
    8000278e:	74e2                	ld	s1,56(sp)
    80002790:	7942                	ld	s2,48(sp)
    80002792:	79a2                	ld	s3,40(sp)
    80002794:	7a02                	ld	s4,32(sp)
    80002796:	6ae2                	ld	s5,24(sp)
    80002798:	6b42                	ld	s6,16(sp)
    8000279a:	6ba2                	ld	s7,8(sp)
    8000279c:	6161                	addi	sp,sp,80
    8000279e:	8082                	ret

00000000800027a0 <swtch>:
    800027a0:	00153023          	sd	ra,0(a0)
    800027a4:	00253423          	sd	sp,8(a0)
    800027a8:	e900                	sd	s0,16(a0)
    800027aa:	ed04                	sd	s1,24(a0)
    800027ac:	03253023          	sd	s2,32(a0)
    800027b0:	03353423          	sd	s3,40(a0)
    800027b4:	03453823          	sd	s4,48(a0)
    800027b8:	03553c23          	sd	s5,56(a0)
    800027bc:	05653023          	sd	s6,64(a0)
    800027c0:	05753423          	sd	s7,72(a0)
    800027c4:	05853823          	sd	s8,80(a0)
    800027c8:	05953c23          	sd	s9,88(a0)
    800027cc:	07a53023          	sd	s10,96(a0)
    800027d0:	07b53423          	sd	s11,104(a0)
    800027d4:	0005b083          	ld	ra,0(a1)
    800027d8:	0085b103          	ld	sp,8(a1)
    800027dc:	6980                	ld	s0,16(a1)
    800027de:	6d84                	ld	s1,24(a1)
    800027e0:	0205b903          	ld	s2,32(a1)
    800027e4:	0285b983          	ld	s3,40(a1)
    800027e8:	0305ba03          	ld	s4,48(a1)
    800027ec:	0385ba83          	ld	s5,56(a1)
    800027f0:	0405bb03          	ld	s6,64(a1)
    800027f4:	0485bb83          	ld	s7,72(a1)
    800027f8:	0505bc03          	ld	s8,80(a1)
    800027fc:	0585bc83          	ld	s9,88(a1)
    80002800:	0605bd03          	ld	s10,96(a1)
    80002804:	0685bd83          	ld	s11,104(a1)
    80002808:	8082                	ret

000000008000280a <trapinit>:

extern int devintr();

void
trapinit(void)
{
    8000280a:	1141                	addi	sp,sp,-16
    8000280c:	e406                	sd	ra,8(sp)
    8000280e:	e022                	sd	s0,0(sp)
    80002810:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80002812:	00006597          	auipc	a1,0x6
    80002816:	aee58593          	addi	a1,a1,-1298 # 80008300 <states.0+0x30>
    8000281a:	00014517          	auipc	a0,0x14
    8000281e:	15650513          	addi	a0,a0,342 # 80016970 <tickslock>
    80002822:	ffffe097          	auipc	ra,0xffffe
    80002826:	324080e7          	jalr	804(ra) # 80000b46 <initlock>
}
    8000282a:	60a2                	ld	ra,8(sp)
    8000282c:	6402                	ld	s0,0(sp)
    8000282e:	0141                	addi	sp,sp,16
    80002830:	8082                	ret

0000000080002832 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80002832:	1141                	addi	sp,sp,-16
    80002834:	e422                	sd	s0,8(sp)
    80002836:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002838:	00003797          	auipc	a5,0x3
    8000283c:	4e878793          	addi	a5,a5,1256 # 80005d20 <kernelvec>
    80002840:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80002844:	6422                	ld	s0,8(sp)
    80002846:	0141                	addi	sp,sp,16
    80002848:	8082                	ret

000000008000284a <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    8000284a:	1141                	addi	sp,sp,-16
    8000284c:	e406                	sd	ra,8(sp)
    8000284e:	e022                	sd	s0,0(sp)
    80002850:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80002852:	fffff097          	auipc	ra,0xfffff
    80002856:	15a080e7          	jalr	346(ra) # 800019ac <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000285a:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    8000285e:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002860:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    80002864:	00004617          	auipc	a2,0x4
    80002868:	79c60613          	addi	a2,a2,1948 # 80007000 <_trampoline>
    8000286c:	00004697          	auipc	a3,0x4
    80002870:	79468693          	addi	a3,a3,1940 # 80007000 <_trampoline>
    80002874:	8e91                	sub	a3,a3,a2
    80002876:	040007b7          	lui	a5,0x4000
    8000287a:	17fd                	addi	a5,a5,-1
    8000287c:	07b2                	slli	a5,a5,0xc
    8000287e:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002880:	10569073          	csrw	stvec,a3
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel pig table
    80002884:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80002886:	180026f3          	csrr	a3,satp
    8000288a:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PIGSIZE; // process's kernel stack
    8000288c:	6d38                	ld	a4,88(a0)
    8000288e:	6134                	ld	a3,64(a0)
    80002890:	6585                	lui	a1,0x1
    80002892:	96ae                	add	a3,a3,a1
    80002894:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80002896:	6d38                	ld	a4,88(a0)
    80002898:	00000697          	auipc	a3,0x0
    8000289c:	13068693          	addi	a3,a3,304 # 800029c8 <usertrap>
    800028a0:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    800028a2:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    800028a4:	8692                	mv	a3,tp
    800028a6:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800028a8:	100026f3          	csrr	a3,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.

  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    800028ac:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    800028b0:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800028b4:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    800028b8:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    800028ba:	6f18                	ld	a4,24(a4)
    800028bc:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user pig table to switch to.
  uint64 satp = MAKE_SATP(p->pigtable);
    800028c0:	6928                	ld	a0,80(a0)
    800028c2:	8131                	srli	a0,a0,0xc

  // jump to userret in trampoline.S at the top of memory, which
  // switches to the user pig table, restores user registers,
  // and switches to user mode with sret.
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    800028c4:	00004717          	auipc	a4,0x4
    800028c8:	7d870713          	addi	a4,a4,2008 # 8000709c <userret>
    800028cc:	8f11                	sub	a4,a4,a2
    800028ce:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    800028d0:	577d                	li	a4,-1
    800028d2:	177e                	slli	a4,a4,0x3f
    800028d4:	8d59                	or	a0,a0,a4
    800028d6:	9782                	jalr	a5
}
    800028d8:	60a2                	ld	ra,8(sp)
    800028da:	6402                	ld	s0,0(sp)
    800028dc:	0141                	addi	sp,sp,16
    800028de:	8082                	ret

00000000800028e0 <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    800028e0:	1101                	addi	sp,sp,-32
    800028e2:	ec06                	sd	ra,24(sp)
    800028e4:	e822                	sd	s0,16(sp)
    800028e6:	e426                	sd	s1,8(sp)
    800028e8:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    800028ea:	00014497          	auipc	s1,0x14
    800028ee:	08648493          	addi	s1,s1,134 # 80016970 <tickslock>
    800028f2:	8526                	mv	a0,s1
    800028f4:	ffffe097          	auipc	ra,0xffffe
    800028f8:	2e2080e7          	jalr	738(ra) # 80000bd6 <acquire>
  ticks++;
    800028fc:	00006517          	auipc	a0,0x6
    80002900:	fd450513          	addi	a0,a0,-44 # 800088d0 <ticks>
    80002904:	411c                	lw	a5,0(a0)
    80002906:	2785                	addiw	a5,a5,1
    80002908:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    8000290a:	fffff097          	auipc	ra,0xfffff
    8000290e:	7ae080e7          	jalr	1966(ra) # 800020b8 <wakeup>
  release(&tickslock);
    80002912:	8526                	mv	a0,s1
    80002914:	ffffe097          	auipc	ra,0xffffe
    80002918:	376080e7          	jalr	886(ra) # 80000c8a <release>
}
    8000291c:	60e2                	ld	ra,24(sp)
    8000291e:	6442                	ld	s0,16(sp)
    80002920:	64a2                	ld	s1,8(sp)
    80002922:	6105                	addi	sp,sp,32
    80002924:	8082                	ret

0000000080002926 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80002926:	1101                	addi	sp,sp,-32
    80002928:	ec06                	sd	ra,24(sp)
    8000292a:	e822                	sd	s0,16(sp)
    8000292c:	e426                	sd	s1,8(sp)
    8000292e:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002930:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    80002934:	00074d63          	bltz	a4,8000294e <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    80002938:	57fd                	li	a5,-1
    8000293a:	17fe                	slli	a5,a5,0x3f
    8000293c:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    8000293e:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80002940:	06f70363          	beq	a4,a5,800029a6 <devintr+0x80>
  }
}
    80002944:	60e2                	ld	ra,24(sp)
    80002946:	6442                	ld	s0,16(sp)
    80002948:	64a2                	ld	s1,8(sp)
    8000294a:	6105                	addi	sp,sp,32
    8000294c:	8082                	ret
     (scause & 0xff) == 9){
    8000294e:	0ff77793          	andi	a5,a4,255
  if((scause & 0x8000000000000000L) &&
    80002952:	46a5                	li	a3,9
    80002954:	fed792e3          	bne	a5,a3,80002938 <devintr+0x12>
    int irq = plic_claim();
    80002958:	00003097          	auipc	ra,0x3
    8000295c:	4d0080e7          	jalr	1232(ra) # 80005e28 <plic_claim>
    80002960:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80002962:	47a9                	li	a5,10
    80002964:	02f50763          	beq	a0,a5,80002992 <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    80002968:	4785                	li	a5,1
    8000296a:	02f50963          	beq	a0,a5,8000299c <devintr+0x76>
    return 1;
    8000296e:	4505                	li	a0,1
    } else if(irq){
    80002970:	d8f1                	beqz	s1,80002944 <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    80002972:	85a6                	mv	a1,s1
    80002974:	00006517          	auipc	a0,0x6
    80002978:	99450513          	addi	a0,a0,-1644 # 80008308 <states.0+0x38>
    8000297c:	ffffe097          	auipc	ra,0xffffe
    80002980:	c0c080e7          	jalr	-1012(ra) # 80000588 <printf>
      plic_complete(irq);
    80002984:	8526                	mv	a0,s1
    80002986:	00003097          	auipc	ra,0x3
    8000298a:	4c6080e7          	jalr	1222(ra) # 80005e4c <plic_complete>
    return 1;
    8000298e:	4505                	li	a0,1
    80002990:	bf55                	j	80002944 <devintr+0x1e>
      uartintr();
    80002992:	ffffe097          	auipc	ra,0xffffe
    80002996:	008080e7          	jalr	8(ra) # 8000099a <uartintr>
    8000299a:	b7ed                	j	80002984 <devintr+0x5e>
      virtio_disk_intr();
    8000299c:	00004097          	auipc	ra,0x4
    800029a0:	97c080e7          	jalr	-1668(ra) # 80006318 <virtio_disk_intr>
    800029a4:	b7c5                	j	80002984 <devintr+0x5e>
    if(cpuid() == 0){
    800029a6:	fffff097          	auipc	ra,0xfffff
    800029aa:	fda080e7          	jalr	-38(ra) # 80001980 <cpuid>
    800029ae:	c901                	beqz	a0,800029be <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    800029b0:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    800029b4:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    800029b6:	14479073          	csrw	sip,a5
    return 2;
    800029ba:	4509                	li	a0,2
    800029bc:	b761                	j	80002944 <devintr+0x1e>
      clockintr();
    800029be:	00000097          	auipc	ra,0x0
    800029c2:	f22080e7          	jalr	-222(ra) # 800028e0 <clockintr>
    800029c6:	b7ed                	j	800029b0 <devintr+0x8a>

00000000800029c8 <usertrap>:
{
    800029c8:	1101                	addi	sp,sp,-32
    800029ca:	ec06                	sd	ra,24(sp)
    800029cc:	e822                	sd	s0,16(sp)
    800029ce:	e426                	sd	s1,8(sp)
    800029d0:	e04a                	sd	s2,0(sp)
    800029d2:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800029d4:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    800029d8:	1007f793          	andi	a5,a5,256
    800029dc:	e3b1                	bnez	a5,80002a20 <usertrap+0x58>
  asm volatile("csrw stvec, %0" : : "r" (x));
    800029de:	00003797          	auipc	a5,0x3
    800029e2:	34278793          	addi	a5,a5,834 # 80005d20 <kernelvec>
    800029e6:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    800029ea:	fffff097          	auipc	ra,0xfffff
    800029ee:	fc2080e7          	jalr	-62(ra) # 800019ac <myproc>
    800029f2:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    800029f4:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800029f6:	14102773          	csrr	a4,sepc
    800029fa:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    800029fc:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80002a00:	47a1                	li	a5,8
    80002a02:	02f70763          	beq	a4,a5,80002a30 <usertrap+0x68>
  } else if((which_dev = devintr()) != 0){
    80002a06:	00000097          	auipc	ra,0x0
    80002a0a:	f20080e7          	jalr	-224(ra) # 80002926 <devintr>
    80002a0e:	892a                	mv	s2,a0
    80002a10:	c151                	beqz	a0,80002a94 <usertrap+0xcc>
  if(killed(p))
    80002a12:	8526                	mv	a0,s1
    80002a14:	00000097          	auipc	ra,0x0
    80002a18:	ad2080e7          	jalr	-1326(ra) # 800024e6 <killed>
    80002a1c:	c929                	beqz	a0,80002a6e <usertrap+0xa6>
    80002a1e:	a099                	j	80002a64 <usertrap+0x9c>
    panic("usertrap: not from user mode");
    80002a20:	00006517          	auipc	a0,0x6
    80002a24:	90850513          	addi	a0,a0,-1784 # 80008328 <states.0+0x58>
    80002a28:	ffffe097          	auipc	ra,0xffffe
    80002a2c:	b16080e7          	jalr	-1258(ra) # 8000053e <panic>
    if(killed(p))
    80002a30:	00000097          	auipc	ra,0x0
    80002a34:	ab6080e7          	jalr	-1354(ra) # 800024e6 <killed>
    80002a38:	e921                	bnez	a0,80002a88 <usertrap+0xc0>
    p->trapframe->epc += 4;
    80002a3a:	6cb8                	ld	a4,88(s1)
    80002a3c:	6f1c                	ld	a5,24(a4)
    80002a3e:	0791                	addi	a5,a5,4
    80002a40:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002a42:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80002a46:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002a4a:	10079073          	csrw	sstatus,a5
    syscall();
    80002a4e:	00000097          	auipc	ra,0x0
    80002a52:	2d4080e7          	jalr	724(ra) # 80002d22 <syscall>
  if(killed(p))
    80002a56:	8526                	mv	a0,s1
    80002a58:	00000097          	auipc	ra,0x0
    80002a5c:	a8e080e7          	jalr	-1394(ra) # 800024e6 <killed>
    80002a60:	c911                	beqz	a0,80002a74 <usertrap+0xac>
    80002a62:	4901                	li	s2,0
    exit(-1);
    80002a64:	557d                	li	a0,-1
    80002a66:	fffff097          	auipc	ra,0xfffff
    80002a6a:	722080e7          	jalr	1826(ra) # 80002188 <exit>
  if(which_dev == 2)
    80002a6e:	4789                	li	a5,2
    80002a70:	04f90f63          	beq	s2,a5,80002ace <usertrap+0x106>
  usertrapret();
    80002a74:	00000097          	auipc	ra,0x0
    80002a78:	dd6080e7          	jalr	-554(ra) # 8000284a <usertrapret>
}
    80002a7c:	60e2                	ld	ra,24(sp)
    80002a7e:	6442                	ld	s0,16(sp)
    80002a80:	64a2                	ld	s1,8(sp)
    80002a82:	6902                	ld	s2,0(sp)
    80002a84:	6105                	addi	sp,sp,32
    80002a86:	8082                	ret
      exit(-1);
    80002a88:	557d                	li	a0,-1
    80002a8a:	fffff097          	auipc	ra,0xfffff
    80002a8e:	6fe080e7          	jalr	1790(ra) # 80002188 <exit>
    80002a92:	b765                	j	80002a3a <usertrap+0x72>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002a94:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80002a98:	5890                	lw	a2,48(s1)
    80002a9a:	00006517          	auipc	a0,0x6
    80002a9e:	8ae50513          	addi	a0,a0,-1874 # 80008348 <states.0+0x78>
    80002aa2:	ffffe097          	auipc	ra,0xffffe
    80002aa6:	ae6080e7          	jalr	-1306(ra) # 80000588 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002aaa:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002aae:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002ab2:	00006517          	auipc	a0,0x6
    80002ab6:	8c650513          	addi	a0,a0,-1850 # 80008378 <states.0+0xa8>
    80002aba:	ffffe097          	auipc	ra,0xffffe
    80002abe:	ace080e7          	jalr	-1330(ra) # 80000588 <printf>
    setkilled(p);
    80002ac2:	8526                	mv	a0,s1
    80002ac4:	00000097          	auipc	ra,0x0
    80002ac8:	9f6080e7          	jalr	-1546(ra) # 800024ba <setkilled>
    80002acc:	b769                	j	80002a56 <usertrap+0x8e>
    yield();
    80002ace:	fffff097          	auipc	ra,0xfffff
    80002ad2:	54a080e7          	jalr	1354(ra) # 80002018 <yield>
    80002ad6:	bf79                	j	80002a74 <usertrap+0xac>

0000000080002ad8 <kerneltrap>:
{
    80002ad8:	7179                	addi	sp,sp,-48
    80002ada:	f406                	sd	ra,40(sp)
    80002adc:	f022                	sd	s0,32(sp)
    80002ade:	ec26                	sd	s1,24(sp)
    80002ae0:	e84a                	sd	s2,16(sp)
    80002ae2:	e44e                	sd	s3,8(sp)
    80002ae4:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002ae6:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002aea:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002aee:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80002af2:	1004f793          	andi	a5,s1,256
    80002af6:	cb85                	beqz	a5,80002b26 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002af8:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80002afc:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80002afe:	ef85                	bnez	a5,80002b36 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80002b00:	00000097          	auipc	ra,0x0
    80002b04:	e26080e7          	jalr	-474(ra) # 80002926 <devintr>
    80002b08:	cd1d                	beqz	a0,80002b46 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002b0a:	4789                	li	a5,2
    80002b0c:	06f50a63          	beq	a0,a5,80002b80 <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002b10:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002b14:	10049073          	csrw	sstatus,s1
}
    80002b18:	70a2                	ld	ra,40(sp)
    80002b1a:	7402                	ld	s0,32(sp)
    80002b1c:	64e2                	ld	s1,24(sp)
    80002b1e:	6942                	ld	s2,16(sp)
    80002b20:	69a2                	ld	s3,8(sp)
    80002b22:	6145                	addi	sp,sp,48
    80002b24:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80002b26:	00006517          	auipc	a0,0x6
    80002b2a:	87250513          	addi	a0,a0,-1934 # 80008398 <states.0+0xc8>
    80002b2e:	ffffe097          	auipc	ra,0xffffe
    80002b32:	a10080e7          	jalr	-1520(ra) # 8000053e <panic>
    panic("kerneltrap: interrupts enabled");
    80002b36:	00006517          	auipc	a0,0x6
    80002b3a:	88a50513          	addi	a0,a0,-1910 # 800083c0 <states.0+0xf0>
    80002b3e:	ffffe097          	auipc	ra,0xffffe
    80002b42:	a00080e7          	jalr	-1536(ra) # 8000053e <panic>
    printf("scause %p\n", scause);
    80002b46:	85ce                	mv	a1,s3
    80002b48:	00006517          	auipc	a0,0x6
    80002b4c:	89850513          	addi	a0,a0,-1896 # 800083e0 <states.0+0x110>
    80002b50:	ffffe097          	auipc	ra,0xffffe
    80002b54:	a38080e7          	jalr	-1480(ra) # 80000588 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002b58:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002b5c:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002b60:	00006517          	auipc	a0,0x6
    80002b64:	89050513          	addi	a0,a0,-1904 # 800083f0 <states.0+0x120>
    80002b68:	ffffe097          	auipc	ra,0xffffe
    80002b6c:	a20080e7          	jalr	-1504(ra) # 80000588 <printf>
    panic("kerneltrap");
    80002b70:	00006517          	auipc	a0,0x6
    80002b74:	89850513          	addi	a0,a0,-1896 # 80008408 <states.0+0x138>
    80002b78:	ffffe097          	auipc	ra,0xffffe
    80002b7c:	9c6080e7          	jalr	-1594(ra) # 8000053e <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002b80:	fffff097          	auipc	ra,0xfffff
    80002b84:	e2c080e7          	jalr	-468(ra) # 800019ac <myproc>
    80002b88:	d541                	beqz	a0,80002b10 <kerneltrap+0x38>
    80002b8a:	fffff097          	auipc	ra,0xfffff
    80002b8e:	e22080e7          	jalr	-478(ra) # 800019ac <myproc>
    80002b92:	4d18                	lw	a4,24(a0)
    80002b94:	4791                	li	a5,4
    80002b96:	f6f71de3          	bne	a4,a5,80002b10 <kerneltrap+0x38>
    yield();
    80002b9a:	fffff097          	auipc	ra,0xfffff
    80002b9e:	47e080e7          	jalr	1150(ra) # 80002018 <yield>
    80002ba2:	b7bd                	j	80002b10 <kerneltrap+0x38>

0000000080002ba4 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80002ba4:	1101                	addi	sp,sp,-32
    80002ba6:	ec06                	sd	ra,24(sp)
    80002ba8:	e822                	sd	s0,16(sp)
    80002baa:	e426                	sd	s1,8(sp)
    80002bac:	1000                	addi	s0,sp,32
    80002bae:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80002bb0:	fffff097          	auipc	ra,0xfffff
    80002bb4:	dfc080e7          	jalr	-516(ra) # 800019ac <myproc>
  switch (n)
    80002bb8:	4795                	li	a5,5
    80002bba:	0497e163          	bltu	a5,s1,80002bfc <argraw+0x58>
    80002bbe:	048a                	slli	s1,s1,0x2
    80002bc0:	00006717          	auipc	a4,0x6
    80002bc4:	88070713          	addi	a4,a4,-1920 # 80008440 <states.0+0x170>
    80002bc8:	94ba                	add	s1,s1,a4
    80002bca:	409c                	lw	a5,0(s1)
    80002bcc:	97ba                	add	a5,a5,a4
    80002bce:	8782                	jr	a5
  {
  case 0:
    return p->trapframe->a0;
    80002bd0:	6d3c                	ld	a5,88(a0)
    80002bd2:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80002bd4:	60e2                	ld	ra,24(sp)
    80002bd6:	6442                	ld	s0,16(sp)
    80002bd8:	64a2                	ld	s1,8(sp)
    80002bda:	6105                	addi	sp,sp,32
    80002bdc:	8082                	ret
    return p->trapframe->a1;
    80002bde:	6d3c                	ld	a5,88(a0)
    80002be0:	7fa8                	ld	a0,120(a5)
    80002be2:	bfcd                	j	80002bd4 <argraw+0x30>
    return p->trapframe->a2;
    80002be4:	6d3c                	ld	a5,88(a0)
    80002be6:	63c8                	ld	a0,128(a5)
    80002be8:	b7f5                	j	80002bd4 <argraw+0x30>
    return p->trapframe->a3;
    80002bea:	6d3c                	ld	a5,88(a0)
    80002bec:	67c8                	ld	a0,136(a5)
    80002bee:	b7dd                	j	80002bd4 <argraw+0x30>
    return p->trapframe->a4;
    80002bf0:	6d3c                	ld	a5,88(a0)
    80002bf2:	6bc8                	ld	a0,144(a5)
    80002bf4:	b7c5                	j	80002bd4 <argraw+0x30>
    return p->trapframe->a5;
    80002bf6:	6d3c                	ld	a5,88(a0)
    80002bf8:	6fc8                	ld	a0,152(a5)
    80002bfa:	bfe9                	j	80002bd4 <argraw+0x30>
  panic("argraw");
    80002bfc:	00006517          	auipc	a0,0x6
    80002c00:	81c50513          	addi	a0,a0,-2020 # 80008418 <states.0+0x148>
    80002c04:	ffffe097          	auipc	ra,0xffffe
    80002c08:	93a080e7          	jalr	-1734(ra) # 8000053e <panic>

0000000080002c0c <fetchaddr>:
{
    80002c0c:	1101                	addi	sp,sp,-32
    80002c0e:	ec06                	sd	ra,24(sp)
    80002c10:	e822                	sd	s0,16(sp)
    80002c12:	e426                	sd	s1,8(sp)
    80002c14:	e04a                	sd	s2,0(sp)
    80002c16:	1000                	addi	s0,sp,32
    80002c18:	84aa                	mv	s1,a0
    80002c1a:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80002c1c:	fffff097          	auipc	ra,0xfffff
    80002c20:	d90080e7          	jalr	-624(ra) # 800019ac <myproc>
  if (addr >= p->sz || addr + sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    80002c24:	653c                	ld	a5,72(a0)
    80002c26:	02f4f863          	bgeu	s1,a5,80002c56 <fetchaddr+0x4a>
    80002c2a:	00848713          	addi	a4,s1,8
    80002c2e:	02e7e663          	bltu	a5,a4,80002c5a <fetchaddr+0x4e>
  if (copyin(p->pigtable, (char *)ip, addr, sizeof(*ip)) != 0)
    80002c32:	46a1                	li	a3,8
    80002c34:	8626                	mv	a2,s1
    80002c36:	85ca                	mv	a1,s2
    80002c38:	6928                	ld	a0,80(a0)
    80002c3a:	fffff097          	auipc	ra,0xfffff
    80002c3e:	aba080e7          	jalr	-1350(ra) # 800016f4 <copyin>
    80002c42:	00a03533          	snez	a0,a0
    80002c46:	40a00533          	neg	a0,a0
}
    80002c4a:	60e2                	ld	ra,24(sp)
    80002c4c:	6442                	ld	s0,16(sp)
    80002c4e:	64a2                	ld	s1,8(sp)
    80002c50:	6902                	ld	s2,0(sp)
    80002c52:	6105                	addi	sp,sp,32
    80002c54:	8082                	ret
    return -1;
    80002c56:	557d                	li	a0,-1
    80002c58:	bfcd                	j	80002c4a <fetchaddr+0x3e>
    80002c5a:	557d                	li	a0,-1
    80002c5c:	b7fd                	j	80002c4a <fetchaddr+0x3e>

0000000080002c5e <fetchstr>:
{
    80002c5e:	7179                	addi	sp,sp,-48
    80002c60:	f406                	sd	ra,40(sp)
    80002c62:	f022                	sd	s0,32(sp)
    80002c64:	ec26                	sd	s1,24(sp)
    80002c66:	e84a                	sd	s2,16(sp)
    80002c68:	e44e                	sd	s3,8(sp)
    80002c6a:	1800                	addi	s0,sp,48
    80002c6c:	892a                	mv	s2,a0
    80002c6e:	84ae                	mv	s1,a1
    80002c70:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80002c72:	fffff097          	auipc	ra,0xfffff
    80002c76:	d3a080e7          	jalr	-710(ra) # 800019ac <myproc>
  if (copyinstr(p->pigtable, buf, addr, max) < 0)
    80002c7a:	86ce                	mv	a3,s3
    80002c7c:	864a                	mv	a2,s2
    80002c7e:	85a6                	mv	a1,s1
    80002c80:	6928                	ld	a0,80(a0)
    80002c82:	fffff097          	auipc	ra,0xfffff
    80002c86:	b00080e7          	jalr	-1280(ra) # 80001782 <copyinstr>
    80002c8a:	00054e63          	bltz	a0,80002ca6 <fetchstr+0x48>
  return strlen(buf);
    80002c8e:	8526                	mv	a0,s1
    80002c90:	ffffe097          	auipc	ra,0xffffe
    80002c94:	1be080e7          	jalr	446(ra) # 80000e4e <strlen>
}
    80002c98:	70a2                	ld	ra,40(sp)
    80002c9a:	7402                	ld	s0,32(sp)
    80002c9c:	64e2                	ld	s1,24(sp)
    80002c9e:	6942                	ld	s2,16(sp)
    80002ca0:	69a2                	ld	s3,8(sp)
    80002ca2:	6145                	addi	sp,sp,48
    80002ca4:	8082                	ret
    return -1;
    80002ca6:	557d                	li	a0,-1
    80002ca8:	bfc5                	j	80002c98 <fetchstr+0x3a>

0000000080002caa <argint>:

// Fetch the nth 32-bit system call argument.
void argint(int n, int *ip)
{
    80002caa:	1101                	addi	sp,sp,-32
    80002cac:	ec06                	sd	ra,24(sp)
    80002cae:	e822                	sd	s0,16(sp)
    80002cb0:	e426                	sd	s1,8(sp)
    80002cb2:	1000                	addi	s0,sp,32
    80002cb4:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002cb6:	00000097          	auipc	ra,0x0
    80002cba:	eee080e7          	jalr	-274(ra) # 80002ba4 <argraw>
    80002cbe:	c088                	sw	a0,0(s1)
}
    80002cc0:	60e2                	ld	ra,24(sp)
    80002cc2:	6442                	ld	s0,16(sp)
    80002cc4:	64a2                	ld	s1,8(sp)
    80002cc6:	6105                	addi	sp,sp,32
    80002cc8:	8082                	ret

0000000080002cca <argaddr>:

// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void argaddr(int n, uint64 *ip)
{
    80002cca:	1101                	addi	sp,sp,-32
    80002ccc:	ec06                	sd	ra,24(sp)
    80002cce:	e822                	sd	s0,16(sp)
    80002cd0:	e426                	sd	s1,8(sp)
    80002cd2:	1000                	addi	s0,sp,32
    80002cd4:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002cd6:	00000097          	auipc	ra,0x0
    80002cda:	ece080e7          	jalr	-306(ra) # 80002ba4 <argraw>
    80002cde:	e088                	sd	a0,0(s1)
}
    80002ce0:	60e2                	ld	ra,24(sp)
    80002ce2:	6442                	ld	s0,16(sp)
    80002ce4:	64a2                	ld	s1,8(sp)
    80002ce6:	6105                	addi	sp,sp,32
    80002ce8:	8082                	ret

0000000080002cea <argstr>:

// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int argstr(int n, char *buf, int max)
{
    80002cea:	7179                	addi	sp,sp,-48
    80002cec:	f406                	sd	ra,40(sp)
    80002cee:	f022                	sd	s0,32(sp)
    80002cf0:	ec26                	sd	s1,24(sp)
    80002cf2:	e84a                	sd	s2,16(sp)
    80002cf4:	1800                	addi	s0,sp,48
    80002cf6:	84ae                	mv	s1,a1
    80002cf8:	8932                	mv	s2,a2
  uint64 addr;
  argaddr(n, &addr);
    80002cfa:	fd840593          	addi	a1,s0,-40
    80002cfe:	00000097          	auipc	ra,0x0
    80002d02:	fcc080e7          	jalr	-52(ra) # 80002cca <argaddr>
  return fetchstr(addr, buf, max);
    80002d06:	864a                	mv	a2,s2
    80002d08:	85a6                	mv	a1,s1
    80002d0a:	fd843503          	ld	a0,-40(s0)
    80002d0e:	00000097          	auipc	ra,0x0
    80002d12:	f50080e7          	jalr	-176(ra) # 80002c5e <fetchstr>
}
    80002d16:	70a2                	ld	ra,40(sp)
    80002d18:	7402                	ld	s0,32(sp)
    80002d1a:	64e2                	ld	s1,24(sp)
    80002d1c:	6942                	ld	s2,16(sp)
    80002d1e:	6145                	addi	sp,sp,48
    80002d20:	8082                	ret

0000000080002d22 <syscall>:
    [SYS_close] sys_close,
    [SYS_pigs] sys_pigs,
};

void syscall(void)
{
    80002d22:	1101                	addi	sp,sp,-32
    80002d24:	ec06                	sd	ra,24(sp)
    80002d26:	e822                	sd	s0,16(sp)
    80002d28:	e426                	sd	s1,8(sp)
    80002d2a:	e04a                	sd	s2,0(sp)
    80002d2c:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80002d2e:	fffff097          	auipc	ra,0xfffff
    80002d32:	c7e080e7          	jalr	-898(ra) # 800019ac <myproc>
    80002d36:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80002d38:	05853903          	ld	s2,88(a0)
    80002d3c:	0a893783          	ld	a5,168(s2)
    80002d40:	0007869b          	sext.w	a3,a5
  if (num > 0 && num < NELEM(syscalls) && syscalls[num])
    80002d44:	37fd                	addiw	a5,a5,-1
    80002d46:	4755                	li	a4,21
    80002d48:	00f76f63          	bltu	a4,a5,80002d66 <syscall+0x44>
    80002d4c:	00369713          	slli	a4,a3,0x3
    80002d50:	00005797          	auipc	a5,0x5
    80002d54:	70878793          	addi	a5,a5,1800 # 80008458 <syscalls>
    80002d58:	97ba                	add	a5,a5,a4
    80002d5a:	639c                	ld	a5,0(a5)
    80002d5c:	c789                	beqz	a5,80002d66 <syscall+0x44>
  {
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    80002d5e:	9782                	jalr	a5
    80002d60:	06a93823          	sd	a0,112(s2)
    80002d64:	a839                	j	80002d82 <syscall+0x60>
  }
  else
  {
    printf("%d %s: unknown sys call %d\n",
    80002d66:	15848613          	addi	a2,s1,344
    80002d6a:	588c                	lw	a1,48(s1)
    80002d6c:	00005517          	auipc	a0,0x5
    80002d70:	6b450513          	addi	a0,a0,1716 # 80008420 <states.0+0x150>
    80002d74:	ffffe097          	auipc	ra,0xffffe
    80002d78:	814080e7          	jalr	-2028(ra) # 80000588 <printf>
           p->pid, p->name, num);
    p->trapframe->a0 = -1;
    80002d7c:	6cbc                	ld	a5,88(s1)
    80002d7e:	577d                	li	a4,-1
    80002d80:	fbb8                	sd	a4,112(a5)
  }
}
    80002d82:	60e2                	ld	ra,24(sp)
    80002d84:	6442                	ld	s0,16(sp)
    80002d86:	64a2                	ld	s1,8(sp)
    80002d88:	6902                	ld	s2,0(sp)
    80002d8a:	6105                	addi	sp,sp,32
    80002d8c:	8082                	ret

0000000080002d8e <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    80002d8e:	1101                	addi	sp,sp,-32
    80002d90:	ec06                	sd	ra,24(sp)
    80002d92:	e822                	sd	s0,16(sp)
    80002d94:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    80002d96:	fec40593          	addi	a1,s0,-20
    80002d9a:	4501                	li	a0,0
    80002d9c:	00000097          	auipc	ra,0x0
    80002da0:	f0e080e7          	jalr	-242(ra) # 80002caa <argint>
  exit(n);
    80002da4:	fec42503          	lw	a0,-20(s0)
    80002da8:	fffff097          	auipc	ra,0xfffff
    80002dac:	3e0080e7          	jalr	992(ra) # 80002188 <exit>
  return 0; // not reached
}
    80002db0:	4501                	li	a0,0
    80002db2:	60e2                	ld	ra,24(sp)
    80002db4:	6442                	ld	s0,16(sp)
    80002db6:	6105                	addi	sp,sp,32
    80002db8:	8082                	ret

0000000080002dba <sys_getpid>:

uint64
sys_getpid(void)
{
    80002dba:	1141                	addi	sp,sp,-16
    80002dbc:	e406                	sd	ra,8(sp)
    80002dbe:	e022                	sd	s0,0(sp)
    80002dc0:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80002dc2:	fffff097          	auipc	ra,0xfffff
    80002dc6:	bea080e7          	jalr	-1046(ra) # 800019ac <myproc>
}
    80002dca:	5908                	lw	a0,48(a0)
    80002dcc:	60a2                	ld	ra,8(sp)
    80002dce:	6402                	ld	s0,0(sp)
    80002dd0:	0141                	addi	sp,sp,16
    80002dd2:	8082                	ret

0000000080002dd4 <sys_fork>:

uint64
sys_fork(void)
{
    80002dd4:	1141                	addi	sp,sp,-16
    80002dd6:	e406                	sd	ra,8(sp)
    80002dd8:	e022                	sd	s0,0(sp)
    80002dda:	0800                	addi	s0,sp,16
  return fork();
    80002ddc:	fffff097          	auipc	ra,0xfffff
    80002de0:	f86080e7          	jalr	-122(ra) # 80001d62 <fork>
}
    80002de4:	60a2                	ld	ra,8(sp)
    80002de6:	6402                	ld	s0,0(sp)
    80002de8:	0141                	addi	sp,sp,16
    80002dea:	8082                	ret

0000000080002dec <sys_wait>:

uint64
sys_wait(void)
{
    80002dec:	1101                	addi	sp,sp,-32
    80002dee:	ec06                	sd	ra,24(sp)
    80002df0:	e822                	sd	s0,16(sp)
    80002df2:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    80002df4:	fe840593          	addi	a1,s0,-24
    80002df8:	4501                	li	a0,0
    80002dfa:	00000097          	auipc	ra,0x0
    80002dfe:	ed0080e7          	jalr	-304(ra) # 80002cca <argaddr>
  return wait(p);
    80002e02:	fe843503          	ld	a0,-24(s0)
    80002e06:	fffff097          	auipc	ra,0xfffff
    80002e0a:	712080e7          	jalr	1810(ra) # 80002518 <wait>
}
    80002e0e:	60e2                	ld	ra,24(sp)
    80002e10:	6442                	ld	s0,16(sp)
    80002e12:	6105                	addi	sp,sp,32
    80002e14:	8082                	ret

0000000080002e16 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002e16:	7179                	addi	sp,sp,-48
    80002e18:	f406                	sd	ra,40(sp)
    80002e1a:	f022                	sd	s0,32(sp)
    80002e1c:	ec26                	sd	s1,24(sp)
    80002e1e:	1800                	addi	s0,sp,48
  uint64 addr;
  int n;

  argint(0, &n);
    80002e20:	fdc40593          	addi	a1,s0,-36
    80002e24:	4501                	li	a0,0
    80002e26:	00000097          	auipc	ra,0x0
    80002e2a:	e84080e7          	jalr	-380(ra) # 80002caa <argint>
  addr = myproc()->sz;
    80002e2e:	fffff097          	auipc	ra,0xfffff
    80002e32:	b7e080e7          	jalr	-1154(ra) # 800019ac <myproc>
    80002e36:	6524                	ld	s1,72(a0)
  if (growproc(n) < 0)
    80002e38:	fdc42503          	lw	a0,-36(s0)
    80002e3c:	fffff097          	auipc	ra,0xfffff
    80002e40:	eca080e7          	jalr	-310(ra) # 80001d06 <growproc>
    80002e44:	00054863          	bltz	a0,80002e54 <sys_sbrk+0x3e>
    return -1;
  return addr;
}
    80002e48:	8526                	mv	a0,s1
    80002e4a:	70a2                	ld	ra,40(sp)
    80002e4c:	7402                	ld	s0,32(sp)
    80002e4e:	64e2                	ld	s1,24(sp)
    80002e50:	6145                	addi	sp,sp,48
    80002e52:	8082                	ret
    return -1;
    80002e54:	54fd                	li	s1,-1
    80002e56:	bfcd                	j	80002e48 <sys_sbrk+0x32>

0000000080002e58 <sys_sleep>:

uint64
sys_sleep(void)
{
    80002e58:	7139                	addi	sp,sp,-64
    80002e5a:	fc06                	sd	ra,56(sp)
    80002e5c:	f822                	sd	s0,48(sp)
    80002e5e:	f426                	sd	s1,40(sp)
    80002e60:	f04a                	sd	s2,32(sp)
    80002e62:	ec4e                	sd	s3,24(sp)
    80002e64:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    80002e66:	fcc40593          	addi	a1,s0,-52
    80002e6a:	4501                	li	a0,0
    80002e6c:	00000097          	auipc	ra,0x0
    80002e70:	e3e080e7          	jalr	-450(ra) # 80002caa <argint>
  acquire(&tickslock);
    80002e74:	00014517          	auipc	a0,0x14
    80002e78:	afc50513          	addi	a0,a0,-1284 # 80016970 <tickslock>
    80002e7c:	ffffe097          	auipc	ra,0xffffe
    80002e80:	d5a080e7          	jalr	-678(ra) # 80000bd6 <acquire>
  ticks0 = ticks;
    80002e84:	00006917          	auipc	s2,0x6
    80002e88:	a4c92903          	lw	s2,-1460(s2) # 800088d0 <ticks>
  while (ticks - ticks0 < n)
    80002e8c:	fcc42783          	lw	a5,-52(s0)
    80002e90:	cf9d                	beqz	a5,80002ece <sys_sleep+0x76>
    if (killed(myproc()))
    {
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80002e92:	00014997          	auipc	s3,0x14
    80002e96:	ade98993          	addi	s3,s3,-1314 # 80016970 <tickslock>
    80002e9a:	00006497          	auipc	s1,0x6
    80002e9e:	a3648493          	addi	s1,s1,-1482 # 800088d0 <ticks>
    if (killed(myproc()))
    80002ea2:	fffff097          	auipc	ra,0xfffff
    80002ea6:	b0a080e7          	jalr	-1270(ra) # 800019ac <myproc>
    80002eaa:	fffff097          	auipc	ra,0xfffff
    80002eae:	63c080e7          	jalr	1596(ra) # 800024e6 <killed>
    80002eb2:	ed15                	bnez	a0,80002eee <sys_sleep+0x96>
    sleep(&ticks, &tickslock);
    80002eb4:	85ce                	mv	a1,s3
    80002eb6:	8526                	mv	a0,s1
    80002eb8:	fffff097          	auipc	ra,0xfffff
    80002ebc:	19c080e7          	jalr	412(ra) # 80002054 <sleep>
  while (ticks - ticks0 < n)
    80002ec0:	409c                	lw	a5,0(s1)
    80002ec2:	412787bb          	subw	a5,a5,s2
    80002ec6:	fcc42703          	lw	a4,-52(s0)
    80002eca:	fce7ece3          	bltu	a5,a4,80002ea2 <sys_sleep+0x4a>
  }
  release(&tickslock);
    80002ece:	00014517          	auipc	a0,0x14
    80002ed2:	aa250513          	addi	a0,a0,-1374 # 80016970 <tickslock>
    80002ed6:	ffffe097          	auipc	ra,0xffffe
    80002eda:	db4080e7          	jalr	-588(ra) # 80000c8a <release>
  return 0;
    80002ede:	4501                	li	a0,0
}
    80002ee0:	70e2                	ld	ra,56(sp)
    80002ee2:	7442                	ld	s0,48(sp)
    80002ee4:	74a2                	ld	s1,40(sp)
    80002ee6:	7902                	ld	s2,32(sp)
    80002ee8:	69e2                	ld	s3,24(sp)
    80002eea:	6121                	addi	sp,sp,64
    80002eec:	8082                	ret
      release(&tickslock);
    80002eee:	00014517          	auipc	a0,0x14
    80002ef2:	a8250513          	addi	a0,a0,-1406 # 80016970 <tickslock>
    80002ef6:	ffffe097          	auipc	ra,0xffffe
    80002efa:	d94080e7          	jalr	-620(ra) # 80000c8a <release>
      return -1;
    80002efe:	557d                	li	a0,-1
    80002f00:	b7c5                	j	80002ee0 <sys_sleep+0x88>

0000000080002f02 <sys_kill>:

uint64
sys_kill(void)
{
    80002f02:	1101                	addi	sp,sp,-32
    80002f04:	ec06                	sd	ra,24(sp)
    80002f06:	e822                	sd	s0,16(sp)
    80002f08:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    80002f0a:	fec40593          	addi	a1,s0,-20
    80002f0e:	4501                	li	a0,0
    80002f10:	00000097          	auipc	ra,0x0
    80002f14:	d9a080e7          	jalr	-614(ra) # 80002caa <argint>
  return kill(pid);
    80002f18:	fec42503          	lw	a0,-20(s0)
    80002f1c:	fffff097          	auipc	ra,0xfffff
    80002f20:	342080e7          	jalr	834(ra) # 8000225e <kill>
}
    80002f24:	60e2                	ld	ra,24(sp)
    80002f26:	6442                	ld	s0,16(sp)
    80002f28:	6105                	addi	sp,sp,32
    80002f2a:	8082                	ret

0000000080002f2c <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80002f2c:	1101                	addi	sp,sp,-32
    80002f2e:	ec06                	sd	ra,24(sp)
    80002f30:	e822                	sd	s0,16(sp)
    80002f32:	e426                	sd	s1,8(sp)
    80002f34:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80002f36:	00014517          	auipc	a0,0x14
    80002f3a:	a3a50513          	addi	a0,a0,-1478 # 80016970 <tickslock>
    80002f3e:	ffffe097          	auipc	ra,0xffffe
    80002f42:	c98080e7          	jalr	-872(ra) # 80000bd6 <acquire>
  xticks = ticks;
    80002f46:	00006497          	auipc	s1,0x6
    80002f4a:	98a4a483          	lw	s1,-1654(s1) # 800088d0 <ticks>
  release(&tickslock);
    80002f4e:	00014517          	auipc	a0,0x14
    80002f52:	a2250513          	addi	a0,a0,-1502 # 80016970 <tickslock>
    80002f56:	ffffe097          	auipc	ra,0xffffe
    80002f5a:	d34080e7          	jalr	-716(ra) # 80000c8a <release>
  return xticks;
}
    80002f5e:	02049513          	slli	a0,s1,0x20
    80002f62:	9101                	srli	a0,a0,0x20
    80002f64:	60e2                	ld	ra,24(sp)
    80002f66:	6442                	ld	s0,16(sp)
    80002f68:	64a2                	ld	s1,8(sp)
    80002f6a:	6105                	addi	sp,sp,32
    80002f6c:	8082                	ret

0000000080002f6e <sys_pigs>:

uint64 sys_pigs(void)
{
    80002f6e:	1101                	addi	sp,sp,-32
    80002f70:	ec06                	sd	ra,24(sp)
    80002f72:	e822                	sd	s0,16(sp)
    80002f74:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    80002f76:	fec40593          	addi	a1,s0,-20
    80002f7a:	4501                	li	a0,0
    80002f7c:	00000097          	auipc	ra,0x0
    80002f80:	d2e080e7          	jalr	-722(ra) # 80002caa <argint>
  return pigwalk(pid);
    80002f84:	fec42503          	lw	a0,-20(s0)
    80002f88:	fffff097          	auipc	ra,0xfffff
    80002f8c:	4ae080e7          	jalr	1198(ra) # 80002436 <pigwalk>
}
    80002f90:	60e2                	ld	ra,24(sp)
    80002f92:	6442                	ld	s0,16(sp)
    80002f94:	6105                	addi	sp,sp,32
    80002f96:	8082                	ret

0000000080002f98 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80002f98:	7179                	addi	sp,sp,-48
    80002f9a:	f406                	sd	ra,40(sp)
    80002f9c:	f022                	sd	s0,32(sp)
    80002f9e:	ec26                	sd	s1,24(sp)
    80002fa0:	e84a                	sd	s2,16(sp)
    80002fa2:	e44e                	sd	s3,8(sp)
    80002fa4:	e052                	sd	s4,0(sp)
    80002fa6:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80002fa8:	00005597          	auipc	a1,0x5
    80002fac:	56858593          	addi	a1,a1,1384 # 80008510 <syscalls+0xb8>
    80002fb0:	00014517          	auipc	a0,0x14
    80002fb4:	9d850513          	addi	a0,a0,-1576 # 80016988 <bcache>
    80002fb8:	ffffe097          	auipc	ra,0xffffe
    80002fbc:	b8e080e7          	jalr	-1138(ra) # 80000b46 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80002fc0:	0001c797          	auipc	a5,0x1c
    80002fc4:	9c878793          	addi	a5,a5,-1592 # 8001e988 <bcache+0x8000>
    80002fc8:	0001c717          	auipc	a4,0x1c
    80002fcc:	c2870713          	addi	a4,a4,-984 # 8001ebf0 <bcache+0x8268>
    80002fd0:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80002fd4:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002fd8:	00014497          	auipc	s1,0x14
    80002fdc:	9c848493          	addi	s1,s1,-1592 # 800169a0 <bcache+0x18>
    b->next = bcache.head.next;
    80002fe0:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80002fe2:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80002fe4:	00005a17          	auipc	s4,0x5
    80002fe8:	534a0a13          	addi	s4,s4,1332 # 80008518 <syscalls+0xc0>
    b->next = bcache.head.next;
    80002fec:	2b893783          	ld	a5,696(s2)
    80002ff0:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80002ff2:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80002ff6:	85d2                	mv	a1,s4
    80002ff8:	01048513          	addi	a0,s1,16
    80002ffc:	00001097          	auipc	ra,0x1
    80003000:	4c4080e7          	jalr	1220(ra) # 800044c0 <initsleeplock>
    bcache.head.next->prev = b;
    80003004:	2b893783          	ld	a5,696(s2)
    80003008:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    8000300a:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    8000300e:	45848493          	addi	s1,s1,1112
    80003012:	fd349de3          	bne	s1,s3,80002fec <binit+0x54>
  }
}
    80003016:	70a2                	ld	ra,40(sp)
    80003018:	7402                	ld	s0,32(sp)
    8000301a:	64e2                	ld	s1,24(sp)
    8000301c:	6942                	ld	s2,16(sp)
    8000301e:	69a2                	ld	s3,8(sp)
    80003020:	6a02                	ld	s4,0(sp)
    80003022:	6145                	addi	sp,sp,48
    80003024:	8082                	ret

0000000080003026 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80003026:	7179                	addi	sp,sp,-48
    80003028:	f406                	sd	ra,40(sp)
    8000302a:	f022                	sd	s0,32(sp)
    8000302c:	ec26                	sd	s1,24(sp)
    8000302e:	e84a                	sd	s2,16(sp)
    80003030:	e44e                	sd	s3,8(sp)
    80003032:	1800                	addi	s0,sp,48
    80003034:	892a                	mv	s2,a0
    80003036:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    80003038:	00014517          	auipc	a0,0x14
    8000303c:	95050513          	addi	a0,a0,-1712 # 80016988 <bcache>
    80003040:	ffffe097          	auipc	ra,0xffffe
    80003044:	b96080e7          	jalr	-1130(ra) # 80000bd6 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80003048:	0001c497          	auipc	s1,0x1c
    8000304c:	bf84b483          	ld	s1,-1032(s1) # 8001ec40 <bcache+0x82b8>
    80003050:	0001c797          	auipc	a5,0x1c
    80003054:	ba078793          	addi	a5,a5,-1120 # 8001ebf0 <bcache+0x8268>
    80003058:	02f48f63          	beq	s1,a5,80003096 <bread+0x70>
    8000305c:	873e                	mv	a4,a5
    8000305e:	a021                	j	80003066 <bread+0x40>
    80003060:	68a4                	ld	s1,80(s1)
    80003062:	02e48a63          	beq	s1,a4,80003096 <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    80003066:	449c                	lw	a5,8(s1)
    80003068:	ff279ce3          	bne	a5,s2,80003060 <bread+0x3a>
    8000306c:	44dc                	lw	a5,12(s1)
    8000306e:	ff3799e3          	bne	a5,s3,80003060 <bread+0x3a>
      b->refcnt++;
    80003072:	40bc                	lw	a5,64(s1)
    80003074:	2785                	addiw	a5,a5,1
    80003076:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80003078:	00014517          	auipc	a0,0x14
    8000307c:	91050513          	addi	a0,a0,-1776 # 80016988 <bcache>
    80003080:	ffffe097          	auipc	ra,0xffffe
    80003084:	c0a080e7          	jalr	-1014(ra) # 80000c8a <release>
      acquiresleep(&b->lock);
    80003088:	01048513          	addi	a0,s1,16
    8000308c:	00001097          	auipc	ra,0x1
    80003090:	46e080e7          	jalr	1134(ra) # 800044fa <acquiresleep>
      return b;
    80003094:	a8b9                	j	800030f2 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80003096:	0001c497          	auipc	s1,0x1c
    8000309a:	ba24b483          	ld	s1,-1118(s1) # 8001ec38 <bcache+0x82b0>
    8000309e:	0001c797          	auipc	a5,0x1c
    800030a2:	b5278793          	addi	a5,a5,-1198 # 8001ebf0 <bcache+0x8268>
    800030a6:	00f48863          	beq	s1,a5,800030b6 <bread+0x90>
    800030aa:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    800030ac:	40bc                	lw	a5,64(s1)
    800030ae:	cf81                	beqz	a5,800030c6 <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800030b0:	64a4                	ld	s1,72(s1)
    800030b2:	fee49de3          	bne	s1,a4,800030ac <bread+0x86>
  panic("bget: no buffers");
    800030b6:	00005517          	auipc	a0,0x5
    800030ba:	46a50513          	addi	a0,a0,1130 # 80008520 <syscalls+0xc8>
    800030be:	ffffd097          	auipc	ra,0xffffd
    800030c2:	480080e7          	jalr	1152(ra) # 8000053e <panic>
      b->dev = dev;
    800030c6:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    800030ca:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    800030ce:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    800030d2:	4785                	li	a5,1
    800030d4:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800030d6:	00014517          	auipc	a0,0x14
    800030da:	8b250513          	addi	a0,a0,-1870 # 80016988 <bcache>
    800030de:	ffffe097          	auipc	ra,0xffffe
    800030e2:	bac080e7          	jalr	-1108(ra) # 80000c8a <release>
      acquiresleep(&b->lock);
    800030e6:	01048513          	addi	a0,s1,16
    800030ea:	00001097          	auipc	ra,0x1
    800030ee:	410080e7          	jalr	1040(ra) # 800044fa <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    800030f2:	409c                	lw	a5,0(s1)
    800030f4:	cb89                	beqz	a5,80003106 <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    800030f6:	8526                	mv	a0,s1
    800030f8:	70a2                	ld	ra,40(sp)
    800030fa:	7402                	ld	s0,32(sp)
    800030fc:	64e2                	ld	s1,24(sp)
    800030fe:	6942                	ld	s2,16(sp)
    80003100:	69a2                	ld	s3,8(sp)
    80003102:	6145                	addi	sp,sp,48
    80003104:	8082                	ret
    virtio_disk_rw(b, 0);
    80003106:	4581                	li	a1,0
    80003108:	8526                	mv	a0,s1
    8000310a:	00003097          	auipc	ra,0x3
    8000310e:	fda080e7          	jalr	-38(ra) # 800060e4 <virtio_disk_rw>
    b->valid = 1;
    80003112:	4785                	li	a5,1
    80003114:	c09c                	sw	a5,0(s1)
  return b;
    80003116:	b7c5                	j	800030f6 <bread+0xd0>

0000000080003118 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80003118:	1101                	addi	sp,sp,-32
    8000311a:	ec06                	sd	ra,24(sp)
    8000311c:	e822                	sd	s0,16(sp)
    8000311e:	e426                	sd	s1,8(sp)
    80003120:	1000                	addi	s0,sp,32
    80003122:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80003124:	0541                	addi	a0,a0,16
    80003126:	00001097          	auipc	ra,0x1
    8000312a:	46e080e7          	jalr	1134(ra) # 80004594 <holdingsleep>
    8000312e:	cd01                	beqz	a0,80003146 <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80003130:	4585                	li	a1,1
    80003132:	8526                	mv	a0,s1
    80003134:	00003097          	auipc	ra,0x3
    80003138:	fb0080e7          	jalr	-80(ra) # 800060e4 <virtio_disk_rw>
}
    8000313c:	60e2                	ld	ra,24(sp)
    8000313e:	6442                	ld	s0,16(sp)
    80003140:	64a2                	ld	s1,8(sp)
    80003142:	6105                	addi	sp,sp,32
    80003144:	8082                	ret
    panic("bwrite");
    80003146:	00005517          	auipc	a0,0x5
    8000314a:	3f250513          	addi	a0,a0,1010 # 80008538 <syscalls+0xe0>
    8000314e:	ffffd097          	auipc	ra,0xffffd
    80003152:	3f0080e7          	jalr	1008(ra) # 8000053e <panic>

0000000080003156 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80003156:	1101                	addi	sp,sp,-32
    80003158:	ec06                	sd	ra,24(sp)
    8000315a:	e822                	sd	s0,16(sp)
    8000315c:	e426                	sd	s1,8(sp)
    8000315e:	e04a                	sd	s2,0(sp)
    80003160:	1000                	addi	s0,sp,32
    80003162:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80003164:	01050913          	addi	s2,a0,16
    80003168:	854a                	mv	a0,s2
    8000316a:	00001097          	auipc	ra,0x1
    8000316e:	42a080e7          	jalr	1066(ra) # 80004594 <holdingsleep>
    80003172:	c92d                	beqz	a0,800031e4 <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    80003174:	854a                	mv	a0,s2
    80003176:	00001097          	auipc	ra,0x1
    8000317a:	3da080e7          	jalr	986(ra) # 80004550 <releasesleep>

  acquire(&bcache.lock);
    8000317e:	00014517          	auipc	a0,0x14
    80003182:	80a50513          	addi	a0,a0,-2038 # 80016988 <bcache>
    80003186:	ffffe097          	auipc	ra,0xffffe
    8000318a:	a50080e7          	jalr	-1456(ra) # 80000bd6 <acquire>
  b->refcnt--;
    8000318e:	40bc                	lw	a5,64(s1)
    80003190:	37fd                	addiw	a5,a5,-1
    80003192:	0007871b          	sext.w	a4,a5
    80003196:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80003198:	eb05                	bnez	a4,800031c8 <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    8000319a:	68bc                	ld	a5,80(s1)
    8000319c:	64b8                	ld	a4,72(s1)
    8000319e:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    800031a0:	64bc                	ld	a5,72(s1)
    800031a2:	68b8                	ld	a4,80(s1)
    800031a4:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    800031a6:	0001b797          	auipc	a5,0x1b
    800031aa:	7e278793          	addi	a5,a5,2018 # 8001e988 <bcache+0x8000>
    800031ae:	2b87b703          	ld	a4,696(a5)
    800031b2:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    800031b4:	0001c717          	auipc	a4,0x1c
    800031b8:	a3c70713          	addi	a4,a4,-1476 # 8001ebf0 <bcache+0x8268>
    800031bc:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    800031be:	2b87b703          	ld	a4,696(a5)
    800031c2:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    800031c4:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    800031c8:	00013517          	auipc	a0,0x13
    800031cc:	7c050513          	addi	a0,a0,1984 # 80016988 <bcache>
    800031d0:	ffffe097          	auipc	ra,0xffffe
    800031d4:	aba080e7          	jalr	-1350(ra) # 80000c8a <release>
}
    800031d8:	60e2                	ld	ra,24(sp)
    800031da:	6442                	ld	s0,16(sp)
    800031dc:	64a2                	ld	s1,8(sp)
    800031de:	6902                	ld	s2,0(sp)
    800031e0:	6105                	addi	sp,sp,32
    800031e2:	8082                	ret
    panic("brelse");
    800031e4:	00005517          	auipc	a0,0x5
    800031e8:	35c50513          	addi	a0,a0,860 # 80008540 <syscalls+0xe8>
    800031ec:	ffffd097          	auipc	ra,0xffffd
    800031f0:	352080e7          	jalr	850(ra) # 8000053e <panic>

00000000800031f4 <bpin>:

void
bpin(struct buf *b) {
    800031f4:	1101                	addi	sp,sp,-32
    800031f6:	ec06                	sd	ra,24(sp)
    800031f8:	e822                	sd	s0,16(sp)
    800031fa:	e426                	sd	s1,8(sp)
    800031fc:	1000                	addi	s0,sp,32
    800031fe:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80003200:	00013517          	auipc	a0,0x13
    80003204:	78850513          	addi	a0,a0,1928 # 80016988 <bcache>
    80003208:	ffffe097          	auipc	ra,0xffffe
    8000320c:	9ce080e7          	jalr	-1586(ra) # 80000bd6 <acquire>
  b->refcnt++;
    80003210:	40bc                	lw	a5,64(s1)
    80003212:	2785                	addiw	a5,a5,1
    80003214:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80003216:	00013517          	auipc	a0,0x13
    8000321a:	77250513          	addi	a0,a0,1906 # 80016988 <bcache>
    8000321e:	ffffe097          	auipc	ra,0xffffe
    80003222:	a6c080e7          	jalr	-1428(ra) # 80000c8a <release>
}
    80003226:	60e2                	ld	ra,24(sp)
    80003228:	6442                	ld	s0,16(sp)
    8000322a:	64a2                	ld	s1,8(sp)
    8000322c:	6105                	addi	sp,sp,32
    8000322e:	8082                	ret

0000000080003230 <bunpin>:

void
bunpin(struct buf *b) {
    80003230:	1101                	addi	sp,sp,-32
    80003232:	ec06                	sd	ra,24(sp)
    80003234:	e822                	sd	s0,16(sp)
    80003236:	e426                	sd	s1,8(sp)
    80003238:	1000                	addi	s0,sp,32
    8000323a:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    8000323c:	00013517          	auipc	a0,0x13
    80003240:	74c50513          	addi	a0,a0,1868 # 80016988 <bcache>
    80003244:	ffffe097          	auipc	ra,0xffffe
    80003248:	992080e7          	jalr	-1646(ra) # 80000bd6 <acquire>
  b->refcnt--;
    8000324c:	40bc                	lw	a5,64(s1)
    8000324e:	37fd                	addiw	a5,a5,-1
    80003250:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80003252:	00013517          	auipc	a0,0x13
    80003256:	73650513          	addi	a0,a0,1846 # 80016988 <bcache>
    8000325a:	ffffe097          	auipc	ra,0xffffe
    8000325e:	a30080e7          	jalr	-1488(ra) # 80000c8a <release>
}
    80003262:	60e2                	ld	ra,24(sp)
    80003264:	6442                	ld	s0,16(sp)
    80003266:	64a2                	ld	s1,8(sp)
    80003268:	6105                	addi	sp,sp,32
    8000326a:	8082                	ret

000000008000326c <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    8000326c:	1101                	addi	sp,sp,-32
    8000326e:	ec06                	sd	ra,24(sp)
    80003270:	e822                	sd	s0,16(sp)
    80003272:	e426                	sd	s1,8(sp)
    80003274:	e04a                	sd	s2,0(sp)
    80003276:	1000                	addi	s0,sp,32
    80003278:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    8000327a:	00d5d59b          	srliw	a1,a1,0xd
    8000327e:	0001c797          	auipc	a5,0x1c
    80003282:	de67a783          	lw	a5,-538(a5) # 8001f064 <sb+0x1c>
    80003286:	9dbd                	addw	a1,a1,a5
    80003288:	00000097          	auipc	ra,0x0
    8000328c:	d9e080e7          	jalr	-610(ra) # 80003026 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    80003290:	0074f713          	andi	a4,s1,7
    80003294:	4785                	li	a5,1
    80003296:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    8000329a:	14ce                	slli	s1,s1,0x33
    8000329c:	90d9                	srli	s1,s1,0x36
    8000329e:	00950733          	add	a4,a0,s1
    800032a2:	05874703          	lbu	a4,88(a4)
    800032a6:	00e7f6b3          	and	a3,a5,a4
    800032aa:	c69d                	beqz	a3,800032d8 <bfree+0x6c>
    800032ac:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    800032ae:	94aa                	add	s1,s1,a0
    800032b0:	fff7c793          	not	a5,a5
    800032b4:	8ff9                	and	a5,a5,a4
    800032b6:	04f48c23          	sb	a5,88(s1)
  log_write(bp);
    800032ba:	00001097          	auipc	ra,0x1
    800032be:	120080e7          	jalr	288(ra) # 800043da <log_write>
  brelse(bp);
    800032c2:	854a                	mv	a0,s2
    800032c4:	00000097          	auipc	ra,0x0
    800032c8:	e92080e7          	jalr	-366(ra) # 80003156 <brelse>
}
    800032cc:	60e2                	ld	ra,24(sp)
    800032ce:	6442                	ld	s0,16(sp)
    800032d0:	64a2                	ld	s1,8(sp)
    800032d2:	6902                	ld	s2,0(sp)
    800032d4:	6105                	addi	sp,sp,32
    800032d6:	8082                	ret
    panic("freeing free block");
    800032d8:	00005517          	auipc	a0,0x5
    800032dc:	27050513          	addi	a0,a0,624 # 80008548 <syscalls+0xf0>
    800032e0:	ffffd097          	auipc	ra,0xffffd
    800032e4:	25e080e7          	jalr	606(ra) # 8000053e <panic>

00000000800032e8 <balloc>:
{
    800032e8:	711d                	addi	sp,sp,-96
    800032ea:	ec86                	sd	ra,88(sp)
    800032ec:	e8a2                	sd	s0,80(sp)
    800032ee:	e4a6                	sd	s1,72(sp)
    800032f0:	e0ca                	sd	s2,64(sp)
    800032f2:	fc4e                	sd	s3,56(sp)
    800032f4:	f852                	sd	s4,48(sp)
    800032f6:	f456                	sd	s5,40(sp)
    800032f8:	f05a                	sd	s6,32(sp)
    800032fa:	ec5e                	sd	s7,24(sp)
    800032fc:	e862                	sd	s8,16(sp)
    800032fe:	e466                	sd	s9,8(sp)
    80003300:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80003302:	0001c797          	auipc	a5,0x1c
    80003306:	d4a7a783          	lw	a5,-694(a5) # 8001f04c <sb+0x4>
    8000330a:	10078163          	beqz	a5,8000340c <balloc+0x124>
    8000330e:	8baa                	mv	s7,a0
    80003310:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80003312:	0001cb17          	auipc	s6,0x1c
    80003316:	d36b0b13          	addi	s6,s6,-714 # 8001f048 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000331a:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    8000331c:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000331e:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80003320:	6c89                	lui	s9,0x2
    80003322:	a061                	j	800033aa <balloc+0xc2>
        bp->data[bi/8] |= m;  // Mark block in use.
    80003324:	974a                	add	a4,a4,s2
    80003326:	8fd5                	or	a5,a5,a3
    80003328:	04f70c23          	sb	a5,88(a4)
        log_write(bp);
    8000332c:	854a                	mv	a0,s2
    8000332e:	00001097          	auipc	ra,0x1
    80003332:	0ac080e7          	jalr	172(ra) # 800043da <log_write>
        brelse(bp);
    80003336:	854a                	mv	a0,s2
    80003338:	00000097          	auipc	ra,0x0
    8000333c:	e1e080e7          	jalr	-482(ra) # 80003156 <brelse>
  bp = bread(dev, bno);
    80003340:	85a6                	mv	a1,s1
    80003342:	855e                	mv	a0,s7
    80003344:	00000097          	auipc	ra,0x0
    80003348:	ce2080e7          	jalr	-798(ra) # 80003026 <bread>
    8000334c:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    8000334e:	40000613          	li	a2,1024
    80003352:	4581                	li	a1,0
    80003354:	05850513          	addi	a0,a0,88
    80003358:	ffffe097          	auipc	ra,0xffffe
    8000335c:	97a080e7          	jalr	-1670(ra) # 80000cd2 <memset>
  log_write(bp);
    80003360:	854a                	mv	a0,s2
    80003362:	00001097          	auipc	ra,0x1
    80003366:	078080e7          	jalr	120(ra) # 800043da <log_write>
  brelse(bp);
    8000336a:	854a                	mv	a0,s2
    8000336c:	00000097          	auipc	ra,0x0
    80003370:	dea080e7          	jalr	-534(ra) # 80003156 <brelse>
}
    80003374:	8526                	mv	a0,s1
    80003376:	60e6                	ld	ra,88(sp)
    80003378:	6446                	ld	s0,80(sp)
    8000337a:	64a6                	ld	s1,72(sp)
    8000337c:	6906                	ld	s2,64(sp)
    8000337e:	79e2                	ld	s3,56(sp)
    80003380:	7a42                	ld	s4,48(sp)
    80003382:	7aa2                	ld	s5,40(sp)
    80003384:	7b02                	ld	s6,32(sp)
    80003386:	6be2                	ld	s7,24(sp)
    80003388:	6c42                	ld	s8,16(sp)
    8000338a:	6ca2                	ld	s9,8(sp)
    8000338c:	6125                	addi	sp,sp,96
    8000338e:	8082                	ret
    brelse(bp);
    80003390:	854a                	mv	a0,s2
    80003392:	00000097          	auipc	ra,0x0
    80003396:	dc4080e7          	jalr	-572(ra) # 80003156 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    8000339a:	015c87bb          	addw	a5,s9,s5
    8000339e:	00078a9b          	sext.w	s5,a5
    800033a2:	004b2703          	lw	a4,4(s6)
    800033a6:	06eaf363          	bgeu	s5,a4,8000340c <balloc+0x124>
    bp = bread(dev, BBLOCK(b, sb));
    800033aa:	41fad79b          	sraiw	a5,s5,0x1f
    800033ae:	0137d79b          	srliw	a5,a5,0x13
    800033b2:	015787bb          	addw	a5,a5,s5
    800033b6:	40d7d79b          	sraiw	a5,a5,0xd
    800033ba:	01cb2583          	lw	a1,28(s6)
    800033be:	9dbd                	addw	a1,a1,a5
    800033c0:	855e                	mv	a0,s7
    800033c2:	00000097          	auipc	ra,0x0
    800033c6:	c64080e7          	jalr	-924(ra) # 80003026 <bread>
    800033ca:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800033cc:	004b2503          	lw	a0,4(s6)
    800033d0:	000a849b          	sext.w	s1,s5
    800033d4:	8662                	mv	a2,s8
    800033d6:	faa4fde3          	bgeu	s1,a0,80003390 <balloc+0xa8>
      m = 1 << (bi % 8);
    800033da:	41f6579b          	sraiw	a5,a2,0x1f
    800033de:	01d7d69b          	srliw	a3,a5,0x1d
    800033e2:	00c6873b          	addw	a4,a3,a2
    800033e6:	00777793          	andi	a5,a4,7
    800033ea:	9f95                	subw	a5,a5,a3
    800033ec:	00f997bb          	sllw	a5,s3,a5
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    800033f0:	4037571b          	sraiw	a4,a4,0x3
    800033f4:	00e906b3          	add	a3,s2,a4
    800033f8:	0586c683          	lbu	a3,88(a3)
    800033fc:	00d7f5b3          	and	a1,a5,a3
    80003400:	d195                	beqz	a1,80003324 <balloc+0x3c>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003402:	2605                	addiw	a2,a2,1
    80003404:	2485                	addiw	s1,s1,1
    80003406:	fd4618e3          	bne	a2,s4,800033d6 <balloc+0xee>
    8000340a:	b759                	j	80003390 <balloc+0xa8>
  printf("balloc: out of blocks\n");
    8000340c:	00005517          	auipc	a0,0x5
    80003410:	15450513          	addi	a0,a0,340 # 80008560 <syscalls+0x108>
    80003414:	ffffd097          	auipc	ra,0xffffd
    80003418:	174080e7          	jalr	372(ra) # 80000588 <printf>
  return 0;
    8000341c:	4481                	li	s1,0
    8000341e:	bf99                	j	80003374 <balloc+0x8c>

0000000080003420 <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    80003420:	7179                	addi	sp,sp,-48
    80003422:	f406                	sd	ra,40(sp)
    80003424:	f022                	sd	s0,32(sp)
    80003426:	ec26                	sd	s1,24(sp)
    80003428:	e84a                	sd	s2,16(sp)
    8000342a:	e44e                	sd	s3,8(sp)
    8000342c:	e052                	sd	s4,0(sp)
    8000342e:	1800                	addi	s0,sp,48
    80003430:	89aa                	mv	s3,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80003432:	47ad                	li	a5,11
    80003434:	02b7e763          	bltu	a5,a1,80003462 <bmap+0x42>
    if((addr = ip->addrs[bn]) == 0){
    80003438:	02059493          	slli	s1,a1,0x20
    8000343c:	9081                	srli	s1,s1,0x20
    8000343e:	048a                	slli	s1,s1,0x2
    80003440:	94aa                	add	s1,s1,a0
    80003442:	0504a903          	lw	s2,80(s1)
    80003446:	06091e63          	bnez	s2,800034c2 <bmap+0xa2>
      addr = balloc(ip->dev);
    8000344a:	4108                	lw	a0,0(a0)
    8000344c:	00000097          	auipc	ra,0x0
    80003450:	e9c080e7          	jalr	-356(ra) # 800032e8 <balloc>
    80003454:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    80003458:	06090563          	beqz	s2,800034c2 <bmap+0xa2>
        return 0;
      ip->addrs[bn] = addr;
    8000345c:	0524a823          	sw	s2,80(s1)
    80003460:	a08d                	j	800034c2 <bmap+0xa2>
    }
    return addr;
  }
  bn -= NDIRECT;
    80003462:	ff45849b          	addiw	s1,a1,-12
    80003466:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    8000346a:	0ff00793          	li	a5,255
    8000346e:	08e7e563          	bltu	a5,a4,800034f8 <bmap+0xd8>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    80003472:	08052903          	lw	s2,128(a0)
    80003476:	00091d63          	bnez	s2,80003490 <bmap+0x70>
      addr = balloc(ip->dev);
    8000347a:	4108                	lw	a0,0(a0)
    8000347c:	00000097          	auipc	ra,0x0
    80003480:	e6c080e7          	jalr	-404(ra) # 800032e8 <balloc>
    80003484:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    80003488:	02090d63          	beqz	s2,800034c2 <bmap+0xa2>
        return 0;
      ip->addrs[NDIRECT] = addr;
    8000348c:	0929a023          	sw	s2,128(s3)
    }
    bp = bread(ip->dev, addr);
    80003490:	85ca                	mv	a1,s2
    80003492:	0009a503          	lw	a0,0(s3)
    80003496:	00000097          	auipc	ra,0x0
    8000349a:	b90080e7          	jalr	-1136(ra) # 80003026 <bread>
    8000349e:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    800034a0:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    800034a4:	02049593          	slli	a1,s1,0x20
    800034a8:	9181                	srli	a1,a1,0x20
    800034aa:	058a                	slli	a1,a1,0x2
    800034ac:	00b784b3          	add	s1,a5,a1
    800034b0:	0004a903          	lw	s2,0(s1)
    800034b4:	02090063          	beqz	s2,800034d4 <bmap+0xb4>
      if(addr){
        a[bn] = addr;
        log_write(bp);
      }
    }
    brelse(bp);
    800034b8:	8552                	mv	a0,s4
    800034ba:	00000097          	auipc	ra,0x0
    800034be:	c9c080e7          	jalr	-868(ra) # 80003156 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    800034c2:	854a                	mv	a0,s2
    800034c4:	70a2                	ld	ra,40(sp)
    800034c6:	7402                	ld	s0,32(sp)
    800034c8:	64e2                	ld	s1,24(sp)
    800034ca:	6942                	ld	s2,16(sp)
    800034cc:	69a2                	ld	s3,8(sp)
    800034ce:	6a02                	ld	s4,0(sp)
    800034d0:	6145                	addi	sp,sp,48
    800034d2:	8082                	ret
      addr = balloc(ip->dev);
    800034d4:	0009a503          	lw	a0,0(s3)
    800034d8:	00000097          	auipc	ra,0x0
    800034dc:	e10080e7          	jalr	-496(ra) # 800032e8 <balloc>
    800034e0:	0005091b          	sext.w	s2,a0
      if(addr){
    800034e4:	fc090ae3          	beqz	s2,800034b8 <bmap+0x98>
        a[bn] = addr;
    800034e8:	0124a023          	sw	s2,0(s1)
        log_write(bp);
    800034ec:	8552                	mv	a0,s4
    800034ee:	00001097          	auipc	ra,0x1
    800034f2:	eec080e7          	jalr	-276(ra) # 800043da <log_write>
    800034f6:	b7c9                	j	800034b8 <bmap+0x98>
  panic("bmap: out of range");
    800034f8:	00005517          	auipc	a0,0x5
    800034fc:	08050513          	addi	a0,a0,128 # 80008578 <syscalls+0x120>
    80003500:	ffffd097          	auipc	ra,0xffffd
    80003504:	03e080e7          	jalr	62(ra) # 8000053e <panic>

0000000080003508 <iget>:
{
    80003508:	7179                	addi	sp,sp,-48
    8000350a:	f406                	sd	ra,40(sp)
    8000350c:	f022                	sd	s0,32(sp)
    8000350e:	ec26                	sd	s1,24(sp)
    80003510:	e84a                	sd	s2,16(sp)
    80003512:	e44e                	sd	s3,8(sp)
    80003514:	e052                	sd	s4,0(sp)
    80003516:	1800                	addi	s0,sp,48
    80003518:	89aa                	mv	s3,a0
    8000351a:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    8000351c:	0001c517          	auipc	a0,0x1c
    80003520:	b4c50513          	addi	a0,a0,-1204 # 8001f068 <itable>
    80003524:	ffffd097          	auipc	ra,0xffffd
    80003528:	6b2080e7          	jalr	1714(ra) # 80000bd6 <acquire>
  empty = 0;
    8000352c:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    8000352e:	0001c497          	auipc	s1,0x1c
    80003532:	b5248493          	addi	s1,s1,-1198 # 8001f080 <itable+0x18>
    80003536:	0001d697          	auipc	a3,0x1d
    8000353a:	5da68693          	addi	a3,a3,1498 # 80020b10 <log>
    8000353e:	a039                	j	8000354c <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80003540:	02090b63          	beqz	s2,80003576 <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80003544:	08848493          	addi	s1,s1,136
    80003548:	02d48a63          	beq	s1,a3,8000357c <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    8000354c:	449c                	lw	a5,8(s1)
    8000354e:	fef059e3          	blez	a5,80003540 <iget+0x38>
    80003552:	4098                	lw	a4,0(s1)
    80003554:	ff3716e3          	bne	a4,s3,80003540 <iget+0x38>
    80003558:	40d8                	lw	a4,4(s1)
    8000355a:	ff4713e3          	bne	a4,s4,80003540 <iget+0x38>
      ip->ref++;
    8000355e:	2785                	addiw	a5,a5,1
    80003560:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80003562:	0001c517          	auipc	a0,0x1c
    80003566:	b0650513          	addi	a0,a0,-1274 # 8001f068 <itable>
    8000356a:	ffffd097          	auipc	ra,0xffffd
    8000356e:	720080e7          	jalr	1824(ra) # 80000c8a <release>
      return ip;
    80003572:	8926                	mv	s2,s1
    80003574:	a03d                	j	800035a2 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80003576:	f7f9                	bnez	a5,80003544 <iget+0x3c>
    80003578:	8926                	mv	s2,s1
    8000357a:	b7e9                	j	80003544 <iget+0x3c>
  if(empty == 0)
    8000357c:	02090c63          	beqz	s2,800035b4 <iget+0xac>
  ip->dev = dev;
    80003580:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80003584:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    80003588:	4785                	li	a5,1
    8000358a:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    8000358e:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80003592:	0001c517          	auipc	a0,0x1c
    80003596:	ad650513          	addi	a0,a0,-1322 # 8001f068 <itable>
    8000359a:	ffffd097          	auipc	ra,0xffffd
    8000359e:	6f0080e7          	jalr	1776(ra) # 80000c8a <release>
}
    800035a2:	854a                	mv	a0,s2
    800035a4:	70a2                	ld	ra,40(sp)
    800035a6:	7402                	ld	s0,32(sp)
    800035a8:	64e2                	ld	s1,24(sp)
    800035aa:	6942                	ld	s2,16(sp)
    800035ac:	69a2                	ld	s3,8(sp)
    800035ae:	6a02                	ld	s4,0(sp)
    800035b0:	6145                	addi	sp,sp,48
    800035b2:	8082                	ret
    panic("iget: no inodes");
    800035b4:	00005517          	auipc	a0,0x5
    800035b8:	fdc50513          	addi	a0,a0,-36 # 80008590 <syscalls+0x138>
    800035bc:	ffffd097          	auipc	ra,0xffffd
    800035c0:	f82080e7          	jalr	-126(ra) # 8000053e <panic>

00000000800035c4 <fsinit>:
fsinit(int dev) {
    800035c4:	7179                	addi	sp,sp,-48
    800035c6:	f406                	sd	ra,40(sp)
    800035c8:	f022                	sd	s0,32(sp)
    800035ca:	ec26                	sd	s1,24(sp)
    800035cc:	e84a                	sd	s2,16(sp)
    800035ce:	e44e                	sd	s3,8(sp)
    800035d0:	1800                	addi	s0,sp,48
    800035d2:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    800035d4:	4585                	li	a1,1
    800035d6:	00000097          	auipc	ra,0x0
    800035da:	a50080e7          	jalr	-1456(ra) # 80003026 <bread>
    800035de:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    800035e0:	0001c997          	auipc	s3,0x1c
    800035e4:	a6898993          	addi	s3,s3,-1432 # 8001f048 <sb>
    800035e8:	02000613          	li	a2,32
    800035ec:	05850593          	addi	a1,a0,88
    800035f0:	854e                	mv	a0,s3
    800035f2:	ffffd097          	auipc	ra,0xffffd
    800035f6:	73c080e7          	jalr	1852(ra) # 80000d2e <memmove>
  brelse(bp);
    800035fa:	8526                	mv	a0,s1
    800035fc:	00000097          	auipc	ra,0x0
    80003600:	b5a080e7          	jalr	-1190(ra) # 80003156 <brelse>
  if(sb.magic != FSMAGIC)
    80003604:	0009a703          	lw	a4,0(s3)
    80003608:	102037b7          	lui	a5,0x10203
    8000360c:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80003610:	02f71263          	bne	a4,a5,80003634 <fsinit+0x70>
  initlog(dev, &sb);
    80003614:	0001c597          	auipc	a1,0x1c
    80003618:	a3458593          	addi	a1,a1,-1484 # 8001f048 <sb>
    8000361c:	854a                	mv	a0,s2
    8000361e:	00001097          	auipc	ra,0x1
    80003622:	b40080e7          	jalr	-1216(ra) # 8000415e <initlog>
}
    80003626:	70a2                	ld	ra,40(sp)
    80003628:	7402                	ld	s0,32(sp)
    8000362a:	64e2                	ld	s1,24(sp)
    8000362c:	6942                	ld	s2,16(sp)
    8000362e:	69a2                	ld	s3,8(sp)
    80003630:	6145                	addi	sp,sp,48
    80003632:	8082                	ret
    panic("invalid file system");
    80003634:	00005517          	auipc	a0,0x5
    80003638:	f6c50513          	addi	a0,a0,-148 # 800085a0 <syscalls+0x148>
    8000363c:	ffffd097          	auipc	ra,0xffffd
    80003640:	f02080e7          	jalr	-254(ra) # 8000053e <panic>

0000000080003644 <iinit>:
{
    80003644:	7179                	addi	sp,sp,-48
    80003646:	f406                	sd	ra,40(sp)
    80003648:	f022                	sd	s0,32(sp)
    8000364a:	ec26                	sd	s1,24(sp)
    8000364c:	e84a                	sd	s2,16(sp)
    8000364e:	e44e                	sd	s3,8(sp)
    80003650:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    80003652:	00005597          	auipc	a1,0x5
    80003656:	f6658593          	addi	a1,a1,-154 # 800085b8 <syscalls+0x160>
    8000365a:	0001c517          	auipc	a0,0x1c
    8000365e:	a0e50513          	addi	a0,a0,-1522 # 8001f068 <itable>
    80003662:	ffffd097          	auipc	ra,0xffffd
    80003666:	4e4080e7          	jalr	1252(ra) # 80000b46 <initlock>
  for(i = 0; i < NINODE; i++) {
    8000366a:	0001c497          	auipc	s1,0x1c
    8000366e:	a2648493          	addi	s1,s1,-1498 # 8001f090 <itable+0x28>
    80003672:	0001d997          	auipc	s3,0x1d
    80003676:	4ae98993          	addi	s3,s3,1198 # 80020b20 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    8000367a:	00005917          	auipc	s2,0x5
    8000367e:	f4690913          	addi	s2,s2,-186 # 800085c0 <syscalls+0x168>
    80003682:	85ca                	mv	a1,s2
    80003684:	8526                	mv	a0,s1
    80003686:	00001097          	auipc	ra,0x1
    8000368a:	e3a080e7          	jalr	-454(ra) # 800044c0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    8000368e:	08848493          	addi	s1,s1,136
    80003692:	ff3498e3          	bne	s1,s3,80003682 <iinit+0x3e>
}
    80003696:	70a2                	ld	ra,40(sp)
    80003698:	7402                	ld	s0,32(sp)
    8000369a:	64e2                	ld	s1,24(sp)
    8000369c:	6942                	ld	s2,16(sp)
    8000369e:	69a2                	ld	s3,8(sp)
    800036a0:	6145                	addi	sp,sp,48
    800036a2:	8082                	ret

00000000800036a4 <ialloc>:
{
    800036a4:	715d                	addi	sp,sp,-80
    800036a6:	e486                	sd	ra,72(sp)
    800036a8:	e0a2                	sd	s0,64(sp)
    800036aa:	fc26                	sd	s1,56(sp)
    800036ac:	f84a                	sd	s2,48(sp)
    800036ae:	f44e                	sd	s3,40(sp)
    800036b0:	f052                	sd	s4,32(sp)
    800036b2:	ec56                	sd	s5,24(sp)
    800036b4:	e85a                	sd	s6,16(sp)
    800036b6:	e45e                	sd	s7,8(sp)
    800036b8:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    800036ba:	0001c717          	auipc	a4,0x1c
    800036be:	99a72703          	lw	a4,-1638(a4) # 8001f054 <sb+0xc>
    800036c2:	4785                	li	a5,1
    800036c4:	04e7fa63          	bgeu	a5,a4,80003718 <ialloc+0x74>
    800036c8:	8aaa                	mv	s5,a0
    800036ca:	8bae                	mv	s7,a1
    800036cc:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    800036ce:	0001ca17          	auipc	s4,0x1c
    800036d2:	97aa0a13          	addi	s4,s4,-1670 # 8001f048 <sb>
    800036d6:	00048b1b          	sext.w	s6,s1
    800036da:	0044d793          	srli	a5,s1,0x4
    800036de:	018a2583          	lw	a1,24(s4)
    800036e2:	9dbd                	addw	a1,a1,a5
    800036e4:	8556                	mv	a0,s5
    800036e6:	00000097          	auipc	ra,0x0
    800036ea:	940080e7          	jalr	-1728(ra) # 80003026 <bread>
    800036ee:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    800036f0:	05850993          	addi	s3,a0,88
    800036f4:	00f4f793          	andi	a5,s1,15
    800036f8:	079a                	slli	a5,a5,0x6
    800036fa:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    800036fc:	00099783          	lh	a5,0(s3)
    80003700:	c3a1                	beqz	a5,80003740 <ialloc+0x9c>
    brelse(bp);
    80003702:	00000097          	auipc	ra,0x0
    80003706:	a54080e7          	jalr	-1452(ra) # 80003156 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    8000370a:	0485                	addi	s1,s1,1
    8000370c:	00ca2703          	lw	a4,12(s4)
    80003710:	0004879b          	sext.w	a5,s1
    80003714:	fce7e1e3          	bltu	a5,a4,800036d6 <ialloc+0x32>
  printf("ialloc: no inodes\n");
    80003718:	00005517          	auipc	a0,0x5
    8000371c:	eb050513          	addi	a0,a0,-336 # 800085c8 <syscalls+0x170>
    80003720:	ffffd097          	auipc	ra,0xffffd
    80003724:	e68080e7          	jalr	-408(ra) # 80000588 <printf>
  return 0;
    80003728:	4501                	li	a0,0
}
    8000372a:	60a6                	ld	ra,72(sp)
    8000372c:	6406                	ld	s0,64(sp)
    8000372e:	74e2                	ld	s1,56(sp)
    80003730:	7942                	ld	s2,48(sp)
    80003732:	79a2                	ld	s3,40(sp)
    80003734:	7a02                	ld	s4,32(sp)
    80003736:	6ae2                	ld	s5,24(sp)
    80003738:	6b42                	ld	s6,16(sp)
    8000373a:	6ba2                	ld	s7,8(sp)
    8000373c:	6161                	addi	sp,sp,80
    8000373e:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    80003740:	04000613          	li	a2,64
    80003744:	4581                	li	a1,0
    80003746:	854e                	mv	a0,s3
    80003748:	ffffd097          	auipc	ra,0xffffd
    8000374c:	58a080e7          	jalr	1418(ra) # 80000cd2 <memset>
      dip->type = type;
    80003750:	01799023          	sh	s7,0(s3)
      log_write(bp);   // mark it allocated on the disk
    80003754:	854a                	mv	a0,s2
    80003756:	00001097          	auipc	ra,0x1
    8000375a:	c84080e7          	jalr	-892(ra) # 800043da <log_write>
      brelse(bp);
    8000375e:	854a                	mv	a0,s2
    80003760:	00000097          	auipc	ra,0x0
    80003764:	9f6080e7          	jalr	-1546(ra) # 80003156 <brelse>
      return iget(dev, inum);
    80003768:	85da                	mv	a1,s6
    8000376a:	8556                	mv	a0,s5
    8000376c:	00000097          	auipc	ra,0x0
    80003770:	d9c080e7          	jalr	-612(ra) # 80003508 <iget>
    80003774:	bf5d                	j	8000372a <ialloc+0x86>

0000000080003776 <iupdate>:
{
    80003776:	1101                	addi	sp,sp,-32
    80003778:	ec06                	sd	ra,24(sp)
    8000377a:	e822                	sd	s0,16(sp)
    8000377c:	e426                	sd	s1,8(sp)
    8000377e:	e04a                	sd	s2,0(sp)
    80003780:	1000                	addi	s0,sp,32
    80003782:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003784:	415c                	lw	a5,4(a0)
    80003786:	0047d79b          	srliw	a5,a5,0x4
    8000378a:	0001c597          	auipc	a1,0x1c
    8000378e:	8d65a583          	lw	a1,-1834(a1) # 8001f060 <sb+0x18>
    80003792:	9dbd                	addw	a1,a1,a5
    80003794:	4108                	lw	a0,0(a0)
    80003796:	00000097          	auipc	ra,0x0
    8000379a:	890080e7          	jalr	-1904(ra) # 80003026 <bread>
    8000379e:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    800037a0:	05850793          	addi	a5,a0,88
    800037a4:	40c8                	lw	a0,4(s1)
    800037a6:	893d                	andi	a0,a0,15
    800037a8:	051a                	slli	a0,a0,0x6
    800037aa:	953e                	add	a0,a0,a5
  dip->type = ip->type;
    800037ac:	04449703          	lh	a4,68(s1)
    800037b0:	00e51023          	sh	a4,0(a0)
  dip->major = ip->major;
    800037b4:	04649703          	lh	a4,70(s1)
    800037b8:	00e51123          	sh	a4,2(a0)
  dip->minor = ip->minor;
    800037bc:	04849703          	lh	a4,72(s1)
    800037c0:	00e51223          	sh	a4,4(a0)
  dip->nlink = ip->nlink;
    800037c4:	04a49703          	lh	a4,74(s1)
    800037c8:	00e51323          	sh	a4,6(a0)
  dip->size = ip->size;
    800037cc:	44f8                	lw	a4,76(s1)
    800037ce:	c518                	sw	a4,8(a0)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    800037d0:	03400613          	li	a2,52
    800037d4:	05048593          	addi	a1,s1,80
    800037d8:	0531                	addi	a0,a0,12
    800037da:	ffffd097          	auipc	ra,0xffffd
    800037de:	554080e7          	jalr	1364(ra) # 80000d2e <memmove>
  log_write(bp);
    800037e2:	854a                	mv	a0,s2
    800037e4:	00001097          	auipc	ra,0x1
    800037e8:	bf6080e7          	jalr	-1034(ra) # 800043da <log_write>
  brelse(bp);
    800037ec:	854a                	mv	a0,s2
    800037ee:	00000097          	auipc	ra,0x0
    800037f2:	968080e7          	jalr	-1688(ra) # 80003156 <brelse>
}
    800037f6:	60e2                	ld	ra,24(sp)
    800037f8:	6442                	ld	s0,16(sp)
    800037fa:	64a2                	ld	s1,8(sp)
    800037fc:	6902                	ld	s2,0(sp)
    800037fe:	6105                	addi	sp,sp,32
    80003800:	8082                	ret

0000000080003802 <idup>:
{
    80003802:	1101                	addi	sp,sp,-32
    80003804:	ec06                	sd	ra,24(sp)
    80003806:	e822                	sd	s0,16(sp)
    80003808:	e426                	sd	s1,8(sp)
    8000380a:	1000                	addi	s0,sp,32
    8000380c:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    8000380e:	0001c517          	auipc	a0,0x1c
    80003812:	85a50513          	addi	a0,a0,-1958 # 8001f068 <itable>
    80003816:	ffffd097          	auipc	ra,0xffffd
    8000381a:	3c0080e7          	jalr	960(ra) # 80000bd6 <acquire>
  ip->ref++;
    8000381e:	449c                	lw	a5,8(s1)
    80003820:	2785                	addiw	a5,a5,1
    80003822:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80003824:	0001c517          	auipc	a0,0x1c
    80003828:	84450513          	addi	a0,a0,-1980 # 8001f068 <itable>
    8000382c:	ffffd097          	auipc	ra,0xffffd
    80003830:	45e080e7          	jalr	1118(ra) # 80000c8a <release>
}
    80003834:	8526                	mv	a0,s1
    80003836:	60e2                	ld	ra,24(sp)
    80003838:	6442                	ld	s0,16(sp)
    8000383a:	64a2                	ld	s1,8(sp)
    8000383c:	6105                	addi	sp,sp,32
    8000383e:	8082                	ret

0000000080003840 <ilock>:
{
    80003840:	1101                	addi	sp,sp,-32
    80003842:	ec06                	sd	ra,24(sp)
    80003844:	e822                	sd	s0,16(sp)
    80003846:	e426                	sd	s1,8(sp)
    80003848:	e04a                	sd	s2,0(sp)
    8000384a:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    8000384c:	c115                	beqz	a0,80003870 <ilock+0x30>
    8000384e:	84aa                	mv	s1,a0
    80003850:	451c                	lw	a5,8(a0)
    80003852:	00f05f63          	blez	a5,80003870 <ilock+0x30>
  acquiresleep(&ip->lock);
    80003856:	0541                	addi	a0,a0,16
    80003858:	00001097          	auipc	ra,0x1
    8000385c:	ca2080e7          	jalr	-862(ra) # 800044fa <acquiresleep>
  if(ip->valid == 0){
    80003860:	40bc                	lw	a5,64(s1)
    80003862:	cf99                	beqz	a5,80003880 <ilock+0x40>
}
    80003864:	60e2                	ld	ra,24(sp)
    80003866:	6442                	ld	s0,16(sp)
    80003868:	64a2                	ld	s1,8(sp)
    8000386a:	6902                	ld	s2,0(sp)
    8000386c:	6105                	addi	sp,sp,32
    8000386e:	8082                	ret
    panic("ilock");
    80003870:	00005517          	auipc	a0,0x5
    80003874:	d7050513          	addi	a0,a0,-656 # 800085e0 <syscalls+0x188>
    80003878:	ffffd097          	auipc	ra,0xffffd
    8000387c:	cc6080e7          	jalr	-826(ra) # 8000053e <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003880:	40dc                	lw	a5,4(s1)
    80003882:	0047d79b          	srliw	a5,a5,0x4
    80003886:	0001b597          	auipc	a1,0x1b
    8000388a:	7da5a583          	lw	a1,2010(a1) # 8001f060 <sb+0x18>
    8000388e:	9dbd                	addw	a1,a1,a5
    80003890:	4088                	lw	a0,0(s1)
    80003892:	fffff097          	auipc	ra,0xfffff
    80003896:	794080e7          	jalr	1940(ra) # 80003026 <bread>
    8000389a:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    8000389c:	05850593          	addi	a1,a0,88
    800038a0:	40dc                	lw	a5,4(s1)
    800038a2:	8bbd                	andi	a5,a5,15
    800038a4:	079a                	slli	a5,a5,0x6
    800038a6:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    800038a8:	00059783          	lh	a5,0(a1)
    800038ac:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    800038b0:	00259783          	lh	a5,2(a1)
    800038b4:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    800038b8:	00459783          	lh	a5,4(a1)
    800038bc:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    800038c0:	00659783          	lh	a5,6(a1)
    800038c4:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    800038c8:	459c                	lw	a5,8(a1)
    800038ca:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    800038cc:	03400613          	li	a2,52
    800038d0:	05b1                	addi	a1,a1,12
    800038d2:	05048513          	addi	a0,s1,80
    800038d6:	ffffd097          	auipc	ra,0xffffd
    800038da:	458080e7          	jalr	1112(ra) # 80000d2e <memmove>
    brelse(bp);
    800038de:	854a                	mv	a0,s2
    800038e0:	00000097          	auipc	ra,0x0
    800038e4:	876080e7          	jalr	-1930(ra) # 80003156 <brelse>
    ip->valid = 1;
    800038e8:	4785                	li	a5,1
    800038ea:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    800038ec:	04449783          	lh	a5,68(s1)
    800038f0:	fbb5                	bnez	a5,80003864 <ilock+0x24>
      panic("ilock: no type");
    800038f2:	00005517          	auipc	a0,0x5
    800038f6:	cf650513          	addi	a0,a0,-778 # 800085e8 <syscalls+0x190>
    800038fa:	ffffd097          	auipc	ra,0xffffd
    800038fe:	c44080e7          	jalr	-956(ra) # 8000053e <panic>

0000000080003902 <iunlock>:
{
    80003902:	1101                	addi	sp,sp,-32
    80003904:	ec06                	sd	ra,24(sp)
    80003906:	e822                	sd	s0,16(sp)
    80003908:	e426                	sd	s1,8(sp)
    8000390a:	e04a                	sd	s2,0(sp)
    8000390c:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    8000390e:	c905                	beqz	a0,8000393e <iunlock+0x3c>
    80003910:	84aa                	mv	s1,a0
    80003912:	01050913          	addi	s2,a0,16
    80003916:	854a                	mv	a0,s2
    80003918:	00001097          	auipc	ra,0x1
    8000391c:	c7c080e7          	jalr	-900(ra) # 80004594 <holdingsleep>
    80003920:	cd19                	beqz	a0,8000393e <iunlock+0x3c>
    80003922:	449c                	lw	a5,8(s1)
    80003924:	00f05d63          	blez	a5,8000393e <iunlock+0x3c>
  releasesleep(&ip->lock);
    80003928:	854a                	mv	a0,s2
    8000392a:	00001097          	auipc	ra,0x1
    8000392e:	c26080e7          	jalr	-986(ra) # 80004550 <releasesleep>
}
    80003932:	60e2                	ld	ra,24(sp)
    80003934:	6442                	ld	s0,16(sp)
    80003936:	64a2                	ld	s1,8(sp)
    80003938:	6902                	ld	s2,0(sp)
    8000393a:	6105                	addi	sp,sp,32
    8000393c:	8082                	ret
    panic("iunlock");
    8000393e:	00005517          	auipc	a0,0x5
    80003942:	cba50513          	addi	a0,a0,-838 # 800085f8 <syscalls+0x1a0>
    80003946:	ffffd097          	auipc	ra,0xffffd
    8000394a:	bf8080e7          	jalr	-1032(ra) # 8000053e <panic>

000000008000394e <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    8000394e:	7179                	addi	sp,sp,-48
    80003950:	f406                	sd	ra,40(sp)
    80003952:	f022                	sd	s0,32(sp)
    80003954:	ec26                	sd	s1,24(sp)
    80003956:	e84a                	sd	s2,16(sp)
    80003958:	e44e                	sd	s3,8(sp)
    8000395a:	e052                	sd	s4,0(sp)
    8000395c:	1800                	addi	s0,sp,48
    8000395e:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80003960:	05050493          	addi	s1,a0,80
    80003964:	08050913          	addi	s2,a0,128
    80003968:	a021                	j	80003970 <itrunc+0x22>
    8000396a:	0491                	addi	s1,s1,4
    8000396c:	01248d63          	beq	s1,s2,80003986 <itrunc+0x38>
    if(ip->addrs[i]){
    80003970:	408c                	lw	a1,0(s1)
    80003972:	dde5                	beqz	a1,8000396a <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    80003974:	0009a503          	lw	a0,0(s3)
    80003978:	00000097          	auipc	ra,0x0
    8000397c:	8f4080e7          	jalr	-1804(ra) # 8000326c <bfree>
      ip->addrs[i] = 0;
    80003980:	0004a023          	sw	zero,0(s1)
    80003984:	b7dd                	j	8000396a <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    80003986:	0809a583          	lw	a1,128(s3)
    8000398a:	e185                	bnez	a1,800039aa <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    8000398c:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80003990:	854e                	mv	a0,s3
    80003992:	00000097          	auipc	ra,0x0
    80003996:	de4080e7          	jalr	-540(ra) # 80003776 <iupdate>
}
    8000399a:	70a2                	ld	ra,40(sp)
    8000399c:	7402                	ld	s0,32(sp)
    8000399e:	64e2                	ld	s1,24(sp)
    800039a0:	6942                	ld	s2,16(sp)
    800039a2:	69a2                	ld	s3,8(sp)
    800039a4:	6a02                	ld	s4,0(sp)
    800039a6:	6145                	addi	sp,sp,48
    800039a8:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    800039aa:	0009a503          	lw	a0,0(s3)
    800039ae:	fffff097          	auipc	ra,0xfffff
    800039b2:	678080e7          	jalr	1656(ra) # 80003026 <bread>
    800039b6:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    800039b8:	05850493          	addi	s1,a0,88
    800039bc:	45850913          	addi	s2,a0,1112
    800039c0:	a021                	j	800039c8 <itrunc+0x7a>
    800039c2:	0491                	addi	s1,s1,4
    800039c4:	01248b63          	beq	s1,s2,800039da <itrunc+0x8c>
      if(a[j])
    800039c8:	408c                	lw	a1,0(s1)
    800039ca:	dde5                	beqz	a1,800039c2 <itrunc+0x74>
        bfree(ip->dev, a[j]);
    800039cc:	0009a503          	lw	a0,0(s3)
    800039d0:	00000097          	auipc	ra,0x0
    800039d4:	89c080e7          	jalr	-1892(ra) # 8000326c <bfree>
    800039d8:	b7ed                	j	800039c2 <itrunc+0x74>
    brelse(bp);
    800039da:	8552                	mv	a0,s4
    800039dc:	fffff097          	auipc	ra,0xfffff
    800039e0:	77a080e7          	jalr	1914(ra) # 80003156 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    800039e4:	0809a583          	lw	a1,128(s3)
    800039e8:	0009a503          	lw	a0,0(s3)
    800039ec:	00000097          	auipc	ra,0x0
    800039f0:	880080e7          	jalr	-1920(ra) # 8000326c <bfree>
    ip->addrs[NDIRECT] = 0;
    800039f4:	0809a023          	sw	zero,128(s3)
    800039f8:	bf51                	j	8000398c <itrunc+0x3e>

00000000800039fa <iput>:
{
    800039fa:	1101                	addi	sp,sp,-32
    800039fc:	ec06                	sd	ra,24(sp)
    800039fe:	e822                	sd	s0,16(sp)
    80003a00:	e426                	sd	s1,8(sp)
    80003a02:	e04a                	sd	s2,0(sp)
    80003a04:	1000                	addi	s0,sp,32
    80003a06:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80003a08:	0001b517          	auipc	a0,0x1b
    80003a0c:	66050513          	addi	a0,a0,1632 # 8001f068 <itable>
    80003a10:	ffffd097          	auipc	ra,0xffffd
    80003a14:	1c6080e7          	jalr	454(ra) # 80000bd6 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80003a18:	4498                	lw	a4,8(s1)
    80003a1a:	4785                	li	a5,1
    80003a1c:	02f70363          	beq	a4,a5,80003a42 <iput+0x48>
  ip->ref--;
    80003a20:	449c                	lw	a5,8(s1)
    80003a22:	37fd                	addiw	a5,a5,-1
    80003a24:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80003a26:	0001b517          	auipc	a0,0x1b
    80003a2a:	64250513          	addi	a0,a0,1602 # 8001f068 <itable>
    80003a2e:	ffffd097          	auipc	ra,0xffffd
    80003a32:	25c080e7          	jalr	604(ra) # 80000c8a <release>
}
    80003a36:	60e2                	ld	ra,24(sp)
    80003a38:	6442                	ld	s0,16(sp)
    80003a3a:	64a2                	ld	s1,8(sp)
    80003a3c:	6902                	ld	s2,0(sp)
    80003a3e:	6105                	addi	sp,sp,32
    80003a40:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80003a42:	40bc                	lw	a5,64(s1)
    80003a44:	dff1                	beqz	a5,80003a20 <iput+0x26>
    80003a46:	04a49783          	lh	a5,74(s1)
    80003a4a:	fbf9                	bnez	a5,80003a20 <iput+0x26>
    acquiresleep(&ip->lock);
    80003a4c:	01048913          	addi	s2,s1,16
    80003a50:	854a                	mv	a0,s2
    80003a52:	00001097          	auipc	ra,0x1
    80003a56:	aa8080e7          	jalr	-1368(ra) # 800044fa <acquiresleep>
    release(&itable.lock);
    80003a5a:	0001b517          	auipc	a0,0x1b
    80003a5e:	60e50513          	addi	a0,a0,1550 # 8001f068 <itable>
    80003a62:	ffffd097          	auipc	ra,0xffffd
    80003a66:	228080e7          	jalr	552(ra) # 80000c8a <release>
    itrunc(ip);
    80003a6a:	8526                	mv	a0,s1
    80003a6c:	00000097          	auipc	ra,0x0
    80003a70:	ee2080e7          	jalr	-286(ra) # 8000394e <itrunc>
    ip->type = 0;
    80003a74:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80003a78:	8526                	mv	a0,s1
    80003a7a:	00000097          	auipc	ra,0x0
    80003a7e:	cfc080e7          	jalr	-772(ra) # 80003776 <iupdate>
    ip->valid = 0;
    80003a82:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80003a86:	854a                	mv	a0,s2
    80003a88:	00001097          	auipc	ra,0x1
    80003a8c:	ac8080e7          	jalr	-1336(ra) # 80004550 <releasesleep>
    acquire(&itable.lock);
    80003a90:	0001b517          	auipc	a0,0x1b
    80003a94:	5d850513          	addi	a0,a0,1496 # 8001f068 <itable>
    80003a98:	ffffd097          	auipc	ra,0xffffd
    80003a9c:	13e080e7          	jalr	318(ra) # 80000bd6 <acquire>
    80003aa0:	b741                	j	80003a20 <iput+0x26>

0000000080003aa2 <iunlockput>:
{
    80003aa2:	1101                	addi	sp,sp,-32
    80003aa4:	ec06                	sd	ra,24(sp)
    80003aa6:	e822                	sd	s0,16(sp)
    80003aa8:	e426                	sd	s1,8(sp)
    80003aaa:	1000                	addi	s0,sp,32
    80003aac:	84aa                	mv	s1,a0
  iunlock(ip);
    80003aae:	00000097          	auipc	ra,0x0
    80003ab2:	e54080e7          	jalr	-428(ra) # 80003902 <iunlock>
  iput(ip);
    80003ab6:	8526                	mv	a0,s1
    80003ab8:	00000097          	auipc	ra,0x0
    80003abc:	f42080e7          	jalr	-190(ra) # 800039fa <iput>
}
    80003ac0:	60e2                	ld	ra,24(sp)
    80003ac2:	6442                	ld	s0,16(sp)
    80003ac4:	64a2                	ld	s1,8(sp)
    80003ac6:	6105                	addi	sp,sp,32
    80003ac8:	8082                	ret

0000000080003aca <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80003aca:	1141                	addi	sp,sp,-16
    80003acc:	e422                	sd	s0,8(sp)
    80003ace:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80003ad0:	411c                	lw	a5,0(a0)
    80003ad2:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80003ad4:	415c                	lw	a5,4(a0)
    80003ad6:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80003ad8:	04451783          	lh	a5,68(a0)
    80003adc:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80003ae0:	04a51783          	lh	a5,74(a0)
    80003ae4:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80003ae8:	04c56783          	lwu	a5,76(a0)
    80003aec:	e99c                	sd	a5,16(a1)
}
    80003aee:	6422                	ld	s0,8(sp)
    80003af0:	0141                	addi	sp,sp,16
    80003af2:	8082                	ret

0000000080003af4 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003af4:	457c                	lw	a5,76(a0)
    80003af6:	0ed7e963          	bltu	a5,a3,80003be8 <readi+0xf4>
{
    80003afa:	7159                	addi	sp,sp,-112
    80003afc:	f486                	sd	ra,104(sp)
    80003afe:	f0a2                	sd	s0,96(sp)
    80003b00:	eca6                	sd	s1,88(sp)
    80003b02:	e8ca                	sd	s2,80(sp)
    80003b04:	e4ce                	sd	s3,72(sp)
    80003b06:	e0d2                	sd	s4,64(sp)
    80003b08:	fc56                	sd	s5,56(sp)
    80003b0a:	f85a                	sd	s6,48(sp)
    80003b0c:	f45e                	sd	s7,40(sp)
    80003b0e:	f062                	sd	s8,32(sp)
    80003b10:	ec66                	sd	s9,24(sp)
    80003b12:	e86a                	sd	s10,16(sp)
    80003b14:	e46e                	sd	s11,8(sp)
    80003b16:	1880                	addi	s0,sp,112
    80003b18:	8b2a                	mv	s6,a0
    80003b1a:	8bae                	mv	s7,a1
    80003b1c:	8a32                	mv	s4,a2
    80003b1e:	84b6                	mv	s1,a3
    80003b20:	8aba                	mv	s5,a4
  if(off > ip->size || off + n < off)
    80003b22:	9f35                	addw	a4,a4,a3
    return 0;
    80003b24:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80003b26:	0ad76063          	bltu	a4,a3,80003bc6 <readi+0xd2>
  if(off + n > ip->size)
    80003b2a:	00e7f463          	bgeu	a5,a4,80003b32 <readi+0x3e>
    n = ip->size - off;
    80003b2e:	40d78abb          	subw	s5,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003b32:	0a0a8963          	beqz	s5,80003be4 <readi+0xf0>
    80003b36:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80003b38:	40000c93          	li	s9,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80003b3c:	5c7d                	li	s8,-1
    80003b3e:	a82d                	j	80003b78 <readi+0x84>
    80003b40:	020d1d93          	slli	s11,s10,0x20
    80003b44:	020ddd93          	srli	s11,s11,0x20
    80003b48:	05890793          	addi	a5,s2,88
    80003b4c:	86ee                	mv	a3,s11
    80003b4e:	963e                	add	a2,a2,a5
    80003b50:	85d2                	mv	a1,s4
    80003b52:	855e                	mv	a0,s7
    80003b54:	fffff097          	auipc	ra,0xfffff
    80003b58:	af2080e7          	jalr	-1294(ra) # 80002646 <either_copyout>
    80003b5c:	05850d63          	beq	a0,s8,80003bb6 <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80003b60:	854a                	mv	a0,s2
    80003b62:	fffff097          	auipc	ra,0xfffff
    80003b66:	5f4080e7          	jalr	1524(ra) # 80003156 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003b6a:	013d09bb          	addw	s3,s10,s3
    80003b6e:	009d04bb          	addw	s1,s10,s1
    80003b72:	9a6e                	add	s4,s4,s11
    80003b74:	0559f763          	bgeu	s3,s5,80003bc2 <readi+0xce>
    uint addr = bmap(ip, off/BSIZE);
    80003b78:	00a4d59b          	srliw	a1,s1,0xa
    80003b7c:	855a                	mv	a0,s6
    80003b7e:	00000097          	auipc	ra,0x0
    80003b82:	8a2080e7          	jalr	-1886(ra) # 80003420 <bmap>
    80003b86:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    80003b8a:	cd85                	beqz	a1,80003bc2 <readi+0xce>
    bp = bread(ip->dev, addr);
    80003b8c:	000b2503          	lw	a0,0(s6)
    80003b90:	fffff097          	auipc	ra,0xfffff
    80003b94:	496080e7          	jalr	1174(ra) # 80003026 <bread>
    80003b98:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003b9a:	3ff4f613          	andi	a2,s1,1023
    80003b9e:	40cc87bb          	subw	a5,s9,a2
    80003ba2:	413a873b          	subw	a4,s5,s3
    80003ba6:	8d3e                	mv	s10,a5
    80003ba8:	2781                	sext.w	a5,a5
    80003baa:	0007069b          	sext.w	a3,a4
    80003bae:	f8f6f9e3          	bgeu	a3,a5,80003b40 <readi+0x4c>
    80003bb2:	8d3a                	mv	s10,a4
    80003bb4:	b771                	j	80003b40 <readi+0x4c>
      brelse(bp);
    80003bb6:	854a                	mv	a0,s2
    80003bb8:	fffff097          	auipc	ra,0xfffff
    80003bbc:	59e080e7          	jalr	1438(ra) # 80003156 <brelse>
      tot = -1;
    80003bc0:	59fd                	li	s3,-1
  }
  return tot;
    80003bc2:	0009851b          	sext.w	a0,s3
}
    80003bc6:	70a6                	ld	ra,104(sp)
    80003bc8:	7406                	ld	s0,96(sp)
    80003bca:	64e6                	ld	s1,88(sp)
    80003bcc:	6946                	ld	s2,80(sp)
    80003bce:	69a6                	ld	s3,72(sp)
    80003bd0:	6a06                	ld	s4,64(sp)
    80003bd2:	7ae2                	ld	s5,56(sp)
    80003bd4:	7b42                	ld	s6,48(sp)
    80003bd6:	7ba2                	ld	s7,40(sp)
    80003bd8:	7c02                	ld	s8,32(sp)
    80003bda:	6ce2                	ld	s9,24(sp)
    80003bdc:	6d42                	ld	s10,16(sp)
    80003bde:	6da2                	ld	s11,8(sp)
    80003be0:	6165                	addi	sp,sp,112
    80003be2:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003be4:	89d6                	mv	s3,s5
    80003be6:	bff1                	j	80003bc2 <readi+0xce>
    return 0;
    80003be8:	4501                	li	a0,0
}
    80003bea:	8082                	ret

0000000080003bec <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003bec:	457c                	lw	a5,76(a0)
    80003bee:	10d7e863          	bltu	a5,a3,80003cfe <writei+0x112>
{
    80003bf2:	7159                	addi	sp,sp,-112
    80003bf4:	f486                	sd	ra,104(sp)
    80003bf6:	f0a2                	sd	s0,96(sp)
    80003bf8:	eca6                	sd	s1,88(sp)
    80003bfa:	e8ca                	sd	s2,80(sp)
    80003bfc:	e4ce                	sd	s3,72(sp)
    80003bfe:	e0d2                	sd	s4,64(sp)
    80003c00:	fc56                	sd	s5,56(sp)
    80003c02:	f85a                	sd	s6,48(sp)
    80003c04:	f45e                	sd	s7,40(sp)
    80003c06:	f062                	sd	s8,32(sp)
    80003c08:	ec66                	sd	s9,24(sp)
    80003c0a:	e86a                	sd	s10,16(sp)
    80003c0c:	e46e                	sd	s11,8(sp)
    80003c0e:	1880                	addi	s0,sp,112
    80003c10:	8aaa                	mv	s5,a0
    80003c12:	8bae                	mv	s7,a1
    80003c14:	8a32                	mv	s4,a2
    80003c16:	8936                	mv	s2,a3
    80003c18:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80003c1a:	00e687bb          	addw	a5,a3,a4
    80003c1e:	0ed7e263          	bltu	a5,a3,80003d02 <writei+0x116>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80003c22:	00043737          	lui	a4,0x43
    80003c26:	0ef76063          	bltu	a4,a5,80003d06 <writei+0x11a>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003c2a:	0c0b0863          	beqz	s6,80003cfa <writei+0x10e>
    80003c2e:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80003c30:	40000c93          	li	s9,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80003c34:	5c7d                	li	s8,-1
    80003c36:	a091                	j	80003c7a <writei+0x8e>
    80003c38:	020d1d93          	slli	s11,s10,0x20
    80003c3c:	020ddd93          	srli	s11,s11,0x20
    80003c40:	05848793          	addi	a5,s1,88
    80003c44:	86ee                	mv	a3,s11
    80003c46:	8652                	mv	a2,s4
    80003c48:	85de                	mv	a1,s7
    80003c4a:	953e                	add	a0,a0,a5
    80003c4c:	fffff097          	auipc	ra,0xfffff
    80003c50:	a50080e7          	jalr	-1456(ra) # 8000269c <either_copyin>
    80003c54:	07850263          	beq	a0,s8,80003cb8 <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    80003c58:	8526                	mv	a0,s1
    80003c5a:	00000097          	auipc	ra,0x0
    80003c5e:	780080e7          	jalr	1920(ra) # 800043da <log_write>
    brelse(bp);
    80003c62:	8526                	mv	a0,s1
    80003c64:	fffff097          	auipc	ra,0xfffff
    80003c68:	4f2080e7          	jalr	1266(ra) # 80003156 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003c6c:	013d09bb          	addw	s3,s10,s3
    80003c70:	012d093b          	addw	s2,s10,s2
    80003c74:	9a6e                	add	s4,s4,s11
    80003c76:	0569f663          	bgeu	s3,s6,80003cc2 <writei+0xd6>
    uint addr = bmap(ip, off/BSIZE);
    80003c7a:	00a9559b          	srliw	a1,s2,0xa
    80003c7e:	8556                	mv	a0,s5
    80003c80:	fffff097          	auipc	ra,0xfffff
    80003c84:	7a0080e7          	jalr	1952(ra) # 80003420 <bmap>
    80003c88:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    80003c8c:	c99d                	beqz	a1,80003cc2 <writei+0xd6>
    bp = bread(ip->dev, addr);
    80003c8e:	000aa503          	lw	a0,0(s5)
    80003c92:	fffff097          	auipc	ra,0xfffff
    80003c96:	394080e7          	jalr	916(ra) # 80003026 <bread>
    80003c9a:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003c9c:	3ff97513          	andi	a0,s2,1023
    80003ca0:	40ac87bb          	subw	a5,s9,a0
    80003ca4:	413b073b          	subw	a4,s6,s3
    80003ca8:	8d3e                	mv	s10,a5
    80003caa:	2781                	sext.w	a5,a5
    80003cac:	0007069b          	sext.w	a3,a4
    80003cb0:	f8f6f4e3          	bgeu	a3,a5,80003c38 <writei+0x4c>
    80003cb4:	8d3a                	mv	s10,a4
    80003cb6:	b749                	j	80003c38 <writei+0x4c>
      brelse(bp);
    80003cb8:	8526                	mv	a0,s1
    80003cba:	fffff097          	auipc	ra,0xfffff
    80003cbe:	49c080e7          	jalr	1180(ra) # 80003156 <brelse>
  }

  if(off > ip->size)
    80003cc2:	04caa783          	lw	a5,76(s5)
    80003cc6:	0127f463          	bgeu	a5,s2,80003cce <writei+0xe2>
    ip->size = off;
    80003cca:	052aa623          	sw	s2,76(s5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80003cce:	8556                	mv	a0,s5
    80003cd0:	00000097          	auipc	ra,0x0
    80003cd4:	aa6080e7          	jalr	-1370(ra) # 80003776 <iupdate>

  return tot;
    80003cd8:	0009851b          	sext.w	a0,s3
}
    80003cdc:	70a6                	ld	ra,104(sp)
    80003cde:	7406                	ld	s0,96(sp)
    80003ce0:	64e6                	ld	s1,88(sp)
    80003ce2:	6946                	ld	s2,80(sp)
    80003ce4:	69a6                	ld	s3,72(sp)
    80003ce6:	6a06                	ld	s4,64(sp)
    80003ce8:	7ae2                	ld	s5,56(sp)
    80003cea:	7b42                	ld	s6,48(sp)
    80003cec:	7ba2                	ld	s7,40(sp)
    80003cee:	7c02                	ld	s8,32(sp)
    80003cf0:	6ce2                	ld	s9,24(sp)
    80003cf2:	6d42                	ld	s10,16(sp)
    80003cf4:	6da2                	ld	s11,8(sp)
    80003cf6:	6165                	addi	sp,sp,112
    80003cf8:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003cfa:	89da                	mv	s3,s6
    80003cfc:	bfc9                	j	80003cce <writei+0xe2>
    return -1;
    80003cfe:	557d                	li	a0,-1
}
    80003d00:	8082                	ret
    return -1;
    80003d02:	557d                	li	a0,-1
    80003d04:	bfe1                	j	80003cdc <writei+0xf0>
    return -1;
    80003d06:	557d                	li	a0,-1
    80003d08:	bfd1                	j	80003cdc <writei+0xf0>

0000000080003d0a <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80003d0a:	1141                	addi	sp,sp,-16
    80003d0c:	e406                	sd	ra,8(sp)
    80003d0e:	e022                	sd	s0,0(sp)
    80003d10:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80003d12:	4639                	li	a2,14
    80003d14:	ffffd097          	auipc	ra,0xffffd
    80003d18:	08e080e7          	jalr	142(ra) # 80000da2 <strncmp>
}
    80003d1c:	60a2                	ld	ra,8(sp)
    80003d1e:	6402                	ld	s0,0(sp)
    80003d20:	0141                	addi	sp,sp,16
    80003d22:	8082                	ret

0000000080003d24 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80003d24:	7139                	addi	sp,sp,-64
    80003d26:	fc06                	sd	ra,56(sp)
    80003d28:	f822                	sd	s0,48(sp)
    80003d2a:	f426                	sd	s1,40(sp)
    80003d2c:	f04a                	sd	s2,32(sp)
    80003d2e:	ec4e                	sd	s3,24(sp)
    80003d30:	e852                	sd	s4,16(sp)
    80003d32:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80003d34:	04451703          	lh	a4,68(a0)
    80003d38:	4785                	li	a5,1
    80003d3a:	00f71a63          	bne	a4,a5,80003d4e <dirlookup+0x2a>
    80003d3e:	892a                	mv	s2,a0
    80003d40:	89ae                	mv	s3,a1
    80003d42:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80003d44:	457c                	lw	a5,76(a0)
    80003d46:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80003d48:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003d4a:	e79d                	bnez	a5,80003d78 <dirlookup+0x54>
    80003d4c:	a8a5                	j	80003dc4 <dirlookup+0xa0>
    panic("dirlookup not DIR");
    80003d4e:	00005517          	auipc	a0,0x5
    80003d52:	8b250513          	addi	a0,a0,-1870 # 80008600 <syscalls+0x1a8>
    80003d56:	ffffc097          	auipc	ra,0xffffc
    80003d5a:	7e8080e7          	jalr	2024(ra) # 8000053e <panic>
      panic("dirlookup read");
    80003d5e:	00005517          	auipc	a0,0x5
    80003d62:	8ba50513          	addi	a0,a0,-1862 # 80008618 <syscalls+0x1c0>
    80003d66:	ffffc097          	auipc	ra,0xffffc
    80003d6a:	7d8080e7          	jalr	2008(ra) # 8000053e <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003d6e:	24c1                	addiw	s1,s1,16
    80003d70:	04c92783          	lw	a5,76(s2)
    80003d74:	04f4f763          	bgeu	s1,a5,80003dc2 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003d78:	4741                	li	a4,16
    80003d7a:	86a6                	mv	a3,s1
    80003d7c:	fc040613          	addi	a2,s0,-64
    80003d80:	4581                	li	a1,0
    80003d82:	854a                	mv	a0,s2
    80003d84:	00000097          	auipc	ra,0x0
    80003d88:	d70080e7          	jalr	-656(ra) # 80003af4 <readi>
    80003d8c:	47c1                	li	a5,16
    80003d8e:	fcf518e3          	bne	a0,a5,80003d5e <dirlookup+0x3a>
    if(de.inum == 0)
    80003d92:	fc045783          	lhu	a5,-64(s0)
    80003d96:	dfe1                	beqz	a5,80003d6e <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    80003d98:	fc240593          	addi	a1,s0,-62
    80003d9c:	854e                	mv	a0,s3
    80003d9e:	00000097          	auipc	ra,0x0
    80003da2:	f6c080e7          	jalr	-148(ra) # 80003d0a <namecmp>
    80003da6:	f561                	bnez	a0,80003d6e <dirlookup+0x4a>
      if(poff)
    80003da8:	000a0463          	beqz	s4,80003db0 <dirlookup+0x8c>
        *poff = off;
    80003dac:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    80003db0:	fc045583          	lhu	a1,-64(s0)
    80003db4:	00092503          	lw	a0,0(s2)
    80003db8:	fffff097          	auipc	ra,0xfffff
    80003dbc:	750080e7          	jalr	1872(ra) # 80003508 <iget>
    80003dc0:	a011                	j	80003dc4 <dirlookup+0xa0>
  return 0;
    80003dc2:	4501                	li	a0,0
}
    80003dc4:	70e2                	ld	ra,56(sp)
    80003dc6:	7442                	ld	s0,48(sp)
    80003dc8:	74a2                	ld	s1,40(sp)
    80003dca:	7902                	ld	s2,32(sp)
    80003dcc:	69e2                	ld	s3,24(sp)
    80003dce:	6a42                	ld	s4,16(sp)
    80003dd0:	6121                	addi	sp,sp,64
    80003dd2:	8082                	ret

0000000080003dd4 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80003dd4:	711d                	addi	sp,sp,-96
    80003dd6:	ec86                	sd	ra,88(sp)
    80003dd8:	e8a2                	sd	s0,80(sp)
    80003dda:	e4a6                	sd	s1,72(sp)
    80003ddc:	e0ca                	sd	s2,64(sp)
    80003dde:	fc4e                	sd	s3,56(sp)
    80003de0:	f852                	sd	s4,48(sp)
    80003de2:	f456                	sd	s5,40(sp)
    80003de4:	f05a                	sd	s6,32(sp)
    80003de6:	ec5e                	sd	s7,24(sp)
    80003de8:	e862                	sd	s8,16(sp)
    80003dea:	e466                	sd	s9,8(sp)
    80003dec:	1080                	addi	s0,sp,96
    80003dee:	84aa                	mv	s1,a0
    80003df0:	8aae                	mv	s5,a1
    80003df2:	8a32                	mv	s4,a2
  struct inode *ip, *next;

  if(*path == '/')
    80003df4:	00054703          	lbu	a4,0(a0)
    80003df8:	02f00793          	li	a5,47
    80003dfc:	02f70363          	beq	a4,a5,80003e22 <namex+0x4e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80003e00:	ffffe097          	auipc	ra,0xffffe
    80003e04:	bac080e7          	jalr	-1108(ra) # 800019ac <myproc>
    80003e08:	15053503          	ld	a0,336(a0)
    80003e0c:	00000097          	auipc	ra,0x0
    80003e10:	9f6080e7          	jalr	-1546(ra) # 80003802 <idup>
    80003e14:	89aa                	mv	s3,a0
  while(*path == '/')
    80003e16:	02f00913          	li	s2,47
  len = path - s;
    80003e1a:	4b01                	li	s6,0
  if(len >= DIRSIZ)
    80003e1c:	4c35                	li	s8,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80003e1e:	4b85                	li	s7,1
    80003e20:	a865                	j	80003ed8 <namex+0x104>
    ip = iget(ROOTDEV, ROOTINO);
    80003e22:	4585                	li	a1,1
    80003e24:	4505                	li	a0,1
    80003e26:	fffff097          	auipc	ra,0xfffff
    80003e2a:	6e2080e7          	jalr	1762(ra) # 80003508 <iget>
    80003e2e:	89aa                	mv	s3,a0
    80003e30:	b7dd                	j	80003e16 <namex+0x42>
      iunlockput(ip);
    80003e32:	854e                	mv	a0,s3
    80003e34:	00000097          	auipc	ra,0x0
    80003e38:	c6e080e7          	jalr	-914(ra) # 80003aa2 <iunlockput>
      return 0;
    80003e3c:	4981                	li	s3,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80003e3e:	854e                	mv	a0,s3
    80003e40:	60e6                	ld	ra,88(sp)
    80003e42:	6446                	ld	s0,80(sp)
    80003e44:	64a6                	ld	s1,72(sp)
    80003e46:	6906                	ld	s2,64(sp)
    80003e48:	79e2                	ld	s3,56(sp)
    80003e4a:	7a42                	ld	s4,48(sp)
    80003e4c:	7aa2                	ld	s5,40(sp)
    80003e4e:	7b02                	ld	s6,32(sp)
    80003e50:	6be2                	ld	s7,24(sp)
    80003e52:	6c42                	ld	s8,16(sp)
    80003e54:	6ca2                	ld	s9,8(sp)
    80003e56:	6125                	addi	sp,sp,96
    80003e58:	8082                	ret
      iunlock(ip);
    80003e5a:	854e                	mv	a0,s3
    80003e5c:	00000097          	auipc	ra,0x0
    80003e60:	aa6080e7          	jalr	-1370(ra) # 80003902 <iunlock>
      return ip;
    80003e64:	bfe9                	j	80003e3e <namex+0x6a>
      iunlockput(ip);
    80003e66:	854e                	mv	a0,s3
    80003e68:	00000097          	auipc	ra,0x0
    80003e6c:	c3a080e7          	jalr	-966(ra) # 80003aa2 <iunlockput>
      return 0;
    80003e70:	89e6                	mv	s3,s9
    80003e72:	b7f1                	j	80003e3e <namex+0x6a>
  len = path - s;
    80003e74:	40b48633          	sub	a2,s1,a1
    80003e78:	00060c9b          	sext.w	s9,a2
  if(len >= DIRSIZ)
    80003e7c:	099c5463          	bge	s8,s9,80003f04 <namex+0x130>
    memmove(name, s, DIRSIZ);
    80003e80:	4639                	li	a2,14
    80003e82:	8552                	mv	a0,s4
    80003e84:	ffffd097          	auipc	ra,0xffffd
    80003e88:	eaa080e7          	jalr	-342(ra) # 80000d2e <memmove>
  while(*path == '/')
    80003e8c:	0004c783          	lbu	a5,0(s1)
    80003e90:	01279763          	bne	a5,s2,80003e9e <namex+0xca>
    path++;
    80003e94:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003e96:	0004c783          	lbu	a5,0(s1)
    80003e9a:	ff278de3          	beq	a5,s2,80003e94 <namex+0xc0>
    ilock(ip);
    80003e9e:	854e                	mv	a0,s3
    80003ea0:	00000097          	auipc	ra,0x0
    80003ea4:	9a0080e7          	jalr	-1632(ra) # 80003840 <ilock>
    if(ip->type != T_DIR){
    80003ea8:	04499783          	lh	a5,68(s3)
    80003eac:	f97793e3          	bne	a5,s7,80003e32 <namex+0x5e>
    if(nameiparent && *path == '\0'){
    80003eb0:	000a8563          	beqz	s5,80003eba <namex+0xe6>
    80003eb4:	0004c783          	lbu	a5,0(s1)
    80003eb8:	d3cd                	beqz	a5,80003e5a <namex+0x86>
    if((next = dirlookup(ip, name, 0)) == 0){
    80003eba:	865a                	mv	a2,s6
    80003ebc:	85d2                	mv	a1,s4
    80003ebe:	854e                	mv	a0,s3
    80003ec0:	00000097          	auipc	ra,0x0
    80003ec4:	e64080e7          	jalr	-412(ra) # 80003d24 <dirlookup>
    80003ec8:	8caa                	mv	s9,a0
    80003eca:	dd51                	beqz	a0,80003e66 <namex+0x92>
    iunlockput(ip);
    80003ecc:	854e                	mv	a0,s3
    80003ece:	00000097          	auipc	ra,0x0
    80003ed2:	bd4080e7          	jalr	-1068(ra) # 80003aa2 <iunlockput>
    ip = next;
    80003ed6:	89e6                	mv	s3,s9
  while(*path == '/')
    80003ed8:	0004c783          	lbu	a5,0(s1)
    80003edc:	05279763          	bne	a5,s2,80003f2a <namex+0x156>
    path++;
    80003ee0:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003ee2:	0004c783          	lbu	a5,0(s1)
    80003ee6:	ff278de3          	beq	a5,s2,80003ee0 <namex+0x10c>
  if(*path == 0)
    80003eea:	c79d                	beqz	a5,80003f18 <namex+0x144>
    path++;
    80003eec:	85a6                	mv	a1,s1
  len = path - s;
    80003eee:	8cda                	mv	s9,s6
    80003ef0:	865a                	mv	a2,s6
  while(*path != '/' && *path != 0)
    80003ef2:	01278963          	beq	a5,s2,80003f04 <namex+0x130>
    80003ef6:	dfbd                	beqz	a5,80003e74 <namex+0xa0>
    path++;
    80003ef8:	0485                	addi	s1,s1,1
  while(*path != '/' && *path != 0)
    80003efa:	0004c783          	lbu	a5,0(s1)
    80003efe:	ff279ce3          	bne	a5,s2,80003ef6 <namex+0x122>
    80003f02:	bf8d                	j	80003e74 <namex+0xa0>
    memmove(name, s, len);
    80003f04:	2601                	sext.w	a2,a2
    80003f06:	8552                	mv	a0,s4
    80003f08:	ffffd097          	auipc	ra,0xffffd
    80003f0c:	e26080e7          	jalr	-474(ra) # 80000d2e <memmove>
    name[len] = 0;
    80003f10:	9cd2                	add	s9,s9,s4
    80003f12:	000c8023          	sb	zero,0(s9) # 2000 <_entry-0x7fffe000>
    80003f16:	bf9d                	j	80003e8c <namex+0xb8>
  if(nameiparent){
    80003f18:	f20a83e3          	beqz	s5,80003e3e <namex+0x6a>
    iput(ip);
    80003f1c:	854e                	mv	a0,s3
    80003f1e:	00000097          	auipc	ra,0x0
    80003f22:	adc080e7          	jalr	-1316(ra) # 800039fa <iput>
    return 0;
    80003f26:	4981                	li	s3,0
    80003f28:	bf19                	j	80003e3e <namex+0x6a>
  if(*path == 0)
    80003f2a:	d7fd                	beqz	a5,80003f18 <namex+0x144>
  while(*path != '/' && *path != 0)
    80003f2c:	0004c783          	lbu	a5,0(s1)
    80003f30:	85a6                	mv	a1,s1
    80003f32:	b7d1                	j	80003ef6 <namex+0x122>

0000000080003f34 <dirlink>:
{
    80003f34:	7139                	addi	sp,sp,-64
    80003f36:	fc06                	sd	ra,56(sp)
    80003f38:	f822                	sd	s0,48(sp)
    80003f3a:	f426                	sd	s1,40(sp)
    80003f3c:	f04a                	sd	s2,32(sp)
    80003f3e:	ec4e                	sd	s3,24(sp)
    80003f40:	e852                	sd	s4,16(sp)
    80003f42:	0080                	addi	s0,sp,64
    80003f44:	892a                	mv	s2,a0
    80003f46:	8a2e                	mv	s4,a1
    80003f48:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80003f4a:	4601                	li	a2,0
    80003f4c:	00000097          	auipc	ra,0x0
    80003f50:	dd8080e7          	jalr	-552(ra) # 80003d24 <dirlookup>
    80003f54:	e93d                	bnez	a0,80003fca <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003f56:	04c92483          	lw	s1,76(s2)
    80003f5a:	c49d                	beqz	s1,80003f88 <dirlink+0x54>
    80003f5c:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003f5e:	4741                	li	a4,16
    80003f60:	86a6                	mv	a3,s1
    80003f62:	fc040613          	addi	a2,s0,-64
    80003f66:	4581                	li	a1,0
    80003f68:	854a                	mv	a0,s2
    80003f6a:	00000097          	auipc	ra,0x0
    80003f6e:	b8a080e7          	jalr	-1142(ra) # 80003af4 <readi>
    80003f72:	47c1                	li	a5,16
    80003f74:	06f51163          	bne	a0,a5,80003fd6 <dirlink+0xa2>
    if(de.inum == 0)
    80003f78:	fc045783          	lhu	a5,-64(s0)
    80003f7c:	c791                	beqz	a5,80003f88 <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003f7e:	24c1                	addiw	s1,s1,16
    80003f80:	04c92783          	lw	a5,76(s2)
    80003f84:	fcf4ede3          	bltu	s1,a5,80003f5e <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    80003f88:	4639                	li	a2,14
    80003f8a:	85d2                	mv	a1,s4
    80003f8c:	fc240513          	addi	a0,s0,-62
    80003f90:	ffffd097          	auipc	ra,0xffffd
    80003f94:	e4e080e7          	jalr	-434(ra) # 80000dde <strncpy>
  de.inum = inum;
    80003f98:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003f9c:	4741                	li	a4,16
    80003f9e:	86a6                	mv	a3,s1
    80003fa0:	fc040613          	addi	a2,s0,-64
    80003fa4:	4581                	li	a1,0
    80003fa6:	854a                	mv	a0,s2
    80003fa8:	00000097          	auipc	ra,0x0
    80003fac:	c44080e7          	jalr	-956(ra) # 80003bec <writei>
    80003fb0:	1541                	addi	a0,a0,-16
    80003fb2:	00a03533          	snez	a0,a0
    80003fb6:	40a00533          	neg	a0,a0
}
    80003fba:	70e2                	ld	ra,56(sp)
    80003fbc:	7442                	ld	s0,48(sp)
    80003fbe:	74a2                	ld	s1,40(sp)
    80003fc0:	7902                	ld	s2,32(sp)
    80003fc2:	69e2                	ld	s3,24(sp)
    80003fc4:	6a42                	ld	s4,16(sp)
    80003fc6:	6121                	addi	sp,sp,64
    80003fc8:	8082                	ret
    iput(ip);
    80003fca:	00000097          	auipc	ra,0x0
    80003fce:	a30080e7          	jalr	-1488(ra) # 800039fa <iput>
    return -1;
    80003fd2:	557d                	li	a0,-1
    80003fd4:	b7dd                	j	80003fba <dirlink+0x86>
      panic("dirlink read");
    80003fd6:	00004517          	auipc	a0,0x4
    80003fda:	65250513          	addi	a0,a0,1618 # 80008628 <syscalls+0x1d0>
    80003fde:	ffffc097          	auipc	ra,0xffffc
    80003fe2:	560080e7          	jalr	1376(ra) # 8000053e <panic>

0000000080003fe6 <namei>:

struct inode*
namei(char *path)
{
    80003fe6:	1101                	addi	sp,sp,-32
    80003fe8:	ec06                	sd	ra,24(sp)
    80003fea:	e822                	sd	s0,16(sp)
    80003fec:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80003fee:	fe040613          	addi	a2,s0,-32
    80003ff2:	4581                	li	a1,0
    80003ff4:	00000097          	auipc	ra,0x0
    80003ff8:	de0080e7          	jalr	-544(ra) # 80003dd4 <namex>
}
    80003ffc:	60e2                	ld	ra,24(sp)
    80003ffe:	6442                	ld	s0,16(sp)
    80004000:	6105                	addi	sp,sp,32
    80004002:	8082                	ret

0000000080004004 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80004004:	1141                	addi	sp,sp,-16
    80004006:	e406                	sd	ra,8(sp)
    80004008:	e022                	sd	s0,0(sp)
    8000400a:	0800                	addi	s0,sp,16
    8000400c:	862e                	mv	a2,a1
  return namex(path, 1, name);
    8000400e:	4585                	li	a1,1
    80004010:	00000097          	auipc	ra,0x0
    80004014:	dc4080e7          	jalr	-572(ra) # 80003dd4 <namex>
}
    80004018:	60a2                	ld	ra,8(sp)
    8000401a:	6402                	ld	s0,0(sp)
    8000401c:	0141                	addi	sp,sp,16
    8000401e:	8082                	ret

0000000080004020 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80004020:	1101                	addi	sp,sp,-32
    80004022:	ec06                	sd	ra,24(sp)
    80004024:	e822                	sd	s0,16(sp)
    80004026:	e426                	sd	s1,8(sp)
    80004028:	e04a                	sd	s2,0(sp)
    8000402a:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    8000402c:	0001d917          	auipc	s2,0x1d
    80004030:	ae490913          	addi	s2,s2,-1308 # 80020b10 <log>
    80004034:	01892583          	lw	a1,24(s2)
    80004038:	02892503          	lw	a0,40(s2)
    8000403c:	fffff097          	auipc	ra,0xfffff
    80004040:	fea080e7          	jalr	-22(ra) # 80003026 <bread>
    80004044:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    80004046:	02c92683          	lw	a3,44(s2)
    8000404a:	cd34                	sw	a3,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    8000404c:	02d05763          	blez	a3,8000407a <write_head+0x5a>
    80004050:	0001d797          	auipc	a5,0x1d
    80004054:	af078793          	addi	a5,a5,-1296 # 80020b40 <log+0x30>
    80004058:	05c50713          	addi	a4,a0,92
    8000405c:	36fd                	addiw	a3,a3,-1
    8000405e:	1682                	slli	a3,a3,0x20
    80004060:	9281                	srli	a3,a3,0x20
    80004062:	068a                	slli	a3,a3,0x2
    80004064:	0001d617          	auipc	a2,0x1d
    80004068:	ae060613          	addi	a2,a2,-1312 # 80020b44 <log+0x34>
    8000406c:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    8000406e:	4390                	lw	a2,0(a5)
    80004070:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80004072:	0791                	addi	a5,a5,4
    80004074:	0711                	addi	a4,a4,4
    80004076:	fed79ce3          	bne	a5,a3,8000406e <write_head+0x4e>
  }
  bwrite(buf);
    8000407a:	8526                	mv	a0,s1
    8000407c:	fffff097          	auipc	ra,0xfffff
    80004080:	09c080e7          	jalr	156(ra) # 80003118 <bwrite>
  brelse(buf);
    80004084:	8526                	mv	a0,s1
    80004086:	fffff097          	auipc	ra,0xfffff
    8000408a:	0d0080e7          	jalr	208(ra) # 80003156 <brelse>
}
    8000408e:	60e2                	ld	ra,24(sp)
    80004090:	6442                	ld	s0,16(sp)
    80004092:	64a2                	ld	s1,8(sp)
    80004094:	6902                	ld	s2,0(sp)
    80004096:	6105                	addi	sp,sp,32
    80004098:	8082                	ret

000000008000409a <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    8000409a:	0001d797          	auipc	a5,0x1d
    8000409e:	aa27a783          	lw	a5,-1374(a5) # 80020b3c <log+0x2c>
    800040a2:	0af05d63          	blez	a5,8000415c <install_trans+0xc2>
{
    800040a6:	7139                	addi	sp,sp,-64
    800040a8:	fc06                	sd	ra,56(sp)
    800040aa:	f822                	sd	s0,48(sp)
    800040ac:	f426                	sd	s1,40(sp)
    800040ae:	f04a                	sd	s2,32(sp)
    800040b0:	ec4e                	sd	s3,24(sp)
    800040b2:	e852                	sd	s4,16(sp)
    800040b4:	e456                	sd	s5,8(sp)
    800040b6:	e05a                	sd	s6,0(sp)
    800040b8:	0080                	addi	s0,sp,64
    800040ba:	8b2a                	mv	s6,a0
    800040bc:	0001da97          	auipc	s5,0x1d
    800040c0:	a84a8a93          	addi	s5,s5,-1404 # 80020b40 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    800040c4:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    800040c6:	0001d997          	auipc	s3,0x1d
    800040ca:	a4a98993          	addi	s3,s3,-1462 # 80020b10 <log>
    800040ce:	a00d                	j	800040f0 <install_trans+0x56>
    brelse(lbuf);
    800040d0:	854a                	mv	a0,s2
    800040d2:	fffff097          	auipc	ra,0xfffff
    800040d6:	084080e7          	jalr	132(ra) # 80003156 <brelse>
    brelse(dbuf);
    800040da:	8526                	mv	a0,s1
    800040dc:	fffff097          	auipc	ra,0xfffff
    800040e0:	07a080e7          	jalr	122(ra) # 80003156 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800040e4:	2a05                	addiw	s4,s4,1
    800040e6:	0a91                	addi	s5,s5,4
    800040e8:	02c9a783          	lw	a5,44(s3)
    800040ec:	04fa5e63          	bge	s4,a5,80004148 <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    800040f0:	0189a583          	lw	a1,24(s3)
    800040f4:	014585bb          	addw	a1,a1,s4
    800040f8:	2585                	addiw	a1,a1,1
    800040fa:	0289a503          	lw	a0,40(s3)
    800040fe:	fffff097          	auipc	ra,0xfffff
    80004102:	f28080e7          	jalr	-216(ra) # 80003026 <bread>
    80004106:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80004108:	000aa583          	lw	a1,0(s5)
    8000410c:	0289a503          	lw	a0,40(s3)
    80004110:	fffff097          	auipc	ra,0xfffff
    80004114:	f16080e7          	jalr	-234(ra) # 80003026 <bread>
    80004118:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    8000411a:	40000613          	li	a2,1024
    8000411e:	05890593          	addi	a1,s2,88
    80004122:	05850513          	addi	a0,a0,88
    80004126:	ffffd097          	auipc	ra,0xffffd
    8000412a:	c08080e7          	jalr	-1016(ra) # 80000d2e <memmove>
    bwrite(dbuf);  // write dst to disk
    8000412e:	8526                	mv	a0,s1
    80004130:	fffff097          	auipc	ra,0xfffff
    80004134:	fe8080e7          	jalr	-24(ra) # 80003118 <bwrite>
    if(recovering == 0)
    80004138:	f80b1ce3          	bnez	s6,800040d0 <install_trans+0x36>
      bunpin(dbuf);
    8000413c:	8526                	mv	a0,s1
    8000413e:	fffff097          	auipc	ra,0xfffff
    80004142:	0f2080e7          	jalr	242(ra) # 80003230 <bunpin>
    80004146:	b769                	j	800040d0 <install_trans+0x36>
}
    80004148:	70e2                	ld	ra,56(sp)
    8000414a:	7442                	ld	s0,48(sp)
    8000414c:	74a2                	ld	s1,40(sp)
    8000414e:	7902                	ld	s2,32(sp)
    80004150:	69e2                	ld	s3,24(sp)
    80004152:	6a42                	ld	s4,16(sp)
    80004154:	6aa2                	ld	s5,8(sp)
    80004156:	6b02                	ld	s6,0(sp)
    80004158:	6121                	addi	sp,sp,64
    8000415a:	8082                	ret
    8000415c:	8082                	ret

000000008000415e <initlog>:
{
    8000415e:	7179                	addi	sp,sp,-48
    80004160:	f406                	sd	ra,40(sp)
    80004162:	f022                	sd	s0,32(sp)
    80004164:	ec26                	sd	s1,24(sp)
    80004166:	e84a                	sd	s2,16(sp)
    80004168:	e44e                	sd	s3,8(sp)
    8000416a:	1800                	addi	s0,sp,48
    8000416c:	892a                	mv	s2,a0
    8000416e:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80004170:	0001d497          	auipc	s1,0x1d
    80004174:	9a048493          	addi	s1,s1,-1632 # 80020b10 <log>
    80004178:	00004597          	auipc	a1,0x4
    8000417c:	4c058593          	addi	a1,a1,1216 # 80008638 <syscalls+0x1e0>
    80004180:	8526                	mv	a0,s1
    80004182:	ffffd097          	auipc	ra,0xffffd
    80004186:	9c4080e7          	jalr	-1596(ra) # 80000b46 <initlock>
  log.start = sb->logstart;
    8000418a:	0149a583          	lw	a1,20(s3)
    8000418e:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    80004190:	0109a783          	lw	a5,16(s3)
    80004194:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    80004196:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    8000419a:	854a                	mv	a0,s2
    8000419c:	fffff097          	auipc	ra,0xfffff
    800041a0:	e8a080e7          	jalr	-374(ra) # 80003026 <bread>
  log.lh.n = lh->n;
    800041a4:	4d34                	lw	a3,88(a0)
    800041a6:	d4d4                	sw	a3,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    800041a8:	02d05563          	blez	a3,800041d2 <initlog+0x74>
    800041ac:	05c50793          	addi	a5,a0,92
    800041b0:	0001d717          	auipc	a4,0x1d
    800041b4:	99070713          	addi	a4,a4,-1648 # 80020b40 <log+0x30>
    800041b8:	36fd                	addiw	a3,a3,-1
    800041ba:	1682                	slli	a3,a3,0x20
    800041bc:	9281                	srli	a3,a3,0x20
    800041be:	068a                	slli	a3,a3,0x2
    800041c0:	06050613          	addi	a2,a0,96
    800041c4:	96b2                	add	a3,a3,a2
    log.lh.block[i] = lh->block[i];
    800041c6:	4390                	lw	a2,0(a5)
    800041c8:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    800041ca:	0791                	addi	a5,a5,4
    800041cc:	0711                	addi	a4,a4,4
    800041ce:	fed79ce3          	bne	a5,a3,800041c6 <initlog+0x68>
  brelse(buf);
    800041d2:	fffff097          	auipc	ra,0xfffff
    800041d6:	f84080e7          	jalr	-124(ra) # 80003156 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    800041da:	4505                	li	a0,1
    800041dc:	00000097          	auipc	ra,0x0
    800041e0:	ebe080e7          	jalr	-322(ra) # 8000409a <install_trans>
  log.lh.n = 0;
    800041e4:	0001d797          	auipc	a5,0x1d
    800041e8:	9407ac23          	sw	zero,-1704(a5) # 80020b3c <log+0x2c>
  write_head(); // clear the log
    800041ec:	00000097          	auipc	ra,0x0
    800041f0:	e34080e7          	jalr	-460(ra) # 80004020 <write_head>
}
    800041f4:	70a2                	ld	ra,40(sp)
    800041f6:	7402                	ld	s0,32(sp)
    800041f8:	64e2                	ld	s1,24(sp)
    800041fa:	6942                	ld	s2,16(sp)
    800041fc:	69a2                	ld	s3,8(sp)
    800041fe:	6145                	addi	sp,sp,48
    80004200:	8082                	ret

0000000080004202 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80004202:	1101                	addi	sp,sp,-32
    80004204:	ec06                	sd	ra,24(sp)
    80004206:	e822                	sd	s0,16(sp)
    80004208:	e426                	sd	s1,8(sp)
    8000420a:	e04a                	sd	s2,0(sp)
    8000420c:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    8000420e:	0001d517          	auipc	a0,0x1d
    80004212:	90250513          	addi	a0,a0,-1790 # 80020b10 <log>
    80004216:	ffffd097          	auipc	ra,0xffffd
    8000421a:	9c0080e7          	jalr	-1600(ra) # 80000bd6 <acquire>
  while(1){
    if(log.committing){
    8000421e:	0001d497          	auipc	s1,0x1d
    80004222:	8f248493          	addi	s1,s1,-1806 # 80020b10 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80004226:	4979                	li	s2,30
    80004228:	a039                	j	80004236 <begin_op+0x34>
      sleep(&log, &log.lock);
    8000422a:	85a6                	mv	a1,s1
    8000422c:	8526                	mv	a0,s1
    8000422e:	ffffe097          	auipc	ra,0xffffe
    80004232:	e26080e7          	jalr	-474(ra) # 80002054 <sleep>
    if(log.committing){
    80004236:	50dc                	lw	a5,36(s1)
    80004238:	fbed                	bnez	a5,8000422a <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    8000423a:	509c                	lw	a5,32(s1)
    8000423c:	0017871b          	addiw	a4,a5,1
    80004240:	0007069b          	sext.w	a3,a4
    80004244:	0027179b          	slliw	a5,a4,0x2
    80004248:	9fb9                	addw	a5,a5,a4
    8000424a:	0017979b          	slliw	a5,a5,0x1
    8000424e:	54d8                	lw	a4,44(s1)
    80004250:	9fb9                	addw	a5,a5,a4
    80004252:	00f95963          	bge	s2,a5,80004264 <begin_op+0x62>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80004256:	85a6                	mv	a1,s1
    80004258:	8526                	mv	a0,s1
    8000425a:	ffffe097          	auipc	ra,0xffffe
    8000425e:	dfa080e7          	jalr	-518(ra) # 80002054 <sleep>
    80004262:	bfd1                	j	80004236 <begin_op+0x34>
    } else {
      log.outstanding += 1;
    80004264:	0001d517          	auipc	a0,0x1d
    80004268:	8ac50513          	addi	a0,a0,-1876 # 80020b10 <log>
    8000426c:	d114                	sw	a3,32(a0)
      release(&log.lock);
    8000426e:	ffffd097          	auipc	ra,0xffffd
    80004272:	a1c080e7          	jalr	-1508(ra) # 80000c8a <release>
      break;
    }
  }
}
    80004276:	60e2                	ld	ra,24(sp)
    80004278:	6442                	ld	s0,16(sp)
    8000427a:	64a2                	ld	s1,8(sp)
    8000427c:	6902                	ld	s2,0(sp)
    8000427e:	6105                	addi	sp,sp,32
    80004280:	8082                	ret

0000000080004282 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80004282:	7139                	addi	sp,sp,-64
    80004284:	fc06                	sd	ra,56(sp)
    80004286:	f822                	sd	s0,48(sp)
    80004288:	f426                	sd	s1,40(sp)
    8000428a:	f04a                	sd	s2,32(sp)
    8000428c:	ec4e                	sd	s3,24(sp)
    8000428e:	e852                	sd	s4,16(sp)
    80004290:	e456                	sd	s5,8(sp)
    80004292:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80004294:	0001d497          	auipc	s1,0x1d
    80004298:	87c48493          	addi	s1,s1,-1924 # 80020b10 <log>
    8000429c:	8526                	mv	a0,s1
    8000429e:	ffffd097          	auipc	ra,0xffffd
    800042a2:	938080e7          	jalr	-1736(ra) # 80000bd6 <acquire>
  log.outstanding -= 1;
    800042a6:	509c                	lw	a5,32(s1)
    800042a8:	37fd                	addiw	a5,a5,-1
    800042aa:	0007891b          	sext.w	s2,a5
    800042ae:	d09c                	sw	a5,32(s1)
  if(log.committing)
    800042b0:	50dc                	lw	a5,36(s1)
    800042b2:	e7b9                	bnez	a5,80004300 <end_op+0x7e>
    panic("log.committing");
  if(log.outstanding == 0){
    800042b4:	04091e63          	bnez	s2,80004310 <end_op+0x8e>
    do_commit = 1;
    log.committing = 1;
    800042b8:	0001d497          	auipc	s1,0x1d
    800042bc:	85848493          	addi	s1,s1,-1960 # 80020b10 <log>
    800042c0:	4785                	li	a5,1
    800042c2:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    800042c4:	8526                	mv	a0,s1
    800042c6:	ffffd097          	auipc	ra,0xffffd
    800042ca:	9c4080e7          	jalr	-1596(ra) # 80000c8a <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    800042ce:	54dc                	lw	a5,44(s1)
    800042d0:	06f04763          	bgtz	a5,8000433e <end_op+0xbc>
    acquire(&log.lock);
    800042d4:	0001d497          	auipc	s1,0x1d
    800042d8:	83c48493          	addi	s1,s1,-1988 # 80020b10 <log>
    800042dc:	8526                	mv	a0,s1
    800042de:	ffffd097          	auipc	ra,0xffffd
    800042e2:	8f8080e7          	jalr	-1800(ra) # 80000bd6 <acquire>
    log.committing = 0;
    800042e6:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    800042ea:	8526                	mv	a0,s1
    800042ec:	ffffe097          	auipc	ra,0xffffe
    800042f0:	dcc080e7          	jalr	-564(ra) # 800020b8 <wakeup>
    release(&log.lock);
    800042f4:	8526                	mv	a0,s1
    800042f6:	ffffd097          	auipc	ra,0xffffd
    800042fa:	994080e7          	jalr	-1644(ra) # 80000c8a <release>
}
    800042fe:	a03d                	j	8000432c <end_op+0xaa>
    panic("log.committing");
    80004300:	00004517          	auipc	a0,0x4
    80004304:	34050513          	addi	a0,a0,832 # 80008640 <syscalls+0x1e8>
    80004308:	ffffc097          	auipc	ra,0xffffc
    8000430c:	236080e7          	jalr	566(ra) # 8000053e <panic>
    wakeup(&log);
    80004310:	0001d497          	auipc	s1,0x1d
    80004314:	80048493          	addi	s1,s1,-2048 # 80020b10 <log>
    80004318:	8526                	mv	a0,s1
    8000431a:	ffffe097          	auipc	ra,0xffffe
    8000431e:	d9e080e7          	jalr	-610(ra) # 800020b8 <wakeup>
  release(&log.lock);
    80004322:	8526                	mv	a0,s1
    80004324:	ffffd097          	auipc	ra,0xffffd
    80004328:	966080e7          	jalr	-1690(ra) # 80000c8a <release>
}
    8000432c:	70e2                	ld	ra,56(sp)
    8000432e:	7442                	ld	s0,48(sp)
    80004330:	74a2                	ld	s1,40(sp)
    80004332:	7902                	ld	s2,32(sp)
    80004334:	69e2                	ld	s3,24(sp)
    80004336:	6a42                	ld	s4,16(sp)
    80004338:	6aa2                	ld	s5,8(sp)
    8000433a:	6121                	addi	sp,sp,64
    8000433c:	8082                	ret
  for (tail = 0; tail < log.lh.n; tail++) {
    8000433e:	0001da97          	auipc	s5,0x1d
    80004342:	802a8a93          	addi	s5,s5,-2046 # 80020b40 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80004346:	0001ca17          	auipc	s4,0x1c
    8000434a:	7caa0a13          	addi	s4,s4,1994 # 80020b10 <log>
    8000434e:	018a2583          	lw	a1,24(s4)
    80004352:	012585bb          	addw	a1,a1,s2
    80004356:	2585                	addiw	a1,a1,1
    80004358:	028a2503          	lw	a0,40(s4)
    8000435c:	fffff097          	auipc	ra,0xfffff
    80004360:	cca080e7          	jalr	-822(ra) # 80003026 <bread>
    80004364:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80004366:	000aa583          	lw	a1,0(s5)
    8000436a:	028a2503          	lw	a0,40(s4)
    8000436e:	fffff097          	auipc	ra,0xfffff
    80004372:	cb8080e7          	jalr	-840(ra) # 80003026 <bread>
    80004376:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    80004378:	40000613          	li	a2,1024
    8000437c:	05850593          	addi	a1,a0,88
    80004380:	05848513          	addi	a0,s1,88
    80004384:	ffffd097          	auipc	ra,0xffffd
    80004388:	9aa080e7          	jalr	-1622(ra) # 80000d2e <memmove>
    bwrite(to);  // write the log
    8000438c:	8526                	mv	a0,s1
    8000438e:	fffff097          	auipc	ra,0xfffff
    80004392:	d8a080e7          	jalr	-630(ra) # 80003118 <bwrite>
    brelse(from);
    80004396:	854e                	mv	a0,s3
    80004398:	fffff097          	auipc	ra,0xfffff
    8000439c:	dbe080e7          	jalr	-578(ra) # 80003156 <brelse>
    brelse(to);
    800043a0:	8526                	mv	a0,s1
    800043a2:	fffff097          	auipc	ra,0xfffff
    800043a6:	db4080e7          	jalr	-588(ra) # 80003156 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800043aa:	2905                	addiw	s2,s2,1
    800043ac:	0a91                	addi	s5,s5,4
    800043ae:	02ca2783          	lw	a5,44(s4)
    800043b2:	f8f94ee3          	blt	s2,a5,8000434e <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    800043b6:	00000097          	auipc	ra,0x0
    800043ba:	c6a080e7          	jalr	-918(ra) # 80004020 <write_head>
    install_trans(0); // Now install writes to home locations
    800043be:	4501                	li	a0,0
    800043c0:	00000097          	auipc	ra,0x0
    800043c4:	cda080e7          	jalr	-806(ra) # 8000409a <install_trans>
    log.lh.n = 0;
    800043c8:	0001c797          	auipc	a5,0x1c
    800043cc:	7607aa23          	sw	zero,1908(a5) # 80020b3c <log+0x2c>
    write_head();    // Erase the transaction from the log
    800043d0:	00000097          	auipc	ra,0x0
    800043d4:	c50080e7          	jalr	-944(ra) # 80004020 <write_head>
    800043d8:	bdf5                	j	800042d4 <end_op+0x52>

00000000800043da <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    800043da:	1101                	addi	sp,sp,-32
    800043dc:	ec06                	sd	ra,24(sp)
    800043de:	e822                	sd	s0,16(sp)
    800043e0:	e426                	sd	s1,8(sp)
    800043e2:	e04a                	sd	s2,0(sp)
    800043e4:	1000                	addi	s0,sp,32
    800043e6:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    800043e8:	0001c917          	auipc	s2,0x1c
    800043ec:	72890913          	addi	s2,s2,1832 # 80020b10 <log>
    800043f0:	854a                	mv	a0,s2
    800043f2:	ffffc097          	auipc	ra,0xffffc
    800043f6:	7e4080e7          	jalr	2020(ra) # 80000bd6 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    800043fa:	02c92603          	lw	a2,44(s2)
    800043fe:	47f5                	li	a5,29
    80004400:	06c7c563          	blt	a5,a2,8000446a <log_write+0x90>
    80004404:	0001c797          	auipc	a5,0x1c
    80004408:	7287a783          	lw	a5,1832(a5) # 80020b2c <log+0x1c>
    8000440c:	37fd                	addiw	a5,a5,-1
    8000440e:	04f65e63          	bge	a2,a5,8000446a <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    80004412:	0001c797          	auipc	a5,0x1c
    80004416:	71e7a783          	lw	a5,1822(a5) # 80020b30 <log+0x20>
    8000441a:	06f05063          	blez	a5,8000447a <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    8000441e:	4781                	li	a5,0
    80004420:	06c05563          	blez	a2,8000448a <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80004424:	44cc                	lw	a1,12(s1)
    80004426:	0001c717          	auipc	a4,0x1c
    8000442a:	71a70713          	addi	a4,a4,1818 # 80020b40 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    8000442e:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    80004430:	4314                	lw	a3,0(a4)
    80004432:	04b68c63          	beq	a3,a1,8000448a <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    80004436:	2785                	addiw	a5,a5,1
    80004438:	0711                	addi	a4,a4,4
    8000443a:	fef61be3          	bne	a2,a5,80004430 <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    8000443e:	0621                	addi	a2,a2,8
    80004440:	060a                	slli	a2,a2,0x2
    80004442:	0001c797          	auipc	a5,0x1c
    80004446:	6ce78793          	addi	a5,a5,1742 # 80020b10 <log>
    8000444a:	963e                	add	a2,a2,a5
    8000444c:	44dc                	lw	a5,12(s1)
    8000444e:	ca1c                	sw	a5,16(a2)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    80004450:	8526                	mv	a0,s1
    80004452:	fffff097          	auipc	ra,0xfffff
    80004456:	da2080e7          	jalr	-606(ra) # 800031f4 <bpin>
    log.lh.n++;
    8000445a:	0001c717          	auipc	a4,0x1c
    8000445e:	6b670713          	addi	a4,a4,1718 # 80020b10 <log>
    80004462:	575c                	lw	a5,44(a4)
    80004464:	2785                	addiw	a5,a5,1
    80004466:	d75c                	sw	a5,44(a4)
    80004468:	a835                	j	800044a4 <log_write+0xca>
    panic("too big a transaction");
    8000446a:	00004517          	auipc	a0,0x4
    8000446e:	1e650513          	addi	a0,a0,486 # 80008650 <syscalls+0x1f8>
    80004472:	ffffc097          	auipc	ra,0xffffc
    80004476:	0cc080e7          	jalr	204(ra) # 8000053e <panic>
    panic("log_write outside of trans");
    8000447a:	00004517          	auipc	a0,0x4
    8000447e:	1ee50513          	addi	a0,a0,494 # 80008668 <syscalls+0x210>
    80004482:	ffffc097          	auipc	ra,0xffffc
    80004486:	0bc080e7          	jalr	188(ra) # 8000053e <panic>
  log.lh.block[i] = b->blockno;
    8000448a:	00878713          	addi	a4,a5,8
    8000448e:	00271693          	slli	a3,a4,0x2
    80004492:	0001c717          	auipc	a4,0x1c
    80004496:	67e70713          	addi	a4,a4,1662 # 80020b10 <log>
    8000449a:	9736                	add	a4,a4,a3
    8000449c:	44d4                	lw	a3,12(s1)
    8000449e:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    800044a0:	faf608e3          	beq	a2,a5,80004450 <log_write+0x76>
  }
  release(&log.lock);
    800044a4:	0001c517          	auipc	a0,0x1c
    800044a8:	66c50513          	addi	a0,a0,1644 # 80020b10 <log>
    800044ac:	ffffc097          	auipc	ra,0xffffc
    800044b0:	7de080e7          	jalr	2014(ra) # 80000c8a <release>
}
    800044b4:	60e2                	ld	ra,24(sp)
    800044b6:	6442                	ld	s0,16(sp)
    800044b8:	64a2                	ld	s1,8(sp)
    800044ba:	6902                	ld	s2,0(sp)
    800044bc:	6105                	addi	sp,sp,32
    800044be:	8082                	ret

00000000800044c0 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    800044c0:	1101                	addi	sp,sp,-32
    800044c2:	ec06                	sd	ra,24(sp)
    800044c4:	e822                	sd	s0,16(sp)
    800044c6:	e426                	sd	s1,8(sp)
    800044c8:	e04a                	sd	s2,0(sp)
    800044ca:	1000                	addi	s0,sp,32
    800044cc:	84aa                	mv	s1,a0
    800044ce:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    800044d0:	00004597          	auipc	a1,0x4
    800044d4:	1b858593          	addi	a1,a1,440 # 80008688 <syscalls+0x230>
    800044d8:	0521                	addi	a0,a0,8
    800044da:	ffffc097          	auipc	ra,0xffffc
    800044de:	66c080e7          	jalr	1644(ra) # 80000b46 <initlock>
  lk->name = name;
    800044e2:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    800044e6:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800044ea:	0204a423          	sw	zero,40(s1)
}
    800044ee:	60e2                	ld	ra,24(sp)
    800044f0:	6442                	ld	s0,16(sp)
    800044f2:	64a2                	ld	s1,8(sp)
    800044f4:	6902                	ld	s2,0(sp)
    800044f6:	6105                	addi	sp,sp,32
    800044f8:	8082                	ret

00000000800044fa <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    800044fa:	1101                	addi	sp,sp,-32
    800044fc:	ec06                	sd	ra,24(sp)
    800044fe:	e822                	sd	s0,16(sp)
    80004500:	e426                	sd	s1,8(sp)
    80004502:	e04a                	sd	s2,0(sp)
    80004504:	1000                	addi	s0,sp,32
    80004506:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80004508:	00850913          	addi	s2,a0,8
    8000450c:	854a                	mv	a0,s2
    8000450e:	ffffc097          	auipc	ra,0xffffc
    80004512:	6c8080e7          	jalr	1736(ra) # 80000bd6 <acquire>
  while (lk->locked) {
    80004516:	409c                	lw	a5,0(s1)
    80004518:	cb89                	beqz	a5,8000452a <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    8000451a:	85ca                	mv	a1,s2
    8000451c:	8526                	mv	a0,s1
    8000451e:	ffffe097          	auipc	ra,0xffffe
    80004522:	b36080e7          	jalr	-1226(ra) # 80002054 <sleep>
  while (lk->locked) {
    80004526:	409c                	lw	a5,0(s1)
    80004528:	fbed                	bnez	a5,8000451a <acquiresleep+0x20>
  }
  lk->locked = 1;
    8000452a:	4785                	li	a5,1
    8000452c:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    8000452e:	ffffd097          	auipc	ra,0xffffd
    80004532:	47e080e7          	jalr	1150(ra) # 800019ac <myproc>
    80004536:	591c                	lw	a5,48(a0)
    80004538:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    8000453a:	854a                	mv	a0,s2
    8000453c:	ffffc097          	auipc	ra,0xffffc
    80004540:	74e080e7          	jalr	1870(ra) # 80000c8a <release>
}
    80004544:	60e2                	ld	ra,24(sp)
    80004546:	6442                	ld	s0,16(sp)
    80004548:	64a2                	ld	s1,8(sp)
    8000454a:	6902                	ld	s2,0(sp)
    8000454c:	6105                	addi	sp,sp,32
    8000454e:	8082                	ret

0000000080004550 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80004550:	1101                	addi	sp,sp,-32
    80004552:	ec06                	sd	ra,24(sp)
    80004554:	e822                	sd	s0,16(sp)
    80004556:	e426                	sd	s1,8(sp)
    80004558:	e04a                	sd	s2,0(sp)
    8000455a:	1000                	addi	s0,sp,32
    8000455c:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    8000455e:	00850913          	addi	s2,a0,8
    80004562:	854a                	mv	a0,s2
    80004564:	ffffc097          	auipc	ra,0xffffc
    80004568:	672080e7          	jalr	1650(ra) # 80000bd6 <acquire>
  lk->locked = 0;
    8000456c:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80004570:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80004574:	8526                	mv	a0,s1
    80004576:	ffffe097          	auipc	ra,0xffffe
    8000457a:	b42080e7          	jalr	-1214(ra) # 800020b8 <wakeup>
  release(&lk->lk);
    8000457e:	854a                	mv	a0,s2
    80004580:	ffffc097          	auipc	ra,0xffffc
    80004584:	70a080e7          	jalr	1802(ra) # 80000c8a <release>
}
    80004588:	60e2                	ld	ra,24(sp)
    8000458a:	6442                	ld	s0,16(sp)
    8000458c:	64a2                	ld	s1,8(sp)
    8000458e:	6902                	ld	s2,0(sp)
    80004590:	6105                	addi	sp,sp,32
    80004592:	8082                	ret

0000000080004594 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80004594:	7179                	addi	sp,sp,-48
    80004596:	f406                	sd	ra,40(sp)
    80004598:	f022                	sd	s0,32(sp)
    8000459a:	ec26                	sd	s1,24(sp)
    8000459c:	e84a                	sd	s2,16(sp)
    8000459e:	e44e                	sd	s3,8(sp)
    800045a0:	1800                	addi	s0,sp,48
    800045a2:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    800045a4:	00850913          	addi	s2,a0,8
    800045a8:	854a                	mv	a0,s2
    800045aa:	ffffc097          	auipc	ra,0xffffc
    800045ae:	62c080e7          	jalr	1580(ra) # 80000bd6 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    800045b2:	409c                	lw	a5,0(s1)
    800045b4:	ef99                	bnez	a5,800045d2 <holdingsleep+0x3e>
    800045b6:	4481                	li	s1,0
  release(&lk->lk);
    800045b8:	854a                	mv	a0,s2
    800045ba:	ffffc097          	auipc	ra,0xffffc
    800045be:	6d0080e7          	jalr	1744(ra) # 80000c8a <release>
  return r;
}
    800045c2:	8526                	mv	a0,s1
    800045c4:	70a2                	ld	ra,40(sp)
    800045c6:	7402                	ld	s0,32(sp)
    800045c8:	64e2                	ld	s1,24(sp)
    800045ca:	6942                	ld	s2,16(sp)
    800045cc:	69a2                	ld	s3,8(sp)
    800045ce:	6145                	addi	sp,sp,48
    800045d0:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    800045d2:	0284a983          	lw	s3,40(s1)
    800045d6:	ffffd097          	auipc	ra,0xffffd
    800045da:	3d6080e7          	jalr	982(ra) # 800019ac <myproc>
    800045de:	5904                	lw	s1,48(a0)
    800045e0:	413484b3          	sub	s1,s1,s3
    800045e4:	0014b493          	seqz	s1,s1
    800045e8:	bfc1                	j	800045b8 <holdingsleep+0x24>

00000000800045ea <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    800045ea:	1141                	addi	sp,sp,-16
    800045ec:	e406                	sd	ra,8(sp)
    800045ee:	e022                	sd	s0,0(sp)
    800045f0:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    800045f2:	00004597          	auipc	a1,0x4
    800045f6:	0a658593          	addi	a1,a1,166 # 80008698 <syscalls+0x240>
    800045fa:	0001c517          	auipc	a0,0x1c
    800045fe:	65e50513          	addi	a0,a0,1630 # 80020c58 <ftable>
    80004602:	ffffc097          	auipc	ra,0xffffc
    80004606:	544080e7          	jalr	1348(ra) # 80000b46 <initlock>
}
    8000460a:	60a2                	ld	ra,8(sp)
    8000460c:	6402                	ld	s0,0(sp)
    8000460e:	0141                	addi	sp,sp,16
    80004610:	8082                	ret

0000000080004612 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80004612:	1101                	addi	sp,sp,-32
    80004614:	ec06                	sd	ra,24(sp)
    80004616:	e822                	sd	s0,16(sp)
    80004618:	e426                	sd	s1,8(sp)
    8000461a:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    8000461c:	0001c517          	auipc	a0,0x1c
    80004620:	63c50513          	addi	a0,a0,1596 # 80020c58 <ftable>
    80004624:	ffffc097          	auipc	ra,0xffffc
    80004628:	5b2080e7          	jalr	1458(ra) # 80000bd6 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    8000462c:	0001c497          	auipc	s1,0x1c
    80004630:	64448493          	addi	s1,s1,1604 # 80020c70 <ftable+0x18>
    80004634:	0001d717          	auipc	a4,0x1d
    80004638:	5dc70713          	addi	a4,a4,1500 # 80021c10 <disk>
    if(f->ref == 0){
    8000463c:	40dc                	lw	a5,4(s1)
    8000463e:	cf99                	beqz	a5,8000465c <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80004640:	02848493          	addi	s1,s1,40
    80004644:	fee49ce3          	bne	s1,a4,8000463c <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80004648:	0001c517          	auipc	a0,0x1c
    8000464c:	61050513          	addi	a0,a0,1552 # 80020c58 <ftable>
    80004650:	ffffc097          	auipc	ra,0xffffc
    80004654:	63a080e7          	jalr	1594(ra) # 80000c8a <release>
  return 0;
    80004658:	4481                	li	s1,0
    8000465a:	a819                	j	80004670 <filealloc+0x5e>
      f->ref = 1;
    8000465c:	4785                	li	a5,1
    8000465e:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80004660:	0001c517          	auipc	a0,0x1c
    80004664:	5f850513          	addi	a0,a0,1528 # 80020c58 <ftable>
    80004668:	ffffc097          	auipc	ra,0xffffc
    8000466c:	622080e7          	jalr	1570(ra) # 80000c8a <release>
}
    80004670:	8526                	mv	a0,s1
    80004672:	60e2                	ld	ra,24(sp)
    80004674:	6442                	ld	s0,16(sp)
    80004676:	64a2                	ld	s1,8(sp)
    80004678:	6105                	addi	sp,sp,32
    8000467a:	8082                	ret

000000008000467c <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    8000467c:	1101                	addi	sp,sp,-32
    8000467e:	ec06                	sd	ra,24(sp)
    80004680:	e822                	sd	s0,16(sp)
    80004682:	e426                	sd	s1,8(sp)
    80004684:	1000                	addi	s0,sp,32
    80004686:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80004688:	0001c517          	auipc	a0,0x1c
    8000468c:	5d050513          	addi	a0,a0,1488 # 80020c58 <ftable>
    80004690:	ffffc097          	auipc	ra,0xffffc
    80004694:	546080e7          	jalr	1350(ra) # 80000bd6 <acquire>
  if(f->ref < 1)
    80004698:	40dc                	lw	a5,4(s1)
    8000469a:	02f05263          	blez	a5,800046be <filedup+0x42>
    panic("filedup");
  f->ref++;
    8000469e:	2785                	addiw	a5,a5,1
    800046a0:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    800046a2:	0001c517          	auipc	a0,0x1c
    800046a6:	5b650513          	addi	a0,a0,1462 # 80020c58 <ftable>
    800046aa:	ffffc097          	auipc	ra,0xffffc
    800046ae:	5e0080e7          	jalr	1504(ra) # 80000c8a <release>
  return f;
}
    800046b2:	8526                	mv	a0,s1
    800046b4:	60e2                	ld	ra,24(sp)
    800046b6:	6442                	ld	s0,16(sp)
    800046b8:	64a2                	ld	s1,8(sp)
    800046ba:	6105                	addi	sp,sp,32
    800046bc:	8082                	ret
    panic("filedup");
    800046be:	00004517          	auipc	a0,0x4
    800046c2:	fe250513          	addi	a0,a0,-30 # 800086a0 <syscalls+0x248>
    800046c6:	ffffc097          	auipc	ra,0xffffc
    800046ca:	e78080e7          	jalr	-392(ra) # 8000053e <panic>

00000000800046ce <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    800046ce:	7139                	addi	sp,sp,-64
    800046d0:	fc06                	sd	ra,56(sp)
    800046d2:	f822                	sd	s0,48(sp)
    800046d4:	f426                	sd	s1,40(sp)
    800046d6:	f04a                	sd	s2,32(sp)
    800046d8:	ec4e                	sd	s3,24(sp)
    800046da:	e852                	sd	s4,16(sp)
    800046dc:	e456                	sd	s5,8(sp)
    800046de:	0080                	addi	s0,sp,64
    800046e0:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    800046e2:	0001c517          	auipc	a0,0x1c
    800046e6:	57650513          	addi	a0,a0,1398 # 80020c58 <ftable>
    800046ea:	ffffc097          	auipc	ra,0xffffc
    800046ee:	4ec080e7          	jalr	1260(ra) # 80000bd6 <acquire>
  if(f->ref < 1)
    800046f2:	40dc                	lw	a5,4(s1)
    800046f4:	06f05163          	blez	a5,80004756 <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    800046f8:	37fd                	addiw	a5,a5,-1
    800046fa:	0007871b          	sext.w	a4,a5
    800046fe:	c0dc                	sw	a5,4(s1)
    80004700:	06e04363          	bgtz	a4,80004766 <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80004704:	0004a903          	lw	s2,0(s1)
    80004708:	0094ca83          	lbu	s5,9(s1)
    8000470c:	0104ba03          	ld	s4,16(s1)
    80004710:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80004714:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80004718:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    8000471c:	0001c517          	auipc	a0,0x1c
    80004720:	53c50513          	addi	a0,a0,1340 # 80020c58 <ftable>
    80004724:	ffffc097          	auipc	ra,0xffffc
    80004728:	566080e7          	jalr	1382(ra) # 80000c8a <release>

  if(ff.type == FD_PIPE){
    8000472c:	4785                	li	a5,1
    8000472e:	04f90d63          	beq	s2,a5,80004788 <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80004732:	3979                	addiw	s2,s2,-2
    80004734:	4785                	li	a5,1
    80004736:	0527e063          	bltu	a5,s2,80004776 <fileclose+0xa8>
    begin_op();
    8000473a:	00000097          	auipc	ra,0x0
    8000473e:	ac8080e7          	jalr	-1336(ra) # 80004202 <begin_op>
    iput(ff.ip);
    80004742:	854e                	mv	a0,s3
    80004744:	fffff097          	auipc	ra,0xfffff
    80004748:	2b6080e7          	jalr	694(ra) # 800039fa <iput>
    end_op();
    8000474c:	00000097          	auipc	ra,0x0
    80004750:	b36080e7          	jalr	-1226(ra) # 80004282 <end_op>
    80004754:	a00d                	j	80004776 <fileclose+0xa8>
    panic("fileclose");
    80004756:	00004517          	auipc	a0,0x4
    8000475a:	f5250513          	addi	a0,a0,-174 # 800086a8 <syscalls+0x250>
    8000475e:	ffffc097          	auipc	ra,0xffffc
    80004762:	de0080e7          	jalr	-544(ra) # 8000053e <panic>
    release(&ftable.lock);
    80004766:	0001c517          	auipc	a0,0x1c
    8000476a:	4f250513          	addi	a0,a0,1266 # 80020c58 <ftable>
    8000476e:	ffffc097          	auipc	ra,0xffffc
    80004772:	51c080e7          	jalr	1308(ra) # 80000c8a <release>
  }
}
    80004776:	70e2                	ld	ra,56(sp)
    80004778:	7442                	ld	s0,48(sp)
    8000477a:	74a2                	ld	s1,40(sp)
    8000477c:	7902                	ld	s2,32(sp)
    8000477e:	69e2                	ld	s3,24(sp)
    80004780:	6a42                	ld	s4,16(sp)
    80004782:	6aa2                	ld	s5,8(sp)
    80004784:	6121                	addi	sp,sp,64
    80004786:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80004788:	85d6                	mv	a1,s5
    8000478a:	8552                	mv	a0,s4
    8000478c:	00000097          	auipc	ra,0x0
    80004790:	34c080e7          	jalr	844(ra) # 80004ad8 <pipeclose>
    80004794:	b7cd                	j	80004776 <fileclose+0xa8>

0000000080004796 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80004796:	715d                	addi	sp,sp,-80
    80004798:	e486                	sd	ra,72(sp)
    8000479a:	e0a2                	sd	s0,64(sp)
    8000479c:	fc26                	sd	s1,56(sp)
    8000479e:	f84a                	sd	s2,48(sp)
    800047a0:	f44e                	sd	s3,40(sp)
    800047a2:	0880                	addi	s0,sp,80
    800047a4:	84aa                	mv	s1,a0
    800047a6:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    800047a8:	ffffd097          	auipc	ra,0xffffd
    800047ac:	204080e7          	jalr	516(ra) # 800019ac <myproc>
  struct stat st;

  if(f->type == FD_INODE || f->type == FD_DEVICE){
    800047b0:	409c                	lw	a5,0(s1)
    800047b2:	37f9                	addiw	a5,a5,-2
    800047b4:	4705                	li	a4,1
    800047b6:	04f76763          	bltu	a4,a5,80004804 <filestat+0x6e>
    800047ba:	892a                	mv	s2,a0
    ilock(f->ip);
    800047bc:	6c88                	ld	a0,24(s1)
    800047be:	fffff097          	auipc	ra,0xfffff
    800047c2:	082080e7          	jalr	130(ra) # 80003840 <ilock>
    stati(f->ip, &st);
    800047c6:	fb840593          	addi	a1,s0,-72
    800047ca:	6c88                	ld	a0,24(s1)
    800047cc:	fffff097          	auipc	ra,0xfffff
    800047d0:	2fe080e7          	jalr	766(ra) # 80003aca <stati>
    iunlock(f->ip);
    800047d4:	6c88                	ld	a0,24(s1)
    800047d6:	fffff097          	auipc	ra,0xfffff
    800047da:	12c080e7          	jalr	300(ra) # 80003902 <iunlock>
    if(copyout(p->pigtable, addr, (char *)&st, sizeof(st)) < 0)
    800047de:	46e1                	li	a3,24
    800047e0:	fb840613          	addi	a2,s0,-72
    800047e4:	85ce                	mv	a1,s3
    800047e6:	05093503          	ld	a0,80(s2)
    800047ea:	ffffd097          	auipc	ra,0xffffd
    800047ee:	e7e080e7          	jalr	-386(ra) # 80001668 <copyout>
    800047f2:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    800047f6:	60a6                	ld	ra,72(sp)
    800047f8:	6406                	ld	s0,64(sp)
    800047fa:	74e2                	ld	s1,56(sp)
    800047fc:	7942                	ld	s2,48(sp)
    800047fe:	79a2                	ld	s3,40(sp)
    80004800:	6161                	addi	sp,sp,80
    80004802:	8082                	ret
  return -1;
    80004804:	557d                	li	a0,-1
    80004806:	bfc5                	j	800047f6 <filestat+0x60>

0000000080004808 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80004808:	7179                	addi	sp,sp,-48
    8000480a:	f406                	sd	ra,40(sp)
    8000480c:	f022                	sd	s0,32(sp)
    8000480e:	ec26                	sd	s1,24(sp)
    80004810:	e84a                	sd	s2,16(sp)
    80004812:	e44e                	sd	s3,8(sp)
    80004814:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80004816:	00854783          	lbu	a5,8(a0)
    8000481a:	c3d5                	beqz	a5,800048be <fileread+0xb6>
    8000481c:	84aa                	mv	s1,a0
    8000481e:	89ae                	mv	s3,a1
    80004820:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80004822:	411c                	lw	a5,0(a0)
    80004824:	4705                	li	a4,1
    80004826:	04e78963          	beq	a5,a4,80004878 <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    8000482a:	470d                	li	a4,3
    8000482c:	04e78d63          	beq	a5,a4,80004886 <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80004830:	4709                	li	a4,2
    80004832:	06e79e63          	bne	a5,a4,800048ae <fileread+0xa6>
    ilock(f->ip);
    80004836:	6d08                	ld	a0,24(a0)
    80004838:	fffff097          	auipc	ra,0xfffff
    8000483c:	008080e7          	jalr	8(ra) # 80003840 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80004840:	874a                	mv	a4,s2
    80004842:	5094                	lw	a3,32(s1)
    80004844:	864e                	mv	a2,s3
    80004846:	4585                	li	a1,1
    80004848:	6c88                	ld	a0,24(s1)
    8000484a:	fffff097          	auipc	ra,0xfffff
    8000484e:	2aa080e7          	jalr	682(ra) # 80003af4 <readi>
    80004852:	892a                	mv	s2,a0
    80004854:	00a05563          	blez	a0,8000485e <fileread+0x56>
      f->off += r;
    80004858:	509c                	lw	a5,32(s1)
    8000485a:	9fa9                	addw	a5,a5,a0
    8000485c:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    8000485e:	6c88                	ld	a0,24(s1)
    80004860:	fffff097          	auipc	ra,0xfffff
    80004864:	0a2080e7          	jalr	162(ra) # 80003902 <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80004868:	854a                	mv	a0,s2
    8000486a:	70a2                	ld	ra,40(sp)
    8000486c:	7402                	ld	s0,32(sp)
    8000486e:	64e2                	ld	s1,24(sp)
    80004870:	6942                	ld	s2,16(sp)
    80004872:	69a2                	ld	s3,8(sp)
    80004874:	6145                	addi	sp,sp,48
    80004876:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80004878:	6908                	ld	a0,16(a0)
    8000487a:	00000097          	auipc	ra,0x0
    8000487e:	3c6080e7          	jalr	966(ra) # 80004c40 <piperead>
    80004882:	892a                	mv	s2,a0
    80004884:	b7d5                	j	80004868 <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80004886:	02451783          	lh	a5,36(a0)
    8000488a:	03079693          	slli	a3,a5,0x30
    8000488e:	92c1                	srli	a3,a3,0x30
    80004890:	4725                	li	a4,9
    80004892:	02d76863          	bltu	a4,a3,800048c2 <fileread+0xba>
    80004896:	0792                	slli	a5,a5,0x4
    80004898:	0001c717          	auipc	a4,0x1c
    8000489c:	32070713          	addi	a4,a4,800 # 80020bb8 <devsw>
    800048a0:	97ba                	add	a5,a5,a4
    800048a2:	639c                	ld	a5,0(a5)
    800048a4:	c38d                	beqz	a5,800048c6 <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    800048a6:	4505                	li	a0,1
    800048a8:	9782                	jalr	a5
    800048aa:	892a                	mv	s2,a0
    800048ac:	bf75                	j	80004868 <fileread+0x60>
    panic("fileread");
    800048ae:	00004517          	auipc	a0,0x4
    800048b2:	e0a50513          	addi	a0,a0,-502 # 800086b8 <syscalls+0x260>
    800048b6:	ffffc097          	auipc	ra,0xffffc
    800048ba:	c88080e7          	jalr	-888(ra) # 8000053e <panic>
    return -1;
    800048be:	597d                	li	s2,-1
    800048c0:	b765                	j	80004868 <fileread+0x60>
      return -1;
    800048c2:	597d                	li	s2,-1
    800048c4:	b755                	j	80004868 <fileread+0x60>
    800048c6:	597d                	li	s2,-1
    800048c8:	b745                	j	80004868 <fileread+0x60>

00000000800048ca <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    800048ca:	715d                	addi	sp,sp,-80
    800048cc:	e486                	sd	ra,72(sp)
    800048ce:	e0a2                	sd	s0,64(sp)
    800048d0:	fc26                	sd	s1,56(sp)
    800048d2:	f84a                	sd	s2,48(sp)
    800048d4:	f44e                	sd	s3,40(sp)
    800048d6:	f052                	sd	s4,32(sp)
    800048d8:	ec56                	sd	s5,24(sp)
    800048da:	e85a                	sd	s6,16(sp)
    800048dc:	e45e                	sd	s7,8(sp)
    800048de:	e062                	sd	s8,0(sp)
    800048e0:	0880                	addi	s0,sp,80
  int r, ret = 0;

  if(f->writable == 0)
    800048e2:	00954783          	lbu	a5,9(a0)
    800048e6:	10078663          	beqz	a5,800049f2 <filewrite+0x128>
    800048ea:	892a                	mv	s2,a0
    800048ec:	8aae                	mv	s5,a1
    800048ee:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    800048f0:	411c                	lw	a5,0(a0)
    800048f2:	4705                	li	a4,1
    800048f4:	02e78263          	beq	a5,a4,80004918 <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    800048f8:	470d                	li	a4,3
    800048fa:	02e78663          	beq	a5,a4,80004926 <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    800048fe:	4709                	li	a4,2
    80004900:	0ee79163          	bne	a5,a4,800049e2 <filewrite+0x118>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80004904:	0ac05d63          	blez	a2,800049be <filewrite+0xf4>
    int i = 0;
    80004908:	4981                	li	s3,0
    8000490a:	6b05                	lui	s6,0x1
    8000490c:	c00b0b13          	addi	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    80004910:	6b85                	lui	s7,0x1
    80004912:	c00b8b9b          	addiw	s7,s7,-1024
    80004916:	a861                	j	800049ae <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    80004918:	6908                	ld	a0,16(a0)
    8000491a:	00000097          	auipc	ra,0x0
    8000491e:	22e080e7          	jalr	558(ra) # 80004b48 <pipewrite>
    80004922:	8a2a                	mv	s4,a0
    80004924:	a045                	j	800049c4 <filewrite+0xfa>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80004926:	02451783          	lh	a5,36(a0)
    8000492a:	03079693          	slli	a3,a5,0x30
    8000492e:	92c1                	srli	a3,a3,0x30
    80004930:	4725                	li	a4,9
    80004932:	0cd76263          	bltu	a4,a3,800049f6 <filewrite+0x12c>
    80004936:	0792                	slli	a5,a5,0x4
    80004938:	0001c717          	auipc	a4,0x1c
    8000493c:	28070713          	addi	a4,a4,640 # 80020bb8 <devsw>
    80004940:	97ba                	add	a5,a5,a4
    80004942:	679c                	ld	a5,8(a5)
    80004944:	cbdd                	beqz	a5,800049fa <filewrite+0x130>
    ret = devsw[f->major].write(1, addr, n);
    80004946:	4505                	li	a0,1
    80004948:	9782                	jalr	a5
    8000494a:	8a2a                	mv	s4,a0
    8000494c:	a8a5                	j	800049c4 <filewrite+0xfa>
    8000494e:	00048c1b          	sext.w	s8,s1
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    80004952:	00000097          	auipc	ra,0x0
    80004956:	8b0080e7          	jalr	-1872(ra) # 80004202 <begin_op>
      ilock(f->ip);
    8000495a:	01893503          	ld	a0,24(s2)
    8000495e:	fffff097          	auipc	ra,0xfffff
    80004962:	ee2080e7          	jalr	-286(ra) # 80003840 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80004966:	8762                	mv	a4,s8
    80004968:	02092683          	lw	a3,32(s2)
    8000496c:	01598633          	add	a2,s3,s5
    80004970:	4585                	li	a1,1
    80004972:	01893503          	ld	a0,24(s2)
    80004976:	fffff097          	auipc	ra,0xfffff
    8000497a:	276080e7          	jalr	630(ra) # 80003bec <writei>
    8000497e:	84aa                	mv	s1,a0
    80004980:	00a05763          	blez	a0,8000498e <filewrite+0xc4>
        f->off += r;
    80004984:	02092783          	lw	a5,32(s2)
    80004988:	9fa9                	addw	a5,a5,a0
    8000498a:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    8000498e:	01893503          	ld	a0,24(s2)
    80004992:	fffff097          	auipc	ra,0xfffff
    80004996:	f70080e7          	jalr	-144(ra) # 80003902 <iunlock>
      end_op();
    8000499a:	00000097          	auipc	ra,0x0
    8000499e:	8e8080e7          	jalr	-1816(ra) # 80004282 <end_op>

      if(r != n1){
    800049a2:	009c1f63          	bne	s8,s1,800049c0 <filewrite+0xf6>
        // error from writei
        break;
      }
      i += r;
    800049a6:	013489bb          	addw	s3,s1,s3
    while(i < n){
    800049aa:	0149db63          	bge	s3,s4,800049c0 <filewrite+0xf6>
      int n1 = n - i;
    800049ae:	413a07bb          	subw	a5,s4,s3
      if(n1 > max)
    800049b2:	84be                	mv	s1,a5
    800049b4:	2781                	sext.w	a5,a5
    800049b6:	f8fb5ce3          	bge	s6,a5,8000494e <filewrite+0x84>
    800049ba:	84de                	mv	s1,s7
    800049bc:	bf49                	j	8000494e <filewrite+0x84>
    int i = 0;
    800049be:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    800049c0:	013a1f63          	bne	s4,s3,800049de <filewrite+0x114>
  } else {
    panic("filewrite");
  }

  return ret;
}
    800049c4:	8552                	mv	a0,s4
    800049c6:	60a6                	ld	ra,72(sp)
    800049c8:	6406                	ld	s0,64(sp)
    800049ca:	74e2                	ld	s1,56(sp)
    800049cc:	7942                	ld	s2,48(sp)
    800049ce:	79a2                	ld	s3,40(sp)
    800049d0:	7a02                	ld	s4,32(sp)
    800049d2:	6ae2                	ld	s5,24(sp)
    800049d4:	6b42                	ld	s6,16(sp)
    800049d6:	6ba2                	ld	s7,8(sp)
    800049d8:	6c02                	ld	s8,0(sp)
    800049da:	6161                	addi	sp,sp,80
    800049dc:	8082                	ret
    ret = (i == n ? n : -1);
    800049de:	5a7d                	li	s4,-1
    800049e0:	b7d5                	j	800049c4 <filewrite+0xfa>
    panic("filewrite");
    800049e2:	00004517          	auipc	a0,0x4
    800049e6:	ce650513          	addi	a0,a0,-794 # 800086c8 <syscalls+0x270>
    800049ea:	ffffc097          	auipc	ra,0xffffc
    800049ee:	b54080e7          	jalr	-1196(ra) # 8000053e <panic>
    return -1;
    800049f2:	5a7d                	li	s4,-1
    800049f4:	bfc1                	j	800049c4 <filewrite+0xfa>
      return -1;
    800049f6:	5a7d                	li	s4,-1
    800049f8:	b7f1                	j	800049c4 <filewrite+0xfa>
    800049fa:	5a7d                	li	s4,-1
    800049fc:	b7e1                	j	800049c4 <filewrite+0xfa>

00000000800049fe <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    800049fe:	7179                	addi	sp,sp,-48
    80004a00:	f406                	sd	ra,40(sp)
    80004a02:	f022                	sd	s0,32(sp)
    80004a04:	ec26                	sd	s1,24(sp)
    80004a06:	e84a                	sd	s2,16(sp)
    80004a08:	e44e                	sd	s3,8(sp)
    80004a0a:	e052                	sd	s4,0(sp)
    80004a0c:	1800                	addi	s0,sp,48
    80004a0e:	84aa                	mv	s1,a0
    80004a10:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80004a12:	0005b023          	sd	zero,0(a1)
    80004a16:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80004a1a:	00000097          	auipc	ra,0x0
    80004a1e:	bf8080e7          	jalr	-1032(ra) # 80004612 <filealloc>
    80004a22:	e088                	sd	a0,0(s1)
    80004a24:	c551                	beqz	a0,80004ab0 <pipealloc+0xb2>
    80004a26:	00000097          	auipc	ra,0x0
    80004a2a:	bec080e7          	jalr	-1044(ra) # 80004612 <filealloc>
    80004a2e:	00aa3023          	sd	a0,0(s4)
    80004a32:	c92d                	beqz	a0,80004aa4 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80004a34:	ffffc097          	auipc	ra,0xffffc
    80004a38:	0b2080e7          	jalr	178(ra) # 80000ae6 <kalloc>
    80004a3c:	892a                	mv	s2,a0
    80004a3e:	c125                	beqz	a0,80004a9e <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80004a40:	4985                	li	s3,1
    80004a42:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80004a46:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80004a4a:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80004a4e:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80004a52:	00004597          	auipc	a1,0x4
    80004a56:	c8658593          	addi	a1,a1,-890 # 800086d8 <syscalls+0x280>
    80004a5a:	ffffc097          	auipc	ra,0xffffc
    80004a5e:	0ec080e7          	jalr	236(ra) # 80000b46 <initlock>
  (*f0)->type = FD_PIPE;
    80004a62:	609c                	ld	a5,0(s1)
    80004a64:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80004a68:	609c                	ld	a5,0(s1)
    80004a6a:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80004a6e:	609c                	ld	a5,0(s1)
    80004a70:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80004a74:	609c                	ld	a5,0(s1)
    80004a76:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80004a7a:	000a3783          	ld	a5,0(s4)
    80004a7e:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80004a82:	000a3783          	ld	a5,0(s4)
    80004a86:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80004a8a:	000a3783          	ld	a5,0(s4)
    80004a8e:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80004a92:	000a3783          	ld	a5,0(s4)
    80004a96:	0127b823          	sd	s2,16(a5)
  return 0;
    80004a9a:	4501                	li	a0,0
    80004a9c:	a025                	j	80004ac4 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80004a9e:	6088                	ld	a0,0(s1)
    80004aa0:	e501                	bnez	a0,80004aa8 <pipealloc+0xaa>
    80004aa2:	a039                	j	80004ab0 <pipealloc+0xb2>
    80004aa4:	6088                	ld	a0,0(s1)
    80004aa6:	c51d                	beqz	a0,80004ad4 <pipealloc+0xd6>
    fileclose(*f0);
    80004aa8:	00000097          	auipc	ra,0x0
    80004aac:	c26080e7          	jalr	-986(ra) # 800046ce <fileclose>
  if(*f1)
    80004ab0:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80004ab4:	557d                	li	a0,-1
  if(*f1)
    80004ab6:	c799                	beqz	a5,80004ac4 <pipealloc+0xc6>
    fileclose(*f1);
    80004ab8:	853e                	mv	a0,a5
    80004aba:	00000097          	auipc	ra,0x0
    80004abe:	c14080e7          	jalr	-1004(ra) # 800046ce <fileclose>
  return -1;
    80004ac2:	557d                	li	a0,-1
}
    80004ac4:	70a2                	ld	ra,40(sp)
    80004ac6:	7402                	ld	s0,32(sp)
    80004ac8:	64e2                	ld	s1,24(sp)
    80004aca:	6942                	ld	s2,16(sp)
    80004acc:	69a2                	ld	s3,8(sp)
    80004ace:	6a02                	ld	s4,0(sp)
    80004ad0:	6145                	addi	sp,sp,48
    80004ad2:	8082                	ret
  return -1;
    80004ad4:	557d                	li	a0,-1
    80004ad6:	b7fd                	j	80004ac4 <pipealloc+0xc6>

0000000080004ad8 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80004ad8:	1101                	addi	sp,sp,-32
    80004ada:	ec06                	sd	ra,24(sp)
    80004adc:	e822                	sd	s0,16(sp)
    80004ade:	e426                	sd	s1,8(sp)
    80004ae0:	e04a                	sd	s2,0(sp)
    80004ae2:	1000                	addi	s0,sp,32
    80004ae4:	84aa                	mv	s1,a0
    80004ae6:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80004ae8:	ffffc097          	auipc	ra,0xffffc
    80004aec:	0ee080e7          	jalr	238(ra) # 80000bd6 <acquire>
  if(writable){
    80004af0:	02090d63          	beqz	s2,80004b2a <pipeclose+0x52>
    pi->writeopen = 0;
    80004af4:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80004af8:	21848513          	addi	a0,s1,536
    80004afc:	ffffd097          	auipc	ra,0xffffd
    80004b00:	5bc080e7          	jalr	1468(ra) # 800020b8 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80004b04:	2204b783          	ld	a5,544(s1)
    80004b08:	eb95                	bnez	a5,80004b3c <pipeclose+0x64>
    release(&pi->lock);
    80004b0a:	8526                	mv	a0,s1
    80004b0c:	ffffc097          	auipc	ra,0xffffc
    80004b10:	17e080e7          	jalr	382(ra) # 80000c8a <release>
    kfree((char*)pi);
    80004b14:	8526                	mv	a0,s1
    80004b16:	ffffc097          	auipc	ra,0xffffc
    80004b1a:	ed4080e7          	jalr	-300(ra) # 800009ea <kfree>
  } else
    release(&pi->lock);
}
    80004b1e:	60e2                	ld	ra,24(sp)
    80004b20:	6442                	ld	s0,16(sp)
    80004b22:	64a2                	ld	s1,8(sp)
    80004b24:	6902                	ld	s2,0(sp)
    80004b26:	6105                	addi	sp,sp,32
    80004b28:	8082                	ret
    pi->readopen = 0;
    80004b2a:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80004b2e:	21c48513          	addi	a0,s1,540
    80004b32:	ffffd097          	auipc	ra,0xffffd
    80004b36:	586080e7          	jalr	1414(ra) # 800020b8 <wakeup>
    80004b3a:	b7e9                	j	80004b04 <pipeclose+0x2c>
    release(&pi->lock);
    80004b3c:	8526                	mv	a0,s1
    80004b3e:	ffffc097          	auipc	ra,0xffffc
    80004b42:	14c080e7          	jalr	332(ra) # 80000c8a <release>
}
    80004b46:	bfe1                	j	80004b1e <pipeclose+0x46>

0000000080004b48 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80004b48:	711d                	addi	sp,sp,-96
    80004b4a:	ec86                	sd	ra,88(sp)
    80004b4c:	e8a2                	sd	s0,80(sp)
    80004b4e:	e4a6                	sd	s1,72(sp)
    80004b50:	e0ca                	sd	s2,64(sp)
    80004b52:	fc4e                	sd	s3,56(sp)
    80004b54:	f852                	sd	s4,48(sp)
    80004b56:	f456                	sd	s5,40(sp)
    80004b58:	f05a                	sd	s6,32(sp)
    80004b5a:	ec5e                	sd	s7,24(sp)
    80004b5c:	e862                	sd	s8,16(sp)
    80004b5e:	1080                	addi	s0,sp,96
    80004b60:	84aa                	mv	s1,a0
    80004b62:	8aae                	mv	s5,a1
    80004b64:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80004b66:	ffffd097          	auipc	ra,0xffffd
    80004b6a:	e46080e7          	jalr	-442(ra) # 800019ac <myproc>
    80004b6e:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80004b70:	8526                	mv	a0,s1
    80004b72:	ffffc097          	auipc	ra,0xffffc
    80004b76:	064080e7          	jalr	100(ra) # 80000bd6 <acquire>
  while(i < n){
    80004b7a:	0b405663          	blez	s4,80004c26 <pipewrite+0xde>
  int i = 0;
    80004b7e:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pigtable, &ch, addr + i, 1) == -1)
    80004b80:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80004b82:	21848c13          	addi	s8,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80004b86:	21c48b93          	addi	s7,s1,540
    80004b8a:	a089                	j	80004bcc <pipewrite+0x84>
      release(&pi->lock);
    80004b8c:	8526                	mv	a0,s1
    80004b8e:	ffffc097          	auipc	ra,0xffffc
    80004b92:	0fc080e7          	jalr	252(ra) # 80000c8a <release>
      return -1;
    80004b96:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80004b98:	854a                	mv	a0,s2
    80004b9a:	60e6                	ld	ra,88(sp)
    80004b9c:	6446                	ld	s0,80(sp)
    80004b9e:	64a6                	ld	s1,72(sp)
    80004ba0:	6906                	ld	s2,64(sp)
    80004ba2:	79e2                	ld	s3,56(sp)
    80004ba4:	7a42                	ld	s4,48(sp)
    80004ba6:	7aa2                	ld	s5,40(sp)
    80004ba8:	7b02                	ld	s6,32(sp)
    80004baa:	6be2                	ld	s7,24(sp)
    80004bac:	6c42                	ld	s8,16(sp)
    80004bae:	6125                	addi	sp,sp,96
    80004bb0:	8082                	ret
      wakeup(&pi->nread);
    80004bb2:	8562                	mv	a0,s8
    80004bb4:	ffffd097          	auipc	ra,0xffffd
    80004bb8:	504080e7          	jalr	1284(ra) # 800020b8 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80004bbc:	85a6                	mv	a1,s1
    80004bbe:	855e                	mv	a0,s7
    80004bc0:	ffffd097          	auipc	ra,0xffffd
    80004bc4:	494080e7          	jalr	1172(ra) # 80002054 <sleep>
  while(i < n){
    80004bc8:	07495063          	bge	s2,s4,80004c28 <pipewrite+0xe0>
    if(pi->readopen == 0 || killed(pr)){
    80004bcc:	2204a783          	lw	a5,544(s1)
    80004bd0:	dfd5                	beqz	a5,80004b8c <pipewrite+0x44>
    80004bd2:	854e                	mv	a0,s3
    80004bd4:	ffffe097          	auipc	ra,0xffffe
    80004bd8:	912080e7          	jalr	-1774(ra) # 800024e6 <killed>
    80004bdc:	f945                	bnez	a0,80004b8c <pipewrite+0x44>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80004bde:	2184a783          	lw	a5,536(s1)
    80004be2:	21c4a703          	lw	a4,540(s1)
    80004be6:	2007879b          	addiw	a5,a5,512
    80004bea:	fcf704e3          	beq	a4,a5,80004bb2 <pipewrite+0x6a>
      if(copyin(pr->pigtable, &ch, addr + i, 1) == -1)
    80004bee:	4685                	li	a3,1
    80004bf0:	01590633          	add	a2,s2,s5
    80004bf4:	faf40593          	addi	a1,s0,-81
    80004bf8:	0509b503          	ld	a0,80(s3)
    80004bfc:	ffffd097          	auipc	ra,0xffffd
    80004c00:	af8080e7          	jalr	-1288(ra) # 800016f4 <copyin>
    80004c04:	03650263          	beq	a0,s6,80004c28 <pipewrite+0xe0>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80004c08:	21c4a783          	lw	a5,540(s1)
    80004c0c:	0017871b          	addiw	a4,a5,1
    80004c10:	20e4ae23          	sw	a4,540(s1)
    80004c14:	1ff7f793          	andi	a5,a5,511
    80004c18:	97a6                	add	a5,a5,s1
    80004c1a:	faf44703          	lbu	a4,-81(s0)
    80004c1e:	00e78c23          	sb	a4,24(a5)
      i++;
    80004c22:	2905                	addiw	s2,s2,1
    80004c24:	b755                	j	80004bc8 <pipewrite+0x80>
  int i = 0;
    80004c26:	4901                	li	s2,0
  wakeup(&pi->nread);
    80004c28:	21848513          	addi	a0,s1,536
    80004c2c:	ffffd097          	auipc	ra,0xffffd
    80004c30:	48c080e7          	jalr	1164(ra) # 800020b8 <wakeup>
  release(&pi->lock);
    80004c34:	8526                	mv	a0,s1
    80004c36:	ffffc097          	auipc	ra,0xffffc
    80004c3a:	054080e7          	jalr	84(ra) # 80000c8a <release>
  return i;
    80004c3e:	bfa9                	j	80004b98 <pipewrite+0x50>

0000000080004c40 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80004c40:	715d                	addi	sp,sp,-80
    80004c42:	e486                	sd	ra,72(sp)
    80004c44:	e0a2                	sd	s0,64(sp)
    80004c46:	fc26                	sd	s1,56(sp)
    80004c48:	f84a                	sd	s2,48(sp)
    80004c4a:	f44e                	sd	s3,40(sp)
    80004c4c:	f052                	sd	s4,32(sp)
    80004c4e:	ec56                	sd	s5,24(sp)
    80004c50:	e85a                	sd	s6,16(sp)
    80004c52:	0880                	addi	s0,sp,80
    80004c54:	84aa                	mv	s1,a0
    80004c56:	892e                	mv	s2,a1
    80004c58:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80004c5a:	ffffd097          	auipc	ra,0xffffd
    80004c5e:	d52080e7          	jalr	-686(ra) # 800019ac <myproc>
    80004c62:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80004c64:	8526                	mv	a0,s1
    80004c66:	ffffc097          	auipc	ra,0xffffc
    80004c6a:	f70080e7          	jalr	-144(ra) # 80000bd6 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004c6e:	2184a703          	lw	a4,536(s1)
    80004c72:	21c4a783          	lw	a5,540(s1)
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004c76:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004c7a:	02f71763          	bne	a4,a5,80004ca8 <piperead+0x68>
    80004c7e:	2244a783          	lw	a5,548(s1)
    80004c82:	c39d                	beqz	a5,80004ca8 <piperead+0x68>
    if(killed(pr)){
    80004c84:	8552                	mv	a0,s4
    80004c86:	ffffe097          	auipc	ra,0xffffe
    80004c8a:	860080e7          	jalr	-1952(ra) # 800024e6 <killed>
    80004c8e:	e941                	bnez	a0,80004d1e <piperead+0xde>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004c90:	85a6                	mv	a1,s1
    80004c92:	854e                	mv	a0,s3
    80004c94:	ffffd097          	auipc	ra,0xffffd
    80004c98:	3c0080e7          	jalr	960(ra) # 80002054 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004c9c:	2184a703          	lw	a4,536(s1)
    80004ca0:	21c4a783          	lw	a5,540(s1)
    80004ca4:	fcf70de3          	beq	a4,a5,80004c7e <piperead+0x3e>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004ca8:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pigtable, addr + i, &ch, 1) == -1)
    80004caa:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004cac:	05505363          	blez	s5,80004cf2 <piperead+0xb2>
    if(pi->nread == pi->nwrite)
    80004cb0:	2184a783          	lw	a5,536(s1)
    80004cb4:	21c4a703          	lw	a4,540(s1)
    80004cb8:	02f70d63          	beq	a4,a5,80004cf2 <piperead+0xb2>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80004cbc:	0017871b          	addiw	a4,a5,1
    80004cc0:	20e4ac23          	sw	a4,536(s1)
    80004cc4:	1ff7f793          	andi	a5,a5,511
    80004cc8:	97a6                	add	a5,a5,s1
    80004cca:	0187c783          	lbu	a5,24(a5)
    80004cce:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pigtable, addr + i, &ch, 1) == -1)
    80004cd2:	4685                	li	a3,1
    80004cd4:	fbf40613          	addi	a2,s0,-65
    80004cd8:	85ca                	mv	a1,s2
    80004cda:	050a3503          	ld	a0,80(s4)
    80004cde:	ffffd097          	auipc	ra,0xffffd
    80004ce2:	98a080e7          	jalr	-1654(ra) # 80001668 <copyout>
    80004ce6:	01650663          	beq	a0,s6,80004cf2 <piperead+0xb2>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004cea:	2985                	addiw	s3,s3,1
    80004cec:	0905                	addi	s2,s2,1
    80004cee:	fd3a91e3          	bne	s5,s3,80004cb0 <piperead+0x70>
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80004cf2:	21c48513          	addi	a0,s1,540
    80004cf6:	ffffd097          	auipc	ra,0xffffd
    80004cfa:	3c2080e7          	jalr	962(ra) # 800020b8 <wakeup>
  release(&pi->lock);
    80004cfe:	8526                	mv	a0,s1
    80004d00:	ffffc097          	auipc	ra,0xffffc
    80004d04:	f8a080e7          	jalr	-118(ra) # 80000c8a <release>
  return i;
}
    80004d08:	854e                	mv	a0,s3
    80004d0a:	60a6                	ld	ra,72(sp)
    80004d0c:	6406                	ld	s0,64(sp)
    80004d0e:	74e2                	ld	s1,56(sp)
    80004d10:	7942                	ld	s2,48(sp)
    80004d12:	79a2                	ld	s3,40(sp)
    80004d14:	7a02                	ld	s4,32(sp)
    80004d16:	6ae2                	ld	s5,24(sp)
    80004d18:	6b42                	ld	s6,16(sp)
    80004d1a:	6161                	addi	sp,sp,80
    80004d1c:	8082                	ret
      release(&pi->lock);
    80004d1e:	8526                	mv	a0,s1
    80004d20:	ffffc097          	auipc	ra,0xffffc
    80004d24:	f6a080e7          	jalr	-150(ra) # 80000c8a <release>
      return -1;
    80004d28:	59fd                	li	s3,-1
    80004d2a:	bff9                	j	80004d08 <piperead+0xc8>

0000000080004d2c <flags2perm>:
#include "elf.h"

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int flags2perm(int flags)
{
    80004d2c:	1141                	addi	sp,sp,-16
    80004d2e:	e422                	sd	s0,8(sp)
    80004d30:	0800                	addi	s0,sp,16
    80004d32:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    80004d34:	8905                	andi	a0,a0,1
    80004d36:	c111                	beqz	a0,80004d3a <flags2perm+0xe>
      perm = PTE_X;
    80004d38:	4521                	li	a0,8
    if(flags & 0x2)
    80004d3a:	8b89                	andi	a5,a5,2
    80004d3c:	c399                	beqz	a5,80004d42 <flags2perm+0x16>
      perm |= PTE_W;
    80004d3e:	00456513          	ori	a0,a0,4
    return perm;
}
    80004d42:	6422                	ld	s0,8(sp)
    80004d44:	0141                	addi	sp,sp,16
    80004d46:	8082                	ret

0000000080004d48 <exec>:

int
exec(char *path, char **argv)
{
    80004d48:	de010113          	addi	sp,sp,-544
    80004d4c:	20113c23          	sd	ra,536(sp)
    80004d50:	20813823          	sd	s0,528(sp)
    80004d54:	20913423          	sd	s1,520(sp)
    80004d58:	21213023          	sd	s2,512(sp)
    80004d5c:	ffce                	sd	s3,504(sp)
    80004d5e:	fbd2                	sd	s4,496(sp)
    80004d60:	f7d6                	sd	s5,488(sp)
    80004d62:	f3da                	sd	s6,480(sp)
    80004d64:	efde                	sd	s7,472(sp)
    80004d66:	ebe2                	sd	s8,464(sp)
    80004d68:	e7e6                	sd	s9,456(sp)
    80004d6a:	e3ea                	sd	s10,448(sp)
    80004d6c:	ff6e                	sd	s11,440(sp)
    80004d6e:	1400                	addi	s0,sp,544
    80004d70:	892a                	mv	s2,a0
    80004d72:	dea43423          	sd	a0,-536(s0)
    80004d76:	deb43823          	sd	a1,-528(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pigtable_t pigtable = 0, oldpigtable;
  struct proc *p = myproc();
    80004d7a:	ffffd097          	auipc	ra,0xffffd
    80004d7e:	c32080e7          	jalr	-974(ra) # 800019ac <myproc>
    80004d82:	84aa                	mv	s1,a0

  begin_op();
    80004d84:	fffff097          	auipc	ra,0xfffff
    80004d88:	47e080e7          	jalr	1150(ra) # 80004202 <begin_op>

  if((ip = namei(path)) == 0){
    80004d8c:	854a                	mv	a0,s2
    80004d8e:	fffff097          	auipc	ra,0xfffff
    80004d92:	258080e7          	jalr	600(ra) # 80003fe6 <namei>
    80004d96:	c93d                	beqz	a0,80004e0c <exec+0xc4>
    80004d98:	8aaa                	mv	s5,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80004d9a:	fffff097          	auipc	ra,0xfffff
    80004d9e:	aa6080e7          	jalr	-1370(ra) # 80003840 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80004da2:	04000713          	li	a4,64
    80004da6:	4681                	li	a3,0
    80004da8:	e5040613          	addi	a2,s0,-432
    80004dac:	4581                	li	a1,0
    80004dae:	8556                	mv	a0,s5
    80004db0:	fffff097          	auipc	ra,0xfffff
    80004db4:	d44080e7          	jalr	-700(ra) # 80003af4 <readi>
    80004db8:	04000793          	li	a5,64
    80004dbc:	00f51a63          	bne	a0,a5,80004dd0 <exec+0x88>
    goto bad;

  if(elf.magic != ELF_MAGIC)
    80004dc0:	e5042703          	lw	a4,-432(s0)
    80004dc4:	464c47b7          	lui	a5,0x464c4
    80004dc8:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80004dcc:	04f70663          	beq	a4,a5,80004e18 <exec+0xd0>

 bad:
  if(pigtable)
    proc_freepigtable(pigtable, sz);
  if(ip){
    iunlockput(ip);
    80004dd0:	8556                	mv	a0,s5
    80004dd2:	fffff097          	auipc	ra,0xfffff
    80004dd6:	cd0080e7          	jalr	-816(ra) # 80003aa2 <iunlockput>
    end_op();
    80004dda:	fffff097          	auipc	ra,0xfffff
    80004dde:	4a8080e7          	jalr	1192(ra) # 80004282 <end_op>
  }
  return -1;
    80004de2:	557d                	li	a0,-1
}
    80004de4:	21813083          	ld	ra,536(sp)
    80004de8:	21013403          	ld	s0,528(sp)
    80004dec:	20813483          	ld	s1,520(sp)
    80004df0:	20013903          	ld	s2,512(sp)
    80004df4:	79fe                	ld	s3,504(sp)
    80004df6:	7a5e                	ld	s4,496(sp)
    80004df8:	7abe                	ld	s5,488(sp)
    80004dfa:	7b1e                	ld	s6,480(sp)
    80004dfc:	6bfe                	ld	s7,472(sp)
    80004dfe:	6c5e                	ld	s8,464(sp)
    80004e00:	6cbe                	ld	s9,456(sp)
    80004e02:	6d1e                	ld	s10,448(sp)
    80004e04:	7dfa                	ld	s11,440(sp)
    80004e06:	22010113          	addi	sp,sp,544
    80004e0a:	8082                	ret
    end_op();
    80004e0c:	fffff097          	auipc	ra,0xfffff
    80004e10:	476080e7          	jalr	1142(ra) # 80004282 <end_op>
    return -1;
    80004e14:	557d                	li	a0,-1
    80004e16:	b7f9                	j	80004de4 <exec+0x9c>
  if((pigtable = proc_pigtable(p)) == 0)
    80004e18:	8526                	mv	a0,s1
    80004e1a:	ffffd097          	auipc	ra,0xffffd
    80004e1e:	c56080e7          	jalr	-938(ra) # 80001a70 <proc_pigtable>
    80004e22:	8b2a                	mv	s6,a0
    80004e24:	d555                	beqz	a0,80004dd0 <exec+0x88>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004e26:	e7042783          	lw	a5,-400(s0)
    80004e2a:	e8845703          	lhu	a4,-376(s0)
    80004e2e:	c735                	beqz	a4,80004e9a <exec+0x152>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004e30:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004e32:	e0043423          	sd	zero,-504(s0)
    if(ph.vaddr % PIGSIZE != 0)
    80004e36:	6a05                	lui	s4,0x1
    80004e38:	fffa0713          	addi	a4,s4,-1 # fff <_entry-0x7ffff001>
    80004e3c:	dee43023          	sd	a4,-544(s0)
loadseg(pigtable_t pigtable, uint64 va, struct inode *ip, uint offset, uint sz)
{
  uint i, n;
  uint64 pa;

  for(i = 0; i < sz; i += PIGSIZE){
    80004e40:	6d85                	lui	s11,0x1
    80004e42:	7d7d                	lui	s10,0xfffff
    80004e44:	a481                	j	80005084 <exec+0x33c>
    pa = walkaddr(pigtable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    80004e46:	00004517          	auipc	a0,0x4
    80004e4a:	89a50513          	addi	a0,a0,-1894 # 800086e0 <syscalls+0x288>
    80004e4e:	ffffb097          	auipc	ra,0xffffb
    80004e52:	6f0080e7          	jalr	1776(ra) # 8000053e <panic>
    if(sz - i < PIGSIZE)
      n = sz - i;
    else
      n = PIGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80004e56:	874a                	mv	a4,s2
    80004e58:	009c86bb          	addw	a3,s9,s1
    80004e5c:	4581                	li	a1,0
    80004e5e:	8556                	mv	a0,s5
    80004e60:	fffff097          	auipc	ra,0xfffff
    80004e64:	c94080e7          	jalr	-876(ra) # 80003af4 <readi>
    80004e68:	2501                	sext.w	a0,a0
    80004e6a:	1aa91a63          	bne	s2,a0,8000501e <exec+0x2d6>
  for(i = 0; i < sz; i += PIGSIZE){
    80004e6e:	009d84bb          	addw	s1,s11,s1
    80004e72:	013d09bb          	addw	s3,s10,s3
    80004e76:	1f74f763          	bgeu	s1,s7,80005064 <exec+0x31c>
    pa = walkaddr(pigtable, va + i);
    80004e7a:	02049593          	slli	a1,s1,0x20
    80004e7e:	9181                	srli	a1,a1,0x20
    80004e80:	95e2                	add	a1,a1,s8
    80004e82:	855a                	mv	a0,s6
    80004e84:	ffffc097          	auipc	ra,0xffffc
    80004e88:	1d8080e7          	jalr	472(ra) # 8000105c <walkaddr>
    80004e8c:	862a                	mv	a2,a0
    if(pa == 0)
    80004e8e:	dd45                	beqz	a0,80004e46 <exec+0xfe>
      n = PIGSIZE;
    80004e90:	8952                	mv	s2,s4
    if(sz - i < PIGSIZE)
    80004e92:	fd49f2e3          	bgeu	s3,s4,80004e56 <exec+0x10e>
      n = sz - i;
    80004e96:	894e                	mv	s2,s3
    80004e98:	bf7d                	j	80004e56 <exec+0x10e>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004e9a:	4901                	li	s2,0
  iunlockput(ip);
    80004e9c:	8556                	mv	a0,s5
    80004e9e:	fffff097          	auipc	ra,0xfffff
    80004ea2:	c04080e7          	jalr	-1020(ra) # 80003aa2 <iunlockput>
  end_op();
    80004ea6:	fffff097          	auipc	ra,0xfffff
    80004eaa:	3dc080e7          	jalr	988(ra) # 80004282 <end_op>
  p = myproc();
    80004eae:	ffffd097          	auipc	ra,0xffffd
    80004eb2:	afe080e7          	jalr	-1282(ra) # 800019ac <myproc>
    80004eb6:	8baa                	mv	s7,a0
  uint64 oldsz = p->sz;
    80004eb8:	04853d03          	ld	s10,72(a0)
  sz = PIGROUNDUP(sz);
    80004ebc:	6785                	lui	a5,0x1
    80004ebe:	17fd                	addi	a5,a5,-1
    80004ec0:	993e                	add	s2,s2,a5
    80004ec2:	77fd                	lui	a5,0xfffff
    80004ec4:	00f977b3          	and	a5,s2,a5
    80004ec8:	def43c23          	sd	a5,-520(s0)
  if((sz1 = uvmalloc(pigtable, sz, sz + 2*PIGSIZE, PTE_W)) == 0)
    80004ecc:	4691                	li	a3,4
    80004ece:	6609                	lui	a2,0x2
    80004ed0:	963e                	add	a2,a2,a5
    80004ed2:	85be                	mv	a1,a5
    80004ed4:	855a                	mv	a0,s6
    80004ed6:	ffffc097          	auipc	ra,0xffffc
    80004eda:	53a080e7          	jalr	1338(ra) # 80001410 <uvmalloc>
    80004ede:	8c2a                	mv	s8,a0
  ip = 0;
    80004ee0:	4a81                	li	s5,0
  if((sz1 = uvmalloc(pigtable, sz, sz + 2*PIGSIZE, PTE_W)) == 0)
    80004ee2:	12050e63          	beqz	a0,8000501e <exec+0x2d6>
  uvmclear(pigtable, sz-2*PIGSIZE);
    80004ee6:	75f9                	lui	a1,0xffffe
    80004ee8:	95aa                	add	a1,a1,a0
    80004eea:	855a                	mv	a0,s6
    80004eec:	ffffc097          	auipc	ra,0xffffc
    80004ef0:	74a080e7          	jalr	1866(ra) # 80001636 <uvmclear>
  stackbase = sp - PIGSIZE;
    80004ef4:	7afd                	lui	s5,0xfffff
    80004ef6:	9ae2                	add	s5,s5,s8
  for(argc = 0; argv[argc]; argc++) {
    80004ef8:	df043783          	ld	a5,-528(s0)
    80004efc:	6388                	ld	a0,0(a5)
    80004efe:	c925                	beqz	a0,80004f6e <exec+0x226>
    80004f00:	e9040993          	addi	s3,s0,-368
    80004f04:	f9040c93          	addi	s9,s0,-112
  sp = sz;
    80004f08:	8962                	mv	s2,s8
  for(argc = 0; argv[argc]; argc++) {
    80004f0a:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    80004f0c:	ffffc097          	auipc	ra,0xffffc
    80004f10:	f42080e7          	jalr	-190(ra) # 80000e4e <strlen>
    80004f14:	0015079b          	addiw	a5,a0,1
    80004f18:	40f90933          	sub	s2,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80004f1c:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    80004f20:	13596663          	bltu	s2,s5,8000504c <exec+0x304>
    if(copyout(pigtable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80004f24:	df043d83          	ld	s11,-528(s0)
    80004f28:	000dba03          	ld	s4,0(s11) # 1000 <_entry-0x7ffff000>
    80004f2c:	8552                	mv	a0,s4
    80004f2e:	ffffc097          	auipc	ra,0xffffc
    80004f32:	f20080e7          	jalr	-224(ra) # 80000e4e <strlen>
    80004f36:	0015069b          	addiw	a3,a0,1
    80004f3a:	8652                	mv	a2,s4
    80004f3c:	85ca                	mv	a1,s2
    80004f3e:	855a                	mv	a0,s6
    80004f40:	ffffc097          	auipc	ra,0xffffc
    80004f44:	728080e7          	jalr	1832(ra) # 80001668 <copyout>
    80004f48:	10054663          	bltz	a0,80005054 <exec+0x30c>
    ustack[argc] = sp;
    80004f4c:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    80004f50:	0485                	addi	s1,s1,1
    80004f52:	008d8793          	addi	a5,s11,8
    80004f56:	def43823          	sd	a5,-528(s0)
    80004f5a:	008db503          	ld	a0,8(s11)
    80004f5e:	c911                	beqz	a0,80004f72 <exec+0x22a>
    if(argc >= MAXARG)
    80004f60:	09a1                	addi	s3,s3,8
    80004f62:	fb3c95e3          	bne	s9,s3,80004f0c <exec+0x1c4>
  sz = sz1;
    80004f66:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004f6a:	4a81                	li	s5,0
    80004f6c:	a84d                	j	8000501e <exec+0x2d6>
  sp = sz;
    80004f6e:	8962                	mv	s2,s8
  for(argc = 0; argv[argc]; argc++) {
    80004f70:	4481                	li	s1,0
  ustack[argc] = 0;
    80004f72:	00349793          	slli	a5,s1,0x3
    80004f76:	f9040713          	addi	a4,s0,-112
    80004f7a:	97ba                	add	a5,a5,a4
    80004f7c:	f007b023          	sd	zero,-256(a5) # ffffffffffffef00 <end+0xffffffff7ffdd1b0>
  sp -= (argc+1) * sizeof(uint64);
    80004f80:	00148693          	addi	a3,s1,1
    80004f84:	068e                	slli	a3,a3,0x3
    80004f86:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80004f8a:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    80004f8e:	01597663          	bgeu	s2,s5,80004f9a <exec+0x252>
  sz = sz1;
    80004f92:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004f96:	4a81                	li	s5,0
    80004f98:	a059                	j	8000501e <exec+0x2d6>
  if(copyout(pigtable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80004f9a:	e9040613          	addi	a2,s0,-368
    80004f9e:	85ca                	mv	a1,s2
    80004fa0:	855a                	mv	a0,s6
    80004fa2:	ffffc097          	auipc	ra,0xffffc
    80004fa6:	6c6080e7          	jalr	1734(ra) # 80001668 <copyout>
    80004faa:	0a054963          	bltz	a0,8000505c <exec+0x314>
  p->trapframe->a1 = sp;
    80004fae:	058bb783          	ld	a5,88(s7) # 1058 <_entry-0x7fffefa8>
    80004fb2:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80004fb6:	de843783          	ld	a5,-536(s0)
    80004fba:	0007c703          	lbu	a4,0(a5)
    80004fbe:	cf11                	beqz	a4,80004fda <exec+0x292>
    80004fc0:	0785                	addi	a5,a5,1
    if(*s == '/')
    80004fc2:	02f00693          	li	a3,47
    80004fc6:	a039                	j	80004fd4 <exec+0x28c>
      last = s+1;
    80004fc8:	def43423          	sd	a5,-536(s0)
  for(last=s=path; *s; s++)
    80004fcc:	0785                	addi	a5,a5,1
    80004fce:	fff7c703          	lbu	a4,-1(a5)
    80004fd2:	c701                	beqz	a4,80004fda <exec+0x292>
    if(*s == '/')
    80004fd4:	fed71ce3          	bne	a4,a3,80004fcc <exec+0x284>
    80004fd8:	bfc5                	j	80004fc8 <exec+0x280>
  safestrcpy(p->name, last, sizeof(p->name));
    80004fda:	4641                	li	a2,16
    80004fdc:	de843583          	ld	a1,-536(s0)
    80004fe0:	158b8513          	addi	a0,s7,344
    80004fe4:	ffffc097          	auipc	ra,0xffffc
    80004fe8:	e38080e7          	jalr	-456(ra) # 80000e1c <safestrcpy>
  oldpigtable = p->pigtable;
    80004fec:	050bb503          	ld	a0,80(s7)
  p->pigtable = pigtable;
    80004ff0:	056bb823          	sd	s6,80(s7)
  p->sz = sz;
    80004ff4:	058bb423          	sd	s8,72(s7)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80004ff8:	058bb783          	ld	a5,88(s7)
    80004ffc:	e6843703          	ld	a4,-408(s0)
    80005000:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80005002:	058bb783          	ld	a5,88(s7)
    80005006:	0327b823          	sd	s2,48(a5)
  proc_freepigtable(oldpigtable, oldsz);
    8000500a:	85ea                	mv	a1,s10
    8000500c:	ffffd097          	auipc	ra,0xffffd
    80005010:	b00080e7          	jalr	-1280(ra) # 80001b0c <proc_freepigtable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80005014:	0004851b          	sext.w	a0,s1
    80005018:	b3f1                	j	80004de4 <exec+0x9c>
    8000501a:	df243c23          	sd	s2,-520(s0)
    proc_freepigtable(pigtable, sz);
    8000501e:	df843583          	ld	a1,-520(s0)
    80005022:	855a                	mv	a0,s6
    80005024:	ffffd097          	auipc	ra,0xffffd
    80005028:	ae8080e7          	jalr	-1304(ra) # 80001b0c <proc_freepigtable>
  if(ip){
    8000502c:	da0a92e3          	bnez	s5,80004dd0 <exec+0x88>
  return -1;
    80005030:	557d                	li	a0,-1
    80005032:	bb4d                	j	80004de4 <exec+0x9c>
    80005034:	df243c23          	sd	s2,-520(s0)
    80005038:	b7dd                	j	8000501e <exec+0x2d6>
    8000503a:	df243c23          	sd	s2,-520(s0)
    8000503e:	b7c5                	j	8000501e <exec+0x2d6>
    80005040:	df243c23          	sd	s2,-520(s0)
    80005044:	bfe9                	j	8000501e <exec+0x2d6>
    80005046:	df243c23          	sd	s2,-520(s0)
    8000504a:	bfd1                	j	8000501e <exec+0x2d6>
  sz = sz1;
    8000504c:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80005050:	4a81                	li	s5,0
    80005052:	b7f1                	j	8000501e <exec+0x2d6>
  sz = sz1;
    80005054:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80005058:	4a81                	li	s5,0
    8000505a:	b7d1                	j	8000501e <exec+0x2d6>
  sz = sz1;
    8000505c:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80005060:	4a81                	li	s5,0
    80005062:	bf75                	j	8000501e <exec+0x2d6>
    if((sz1 = uvmalloc(pigtable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80005064:	df843903          	ld	s2,-520(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80005068:	e0843783          	ld	a5,-504(s0)
    8000506c:	0017869b          	addiw	a3,a5,1
    80005070:	e0d43423          	sd	a3,-504(s0)
    80005074:	e0043783          	ld	a5,-512(s0)
    80005078:	0387879b          	addiw	a5,a5,56
    8000507c:	e8845703          	lhu	a4,-376(s0)
    80005080:	e0e6dee3          	bge	a3,a4,80004e9c <exec+0x154>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80005084:	2781                	sext.w	a5,a5
    80005086:	e0f43023          	sd	a5,-512(s0)
    8000508a:	03800713          	li	a4,56
    8000508e:	86be                	mv	a3,a5
    80005090:	e1840613          	addi	a2,s0,-488
    80005094:	4581                	li	a1,0
    80005096:	8556                	mv	a0,s5
    80005098:	fffff097          	auipc	ra,0xfffff
    8000509c:	a5c080e7          	jalr	-1444(ra) # 80003af4 <readi>
    800050a0:	03800793          	li	a5,56
    800050a4:	f6f51be3          	bne	a0,a5,8000501a <exec+0x2d2>
    if(ph.type != ELF_PROG_LOAD)
    800050a8:	e1842783          	lw	a5,-488(s0)
    800050ac:	4705                	li	a4,1
    800050ae:	fae79de3          	bne	a5,a4,80005068 <exec+0x320>
    if(ph.memsz < ph.filesz)
    800050b2:	e4043483          	ld	s1,-448(s0)
    800050b6:	e3843783          	ld	a5,-456(s0)
    800050ba:	f6f4ede3          	bltu	s1,a5,80005034 <exec+0x2ec>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    800050be:	e2843783          	ld	a5,-472(s0)
    800050c2:	94be                	add	s1,s1,a5
    800050c4:	f6f4ebe3          	bltu	s1,a5,8000503a <exec+0x2f2>
    if(ph.vaddr % PIGSIZE != 0)
    800050c8:	de043703          	ld	a4,-544(s0)
    800050cc:	8ff9                	and	a5,a5,a4
    800050ce:	fbad                	bnez	a5,80005040 <exec+0x2f8>
    if((sz1 = uvmalloc(pigtable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    800050d0:	e1c42503          	lw	a0,-484(s0)
    800050d4:	00000097          	auipc	ra,0x0
    800050d8:	c58080e7          	jalr	-936(ra) # 80004d2c <flags2perm>
    800050dc:	86aa                	mv	a3,a0
    800050de:	8626                	mv	a2,s1
    800050e0:	85ca                	mv	a1,s2
    800050e2:	855a                	mv	a0,s6
    800050e4:	ffffc097          	auipc	ra,0xffffc
    800050e8:	32c080e7          	jalr	812(ra) # 80001410 <uvmalloc>
    800050ec:	dea43c23          	sd	a0,-520(s0)
    800050f0:	d939                	beqz	a0,80005046 <exec+0x2fe>
    if(loadseg(pigtable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    800050f2:	e2843c03          	ld	s8,-472(s0)
    800050f6:	e2042c83          	lw	s9,-480(s0)
    800050fa:	e3842b83          	lw	s7,-456(s0)
  for(i = 0; i < sz; i += PIGSIZE){
    800050fe:	f60b83e3          	beqz	s7,80005064 <exec+0x31c>
    80005102:	89de                	mv	s3,s7
    80005104:	4481                	li	s1,0
    80005106:	bb95                	j	80004e7a <exec+0x132>

0000000080005108 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80005108:	7179                	addi	sp,sp,-48
    8000510a:	f406                	sd	ra,40(sp)
    8000510c:	f022                	sd	s0,32(sp)
    8000510e:	ec26                	sd	s1,24(sp)
    80005110:	e84a                	sd	s2,16(sp)
    80005112:	1800                	addi	s0,sp,48
    80005114:	892e                	mv	s2,a1
    80005116:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    80005118:	fdc40593          	addi	a1,s0,-36
    8000511c:	ffffe097          	auipc	ra,0xffffe
    80005120:	b8e080e7          	jalr	-1138(ra) # 80002caa <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80005124:	fdc42703          	lw	a4,-36(s0)
    80005128:	47bd                	li	a5,15
    8000512a:	02e7eb63          	bltu	a5,a4,80005160 <argfd+0x58>
    8000512e:	ffffd097          	auipc	ra,0xffffd
    80005132:	87e080e7          	jalr	-1922(ra) # 800019ac <myproc>
    80005136:	fdc42703          	lw	a4,-36(s0)
    8000513a:	01a70793          	addi	a5,a4,26
    8000513e:	078e                	slli	a5,a5,0x3
    80005140:	953e                	add	a0,a0,a5
    80005142:	611c                	ld	a5,0(a0)
    80005144:	c385                	beqz	a5,80005164 <argfd+0x5c>
    return -1;
  if(pfd)
    80005146:	00090463          	beqz	s2,8000514e <argfd+0x46>
    *pfd = fd;
    8000514a:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    8000514e:	4501                	li	a0,0
  if(pf)
    80005150:	c091                	beqz	s1,80005154 <argfd+0x4c>
    *pf = f;
    80005152:	e09c                	sd	a5,0(s1)
}
    80005154:	70a2                	ld	ra,40(sp)
    80005156:	7402                	ld	s0,32(sp)
    80005158:	64e2                	ld	s1,24(sp)
    8000515a:	6942                	ld	s2,16(sp)
    8000515c:	6145                	addi	sp,sp,48
    8000515e:	8082                	ret
    return -1;
    80005160:	557d                	li	a0,-1
    80005162:	bfcd                	j	80005154 <argfd+0x4c>
    80005164:	557d                	li	a0,-1
    80005166:	b7fd                	j	80005154 <argfd+0x4c>

0000000080005168 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80005168:	1101                	addi	sp,sp,-32
    8000516a:	ec06                	sd	ra,24(sp)
    8000516c:	e822                	sd	s0,16(sp)
    8000516e:	e426                	sd	s1,8(sp)
    80005170:	1000                	addi	s0,sp,32
    80005172:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80005174:	ffffd097          	auipc	ra,0xffffd
    80005178:	838080e7          	jalr	-1992(ra) # 800019ac <myproc>
    8000517c:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    8000517e:	0d050793          	addi	a5,a0,208
    80005182:	4501                	li	a0,0
    80005184:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80005186:	6398                	ld	a4,0(a5)
    80005188:	cb19                	beqz	a4,8000519e <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    8000518a:	2505                	addiw	a0,a0,1
    8000518c:	07a1                	addi	a5,a5,8
    8000518e:	fed51ce3          	bne	a0,a3,80005186 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80005192:	557d                	li	a0,-1
}
    80005194:	60e2                	ld	ra,24(sp)
    80005196:	6442                	ld	s0,16(sp)
    80005198:	64a2                	ld	s1,8(sp)
    8000519a:	6105                	addi	sp,sp,32
    8000519c:	8082                	ret
      p->ofile[fd] = f;
    8000519e:	01a50793          	addi	a5,a0,26
    800051a2:	078e                	slli	a5,a5,0x3
    800051a4:	963e                	add	a2,a2,a5
    800051a6:	e204                	sd	s1,0(a2)
      return fd;
    800051a8:	b7f5                	j	80005194 <fdalloc+0x2c>

00000000800051aa <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    800051aa:	715d                	addi	sp,sp,-80
    800051ac:	e486                	sd	ra,72(sp)
    800051ae:	e0a2                	sd	s0,64(sp)
    800051b0:	fc26                	sd	s1,56(sp)
    800051b2:	f84a                	sd	s2,48(sp)
    800051b4:	f44e                	sd	s3,40(sp)
    800051b6:	f052                	sd	s4,32(sp)
    800051b8:	ec56                	sd	s5,24(sp)
    800051ba:	e85a                	sd	s6,16(sp)
    800051bc:	0880                	addi	s0,sp,80
    800051be:	8b2e                	mv	s6,a1
    800051c0:	89b2                	mv	s3,a2
    800051c2:	8936                	mv	s2,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    800051c4:	fb040593          	addi	a1,s0,-80
    800051c8:	fffff097          	auipc	ra,0xfffff
    800051cc:	e3c080e7          	jalr	-452(ra) # 80004004 <nameiparent>
    800051d0:	84aa                	mv	s1,a0
    800051d2:	14050f63          	beqz	a0,80005330 <create+0x186>
    return 0;

  ilock(dp);
    800051d6:	ffffe097          	auipc	ra,0xffffe
    800051da:	66a080e7          	jalr	1642(ra) # 80003840 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    800051de:	4601                	li	a2,0
    800051e0:	fb040593          	addi	a1,s0,-80
    800051e4:	8526                	mv	a0,s1
    800051e6:	fffff097          	auipc	ra,0xfffff
    800051ea:	b3e080e7          	jalr	-1218(ra) # 80003d24 <dirlookup>
    800051ee:	8aaa                	mv	s5,a0
    800051f0:	c931                	beqz	a0,80005244 <create+0x9a>
    iunlockput(dp);
    800051f2:	8526                	mv	a0,s1
    800051f4:	fffff097          	auipc	ra,0xfffff
    800051f8:	8ae080e7          	jalr	-1874(ra) # 80003aa2 <iunlockput>
    ilock(ip);
    800051fc:	8556                	mv	a0,s5
    800051fe:	ffffe097          	auipc	ra,0xffffe
    80005202:	642080e7          	jalr	1602(ra) # 80003840 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80005206:	000b059b          	sext.w	a1,s6
    8000520a:	4789                	li	a5,2
    8000520c:	02f59563          	bne	a1,a5,80005236 <create+0x8c>
    80005210:	044ad783          	lhu	a5,68(s5) # fffffffffffff044 <end+0xffffffff7ffdd2f4>
    80005214:	37f9                	addiw	a5,a5,-2
    80005216:	17c2                	slli	a5,a5,0x30
    80005218:	93c1                	srli	a5,a5,0x30
    8000521a:	4705                	li	a4,1
    8000521c:	00f76d63          	bltu	a4,a5,80005236 <create+0x8c>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    80005220:	8556                	mv	a0,s5
    80005222:	60a6                	ld	ra,72(sp)
    80005224:	6406                	ld	s0,64(sp)
    80005226:	74e2                	ld	s1,56(sp)
    80005228:	7942                	ld	s2,48(sp)
    8000522a:	79a2                	ld	s3,40(sp)
    8000522c:	7a02                	ld	s4,32(sp)
    8000522e:	6ae2                	ld	s5,24(sp)
    80005230:	6b42                	ld	s6,16(sp)
    80005232:	6161                	addi	sp,sp,80
    80005234:	8082                	ret
    iunlockput(ip);
    80005236:	8556                	mv	a0,s5
    80005238:	fffff097          	auipc	ra,0xfffff
    8000523c:	86a080e7          	jalr	-1942(ra) # 80003aa2 <iunlockput>
    return 0;
    80005240:	4a81                	li	s5,0
    80005242:	bff9                	j	80005220 <create+0x76>
  if((ip = ialloc(dp->dev, type)) == 0){
    80005244:	85da                	mv	a1,s6
    80005246:	4088                	lw	a0,0(s1)
    80005248:	ffffe097          	auipc	ra,0xffffe
    8000524c:	45c080e7          	jalr	1116(ra) # 800036a4 <ialloc>
    80005250:	8a2a                	mv	s4,a0
    80005252:	c539                	beqz	a0,800052a0 <create+0xf6>
  ilock(ip);
    80005254:	ffffe097          	auipc	ra,0xffffe
    80005258:	5ec080e7          	jalr	1516(ra) # 80003840 <ilock>
  ip->major = major;
    8000525c:	053a1323          	sh	s3,70(s4)
  ip->minor = minor;
    80005260:	052a1423          	sh	s2,72(s4)
  ip->nlink = 1;
    80005264:	4905                	li	s2,1
    80005266:	052a1523          	sh	s2,74(s4)
  iupdate(ip);
    8000526a:	8552                	mv	a0,s4
    8000526c:	ffffe097          	auipc	ra,0xffffe
    80005270:	50a080e7          	jalr	1290(ra) # 80003776 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    80005274:	000b059b          	sext.w	a1,s6
    80005278:	03258b63          	beq	a1,s2,800052ae <create+0x104>
  if(dirlink(dp, name, ip->inum) < 0)
    8000527c:	004a2603          	lw	a2,4(s4)
    80005280:	fb040593          	addi	a1,s0,-80
    80005284:	8526                	mv	a0,s1
    80005286:	fffff097          	auipc	ra,0xfffff
    8000528a:	cae080e7          	jalr	-850(ra) # 80003f34 <dirlink>
    8000528e:	06054f63          	bltz	a0,8000530c <create+0x162>
  iunlockput(dp);
    80005292:	8526                	mv	a0,s1
    80005294:	fffff097          	auipc	ra,0xfffff
    80005298:	80e080e7          	jalr	-2034(ra) # 80003aa2 <iunlockput>
  return ip;
    8000529c:	8ad2                	mv	s5,s4
    8000529e:	b749                	j	80005220 <create+0x76>
    iunlockput(dp);
    800052a0:	8526                	mv	a0,s1
    800052a2:	fffff097          	auipc	ra,0xfffff
    800052a6:	800080e7          	jalr	-2048(ra) # 80003aa2 <iunlockput>
    return 0;
    800052aa:	8ad2                	mv	s5,s4
    800052ac:	bf95                	j	80005220 <create+0x76>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    800052ae:	004a2603          	lw	a2,4(s4)
    800052b2:	00003597          	auipc	a1,0x3
    800052b6:	44e58593          	addi	a1,a1,1102 # 80008700 <syscalls+0x2a8>
    800052ba:	8552                	mv	a0,s4
    800052bc:	fffff097          	auipc	ra,0xfffff
    800052c0:	c78080e7          	jalr	-904(ra) # 80003f34 <dirlink>
    800052c4:	04054463          	bltz	a0,8000530c <create+0x162>
    800052c8:	40d0                	lw	a2,4(s1)
    800052ca:	00003597          	auipc	a1,0x3
    800052ce:	43e58593          	addi	a1,a1,1086 # 80008708 <syscalls+0x2b0>
    800052d2:	8552                	mv	a0,s4
    800052d4:	fffff097          	auipc	ra,0xfffff
    800052d8:	c60080e7          	jalr	-928(ra) # 80003f34 <dirlink>
    800052dc:	02054863          	bltz	a0,8000530c <create+0x162>
  if(dirlink(dp, name, ip->inum) < 0)
    800052e0:	004a2603          	lw	a2,4(s4)
    800052e4:	fb040593          	addi	a1,s0,-80
    800052e8:	8526                	mv	a0,s1
    800052ea:	fffff097          	auipc	ra,0xfffff
    800052ee:	c4a080e7          	jalr	-950(ra) # 80003f34 <dirlink>
    800052f2:	00054d63          	bltz	a0,8000530c <create+0x162>
    dp->nlink++;  // for ".."
    800052f6:	04a4d783          	lhu	a5,74(s1)
    800052fa:	2785                	addiw	a5,a5,1
    800052fc:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80005300:	8526                	mv	a0,s1
    80005302:	ffffe097          	auipc	ra,0xffffe
    80005306:	474080e7          	jalr	1140(ra) # 80003776 <iupdate>
    8000530a:	b761                	j	80005292 <create+0xe8>
  ip->nlink = 0;
    8000530c:	040a1523          	sh	zero,74(s4)
  iupdate(ip);
    80005310:	8552                	mv	a0,s4
    80005312:	ffffe097          	auipc	ra,0xffffe
    80005316:	464080e7          	jalr	1124(ra) # 80003776 <iupdate>
  iunlockput(ip);
    8000531a:	8552                	mv	a0,s4
    8000531c:	ffffe097          	auipc	ra,0xffffe
    80005320:	786080e7          	jalr	1926(ra) # 80003aa2 <iunlockput>
  iunlockput(dp);
    80005324:	8526                	mv	a0,s1
    80005326:	ffffe097          	auipc	ra,0xffffe
    8000532a:	77c080e7          	jalr	1916(ra) # 80003aa2 <iunlockput>
  return 0;
    8000532e:	bdcd                	j	80005220 <create+0x76>
    return 0;
    80005330:	8aaa                	mv	s5,a0
    80005332:	b5fd                	j	80005220 <create+0x76>

0000000080005334 <sys_dup>:
{
    80005334:	7179                	addi	sp,sp,-48
    80005336:	f406                	sd	ra,40(sp)
    80005338:	f022                	sd	s0,32(sp)
    8000533a:	ec26                	sd	s1,24(sp)
    8000533c:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    8000533e:	fd840613          	addi	a2,s0,-40
    80005342:	4581                	li	a1,0
    80005344:	4501                	li	a0,0
    80005346:	00000097          	auipc	ra,0x0
    8000534a:	dc2080e7          	jalr	-574(ra) # 80005108 <argfd>
    return -1;
    8000534e:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80005350:	02054363          	bltz	a0,80005376 <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    80005354:	fd843503          	ld	a0,-40(s0)
    80005358:	00000097          	auipc	ra,0x0
    8000535c:	e10080e7          	jalr	-496(ra) # 80005168 <fdalloc>
    80005360:	84aa                	mv	s1,a0
    return -1;
    80005362:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80005364:	00054963          	bltz	a0,80005376 <sys_dup+0x42>
  filedup(f);
    80005368:	fd843503          	ld	a0,-40(s0)
    8000536c:	fffff097          	auipc	ra,0xfffff
    80005370:	310080e7          	jalr	784(ra) # 8000467c <filedup>
  return fd;
    80005374:	87a6                	mv	a5,s1
}
    80005376:	853e                	mv	a0,a5
    80005378:	70a2                	ld	ra,40(sp)
    8000537a:	7402                	ld	s0,32(sp)
    8000537c:	64e2                	ld	s1,24(sp)
    8000537e:	6145                	addi	sp,sp,48
    80005380:	8082                	ret

0000000080005382 <sys_read>:
{
    80005382:	7179                	addi	sp,sp,-48
    80005384:	f406                	sd	ra,40(sp)
    80005386:	f022                	sd	s0,32(sp)
    80005388:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    8000538a:	fd840593          	addi	a1,s0,-40
    8000538e:	4505                	li	a0,1
    80005390:	ffffe097          	auipc	ra,0xffffe
    80005394:	93a080e7          	jalr	-1734(ra) # 80002cca <argaddr>
  argint(2, &n);
    80005398:	fe440593          	addi	a1,s0,-28
    8000539c:	4509                	li	a0,2
    8000539e:	ffffe097          	auipc	ra,0xffffe
    800053a2:	90c080e7          	jalr	-1780(ra) # 80002caa <argint>
  if(argfd(0, 0, &f) < 0)
    800053a6:	fe840613          	addi	a2,s0,-24
    800053aa:	4581                	li	a1,0
    800053ac:	4501                	li	a0,0
    800053ae:	00000097          	auipc	ra,0x0
    800053b2:	d5a080e7          	jalr	-678(ra) # 80005108 <argfd>
    800053b6:	87aa                	mv	a5,a0
    return -1;
    800053b8:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    800053ba:	0007cc63          	bltz	a5,800053d2 <sys_read+0x50>
  return fileread(f, p, n);
    800053be:	fe442603          	lw	a2,-28(s0)
    800053c2:	fd843583          	ld	a1,-40(s0)
    800053c6:	fe843503          	ld	a0,-24(s0)
    800053ca:	fffff097          	auipc	ra,0xfffff
    800053ce:	43e080e7          	jalr	1086(ra) # 80004808 <fileread>
}
    800053d2:	70a2                	ld	ra,40(sp)
    800053d4:	7402                	ld	s0,32(sp)
    800053d6:	6145                	addi	sp,sp,48
    800053d8:	8082                	ret

00000000800053da <sys_write>:
{
    800053da:	7179                	addi	sp,sp,-48
    800053dc:	f406                	sd	ra,40(sp)
    800053de:	f022                	sd	s0,32(sp)
    800053e0:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    800053e2:	fd840593          	addi	a1,s0,-40
    800053e6:	4505                	li	a0,1
    800053e8:	ffffe097          	auipc	ra,0xffffe
    800053ec:	8e2080e7          	jalr	-1822(ra) # 80002cca <argaddr>
  argint(2, &n);
    800053f0:	fe440593          	addi	a1,s0,-28
    800053f4:	4509                	li	a0,2
    800053f6:	ffffe097          	auipc	ra,0xffffe
    800053fa:	8b4080e7          	jalr	-1868(ra) # 80002caa <argint>
  if(argfd(0, 0, &f) < 0)
    800053fe:	fe840613          	addi	a2,s0,-24
    80005402:	4581                	li	a1,0
    80005404:	4501                	li	a0,0
    80005406:	00000097          	auipc	ra,0x0
    8000540a:	d02080e7          	jalr	-766(ra) # 80005108 <argfd>
    8000540e:	87aa                	mv	a5,a0
    return -1;
    80005410:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80005412:	0007cc63          	bltz	a5,8000542a <sys_write+0x50>
  return filewrite(f, p, n);
    80005416:	fe442603          	lw	a2,-28(s0)
    8000541a:	fd843583          	ld	a1,-40(s0)
    8000541e:	fe843503          	ld	a0,-24(s0)
    80005422:	fffff097          	auipc	ra,0xfffff
    80005426:	4a8080e7          	jalr	1192(ra) # 800048ca <filewrite>
}
    8000542a:	70a2                	ld	ra,40(sp)
    8000542c:	7402                	ld	s0,32(sp)
    8000542e:	6145                	addi	sp,sp,48
    80005430:	8082                	ret

0000000080005432 <sys_close>:
{
    80005432:	1101                	addi	sp,sp,-32
    80005434:	ec06                	sd	ra,24(sp)
    80005436:	e822                	sd	s0,16(sp)
    80005438:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    8000543a:	fe040613          	addi	a2,s0,-32
    8000543e:	fec40593          	addi	a1,s0,-20
    80005442:	4501                	li	a0,0
    80005444:	00000097          	auipc	ra,0x0
    80005448:	cc4080e7          	jalr	-828(ra) # 80005108 <argfd>
    return -1;
    8000544c:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    8000544e:	02054463          	bltz	a0,80005476 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    80005452:	ffffc097          	auipc	ra,0xffffc
    80005456:	55a080e7          	jalr	1370(ra) # 800019ac <myproc>
    8000545a:	fec42783          	lw	a5,-20(s0)
    8000545e:	07e9                	addi	a5,a5,26
    80005460:	078e                	slli	a5,a5,0x3
    80005462:	97aa                	add	a5,a5,a0
    80005464:	0007b023          	sd	zero,0(a5)
  fileclose(f);
    80005468:	fe043503          	ld	a0,-32(s0)
    8000546c:	fffff097          	auipc	ra,0xfffff
    80005470:	262080e7          	jalr	610(ra) # 800046ce <fileclose>
  return 0;
    80005474:	4781                	li	a5,0
}
    80005476:	853e                	mv	a0,a5
    80005478:	60e2                	ld	ra,24(sp)
    8000547a:	6442                	ld	s0,16(sp)
    8000547c:	6105                	addi	sp,sp,32
    8000547e:	8082                	ret

0000000080005480 <sys_fstat>:
{
    80005480:	1101                	addi	sp,sp,-32
    80005482:	ec06                	sd	ra,24(sp)
    80005484:	e822                	sd	s0,16(sp)
    80005486:	1000                	addi	s0,sp,32
  argaddr(1, &st);
    80005488:	fe040593          	addi	a1,s0,-32
    8000548c:	4505                	li	a0,1
    8000548e:	ffffe097          	auipc	ra,0xffffe
    80005492:	83c080e7          	jalr	-1988(ra) # 80002cca <argaddr>
  if(argfd(0, 0, &f) < 0)
    80005496:	fe840613          	addi	a2,s0,-24
    8000549a:	4581                	li	a1,0
    8000549c:	4501                	li	a0,0
    8000549e:	00000097          	auipc	ra,0x0
    800054a2:	c6a080e7          	jalr	-918(ra) # 80005108 <argfd>
    800054a6:	87aa                	mv	a5,a0
    return -1;
    800054a8:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    800054aa:	0007ca63          	bltz	a5,800054be <sys_fstat+0x3e>
  return filestat(f, st);
    800054ae:	fe043583          	ld	a1,-32(s0)
    800054b2:	fe843503          	ld	a0,-24(s0)
    800054b6:	fffff097          	auipc	ra,0xfffff
    800054ba:	2e0080e7          	jalr	736(ra) # 80004796 <filestat>
}
    800054be:	60e2                	ld	ra,24(sp)
    800054c0:	6442                	ld	s0,16(sp)
    800054c2:	6105                	addi	sp,sp,32
    800054c4:	8082                	ret

00000000800054c6 <sys_link>:
{
    800054c6:	7169                	addi	sp,sp,-304
    800054c8:	f606                	sd	ra,296(sp)
    800054ca:	f222                	sd	s0,288(sp)
    800054cc:	ee26                	sd	s1,280(sp)
    800054ce:	ea4a                	sd	s2,272(sp)
    800054d0:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800054d2:	08000613          	li	a2,128
    800054d6:	ed040593          	addi	a1,s0,-304
    800054da:	4501                	li	a0,0
    800054dc:	ffffe097          	auipc	ra,0xffffe
    800054e0:	80e080e7          	jalr	-2034(ra) # 80002cea <argstr>
    return -1;
    800054e4:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800054e6:	10054e63          	bltz	a0,80005602 <sys_link+0x13c>
    800054ea:	08000613          	li	a2,128
    800054ee:	f5040593          	addi	a1,s0,-176
    800054f2:	4505                	li	a0,1
    800054f4:	ffffd097          	auipc	ra,0xffffd
    800054f8:	7f6080e7          	jalr	2038(ra) # 80002cea <argstr>
    return -1;
    800054fc:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800054fe:	10054263          	bltz	a0,80005602 <sys_link+0x13c>
  begin_op();
    80005502:	fffff097          	auipc	ra,0xfffff
    80005506:	d00080e7          	jalr	-768(ra) # 80004202 <begin_op>
  if((ip = namei(old)) == 0){
    8000550a:	ed040513          	addi	a0,s0,-304
    8000550e:	fffff097          	auipc	ra,0xfffff
    80005512:	ad8080e7          	jalr	-1320(ra) # 80003fe6 <namei>
    80005516:	84aa                	mv	s1,a0
    80005518:	c551                	beqz	a0,800055a4 <sys_link+0xde>
  ilock(ip);
    8000551a:	ffffe097          	auipc	ra,0xffffe
    8000551e:	326080e7          	jalr	806(ra) # 80003840 <ilock>
  if(ip->type == T_DIR){
    80005522:	04449703          	lh	a4,68(s1)
    80005526:	4785                	li	a5,1
    80005528:	08f70463          	beq	a4,a5,800055b0 <sys_link+0xea>
  ip->nlink++;
    8000552c:	04a4d783          	lhu	a5,74(s1)
    80005530:	2785                	addiw	a5,a5,1
    80005532:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80005536:	8526                	mv	a0,s1
    80005538:	ffffe097          	auipc	ra,0xffffe
    8000553c:	23e080e7          	jalr	574(ra) # 80003776 <iupdate>
  iunlock(ip);
    80005540:	8526                	mv	a0,s1
    80005542:	ffffe097          	auipc	ra,0xffffe
    80005546:	3c0080e7          	jalr	960(ra) # 80003902 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    8000554a:	fd040593          	addi	a1,s0,-48
    8000554e:	f5040513          	addi	a0,s0,-176
    80005552:	fffff097          	auipc	ra,0xfffff
    80005556:	ab2080e7          	jalr	-1358(ra) # 80004004 <nameiparent>
    8000555a:	892a                	mv	s2,a0
    8000555c:	c935                	beqz	a0,800055d0 <sys_link+0x10a>
  ilock(dp);
    8000555e:	ffffe097          	auipc	ra,0xffffe
    80005562:	2e2080e7          	jalr	738(ra) # 80003840 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80005566:	00092703          	lw	a4,0(s2)
    8000556a:	409c                	lw	a5,0(s1)
    8000556c:	04f71d63          	bne	a4,a5,800055c6 <sys_link+0x100>
    80005570:	40d0                	lw	a2,4(s1)
    80005572:	fd040593          	addi	a1,s0,-48
    80005576:	854a                	mv	a0,s2
    80005578:	fffff097          	auipc	ra,0xfffff
    8000557c:	9bc080e7          	jalr	-1604(ra) # 80003f34 <dirlink>
    80005580:	04054363          	bltz	a0,800055c6 <sys_link+0x100>
  iunlockput(dp);
    80005584:	854a                	mv	a0,s2
    80005586:	ffffe097          	auipc	ra,0xffffe
    8000558a:	51c080e7          	jalr	1308(ra) # 80003aa2 <iunlockput>
  iput(ip);
    8000558e:	8526                	mv	a0,s1
    80005590:	ffffe097          	auipc	ra,0xffffe
    80005594:	46a080e7          	jalr	1130(ra) # 800039fa <iput>
  end_op();
    80005598:	fffff097          	auipc	ra,0xfffff
    8000559c:	cea080e7          	jalr	-790(ra) # 80004282 <end_op>
  return 0;
    800055a0:	4781                	li	a5,0
    800055a2:	a085                	j	80005602 <sys_link+0x13c>
    end_op();
    800055a4:	fffff097          	auipc	ra,0xfffff
    800055a8:	cde080e7          	jalr	-802(ra) # 80004282 <end_op>
    return -1;
    800055ac:	57fd                	li	a5,-1
    800055ae:	a891                	j	80005602 <sys_link+0x13c>
    iunlockput(ip);
    800055b0:	8526                	mv	a0,s1
    800055b2:	ffffe097          	auipc	ra,0xffffe
    800055b6:	4f0080e7          	jalr	1264(ra) # 80003aa2 <iunlockput>
    end_op();
    800055ba:	fffff097          	auipc	ra,0xfffff
    800055be:	cc8080e7          	jalr	-824(ra) # 80004282 <end_op>
    return -1;
    800055c2:	57fd                	li	a5,-1
    800055c4:	a83d                	j	80005602 <sys_link+0x13c>
    iunlockput(dp);
    800055c6:	854a                	mv	a0,s2
    800055c8:	ffffe097          	auipc	ra,0xffffe
    800055cc:	4da080e7          	jalr	1242(ra) # 80003aa2 <iunlockput>
  ilock(ip);
    800055d0:	8526                	mv	a0,s1
    800055d2:	ffffe097          	auipc	ra,0xffffe
    800055d6:	26e080e7          	jalr	622(ra) # 80003840 <ilock>
  ip->nlink--;
    800055da:	04a4d783          	lhu	a5,74(s1)
    800055de:	37fd                	addiw	a5,a5,-1
    800055e0:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800055e4:	8526                	mv	a0,s1
    800055e6:	ffffe097          	auipc	ra,0xffffe
    800055ea:	190080e7          	jalr	400(ra) # 80003776 <iupdate>
  iunlockput(ip);
    800055ee:	8526                	mv	a0,s1
    800055f0:	ffffe097          	auipc	ra,0xffffe
    800055f4:	4b2080e7          	jalr	1202(ra) # 80003aa2 <iunlockput>
  end_op();
    800055f8:	fffff097          	auipc	ra,0xfffff
    800055fc:	c8a080e7          	jalr	-886(ra) # 80004282 <end_op>
  return -1;
    80005600:	57fd                	li	a5,-1
}
    80005602:	853e                	mv	a0,a5
    80005604:	70b2                	ld	ra,296(sp)
    80005606:	7412                	ld	s0,288(sp)
    80005608:	64f2                	ld	s1,280(sp)
    8000560a:	6952                	ld	s2,272(sp)
    8000560c:	6155                	addi	sp,sp,304
    8000560e:	8082                	ret

0000000080005610 <sys_unlink>:
{
    80005610:	7151                	addi	sp,sp,-240
    80005612:	f586                	sd	ra,232(sp)
    80005614:	f1a2                	sd	s0,224(sp)
    80005616:	eda6                	sd	s1,216(sp)
    80005618:	e9ca                	sd	s2,208(sp)
    8000561a:	e5ce                	sd	s3,200(sp)
    8000561c:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    8000561e:	08000613          	li	a2,128
    80005622:	f3040593          	addi	a1,s0,-208
    80005626:	4501                	li	a0,0
    80005628:	ffffd097          	auipc	ra,0xffffd
    8000562c:	6c2080e7          	jalr	1730(ra) # 80002cea <argstr>
    80005630:	18054163          	bltz	a0,800057b2 <sys_unlink+0x1a2>
  begin_op();
    80005634:	fffff097          	auipc	ra,0xfffff
    80005638:	bce080e7          	jalr	-1074(ra) # 80004202 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    8000563c:	fb040593          	addi	a1,s0,-80
    80005640:	f3040513          	addi	a0,s0,-208
    80005644:	fffff097          	auipc	ra,0xfffff
    80005648:	9c0080e7          	jalr	-1600(ra) # 80004004 <nameiparent>
    8000564c:	84aa                	mv	s1,a0
    8000564e:	c979                	beqz	a0,80005724 <sys_unlink+0x114>
  ilock(dp);
    80005650:	ffffe097          	auipc	ra,0xffffe
    80005654:	1f0080e7          	jalr	496(ra) # 80003840 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80005658:	00003597          	auipc	a1,0x3
    8000565c:	0a858593          	addi	a1,a1,168 # 80008700 <syscalls+0x2a8>
    80005660:	fb040513          	addi	a0,s0,-80
    80005664:	ffffe097          	auipc	ra,0xffffe
    80005668:	6a6080e7          	jalr	1702(ra) # 80003d0a <namecmp>
    8000566c:	14050a63          	beqz	a0,800057c0 <sys_unlink+0x1b0>
    80005670:	00003597          	auipc	a1,0x3
    80005674:	09858593          	addi	a1,a1,152 # 80008708 <syscalls+0x2b0>
    80005678:	fb040513          	addi	a0,s0,-80
    8000567c:	ffffe097          	auipc	ra,0xffffe
    80005680:	68e080e7          	jalr	1678(ra) # 80003d0a <namecmp>
    80005684:	12050e63          	beqz	a0,800057c0 <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    80005688:	f2c40613          	addi	a2,s0,-212
    8000568c:	fb040593          	addi	a1,s0,-80
    80005690:	8526                	mv	a0,s1
    80005692:	ffffe097          	auipc	ra,0xffffe
    80005696:	692080e7          	jalr	1682(ra) # 80003d24 <dirlookup>
    8000569a:	892a                	mv	s2,a0
    8000569c:	12050263          	beqz	a0,800057c0 <sys_unlink+0x1b0>
  ilock(ip);
    800056a0:	ffffe097          	auipc	ra,0xffffe
    800056a4:	1a0080e7          	jalr	416(ra) # 80003840 <ilock>
  if(ip->nlink < 1)
    800056a8:	04a91783          	lh	a5,74(s2)
    800056ac:	08f05263          	blez	a5,80005730 <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    800056b0:	04491703          	lh	a4,68(s2)
    800056b4:	4785                	li	a5,1
    800056b6:	08f70563          	beq	a4,a5,80005740 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    800056ba:	4641                	li	a2,16
    800056bc:	4581                	li	a1,0
    800056be:	fc040513          	addi	a0,s0,-64
    800056c2:	ffffb097          	auipc	ra,0xffffb
    800056c6:	610080e7          	jalr	1552(ra) # 80000cd2 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800056ca:	4741                	li	a4,16
    800056cc:	f2c42683          	lw	a3,-212(s0)
    800056d0:	fc040613          	addi	a2,s0,-64
    800056d4:	4581                	li	a1,0
    800056d6:	8526                	mv	a0,s1
    800056d8:	ffffe097          	auipc	ra,0xffffe
    800056dc:	514080e7          	jalr	1300(ra) # 80003bec <writei>
    800056e0:	47c1                	li	a5,16
    800056e2:	0af51563          	bne	a0,a5,8000578c <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    800056e6:	04491703          	lh	a4,68(s2)
    800056ea:	4785                	li	a5,1
    800056ec:	0af70863          	beq	a4,a5,8000579c <sys_unlink+0x18c>
  iunlockput(dp);
    800056f0:	8526                	mv	a0,s1
    800056f2:	ffffe097          	auipc	ra,0xffffe
    800056f6:	3b0080e7          	jalr	944(ra) # 80003aa2 <iunlockput>
  ip->nlink--;
    800056fa:	04a95783          	lhu	a5,74(s2)
    800056fe:	37fd                	addiw	a5,a5,-1
    80005700:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80005704:	854a                	mv	a0,s2
    80005706:	ffffe097          	auipc	ra,0xffffe
    8000570a:	070080e7          	jalr	112(ra) # 80003776 <iupdate>
  iunlockput(ip);
    8000570e:	854a                	mv	a0,s2
    80005710:	ffffe097          	auipc	ra,0xffffe
    80005714:	392080e7          	jalr	914(ra) # 80003aa2 <iunlockput>
  end_op();
    80005718:	fffff097          	auipc	ra,0xfffff
    8000571c:	b6a080e7          	jalr	-1174(ra) # 80004282 <end_op>
  return 0;
    80005720:	4501                	li	a0,0
    80005722:	a84d                	j	800057d4 <sys_unlink+0x1c4>
    end_op();
    80005724:	fffff097          	auipc	ra,0xfffff
    80005728:	b5e080e7          	jalr	-1186(ra) # 80004282 <end_op>
    return -1;
    8000572c:	557d                	li	a0,-1
    8000572e:	a05d                	j	800057d4 <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    80005730:	00003517          	auipc	a0,0x3
    80005734:	fe050513          	addi	a0,a0,-32 # 80008710 <syscalls+0x2b8>
    80005738:	ffffb097          	auipc	ra,0xffffb
    8000573c:	e06080e7          	jalr	-506(ra) # 8000053e <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80005740:	04c92703          	lw	a4,76(s2)
    80005744:	02000793          	li	a5,32
    80005748:	f6e7f9e3          	bgeu	a5,a4,800056ba <sys_unlink+0xaa>
    8000574c:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005750:	4741                	li	a4,16
    80005752:	86ce                	mv	a3,s3
    80005754:	f1840613          	addi	a2,s0,-232
    80005758:	4581                	li	a1,0
    8000575a:	854a                	mv	a0,s2
    8000575c:	ffffe097          	auipc	ra,0xffffe
    80005760:	398080e7          	jalr	920(ra) # 80003af4 <readi>
    80005764:	47c1                	li	a5,16
    80005766:	00f51b63          	bne	a0,a5,8000577c <sys_unlink+0x16c>
    if(de.inum != 0)
    8000576a:	f1845783          	lhu	a5,-232(s0)
    8000576e:	e7a1                	bnez	a5,800057b6 <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80005770:	29c1                	addiw	s3,s3,16
    80005772:	04c92783          	lw	a5,76(s2)
    80005776:	fcf9ede3          	bltu	s3,a5,80005750 <sys_unlink+0x140>
    8000577a:	b781                	j	800056ba <sys_unlink+0xaa>
      panic("isdirempty: readi");
    8000577c:	00003517          	auipc	a0,0x3
    80005780:	fac50513          	addi	a0,a0,-84 # 80008728 <syscalls+0x2d0>
    80005784:	ffffb097          	auipc	ra,0xffffb
    80005788:	dba080e7          	jalr	-582(ra) # 8000053e <panic>
    panic("unlink: writei");
    8000578c:	00003517          	auipc	a0,0x3
    80005790:	fb450513          	addi	a0,a0,-76 # 80008740 <syscalls+0x2e8>
    80005794:	ffffb097          	auipc	ra,0xffffb
    80005798:	daa080e7          	jalr	-598(ra) # 8000053e <panic>
    dp->nlink--;
    8000579c:	04a4d783          	lhu	a5,74(s1)
    800057a0:	37fd                	addiw	a5,a5,-1
    800057a2:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    800057a6:	8526                	mv	a0,s1
    800057a8:	ffffe097          	auipc	ra,0xffffe
    800057ac:	fce080e7          	jalr	-50(ra) # 80003776 <iupdate>
    800057b0:	b781                	j	800056f0 <sys_unlink+0xe0>
    return -1;
    800057b2:	557d                	li	a0,-1
    800057b4:	a005                	j	800057d4 <sys_unlink+0x1c4>
    iunlockput(ip);
    800057b6:	854a                	mv	a0,s2
    800057b8:	ffffe097          	auipc	ra,0xffffe
    800057bc:	2ea080e7          	jalr	746(ra) # 80003aa2 <iunlockput>
  iunlockput(dp);
    800057c0:	8526                	mv	a0,s1
    800057c2:	ffffe097          	auipc	ra,0xffffe
    800057c6:	2e0080e7          	jalr	736(ra) # 80003aa2 <iunlockput>
  end_op();
    800057ca:	fffff097          	auipc	ra,0xfffff
    800057ce:	ab8080e7          	jalr	-1352(ra) # 80004282 <end_op>
  return -1;
    800057d2:	557d                	li	a0,-1
}
    800057d4:	70ae                	ld	ra,232(sp)
    800057d6:	740e                	ld	s0,224(sp)
    800057d8:	64ee                	ld	s1,216(sp)
    800057da:	694e                	ld	s2,208(sp)
    800057dc:	69ae                	ld	s3,200(sp)
    800057de:	616d                	addi	sp,sp,240
    800057e0:	8082                	ret

00000000800057e2 <sys_open>:

uint64
sys_open(void)
{
    800057e2:	7131                	addi	sp,sp,-192
    800057e4:	fd06                	sd	ra,184(sp)
    800057e6:	f922                	sd	s0,176(sp)
    800057e8:	f526                	sd	s1,168(sp)
    800057ea:	f14a                	sd	s2,160(sp)
    800057ec:	ed4e                	sd	s3,152(sp)
    800057ee:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    800057f0:	f4c40593          	addi	a1,s0,-180
    800057f4:	4505                	li	a0,1
    800057f6:	ffffd097          	auipc	ra,0xffffd
    800057fa:	4b4080e7          	jalr	1204(ra) # 80002caa <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    800057fe:	08000613          	li	a2,128
    80005802:	f5040593          	addi	a1,s0,-176
    80005806:	4501                	li	a0,0
    80005808:	ffffd097          	auipc	ra,0xffffd
    8000580c:	4e2080e7          	jalr	1250(ra) # 80002cea <argstr>
    80005810:	87aa                	mv	a5,a0
    return -1;
    80005812:	557d                	li	a0,-1
  if((n = argstr(0, path, MAXPATH)) < 0)
    80005814:	0a07c963          	bltz	a5,800058c6 <sys_open+0xe4>

  begin_op();
    80005818:	fffff097          	auipc	ra,0xfffff
    8000581c:	9ea080e7          	jalr	-1558(ra) # 80004202 <begin_op>

  if(omode & O_CREATE){
    80005820:	f4c42783          	lw	a5,-180(s0)
    80005824:	2007f793          	andi	a5,a5,512
    80005828:	cfc5                	beqz	a5,800058e0 <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    8000582a:	4681                	li	a3,0
    8000582c:	4601                	li	a2,0
    8000582e:	4589                	li	a1,2
    80005830:	f5040513          	addi	a0,s0,-176
    80005834:	00000097          	auipc	ra,0x0
    80005838:	976080e7          	jalr	-1674(ra) # 800051aa <create>
    8000583c:	84aa                	mv	s1,a0
    if(ip == 0){
    8000583e:	c959                	beqz	a0,800058d4 <sys_open+0xf2>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80005840:	04449703          	lh	a4,68(s1)
    80005844:	478d                	li	a5,3
    80005846:	00f71763          	bne	a4,a5,80005854 <sys_open+0x72>
    8000584a:	0464d703          	lhu	a4,70(s1)
    8000584e:	47a5                	li	a5,9
    80005850:	0ce7ed63          	bltu	a5,a4,8000592a <sys_open+0x148>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80005854:	fffff097          	auipc	ra,0xfffff
    80005858:	dbe080e7          	jalr	-578(ra) # 80004612 <filealloc>
    8000585c:	89aa                	mv	s3,a0
    8000585e:	10050363          	beqz	a0,80005964 <sys_open+0x182>
    80005862:	00000097          	auipc	ra,0x0
    80005866:	906080e7          	jalr	-1786(ra) # 80005168 <fdalloc>
    8000586a:	892a                	mv	s2,a0
    8000586c:	0e054763          	bltz	a0,8000595a <sys_open+0x178>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80005870:	04449703          	lh	a4,68(s1)
    80005874:	478d                	li	a5,3
    80005876:	0cf70563          	beq	a4,a5,80005940 <sys_open+0x15e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    8000587a:	4789                	li	a5,2
    8000587c:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80005880:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    80005884:	0099bc23          	sd	s1,24(s3)
  f->readable = !(omode & O_WRONLY);
    80005888:	f4c42783          	lw	a5,-180(s0)
    8000588c:	0017c713          	xori	a4,a5,1
    80005890:	8b05                	andi	a4,a4,1
    80005892:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80005896:	0037f713          	andi	a4,a5,3
    8000589a:	00e03733          	snez	a4,a4
    8000589e:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    800058a2:	4007f793          	andi	a5,a5,1024
    800058a6:	c791                	beqz	a5,800058b2 <sys_open+0xd0>
    800058a8:	04449703          	lh	a4,68(s1)
    800058ac:	4789                	li	a5,2
    800058ae:	0af70063          	beq	a4,a5,8000594e <sys_open+0x16c>
    itrunc(ip);
  }

  iunlock(ip);
    800058b2:	8526                	mv	a0,s1
    800058b4:	ffffe097          	auipc	ra,0xffffe
    800058b8:	04e080e7          	jalr	78(ra) # 80003902 <iunlock>
  end_op();
    800058bc:	fffff097          	auipc	ra,0xfffff
    800058c0:	9c6080e7          	jalr	-1594(ra) # 80004282 <end_op>

  return fd;
    800058c4:	854a                	mv	a0,s2
}
    800058c6:	70ea                	ld	ra,184(sp)
    800058c8:	744a                	ld	s0,176(sp)
    800058ca:	74aa                	ld	s1,168(sp)
    800058cc:	790a                	ld	s2,160(sp)
    800058ce:	69ea                	ld	s3,152(sp)
    800058d0:	6129                	addi	sp,sp,192
    800058d2:	8082                	ret
      end_op();
    800058d4:	fffff097          	auipc	ra,0xfffff
    800058d8:	9ae080e7          	jalr	-1618(ra) # 80004282 <end_op>
      return -1;
    800058dc:	557d                	li	a0,-1
    800058de:	b7e5                	j	800058c6 <sys_open+0xe4>
    if((ip = namei(path)) == 0){
    800058e0:	f5040513          	addi	a0,s0,-176
    800058e4:	ffffe097          	auipc	ra,0xffffe
    800058e8:	702080e7          	jalr	1794(ra) # 80003fe6 <namei>
    800058ec:	84aa                	mv	s1,a0
    800058ee:	c905                	beqz	a0,8000591e <sys_open+0x13c>
    ilock(ip);
    800058f0:	ffffe097          	auipc	ra,0xffffe
    800058f4:	f50080e7          	jalr	-176(ra) # 80003840 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    800058f8:	04449703          	lh	a4,68(s1)
    800058fc:	4785                	li	a5,1
    800058fe:	f4f711e3          	bne	a4,a5,80005840 <sys_open+0x5e>
    80005902:	f4c42783          	lw	a5,-180(s0)
    80005906:	d7b9                	beqz	a5,80005854 <sys_open+0x72>
      iunlockput(ip);
    80005908:	8526                	mv	a0,s1
    8000590a:	ffffe097          	auipc	ra,0xffffe
    8000590e:	198080e7          	jalr	408(ra) # 80003aa2 <iunlockput>
      end_op();
    80005912:	fffff097          	auipc	ra,0xfffff
    80005916:	970080e7          	jalr	-1680(ra) # 80004282 <end_op>
      return -1;
    8000591a:	557d                	li	a0,-1
    8000591c:	b76d                	j	800058c6 <sys_open+0xe4>
      end_op();
    8000591e:	fffff097          	auipc	ra,0xfffff
    80005922:	964080e7          	jalr	-1692(ra) # 80004282 <end_op>
      return -1;
    80005926:	557d                	li	a0,-1
    80005928:	bf79                	j	800058c6 <sys_open+0xe4>
    iunlockput(ip);
    8000592a:	8526                	mv	a0,s1
    8000592c:	ffffe097          	auipc	ra,0xffffe
    80005930:	176080e7          	jalr	374(ra) # 80003aa2 <iunlockput>
    end_op();
    80005934:	fffff097          	auipc	ra,0xfffff
    80005938:	94e080e7          	jalr	-1714(ra) # 80004282 <end_op>
    return -1;
    8000593c:	557d                	li	a0,-1
    8000593e:	b761                	j	800058c6 <sys_open+0xe4>
    f->type = FD_DEVICE;
    80005940:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80005944:	04649783          	lh	a5,70(s1)
    80005948:	02f99223          	sh	a5,36(s3)
    8000594c:	bf25                	j	80005884 <sys_open+0xa2>
    itrunc(ip);
    8000594e:	8526                	mv	a0,s1
    80005950:	ffffe097          	auipc	ra,0xffffe
    80005954:	ffe080e7          	jalr	-2(ra) # 8000394e <itrunc>
    80005958:	bfa9                	j	800058b2 <sys_open+0xd0>
      fileclose(f);
    8000595a:	854e                	mv	a0,s3
    8000595c:	fffff097          	auipc	ra,0xfffff
    80005960:	d72080e7          	jalr	-654(ra) # 800046ce <fileclose>
    iunlockput(ip);
    80005964:	8526                	mv	a0,s1
    80005966:	ffffe097          	auipc	ra,0xffffe
    8000596a:	13c080e7          	jalr	316(ra) # 80003aa2 <iunlockput>
    end_op();
    8000596e:	fffff097          	auipc	ra,0xfffff
    80005972:	914080e7          	jalr	-1772(ra) # 80004282 <end_op>
    return -1;
    80005976:	557d                	li	a0,-1
    80005978:	b7b9                	j	800058c6 <sys_open+0xe4>

000000008000597a <sys_mkdir>:

uint64
sys_mkdir(void)
{
    8000597a:	7175                	addi	sp,sp,-144
    8000597c:	e506                	sd	ra,136(sp)
    8000597e:	e122                	sd	s0,128(sp)
    80005980:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80005982:	fffff097          	auipc	ra,0xfffff
    80005986:	880080e7          	jalr	-1920(ra) # 80004202 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    8000598a:	08000613          	li	a2,128
    8000598e:	f7040593          	addi	a1,s0,-144
    80005992:	4501                	li	a0,0
    80005994:	ffffd097          	auipc	ra,0xffffd
    80005998:	356080e7          	jalr	854(ra) # 80002cea <argstr>
    8000599c:	02054963          	bltz	a0,800059ce <sys_mkdir+0x54>
    800059a0:	4681                	li	a3,0
    800059a2:	4601                	li	a2,0
    800059a4:	4585                	li	a1,1
    800059a6:	f7040513          	addi	a0,s0,-144
    800059aa:	00000097          	auipc	ra,0x0
    800059ae:	800080e7          	jalr	-2048(ra) # 800051aa <create>
    800059b2:	cd11                	beqz	a0,800059ce <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    800059b4:	ffffe097          	auipc	ra,0xffffe
    800059b8:	0ee080e7          	jalr	238(ra) # 80003aa2 <iunlockput>
  end_op();
    800059bc:	fffff097          	auipc	ra,0xfffff
    800059c0:	8c6080e7          	jalr	-1850(ra) # 80004282 <end_op>
  return 0;
    800059c4:	4501                	li	a0,0
}
    800059c6:	60aa                	ld	ra,136(sp)
    800059c8:	640a                	ld	s0,128(sp)
    800059ca:	6149                	addi	sp,sp,144
    800059cc:	8082                	ret
    end_op();
    800059ce:	fffff097          	auipc	ra,0xfffff
    800059d2:	8b4080e7          	jalr	-1868(ra) # 80004282 <end_op>
    return -1;
    800059d6:	557d                	li	a0,-1
    800059d8:	b7fd                	j	800059c6 <sys_mkdir+0x4c>

00000000800059da <sys_mknod>:

uint64
sys_mknod(void)
{
    800059da:	7135                	addi	sp,sp,-160
    800059dc:	ed06                	sd	ra,152(sp)
    800059de:	e922                	sd	s0,144(sp)
    800059e0:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    800059e2:	fffff097          	auipc	ra,0xfffff
    800059e6:	820080e7          	jalr	-2016(ra) # 80004202 <begin_op>
  argint(1, &major);
    800059ea:	f6c40593          	addi	a1,s0,-148
    800059ee:	4505                	li	a0,1
    800059f0:	ffffd097          	auipc	ra,0xffffd
    800059f4:	2ba080e7          	jalr	698(ra) # 80002caa <argint>
  argint(2, &minor);
    800059f8:	f6840593          	addi	a1,s0,-152
    800059fc:	4509                	li	a0,2
    800059fe:	ffffd097          	auipc	ra,0xffffd
    80005a02:	2ac080e7          	jalr	684(ra) # 80002caa <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80005a06:	08000613          	li	a2,128
    80005a0a:	f7040593          	addi	a1,s0,-144
    80005a0e:	4501                	li	a0,0
    80005a10:	ffffd097          	auipc	ra,0xffffd
    80005a14:	2da080e7          	jalr	730(ra) # 80002cea <argstr>
    80005a18:	02054b63          	bltz	a0,80005a4e <sys_mknod+0x74>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80005a1c:	f6841683          	lh	a3,-152(s0)
    80005a20:	f6c41603          	lh	a2,-148(s0)
    80005a24:	458d                	li	a1,3
    80005a26:	f7040513          	addi	a0,s0,-144
    80005a2a:	fffff097          	auipc	ra,0xfffff
    80005a2e:	780080e7          	jalr	1920(ra) # 800051aa <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80005a32:	cd11                	beqz	a0,80005a4e <sys_mknod+0x74>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80005a34:	ffffe097          	auipc	ra,0xffffe
    80005a38:	06e080e7          	jalr	110(ra) # 80003aa2 <iunlockput>
  end_op();
    80005a3c:	fffff097          	auipc	ra,0xfffff
    80005a40:	846080e7          	jalr	-1978(ra) # 80004282 <end_op>
  return 0;
    80005a44:	4501                	li	a0,0
}
    80005a46:	60ea                	ld	ra,152(sp)
    80005a48:	644a                	ld	s0,144(sp)
    80005a4a:	610d                	addi	sp,sp,160
    80005a4c:	8082                	ret
    end_op();
    80005a4e:	fffff097          	auipc	ra,0xfffff
    80005a52:	834080e7          	jalr	-1996(ra) # 80004282 <end_op>
    return -1;
    80005a56:	557d                	li	a0,-1
    80005a58:	b7fd                	j	80005a46 <sys_mknod+0x6c>

0000000080005a5a <sys_chdir>:

uint64
sys_chdir(void)
{
    80005a5a:	7135                	addi	sp,sp,-160
    80005a5c:	ed06                	sd	ra,152(sp)
    80005a5e:	e922                	sd	s0,144(sp)
    80005a60:	e526                	sd	s1,136(sp)
    80005a62:	e14a                	sd	s2,128(sp)
    80005a64:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80005a66:	ffffc097          	auipc	ra,0xffffc
    80005a6a:	f46080e7          	jalr	-186(ra) # 800019ac <myproc>
    80005a6e:	892a                	mv	s2,a0

  begin_op();
    80005a70:	ffffe097          	auipc	ra,0xffffe
    80005a74:	792080e7          	jalr	1938(ra) # 80004202 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80005a78:	08000613          	li	a2,128
    80005a7c:	f6040593          	addi	a1,s0,-160
    80005a80:	4501                	li	a0,0
    80005a82:	ffffd097          	auipc	ra,0xffffd
    80005a86:	268080e7          	jalr	616(ra) # 80002cea <argstr>
    80005a8a:	04054b63          	bltz	a0,80005ae0 <sys_chdir+0x86>
    80005a8e:	f6040513          	addi	a0,s0,-160
    80005a92:	ffffe097          	auipc	ra,0xffffe
    80005a96:	554080e7          	jalr	1364(ra) # 80003fe6 <namei>
    80005a9a:	84aa                	mv	s1,a0
    80005a9c:	c131                	beqz	a0,80005ae0 <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80005a9e:	ffffe097          	auipc	ra,0xffffe
    80005aa2:	da2080e7          	jalr	-606(ra) # 80003840 <ilock>
  if(ip->type != T_DIR){
    80005aa6:	04449703          	lh	a4,68(s1)
    80005aaa:	4785                	li	a5,1
    80005aac:	04f71063          	bne	a4,a5,80005aec <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80005ab0:	8526                	mv	a0,s1
    80005ab2:	ffffe097          	auipc	ra,0xffffe
    80005ab6:	e50080e7          	jalr	-432(ra) # 80003902 <iunlock>
  iput(p->cwd);
    80005aba:	15093503          	ld	a0,336(s2)
    80005abe:	ffffe097          	auipc	ra,0xffffe
    80005ac2:	f3c080e7          	jalr	-196(ra) # 800039fa <iput>
  end_op();
    80005ac6:	ffffe097          	auipc	ra,0xffffe
    80005aca:	7bc080e7          	jalr	1980(ra) # 80004282 <end_op>
  p->cwd = ip;
    80005ace:	14993823          	sd	s1,336(s2)
  return 0;
    80005ad2:	4501                	li	a0,0
}
    80005ad4:	60ea                	ld	ra,152(sp)
    80005ad6:	644a                	ld	s0,144(sp)
    80005ad8:	64aa                	ld	s1,136(sp)
    80005ada:	690a                	ld	s2,128(sp)
    80005adc:	610d                	addi	sp,sp,160
    80005ade:	8082                	ret
    end_op();
    80005ae0:	ffffe097          	auipc	ra,0xffffe
    80005ae4:	7a2080e7          	jalr	1954(ra) # 80004282 <end_op>
    return -1;
    80005ae8:	557d                	li	a0,-1
    80005aea:	b7ed                	j	80005ad4 <sys_chdir+0x7a>
    iunlockput(ip);
    80005aec:	8526                	mv	a0,s1
    80005aee:	ffffe097          	auipc	ra,0xffffe
    80005af2:	fb4080e7          	jalr	-76(ra) # 80003aa2 <iunlockput>
    end_op();
    80005af6:	ffffe097          	auipc	ra,0xffffe
    80005afa:	78c080e7          	jalr	1932(ra) # 80004282 <end_op>
    return -1;
    80005afe:	557d                	li	a0,-1
    80005b00:	bfd1                	j	80005ad4 <sys_chdir+0x7a>

0000000080005b02 <sys_exec>:

uint64
sys_exec(void)
{
    80005b02:	7145                	addi	sp,sp,-464
    80005b04:	e786                	sd	ra,456(sp)
    80005b06:	e3a2                	sd	s0,448(sp)
    80005b08:	ff26                	sd	s1,440(sp)
    80005b0a:	fb4a                	sd	s2,432(sp)
    80005b0c:	f74e                	sd	s3,424(sp)
    80005b0e:	f352                	sd	s4,416(sp)
    80005b10:	ef56                	sd	s5,408(sp)
    80005b12:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    80005b14:	e3840593          	addi	a1,s0,-456
    80005b18:	4505                	li	a0,1
    80005b1a:	ffffd097          	auipc	ra,0xffffd
    80005b1e:	1b0080e7          	jalr	432(ra) # 80002cca <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    80005b22:	08000613          	li	a2,128
    80005b26:	f4040593          	addi	a1,s0,-192
    80005b2a:	4501                	li	a0,0
    80005b2c:	ffffd097          	auipc	ra,0xffffd
    80005b30:	1be080e7          	jalr	446(ra) # 80002cea <argstr>
    80005b34:	87aa                	mv	a5,a0
    return -1;
    80005b36:	557d                	li	a0,-1
  if(argstr(0, path, MAXPATH) < 0) {
    80005b38:	0c07c263          	bltz	a5,80005bfc <sys_exec+0xfa>
  }
  memset(argv, 0, sizeof(argv));
    80005b3c:	10000613          	li	a2,256
    80005b40:	4581                	li	a1,0
    80005b42:	e4040513          	addi	a0,s0,-448
    80005b46:	ffffb097          	auipc	ra,0xffffb
    80005b4a:	18c080e7          	jalr	396(ra) # 80000cd2 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80005b4e:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    80005b52:	89a6                	mv	s3,s1
    80005b54:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    80005b56:	02000a13          	li	s4,32
    80005b5a:	00090a9b          	sext.w	s5,s2
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80005b5e:	00391793          	slli	a5,s2,0x3
    80005b62:	e3040593          	addi	a1,s0,-464
    80005b66:	e3843503          	ld	a0,-456(s0)
    80005b6a:	953e                	add	a0,a0,a5
    80005b6c:	ffffd097          	auipc	ra,0xffffd
    80005b70:	0a0080e7          	jalr	160(ra) # 80002c0c <fetchaddr>
    80005b74:	02054a63          	bltz	a0,80005ba8 <sys_exec+0xa6>
      goto bad;
    }
    if(uarg == 0){
    80005b78:	e3043783          	ld	a5,-464(s0)
    80005b7c:	c3b9                	beqz	a5,80005bc2 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80005b7e:	ffffb097          	auipc	ra,0xffffb
    80005b82:	f68080e7          	jalr	-152(ra) # 80000ae6 <kalloc>
    80005b86:	85aa                	mv	a1,a0
    80005b88:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80005b8c:	cd11                	beqz	a0,80005ba8 <sys_exec+0xa6>
      goto bad;
    if(fetchstr(uarg, argv[i], PIGSIZE) < 0)
    80005b8e:	6605                	lui	a2,0x1
    80005b90:	e3043503          	ld	a0,-464(s0)
    80005b94:	ffffd097          	auipc	ra,0xffffd
    80005b98:	0ca080e7          	jalr	202(ra) # 80002c5e <fetchstr>
    80005b9c:	00054663          	bltz	a0,80005ba8 <sys_exec+0xa6>
    if(i >= NELEM(argv)){
    80005ba0:	0905                	addi	s2,s2,1
    80005ba2:	09a1                	addi	s3,s3,8
    80005ba4:	fb491be3          	bne	s2,s4,80005b5a <sys_exec+0x58>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005ba8:	10048913          	addi	s2,s1,256
    80005bac:	6088                	ld	a0,0(s1)
    80005bae:	c531                	beqz	a0,80005bfa <sys_exec+0xf8>
    kfree(argv[i]);
    80005bb0:	ffffb097          	auipc	ra,0xffffb
    80005bb4:	e3a080e7          	jalr	-454(ra) # 800009ea <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005bb8:	04a1                	addi	s1,s1,8
    80005bba:	ff2499e3          	bne	s1,s2,80005bac <sys_exec+0xaa>
  return -1;
    80005bbe:	557d                	li	a0,-1
    80005bc0:	a835                	j	80005bfc <sys_exec+0xfa>
      argv[i] = 0;
    80005bc2:	0a8e                	slli	s5,s5,0x3
    80005bc4:	fc040793          	addi	a5,s0,-64
    80005bc8:	9abe                	add	s5,s5,a5
    80005bca:	e80ab023          	sd	zero,-384(s5)
  int ret = exec(path, argv);
    80005bce:	e4040593          	addi	a1,s0,-448
    80005bd2:	f4040513          	addi	a0,s0,-192
    80005bd6:	fffff097          	auipc	ra,0xfffff
    80005bda:	172080e7          	jalr	370(ra) # 80004d48 <exec>
    80005bde:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005be0:	10048993          	addi	s3,s1,256
    80005be4:	6088                	ld	a0,0(s1)
    80005be6:	c901                	beqz	a0,80005bf6 <sys_exec+0xf4>
    kfree(argv[i]);
    80005be8:	ffffb097          	auipc	ra,0xffffb
    80005bec:	e02080e7          	jalr	-510(ra) # 800009ea <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005bf0:	04a1                	addi	s1,s1,8
    80005bf2:	ff3499e3          	bne	s1,s3,80005be4 <sys_exec+0xe2>
  return ret;
    80005bf6:	854a                	mv	a0,s2
    80005bf8:	a011                	j	80005bfc <sys_exec+0xfa>
  return -1;
    80005bfa:	557d                	li	a0,-1
}
    80005bfc:	60be                	ld	ra,456(sp)
    80005bfe:	641e                	ld	s0,448(sp)
    80005c00:	74fa                	ld	s1,440(sp)
    80005c02:	795a                	ld	s2,432(sp)
    80005c04:	79ba                	ld	s3,424(sp)
    80005c06:	7a1a                	ld	s4,416(sp)
    80005c08:	6afa                	ld	s5,408(sp)
    80005c0a:	6179                	addi	sp,sp,464
    80005c0c:	8082                	ret

0000000080005c0e <sys_pipe>:

uint64
sys_pipe(void)
{
    80005c0e:	7139                	addi	sp,sp,-64
    80005c10:	fc06                	sd	ra,56(sp)
    80005c12:	f822                	sd	s0,48(sp)
    80005c14:	f426                	sd	s1,40(sp)
    80005c16:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80005c18:	ffffc097          	auipc	ra,0xffffc
    80005c1c:	d94080e7          	jalr	-620(ra) # 800019ac <myproc>
    80005c20:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    80005c22:	fd840593          	addi	a1,s0,-40
    80005c26:	4501                	li	a0,0
    80005c28:	ffffd097          	auipc	ra,0xffffd
    80005c2c:	0a2080e7          	jalr	162(ra) # 80002cca <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    80005c30:	fc840593          	addi	a1,s0,-56
    80005c34:	fd040513          	addi	a0,s0,-48
    80005c38:	fffff097          	auipc	ra,0xfffff
    80005c3c:	dc6080e7          	jalr	-570(ra) # 800049fe <pipealloc>
    return -1;
    80005c40:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80005c42:	0c054463          	bltz	a0,80005d0a <sys_pipe+0xfc>
  fd0 = -1;
    80005c46:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80005c4a:	fd043503          	ld	a0,-48(s0)
    80005c4e:	fffff097          	auipc	ra,0xfffff
    80005c52:	51a080e7          	jalr	1306(ra) # 80005168 <fdalloc>
    80005c56:	fca42223          	sw	a0,-60(s0)
    80005c5a:	08054b63          	bltz	a0,80005cf0 <sys_pipe+0xe2>
    80005c5e:	fc843503          	ld	a0,-56(s0)
    80005c62:	fffff097          	auipc	ra,0xfffff
    80005c66:	506080e7          	jalr	1286(ra) # 80005168 <fdalloc>
    80005c6a:	fca42023          	sw	a0,-64(s0)
    80005c6e:	06054863          	bltz	a0,80005cde <sys_pipe+0xd0>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pigtable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005c72:	4691                	li	a3,4
    80005c74:	fc440613          	addi	a2,s0,-60
    80005c78:	fd843583          	ld	a1,-40(s0)
    80005c7c:	68a8                	ld	a0,80(s1)
    80005c7e:	ffffc097          	auipc	ra,0xffffc
    80005c82:	9ea080e7          	jalr	-1558(ra) # 80001668 <copyout>
    80005c86:	02054063          	bltz	a0,80005ca6 <sys_pipe+0x98>
     copyout(p->pigtable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80005c8a:	4691                	li	a3,4
    80005c8c:	fc040613          	addi	a2,s0,-64
    80005c90:	fd843583          	ld	a1,-40(s0)
    80005c94:	0591                	addi	a1,a1,4
    80005c96:	68a8                	ld	a0,80(s1)
    80005c98:	ffffc097          	auipc	ra,0xffffc
    80005c9c:	9d0080e7          	jalr	-1584(ra) # 80001668 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80005ca0:	4781                	li	a5,0
  if(copyout(p->pigtable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005ca2:	06055463          	bgez	a0,80005d0a <sys_pipe+0xfc>
    p->ofile[fd0] = 0;
    80005ca6:	fc442783          	lw	a5,-60(s0)
    80005caa:	07e9                	addi	a5,a5,26
    80005cac:	078e                	slli	a5,a5,0x3
    80005cae:	97a6                	add	a5,a5,s1
    80005cb0:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80005cb4:	fc042503          	lw	a0,-64(s0)
    80005cb8:	0569                	addi	a0,a0,26
    80005cba:	050e                	slli	a0,a0,0x3
    80005cbc:	94aa                	add	s1,s1,a0
    80005cbe:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    80005cc2:	fd043503          	ld	a0,-48(s0)
    80005cc6:	fffff097          	auipc	ra,0xfffff
    80005cca:	a08080e7          	jalr	-1528(ra) # 800046ce <fileclose>
    fileclose(wf);
    80005cce:	fc843503          	ld	a0,-56(s0)
    80005cd2:	fffff097          	auipc	ra,0xfffff
    80005cd6:	9fc080e7          	jalr	-1540(ra) # 800046ce <fileclose>
    return -1;
    80005cda:	57fd                	li	a5,-1
    80005cdc:	a03d                	j	80005d0a <sys_pipe+0xfc>
    if(fd0 >= 0)
    80005cde:	fc442783          	lw	a5,-60(s0)
    80005ce2:	0007c763          	bltz	a5,80005cf0 <sys_pipe+0xe2>
      p->ofile[fd0] = 0;
    80005ce6:	07e9                	addi	a5,a5,26
    80005ce8:	078e                	slli	a5,a5,0x3
    80005cea:	94be                	add	s1,s1,a5
    80005cec:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    80005cf0:	fd043503          	ld	a0,-48(s0)
    80005cf4:	fffff097          	auipc	ra,0xfffff
    80005cf8:	9da080e7          	jalr	-1574(ra) # 800046ce <fileclose>
    fileclose(wf);
    80005cfc:	fc843503          	ld	a0,-56(s0)
    80005d00:	fffff097          	auipc	ra,0xfffff
    80005d04:	9ce080e7          	jalr	-1586(ra) # 800046ce <fileclose>
    return -1;
    80005d08:	57fd                	li	a5,-1
}
    80005d0a:	853e                	mv	a0,a5
    80005d0c:	70e2                	ld	ra,56(sp)
    80005d0e:	7442                	ld	s0,48(sp)
    80005d10:	74a2                	ld	s1,40(sp)
    80005d12:	6121                	addi	sp,sp,64
    80005d14:	8082                	ret
	...

0000000080005d20 <kernelvec>:
    80005d20:	7111                	addi	sp,sp,-256
    80005d22:	e006                	sd	ra,0(sp)
    80005d24:	e40a                	sd	sp,8(sp)
    80005d26:	e80e                	sd	gp,16(sp)
    80005d28:	ec12                	sd	tp,24(sp)
    80005d2a:	f016                	sd	t0,32(sp)
    80005d2c:	f41a                	sd	t1,40(sp)
    80005d2e:	f81e                	sd	t2,48(sp)
    80005d30:	fc22                	sd	s0,56(sp)
    80005d32:	e0a6                	sd	s1,64(sp)
    80005d34:	e4aa                	sd	a0,72(sp)
    80005d36:	e8ae                	sd	a1,80(sp)
    80005d38:	ecb2                	sd	a2,88(sp)
    80005d3a:	f0b6                	sd	a3,96(sp)
    80005d3c:	f4ba                	sd	a4,104(sp)
    80005d3e:	f8be                	sd	a5,112(sp)
    80005d40:	fcc2                	sd	a6,120(sp)
    80005d42:	e146                	sd	a7,128(sp)
    80005d44:	e54a                	sd	s2,136(sp)
    80005d46:	e94e                	sd	s3,144(sp)
    80005d48:	ed52                	sd	s4,152(sp)
    80005d4a:	f156                	sd	s5,160(sp)
    80005d4c:	f55a                	sd	s6,168(sp)
    80005d4e:	f95e                	sd	s7,176(sp)
    80005d50:	fd62                	sd	s8,184(sp)
    80005d52:	e1e6                	sd	s9,192(sp)
    80005d54:	e5ea                	sd	s10,200(sp)
    80005d56:	e9ee                	sd	s11,208(sp)
    80005d58:	edf2                	sd	t3,216(sp)
    80005d5a:	f1f6                	sd	t4,224(sp)
    80005d5c:	f5fa                	sd	t5,232(sp)
    80005d5e:	f9fe                	sd	t6,240(sp)
    80005d60:	d79fc0ef          	jal	ra,80002ad8 <kerneltrap>
    80005d64:	6082                	ld	ra,0(sp)
    80005d66:	6122                	ld	sp,8(sp)
    80005d68:	61c2                	ld	gp,16(sp)
    80005d6a:	7282                	ld	t0,32(sp)
    80005d6c:	7322                	ld	t1,40(sp)
    80005d6e:	73c2                	ld	t2,48(sp)
    80005d70:	7462                	ld	s0,56(sp)
    80005d72:	6486                	ld	s1,64(sp)
    80005d74:	6526                	ld	a0,72(sp)
    80005d76:	65c6                	ld	a1,80(sp)
    80005d78:	6666                	ld	a2,88(sp)
    80005d7a:	7686                	ld	a3,96(sp)
    80005d7c:	7726                	ld	a4,104(sp)
    80005d7e:	77c6                	ld	a5,112(sp)
    80005d80:	7866                	ld	a6,120(sp)
    80005d82:	688a                	ld	a7,128(sp)
    80005d84:	692a                	ld	s2,136(sp)
    80005d86:	69ca                	ld	s3,144(sp)
    80005d88:	6a6a                	ld	s4,152(sp)
    80005d8a:	7a8a                	ld	s5,160(sp)
    80005d8c:	7b2a                	ld	s6,168(sp)
    80005d8e:	7bca                	ld	s7,176(sp)
    80005d90:	7c6a                	ld	s8,184(sp)
    80005d92:	6c8e                	ld	s9,192(sp)
    80005d94:	6d2e                	ld	s10,200(sp)
    80005d96:	6dce                	ld	s11,208(sp)
    80005d98:	6e6e                	ld	t3,216(sp)
    80005d9a:	7e8e                	ld	t4,224(sp)
    80005d9c:	7f2e                	ld	t5,232(sp)
    80005d9e:	7fce                	ld	t6,240(sp)
    80005da0:	6111                	addi	sp,sp,256
    80005da2:	10200073          	sret
    80005da6:	00000013          	nop
    80005daa:	00000013          	nop
    80005dae:	0001                	nop

0000000080005db0 <timervec>:
    80005db0:	34051573          	csrrw	a0,mscratch,a0
    80005db4:	e10c                	sd	a1,0(a0)
    80005db6:	e510                	sd	a2,8(a0)
    80005db8:	e914                	sd	a3,16(a0)
    80005dba:	6d0c                	ld	a1,24(a0)
    80005dbc:	7110                	ld	a2,32(a0)
    80005dbe:	6194                	ld	a3,0(a1)
    80005dc0:	96b2                	add	a3,a3,a2
    80005dc2:	e194                	sd	a3,0(a1)
    80005dc4:	4589                	li	a1,2
    80005dc6:	14459073          	csrw	sip,a1
    80005dca:	6914                	ld	a3,16(a0)
    80005dcc:	6510                	ld	a2,8(a0)
    80005dce:	610c                	ld	a1,0(a0)
    80005dd0:	34051573          	csrrw	a0,mscratch,a0
    80005dd4:	30200073          	mret
	...

0000000080005dda <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    80005dda:	1141                	addi	sp,sp,-16
    80005ddc:	e422                	sd	s0,8(sp)
    80005dde:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005de0:	0c0007b7          	lui	a5,0xc000
    80005de4:	4705                	li	a4,1
    80005de6:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80005de8:	c3d8                	sw	a4,4(a5)
}
    80005dea:	6422                	ld	s0,8(sp)
    80005dec:	0141                	addi	sp,sp,16
    80005dee:	8082                	ret

0000000080005df0 <plicinithart>:

void
plicinithart(void)
{
    80005df0:	1141                	addi	sp,sp,-16
    80005df2:	e406                	sd	ra,8(sp)
    80005df4:	e022                	sd	s0,0(sp)
    80005df6:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005df8:	ffffc097          	auipc	ra,0xffffc
    80005dfc:	b88080e7          	jalr	-1144(ra) # 80001980 <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005e00:	0085171b          	slliw	a4,a0,0x8
    80005e04:	0c0027b7          	lui	a5,0xc002
    80005e08:	97ba                	add	a5,a5,a4
    80005e0a:	40200713          	li	a4,1026
    80005e0e:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005e12:	00d5151b          	slliw	a0,a0,0xd
    80005e16:	0c2017b7          	lui	a5,0xc201
    80005e1a:	953e                	add	a0,a0,a5
    80005e1c:	00052023          	sw	zero,0(a0)
}
    80005e20:	60a2                	ld	ra,8(sp)
    80005e22:	6402                	ld	s0,0(sp)
    80005e24:	0141                	addi	sp,sp,16
    80005e26:	8082                	ret

0000000080005e28 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80005e28:	1141                	addi	sp,sp,-16
    80005e2a:	e406                	sd	ra,8(sp)
    80005e2c:	e022                	sd	s0,0(sp)
    80005e2e:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005e30:	ffffc097          	auipc	ra,0xffffc
    80005e34:	b50080e7          	jalr	-1200(ra) # 80001980 <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80005e38:	00d5179b          	slliw	a5,a0,0xd
    80005e3c:	0c201537          	lui	a0,0xc201
    80005e40:	953e                	add	a0,a0,a5
  return irq;
}
    80005e42:	4148                	lw	a0,4(a0)
    80005e44:	60a2                	ld	ra,8(sp)
    80005e46:	6402                	ld	s0,0(sp)
    80005e48:	0141                	addi	sp,sp,16
    80005e4a:	8082                	ret

0000000080005e4c <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80005e4c:	1101                	addi	sp,sp,-32
    80005e4e:	ec06                	sd	ra,24(sp)
    80005e50:	e822                	sd	s0,16(sp)
    80005e52:	e426                	sd	s1,8(sp)
    80005e54:	1000                	addi	s0,sp,32
    80005e56:	84aa                	mv	s1,a0
  int hart = cpuid();
    80005e58:	ffffc097          	auipc	ra,0xffffc
    80005e5c:	b28080e7          	jalr	-1240(ra) # 80001980 <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80005e60:	00d5151b          	slliw	a0,a0,0xd
    80005e64:	0c2017b7          	lui	a5,0xc201
    80005e68:	97aa                	add	a5,a5,a0
    80005e6a:	c3c4                	sw	s1,4(a5)
}
    80005e6c:	60e2                	ld	ra,24(sp)
    80005e6e:	6442                	ld	s0,16(sp)
    80005e70:	64a2                	ld	s1,8(sp)
    80005e72:	6105                	addi	sp,sp,32
    80005e74:	8082                	ret

0000000080005e76 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80005e76:	1141                	addi	sp,sp,-16
    80005e78:	e406                	sd	ra,8(sp)
    80005e7a:	e022                	sd	s0,0(sp)
    80005e7c:	0800                	addi	s0,sp,16
  if(i >= NUM)
    80005e7e:	479d                	li	a5,7
    80005e80:	04a7cc63          	blt	a5,a0,80005ed8 <free_desc+0x62>
    panic("free_desc 1");
  if(disk.free[i])
    80005e84:	0001c797          	auipc	a5,0x1c
    80005e88:	d8c78793          	addi	a5,a5,-628 # 80021c10 <disk>
    80005e8c:	97aa                	add	a5,a5,a0
    80005e8e:	0187c783          	lbu	a5,24(a5)
    80005e92:	ebb9                	bnez	a5,80005ee8 <free_desc+0x72>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80005e94:	00451613          	slli	a2,a0,0x4
    80005e98:	0001c797          	auipc	a5,0x1c
    80005e9c:	d7878793          	addi	a5,a5,-648 # 80021c10 <disk>
    80005ea0:	6394                	ld	a3,0(a5)
    80005ea2:	96b2                	add	a3,a3,a2
    80005ea4:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    80005ea8:	6398                	ld	a4,0(a5)
    80005eaa:	9732                	add	a4,a4,a2
    80005eac:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    80005eb0:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    80005eb4:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    80005eb8:	953e                	add	a0,a0,a5
    80005eba:	4785                	li	a5,1
    80005ebc:	00f50c23          	sb	a5,24(a0) # c201018 <_entry-0x73dfefe8>
  wakeup(&disk.free[0]);
    80005ec0:	0001c517          	auipc	a0,0x1c
    80005ec4:	d6850513          	addi	a0,a0,-664 # 80021c28 <disk+0x18>
    80005ec8:	ffffc097          	auipc	ra,0xffffc
    80005ecc:	1f0080e7          	jalr	496(ra) # 800020b8 <wakeup>
}
    80005ed0:	60a2                	ld	ra,8(sp)
    80005ed2:	6402                	ld	s0,0(sp)
    80005ed4:	0141                	addi	sp,sp,16
    80005ed6:	8082                	ret
    panic("free_desc 1");
    80005ed8:	00003517          	auipc	a0,0x3
    80005edc:	87850513          	addi	a0,a0,-1928 # 80008750 <syscalls+0x2f8>
    80005ee0:	ffffa097          	auipc	ra,0xffffa
    80005ee4:	65e080e7          	jalr	1630(ra) # 8000053e <panic>
    panic("free_desc 2");
    80005ee8:	00003517          	auipc	a0,0x3
    80005eec:	87850513          	addi	a0,a0,-1928 # 80008760 <syscalls+0x308>
    80005ef0:	ffffa097          	auipc	ra,0xffffa
    80005ef4:	64e080e7          	jalr	1614(ra) # 8000053e <panic>

0000000080005ef8 <virtio_disk_init>:
{
    80005ef8:	1101                	addi	sp,sp,-32
    80005efa:	ec06                	sd	ra,24(sp)
    80005efc:	e822                	sd	s0,16(sp)
    80005efe:	e426                	sd	s1,8(sp)
    80005f00:	e04a                	sd	s2,0(sp)
    80005f02:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80005f04:	00003597          	auipc	a1,0x3
    80005f08:	86c58593          	addi	a1,a1,-1940 # 80008770 <syscalls+0x318>
    80005f0c:	0001c517          	auipc	a0,0x1c
    80005f10:	e2c50513          	addi	a0,a0,-468 # 80021d38 <disk+0x128>
    80005f14:	ffffb097          	auipc	ra,0xffffb
    80005f18:	c32080e7          	jalr	-974(ra) # 80000b46 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005f1c:	100017b7          	lui	a5,0x10001
    80005f20:	4398                	lw	a4,0(a5)
    80005f22:	2701                	sext.w	a4,a4
    80005f24:	747277b7          	lui	a5,0x74727
    80005f28:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80005f2c:	14f71c63          	bne	a4,a5,80006084 <virtio_disk_init+0x18c>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80005f30:	100017b7          	lui	a5,0x10001
    80005f34:	43dc                	lw	a5,4(a5)
    80005f36:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005f38:	4709                	li	a4,2
    80005f3a:	14e79563          	bne	a5,a4,80006084 <virtio_disk_init+0x18c>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005f3e:	100017b7          	lui	a5,0x10001
    80005f42:	479c                	lw	a5,8(a5)
    80005f44:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80005f46:	12e79f63          	bne	a5,a4,80006084 <virtio_disk_init+0x18c>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80005f4a:	100017b7          	lui	a5,0x10001
    80005f4e:	47d8                	lw	a4,12(a5)
    80005f50:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005f52:	554d47b7          	lui	a5,0x554d4
    80005f56:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80005f5a:	12f71563          	bne	a4,a5,80006084 <virtio_disk_init+0x18c>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005f5e:	100017b7          	lui	a5,0x10001
    80005f62:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005f66:	4705                	li	a4,1
    80005f68:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005f6a:	470d                	li	a4,3
    80005f6c:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80005f6e:	4b94                	lw	a3,16(a5)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80005f70:	c7ffe737          	lui	a4,0xc7ffe
    80005f74:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fdca0f>
    80005f78:	8f75                	and	a4,a4,a3
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80005f7a:	2701                	sext.w	a4,a4
    80005f7c:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005f7e:	472d                	li	a4,11
    80005f80:	dbb8                	sw	a4,112(a5)
  status = *R(VIRTIO_MMIO_STATUS);
    80005f82:	5bbc                	lw	a5,112(a5)
    80005f84:	0007891b          	sext.w	s2,a5
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    80005f88:	8ba1                	andi	a5,a5,8
    80005f8a:	10078563          	beqz	a5,80006094 <virtio_disk_init+0x19c>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80005f8e:	100017b7          	lui	a5,0x10001
    80005f92:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    80005f96:	43fc                	lw	a5,68(a5)
    80005f98:	2781                	sext.w	a5,a5
    80005f9a:	10079563          	bnez	a5,800060a4 <virtio_disk_init+0x1ac>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80005f9e:	100017b7          	lui	a5,0x10001
    80005fa2:	5bdc                	lw	a5,52(a5)
    80005fa4:	2781                	sext.w	a5,a5
  if(max == 0)
    80005fa6:	10078763          	beqz	a5,800060b4 <virtio_disk_init+0x1bc>
  if(max < NUM)
    80005faa:	471d                	li	a4,7
    80005fac:	10f77c63          	bgeu	a4,a5,800060c4 <virtio_disk_init+0x1cc>
  disk.desc = kalloc();
    80005fb0:	ffffb097          	auipc	ra,0xffffb
    80005fb4:	b36080e7          	jalr	-1226(ra) # 80000ae6 <kalloc>
    80005fb8:	0001c497          	auipc	s1,0x1c
    80005fbc:	c5848493          	addi	s1,s1,-936 # 80021c10 <disk>
    80005fc0:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    80005fc2:	ffffb097          	auipc	ra,0xffffb
    80005fc6:	b24080e7          	jalr	-1244(ra) # 80000ae6 <kalloc>
    80005fca:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    80005fcc:	ffffb097          	auipc	ra,0xffffb
    80005fd0:	b1a080e7          	jalr	-1254(ra) # 80000ae6 <kalloc>
    80005fd4:	87aa                	mv	a5,a0
    80005fd6:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    80005fd8:	6088                	ld	a0,0(s1)
    80005fda:	cd6d                	beqz	a0,800060d4 <virtio_disk_init+0x1dc>
    80005fdc:	0001c717          	auipc	a4,0x1c
    80005fe0:	c3c73703          	ld	a4,-964(a4) # 80021c18 <disk+0x8>
    80005fe4:	cb65                	beqz	a4,800060d4 <virtio_disk_init+0x1dc>
    80005fe6:	c7fd                	beqz	a5,800060d4 <virtio_disk_init+0x1dc>
  memset(disk.desc, 0, PIGSIZE);
    80005fe8:	6605                	lui	a2,0x1
    80005fea:	4581                	li	a1,0
    80005fec:	ffffb097          	auipc	ra,0xffffb
    80005ff0:	ce6080e7          	jalr	-794(ra) # 80000cd2 <memset>
  memset(disk.avail, 0, PIGSIZE);
    80005ff4:	0001c497          	auipc	s1,0x1c
    80005ff8:	c1c48493          	addi	s1,s1,-996 # 80021c10 <disk>
    80005ffc:	6605                	lui	a2,0x1
    80005ffe:	4581                	li	a1,0
    80006000:	6488                	ld	a0,8(s1)
    80006002:	ffffb097          	auipc	ra,0xffffb
    80006006:	cd0080e7          	jalr	-816(ra) # 80000cd2 <memset>
  memset(disk.used, 0, PIGSIZE);
    8000600a:	6605                	lui	a2,0x1
    8000600c:	4581                	li	a1,0
    8000600e:	6888                	ld	a0,16(s1)
    80006010:	ffffb097          	auipc	ra,0xffffb
    80006014:	cc2080e7          	jalr	-830(ra) # 80000cd2 <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80006018:	100017b7          	lui	a5,0x10001
    8000601c:	4721                	li	a4,8
    8000601e:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    80006020:	4098                	lw	a4,0(s1)
    80006022:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    80006026:	40d8                	lw	a4,4(s1)
    80006028:	08e7a223          	sw	a4,132(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    8000602c:	6498                	ld	a4,8(s1)
    8000602e:	0007069b          	sext.w	a3,a4
    80006032:	08d7a823          	sw	a3,144(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    80006036:	9701                	srai	a4,a4,0x20
    80006038:	08e7aa23          	sw	a4,148(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    8000603c:	6898                	ld	a4,16(s1)
    8000603e:	0007069b          	sext.w	a3,a4
    80006042:	0ad7a023          	sw	a3,160(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    80006046:	9701                	srai	a4,a4,0x20
    80006048:	0ae7a223          	sw	a4,164(a5)
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    8000604c:	4705                	li	a4,1
    8000604e:	c3f8                	sw	a4,68(a5)
    disk.free[i] = 1;
    80006050:	00e48c23          	sb	a4,24(s1)
    80006054:	00e48ca3          	sb	a4,25(s1)
    80006058:	00e48d23          	sb	a4,26(s1)
    8000605c:	00e48da3          	sb	a4,27(s1)
    80006060:	00e48e23          	sb	a4,28(s1)
    80006064:	00e48ea3          	sb	a4,29(s1)
    80006068:	00e48f23          	sb	a4,30(s1)
    8000606c:	00e48fa3          	sb	a4,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    80006070:	00496913          	ori	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    80006074:	0727a823          	sw	s2,112(a5)
}
    80006078:	60e2                	ld	ra,24(sp)
    8000607a:	6442                	ld	s0,16(sp)
    8000607c:	64a2                	ld	s1,8(sp)
    8000607e:	6902                	ld	s2,0(sp)
    80006080:	6105                	addi	sp,sp,32
    80006082:	8082                	ret
    panic("could not find virtio disk");
    80006084:	00002517          	auipc	a0,0x2
    80006088:	6fc50513          	addi	a0,a0,1788 # 80008780 <syscalls+0x328>
    8000608c:	ffffa097          	auipc	ra,0xffffa
    80006090:	4b2080e7          	jalr	1202(ra) # 8000053e <panic>
    panic("virtio disk FEATURES_OK unset");
    80006094:	00002517          	auipc	a0,0x2
    80006098:	70c50513          	addi	a0,a0,1804 # 800087a0 <syscalls+0x348>
    8000609c:	ffffa097          	auipc	ra,0xffffa
    800060a0:	4a2080e7          	jalr	1186(ra) # 8000053e <panic>
    panic("virtio disk should not be ready");
    800060a4:	00002517          	auipc	a0,0x2
    800060a8:	71c50513          	addi	a0,a0,1820 # 800087c0 <syscalls+0x368>
    800060ac:	ffffa097          	auipc	ra,0xffffa
    800060b0:	492080e7          	jalr	1170(ra) # 8000053e <panic>
    panic("virtio disk has no queue 0");
    800060b4:	00002517          	auipc	a0,0x2
    800060b8:	72c50513          	addi	a0,a0,1836 # 800087e0 <syscalls+0x388>
    800060bc:	ffffa097          	auipc	ra,0xffffa
    800060c0:	482080e7          	jalr	1154(ra) # 8000053e <panic>
    panic("virtio disk max queue too short");
    800060c4:	00002517          	auipc	a0,0x2
    800060c8:	73c50513          	addi	a0,a0,1852 # 80008800 <syscalls+0x3a8>
    800060cc:	ffffa097          	auipc	ra,0xffffa
    800060d0:	472080e7          	jalr	1138(ra) # 8000053e <panic>
    panic("virtio disk kalloc");
    800060d4:	00002517          	auipc	a0,0x2
    800060d8:	74c50513          	addi	a0,a0,1868 # 80008820 <syscalls+0x3c8>
    800060dc:	ffffa097          	auipc	ra,0xffffa
    800060e0:	462080e7          	jalr	1122(ra) # 8000053e <panic>

00000000800060e4 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    800060e4:	7119                	addi	sp,sp,-128
    800060e6:	fc86                	sd	ra,120(sp)
    800060e8:	f8a2                	sd	s0,112(sp)
    800060ea:	f4a6                	sd	s1,104(sp)
    800060ec:	f0ca                	sd	s2,96(sp)
    800060ee:	ecce                	sd	s3,88(sp)
    800060f0:	e8d2                	sd	s4,80(sp)
    800060f2:	e4d6                	sd	s5,72(sp)
    800060f4:	e0da                	sd	s6,64(sp)
    800060f6:	fc5e                	sd	s7,56(sp)
    800060f8:	f862                	sd	s8,48(sp)
    800060fa:	f466                	sd	s9,40(sp)
    800060fc:	f06a                	sd	s10,32(sp)
    800060fe:	ec6e                	sd	s11,24(sp)
    80006100:	0100                	addi	s0,sp,128
    80006102:	8aaa                	mv	s5,a0
    80006104:	8c2e                	mv	s8,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80006106:	00c52d03          	lw	s10,12(a0)
    8000610a:	001d1d1b          	slliw	s10,s10,0x1
    8000610e:	1d02                	slli	s10,s10,0x20
    80006110:	020d5d13          	srli	s10,s10,0x20

  acquire(&disk.vdisk_lock);
    80006114:	0001c517          	auipc	a0,0x1c
    80006118:	c2450513          	addi	a0,a0,-988 # 80021d38 <disk+0x128>
    8000611c:	ffffb097          	auipc	ra,0xffffb
    80006120:	aba080e7          	jalr	-1350(ra) # 80000bd6 <acquire>
  for(int i = 0; i < 3; i++){
    80006124:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    80006126:	44a1                	li	s1,8
      disk.free[i] = 0;
    80006128:	0001cb97          	auipc	s7,0x1c
    8000612c:	ae8b8b93          	addi	s7,s7,-1304 # 80021c10 <disk>
  for(int i = 0; i < 3; i++){
    80006130:	4b0d                	li	s6,3
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80006132:	0001cc97          	auipc	s9,0x1c
    80006136:	c06c8c93          	addi	s9,s9,-1018 # 80021d38 <disk+0x128>
    8000613a:	a08d                	j	8000619c <virtio_disk_rw+0xb8>
      disk.free[i] = 0;
    8000613c:	00fb8733          	add	a4,s7,a5
    80006140:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    80006144:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    80006146:	0207c563          	bltz	a5,80006170 <virtio_disk_rw+0x8c>
  for(int i = 0; i < 3; i++){
    8000614a:	2905                	addiw	s2,s2,1
    8000614c:	0611                	addi	a2,a2,4
    8000614e:	05690c63          	beq	s2,s6,800061a6 <virtio_disk_rw+0xc2>
    idx[i] = alloc_desc();
    80006152:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    80006154:	0001c717          	auipc	a4,0x1c
    80006158:	abc70713          	addi	a4,a4,-1348 # 80021c10 <disk>
    8000615c:	87ce                	mv	a5,s3
    if(disk.free[i]){
    8000615e:	01874683          	lbu	a3,24(a4)
    80006162:	fee9                	bnez	a3,8000613c <virtio_disk_rw+0x58>
  for(int i = 0; i < NUM; i++){
    80006164:	2785                	addiw	a5,a5,1
    80006166:	0705                	addi	a4,a4,1
    80006168:	fe979be3          	bne	a5,s1,8000615e <virtio_disk_rw+0x7a>
    idx[i] = alloc_desc();
    8000616c:	57fd                	li	a5,-1
    8000616e:	c19c                	sw	a5,0(a1)
      for(int j = 0; j < i; j++)
    80006170:	01205d63          	blez	s2,8000618a <virtio_disk_rw+0xa6>
    80006174:	8dce                	mv	s11,s3
        free_desc(idx[j]);
    80006176:	000a2503          	lw	a0,0(s4)
    8000617a:	00000097          	auipc	ra,0x0
    8000617e:	cfc080e7          	jalr	-772(ra) # 80005e76 <free_desc>
      for(int j = 0; j < i; j++)
    80006182:	2d85                	addiw	s11,s11,1
    80006184:	0a11                	addi	s4,s4,4
    80006186:	ffb918e3          	bne	s2,s11,80006176 <virtio_disk_rw+0x92>
    sleep(&disk.free[0], &disk.vdisk_lock);
    8000618a:	85e6                	mv	a1,s9
    8000618c:	0001c517          	auipc	a0,0x1c
    80006190:	a9c50513          	addi	a0,a0,-1380 # 80021c28 <disk+0x18>
    80006194:	ffffc097          	auipc	ra,0xffffc
    80006198:	ec0080e7          	jalr	-320(ra) # 80002054 <sleep>
  for(int i = 0; i < 3; i++){
    8000619c:	f8040a13          	addi	s4,s0,-128
{
    800061a0:	8652                	mv	a2,s4
  for(int i = 0; i < 3; i++){
    800061a2:	894e                	mv	s2,s3
    800061a4:	b77d                	j	80006152 <virtio_disk_rw+0x6e>
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800061a6:	f8042583          	lw	a1,-128(s0)
    800061aa:	00a58793          	addi	a5,a1,10
    800061ae:	0792                	slli	a5,a5,0x4

  if(write)
    800061b0:	0001c617          	auipc	a2,0x1c
    800061b4:	a6060613          	addi	a2,a2,-1440 # 80021c10 <disk>
    800061b8:	00f60733          	add	a4,a2,a5
    800061bc:	018036b3          	snez	a3,s8
    800061c0:	c714                	sw	a3,8(a4)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    800061c2:	00072623          	sw	zero,12(a4)
  buf0->sector = sector;
    800061c6:	01a73823          	sd	s10,16(a4)

  disk.desc[idx[0]].addr = (uint64) buf0;
    800061ca:	f6078693          	addi	a3,a5,-160
    800061ce:	6218                	ld	a4,0(a2)
    800061d0:	9736                	add	a4,a4,a3
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800061d2:	00878513          	addi	a0,a5,8
    800061d6:	9532                	add	a0,a0,a2
  disk.desc[idx[0]].addr = (uint64) buf0;
    800061d8:	e308                	sd	a0,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    800061da:	6208                	ld	a0,0(a2)
    800061dc:	96aa                	add	a3,a3,a0
    800061de:	4741                	li	a4,16
    800061e0:	c698                	sw	a4,8(a3)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800061e2:	4705                	li	a4,1
    800061e4:	00e69623          	sh	a4,12(a3)
  disk.desc[idx[0]].next = idx[1];
    800061e8:	f8442703          	lw	a4,-124(s0)
    800061ec:	00e69723          	sh	a4,14(a3)

  disk.desc[idx[1]].addr = (uint64) b->data;
    800061f0:	0712                	slli	a4,a4,0x4
    800061f2:	953a                	add	a0,a0,a4
    800061f4:	058a8693          	addi	a3,s5,88
    800061f8:	e114                	sd	a3,0(a0)
  disk.desc[idx[1]].len = BSIZE;
    800061fa:	6208                	ld	a0,0(a2)
    800061fc:	972a                	add	a4,a4,a0
    800061fe:	40000693          	li	a3,1024
    80006202:	c714                	sw	a3,8(a4)
  if(write)
    disk.desc[idx[1]].flags = 0; // device reads b->data
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80006204:	001c3c13          	seqz	s8,s8
    80006208:	0c06                	slli	s8,s8,0x1
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    8000620a:	001c6c13          	ori	s8,s8,1
    8000620e:	01871623          	sh	s8,12(a4)
  disk.desc[idx[1]].next = idx[2];
    80006212:	f8842603          	lw	a2,-120(s0)
    80006216:	00c71723          	sh	a2,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    8000621a:	0001c697          	auipc	a3,0x1c
    8000621e:	9f668693          	addi	a3,a3,-1546 # 80021c10 <disk>
    80006222:	00258713          	addi	a4,a1,2
    80006226:	0712                	slli	a4,a4,0x4
    80006228:	9736                	add	a4,a4,a3
    8000622a:	587d                	li	a6,-1
    8000622c:	01070823          	sb	a6,16(a4)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80006230:	0612                	slli	a2,a2,0x4
    80006232:	9532                	add	a0,a0,a2
    80006234:	f9078793          	addi	a5,a5,-112
    80006238:	97b6                	add	a5,a5,a3
    8000623a:	e11c                	sd	a5,0(a0)
  disk.desc[idx[2]].len = 1;
    8000623c:	629c                	ld	a5,0(a3)
    8000623e:	97b2                	add	a5,a5,a2
    80006240:	4605                	li	a2,1
    80006242:	c790                	sw	a2,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80006244:	4509                	li	a0,2
    80006246:	00a79623          	sh	a0,12(a5)
  disk.desc[idx[2]].next = 0;
    8000624a:	00079723          	sh	zero,14(a5)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    8000624e:	00caa223          	sw	a2,4(s5)
  disk.info[idx[0]].b = b;
    80006252:	01573423          	sd	s5,8(a4)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80006256:	6698                	ld	a4,8(a3)
    80006258:	00275783          	lhu	a5,2(a4)
    8000625c:	8b9d                	andi	a5,a5,7
    8000625e:	0786                	slli	a5,a5,0x1
    80006260:	97ba                	add	a5,a5,a4
    80006262:	00b79223          	sh	a1,4(a5)

  __sync_synchronize();
    80006266:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    8000626a:	6698                	ld	a4,8(a3)
    8000626c:	00275783          	lhu	a5,2(a4)
    80006270:	2785                	addiw	a5,a5,1
    80006272:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80006276:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    8000627a:	100017b7          	lui	a5,0x10001
    8000627e:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80006282:	004aa783          	lw	a5,4(s5)
    80006286:	02c79163          	bne	a5,a2,800062a8 <virtio_disk_rw+0x1c4>
    sleep(b, &disk.vdisk_lock);
    8000628a:	0001c917          	auipc	s2,0x1c
    8000628e:	aae90913          	addi	s2,s2,-1362 # 80021d38 <disk+0x128>
  while(b->disk == 1) {
    80006292:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    80006294:	85ca                	mv	a1,s2
    80006296:	8556                	mv	a0,s5
    80006298:	ffffc097          	auipc	ra,0xffffc
    8000629c:	dbc080e7          	jalr	-580(ra) # 80002054 <sleep>
  while(b->disk == 1) {
    800062a0:	004aa783          	lw	a5,4(s5)
    800062a4:	fe9788e3          	beq	a5,s1,80006294 <virtio_disk_rw+0x1b0>
  }

  disk.info[idx[0]].b = 0;
    800062a8:	f8042903          	lw	s2,-128(s0)
    800062ac:	00290793          	addi	a5,s2,2
    800062b0:	00479713          	slli	a4,a5,0x4
    800062b4:	0001c797          	auipc	a5,0x1c
    800062b8:	95c78793          	addi	a5,a5,-1700 # 80021c10 <disk>
    800062bc:	97ba                	add	a5,a5,a4
    800062be:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    800062c2:	0001c997          	auipc	s3,0x1c
    800062c6:	94e98993          	addi	s3,s3,-1714 # 80021c10 <disk>
    800062ca:	00491713          	slli	a4,s2,0x4
    800062ce:	0009b783          	ld	a5,0(s3)
    800062d2:	97ba                	add	a5,a5,a4
    800062d4:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    800062d8:	854a                	mv	a0,s2
    800062da:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    800062de:	00000097          	auipc	ra,0x0
    800062e2:	b98080e7          	jalr	-1128(ra) # 80005e76 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    800062e6:	8885                	andi	s1,s1,1
    800062e8:	f0ed                	bnez	s1,800062ca <virtio_disk_rw+0x1e6>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    800062ea:	0001c517          	auipc	a0,0x1c
    800062ee:	a4e50513          	addi	a0,a0,-1458 # 80021d38 <disk+0x128>
    800062f2:	ffffb097          	auipc	ra,0xffffb
    800062f6:	998080e7          	jalr	-1640(ra) # 80000c8a <release>
}
    800062fa:	70e6                	ld	ra,120(sp)
    800062fc:	7446                	ld	s0,112(sp)
    800062fe:	74a6                	ld	s1,104(sp)
    80006300:	7906                	ld	s2,96(sp)
    80006302:	69e6                	ld	s3,88(sp)
    80006304:	6a46                	ld	s4,80(sp)
    80006306:	6aa6                	ld	s5,72(sp)
    80006308:	6b06                	ld	s6,64(sp)
    8000630a:	7be2                	ld	s7,56(sp)
    8000630c:	7c42                	ld	s8,48(sp)
    8000630e:	7ca2                	ld	s9,40(sp)
    80006310:	7d02                	ld	s10,32(sp)
    80006312:	6de2                	ld	s11,24(sp)
    80006314:	6109                	addi	sp,sp,128
    80006316:	8082                	ret

0000000080006318 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80006318:	1101                	addi	sp,sp,-32
    8000631a:	ec06                	sd	ra,24(sp)
    8000631c:	e822                	sd	s0,16(sp)
    8000631e:	e426                	sd	s1,8(sp)
    80006320:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80006322:	0001c497          	auipc	s1,0x1c
    80006326:	8ee48493          	addi	s1,s1,-1810 # 80021c10 <disk>
    8000632a:	0001c517          	auipc	a0,0x1c
    8000632e:	a0e50513          	addi	a0,a0,-1522 # 80021d38 <disk+0x128>
    80006332:	ffffb097          	auipc	ra,0xffffb
    80006336:	8a4080e7          	jalr	-1884(ra) # 80000bd6 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    8000633a:	10001737          	lui	a4,0x10001
    8000633e:	533c                	lw	a5,96(a4)
    80006340:	8b8d                	andi	a5,a5,3
    80006342:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    80006344:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80006348:	689c                	ld	a5,16(s1)
    8000634a:	0204d703          	lhu	a4,32(s1)
    8000634e:	0027d783          	lhu	a5,2(a5)
    80006352:	04f70863          	beq	a4,a5,800063a2 <virtio_disk_intr+0x8a>
    __sync_synchronize();
    80006356:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    8000635a:	6898                	ld	a4,16(s1)
    8000635c:	0204d783          	lhu	a5,32(s1)
    80006360:	8b9d                	andi	a5,a5,7
    80006362:	078e                	slli	a5,a5,0x3
    80006364:	97ba                	add	a5,a5,a4
    80006366:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80006368:	00278713          	addi	a4,a5,2
    8000636c:	0712                	slli	a4,a4,0x4
    8000636e:	9726                	add	a4,a4,s1
    80006370:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    80006374:	e721                	bnez	a4,800063bc <virtio_disk_intr+0xa4>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80006376:	0789                	addi	a5,a5,2
    80006378:	0792                	slli	a5,a5,0x4
    8000637a:	97a6                	add	a5,a5,s1
    8000637c:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    8000637e:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80006382:	ffffc097          	auipc	ra,0xffffc
    80006386:	d36080e7          	jalr	-714(ra) # 800020b8 <wakeup>

    disk.used_idx += 1;
    8000638a:	0204d783          	lhu	a5,32(s1)
    8000638e:	2785                	addiw	a5,a5,1
    80006390:	17c2                	slli	a5,a5,0x30
    80006392:	93c1                	srli	a5,a5,0x30
    80006394:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80006398:	6898                	ld	a4,16(s1)
    8000639a:	00275703          	lhu	a4,2(a4)
    8000639e:	faf71ce3          	bne	a4,a5,80006356 <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    800063a2:	0001c517          	auipc	a0,0x1c
    800063a6:	99650513          	addi	a0,a0,-1642 # 80021d38 <disk+0x128>
    800063aa:	ffffb097          	auipc	ra,0xffffb
    800063ae:	8e0080e7          	jalr	-1824(ra) # 80000c8a <release>
}
    800063b2:	60e2                	ld	ra,24(sp)
    800063b4:	6442                	ld	s0,16(sp)
    800063b6:	64a2                	ld	s1,8(sp)
    800063b8:	6105                	addi	sp,sp,32
    800063ba:	8082                	ret
      panic("virtio_disk_intr status");
    800063bc:	00002517          	auipc	a0,0x2
    800063c0:	47c50513          	addi	a0,a0,1148 # 80008838 <syscalls+0x3e0>
    800063c4:	ffffa097          	auipc	ra,0xffffa
    800063c8:	17a080e7          	jalr	378(ra) # 8000053e <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051073          	csrw	sscratch,a0
    80007004:	02000537          	lui	a0,0x2000
    80007008:	357d                	addiw	a0,a0,-1
    8000700a:	0536                	slli	a0,a0,0xd
    8000700c:	02153423          	sd	ra,40(a0) # 2000028 <_entry-0x7dffffd8>
    80007010:	02253823          	sd	sp,48(a0)
    80007014:	02353c23          	sd	gp,56(a0)
    80007018:	04453023          	sd	tp,64(a0)
    8000701c:	04553423          	sd	t0,72(a0)
    80007020:	04653823          	sd	t1,80(a0)
    80007024:	04753c23          	sd	t2,88(a0)
    80007028:	f120                	sd	s0,96(a0)
    8000702a:	f524                	sd	s1,104(a0)
    8000702c:	fd2c                	sd	a1,120(a0)
    8000702e:	e150                	sd	a2,128(a0)
    80007030:	e554                	sd	a3,136(a0)
    80007032:	e958                	sd	a4,144(a0)
    80007034:	ed5c                	sd	a5,152(a0)
    80007036:	0b053023          	sd	a6,160(a0)
    8000703a:	0b153423          	sd	a7,168(a0)
    8000703e:	0b253823          	sd	s2,176(a0)
    80007042:	0b353c23          	sd	s3,184(a0)
    80007046:	0d453023          	sd	s4,192(a0)
    8000704a:	0d553423          	sd	s5,200(a0)
    8000704e:	0d653823          	sd	s6,208(a0)
    80007052:	0d753c23          	sd	s7,216(a0)
    80007056:	0f853023          	sd	s8,224(a0)
    8000705a:	0f953423          	sd	s9,232(a0)
    8000705e:	0fa53823          	sd	s10,240(a0)
    80007062:	0fb53c23          	sd	s11,248(a0)
    80007066:	11c53023          	sd	t3,256(a0)
    8000706a:	11d53423          	sd	t4,264(a0)
    8000706e:	11e53823          	sd	t5,272(a0)
    80007072:	11f53c23          	sd	t6,280(a0)
    80007076:	140022f3          	csrr	t0,sscratch
    8000707a:	06553823          	sd	t0,112(a0)
    8000707e:	00853103          	ld	sp,8(a0)
    80007082:	02053203          	ld	tp,32(a0)
    80007086:	01053283          	ld	t0,16(a0)
    8000708a:	00053303          	ld	t1,0(a0)
    8000708e:	12000073          	sfence.vma
    80007092:	18031073          	csrw	satp,t1
    80007096:	12000073          	sfence.vma
    8000709a:	8282                	jr	t0

000000008000709c <userret>:
    8000709c:	12000073          	sfence.vma
    800070a0:	18051073          	csrw	satp,a0
    800070a4:	12000073          	sfence.vma
    800070a8:	02000537          	lui	a0,0x2000
    800070ac:	357d                	addiw	a0,a0,-1
    800070ae:	0536                	slli	a0,a0,0xd
    800070b0:	02853083          	ld	ra,40(a0) # 2000028 <_entry-0x7dffffd8>
    800070b4:	03053103          	ld	sp,48(a0)
    800070b8:	03853183          	ld	gp,56(a0)
    800070bc:	04053203          	ld	tp,64(a0)
    800070c0:	04853283          	ld	t0,72(a0)
    800070c4:	05053303          	ld	t1,80(a0)
    800070c8:	05853383          	ld	t2,88(a0)
    800070cc:	7120                	ld	s0,96(a0)
    800070ce:	7524                	ld	s1,104(a0)
    800070d0:	7d2c                	ld	a1,120(a0)
    800070d2:	6150                	ld	a2,128(a0)
    800070d4:	6554                	ld	a3,136(a0)
    800070d6:	6958                	ld	a4,144(a0)
    800070d8:	6d5c                	ld	a5,152(a0)
    800070da:	0a053803          	ld	a6,160(a0)
    800070de:	0a853883          	ld	a7,168(a0)
    800070e2:	0b053903          	ld	s2,176(a0)
    800070e6:	0b853983          	ld	s3,184(a0)
    800070ea:	0c053a03          	ld	s4,192(a0)
    800070ee:	0c853a83          	ld	s5,200(a0)
    800070f2:	0d053b03          	ld	s6,208(a0)
    800070f6:	0d853b83          	ld	s7,216(a0)
    800070fa:	0e053c03          	ld	s8,224(a0)
    800070fe:	0e853c83          	ld	s9,232(a0)
    80007102:	0f053d03          	ld	s10,240(a0)
    80007106:	0f853d83          	ld	s11,248(a0)
    8000710a:	10053e03          	ld	t3,256(a0)
    8000710e:	10853e83          	ld	t4,264(a0)
    80007112:	11053f03          	ld	t5,272(a0)
    80007116:	11853f83          	ld	t6,280(a0)
    8000711a:	7928                	ld	a0,112(a0)
    8000711c:	10200073          	sret
	...
