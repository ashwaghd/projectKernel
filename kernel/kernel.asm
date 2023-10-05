
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	a6010113          	addi	sp,sp,-1440 # 80008a60 <stack0>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	078000ef          	jal	ra,8000008e <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <timerinit>:
    8000001c:	1141                	addi	sp,sp,-16
    8000001e:	e422                	sd	s0,8(sp)
    80000020:	0800                	addi	s0,sp,16
    80000022:	f14027f3          	csrr	a5,mhartid
    80000026:	0007869b          	sext.w	a3,a5
    8000002a:	0037979b          	slliw	a5,a5,0x3
    8000002e:	02004737          	lui	a4,0x2004
    80000032:	97ba                	add	a5,a5,a4
    80000034:	0200c737          	lui	a4,0x200c
    80000038:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000003c:	000f4637          	lui	a2,0xf4
    80000040:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80000044:	95b2                	add	a1,a1,a2
    80000046:	e38c                	sd	a1,0(a5)
    80000048:	00269713          	slli	a4,a3,0x2
    8000004c:	9736                	add	a4,a4,a3
    8000004e:	00371693          	slli	a3,a4,0x3
    80000052:	00009717          	auipc	a4,0x9
    80000056:	8ce70713          	addi	a4,a4,-1842 # 80008920 <timer_scratch>
    8000005a:	9736                	add	a4,a4,a3
    8000005c:	ef1c                	sd	a5,24(a4)
    8000005e:	f310                	sd	a2,32(a4)
    80000060:	34071073          	csrw	mscratch,a4
    80000064:	00006797          	auipc	a5,0x6
    80000068:	f9c78793          	addi	a5,a5,-100 # 80006000 <timervec>
    8000006c:	30579073          	csrw	mtvec,a5
    80000070:	300027f3          	csrr	a5,mstatus
    80000074:	0087e793          	ori	a5,a5,8
    80000078:	30079073          	csrw	mstatus,a5
    8000007c:	304027f3          	csrr	a5,mie
    80000080:	0807e793          	ori	a5,a5,128
    80000084:	30479073          	csrw	mie,a5
    80000088:	6422                	ld	s0,8(sp)
    8000008a:	0141                	addi	sp,sp,16
    8000008c:	8082                	ret

000000008000008e <start>:
    8000008e:	1141                	addi	sp,sp,-16
    80000090:	e406                	sd	ra,8(sp)
    80000092:	e022                	sd	s0,0(sp)
    80000094:	0800                	addi	s0,sp,16
    80000096:	300027f3          	csrr	a5,mstatus
    8000009a:	7779                	lui	a4,0xffffe
    8000009c:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffdca6f>
    800000a0:	8ff9                	and	a5,a5,a4
    800000a2:	6705                	lui	a4,0x1
    800000a4:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800000a8:	8fd9                	or	a5,a5,a4
    800000aa:	30079073          	csrw	mstatus,a5
    800000ae:	00001797          	auipc	a5,0x1
    800000b2:	dca78793          	addi	a5,a5,-566 # 80000e78 <main>
    800000b6:	34179073          	csrw	mepc,a5
    800000ba:	4781                	li	a5,0
    800000bc:	18079073          	csrw	satp,a5
    800000c0:	67c1                	lui	a5,0x10
    800000c2:	17fd                	addi	a5,a5,-1
    800000c4:	30279073          	csrw	medeleg,a5
    800000c8:	30379073          	csrw	mideleg,a5
    800000cc:	104027f3          	csrr	a5,sie
    800000d0:	2227e793          	ori	a5,a5,546
    800000d4:	10479073          	csrw	sie,a5
    800000d8:	57fd                	li	a5,-1
    800000da:	83a9                	srli	a5,a5,0xa
    800000dc:	3b079073          	csrw	pmpaddr0,a5
    800000e0:	47bd                	li	a5,15
    800000e2:	3a079073          	csrw	pmpcfg0,a5
    800000e6:	00000097          	auipc	ra,0x0
    800000ea:	f36080e7          	jalr	-202(ra) # 8000001c <timerinit>
    800000ee:	f14027f3          	csrr	a5,mhartid
    800000f2:	2781                	sext.w	a5,a5
    800000f4:	823e                	mv	tp,a5
    800000f6:	30200073          	mret
    800000fa:	60a2                	ld	ra,8(sp)
    800000fc:	6402                	ld	s0,0(sp)
    800000fe:	0141                	addi	sp,sp,16
    80000100:	8082                	ret

0000000080000102 <consolewrite>:
    80000102:	715d                	addi	sp,sp,-80
    80000104:	e486                	sd	ra,72(sp)
    80000106:	e0a2                	sd	s0,64(sp)
    80000108:	fc26                	sd	s1,56(sp)
    8000010a:	f84a                	sd	s2,48(sp)
    8000010c:	f44e                	sd	s3,40(sp)
    8000010e:	f052                	sd	s4,32(sp)
    80000110:	ec56                	sd	s5,24(sp)
    80000112:	0880                	addi	s0,sp,80
    80000114:	04c05663          	blez	a2,80000160 <consolewrite+0x5e>
    80000118:	8a2a                	mv	s4,a0
    8000011a:	84ae                	mv	s1,a1
    8000011c:	89b2                	mv	s3,a2
    8000011e:	4901                	li	s2,0
    80000120:	5afd                	li	s5,-1
    80000122:	4685                	li	a3,1
    80000124:	8626                	mv	a2,s1
    80000126:	85d2                	mv	a1,s4
    80000128:	fbf40513          	addi	a0,s0,-65
    8000012c:	00002097          	auipc	ra,0x2
    80000130:	7be080e7          	jalr	1982(ra) # 800028ea <either_copyin>
    80000134:	01550c63          	beq	a0,s5,8000014c <consolewrite+0x4a>
    80000138:	fbf44503          	lbu	a0,-65(s0)
    8000013c:	00000097          	auipc	ra,0x0
    80000140:	780080e7          	jalr	1920(ra) # 800008bc <uartputc>
    80000144:	2905                	addiw	s2,s2,1
    80000146:	0485                	addi	s1,s1,1
    80000148:	fd299de3          	bne	s3,s2,80000122 <consolewrite+0x20>
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
    80000160:	4901                	li	s2,0
    80000162:	b7ed                	j	8000014c <consolewrite+0x4a>

0000000080000164 <consoleread>:
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
    80000186:	00060b1b          	sext.w	s6,a2
    8000018a:	00011517          	auipc	a0,0x11
    8000018e:	8d650513          	addi	a0,a0,-1834 # 80010a60 <cons>
    80000192:	00001097          	auipc	ra,0x1
    80000196:	a44080e7          	jalr	-1468(ra) # 80000bd6 <acquire>
    8000019a:	00011497          	auipc	s1,0x11
    8000019e:	8c648493          	addi	s1,s1,-1850 # 80010a60 <cons>
    800001a2:	00011917          	auipc	s2,0x11
    800001a6:	95690913          	addi	s2,s2,-1706 # 80010af8 <cons+0x98>
    800001aa:	4b91                	li	s7,4
    800001ac:	5c7d                	li	s8,-1
    800001ae:	4ca9                	li	s9,10
    800001b0:	07305b63          	blez	s3,80000226 <consoleread+0xc2>
    800001b4:	0984a783          	lw	a5,152(s1)
    800001b8:	09c4a703          	lw	a4,156(s1)
    800001bc:	02f71763          	bne	a4,a5,800001ea <consoleread+0x86>
    800001c0:	00001097          	auipc	ra,0x1
    800001c4:	7ec080e7          	jalr	2028(ra) # 800019ac <myproc>
    800001c8:	00002097          	auipc	ra,0x2
    800001cc:	56c080e7          	jalr	1388(ra) # 80002734 <killed>
    800001d0:	e535                	bnez	a0,8000023c <consoleread+0xd8>
    800001d2:	85a6                	mv	a1,s1
    800001d4:	854a                	mv	a0,s2
    800001d6:	00002097          	auipc	ra,0x2
    800001da:	e7e080e7          	jalr	-386(ra) # 80002054 <sleep>
    800001de:	0984a783          	lw	a5,152(s1)
    800001e2:	09c4a703          	lw	a4,156(s1)
    800001e6:	fcf70de3          	beq	a4,a5,800001c0 <consoleread+0x5c>
    800001ea:	0017871b          	addiw	a4,a5,1
    800001ee:	08e4ac23          	sw	a4,152(s1)
    800001f2:	07f7f713          	andi	a4,a5,127
    800001f6:	9726                	add	a4,a4,s1
    800001f8:	01874703          	lbu	a4,24(a4)
    800001fc:	00070d1b          	sext.w	s10,a4
    80000200:	077d0563          	beq	s10,s7,8000026a <consoleread+0x106>
    80000204:	f8e40fa3          	sb	a4,-97(s0)
    80000208:	4685                	li	a3,1
    8000020a:	f9f40613          	addi	a2,s0,-97
    8000020e:	85d2                	mv	a1,s4
    80000210:	8556                	mv	a0,s5
    80000212:	00002097          	auipc	ra,0x2
    80000216:	682080e7          	jalr	1666(ra) # 80002894 <either_copyout>
    8000021a:	01850663          	beq	a0,s8,80000226 <consoleread+0xc2>
    8000021e:	0a05                	addi	s4,s4,1
    80000220:	39fd                	addiw	s3,s3,-1
    80000222:	f99d17e3          	bne	s10,s9,800001b0 <consoleread+0x4c>
    80000226:	00011517          	auipc	a0,0x11
    8000022a:	83a50513          	addi	a0,a0,-1990 # 80010a60 <cons>
    8000022e:	00001097          	auipc	ra,0x1
    80000232:	a5c080e7          	jalr	-1444(ra) # 80000c8a <release>
    80000236:	413b053b          	subw	a0,s6,s3
    8000023a:	a811                	j	8000024e <consoleread+0xea>
    8000023c:	00011517          	auipc	a0,0x11
    80000240:	82450513          	addi	a0,a0,-2012 # 80010a60 <cons>
    80000244:	00001097          	auipc	ra,0x1
    80000248:	a46080e7          	jalr	-1466(ra) # 80000c8a <release>
    8000024c:	557d                	li	a0,-1
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
    8000026a:	0009871b          	sext.w	a4,s3
    8000026e:	fb677ce3          	bgeu	a4,s6,80000226 <consoleread+0xc2>
    80000272:	00011717          	auipc	a4,0x11
    80000276:	88f72323          	sw	a5,-1914(a4) # 80010af8 <cons+0x98>
    8000027a:	b775                	j	80000226 <consoleread+0xc2>

000000008000027c <consputc>:
    8000027c:	1141                	addi	sp,sp,-16
    8000027e:	e406                	sd	ra,8(sp)
    80000280:	e022                	sd	s0,0(sp)
    80000282:	0800                	addi	s0,sp,16
    80000284:	10000793          	li	a5,256
    80000288:	00f50a63          	beq	a0,a5,8000029c <consputc+0x20>
    8000028c:	00000097          	auipc	ra,0x0
    80000290:	55e080e7          	jalr	1374(ra) # 800007ea <uartputc_sync>
    80000294:	60a2                	ld	ra,8(sp)
    80000296:	6402                	ld	s0,0(sp)
    80000298:	0141                	addi	sp,sp,16
    8000029a:	8082                	ret
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
    800002be:	1101                	addi	sp,sp,-32
    800002c0:	ec06                	sd	ra,24(sp)
    800002c2:	e822                	sd	s0,16(sp)
    800002c4:	e426                	sd	s1,8(sp)
    800002c6:	e04a                	sd	s2,0(sp)
    800002c8:	1000                	addi	s0,sp,32
    800002ca:	84aa                	mv	s1,a0
    800002cc:	00010517          	auipc	a0,0x10
    800002d0:	79450513          	addi	a0,a0,1940 # 80010a60 <cons>
    800002d4:	00001097          	auipc	ra,0x1
    800002d8:	902080e7          	jalr	-1790(ra) # 80000bd6 <acquire>
    800002dc:	47d5                	li	a5,21
    800002de:	0af48663          	beq	s1,a5,8000038a <consoleintr+0xcc>
    800002e2:	0297ca63          	blt	a5,s1,80000316 <consoleintr+0x58>
    800002e6:	47a1                	li	a5,8
    800002e8:	0ef48763          	beq	s1,a5,800003d6 <consoleintr+0x118>
    800002ec:	47c1                	li	a5,16
    800002ee:	10f49a63          	bne	s1,a5,80000402 <consoleintr+0x144>
    800002f2:	00002097          	auipc	ra,0x2
    800002f6:	64e080e7          	jalr	1614(ra) # 80002940 <procdump>
    800002fa:	00010517          	auipc	a0,0x10
    800002fe:	76650513          	addi	a0,a0,1894 # 80010a60 <cons>
    80000302:	00001097          	auipc	ra,0x1
    80000306:	988080e7          	jalr	-1656(ra) # 80000c8a <release>
    8000030a:	60e2                	ld	ra,24(sp)
    8000030c:	6442                	ld	s0,16(sp)
    8000030e:	64a2                	ld	s1,8(sp)
    80000310:	6902                	ld	s2,0(sp)
    80000312:	6105                	addi	sp,sp,32
    80000314:	8082                	ret
    80000316:	07f00793          	li	a5,127
    8000031a:	0af48e63          	beq	s1,a5,800003d6 <consoleintr+0x118>
    8000031e:	00010717          	auipc	a4,0x10
    80000322:	74270713          	addi	a4,a4,1858 # 80010a60 <cons>
    80000326:	0a072783          	lw	a5,160(a4)
    8000032a:	09872703          	lw	a4,152(a4)
    8000032e:	9f99                	subw	a5,a5,a4
    80000330:	07f00713          	li	a4,127
    80000334:	fcf763e3          	bltu	a4,a5,800002fa <consoleintr+0x3c>
    80000338:	47b5                	li	a5,13
    8000033a:	0cf48763          	beq	s1,a5,80000408 <consoleintr+0x14a>
    8000033e:	8526                	mv	a0,s1
    80000340:	00000097          	auipc	ra,0x0
    80000344:	f3c080e7          	jalr	-196(ra) # 8000027c <consputc>
    80000348:	00010797          	auipc	a5,0x10
    8000034c:	71878793          	addi	a5,a5,1816 # 80010a60 <cons>
    80000350:	0a07a683          	lw	a3,160(a5)
    80000354:	0016871b          	addiw	a4,a3,1
    80000358:	0007061b          	sext.w	a2,a4
    8000035c:	0ae7a023          	sw	a4,160(a5)
    80000360:	07f6f693          	andi	a3,a3,127
    80000364:	97b6                	add	a5,a5,a3
    80000366:	00978c23          	sb	s1,24(a5)
    8000036a:	47a9                	li	a5,10
    8000036c:	0cf48563          	beq	s1,a5,80000436 <consoleintr+0x178>
    80000370:	4791                	li	a5,4
    80000372:	0cf48263          	beq	s1,a5,80000436 <consoleintr+0x178>
    80000376:	00010797          	auipc	a5,0x10
    8000037a:	7827a783          	lw	a5,1922(a5) # 80010af8 <cons+0x98>
    8000037e:	9f1d                	subw	a4,a4,a5
    80000380:	08000793          	li	a5,128
    80000384:	f6f71be3          	bne	a4,a5,800002fa <consoleintr+0x3c>
    80000388:	a07d                	j	80000436 <consoleintr+0x178>
    8000038a:	00010717          	auipc	a4,0x10
    8000038e:	6d670713          	addi	a4,a4,1750 # 80010a60 <cons>
    80000392:	0a072783          	lw	a5,160(a4)
    80000396:	09c72703          	lw	a4,156(a4)
    8000039a:	00010497          	auipc	s1,0x10
    8000039e:	6c648493          	addi	s1,s1,1734 # 80010a60 <cons>
    800003a2:	4929                	li	s2,10
    800003a4:	f4f70be3          	beq	a4,a5,800002fa <consoleintr+0x3c>
    800003a8:	37fd                	addiw	a5,a5,-1
    800003aa:	07f7f713          	andi	a4,a5,127
    800003ae:	9726                	add	a4,a4,s1
    800003b0:	01874703          	lbu	a4,24(a4)
    800003b4:	f52703e3          	beq	a4,s2,800002fa <consoleintr+0x3c>
    800003b8:	0af4a023          	sw	a5,160(s1)
    800003bc:	10000513          	li	a0,256
    800003c0:	00000097          	auipc	ra,0x0
    800003c4:	ebc080e7          	jalr	-324(ra) # 8000027c <consputc>
    800003c8:	0a04a783          	lw	a5,160(s1)
    800003cc:	09c4a703          	lw	a4,156(s1)
    800003d0:	fcf71ce3          	bne	a4,a5,800003a8 <consoleintr+0xea>
    800003d4:	b71d                	j	800002fa <consoleintr+0x3c>
    800003d6:	00010717          	auipc	a4,0x10
    800003da:	68a70713          	addi	a4,a4,1674 # 80010a60 <cons>
    800003de:	0a072783          	lw	a5,160(a4)
    800003e2:	09c72703          	lw	a4,156(a4)
    800003e6:	f0f70ae3          	beq	a4,a5,800002fa <consoleintr+0x3c>
    800003ea:	37fd                	addiw	a5,a5,-1
    800003ec:	00010717          	auipc	a4,0x10
    800003f0:	70f72a23          	sw	a5,1812(a4) # 80010b00 <cons+0xa0>
    800003f4:	10000513          	li	a0,256
    800003f8:	00000097          	auipc	ra,0x0
    800003fc:	e84080e7          	jalr	-380(ra) # 8000027c <consputc>
    80000400:	bded                	j	800002fa <consoleintr+0x3c>
    80000402:	ee048ce3          	beqz	s1,800002fa <consoleintr+0x3c>
    80000406:	bf21                	j	8000031e <consoleintr+0x60>
    80000408:	4529                	li	a0,10
    8000040a:	00000097          	auipc	ra,0x0
    8000040e:	e72080e7          	jalr	-398(ra) # 8000027c <consputc>
    80000412:	00010797          	auipc	a5,0x10
    80000416:	64e78793          	addi	a5,a5,1614 # 80010a60 <cons>
    8000041a:	0a07a703          	lw	a4,160(a5)
    8000041e:	0017069b          	addiw	a3,a4,1
    80000422:	0006861b          	sext.w	a2,a3
    80000426:	0ad7a023          	sw	a3,160(a5)
    8000042a:	07f77713          	andi	a4,a4,127
    8000042e:	97ba                	add	a5,a5,a4
    80000430:	4729                	li	a4,10
    80000432:	00e78c23          	sb	a4,24(a5)
    80000436:	00010797          	auipc	a5,0x10
    8000043a:	6cc7a323          	sw	a2,1734(a5) # 80010afc <cons+0x9c>
    8000043e:	00010517          	auipc	a0,0x10
    80000442:	6ba50513          	addi	a0,a0,1722 # 80010af8 <cons+0x98>
    80000446:	00002097          	auipc	ra,0x2
    8000044a:	c72080e7          	jalr	-910(ra) # 800020b8 <wakeup>
    8000044e:	b575                	j	800002fa <consoleintr+0x3c>

0000000080000450 <consoleinit>:
    80000450:	1141                	addi	sp,sp,-16
    80000452:	e406                	sd	ra,8(sp)
    80000454:	e022                	sd	s0,0(sp)
    80000456:	0800                	addi	s0,sp,16
    80000458:	00008597          	auipc	a1,0x8
    8000045c:	bb858593          	addi	a1,a1,-1096 # 80008010 <etext+0x10>
    80000460:	00010517          	auipc	a0,0x10
    80000464:	60050513          	addi	a0,a0,1536 # 80010a60 <cons>
    80000468:	00000097          	auipc	ra,0x0
    8000046c:	6de080e7          	jalr	1758(ra) # 80000b46 <initlock>
    80000470:	00000097          	auipc	ra,0x0
    80000474:	32a080e7          	jalr	810(ra) # 8000079a <uartinit>
    80000478:	00020797          	auipc	a5,0x20
    8000047c:	78078793          	addi	a5,a5,1920 # 80020bf8 <devsw>
    80000480:	00000717          	auipc	a4,0x0
    80000484:	ce470713          	addi	a4,a4,-796 # 80000164 <consoleread>
    80000488:	eb98                	sd	a4,16(a5)
    8000048a:	00000717          	auipc	a4,0x0
    8000048e:	c7870713          	addi	a4,a4,-904 # 80000102 <consolewrite>
    80000492:	ef98                	sd	a4,24(a5)
    80000494:	60a2                	ld	ra,8(sp)
    80000496:	6402                	ld	s0,0(sp)
    80000498:	0141                	addi	sp,sp,16
    8000049a:	8082                	ret

000000008000049c <printint>:
    8000049c:	7179                	addi	sp,sp,-48
    8000049e:	f406                	sd	ra,40(sp)
    800004a0:	f022                	sd	s0,32(sp)
    800004a2:	ec26                	sd	s1,24(sp)
    800004a4:	e84a                	sd	s2,16(sp)
    800004a6:	1800                	addi	s0,sp,48
    800004a8:	c219                	beqz	a2,800004ae <printint+0x12>
    800004aa:	08054663          	bltz	a0,80000536 <printint+0x9a>
    800004ae:	2501                	sext.w	a0,a0
    800004b0:	4881                	li	a7,0
    800004b2:	fd040693          	addi	a3,s0,-48
    800004b6:	4701                	li	a4,0
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
    800004d8:	0005079b          	sext.w	a5,a0
    800004dc:	02b5553b          	divuw	a0,a0,a1
    800004e0:	0685                	addi	a3,a3,1
    800004e2:	feb7f0e3          	bgeu	a5,a1,800004c2 <printint+0x26>
    800004e6:	00088b63          	beqz	a7,800004fc <printint+0x60>
    800004ea:	fe040793          	addi	a5,s0,-32
    800004ee:	973e                	add	a4,a4,a5
    800004f0:	02d00793          	li	a5,45
    800004f4:	fef70823          	sb	a5,-16(a4)
    800004f8:	0028071b          	addiw	a4,a6,2
    800004fc:	02e05763          	blez	a4,8000052a <printint+0x8e>
    80000500:	fd040793          	addi	a5,s0,-48
    80000504:	00e784b3          	add	s1,a5,a4
    80000508:	fff78913          	addi	s2,a5,-1
    8000050c:	993a                	add	s2,s2,a4
    8000050e:	377d                	addiw	a4,a4,-1
    80000510:	1702                	slli	a4,a4,0x20
    80000512:	9301                	srli	a4,a4,0x20
    80000514:	40e90933          	sub	s2,s2,a4
    80000518:	fff4c503          	lbu	a0,-1(s1)
    8000051c:	00000097          	auipc	ra,0x0
    80000520:	d60080e7          	jalr	-672(ra) # 8000027c <consputc>
    80000524:	14fd                	addi	s1,s1,-1
    80000526:	ff2499e3          	bne	s1,s2,80000518 <printint+0x7c>
    8000052a:	70a2                	ld	ra,40(sp)
    8000052c:	7402                	ld	s0,32(sp)
    8000052e:	64e2                	ld	s1,24(sp)
    80000530:	6942                	ld	s2,16(sp)
    80000532:	6145                	addi	sp,sp,48
    80000534:	8082                	ret
    80000536:	40a0053b          	negw	a0,a0
    8000053a:	4885                	li	a7,1
    8000053c:	bf9d                	j	800004b2 <printint+0x16>

000000008000053e <panic>:
    8000053e:	1101                	addi	sp,sp,-32
    80000540:	ec06                	sd	ra,24(sp)
    80000542:	e822                	sd	s0,16(sp)
    80000544:	e426                	sd	s1,8(sp)
    80000546:	1000                	addi	s0,sp,32
    80000548:	84aa                	mv	s1,a0
    8000054a:	00010797          	auipc	a5,0x10
    8000054e:	5c07ab23          	sw	zero,1494(a5) # 80010b20 <pr+0x18>
    80000552:	00008517          	auipc	a0,0x8
    80000556:	ac650513          	addi	a0,a0,-1338 # 80008018 <etext+0x18>
    8000055a:	00000097          	auipc	ra,0x0
    8000055e:	02e080e7          	jalr	46(ra) # 80000588 <printf>
    80000562:	8526                	mv	a0,s1
    80000564:	00000097          	auipc	ra,0x0
    80000568:	024080e7          	jalr	36(ra) # 80000588 <printf>
    8000056c:	00008517          	auipc	a0,0x8
    80000570:	b5c50513          	addi	a0,a0,-1188 # 800080c8 <digits+0x88>
    80000574:	00000097          	auipc	ra,0x0
    80000578:	014080e7          	jalr	20(ra) # 80000588 <printf>
    8000057c:	4785                	li	a5,1
    8000057e:	00008717          	auipc	a4,0x8
    80000582:	36f72123          	sw	a5,866(a4) # 800088e0 <panicked>
    80000586:	a001                	j	80000586 <panic+0x48>

0000000080000588 <printf>:
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
    800005ba:	00010d97          	auipc	s11,0x10
    800005be:	566dad83          	lw	s11,1382(s11) # 80010b20 <pr+0x18>
    800005c2:	020d9b63          	bnez	s11,800005f8 <printf+0x70>
    800005c6:	040a0263          	beqz	s4,8000060a <printf+0x82>
    800005ca:	00840793          	addi	a5,s0,8
    800005ce:	f8f43423          	sd	a5,-120(s0)
    800005d2:	000a4503          	lbu	a0,0(s4)
    800005d6:	14050f63          	beqz	a0,80000734 <printf+0x1ac>
    800005da:	4981                	li	s3,0
    800005dc:	02500a93          	li	s5,37
    800005e0:	07000b93          	li	s7,112
    800005e4:	4d41                	li	s10,16
    800005e6:	00008b17          	auipc	s6,0x8
    800005ea:	a5ab0b13          	addi	s6,s6,-1446 # 80008040 <digits>
    800005ee:	07300c93          	li	s9,115
    800005f2:	06400c13          	li	s8,100
    800005f6:	a82d                	j	80000630 <printf+0xa8>
    800005f8:	00010517          	auipc	a0,0x10
    800005fc:	51050513          	addi	a0,a0,1296 # 80010b08 <pr>
    80000600:	00000097          	auipc	ra,0x0
    80000604:	5d6080e7          	jalr	1494(ra) # 80000bd6 <acquire>
    80000608:	bf7d                	j	800005c6 <printf+0x3e>
    8000060a:	00008517          	auipc	a0,0x8
    8000060e:	a1e50513          	addi	a0,a0,-1506 # 80008028 <etext+0x28>
    80000612:	00000097          	auipc	ra,0x0
    80000616:	f2c080e7          	jalr	-212(ra) # 8000053e <panic>
    8000061a:	00000097          	auipc	ra,0x0
    8000061e:	c62080e7          	jalr	-926(ra) # 8000027c <consputc>
    80000622:	2985                	addiw	s3,s3,1
    80000624:	013a07b3          	add	a5,s4,s3
    80000628:	0007c503          	lbu	a0,0(a5)
    8000062c:	10050463          	beqz	a0,80000734 <printf+0x1ac>
    80000630:	ff5515e3          	bne	a0,s5,8000061a <printf+0x92>
    80000634:	2985                	addiw	s3,s3,1
    80000636:	013a07b3          	add	a5,s4,s3
    8000063a:	0007c783          	lbu	a5,0(a5)
    8000063e:	0007849b          	sext.w	s1,a5
    80000642:	cbed                	beqz	a5,80000734 <printf+0x1ac>
    80000644:	05778a63          	beq	a5,s7,80000698 <printf+0x110>
    80000648:	02fbf663          	bgeu	s7,a5,80000674 <printf+0xec>
    8000064c:	09978863          	beq	a5,s9,800006dc <printf+0x154>
    80000650:	07800713          	li	a4,120
    80000654:	0ce79563          	bne	a5,a4,8000071e <printf+0x196>
    80000658:	f8843783          	ld	a5,-120(s0)
    8000065c:	00878713          	addi	a4,a5,8
    80000660:	f8e43423          	sd	a4,-120(s0)
    80000664:	4605                	li	a2,1
    80000666:	85ea                	mv	a1,s10
    80000668:	4388                	lw	a0,0(a5)
    8000066a:	00000097          	auipc	ra,0x0
    8000066e:	e32080e7          	jalr	-462(ra) # 8000049c <printint>
    80000672:	bf45                	j	80000622 <printf+0x9a>
    80000674:	09578f63          	beq	a5,s5,80000712 <printf+0x18a>
    80000678:	0b879363          	bne	a5,s8,8000071e <printf+0x196>
    8000067c:	f8843783          	ld	a5,-120(s0)
    80000680:	00878713          	addi	a4,a5,8
    80000684:	f8e43423          	sd	a4,-120(s0)
    80000688:	4605                	li	a2,1
    8000068a:	45a9                	li	a1,10
    8000068c:	4388                	lw	a0,0(a5)
    8000068e:	00000097          	auipc	ra,0x0
    80000692:	e0e080e7          	jalr	-498(ra) # 8000049c <printint>
    80000696:	b771                	j	80000622 <printf+0x9a>
    80000698:	f8843783          	ld	a5,-120(s0)
    8000069c:	00878713          	addi	a4,a5,8
    800006a0:	f8e43423          	sd	a4,-120(s0)
    800006a4:	0007b903          	ld	s2,0(a5)
    800006a8:	03000513          	li	a0,48
    800006ac:	00000097          	auipc	ra,0x0
    800006b0:	bd0080e7          	jalr	-1072(ra) # 8000027c <consputc>
    800006b4:	07800513          	li	a0,120
    800006b8:	00000097          	auipc	ra,0x0
    800006bc:	bc4080e7          	jalr	-1084(ra) # 8000027c <consputc>
    800006c0:	84ea                	mv	s1,s10
    800006c2:	03c95793          	srli	a5,s2,0x3c
    800006c6:	97da                	add	a5,a5,s6
    800006c8:	0007c503          	lbu	a0,0(a5)
    800006cc:	00000097          	auipc	ra,0x0
    800006d0:	bb0080e7          	jalr	-1104(ra) # 8000027c <consputc>
    800006d4:	0912                	slli	s2,s2,0x4
    800006d6:	34fd                	addiw	s1,s1,-1
    800006d8:	f4ed                	bnez	s1,800006c2 <printf+0x13a>
    800006da:	b7a1                	j	80000622 <printf+0x9a>
    800006dc:	f8843783          	ld	a5,-120(s0)
    800006e0:	00878713          	addi	a4,a5,8
    800006e4:	f8e43423          	sd	a4,-120(s0)
    800006e8:	6384                	ld	s1,0(a5)
    800006ea:	cc89                	beqz	s1,80000704 <printf+0x17c>
    800006ec:	0004c503          	lbu	a0,0(s1)
    800006f0:	d90d                	beqz	a0,80000622 <printf+0x9a>
    800006f2:	00000097          	auipc	ra,0x0
    800006f6:	b8a080e7          	jalr	-1142(ra) # 8000027c <consputc>
    800006fa:	0485                	addi	s1,s1,1
    800006fc:	0004c503          	lbu	a0,0(s1)
    80000700:	f96d                	bnez	a0,800006f2 <printf+0x16a>
    80000702:	b705                	j	80000622 <printf+0x9a>
    80000704:	00008497          	auipc	s1,0x8
    80000708:	91c48493          	addi	s1,s1,-1764 # 80008020 <etext+0x20>
    8000070c:	02800513          	li	a0,40
    80000710:	b7cd                	j	800006f2 <printf+0x16a>
    80000712:	8556                	mv	a0,s5
    80000714:	00000097          	auipc	ra,0x0
    80000718:	b68080e7          	jalr	-1176(ra) # 8000027c <consputc>
    8000071c:	b719                	j	80000622 <printf+0x9a>
    8000071e:	8556                	mv	a0,s5
    80000720:	00000097          	auipc	ra,0x0
    80000724:	b5c080e7          	jalr	-1188(ra) # 8000027c <consputc>
    80000728:	8526                	mv	a0,s1
    8000072a:	00000097          	auipc	ra,0x0
    8000072e:	b52080e7          	jalr	-1198(ra) # 8000027c <consputc>
    80000732:	bdc5                	j	80000622 <printf+0x9a>
    80000734:	020d9163          	bnez	s11,80000756 <printf+0x1ce>
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
    80000756:	00010517          	auipc	a0,0x10
    8000075a:	3b250513          	addi	a0,a0,946 # 80010b08 <pr>
    8000075e:	00000097          	auipc	ra,0x0
    80000762:	52c080e7          	jalr	1324(ra) # 80000c8a <release>
    80000766:	bfc9                	j	80000738 <printf+0x1b0>

0000000080000768 <printfinit>:
    80000768:	1101                	addi	sp,sp,-32
    8000076a:	ec06                	sd	ra,24(sp)
    8000076c:	e822                	sd	s0,16(sp)
    8000076e:	e426                	sd	s1,8(sp)
    80000770:	1000                	addi	s0,sp,32
    80000772:	00010497          	auipc	s1,0x10
    80000776:	39648493          	addi	s1,s1,918 # 80010b08 <pr>
    8000077a:	00008597          	auipc	a1,0x8
    8000077e:	8be58593          	addi	a1,a1,-1858 # 80008038 <etext+0x38>
    80000782:	8526                	mv	a0,s1
    80000784:	00000097          	auipc	ra,0x0
    80000788:	3c2080e7          	jalr	962(ra) # 80000b46 <initlock>
    8000078c:	4785                	li	a5,1
    8000078e:	cc9c                	sw	a5,24(s1)
    80000790:	60e2                	ld	ra,24(sp)
    80000792:	6442                	ld	s0,16(sp)
    80000794:	64a2                	ld	s1,8(sp)
    80000796:	6105                	addi	sp,sp,32
    80000798:	8082                	ret

000000008000079a <uartinit>:
    8000079a:	1141                	addi	sp,sp,-16
    8000079c:	e406                	sd	ra,8(sp)
    8000079e:	e022                	sd	s0,0(sp)
    800007a0:	0800                	addi	s0,sp,16
    800007a2:	100007b7          	lui	a5,0x10000
    800007a6:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800007aa:	f8000713          	li	a4,-128
    800007ae:	00e781a3          	sb	a4,3(a5)
    800007b2:	470d                	li	a4,3
    800007b4:	00e78023          	sb	a4,0(a5)
    800007b8:	000780a3          	sb	zero,1(a5)
    800007bc:	00e781a3          	sb	a4,3(a5)
    800007c0:	469d                	li	a3,7
    800007c2:	00d78123          	sb	a3,2(a5)
    800007c6:	00e780a3          	sb	a4,1(a5)
    800007ca:	00008597          	auipc	a1,0x8
    800007ce:	88e58593          	addi	a1,a1,-1906 # 80008058 <digits+0x18>
    800007d2:	00010517          	auipc	a0,0x10
    800007d6:	35650513          	addi	a0,a0,854 # 80010b28 <uart_tx_lock>
    800007da:	00000097          	auipc	ra,0x0
    800007de:	36c080e7          	jalr	876(ra) # 80000b46 <initlock>
    800007e2:	60a2                	ld	ra,8(sp)
    800007e4:	6402                	ld	s0,0(sp)
    800007e6:	0141                	addi	sp,sp,16
    800007e8:	8082                	ret

00000000800007ea <uartputc_sync>:
    800007ea:	1101                	addi	sp,sp,-32
    800007ec:	ec06                	sd	ra,24(sp)
    800007ee:	e822                	sd	s0,16(sp)
    800007f0:	e426                	sd	s1,8(sp)
    800007f2:	1000                	addi	s0,sp,32
    800007f4:	84aa                	mv	s1,a0
    800007f6:	00000097          	auipc	ra,0x0
    800007fa:	394080e7          	jalr	916(ra) # 80000b8a <push_off>
    800007fe:	00008797          	auipc	a5,0x8
    80000802:	0e27a783          	lw	a5,226(a5) # 800088e0 <panicked>
    80000806:	10000737          	lui	a4,0x10000
    8000080a:	c391                	beqz	a5,8000080e <uartputc_sync+0x24>
    8000080c:	a001                	j	8000080c <uartputc_sync+0x22>
    8000080e:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80000812:	0207f793          	andi	a5,a5,32
    80000816:	dfe5                	beqz	a5,8000080e <uartputc_sync+0x24>
    80000818:	0ff4f513          	andi	a0,s1,255
    8000081c:	100007b7          	lui	a5,0x10000
    80000820:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>
    80000824:	00000097          	auipc	ra,0x0
    80000828:	406080e7          	jalr	1030(ra) # 80000c2a <pop_off>
    8000082c:	60e2                	ld	ra,24(sp)
    8000082e:	6442                	ld	s0,16(sp)
    80000830:	64a2                	ld	s1,8(sp)
    80000832:	6105                	addi	sp,sp,32
    80000834:	8082                	ret

0000000080000836 <uartstart>:
    80000836:	00008797          	auipc	a5,0x8
    8000083a:	0b27b783          	ld	a5,178(a5) # 800088e8 <uart_tx_r>
    8000083e:	00008717          	auipc	a4,0x8
    80000842:	0b273703          	ld	a4,178(a4) # 800088f0 <uart_tx_w>
    80000846:	06f70a63          	beq	a4,a5,800008ba <uartstart+0x84>
    8000084a:	7139                	addi	sp,sp,-64
    8000084c:	fc06                	sd	ra,56(sp)
    8000084e:	f822                	sd	s0,48(sp)
    80000850:	f426                	sd	s1,40(sp)
    80000852:	f04a                	sd	s2,32(sp)
    80000854:	ec4e                	sd	s3,24(sp)
    80000856:	e852                	sd	s4,16(sp)
    80000858:	e456                	sd	s5,8(sp)
    8000085a:	0080                	addi	s0,sp,64
    8000085c:	10000937          	lui	s2,0x10000
    80000860:	00010a17          	auipc	s4,0x10
    80000864:	2c8a0a13          	addi	s4,s4,712 # 80010b28 <uart_tx_lock>
    80000868:	00008497          	auipc	s1,0x8
    8000086c:	08048493          	addi	s1,s1,128 # 800088e8 <uart_tx_r>
    80000870:	00008997          	auipc	s3,0x8
    80000874:	08098993          	addi	s3,s3,128 # 800088f0 <uart_tx_w>
    80000878:	00594703          	lbu	a4,5(s2) # 10000005 <_entry-0x6ffffffb>
    8000087c:	02077713          	andi	a4,a4,32
    80000880:	c705                	beqz	a4,800008a8 <uartstart+0x72>
    80000882:	01f7f713          	andi	a4,a5,31
    80000886:	9752                	add	a4,a4,s4
    80000888:	01874a83          	lbu	s5,24(a4)
    8000088c:	0785                	addi	a5,a5,1
    8000088e:	e09c                	sd	a5,0(s1)
    80000890:	8526                	mv	a0,s1
    80000892:	00002097          	auipc	ra,0x2
    80000896:	826080e7          	jalr	-2010(ra) # 800020b8 <wakeup>
    8000089a:	01590023          	sb	s5,0(s2)
    8000089e:	609c                	ld	a5,0(s1)
    800008a0:	0009b703          	ld	a4,0(s3)
    800008a4:	fcf71ae3          	bne	a4,a5,80000878 <uartstart+0x42>
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
    800008bc:	7179                	addi	sp,sp,-48
    800008be:	f406                	sd	ra,40(sp)
    800008c0:	f022                	sd	s0,32(sp)
    800008c2:	ec26                	sd	s1,24(sp)
    800008c4:	e84a                	sd	s2,16(sp)
    800008c6:	e44e                	sd	s3,8(sp)
    800008c8:	e052                	sd	s4,0(sp)
    800008ca:	1800                	addi	s0,sp,48
    800008cc:	8a2a                	mv	s4,a0
    800008ce:	00010517          	auipc	a0,0x10
    800008d2:	25a50513          	addi	a0,a0,602 # 80010b28 <uart_tx_lock>
    800008d6:	00000097          	auipc	ra,0x0
    800008da:	300080e7          	jalr	768(ra) # 80000bd6 <acquire>
    800008de:	00008797          	auipc	a5,0x8
    800008e2:	0027a783          	lw	a5,2(a5) # 800088e0 <panicked>
    800008e6:	e7c9                	bnez	a5,80000970 <uartputc+0xb4>
    800008e8:	00008717          	auipc	a4,0x8
    800008ec:	00873703          	ld	a4,8(a4) # 800088f0 <uart_tx_w>
    800008f0:	00008797          	auipc	a5,0x8
    800008f4:	ff87b783          	ld	a5,-8(a5) # 800088e8 <uart_tx_r>
    800008f8:	02078793          	addi	a5,a5,32
    800008fc:	00010997          	auipc	s3,0x10
    80000900:	22c98993          	addi	s3,s3,556 # 80010b28 <uart_tx_lock>
    80000904:	00008497          	auipc	s1,0x8
    80000908:	fe448493          	addi	s1,s1,-28 # 800088e8 <uart_tx_r>
    8000090c:	00008917          	auipc	s2,0x8
    80000910:	fe490913          	addi	s2,s2,-28 # 800088f0 <uart_tx_w>
    80000914:	00e79f63          	bne	a5,a4,80000932 <uartputc+0x76>
    80000918:	85ce                	mv	a1,s3
    8000091a:	8526                	mv	a0,s1
    8000091c:	00001097          	auipc	ra,0x1
    80000920:	738080e7          	jalr	1848(ra) # 80002054 <sleep>
    80000924:	00093703          	ld	a4,0(s2)
    80000928:	609c                	ld	a5,0(s1)
    8000092a:	02078793          	addi	a5,a5,32
    8000092e:	fee785e3          	beq	a5,a4,80000918 <uartputc+0x5c>
    80000932:	00010497          	auipc	s1,0x10
    80000936:	1f648493          	addi	s1,s1,502 # 80010b28 <uart_tx_lock>
    8000093a:	01f77793          	andi	a5,a4,31
    8000093e:	97a6                	add	a5,a5,s1
    80000940:	01478c23          	sb	s4,24(a5)
    80000944:	0705                	addi	a4,a4,1
    80000946:	00008797          	auipc	a5,0x8
    8000094a:	fae7b523          	sd	a4,-86(a5) # 800088f0 <uart_tx_w>
    8000094e:	00000097          	auipc	ra,0x0
    80000952:	ee8080e7          	jalr	-280(ra) # 80000836 <uartstart>
    80000956:	8526                	mv	a0,s1
    80000958:	00000097          	auipc	ra,0x0
    8000095c:	332080e7          	jalr	818(ra) # 80000c8a <release>
    80000960:	70a2                	ld	ra,40(sp)
    80000962:	7402                	ld	s0,32(sp)
    80000964:	64e2                	ld	s1,24(sp)
    80000966:	6942                	ld	s2,16(sp)
    80000968:	69a2                	ld	s3,8(sp)
    8000096a:	6a02                	ld	s4,0(sp)
    8000096c:	6145                	addi	sp,sp,48
    8000096e:	8082                	ret
    80000970:	a001                	j	80000970 <uartputc+0xb4>

0000000080000972 <uartgetc>:
    80000972:	1141                	addi	sp,sp,-16
    80000974:	e422                	sd	s0,8(sp)
    80000976:	0800                	addi	s0,sp,16
    80000978:	100007b7          	lui	a5,0x10000
    8000097c:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80000980:	8b85                	andi	a5,a5,1
    80000982:	cb91                	beqz	a5,80000996 <uartgetc+0x24>
    80000984:	100007b7          	lui	a5,0x10000
    80000988:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
    8000098c:	0ff57513          	andi	a0,a0,255
    80000990:	6422                	ld	s0,8(sp)
    80000992:	0141                	addi	sp,sp,16
    80000994:	8082                	ret
    80000996:	557d                	li	a0,-1
    80000998:	bfe5                	j	80000990 <uartgetc+0x1e>

000000008000099a <uartintr>:
    8000099a:	1101                	addi	sp,sp,-32
    8000099c:	ec06                	sd	ra,24(sp)
    8000099e:	e822                	sd	s0,16(sp)
    800009a0:	e426                	sd	s1,8(sp)
    800009a2:	1000                	addi	s0,sp,32
    800009a4:	54fd                	li	s1,-1
    800009a6:	a029                	j	800009b0 <uartintr+0x16>
    800009a8:	00000097          	auipc	ra,0x0
    800009ac:	916080e7          	jalr	-1770(ra) # 800002be <consoleintr>
    800009b0:	00000097          	auipc	ra,0x0
    800009b4:	fc2080e7          	jalr	-62(ra) # 80000972 <uartgetc>
    800009b8:	fe9518e3          	bne	a0,s1,800009a8 <uartintr+0xe>
    800009bc:	00010497          	auipc	s1,0x10
    800009c0:	16c48493          	addi	s1,s1,364 # 80010b28 <uart_tx_lock>
    800009c4:	8526                	mv	a0,s1
    800009c6:	00000097          	auipc	ra,0x0
    800009ca:	210080e7          	jalr	528(ra) # 80000bd6 <acquire>
    800009ce:	00000097          	auipc	ra,0x0
    800009d2:	e68080e7          	jalr	-408(ra) # 80000836 <uartstart>
    800009d6:	8526                	mv	a0,s1
    800009d8:	00000097          	auipc	ra,0x0
    800009dc:	2b2080e7          	jalr	690(ra) # 80000c8a <release>
    800009e0:	60e2                	ld	ra,24(sp)
    800009e2:	6442                	ld	s0,16(sp)
    800009e4:	64a2                	ld	s1,8(sp)
    800009e6:	6105                	addi	sp,sp,32
    800009e8:	8082                	ret

00000000800009ea <kfree>:
    800009ea:	1101                	addi	sp,sp,-32
    800009ec:	ec06                	sd	ra,24(sp)
    800009ee:	e822                	sd	s0,16(sp)
    800009f0:	e426                	sd	s1,8(sp)
    800009f2:	e04a                	sd	s2,0(sp)
    800009f4:	1000                	addi	s0,sp,32
    800009f6:	03451793          	slli	a5,a0,0x34
    800009fa:	ebb9                	bnez	a5,80000a50 <kfree+0x66>
    800009fc:	84aa                	mv	s1,a0
    800009fe:	00021797          	auipc	a5,0x21
    80000a02:	39278793          	addi	a5,a5,914 # 80021d90 <end>
    80000a06:	04f56563          	bltu	a0,a5,80000a50 <kfree+0x66>
    80000a0a:	47c5                	li	a5,17
    80000a0c:	07ee                	slli	a5,a5,0x1b
    80000a0e:	04f57163          	bgeu	a0,a5,80000a50 <kfree+0x66>
    80000a12:	6605                	lui	a2,0x1
    80000a14:	4585                	li	a1,1
    80000a16:	00000097          	auipc	ra,0x0
    80000a1a:	2bc080e7          	jalr	700(ra) # 80000cd2 <memset>
    80000a1e:	00010917          	auipc	s2,0x10
    80000a22:	14290913          	addi	s2,s2,322 # 80010b60 <kmem>
    80000a26:	854a                	mv	a0,s2
    80000a28:	00000097          	auipc	ra,0x0
    80000a2c:	1ae080e7          	jalr	430(ra) # 80000bd6 <acquire>
    80000a30:	01893783          	ld	a5,24(s2)
    80000a34:	e09c                	sd	a5,0(s1)
    80000a36:	00993c23          	sd	s1,24(s2)
    80000a3a:	854a                	mv	a0,s2
    80000a3c:	00000097          	auipc	ra,0x0
    80000a40:	24e080e7          	jalr	590(ra) # 80000c8a <release>
    80000a44:	60e2                	ld	ra,24(sp)
    80000a46:	6442                	ld	s0,16(sp)
    80000a48:	64a2                	ld	s1,8(sp)
    80000a4a:	6902                	ld	s2,0(sp)
    80000a4c:	6105                	addi	sp,sp,32
    80000a4e:	8082                	ret
    80000a50:	00007517          	auipc	a0,0x7
    80000a54:	61050513          	addi	a0,a0,1552 # 80008060 <digits+0x20>
    80000a58:	00000097          	auipc	ra,0x0
    80000a5c:	ae6080e7          	jalr	-1306(ra) # 8000053e <panic>

0000000080000a60 <freerange>:
    80000a60:	7179                	addi	sp,sp,-48
    80000a62:	f406                	sd	ra,40(sp)
    80000a64:	f022                	sd	s0,32(sp)
    80000a66:	ec26                	sd	s1,24(sp)
    80000a68:	e84a                	sd	s2,16(sp)
    80000a6a:	e44e                	sd	s3,8(sp)
    80000a6c:	e052                	sd	s4,0(sp)
    80000a6e:	1800                	addi	s0,sp,48
    80000a70:	6785                	lui	a5,0x1
    80000a72:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80000a76:	94aa                	add	s1,s1,a0
    80000a78:	757d                	lui	a0,0xfffff
    80000a7a:	8ce9                	and	s1,s1,a0
    80000a7c:	94be                	add	s1,s1,a5
    80000a7e:	0095ee63          	bltu	a1,s1,80000a9a <freerange+0x3a>
    80000a82:	892e                	mv	s2,a1
    80000a84:	7a7d                	lui	s4,0xfffff
    80000a86:	6985                	lui	s3,0x1
    80000a88:	01448533          	add	a0,s1,s4
    80000a8c:	00000097          	auipc	ra,0x0
    80000a90:	f5e080e7          	jalr	-162(ra) # 800009ea <kfree>
    80000a94:	94ce                	add	s1,s1,s3
    80000a96:	fe9979e3          	bgeu	s2,s1,80000a88 <freerange+0x28>
    80000a9a:	70a2                	ld	ra,40(sp)
    80000a9c:	7402                	ld	s0,32(sp)
    80000a9e:	64e2                	ld	s1,24(sp)
    80000aa0:	6942                	ld	s2,16(sp)
    80000aa2:	69a2                	ld	s3,8(sp)
    80000aa4:	6a02                	ld	s4,0(sp)
    80000aa6:	6145                	addi	sp,sp,48
    80000aa8:	8082                	ret

0000000080000aaa <kinit>:
    80000aaa:	1141                	addi	sp,sp,-16
    80000aac:	e406                	sd	ra,8(sp)
    80000aae:	e022                	sd	s0,0(sp)
    80000ab0:	0800                	addi	s0,sp,16
    80000ab2:	00007597          	auipc	a1,0x7
    80000ab6:	5b658593          	addi	a1,a1,1462 # 80008068 <digits+0x28>
    80000aba:	00010517          	auipc	a0,0x10
    80000abe:	0a650513          	addi	a0,a0,166 # 80010b60 <kmem>
    80000ac2:	00000097          	auipc	ra,0x0
    80000ac6:	084080e7          	jalr	132(ra) # 80000b46 <initlock>
    80000aca:	45c5                	li	a1,17
    80000acc:	05ee                	slli	a1,a1,0x1b
    80000ace:	00021517          	auipc	a0,0x21
    80000ad2:	2c250513          	addi	a0,a0,706 # 80021d90 <end>
    80000ad6:	00000097          	auipc	ra,0x0
    80000ada:	f8a080e7          	jalr	-118(ra) # 80000a60 <freerange>
    80000ade:	60a2                	ld	ra,8(sp)
    80000ae0:	6402                	ld	s0,0(sp)
    80000ae2:	0141                	addi	sp,sp,16
    80000ae4:	8082                	ret

0000000080000ae6 <kalloc>:
    80000ae6:	1101                	addi	sp,sp,-32
    80000ae8:	ec06                	sd	ra,24(sp)
    80000aea:	e822                	sd	s0,16(sp)
    80000aec:	e426                	sd	s1,8(sp)
    80000aee:	1000                	addi	s0,sp,32
    80000af0:	00010497          	auipc	s1,0x10
    80000af4:	07048493          	addi	s1,s1,112 # 80010b60 <kmem>
    80000af8:	8526                	mv	a0,s1
    80000afa:	00000097          	auipc	ra,0x0
    80000afe:	0dc080e7          	jalr	220(ra) # 80000bd6 <acquire>
    80000b02:	6c84                	ld	s1,24(s1)
    80000b04:	c885                	beqz	s1,80000b34 <kalloc+0x4e>
    80000b06:	609c                	ld	a5,0(s1)
    80000b08:	00010517          	auipc	a0,0x10
    80000b0c:	05850513          	addi	a0,a0,88 # 80010b60 <kmem>
    80000b10:	ed1c                	sd	a5,24(a0)
    80000b12:	00000097          	auipc	ra,0x0
    80000b16:	178080e7          	jalr	376(ra) # 80000c8a <release>
    80000b1a:	6605                	lui	a2,0x1
    80000b1c:	4595                	li	a1,5
    80000b1e:	8526                	mv	a0,s1
    80000b20:	00000097          	auipc	ra,0x0
    80000b24:	1b2080e7          	jalr	434(ra) # 80000cd2 <memset>
    80000b28:	8526                	mv	a0,s1
    80000b2a:	60e2                	ld	ra,24(sp)
    80000b2c:	6442                	ld	s0,16(sp)
    80000b2e:	64a2                	ld	s1,8(sp)
    80000b30:	6105                	addi	sp,sp,32
    80000b32:	8082                	ret
    80000b34:	00010517          	auipc	a0,0x10
    80000b38:	02c50513          	addi	a0,a0,44 # 80010b60 <kmem>
    80000b3c:	00000097          	auipc	ra,0x0
    80000b40:	14e080e7          	jalr	334(ra) # 80000c8a <release>
    80000b44:	b7d5                	j	80000b28 <kalloc+0x42>

0000000080000b46 <initlock>:
    80000b46:	1141                	addi	sp,sp,-16
    80000b48:	e422                	sd	s0,8(sp)
    80000b4a:	0800                	addi	s0,sp,16
    80000b4c:	e50c                	sd	a1,8(a0)
    80000b4e:	00052023          	sw	zero,0(a0)
    80000b52:	00053823          	sd	zero,16(a0)
    80000b56:	6422                	ld	s0,8(sp)
    80000b58:	0141                	addi	sp,sp,16
    80000b5a:	8082                	ret

0000000080000b5c <holding>:
    80000b5c:	411c                	lw	a5,0(a0)
    80000b5e:	e399                	bnez	a5,80000b64 <holding+0x8>
    80000b60:	4501                	li	a0,0
    80000b62:	8082                	ret
    80000b64:	1101                	addi	sp,sp,-32
    80000b66:	ec06                	sd	ra,24(sp)
    80000b68:	e822                	sd	s0,16(sp)
    80000b6a:	e426                	sd	s1,8(sp)
    80000b6c:	1000                	addi	s0,sp,32
    80000b6e:	6904                	ld	s1,16(a0)
    80000b70:	00001097          	auipc	ra,0x1
    80000b74:	e20080e7          	jalr	-480(ra) # 80001990 <mycpu>
    80000b78:	40a48533          	sub	a0,s1,a0
    80000b7c:	00153513          	seqz	a0,a0
    80000b80:	60e2                	ld	ra,24(sp)
    80000b82:	6442                	ld	s0,16(sp)
    80000b84:	64a2                	ld	s1,8(sp)
    80000b86:	6105                	addi	sp,sp,32
    80000b88:	8082                	ret

0000000080000b8a <push_off>:
    80000b8a:	1101                	addi	sp,sp,-32
    80000b8c:	ec06                	sd	ra,24(sp)
    80000b8e:	e822                	sd	s0,16(sp)
    80000b90:	e426                	sd	s1,8(sp)
    80000b92:	1000                	addi	s0,sp,32
    80000b94:	100024f3          	csrr	s1,sstatus
    80000b98:	100027f3          	csrr	a5,sstatus
    80000b9c:	9bf5                	andi	a5,a5,-3
    80000b9e:	10079073          	csrw	sstatus,a5
    80000ba2:	00001097          	auipc	ra,0x1
    80000ba6:	dee080e7          	jalr	-530(ra) # 80001990 <mycpu>
    80000baa:	5d3c                	lw	a5,120(a0)
    80000bac:	cf89                	beqz	a5,80000bc6 <push_off+0x3c>
    80000bae:	00001097          	auipc	ra,0x1
    80000bb2:	de2080e7          	jalr	-542(ra) # 80001990 <mycpu>
    80000bb6:	5d3c                	lw	a5,120(a0)
    80000bb8:	2785                	addiw	a5,a5,1
    80000bba:	dd3c                	sw	a5,120(a0)
    80000bbc:	60e2                	ld	ra,24(sp)
    80000bbe:	6442                	ld	s0,16(sp)
    80000bc0:	64a2                	ld	s1,8(sp)
    80000bc2:	6105                	addi	sp,sp,32
    80000bc4:	8082                	ret
    80000bc6:	00001097          	auipc	ra,0x1
    80000bca:	dca080e7          	jalr	-566(ra) # 80001990 <mycpu>
    80000bce:	8085                	srli	s1,s1,0x1
    80000bd0:	8885                	andi	s1,s1,1
    80000bd2:	dd64                	sw	s1,124(a0)
    80000bd4:	bfe9                	j	80000bae <push_off+0x24>

0000000080000bd6 <acquire>:
    80000bd6:	1101                	addi	sp,sp,-32
    80000bd8:	ec06                	sd	ra,24(sp)
    80000bda:	e822                	sd	s0,16(sp)
    80000bdc:	e426                	sd	s1,8(sp)
    80000bde:	1000                	addi	s0,sp,32
    80000be0:	84aa                	mv	s1,a0
    80000be2:	00000097          	auipc	ra,0x0
    80000be6:	fa8080e7          	jalr	-88(ra) # 80000b8a <push_off>
    80000bea:	8526                	mv	a0,s1
    80000bec:	00000097          	auipc	ra,0x0
    80000bf0:	f70080e7          	jalr	-144(ra) # 80000b5c <holding>
    80000bf4:	4705                	li	a4,1
    80000bf6:	e115                	bnez	a0,80000c1a <acquire+0x44>
    80000bf8:	87ba                	mv	a5,a4
    80000bfa:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80000bfe:	2781                	sext.w	a5,a5
    80000c00:	ffe5                	bnez	a5,80000bf8 <acquire+0x22>
    80000c02:	0ff0000f          	fence
    80000c06:	00001097          	auipc	ra,0x1
    80000c0a:	d8a080e7          	jalr	-630(ra) # 80001990 <mycpu>
    80000c0e:	e888                	sd	a0,16(s1)
    80000c10:	60e2                	ld	ra,24(sp)
    80000c12:	6442                	ld	s0,16(sp)
    80000c14:	64a2                	ld	s1,8(sp)
    80000c16:	6105                	addi	sp,sp,32
    80000c18:	8082                	ret
    80000c1a:	00007517          	auipc	a0,0x7
    80000c1e:	45650513          	addi	a0,a0,1110 # 80008070 <digits+0x30>
    80000c22:	00000097          	auipc	ra,0x0
    80000c26:	91c080e7          	jalr	-1764(ra) # 8000053e <panic>

0000000080000c2a <pop_off>:
    80000c2a:	1141                	addi	sp,sp,-16
    80000c2c:	e406                	sd	ra,8(sp)
    80000c2e:	e022                	sd	s0,0(sp)
    80000c30:	0800                	addi	s0,sp,16
    80000c32:	00001097          	auipc	ra,0x1
    80000c36:	d5e080e7          	jalr	-674(ra) # 80001990 <mycpu>
    80000c3a:	100027f3          	csrr	a5,sstatus
    80000c3e:	8b89                	andi	a5,a5,2
    80000c40:	e78d                	bnez	a5,80000c6a <pop_off+0x40>
    80000c42:	5d3c                	lw	a5,120(a0)
    80000c44:	02f05b63          	blez	a5,80000c7a <pop_off+0x50>
    80000c48:	37fd                	addiw	a5,a5,-1
    80000c4a:	0007871b          	sext.w	a4,a5
    80000c4e:	dd3c                	sw	a5,120(a0)
    80000c50:	eb09                	bnez	a4,80000c62 <pop_off+0x38>
    80000c52:	5d7c                	lw	a5,124(a0)
    80000c54:	c799                	beqz	a5,80000c62 <pop_off+0x38>
    80000c56:	100027f3          	csrr	a5,sstatus
    80000c5a:	0027e793          	ori	a5,a5,2
    80000c5e:	10079073          	csrw	sstatus,a5
    80000c62:	60a2                	ld	ra,8(sp)
    80000c64:	6402                	ld	s0,0(sp)
    80000c66:	0141                	addi	sp,sp,16
    80000c68:	8082                	ret
    80000c6a:	00007517          	auipc	a0,0x7
    80000c6e:	40e50513          	addi	a0,a0,1038 # 80008078 <digits+0x38>
    80000c72:	00000097          	auipc	ra,0x0
    80000c76:	8cc080e7          	jalr	-1844(ra) # 8000053e <panic>
    80000c7a:	00007517          	auipc	a0,0x7
    80000c7e:	41650513          	addi	a0,a0,1046 # 80008090 <digits+0x50>
    80000c82:	00000097          	auipc	ra,0x0
    80000c86:	8bc080e7          	jalr	-1860(ra) # 8000053e <panic>

0000000080000c8a <release>:
    80000c8a:	1101                	addi	sp,sp,-32
    80000c8c:	ec06                	sd	ra,24(sp)
    80000c8e:	e822                	sd	s0,16(sp)
    80000c90:	e426                	sd	s1,8(sp)
    80000c92:	1000                	addi	s0,sp,32
    80000c94:	84aa                	mv	s1,a0
    80000c96:	00000097          	auipc	ra,0x0
    80000c9a:	ec6080e7          	jalr	-314(ra) # 80000b5c <holding>
    80000c9e:	c115                	beqz	a0,80000cc2 <release+0x38>
    80000ca0:	0004b823          	sd	zero,16(s1)
    80000ca4:	0ff0000f          	fence
    80000ca8:	0f50000f          	fence	iorw,ow
    80000cac:	0804a02f          	amoswap.w	zero,zero,(s1)
    80000cb0:	00000097          	auipc	ra,0x0
    80000cb4:	f7a080e7          	jalr	-134(ra) # 80000c2a <pop_off>
    80000cb8:	60e2                	ld	ra,24(sp)
    80000cba:	6442                	ld	s0,16(sp)
    80000cbc:	64a2                	ld	s1,8(sp)
    80000cbe:	6105                	addi	sp,sp,32
    80000cc0:	8082                	ret
    80000cc2:	00007517          	auipc	a0,0x7
    80000cc6:	3d650513          	addi	a0,a0,982 # 80008098 <digits+0x58>
    80000cca:	00000097          	auipc	ra,0x0
    80000cce:	874080e7          	jalr	-1932(ra) # 8000053e <panic>

0000000080000cd2 <memset>:
    80000cd2:	1141                	addi	sp,sp,-16
    80000cd4:	e422                	sd	s0,8(sp)
    80000cd6:	0800                	addi	s0,sp,16
    80000cd8:	ca19                	beqz	a2,80000cee <memset+0x1c>
    80000cda:	87aa                	mv	a5,a0
    80000cdc:	1602                	slli	a2,a2,0x20
    80000cde:	9201                	srli	a2,a2,0x20
    80000ce0:	00a60733          	add	a4,a2,a0
    80000ce4:	00b78023          	sb	a1,0(a5)
    80000ce8:	0785                	addi	a5,a5,1
    80000cea:	fee79de3          	bne	a5,a4,80000ce4 <memset+0x12>
    80000cee:	6422                	ld	s0,8(sp)
    80000cf0:	0141                	addi	sp,sp,16
    80000cf2:	8082                	ret

0000000080000cf4 <memcmp>:
    80000cf4:	1141                	addi	sp,sp,-16
    80000cf6:	e422                	sd	s0,8(sp)
    80000cf8:	0800                	addi	s0,sp,16
    80000cfa:	ca05                	beqz	a2,80000d2a <memcmp+0x36>
    80000cfc:	fff6069b          	addiw	a3,a2,-1
    80000d00:	1682                	slli	a3,a3,0x20
    80000d02:	9281                	srli	a3,a3,0x20
    80000d04:	0685                	addi	a3,a3,1
    80000d06:	96aa                	add	a3,a3,a0
    80000d08:	00054783          	lbu	a5,0(a0)
    80000d0c:	0005c703          	lbu	a4,0(a1)
    80000d10:	00e79863          	bne	a5,a4,80000d20 <memcmp+0x2c>
    80000d14:	0505                	addi	a0,a0,1
    80000d16:	0585                	addi	a1,a1,1
    80000d18:	fed518e3          	bne	a0,a3,80000d08 <memcmp+0x14>
    80000d1c:	4501                	li	a0,0
    80000d1e:	a019                	j	80000d24 <memcmp+0x30>
    80000d20:	40e7853b          	subw	a0,a5,a4
    80000d24:	6422                	ld	s0,8(sp)
    80000d26:	0141                	addi	sp,sp,16
    80000d28:	8082                	ret
    80000d2a:	4501                	li	a0,0
    80000d2c:	bfe5                	j	80000d24 <memcmp+0x30>

0000000080000d2e <memmove>:
    80000d2e:	1141                	addi	sp,sp,-16
    80000d30:	e422                	sd	s0,8(sp)
    80000d32:	0800                	addi	s0,sp,16
    80000d34:	c205                	beqz	a2,80000d54 <memmove+0x26>
    80000d36:	02a5e263          	bltu	a1,a0,80000d5a <memmove+0x2c>
    80000d3a:	1602                	slli	a2,a2,0x20
    80000d3c:	9201                	srli	a2,a2,0x20
    80000d3e:	00c587b3          	add	a5,a1,a2
    80000d42:	872a                	mv	a4,a0
    80000d44:	0585                	addi	a1,a1,1
    80000d46:	0705                	addi	a4,a4,1
    80000d48:	fff5c683          	lbu	a3,-1(a1)
    80000d4c:	fed70fa3          	sb	a3,-1(a4)
    80000d50:	fef59ae3          	bne	a1,a5,80000d44 <memmove+0x16>
    80000d54:	6422                	ld	s0,8(sp)
    80000d56:	0141                	addi	sp,sp,16
    80000d58:	8082                	ret
    80000d5a:	02061693          	slli	a3,a2,0x20
    80000d5e:	9281                	srli	a3,a3,0x20
    80000d60:	00d58733          	add	a4,a1,a3
    80000d64:	fce57be3          	bgeu	a0,a4,80000d3a <memmove+0xc>
    80000d68:	96aa                	add	a3,a3,a0
    80000d6a:	fff6079b          	addiw	a5,a2,-1
    80000d6e:	1782                	slli	a5,a5,0x20
    80000d70:	9381                	srli	a5,a5,0x20
    80000d72:	fff7c793          	not	a5,a5
    80000d76:	97ba                	add	a5,a5,a4
    80000d78:	177d                	addi	a4,a4,-1
    80000d7a:	16fd                	addi	a3,a3,-1
    80000d7c:	00074603          	lbu	a2,0(a4)
    80000d80:	00c68023          	sb	a2,0(a3)
    80000d84:	fee79ae3          	bne	a5,a4,80000d78 <memmove+0x4a>
    80000d88:	b7f1                	j	80000d54 <memmove+0x26>

0000000080000d8a <memcpy>:
    80000d8a:	1141                	addi	sp,sp,-16
    80000d8c:	e406                	sd	ra,8(sp)
    80000d8e:	e022                	sd	s0,0(sp)
    80000d90:	0800                	addi	s0,sp,16
    80000d92:	00000097          	auipc	ra,0x0
    80000d96:	f9c080e7          	jalr	-100(ra) # 80000d2e <memmove>
    80000d9a:	60a2                	ld	ra,8(sp)
    80000d9c:	6402                	ld	s0,0(sp)
    80000d9e:	0141                	addi	sp,sp,16
    80000da0:	8082                	ret

0000000080000da2 <strncmp>:
    80000da2:	1141                	addi	sp,sp,-16
    80000da4:	e422                	sd	s0,8(sp)
    80000da6:	0800                	addi	s0,sp,16
    80000da8:	ce11                	beqz	a2,80000dc4 <strncmp+0x22>
    80000daa:	00054783          	lbu	a5,0(a0)
    80000dae:	cf89                	beqz	a5,80000dc8 <strncmp+0x26>
    80000db0:	0005c703          	lbu	a4,0(a1)
    80000db4:	00f71a63          	bne	a4,a5,80000dc8 <strncmp+0x26>
    80000db8:	367d                	addiw	a2,a2,-1
    80000dba:	0505                	addi	a0,a0,1
    80000dbc:	0585                	addi	a1,a1,1
    80000dbe:	f675                	bnez	a2,80000daa <strncmp+0x8>
    80000dc0:	4501                	li	a0,0
    80000dc2:	a809                	j	80000dd4 <strncmp+0x32>
    80000dc4:	4501                	li	a0,0
    80000dc6:	a039                	j	80000dd4 <strncmp+0x32>
    80000dc8:	ca09                	beqz	a2,80000dda <strncmp+0x38>
    80000dca:	00054503          	lbu	a0,0(a0)
    80000dce:	0005c783          	lbu	a5,0(a1)
    80000dd2:	9d1d                	subw	a0,a0,a5
    80000dd4:	6422                	ld	s0,8(sp)
    80000dd6:	0141                	addi	sp,sp,16
    80000dd8:	8082                	ret
    80000dda:	4501                	li	a0,0
    80000ddc:	bfe5                	j	80000dd4 <strncmp+0x32>

0000000080000dde <strncpy>:
    80000dde:	1141                	addi	sp,sp,-16
    80000de0:	e422                	sd	s0,8(sp)
    80000de2:	0800                	addi	s0,sp,16
    80000de4:	872a                	mv	a4,a0
    80000de6:	8832                	mv	a6,a2
    80000de8:	367d                	addiw	a2,a2,-1
    80000dea:	01005963          	blez	a6,80000dfc <strncpy+0x1e>
    80000dee:	0705                	addi	a4,a4,1
    80000df0:	0005c783          	lbu	a5,0(a1)
    80000df4:	fef70fa3          	sb	a5,-1(a4)
    80000df8:	0585                	addi	a1,a1,1
    80000dfa:	f7f5                	bnez	a5,80000de6 <strncpy+0x8>
    80000dfc:	86ba                	mv	a3,a4
    80000dfe:	00c05c63          	blez	a2,80000e16 <strncpy+0x38>
    80000e02:	0685                	addi	a3,a3,1
    80000e04:	fe068fa3          	sb	zero,-1(a3)
    80000e08:	fff6c793          	not	a5,a3
    80000e0c:	9fb9                	addw	a5,a5,a4
    80000e0e:	010787bb          	addw	a5,a5,a6
    80000e12:	fef048e3          	bgtz	a5,80000e02 <strncpy+0x24>
    80000e16:	6422                	ld	s0,8(sp)
    80000e18:	0141                	addi	sp,sp,16
    80000e1a:	8082                	ret

0000000080000e1c <safestrcpy>:
    80000e1c:	1141                	addi	sp,sp,-16
    80000e1e:	e422                	sd	s0,8(sp)
    80000e20:	0800                	addi	s0,sp,16
    80000e22:	02c05363          	blez	a2,80000e48 <safestrcpy+0x2c>
    80000e26:	fff6069b          	addiw	a3,a2,-1
    80000e2a:	1682                	slli	a3,a3,0x20
    80000e2c:	9281                	srli	a3,a3,0x20
    80000e2e:	96ae                	add	a3,a3,a1
    80000e30:	87aa                	mv	a5,a0
    80000e32:	00d58963          	beq	a1,a3,80000e44 <safestrcpy+0x28>
    80000e36:	0585                	addi	a1,a1,1
    80000e38:	0785                	addi	a5,a5,1
    80000e3a:	fff5c703          	lbu	a4,-1(a1)
    80000e3e:	fee78fa3          	sb	a4,-1(a5)
    80000e42:	fb65                	bnez	a4,80000e32 <safestrcpy+0x16>
    80000e44:	00078023          	sb	zero,0(a5)
    80000e48:	6422                	ld	s0,8(sp)
    80000e4a:	0141                	addi	sp,sp,16
    80000e4c:	8082                	ret

0000000080000e4e <strlen>:
    80000e4e:	1141                	addi	sp,sp,-16
    80000e50:	e422                	sd	s0,8(sp)
    80000e52:	0800                	addi	s0,sp,16
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
    80000e6e:	6422                	ld	s0,8(sp)
    80000e70:	0141                	addi	sp,sp,16
    80000e72:	8082                	ret
    80000e74:	4501                	li	a0,0
    80000e76:	bfe5                	j	80000e6e <strlen+0x20>

0000000080000e78 <main>:
    80000e78:	1141                	addi	sp,sp,-16
    80000e7a:	e406                	sd	ra,8(sp)
    80000e7c:	e022                	sd	s0,0(sp)
    80000e7e:	0800                	addi	s0,sp,16
    80000e80:	00001097          	auipc	ra,0x1
    80000e84:	b00080e7          	jalr	-1280(ra) # 80001980 <cpuid>
    80000e88:	00008717          	auipc	a4,0x8
    80000e8c:	a7070713          	addi	a4,a4,-1424 # 800088f8 <started>
    80000e90:	c139                	beqz	a0,80000ed6 <main+0x5e>
    80000e92:	431c                	lw	a5,0(a4)
    80000e94:	2781                	sext.w	a5,a5
    80000e96:	dff5                	beqz	a5,80000e92 <main+0x1a>
    80000e98:	0ff0000f          	fence
    80000e9c:	00001097          	auipc	ra,0x1
    80000ea0:	ae4080e7          	jalr	-1308(ra) # 80001980 <cpuid>
    80000ea4:	85aa                	mv	a1,a0
    80000ea6:	00007517          	auipc	a0,0x7
    80000eaa:	21250513          	addi	a0,a0,530 # 800080b8 <digits+0x78>
    80000eae:	fffff097          	auipc	ra,0xfffff
    80000eb2:	6da080e7          	jalr	1754(ra) # 80000588 <printf>
    80000eb6:	00000097          	auipc	ra,0x0
    80000eba:	0d8080e7          	jalr	216(ra) # 80000f8e <kvminithart>
    80000ebe:	00002097          	auipc	ra,0x2
    80000ec2:	bc2080e7          	jalr	-1086(ra) # 80002a80 <trapinithart>
    80000ec6:	00005097          	auipc	ra,0x5
    80000eca:	17a080e7          	jalr	378(ra) # 80006040 <plicinithart>
    80000ece:	00001097          	auipc	ra,0x1
    80000ed2:	fd4080e7          	jalr	-44(ra) # 80001ea2 <scheduler>
    80000ed6:	fffff097          	auipc	ra,0xfffff
    80000eda:	57a080e7          	jalr	1402(ra) # 80000450 <consoleinit>
    80000ede:	00000097          	auipc	ra,0x0
    80000ee2:	88a080e7          	jalr	-1910(ra) # 80000768 <printfinit>
    80000ee6:	00007517          	auipc	a0,0x7
    80000eea:	1e250513          	addi	a0,a0,482 # 800080c8 <digits+0x88>
    80000eee:	fffff097          	auipc	ra,0xfffff
    80000ef2:	69a080e7          	jalr	1690(ra) # 80000588 <printf>
    80000ef6:	00007517          	auipc	a0,0x7
    80000efa:	1aa50513          	addi	a0,a0,426 # 800080a0 <digits+0x60>
    80000efe:	fffff097          	auipc	ra,0xfffff
    80000f02:	68a080e7          	jalr	1674(ra) # 80000588 <printf>
    80000f06:	00007517          	auipc	a0,0x7
    80000f0a:	1c250513          	addi	a0,a0,450 # 800080c8 <digits+0x88>
    80000f0e:	fffff097          	auipc	ra,0xfffff
    80000f12:	67a080e7          	jalr	1658(ra) # 80000588 <printf>
    80000f16:	00000097          	auipc	ra,0x0
    80000f1a:	b94080e7          	jalr	-1132(ra) # 80000aaa <kinit>
    80000f1e:	00000097          	auipc	ra,0x0
    80000f22:	326080e7          	jalr	806(ra) # 80001244 <kvminit>
    80000f26:	00000097          	auipc	ra,0x0
    80000f2a:	068080e7          	jalr	104(ra) # 80000f8e <kvminithart>
    80000f2e:	00001097          	auipc	ra,0x1
    80000f32:	99e080e7          	jalr	-1634(ra) # 800018cc <procinit>
    80000f36:	00002097          	auipc	ra,0x2
    80000f3a:	b22080e7          	jalr	-1246(ra) # 80002a58 <trapinit>
    80000f3e:	00002097          	auipc	ra,0x2
    80000f42:	b42080e7          	jalr	-1214(ra) # 80002a80 <trapinithart>
    80000f46:	00005097          	auipc	ra,0x5
    80000f4a:	0e4080e7          	jalr	228(ra) # 8000602a <plicinit>
    80000f4e:	00005097          	auipc	ra,0x5
    80000f52:	0f2080e7          	jalr	242(ra) # 80006040 <plicinithart>
    80000f56:	00002097          	auipc	ra,0x2
    80000f5a:	290080e7          	jalr	656(ra) # 800031e6 <binit>
    80000f5e:	00003097          	auipc	ra,0x3
    80000f62:	934080e7          	jalr	-1740(ra) # 80003892 <iinit>
    80000f66:	00004097          	auipc	ra,0x4
    80000f6a:	8d2080e7          	jalr	-1838(ra) # 80004838 <fileinit>
    80000f6e:	00005097          	auipc	ra,0x5
    80000f72:	1da080e7          	jalr	474(ra) # 80006148 <virtio_disk_init>
    80000f76:	00001097          	auipc	ra,0x1
    80000f7a:	d0e080e7          	jalr	-754(ra) # 80001c84 <userinit>
    80000f7e:	0ff0000f          	fence
    80000f82:	4785                	li	a5,1
    80000f84:	00008717          	auipc	a4,0x8
    80000f88:	96f72a23          	sw	a5,-1676(a4) # 800088f8 <started>
    80000f8c:	b789                	j	80000ece <main+0x56>

0000000080000f8e <kvminithart>:
    80000f8e:	1141                	addi	sp,sp,-16
    80000f90:	e422                	sd	s0,8(sp)
    80000f92:	0800                	addi	s0,sp,16
    80000f94:	12000073          	sfence.vma
    80000f98:	00008797          	auipc	a5,0x8
    80000f9c:	9687b783          	ld	a5,-1688(a5) # 80008900 <kernel_pigtable>
    80000fa0:	83b1                	srli	a5,a5,0xc
    80000fa2:	577d                	li	a4,-1
    80000fa4:	177e                	slli	a4,a4,0x3f
    80000fa6:	8fd9                	or	a5,a5,a4
    80000fa8:	18079073          	csrw	satp,a5
    80000fac:	12000073          	sfence.vma
    80000fb0:	6422                	ld	s0,8(sp)
    80000fb2:	0141                	addi	sp,sp,16
    80000fb4:	8082                	ret

0000000080000fb6 <walk>:
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
    80000fd0:	57fd                	li	a5,-1
    80000fd2:	83e9                	srli	a5,a5,0x1a
    80000fd4:	4a79                	li	s4,30
    80000fd6:	4b31                	li	s6,12
    80000fd8:	04b7f263          	bgeu	a5,a1,8000101c <walk+0x66>
    80000fdc:	00007517          	auipc	a0,0x7
    80000fe0:	0f450513          	addi	a0,a0,244 # 800080d0 <digits+0x90>
    80000fe4:	fffff097          	auipc	ra,0xfffff
    80000fe8:	55a080e7          	jalr	1370(ra) # 8000053e <panic>
    80000fec:	060a8663          	beqz	s5,80001058 <walk+0xa2>
    80000ff0:	00000097          	auipc	ra,0x0
    80000ff4:	af6080e7          	jalr	-1290(ra) # 80000ae6 <kalloc>
    80000ff8:	84aa                	mv	s1,a0
    80000ffa:	c529                	beqz	a0,80001044 <walk+0x8e>
    80000ffc:	6605                	lui	a2,0x1
    80000ffe:	4581                	li	a1,0
    80001000:	00000097          	auipc	ra,0x0
    80001004:	cd2080e7          	jalr	-814(ra) # 80000cd2 <memset>
    80001008:	00c4d793          	srli	a5,s1,0xc
    8000100c:	07aa                	slli	a5,a5,0xa
    8000100e:	0017e793          	ori	a5,a5,1
    80001012:	00f93023          	sd	a5,0(s2)
    80001016:	3a5d                	addiw	s4,s4,-9
    80001018:	036a0063          	beq	s4,s6,80001038 <walk+0x82>
    8000101c:	0149d933          	srl	s2,s3,s4
    80001020:	1ff97913          	andi	s2,s2,511
    80001024:	090e                	slli	s2,s2,0x3
    80001026:	9926                	add	s2,s2,s1
    80001028:	00093483          	ld	s1,0(s2)
    8000102c:	0014f793          	andi	a5,s1,1
    80001030:	dfd5                	beqz	a5,80000fec <walk+0x36>
    80001032:	80a9                	srli	s1,s1,0xa
    80001034:	04b2                	slli	s1,s1,0xc
    80001036:	b7c5                	j	80001016 <walk+0x60>
    80001038:	00c9d513          	srli	a0,s3,0xc
    8000103c:	1ff57513          	andi	a0,a0,511
    80001040:	050e                	slli	a0,a0,0x3
    80001042:	9526                	add	a0,a0,s1
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
    80001058:	4501                	li	a0,0
    8000105a:	b7ed                	j	80001044 <walk+0x8e>

000000008000105c <walkaddr>:
    8000105c:	57fd                	li	a5,-1
    8000105e:	83e9                	srli	a5,a5,0x1a
    80001060:	00b7f463          	bgeu	a5,a1,80001068 <walkaddr+0xc>
    80001064:	4501                	li	a0,0
    80001066:	8082                	ret
    80001068:	1141                	addi	sp,sp,-16
    8000106a:	e406                	sd	ra,8(sp)
    8000106c:	e022                	sd	s0,0(sp)
    8000106e:	0800                	addi	s0,sp,16
    80001070:	4601                	li	a2,0
    80001072:	00000097          	auipc	ra,0x0
    80001076:	f44080e7          	jalr	-188(ra) # 80000fb6 <walk>
    8000107a:	c105                	beqz	a0,8000109a <walkaddr+0x3e>
    8000107c:	611c                	ld	a5,0(a0)
    8000107e:	0117f693          	andi	a3,a5,17
    80001082:	4745                	li	a4,17
    80001084:	4501                	li	a0,0
    80001086:	00e68663          	beq	a3,a4,80001092 <walkaddr+0x36>
    8000108a:	60a2                	ld	ra,8(sp)
    8000108c:	6402                	ld	s0,0(sp)
    8000108e:	0141                	addi	sp,sp,16
    80001090:	8082                	ret
    80001092:	00a7d513          	srli	a0,a5,0xa
    80001096:	0532                	slli	a0,a0,0xc
    80001098:	bfcd                	j	8000108a <walkaddr+0x2e>
    8000109a:	4501                	li	a0,0
    8000109c:	b7fd                	j	8000108a <walkaddr+0x2e>

000000008000109e <mappigs>:
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
    800010b4:	c639                	beqz	a2,80001102 <mappigs+0x64>
    800010b6:	8aaa                	mv	s5,a0
    800010b8:	8b3a                	mv	s6,a4
    800010ba:	77fd                	lui	a5,0xfffff
    800010bc:	00f5fa33          	and	s4,a1,a5
    800010c0:	15fd                	addi	a1,a1,-1
    800010c2:	00c589b3          	add	s3,a1,a2
    800010c6:	00f9f9b3          	and	s3,s3,a5
    800010ca:	8952                	mv	s2,s4
    800010cc:	41468a33          	sub	s4,a3,s4
    800010d0:	6b85                	lui	s7,0x1
    800010d2:	012a04b3          	add	s1,s4,s2
    800010d6:	4605                	li	a2,1
    800010d8:	85ca                	mv	a1,s2
    800010da:	8556                	mv	a0,s5
    800010dc:	00000097          	auipc	ra,0x0
    800010e0:	eda080e7          	jalr	-294(ra) # 80000fb6 <walk>
    800010e4:	cd1d                	beqz	a0,80001122 <mappigs+0x84>
    800010e6:	611c                	ld	a5,0(a0)
    800010e8:	8b85                	andi	a5,a5,1
    800010ea:	e785                	bnez	a5,80001112 <mappigs+0x74>
    800010ec:	80b1                	srli	s1,s1,0xc
    800010ee:	04aa                	slli	s1,s1,0xa
    800010f0:	0164e4b3          	or	s1,s1,s6
    800010f4:	0014e493          	ori	s1,s1,1
    800010f8:	e104                	sd	s1,0(a0)
    800010fa:	05390063          	beq	s2,s3,8000113a <mappigs+0x9c>
    800010fe:	995e                	add	s2,s2,s7
    80001100:	bfc9                	j	800010d2 <mappigs+0x34>
    80001102:	00007517          	auipc	a0,0x7
    80001106:	fd650513          	addi	a0,a0,-42 # 800080d8 <digits+0x98>
    8000110a:	fffff097          	auipc	ra,0xfffff
    8000110e:	434080e7          	jalr	1076(ra) # 8000053e <panic>
    80001112:	00007517          	auipc	a0,0x7
    80001116:	fd650513          	addi	a0,a0,-42 # 800080e8 <digits+0xa8>
    8000111a:	fffff097          	auipc	ra,0xfffff
    8000111e:	424080e7          	jalr	1060(ra) # 8000053e <panic>
    80001122:	557d                	li	a0,-1
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
    8000113a:	4501                	li	a0,0
    8000113c:	b7e5                	j	80001124 <mappigs+0x86>

000000008000113e <kvmmap>:
    8000113e:	1141                	addi	sp,sp,-16
    80001140:	e406                	sd	ra,8(sp)
    80001142:	e022                	sd	s0,0(sp)
    80001144:	0800                	addi	s0,sp,16
    80001146:	87b6                	mv	a5,a3
    80001148:	86b2                	mv	a3,a2
    8000114a:	863e                	mv	a2,a5
    8000114c:	00000097          	auipc	ra,0x0
    80001150:	f52080e7          	jalr	-174(ra) # 8000109e <mappigs>
    80001154:	e509                	bnez	a0,8000115e <kvmmap+0x20>
    80001156:	60a2                	ld	ra,8(sp)
    80001158:	6402                	ld	s0,0(sp)
    8000115a:	0141                	addi	sp,sp,16
    8000115c:	8082                	ret
    8000115e:	00007517          	auipc	a0,0x7
    80001162:	f9a50513          	addi	a0,a0,-102 # 800080f8 <digits+0xb8>
    80001166:	fffff097          	auipc	ra,0xfffff
    8000116a:	3d8080e7          	jalr	984(ra) # 8000053e <panic>

000000008000116e <kvmmake>:
    8000116e:	1101                	addi	sp,sp,-32
    80001170:	ec06                	sd	ra,24(sp)
    80001172:	e822                	sd	s0,16(sp)
    80001174:	e426                	sd	s1,8(sp)
    80001176:	e04a                	sd	s2,0(sp)
    80001178:	1000                	addi	s0,sp,32
    8000117a:	00000097          	auipc	ra,0x0
    8000117e:	96c080e7          	jalr	-1684(ra) # 80000ae6 <kalloc>
    80001182:	84aa                	mv	s1,a0
    80001184:	6605                	lui	a2,0x1
    80001186:	4581                	li	a1,0
    80001188:	00000097          	auipc	ra,0x0
    8000118c:	b4a080e7          	jalr	-1206(ra) # 80000cd2 <memset>
    80001190:	4719                	li	a4,6
    80001192:	6685                	lui	a3,0x1
    80001194:	10000637          	lui	a2,0x10000
    80001198:	100005b7          	lui	a1,0x10000
    8000119c:	8526                	mv	a0,s1
    8000119e:	00000097          	auipc	ra,0x0
    800011a2:	fa0080e7          	jalr	-96(ra) # 8000113e <kvmmap>
    800011a6:	4719                	li	a4,6
    800011a8:	6685                	lui	a3,0x1
    800011aa:	10001637          	lui	a2,0x10001
    800011ae:	100015b7          	lui	a1,0x10001
    800011b2:	8526                	mv	a0,s1
    800011b4:	00000097          	auipc	ra,0x0
    800011b8:	f8a080e7          	jalr	-118(ra) # 8000113e <kvmmap>
    800011bc:	4719                	li	a4,6
    800011be:	004006b7          	lui	a3,0x400
    800011c2:	0c000637          	lui	a2,0xc000
    800011c6:	0c0005b7          	lui	a1,0xc000
    800011ca:	8526                	mv	a0,s1
    800011cc:	00000097          	auipc	ra,0x0
    800011d0:	f72080e7          	jalr	-142(ra) # 8000113e <kvmmap>
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
    800011f6:	4719                	li	a4,6
    800011f8:	46c5                	li	a3,17
    800011fa:	06ee                	slli	a3,a3,0x1b
    800011fc:	412686b3          	sub	a3,a3,s2
    80001200:	864a                	mv	a2,s2
    80001202:	85ca                	mv	a1,s2
    80001204:	8526                	mv	a0,s1
    80001206:	00000097          	auipc	ra,0x0
    8000120a:	f38080e7          	jalr	-200(ra) # 8000113e <kvmmap>
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
    8000122c:	8526                	mv	a0,s1
    8000122e:	00000097          	auipc	ra,0x0
    80001232:	608080e7          	jalr	1544(ra) # 80001836 <proc_mapstacks>
    80001236:	8526                	mv	a0,s1
    80001238:	60e2                	ld	ra,24(sp)
    8000123a:	6442                	ld	s0,16(sp)
    8000123c:	64a2                	ld	s1,8(sp)
    8000123e:	6902                	ld	s2,0(sp)
    80001240:	6105                	addi	sp,sp,32
    80001242:	8082                	ret

0000000080001244 <kvminit>:
    80001244:	1141                	addi	sp,sp,-16
    80001246:	e406                	sd	ra,8(sp)
    80001248:	e022                	sd	s0,0(sp)
    8000124a:	0800                	addi	s0,sp,16
    8000124c:	00000097          	auipc	ra,0x0
    80001250:	f22080e7          	jalr	-222(ra) # 8000116e <kvmmake>
    80001254:	00007797          	auipc	a5,0x7
    80001258:	6aa7b623          	sd	a0,1708(a5) # 80008900 <kernel_pigtable>
    8000125c:	60a2                	ld	ra,8(sp)
    8000125e:	6402                	ld	s0,0(sp)
    80001260:	0141                	addi	sp,sp,16
    80001262:	8082                	ret

0000000080001264 <uvmunmap>:
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
    8000127a:	03459793          	slli	a5,a1,0x34
    8000127e:	e795                	bnez	a5,800012aa <uvmunmap+0x46>
    80001280:	8a2a                	mv	s4,a0
    80001282:	892e                	mv	s2,a1
    80001284:	8ab6                	mv	s5,a3
    80001286:	0632                	slli	a2,a2,0xc
    80001288:	00b609b3          	add	s3,a2,a1
    8000128c:	4b85                	li	s7,1
    8000128e:	6b05                	lui	s6,0x1
    80001290:	0735e263          	bltu	a1,s3,800012f4 <uvmunmap+0x90>
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
    800012aa:	00007517          	auipc	a0,0x7
    800012ae:	e5650513          	addi	a0,a0,-426 # 80008100 <digits+0xc0>
    800012b2:	fffff097          	auipc	ra,0xfffff
    800012b6:	28c080e7          	jalr	652(ra) # 8000053e <panic>
    800012ba:	00007517          	auipc	a0,0x7
    800012be:	e5e50513          	addi	a0,a0,-418 # 80008118 <digits+0xd8>
    800012c2:	fffff097          	auipc	ra,0xfffff
    800012c6:	27c080e7          	jalr	636(ra) # 8000053e <panic>
    800012ca:	00007517          	auipc	a0,0x7
    800012ce:	e5e50513          	addi	a0,a0,-418 # 80008128 <digits+0xe8>
    800012d2:	fffff097          	auipc	ra,0xfffff
    800012d6:	26c080e7          	jalr	620(ra) # 8000053e <panic>
    800012da:	00007517          	auipc	a0,0x7
    800012de:	e6650513          	addi	a0,a0,-410 # 80008140 <digits+0x100>
    800012e2:	fffff097          	auipc	ra,0xfffff
    800012e6:	25c080e7          	jalr	604(ra) # 8000053e <panic>
    800012ea:	0004b023          	sd	zero,0(s1)
    800012ee:	995a                	add	s2,s2,s6
    800012f0:	fb3972e3          	bgeu	s2,s3,80001294 <uvmunmap+0x30>
    800012f4:	4601                	li	a2,0
    800012f6:	85ca                	mv	a1,s2
    800012f8:	8552                	mv	a0,s4
    800012fa:	00000097          	auipc	ra,0x0
    800012fe:	cbc080e7          	jalr	-836(ra) # 80000fb6 <walk>
    80001302:	84aa                	mv	s1,a0
    80001304:	d95d                	beqz	a0,800012ba <uvmunmap+0x56>
    80001306:	6108                	ld	a0,0(a0)
    80001308:	00157793          	andi	a5,a0,1
    8000130c:	dfdd                	beqz	a5,800012ca <uvmunmap+0x66>
    8000130e:	3ff57793          	andi	a5,a0,1023
    80001312:	fd7784e3          	beq	a5,s7,800012da <uvmunmap+0x76>
    80001316:	fc0a8ae3          	beqz	s5,800012ea <uvmunmap+0x86>
    8000131a:	8129                	srli	a0,a0,0xa
    8000131c:	0532                	slli	a0,a0,0xc
    8000131e:	fffff097          	auipc	ra,0xfffff
    80001322:	6cc080e7          	jalr	1740(ra) # 800009ea <kfree>
    80001326:	b7d1                	j	800012ea <uvmunmap+0x86>

0000000080001328 <uvmcreate>:
    80001328:	1101                	addi	sp,sp,-32
    8000132a:	ec06                	sd	ra,24(sp)
    8000132c:	e822                	sd	s0,16(sp)
    8000132e:	e426                	sd	s1,8(sp)
    80001330:	1000                	addi	s0,sp,32
    80001332:	fffff097          	auipc	ra,0xfffff
    80001336:	7b4080e7          	jalr	1972(ra) # 80000ae6 <kalloc>
    8000133a:	84aa                	mv	s1,a0
    8000133c:	c519                	beqz	a0,8000134a <uvmcreate+0x22>
    8000133e:	6605                	lui	a2,0x1
    80001340:	4581                	li	a1,0
    80001342:	00000097          	auipc	ra,0x0
    80001346:	990080e7          	jalr	-1648(ra) # 80000cd2 <memset>
    8000134a:	8526                	mv	a0,s1
    8000134c:	60e2                	ld	ra,24(sp)
    8000134e:	6442                	ld	s0,16(sp)
    80001350:	64a2                	ld	s1,8(sp)
    80001352:	6105                	addi	sp,sp,32
    80001354:	8082                	ret

0000000080001356 <uvmfirst>:
    80001356:	7179                	addi	sp,sp,-48
    80001358:	f406                	sd	ra,40(sp)
    8000135a:	f022                	sd	s0,32(sp)
    8000135c:	ec26                	sd	s1,24(sp)
    8000135e:	e84a                	sd	s2,16(sp)
    80001360:	e44e                	sd	s3,8(sp)
    80001362:	e052                	sd	s4,0(sp)
    80001364:	1800                	addi	s0,sp,48
    80001366:	6785                	lui	a5,0x1
    80001368:	04f67863          	bgeu	a2,a5,800013b8 <uvmfirst+0x62>
    8000136c:	8a2a                	mv	s4,a0
    8000136e:	89ae                	mv	s3,a1
    80001370:	84b2                	mv	s1,a2
    80001372:	fffff097          	auipc	ra,0xfffff
    80001376:	774080e7          	jalr	1908(ra) # 80000ae6 <kalloc>
    8000137a:	892a                	mv	s2,a0
    8000137c:	6605                	lui	a2,0x1
    8000137e:	4581                	li	a1,0
    80001380:	00000097          	auipc	ra,0x0
    80001384:	952080e7          	jalr	-1710(ra) # 80000cd2 <memset>
    80001388:	4779                	li	a4,30
    8000138a:	86ca                	mv	a3,s2
    8000138c:	6605                	lui	a2,0x1
    8000138e:	4581                	li	a1,0
    80001390:	8552                	mv	a0,s4
    80001392:	00000097          	auipc	ra,0x0
    80001396:	d0c080e7          	jalr	-756(ra) # 8000109e <mappigs>
    8000139a:	8626                	mv	a2,s1
    8000139c:	85ce                	mv	a1,s3
    8000139e:	854a                	mv	a0,s2
    800013a0:	00000097          	auipc	ra,0x0
    800013a4:	98e080e7          	jalr	-1650(ra) # 80000d2e <memmove>
    800013a8:	70a2                	ld	ra,40(sp)
    800013aa:	7402                	ld	s0,32(sp)
    800013ac:	64e2                	ld	s1,24(sp)
    800013ae:	6942                	ld	s2,16(sp)
    800013b0:	69a2                	ld	s3,8(sp)
    800013b2:	6a02                	ld	s4,0(sp)
    800013b4:	6145                	addi	sp,sp,48
    800013b6:	8082                	ret
    800013b8:	00007517          	auipc	a0,0x7
    800013bc:	da050513          	addi	a0,a0,-608 # 80008158 <digits+0x118>
    800013c0:	fffff097          	auipc	ra,0xfffff
    800013c4:	17e080e7          	jalr	382(ra) # 8000053e <panic>

00000000800013c8 <uvmdealloc>:
    800013c8:	1101                	addi	sp,sp,-32
    800013ca:	ec06                	sd	ra,24(sp)
    800013cc:	e822                	sd	s0,16(sp)
    800013ce:	e426                	sd	s1,8(sp)
    800013d0:	1000                	addi	s0,sp,32
    800013d2:	84ae                	mv	s1,a1
    800013d4:	00b67d63          	bgeu	a2,a1,800013ee <uvmdealloc+0x26>
    800013d8:	84b2                	mv	s1,a2
    800013da:	6785                	lui	a5,0x1
    800013dc:	17fd                	addi	a5,a5,-1
    800013de:	00f60733          	add	a4,a2,a5
    800013e2:	767d                	lui	a2,0xfffff
    800013e4:	8f71                	and	a4,a4,a2
    800013e6:	97ae                	add	a5,a5,a1
    800013e8:	8ff1                	and	a5,a5,a2
    800013ea:	00f76863          	bltu	a4,a5,800013fa <uvmdealloc+0x32>
    800013ee:	8526                	mv	a0,s1
    800013f0:	60e2                	ld	ra,24(sp)
    800013f2:	6442                	ld	s0,16(sp)
    800013f4:	64a2                	ld	s1,8(sp)
    800013f6:	6105                	addi	sp,sp,32
    800013f8:	8082                	ret
    800013fa:	8f99                	sub	a5,a5,a4
    800013fc:	83b1                	srli	a5,a5,0xc
    800013fe:	4685                	li	a3,1
    80001400:	0007861b          	sext.w	a2,a5
    80001404:	85ba                	mv	a1,a4
    80001406:	00000097          	auipc	ra,0x0
    8000140a:	e5e080e7          	jalr	-418(ra) # 80001264 <uvmunmap>
    8000140e:	b7c5                	j	800013ee <uvmdealloc+0x26>

0000000080001410 <uvmalloc>:
    80001410:	0ab66563          	bltu	a2,a1,800014ba <uvmalloc+0xaa>
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
    8000142c:	6985                	lui	s3,0x1
    8000142e:	19fd                	addi	s3,s3,-1
    80001430:	95ce                	add	a1,a1,s3
    80001432:	79fd                	lui	s3,0xfffff
    80001434:	0135f9b3          	and	s3,a1,s3
    80001438:	08c9f363          	bgeu	s3,a2,800014be <uvmalloc+0xae>
    8000143c:	894e                	mv	s2,s3
    8000143e:	0126eb13          	ori	s6,a3,18
    80001442:	fffff097          	auipc	ra,0xfffff
    80001446:	6a4080e7          	jalr	1700(ra) # 80000ae6 <kalloc>
    8000144a:	84aa                	mv	s1,a0
    8000144c:	c51d                	beqz	a0,8000147a <uvmalloc+0x6a>
    8000144e:	6605                	lui	a2,0x1
    80001450:	4581                	li	a1,0
    80001452:	00000097          	auipc	ra,0x0
    80001456:	880080e7          	jalr	-1920(ra) # 80000cd2 <memset>
    8000145a:	875a                	mv	a4,s6
    8000145c:	86a6                	mv	a3,s1
    8000145e:	6605                	lui	a2,0x1
    80001460:	85ca                	mv	a1,s2
    80001462:	8556                	mv	a0,s5
    80001464:	00000097          	auipc	ra,0x0
    80001468:	c3a080e7          	jalr	-966(ra) # 8000109e <mappigs>
    8000146c:	e90d                	bnez	a0,8000149e <uvmalloc+0x8e>
    8000146e:	6785                	lui	a5,0x1
    80001470:	993e                	add	s2,s2,a5
    80001472:	fd4968e3          	bltu	s2,s4,80001442 <uvmalloc+0x32>
    80001476:	8552                	mv	a0,s4
    80001478:	a809                	j	8000148a <uvmalloc+0x7a>
    8000147a:	864e                	mv	a2,s3
    8000147c:	85ca                	mv	a1,s2
    8000147e:	8556                	mv	a0,s5
    80001480:	00000097          	auipc	ra,0x0
    80001484:	f48080e7          	jalr	-184(ra) # 800013c8 <uvmdealloc>
    80001488:	4501                	li	a0,0
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
    8000149e:	8526                	mv	a0,s1
    800014a0:	fffff097          	auipc	ra,0xfffff
    800014a4:	54a080e7          	jalr	1354(ra) # 800009ea <kfree>
    800014a8:	864e                	mv	a2,s3
    800014aa:	85ca                	mv	a1,s2
    800014ac:	8556                	mv	a0,s5
    800014ae:	00000097          	auipc	ra,0x0
    800014b2:	f1a080e7          	jalr	-230(ra) # 800013c8 <uvmdealloc>
    800014b6:	4501                	li	a0,0
    800014b8:	bfc9                	j	8000148a <uvmalloc+0x7a>
    800014ba:	852e                	mv	a0,a1
    800014bc:	8082                	ret
    800014be:	8532                	mv	a0,a2
    800014c0:	b7e9                	j	8000148a <uvmalloc+0x7a>

00000000800014c2 <freewalk>:
    800014c2:	7179                	addi	sp,sp,-48
    800014c4:	f406                	sd	ra,40(sp)
    800014c6:	f022                	sd	s0,32(sp)
    800014c8:	ec26                	sd	s1,24(sp)
    800014ca:	e84a                	sd	s2,16(sp)
    800014cc:	e44e                	sd	s3,8(sp)
    800014ce:	e052                	sd	s4,0(sp)
    800014d0:	1800                	addi	s0,sp,48
    800014d2:	8a2a                	mv	s4,a0
    800014d4:	84aa                	mv	s1,a0
    800014d6:	6905                	lui	s2,0x1
    800014d8:	992a                	add	s2,s2,a0
    800014da:	4985                	li	s3,1
    800014dc:	a821                	j	800014f4 <freewalk+0x32>
    800014de:	8129                	srli	a0,a0,0xa
    800014e0:	0532                	slli	a0,a0,0xc
    800014e2:	00000097          	auipc	ra,0x0
    800014e6:	fe0080e7          	jalr	-32(ra) # 800014c2 <freewalk>
    800014ea:	0004b023          	sd	zero,0(s1)
    800014ee:	04a1                	addi	s1,s1,8
    800014f0:	03248163          	beq	s1,s2,80001512 <freewalk+0x50>
    800014f4:	6088                	ld	a0,0(s1)
    800014f6:	00f57793          	andi	a5,a0,15
    800014fa:	ff3782e3          	beq	a5,s3,800014de <freewalk+0x1c>
    800014fe:	8905                	andi	a0,a0,1
    80001500:	d57d                	beqz	a0,800014ee <freewalk+0x2c>
    80001502:	00007517          	auipc	a0,0x7
    80001506:	c7650513          	addi	a0,a0,-906 # 80008178 <digits+0x138>
    8000150a:	fffff097          	auipc	ra,0xfffff
    8000150e:	034080e7          	jalr	52(ra) # 8000053e <panic>
    80001512:	8552                	mv	a0,s4
    80001514:	fffff097          	auipc	ra,0xfffff
    80001518:	4d6080e7          	jalr	1238(ra) # 800009ea <kfree>
    8000151c:	70a2                	ld	ra,40(sp)
    8000151e:	7402                	ld	s0,32(sp)
    80001520:	64e2                	ld	s1,24(sp)
    80001522:	6942                	ld	s2,16(sp)
    80001524:	69a2                	ld	s3,8(sp)
    80001526:	6a02                	ld	s4,0(sp)
    80001528:	6145                	addi	sp,sp,48
    8000152a:	8082                	ret

000000008000152c <uvmfree>:
    8000152c:	1101                	addi	sp,sp,-32
    8000152e:	ec06                	sd	ra,24(sp)
    80001530:	e822                	sd	s0,16(sp)
    80001532:	e426                	sd	s1,8(sp)
    80001534:	1000                	addi	s0,sp,32
    80001536:	84aa                	mv	s1,a0
    80001538:	e999                	bnez	a1,8000154e <uvmfree+0x22>
    8000153a:	8526                	mv	a0,s1
    8000153c:	00000097          	auipc	ra,0x0
    80001540:	f86080e7          	jalr	-122(ra) # 800014c2 <freewalk>
    80001544:	60e2                	ld	ra,24(sp)
    80001546:	6442                	ld	s0,16(sp)
    80001548:	64a2                	ld	s1,8(sp)
    8000154a:	6105                	addi	sp,sp,32
    8000154c:	8082                	ret
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
    80001564:	c679                	beqz	a2,80001632 <uvmcopy+0xce>
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
    80001582:	4981                	li	s3,0
    80001584:	4601                	li	a2,0
    80001586:	85ce                	mv	a1,s3
    80001588:	855a                	mv	a0,s6
    8000158a:	00000097          	auipc	ra,0x0
    8000158e:	a2c080e7          	jalr	-1492(ra) # 80000fb6 <walk>
    80001592:	c531                	beqz	a0,800015de <uvmcopy+0x7a>
    80001594:	6118                	ld	a4,0(a0)
    80001596:	00177793          	andi	a5,a4,1
    8000159a:	cbb1                	beqz	a5,800015ee <uvmcopy+0x8a>
    8000159c:	00a75593          	srli	a1,a4,0xa
    800015a0:	00c59b93          	slli	s7,a1,0xc
    800015a4:	3ff77493          	andi	s1,a4,1023
    800015a8:	fffff097          	auipc	ra,0xfffff
    800015ac:	53e080e7          	jalr	1342(ra) # 80000ae6 <kalloc>
    800015b0:	892a                	mv	s2,a0
    800015b2:	c939                	beqz	a0,80001608 <uvmcopy+0xa4>
    800015b4:	6605                	lui	a2,0x1
    800015b6:	85de                	mv	a1,s7
    800015b8:	fffff097          	auipc	ra,0xfffff
    800015bc:	776080e7          	jalr	1910(ra) # 80000d2e <memmove>
    800015c0:	8726                	mv	a4,s1
    800015c2:	86ca                	mv	a3,s2
    800015c4:	6605                	lui	a2,0x1
    800015c6:	85ce                	mv	a1,s3
    800015c8:	8556                	mv	a0,s5
    800015ca:	00000097          	auipc	ra,0x0
    800015ce:	ad4080e7          	jalr	-1324(ra) # 8000109e <mappigs>
    800015d2:	e515                	bnez	a0,800015fe <uvmcopy+0x9a>
    800015d4:	6785                	lui	a5,0x1
    800015d6:	99be                	add	s3,s3,a5
    800015d8:	fb49e6e3          	bltu	s3,s4,80001584 <uvmcopy+0x20>
    800015dc:	a081                	j	8000161c <uvmcopy+0xb8>
    800015de:	00007517          	auipc	a0,0x7
    800015e2:	baa50513          	addi	a0,a0,-1110 # 80008188 <digits+0x148>
    800015e6:	fffff097          	auipc	ra,0xfffff
    800015ea:	f58080e7          	jalr	-168(ra) # 8000053e <panic>
    800015ee:	00007517          	auipc	a0,0x7
    800015f2:	bba50513          	addi	a0,a0,-1094 # 800081a8 <digits+0x168>
    800015f6:	fffff097          	auipc	ra,0xfffff
    800015fa:	f48080e7          	jalr	-184(ra) # 8000053e <panic>
    800015fe:	854a                	mv	a0,s2
    80001600:	fffff097          	auipc	ra,0xfffff
    80001604:	3ea080e7          	jalr	1002(ra) # 800009ea <kfree>
    80001608:	4685                	li	a3,1
    8000160a:	00c9d613          	srli	a2,s3,0xc
    8000160e:	4581                	li	a1,0
    80001610:	8556                	mv	a0,s5
    80001612:	00000097          	auipc	ra,0x0
    80001616:	c52080e7          	jalr	-942(ra) # 80001264 <uvmunmap>
    8000161a:	557d                	li	a0,-1
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
    80001632:	4501                	li	a0,0
    80001634:	8082                	ret

0000000080001636 <uvmclear>:
    80001636:	1141                	addi	sp,sp,-16
    80001638:	e406                	sd	ra,8(sp)
    8000163a:	e022                	sd	s0,0(sp)
    8000163c:	0800                	addi	s0,sp,16
    8000163e:	4601                	li	a2,0
    80001640:	00000097          	auipc	ra,0x0
    80001644:	976080e7          	jalr	-1674(ra) # 80000fb6 <walk>
    80001648:	c901                	beqz	a0,80001658 <uvmclear+0x22>
    8000164a:	611c                	ld	a5,0(a0)
    8000164c:	9bbd                	andi	a5,a5,-17
    8000164e:	e11c                	sd	a5,0(a0)
    80001650:	60a2                	ld	ra,8(sp)
    80001652:	6402                	ld	s0,0(sp)
    80001654:	0141                	addi	sp,sp,16
    80001656:	8082                	ret
    80001658:	00007517          	auipc	a0,0x7
    8000165c:	b7050513          	addi	a0,a0,-1168 # 800081c8 <digits+0x188>
    80001660:	fffff097          	auipc	ra,0xfffff
    80001664:	ede080e7          	jalr	-290(ra) # 8000053e <panic>

0000000080001668 <copyout>:
    80001668:	c6bd                	beqz	a3,800016d6 <copyout+0x6e>
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
    8000168a:	7bfd                	lui	s7,0xfffff
    8000168c:	6a85                	lui	s5,0x1
    8000168e:	a015                	j	800016b2 <copyout+0x4a>
    80001690:	9562                	add	a0,a0,s8
    80001692:	0004861b          	sext.w	a2,s1
    80001696:	85d2                	mv	a1,s4
    80001698:	41250533          	sub	a0,a0,s2
    8000169c:	fffff097          	auipc	ra,0xfffff
    800016a0:	692080e7          	jalr	1682(ra) # 80000d2e <memmove>
    800016a4:	409989b3          	sub	s3,s3,s1
    800016a8:	9a26                	add	s4,s4,s1
    800016aa:	01590c33          	add	s8,s2,s5
    800016ae:	02098263          	beqz	s3,800016d2 <copyout+0x6a>
    800016b2:	017c7933          	and	s2,s8,s7
    800016b6:	85ca                	mv	a1,s2
    800016b8:	855a                	mv	a0,s6
    800016ba:	00000097          	auipc	ra,0x0
    800016be:	9a2080e7          	jalr	-1630(ra) # 8000105c <walkaddr>
    800016c2:	cd01                	beqz	a0,800016da <copyout+0x72>
    800016c4:	418904b3          	sub	s1,s2,s8
    800016c8:	94d6                	add	s1,s1,s5
    800016ca:	fc99f3e3          	bgeu	s3,s1,80001690 <copyout+0x28>
    800016ce:	84ce                	mv	s1,s3
    800016d0:	b7c1                	j	80001690 <copyout+0x28>
    800016d2:	4501                	li	a0,0
    800016d4:	a021                	j	800016dc <copyout+0x74>
    800016d6:	4501                	li	a0,0
    800016d8:	8082                	ret
    800016da:	557d                	li	a0,-1
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
    800016f4:	caa5                	beqz	a3,80001764 <copyin+0x70>
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
    80001716:	7bfd                	lui	s7,0xfffff
    80001718:	6a85                	lui	s5,0x1
    8000171a:	a01d                	j	80001740 <copyin+0x4c>
    8000171c:	018505b3          	add	a1,a0,s8
    80001720:	0004861b          	sext.w	a2,s1
    80001724:	412585b3          	sub	a1,a1,s2
    80001728:	8552                	mv	a0,s4
    8000172a:	fffff097          	auipc	ra,0xfffff
    8000172e:	604080e7          	jalr	1540(ra) # 80000d2e <memmove>
    80001732:	409989b3          	sub	s3,s3,s1
    80001736:	9a26                	add	s4,s4,s1
    80001738:	01590c33          	add	s8,s2,s5
    8000173c:	02098263          	beqz	s3,80001760 <copyin+0x6c>
    80001740:	017c7933          	and	s2,s8,s7
    80001744:	85ca                	mv	a1,s2
    80001746:	855a                	mv	a0,s6
    80001748:	00000097          	auipc	ra,0x0
    8000174c:	914080e7          	jalr	-1772(ra) # 8000105c <walkaddr>
    80001750:	cd01                	beqz	a0,80001768 <copyin+0x74>
    80001752:	418904b3          	sub	s1,s2,s8
    80001756:	94d6                	add	s1,s1,s5
    80001758:	fc99f2e3          	bgeu	s3,s1,8000171c <copyin+0x28>
    8000175c:	84ce                	mv	s1,s3
    8000175e:	bf7d                	j	8000171c <copyin+0x28>
    80001760:	4501                	li	a0,0
    80001762:	a021                	j	8000176a <copyin+0x76>
    80001764:	4501                	li	a0,0
    80001766:	8082                	ret
    80001768:	557d                	li	a0,-1
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
    80001782:	c6c5                	beqz	a3,8000182a <copyinstr+0xa8>
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
    800017a2:	7afd                	lui	s5,0xfffff
    800017a4:	6985                	lui	s3,0x1
    800017a6:	a035                	j	800017d2 <copyinstr+0x50>
    800017a8:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    800017ac:	4785                	li	a5,1
    800017ae:	0017b793          	seqz	a5,a5
    800017b2:	40f00533          	neg	a0,a5
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
    800017cc:	01390bb3          	add	s7,s2,s3
    800017d0:	c8a9                	beqz	s1,80001822 <copyinstr+0xa0>
    800017d2:	015bf933          	and	s2,s7,s5
    800017d6:	85ca                	mv	a1,s2
    800017d8:	8552                	mv	a0,s4
    800017da:	00000097          	auipc	ra,0x0
    800017de:	882080e7          	jalr	-1918(ra) # 8000105c <walkaddr>
    800017e2:	c131                	beqz	a0,80001826 <copyinstr+0xa4>
    800017e4:	41790833          	sub	a6,s2,s7
    800017e8:	984e                	add	a6,a6,s3
    800017ea:	0104f363          	bgeu	s1,a6,800017f0 <copyinstr+0x6e>
    800017ee:	8826                	mv	a6,s1
    800017f0:	955e                	add	a0,a0,s7
    800017f2:	41250533          	sub	a0,a0,s2
    800017f6:	fc080be3          	beqz	a6,800017cc <copyinstr+0x4a>
    800017fa:	985a                	add	a6,a6,s6
    800017fc:	87da                	mv	a5,s6
    800017fe:	41650633          	sub	a2,a0,s6
    80001802:	14fd                	addi	s1,s1,-1
    80001804:	9b26                	add	s6,s6,s1
    80001806:	00f60733          	add	a4,a2,a5
    8000180a:	00074703          	lbu	a4,0(a4)
    8000180e:	df49                	beqz	a4,800017a8 <copyinstr+0x26>
    80001810:	00e78023          	sb	a4,0(a5)
    80001814:	40fb04b3          	sub	s1,s6,a5
    80001818:	0785                	addi	a5,a5,1
    8000181a:	ff0796e3          	bne	a5,a6,80001806 <copyinstr+0x84>
    8000181e:	8b42                	mv	s6,a6
    80001820:	b775                	j	800017cc <copyinstr+0x4a>
    80001822:	4781                	li	a5,0
    80001824:	b769                	j	800017ae <copyinstr+0x2c>
    80001826:	557d                	li	a0,-1
    80001828:	b779                	j	800017b6 <copyinstr+0x34>
    8000182a:	4781                	li	a5,0
    8000182c:	0017b793          	seqz	a5,a5
    80001830:	40f00533          	neg	a0,a5
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
    80001850:	76448493          	addi	s1,s1,1892 # 80010fb0 <proc>
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
    8000186a:	14aa0a13          	addi	s4,s4,330 # 800169b0 <tickslock>
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
    800018ec:	29850513          	addi	a0,a0,664 # 80010b80 <pid_lock>
    800018f0:	fffff097          	auipc	ra,0xfffff
    800018f4:	256080e7          	jalr	598(ra) # 80000b46 <initlock>
  initlock(&wait_lock, "wait_lock");
    800018f8:	00007597          	auipc	a1,0x7
    800018fc:	8f058593          	addi	a1,a1,-1808 # 800081e8 <digits+0x1a8>
    80001900:	0000f517          	auipc	a0,0xf
    80001904:	29850513          	addi	a0,a0,664 # 80010b98 <wait_lock>
    80001908:	fffff097          	auipc	ra,0xfffff
    8000190c:	23e080e7          	jalr	574(ra) # 80000b46 <initlock>
  for (p = proc; p < &proc[NPROC]; p++)
    80001910:	0000f497          	auipc	s1,0xf
    80001914:	6a048493          	addi	s1,s1,1696 # 80010fb0 <proc>
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
    80001936:	07e98993          	addi	s3,s3,126 # 800169b0 <tickslock>
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
// this core's hartid (core number), the index into cpus[].
static inline uint64
r_tp()
{
  uint64 x;
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
    800019a0:	21450513          	addi	a0,a0,532 # 80010bb0 <cpus>
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
    800019c8:	1bc70713          	addi	a4,a4,444 # 80010b80 <pid_lock>
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
    80001a00:	e947a783          	lw	a5,-364(a5) # 80008890 <first.1>
    80001a04:	eb89                	bnez	a5,80001a16 <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    80001a06:	00001097          	auipc	ra,0x1
    80001a0a:	092080e7          	jalr	146(ra) # 80002a98 <usertrapret>
}
    80001a0e:	60a2                	ld	ra,8(sp)
    80001a10:	6402                	ld	s0,0(sp)
    80001a12:	0141                	addi	sp,sp,16
    80001a14:	8082                	ret
    first = 0;
    80001a16:	00007797          	auipc	a5,0x7
    80001a1a:	e607ad23          	sw	zero,-390(a5) # 80008890 <first.1>
    fsinit(ROOTDEV);
    80001a1e:	4505                	li	a0,1
    80001a20:	00002097          	auipc	ra,0x2
    80001a24:	df2080e7          	jalr	-526(ra) # 80003812 <fsinit>
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
    80001a3a:	14a90913          	addi	s2,s2,330 # 80010b80 <pid_lock>
    80001a3e:	854a                	mv	a0,s2
    80001a40:	fffff097          	auipc	ra,0xfffff
    80001a44:	196080e7          	jalr	406(ra) # 80000bd6 <acquire>
  pid = nextpid;
    80001a48:	00007797          	auipc	a5,0x7
    80001a4c:	e4c78793          	addi	a5,a5,-436 # 80008894 <nextpid>
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
    80001bc6:	3ee48493          	addi	s1,s1,1006 # 80010fb0 <proc>
    80001bca:	00015917          	auipc	s2,0x15
    80001bce:	de690913          	addi	s2,s2,-538 # 800169b0 <tickslock>
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
    80001c9c:	c6a7b823          	sd	a0,-912(a5) # 80008908 <initproc>
  uvmfirst(p->pigtable, initcode, sizeof(initcode));
    80001ca0:	03400613          	li	a2,52
    80001ca4:	00007597          	auipc	a1,0x7
    80001ca8:	bfc58593          	addi	a1,a1,-1028 # 800088a0 <initcode>
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
    80001ce6:	552080e7          	jalr	1362(ra) # 80004234 <namei>
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
    80001e16:	ab8080e7          	jalr	-1352(ra) # 800048ca <filedup>
    80001e1a:	00a93023          	sd	a0,0(s2)
    80001e1e:	b7e5                	j	80001e06 <fork+0xa4>
  np->cwd = idup(p->cwd);
    80001e20:	150ab503          	ld	a0,336(s5)
    80001e24:	00002097          	auipc	ra,0x2
    80001e28:	c2c080e7          	jalr	-980(ra) # 80003a50 <idup>
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
    80001e54:	d4848493          	addi	s1,s1,-696 # 80010b98 <wait_lock>
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
    80001ec2:	cc270713          	addi	a4,a4,-830 # 80010b80 <pid_lock>
    80001ec6:	9756                	add	a4,a4,s5
    80001ec8:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    80001ecc:	0000f717          	auipc	a4,0xf
    80001ed0:	cec70713          	addi	a4,a4,-788 # 80010bb8 <cpus+0x8>
    80001ed4:	9aba                	add	s5,s5,a4
      if (p->state == RUNNABLE)
    80001ed6:	498d                	li	s3,3
        p->state = RUNNING;
    80001ed8:	4b11                	li	s6,4
        c->proc = p;
    80001eda:	079e                	slli	a5,a5,0x7
    80001edc:	0000fa17          	auipc	s4,0xf
    80001ee0:	ca4a0a13          	addi	s4,s4,-860 # 80010b80 <pid_lock>
    80001ee4:	9a3e                	add	s4,s4,a5
    for (p = proc; p < &proc[NPROC]; p++)
    80001ee6:	00015917          	auipc	s2,0x15
    80001eea:	aca90913          	addi	s2,s2,-1334 # 800169b0 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001eee:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001ef2:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001ef6:	10079073          	csrw	sstatus,a5
    80001efa:	0000f497          	auipc	s1,0xf
    80001efe:	0b648493          	addi	s1,s1,182 # 80010fb0 <proc>
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
    80001f38:	aba080e7          	jalr	-1350(ra) # 800029ee <swtch>
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
    80001f6e:	c1670713          	addi	a4,a4,-1002 # 80010b80 <pid_lock>
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
    80001f94:	bf090913          	addi	s2,s2,-1040 # 80010b80 <pid_lock>
    80001f98:	2781                	sext.w	a5,a5
    80001f9a:	079e                	slli	a5,a5,0x7
    80001f9c:	97ca                	add	a5,a5,s2
    80001f9e:	0ac7a983          	lw	s3,172(a5)
    80001fa2:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    80001fa4:	2781                	sext.w	a5,a5
    80001fa6:	079e                	slli	a5,a5,0x7
    80001fa8:	0000f597          	auipc	a1,0xf
    80001fac:	c1058593          	addi	a1,a1,-1008 # 80010bb8 <cpus+0x8>
    80001fb0:	95be                	add	a1,a1,a5
    80001fb2:	06048513          	addi	a0,s1,96
    80001fb6:	00001097          	auipc	ra,0x1
    80001fba:	a38080e7          	jalr	-1480(ra) # 800029ee <swtch>
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
    800020d0:	ee448493          	addi	s1,s1,-284 # 80010fb0 <proc>
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
    800020dc:	8d890913          	addi	s2,s2,-1832 # 800169b0 <tickslock>
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
    80002144:	e7048493          	addi	s1,s1,-400 # 80010fb0 <proc>
      pp->parent = initproc;
    80002148:	00006a17          	auipc	s4,0x6
    8000214c:	7c0a0a13          	addi	s4,s4,1984 # 80008908 <initproc>
  for (pp = proc; pp < &proc[NPROC]; pp++)
    80002150:	00015997          	auipc	s3,0x15
    80002154:	86098993          	addi	s3,s3,-1952 # 800169b0 <tickslock>
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
    800021a8:	7647b783          	ld	a5,1892(a5) # 80008908 <initproc>
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
    800021cc:	754080e7          	jalr	1876(ra) # 8000491c <fileclose>
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
    800021e4:	270080e7          	jalr	624(ra) # 80004450 <begin_op>
  iput(p->cwd);
    800021e8:	1509b503          	ld	a0,336(s3)
    800021ec:	00002097          	auipc	ra,0x2
    800021f0:	a5c080e7          	jalr	-1444(ra) # 80003c48 <iput>
  end_op();
    800021f4:	00002097          	auipc	ra,0x2
    800021f8:	2dc080e7          	jalr	732(ra) # 800044d0 <end_op>
  p->cwd = 0;
    800021fc:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    80002200:	0000f497          	auipc	s1,0xf
    80002204:	99848493          	addi	s1,s1,-1640 # 80010b98 <wait_lock>
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
    80002272:	d4248493          	addi	s1,s1,-702 # 80010fb0 <proc>
    80002276:	00014997          	auipc	s3,0x14
    8000227a:	73a98993          	addi	s3,s3,1850 # 800169b0 <tickslock>
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

static char digits[] = "0123456789abcdef";

void print_pigs(pigtable_t pigtable, int pigdepth)
{
  if (pigdepth <= 2)
    800022d0:	4789                	li	a5,2
    800022d2:	38b7c363          	blt	a5,a1,80002658 <print_pigs+0x388>
{
    800022d6:	7129                	addi	sp,sp,-320
    800022d8:	fe06                	sd	ra,312(sp)
    800022da:	fa22                	sd	s0,304(sp)
    800022dc:	f626                	sd	s1,296(sp)
    800022de:	f24a                	sd	s2,288(sp)
    800022e0:	ee4e                	sd	s3,280(sp)
    800022e2:	ea52                	sd	s4,272(sp)
    800022e4:	e656                	sd	s5,264(sp)
    800022e6:	e25a                	sd	s6,256(sp)
    800022e8:	fdde                	sd	s7,248(sp)
    800022ea:	f9e2                	sd	s8,240(sp)
    800022ec:	f5e6                	sd	s9,232(sp)
    800022ee:	f1ea                	sd	s10,224(sp)
    800022f0:	edee                	sd	s11,216(sp)
    800022f2:	0280                	addi	s0,sp,320
    800022f4:	8bae                	mv	s7,a1
    800022f6:	8aaa                	mv	s5,a0
    800022f8:	0005871b          	sext.w	a4,a1
      pte_t pte = pigtable[i];
      if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
      {
        char str[80];
        int d = 0;
        for (int j = 2 - pigdepth; j > 0; j--)
    800022fc:	4c89                	li	s9,2
    800022fe:	40bc8cbb          	subw	s9,s9,a1
    80002302:	000c8d1b          	sext.w	s10,s9
    80002306:	fffd4793          	not	a5,s10
    8000230a:	97fd                	srai	a5,a5,0x3f
    8000230c:	00fcfcb3          	and	s9,s9,a5
    80002310:	000c8d9b          	sext.w	s11,s9
    80002314:	001c879b          	addiw	a5,s9,1
    80002318:	ecf43823          	sd	a5,-304(s0)
        {
          str[d++] = '\n';
        }
        for (int j = 0; j < pigdepth; j++)
        {
          str[d++] = '\t';
    8000231c:	00bc87bb          	addw	a5,s9,a1
    80002320:	00b05363          	blez	a1,80002326 <print_pigs+0x56>
    80002324:	8cbe                	mv	s9,a5
    80002326:	000c879b          	sext.w	a5,s9
    8000232a:	86be                	mv	a3,a5
    8000232c:	ecf43423          	sd	a5,-312(s0)
    80002330:	ef040793          	addi	a5,s0,-272
    80002334:	00d78c33          	add	s8,a5,a3
    80002338:	8cb6                	mv	s9,a3
    for (int i = 0; i < 512; i++)
    8000233a:	4a01                	li	s4,0
        uint x = i;
        int strlen = 0;
        do
        {
          strlen++;
          buf[ii++] = digits[x % 10];
    8000233c:	00006997          	auipc	s3,0x6
    80002340:	fbc98993          	addi	s3,s3,-68 # 800082f8 <digits>
        print_pigs(child, pigdepth + 1);
    80002344:	001b869b          	addiw	a3,s7,1
    80002348:	ecd43c23          	sd	a3,-296(s0)
    8000234c:	ef140b13          	addi	s6,s0,-271
    80002350:	4785                	li	a5,1
    80002352:	9f99                	subw	a5,a5,a4
    80002354:	1782                	slli	a5,a5,0x20
    80002356:	9381                	srli	a5,a5,0x20
    80002358:	9b3e                	add	s6,s6,a5
    8000235a:	ac49                	j	800025ec <print_pigs+0x31c>
        for (int j = 2 - pigdepth; j > 0; j--)
    8000235c:	01a05a63          	blez	s10,80002370 <print_pigs+0xa0>
    80002360:	ef040793          	addi	a5,s0,-272
          str[d++] = '\n';
    80002364:	4729                	li	a4,10
    80002366:	00e78023          	sb	a4,0(a5)
        for (int j = 2 - pigdepth; j > 0; j--)
    8000236a:	0785                	addi	a5,a5,1
    8000236c:	ff679de3          	bne	a5,s6,80002366 <print_pigs+0x96>
        for (int j = 0; j < pigdepth; j++)
    80002370:	03705263          	blez	s7,80002394 <print_pigs+0xc4>
          str[d++] = '\t';
    80002374:	4725                	li	a4,9
    80002376:	f9040793          	addi	a5,s0,-112
    8000237a:	97ee                	add	a5,a5,s11
    8000237c:	f6e78023          	sb	a4,-160(a5)
        for (int j = 0; j < pigdepth; j++)
    80002380:	4789                	li	a5,2
    80002382:	00fb9963          	bne	s7,a5,80002394 <print_pigs+0xc4>
          str[d++] = '\t';
    80002386:	f9040793          	addi	a5,s0,-112
    8000238a:	ed043683          	ld	a3,-304(s0)
    8000238e:	97b6                	add	a5,a5,a3
    80002390:	f6e78023          	sb	a4,-160(a5)
        uint x = i;
    80002394:	000a071b          	sext.w	a4,s4
        int strlen = 0;
    80002398:	f4040613          	addi	a2,s0,-192
    8000239c:	4681                	li	a3,0
          buf[ii++] = digits[x % 10];
    8000239e:	4529                	li	a0,10
        } while ((x /= 10) != 0);
    800023a0:	4825                	li	a6,9
          strlen++;
    800023a2:	85b6                	mv	a1,a3
    800023a4:	2685                	addiw	a3,a3,1
          buf[ii++] = digits[x % 10];
    800023a6:	02a777bb          	remuw	a5,a4,a0
    800023aa:	1782                	slli	a5,a5,0x20
    800023ac:	9381                	srli	a5,a5,0x20
    800023ae:	97ce                	add	a5,a5,s3
    800023b0:	0007c783          	lbu	a5,0(a5)
    800023b4:	00f60023          	sb	a5,0(a2) # 1000 <_entry-0x7ffff000>
        } while ((x /= 10) != 0);
    800023b8:	0007079b          	sext.w	a5,a4
    800023bc:	02a7573b          	divuw	a4,a4,a0
    800023c0:	0605                	addi	a2,a2,1
    800023c2:	fef860e3          	bltu	a6,a5,800023a2 <print_pigs+0xd2>
        for (int j = 0; j < (3 - strlen); j++)
    800023c6:	448d                	li	s1,3
    800023c8:	9c95                	subw	s1,s1,a3
    800023ca:	0004879b          	sext.w	a5,s1
    800023ce:	0af05a63          	blez	a5,80002482 <print_pigs+0x1b2>
    800023d2:	001c0713          	addi	a4,s8,1
    800023d6:	4789                	li	a5,2
    800023d8:	9f95                	subw	a5,a5,a3
    800023da:	1782                	slli	a5,a5,0x20
    800023dc:	9381                	srli	a5,a5,0x20
    800023de:	973e                	add	a4,a4,a5
    800023e0:	87e2                	mv	a5,s8
          str[d++] = '0';
    800023e2:	03000613          	li	a2,48
    800023e6:	00c78023          	sb	a2,0(a5)
        for (int j = 0; j < (3 - strlen); j++)
    800023ea:	0785                	addi	a5,a5,1
    800023ec:	fee79de3          	bne	a5,a4,800023e6 <print_pigs+0x116>
          str[d++] = '0';
    800023f0:	019484bb          	addw	s1,s1,s9
        for (int j = 1; j <= strlen; j++)
    800023f4:	02d05b63          	blez	a3,8000242a <print_pigs+0x15a>
    800023f8:	f4040793          	addi	a5,s0,-192
    800023fc:	96be                	add	a3,a3,a5
    800023fe:	4781                	li	a5,0
          str[d++] = buf[strlen - j];
    80002400:	00f48733          	add	a4,s1,a5
    80002404:	ef040613          	addi	a2,s0,-272
    80002408:	9732                	add	a4,a4,a2
    8000240a:	fff6c603          	lbu	a2,-1(a3)
    8000240e:	00c70023          	sb	a2,0(a4)
        for (int j = 1; j <= strlen; j++)
    80002412:	0785                	addi	a5,a5,1
    80002414:	16fd                	addi	a3,a3,-1
    80002416:	0007871b          	sext.w	a4,a5
    8000241a:	fee5d3e3          	bge	a1,a4,80002400 <print_pigs+0x130>
    8000241e:	2485                	addiw	s1,s1,1
          str[d++] = buf[strlen - j];
    80002420:	fff5c793          	not	a5,a1
    80002424:	97fd                	srai	a5,a5,0x3f
    80002426:	8dfd                	and	a1,a1,a5
    80002428:	9cad                	addw	s1,s1,a1
        safestrcpy(str + d, ": %p ", 6);
    8000242a:	4619                	li	a2,6
    8000242c:	00006597          	auipc	a1,0x6
    80002430:	e5458593          	addi	a1,a1,-428 # 80008280 <digits+0x240>
    80002434:	ef040793          	addi	a5,s0,-272
    80002438:	00978533          	add	a0,a5,s1
    8000243c:	fffff097          	auipc	ra,0xfffff
    80002440:	9e0080e7          	jalr	-1568(ra) # 80000e1c <safestrcpy>
        str[d++] = '\n';
    80002444:	0054879b          	addiw	a5,s1,5
    80002448:	f9040713          	addi	a4,s0,-112
    8000244c:	97ba                	add	a5,a5,a4
    8000244e:	4729                	li	a4,10
    80002450:	f6e78023          	sb	a4,-160(a5)
        str[d++] = '\0';
    80002454:	2499                	addiw	s1,s1,6
    80002456:	f9040793          	addi	a5,s0,-112
    8000245a:	94be                	add	s1,s1,a5
    8000245c:	f6048023          	sb	zero,-160(s1)
        printf(str, pte);
    80002460:	85ca                	mv	a1,s2
    80002462:	ef040513          	addi	a0,s0,-272
    80002466:	ffffe097          	auipc	ra,0xffffe
    8000246a:	122080e7          	jalr	290(ra) # 80000588 <printf>
        pigtable_t child = (pigtable_t)PTE2PA(pte);
    8000246e:	00a95513          	srli	a0,s2,0xa
        print_pigs(child, pigdepth + 1);
    80002472:	ed843583          	ld	a1,-296(s0)
    80002476:	0532                	slli	a0,a0,0xc
    80002478:	00000097          	auipc	ra,0x0
    8000247c:	e58080e7          	jalr	-424(ra) # 800022d0 <print_pigs>
    80002480:	a285                	j	800025e0 <print_pigs+0x310>
        for (int j = 0; j < (3 - strlen); j++)
    80002482:	ec843483          	ld	s1,-312(s0)
    80002486:	b7bd                	j	800023f4 <print_pigs+0x124>
        uint x = i;
    80002488:	000a071b          	sext.w	a4,s4
        int strlen = 0;
    8000248c:	ee040613          	addi	a2,s0,-288
    80002490:	4681                	li	a3,0
          buf[ii++] = digits[x % 10];
    80002492:	4529                	li	a0,10
        } while ((x /= 10) != 0);
    80002494:	4825                	li	a6,9
          strlen++;
    80002496:	85b6                	mv	a1,a3
    80002498:	2685                	addiw	a3,a3,1
          buf[ii++] = digits[x % 10];
    8000249a:	02a777bb          	remuw	a5,a4,a0
    8000249e:	1782                	slli	a5,a5,0x20
    800024a0:	9381                	srli	a5,a5,0x20
    800024a2:	97ce                	add	a5,a5,s3
    800024a4:	0007c783          	lbu	a5,0(a5)
    800024a8:	00f60023          	sb	a5,0(a2)
        } while ((x /= 10) != 0);
    800024ac:	0007079b          	sext.w	a5,a4
    800024b0:	02a7573b          	divuw	a4,a4,a0
    800024b4:	0605                	addi	a2,a2,1
    800024b6:	fef860e3          	bltu	a6,a5,80002496 <print_pigs+0x1c6>
        for (int j = 0; j < (3 - strlen); j++)
    800024ba:	450d                	li	a0,3
    800024bc:	9d15                	subw	a0,a0,a3
    800024be:	0005079b          	sext.w	a5,a0
    800024c2:	02f05563          	blez	a5,800024ec <print_pigs+0x21c>
    800024c6:	f4040793          	addi	a5,s0,-192
    800024ca:	97a6                	add	a5,a5,s1
    800024cc:	f4140713          	addi	a4,s0,-191
    800024d0:	9726                	add	a4,a4,s1
    800024d2:	4609                	li	a2,2
    800024d4:	9e15                	subw	a2,a2,a3
    800024d6:	1602                	slli	a2,a2,0x20
    800024d8:	9201                	srli	a2,a2,0x20
    800024da:	9732                	add	a4,a4,a2
        {
          str[d++] = '0';
    800024dc:	03000613          	li	a2,48
    800024e0:	00c78023          	sb	a2,0(a5)
        for (int j = 0; j < (3 - strlen); j++)
    800024e4:	0785                	addi	a5,a5,1
    800024e6:	fee79de3          	bne	a5,a4,800024e0 <print_pigs+0x210>
          str[d++] = '0';
    800024ea:	9ca9                	addw	s1,s1,a0
        }
        for (int j = 1; j <= strlen; j++)
    800024ec:	02d05b63          	blez	a3,80002522 <print_pigs+0x252>
    800024f0:	ee040793          	addi	a5,s0,-288
    800024f4:	96be                	add	a3,a3,a5
    800024f6:	4781                	li	a5,0
        {
          str[d++] = buf[strlen - j];
    800024f8:	00f48733          	add	a4,s1,a5
    800024fc:	f4040613          	addi	a2,s0,-192
    80002500:	9732                	add	a4,a4,a2
    80002502:	fff6c603          	lbu	a2,-1(a3)
    80002506:	00c70023          	sb	a2,0(a4)
        for (int j = 1; j <= strlen; j++)
    8000250a:	0785                	addi	a5,a5,1
    8000250c:	16fd                	addi	a3,a3,-1
    8000250e:	0007871b          	sext.w	a4,a5
    80002512:	fee5d3e3          	bge	a1,a4,800024f8 <print_pigs+0x228>
    80002516:	2485                	addiw	s1,s1,1
          str[d++] = buf[strlen - j];
    80002518:	fff5c793          	not	a5,a1
    8000251c:	97fd                	srai	a5,a5,0x3f
    8000251e:	8dfd                	and	a1,a1,a5
    80002520:	9cad                	addw	s1,s1,a1
        }

        safestrcpy(str + d, ": %p ", 6);
    80002522:	4619                	li	a2,6
    80002524:	00006597          	auipc	a1,0x6
    80002528:	d5c58593          	addi	a1,a1,-676 # 80008280 <digits+0x240>
    8000252c:	f4040793          	addi	a5,s0,-192
    80002530:	00978533          	add	a0,a5,s1
    80002534:	fffff097          	auipc	ra,0xfffff
    80002538:	8e8080e7          	jalr	-1816(ra) # 80000e1c <safestrcpy>
        d += 5;
        str[d++] = ' ';
    8000253c:	0054879b          	addiw	a5,s1,5
    80002540:	f9040713          	addi	a4,s0,-112
    80002544:	97ba                	add	a5,a5,a4
    80002546:	02000693          	li	a3,32
    8000254a:	fad78823          	sb	a3,-80(a5)
        str[d++] = ' ';
    8000254e:	0074879b          	addiw	a5,s1,7
    80002552:	0064871b          	addiw	a4,s1,6
    80002556:	f9040613          	addi	a2,s0,-112
    8000255a:	9732                	add	a4,a4,a2
    8000255c:	fad70823          	sb	a3,-80(a4)
        str[d++] = (pte & PTE_R) ? 'r' : '-';
    80002560:	00297713          	andi	a4,s2,2
    80002564:	07200693          	li	a3,114
    80002568:	e319                	bnez	a4,8000256e <print_pigs+0x29e>
    8000256a:	02d00693          	li	a3,45
    8000256e:	0084871b          	addiw	a4,s1,8
    80002572:	f9040613          	addi	a2,s0,-112
    80002576:	97b2                	add	a5,a5,a2
    80002578:	fad78823          	sb	a3,-80(a5)
        str[d++] = (pte & PTE_W) ? 'w' : '-';
    8000257c:	00497793          	andi	a5,s2,4
    80002580:	07700693          	li	a3,119
    80002584:	e399                	bnez	a5,8000258a <print_pigs+0x2ba>
    80002586:	02d00693          	li	a3,45
    8000258a:	0094879b          	addiw	a5,s1,9
    8000258e:	f9040613          	addi	a2,s0,-112
    80002592:	9732                	add	a4,a4,a2
    80002594:	fad70823          	sb	a3,-80(a4)
        str[d++] = (pte & PTE_X) ? 'x' : '-';
    80002598:	00897713          	andi	a4,s2,8
    8000259c:	07800693          	li	a3,120
    800025a0:	e319                	bnez	a4,800025a6 <print_pigs+0x2d6>
    800025a2:	02d00693          	li	a3,45
    800025a6:	00a4851b          	addiw	a0,s1,10
    800025aa:	f9040713          	addi	a4,s0,-112
    800025ae:	97ba                	add	a5,a5,a4
    800025b0:	fad78823          	sb	a3,-80(a5)
        if (!(pte & PTE_U))
    800025b4:	01097793          	andi	a5,s2,16
    800025b8:	c3b5                	beqz	a5,8000261c <print_pigs+0x34c>
        {
          safestrcpy(str + d, "   (kernel)", 12);
          d += 11;
        }
        str[d++] = '\n';
    800025ba:	f9040793          	addi	a5,s0,-112
    800025be:	97aa                	add	a5,a5,a0
    800025c0:	4729                	li	a4,10
    800025c2:	fae78823          	sb	a4,-80(a5)
        str[d++] = '\0';
    800025c6:	2505                	addiw	a0,a0,1
    800025c8:	f9040793          	addi	a5,s0,-112
    800025cc:	953e                	add	a0,a0,a5
    800025ce:	fa050823          	sb	zero,-80(a0)

        printf(str, pte);
    800025d2:	85ca                	mv	a1,s2
    800025d4:	f4040513          	addi	a0,s0,-192
    800025d8:	ffffe097          	auipc	ra,0xffffe
    800025dc:	fb0080e7          	jalr	-80(ra) # 80000588 <printf>
    for (int i = 0; i < 512; i++)
    800025e0:	2a05                	addiw	s4,s4,1
    800025e2:	0aa1                	addi	s5,s5,8
    800025e4:	20000793          	li	a5,512
    800025e8:	04fa0963          	beq	s4,a5,8000263a <print_pigs+0x36a>
      pte_t pte = pigtable[i];
    800025ec:	000ab903          	ld	s2,0(s5)
      if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
    800025f0:	00f97713          	andi	a4,s2,15
    800025f4:	4785                	li	a5,1
    800025f6:	d6f703e3          	beq	a4,a5,8000235c <print_pigs+0x8c>
      else if ((pte & PTE_V))
    800025fa:	00197793          	andi	a5,s2,1
    800025fe:	d3ed                	beqz	a5,800025e0 <print_pigs+0x310>
        int d = 0;
    80002600:	4481                	li	s1,0
        for (; d < pigdepth; d++)
    80002602:	e97053e3          	blez	s7,80002488 <print_pigs+0x1b8>
          str[d] = '\t';
    80002606:	47a5                	li	a5,9
    80002608:	f4f40023          	sb	a5,-192(s0)
        for (; d < pigdepth; d++)
    8000260c:	4789                	li	a5,2
    8000260e:	84de                	mv	s1,s7
    80002610:	e6fb9ce3          	bne	s7,a5,80002488 <print_pigs+0x1b8>
          str[d] = '\t';
    80002614:	47a5                	li	a5,9
    80002616:	f4f400a3          	sb	a5,-191(s0)
        for (; d < pigdepth; d++)
    8000261a:	b5bd                	j	80002488 <print_pigs+0x1b8>
          safestrcpy(str + d, "   (kernel)", 12);
    8000261c:	4631                	li	a2,12
    8000261e:	00006597          	auipc	a1,0x6
    80002622:	c6a58593          	addi	a1,a1,-918 # 80008288 <digits+0x248>
    80002626:	f4040793          	addi	a5,s0,-192
    8000262a:	953e                	add	a0,a0,a5
    8000262c:	ffffe097          	auipc	ra,0xffffe
    80002630:	7f0080e7          	jalr	2032(ra) # 80000e1c <safestrcpy>
          d += 11;
    80002634:	0154851b          	addiw	a0,s1,21
    80002638:	b749                	j	800025ba <print_pigs+0x2ea>
      }
    }
  }
}
    8000263a:	70f2                	ld	ra,312(sp)
    8000263c:	7452                	ld	s0,304(sp)
    8000263e:	74b2                	ld	s1,296(sp)
    80002640:	7912                	ld	s2,288(sp)
    80002642:	69f2                	ld	s3,280(sp)
    80002644:	6a52                	ld	s4,272(sp)
    80002646:	6ab2                	ld	s5,264(sp)
    80002648:	6b12                	ld	s6,256(sp)
    8000264a:	7bee                	ld	s7,248(sp)
    8000264c:	7c4e                	ld	s8,240(sp)
    8000264e:	7cae                	ld	s9,232(sp)
    80002650:	7d0e                	ld	s10,224(sp)
    80002652:	6dee                	ld	s11,216(sp)
    80002654:	6131                	addi	sp,sp,320
    80002656:	8082                	ret
    80002658:	8082                	ret

000000008000265a <pigwalk>:

int pigwalk(int pid)
{
    8000265a:	7179                	addi	sp,sp,-48
    8000265c:	f406                	sd	ra,40(sp)
    8000265e:	f022                	sd	s0,32(sp)
    80002660:	ec26                	sd	s1,24(sp)
    80002662:	e84a                	sd	s2,16(sp)
    80002664:	e44e                	sd	s3,8(sp)
    80002666:	1800                	addi	s0,sp,48
    80002668:	892a                	mv	s2,a0
  if (pid == 0)
  {
    printf("invalid pig: %d\n", pid);
    return -1;
  }
  for (p = proc; p < &proc[NPROC]; p++)
    8000266a:	0000f497          	auipc	s1,0xf
    8000266e:	94648493          	addi	s1,s1,-1722 # 80010fb0 <proc>
    80002672:	00014997          	auipc	s3,0x14
    80002676:	33e98993          	addi	s3,s3,830 # 800169b0 <tickslock>
  if (pid == 0)
    8000267a:	cd0d                	beqz	a0,800026b4 <pigwalk+0x5a>
  {
    acquire(&p->lock);
    8000267c:	8526                	mv	a0,s1
    8000267e:	ffffe097          	auipc	ra,0xffffe
    80002682:	558080e7          	jalr	1368(ra) # 80000bd6 <acquire>
    if (p->pid == pid)
    80002686:	589c                	lw	a5,48(s1)
    80002688:	05278163          	beq	a5,s2,800026ca <pigwalk+0x70>
      pigtable_t pigtable = p->pigtable;
      print_pigs(pigtable, 0);
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    8000268c:	8526                	mv	a0,s1
    8000268e:	ffffe097          	auipc	ra,0xffffe
    80002692:	5fc080e7          	jalr	1532(ra) # 80000c8a <release>
  for (p = proc; p < &proc[NPROC]; p++)
    80002696:	16848493          	addi	s1,s1,360
    8000269a:	ff3491e3          	bne	s1,s3,8000267c <pigwalk+0x22>
  }
  printf("invalid pig: %d\n", pid);
    8000269e:	85ca                	mv	a1,s2
    800026a0:	00006517          	auipc	a0,0x6
    800026a4:	bf850513          	addi	a0,a0,-1032 # 80008298 <digits+0x258>
    800026a8:	ffffe097          	auipc	ra,0xffffe
    800026ac:	ee0080e7          	jalr	-288(ra) # 80000588 <printf>
  return -1;
    800026b0:	557d                	li	a0,-1
    800026b2:	a805                	j	800026e2 <pigwalk+0x88>
    printf("invalid pig: %d\n", pid);
    800026b4:	4581                	li	a1,0
    800026b6:	00006517          	auipc	a0,0x6
    800026ba:	be250513          	addi	a0,a0,-1054 # 80008298 <digits+0x258>
    800026be:	ffffe097          	auipc	ra,0xffffe
    800026c2:	eca080e7          	jalr	-310(ra) # 80000588 <printf>
    return -1;
    800026c6:	557d                	li	a0,-1
    800026c8:	a829                	j	800026e2 <pigwalk+0x88>
      print_pigs(pigtable, 0);
    800026ca:	4581                	li	a1,0
    800026cc:	68a8                	ld	a0,80(s1)
    800026ce:	00000097          	auipc	ra,0x0
    800026d2:	c02080e7          	jalr	-1022(ra) # 800022d0 <print_pigs>
      release(&p->lock);
    800026d6:	8526                	mv	a0,s1
    800026d8:	ffffe097          	auipc	ra,0xffffe
    800026dc:	5b2080e7          	jalr	1458(ra) # 80000c8a <release>
      return 0;
    800026e0:	4501                	li	a0,0
}
    800026e2:	70a2                	ld	ra,40(sp)
    800026e4:	7402                	ld	s0,32(sp)
    800026e6:	64e2                	ld	s1,24(sp)
    800026e8:	6942                	ld	s2,16(sp)
    800026ea:	69a2                	ld	s3,8(sp)
    800026ec:	6145                	addi	sp,sp,48
    800026ee:	8082                	ret

00000000800026f0 <pigs>:

int pigs(int pid)
{
    800026f0:	1141                	addi	sp,sp,-16
    800026f2:	e406                	sd	ra,8(sp)
    800026f4:	e022                	sd	s0,0(sp)
    800026f6:	0800                	addi	s0,sp,16
  return pigwalk(pid);
    800026f8:	00000097          	auipc	ra,0x0
    800026fc:	f62080e7          	jalr	-158(ra) # 8000265a <pigwalk>
}
    80002700:	60a2                	ld	ra,8(sp)
    80002702:	6402                	ld	s0,0(sp)
    80002704:	0141                	addi	sp,sp,16
    80002706:	8082                	ret

0000000080002708 <setkilled>:

void setkilled(struct proc *p)
{
    80002708:	1101                	addi	sp,sp,-32
    8000270a:	ec06                	sd	ra,24(sp)
    8000270c:	e822                	sd	s0,16(sp)
    8000270e:	e426                	sd	s1,8(sp)
    80002710:	1000                	addi	s0,sp,32
    80002712:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80002714:	ffffe097          	auipc	ra,0xffffe
    80002718:	4c2080e7          	jalr	1218(ra) # 80000bd6 <acquire>
  p->killed = 1;
    8000271c:	4785                	li	a5,1
    8000271e:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    80002720:	8526                	mv	a0,s1
    80002722:	ffffe097          	auipc	ra,0xffffe
    80002726:	568080e7          	jalr	1384(ra) # 80000c8a <release>
}
    8000272a:	60e2                	ld	ra,24(sp)
    8000272c:	6442                	ld	s0,16(sp)
    8000272e:	64a2                	ld	s1,8(sp)
    80002730:	6105                	addi	sp,sp,32
    80002732:	8082                	ret

0000000080002734 <killed>:

int killed(struct proc *p)
{
    80002734:	1101                	addi	sp,sp,-32
    80002736:	ec06                	sd	ra,24(sp)
    80002738:	e822                	sd	s0,16(sp)
    8000273a:	e426                	sd	s1,8(sp)
    8000273c:	e04a                	sd	s2,0(sp)
    8000273e:	1000                	addi	s0,sp,32
    80002740:	84aa                	mv	s1,a0
  int k;

  acquire(&p->lock);
    80002742:	ffffe097          	auipc	ra,0xffffe
    80002746:	494080e7          	jalr	1172(ra) # 80000bd6 <acquire>
  k = p->killed;
    8000274a:	0284a903          	lw	s2,40(s1)
  release(&p->lock);
    8000274e:	8526                	mv	a0,s1
    80002750:	ffffe097          	auipc	ra,0xffffe
    80002754:	53a080e7          	jalr	1338(ra) # 80000c8a <release>
  return k;
}
    80002758:	854a                	mv	a0,s2
    8000275a:	60e2                	ld	ra,24(sp)
    8000275c:	6442                	ld	s0,16(sp)
    8000275e:	64a2                	ld	s1,8(sp)
    80002760:	6902                	ld	s2,0(sp)
    80002762:	6105                	addi	sp,sp,32
    80002764:	8082                	ret

0000000080002766 <wait>:
{
    80002766:	715d                	addi	sp,sp,-80
    80002768:	e486                	sd	ra,72(sp)
    8000276a:	e0a2                	sd	s0,64(sp)
    8000276c:	fc26                	sd	s1,56(sp)
    8000276e:	f84a                	sd	s2,48(sp)
    80002770:	f44e                	sd	s3,40(sp)
    80002772:	f052                	sd	s4,32(sp)
    80002774:	ec56                	sd	s5,24(sp)
    80002776:	e85a                	sd	s6,16(sp)
    80002778:	e45e                	sd	s7,8(sp)
    8000277a:	e062                	sd	s8,0(sp)
    8000277c:	0880                	addi	s0,sp,80
    8000277e:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    80002780:	fffff097          	auipc	ra,0xfffff
    80002784:	22c080e7          	jalr	556(ra) # 800019ac <myproc>
    80002788:	892a                	mv	s2,a0
  acquire(&wait_lock);
    8000278a:	0000e517          	auipc	a0,0xe
    8000278e:	40e50513          	addi	a0,a0,1038 # 80010b98 <wait_lock>
    80002792:	ffffe097          	auipc	ra,0xffffe
    80002796:	444080e7          	jalr	1092(ra) # 80000bd6 <acquire>
    havekids = 0;
    8000279a:	4b81                	li	s7,0
        if (pp->state == ZOMBIE)
    8000279c:	4a15                	li	s4,5
        havekids = 1;
    8000279e:	4a85                	li	s5,1
    for (pp = proc; pp < &proc[NPROC]; pp++)
    800027a0:	00014997          	auipc	s3,0x14
    800027a4:	21098993          	addi	s3,s3,528 # 800169b0 <tickslock>
    sleep(p, &wait_lock); // DOC: wait-sleep
    800027a8:	0000ec17          	auipc	s8,0xe
    800027ac:	3f0c0c13          	addi	s8,s8,1008 # 80010b98 <wait_lock>
    havekids = 0;
    800027b0:	875e                	mv	a4,s7
    for (pp = proc; pp < &proc[NPROC]; pp++)
    800027b2:	0000e497          	auipc	s1,0xe
    800027b6:	7fe48493          	addi	s1,s1,2046 # 80010fb0 <proc>
    800027ba:	a0bd                	j	80002828 <wait+0xc2>
          pid = pp->pid;
    800027bc:	0304a983          	lw	s3,48(s1)
          if (addr != 0 && copyout(p->pigtable, addr, (char *)&pp->xstate,
    800027c0:	000b0e63          	beqz	s6,800027dc <wait+0x76>
    800027c4:	4691                	li	a3,4
    800027c6:	02c48613          	addi	a2,s1,44
    800027ca:	85da                	mv	a1,s6
    800027cc:	05093503          	ld	a0,80(s2)
    800027d0:	fffff097          	auipc	ra,0xfffff
    800027d4:	e98080e7          	jalr	-360(ra) # 80001668 <copyout>
    800027d8:	02054563          	bltz	a0,80002802 <wait+0x9c>
          freeproc(pp);
    800027dc:	8526                	mv	a0,s1
    800027de:	fffff097          	auipc	ra,0xfffff
    800027e2:	380080e7          	jalr	896(ra) # 80001b5e <freeproc>
          release(&pp->lock);
    800027e6:	8526                	mv	a0,s1
    800027e8:	ffffe097          	auipc	ra,0xffffe
    800027ec:	4a2080e7          	jalr	1186(ra) # 80000c8a <release>
          release(&wait_lock);
    800027f0:	0000e517          	auipc	a0,0xe
    800027f4:	3a850513          	addi	a0,a0,936 # 80010b98 <wait_lock>
    800027f8:	ffffe097          	auipc	ra,0xffffe
    800027fc:	492080e7          	jalr	1170(ra) # 80000c8a <release>
          return pid;
    80002800:	a0b5                	j	8000286c <wait+0x106>
            release(&pp->lock);
    80002802:	8526                	mv	a0,s1
    80002804:	ffffe097          	auipc	ra,0xffffe
    80002808:	486080e7          	jalr	1158(ra) # 80000c8a <release>
            release(&wait_lock);
    8000280c:	0000e517          	auipc	a0,0xe
    80002810:	38c50513          	addi	a0,a0,908 # 80010b98 <wait_lock>
    80002814:	ffffe097          	auipc	ra,0xffffe
    80002818:	476080e7          	jalr	1142(ra) # 80000c8a <release>
            return -1;
    8000281c:	59fd                	li	s3,-1
    8000281e:	a0b9                	j	8000286c <wait+0x106>
    for (pp = proc; pp < &proc[NPROC]; pp++)
    80002820:	16848493          	addi	s1,s1,360
    80002824:	03348463          	beq	s1,s3,8000284c <wait+0xe6>
      if (pp->parent == p)
    80002828:	7c9c                	ld	a5,56(s1)
    8000282a:	ff279be3          	bne	a5,s2,80002820 <wait+0xba>
        acquire(&pp->lock);
    8000282e:	8526                	mv	a0,s1
    80002830:	ffffe097          	auipc	ra,0xffffe
    80002834:	3a6080e7          	jalr	934(ra) # 80000bd6 <acquire>
        if (pp->state == ZOMBIE)
    80002838:	4c9c                	lw	a5,24(s1)
    8000283a:	f94781e3          	beq	a5,s4,800027bc <wait+0x56>
        release(&pp->lock);
    8000283e:	8526                	mv	a0,s1
    80002840:	ffffe097          	auipc	ra,0xffffe
    80002844:	44a080e7          	jalr	1098(ra) # 80000c8a <release>
        havekids = 1;
    80002848:	8756                	mv	a4,s5
    8000284a:	bfd9                	j	80002820 <wait+0xba>
    if (!havekids || killed(p))
    8000284c:	c719                	beqz	a4,8000285a <wait+0xf4>
    8000284e:	854a                	mv	a0,s2
    80002850:	00000097          	auipc	ra,0x0
    80002854:	ee4080e7          	jalr	-284(ra) # 80002734 <killed>
    80002858:	c51d                	beqz	a0,80002886 <wait+0x120>
      release(&wait_lock);
    8000285a:	0000e517          	auipc	a0,0xe
    8000285e:	33e50513          	addi	a0,a0,830 # 80010b98 <wait_lock>
    80002862:	ffffe097          	auipc	ra,0xffffe
    80002866:	428080e7          	jalr	1064(ra) # 80000c8a <release>
      return -1;
    8000286a:	59fd                	li	s3,-1
}
    8000286c:	854e                	mv	a0,s3
    8000286e:	60a6                	ld	ra,72(sp)
    80002870:	6406                	ld	s0,64(sp)
    80002872:	74e2                	ld	s1,56(sp)
    80002874:	7942                	ld	s2,48(sp)
    80002876:	79a2                	ld	s3,40(sp)
    80002878:	7a02                	ld	s4,32(sp)
    8000287a:	6ae2                	ld	s5,24(sp)
    8000287c:	6b42                	ld	s6,16(sp)
    8000287e:	6ba2                	ld	s7,8(sp)
    80002880:	6c02                	ld	s8,0(sp)
    80002882:	6161                	addi	sp,sp,80
    80002884:	8082                	ret
    sleep(p, &wait_lock); // DOC: wait-sleep
    80002886:	85e2                	mv	a1,s8
    80002888:	854a                	mv	a0,s2
    8000288a:	fffff097          	auipc	ra,0xfffff
    8000288e:	7ca080e7          	jalr	1994(ra) # 80002054 <sleep>
    havekids = 0;
    80002892:	bf39                	j	800027b0 <wait+0x4a>

0000000080002894 <either_copyout>:

// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80002894:	7179                	addi	sp,sp,-48
    80002896:	f406                	sd	ra,40(sp)
    80002898:	f022                	sd	s0,32(sp)
    8000289a:	ec26                	sd	s1,24(sp)
    8000289c:	e84a                	sd	s2,16(sp)
    8000289e:	e44e                	sd	s3,8(sp)
    800028a0:	e052                	sd	s4,0(sp)
    800028a2:	1800                	addi	s0,sp,48
    800028a4:	84aa                	mv	s1,a0
    800028a6:	892e                	mv	s2,a1
    800028a8:	89b2                	mv	s3,a2
    800028aa:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800028ac:	fffff097          	auipc	ra,0xfffff
    800028b0:	100080e7          	jalr	256(ra) # 800019ac <myproc>
  if (user_dst)
    800028b4:	c08d                	beqz	s1,800028d6 <either_copyout+0x42>
  {
    return copyout(p->pigtable, dst, src, len);
    800028b6:	86d2                	mv	a3,s4
    800028b8:	864e                	mv	a2,s3
    800028ba:	85ca                	mv	a1,s2
    800028bc:	6928                	ld	a0,80(a0)
    800028be:	fffff097          	auipc	ra,0xfffff
    800028c2:	daa080e7          	jalr	-598(ra) # 80001668 <copyout>
  else
  {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    800028c6:	70a2                	ld	ra,40(sp)
    800028c8:	7402                	ld	s0,32(sp)
    800028ca:	64e2                	ld	s1,24(sp)
    800028cc:	6942                	ld	s2,16(sp)
    800028ce:	69a2                	ld	s3,8(sp)
    800028d0:	6a02                	ld	s4,0(sp)
    800028d2:	6145                	addi	sp,sp,48
    800028d4:	8082                	ret
    memmove((char *)dst, src, len);
    800028d6:	000a061b          	sext.w	a2,s4
    800028da:	85ce                	mv	a1,s3
    800028dc:	854a                	mv	a0,s2
    800028de:	ffffe097          	auipc	ra,0xffffe
    800028e2:	450080e7          	jalr	1104(ra) # 80000d2e <memmove>
    return 0;
    800028e6:	8526                	mv	a0,s1
    800028e8:	bff9                	j	800028c6 <either_copyout+0x32>

00000000800028ea <either_copyin>:

// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    800028ea:	7179                	addi	sp,sp,-48
    800028ec:	f406                	sd	ra,40(sp)
    800028ee:	f022                	sd	s0,32(sp)
    800028f0:	ec26                	sd	s1,24(sp)
    800028f2:	e84a                	sd	s2,16(sp)
    800028f4:	e44e                	sd	s3,8(sp)
    800028f6:	e052                	sd	s4,0(sp)
    800028f8:	1800                	addi	s0,sp,48
    800028fa:	892a                	mv	s2,a0
    800028fc:	84ae                	mv	s1,a1
    800028fe:	89b2                	mv	s3,a2
    80002900:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80002902:	fffff097          	auipc	ra,0xfffff
    80002906:	0aa080e7          	jalr	170(ra) # 800019ac <myproc>
  if (user_src)
    8000290a:	c08d                	beqz	s1,8000292c <either_copyin+0x42>
  {
    return copyin(p->pigtable, dst, src, len);
    8000290c:	86d2                	mv	a3,s4
    8000290e:	864e                	mv	a2,s3
    80002910:	85ca                	mv	a1,s2
    80002912:	6928                	ld	a0,80(a0)
    80002914:	fffff097          	auipc	ra,0xfffff
    80002918:	de0080e7          	jalr	-544(ra) # 800016f4 <copyin>
  else
  {
    memmove(dst, (char *)src, len);
    return 0;
  }
}
    8000291c:	70a2                	ld	ra,40(sp)
    8000291e:	7402                	ld	s0,32(sp)
    80002920:	64e2                	ld	s1,24(sp)
    80002922:	6942                	ld	s2,16(sp)
    80002924:	69a2                	ld	s3,8(sp)
    80002926:	6a02                	ld	s4,0(sp)
    80002928:	6145                	addi	sp,sp,48
    8000292a:	8082                	ret
    memmove(dst, (char *)src, len);
    8000292c:	000a061b          	sext.w	a2,s4
    80002930:	85ce                	mv	a1,s3
    80002932:	854a                	mv	a0,s2
    80002934:	ffffe097          	auipc	ra,0xffffe
    80002938:	3fa080e7          	jalr	1018(ra) # 80000d2e <memmove>
    return 0;
    8000293c:	8526                	mv	a0,s1
    8000293e:	bff9                	j	8000291c <either_copyin+0x32>

0000000080002940 <procdump>:

// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void procdump(void)
{
    80002940:	715d                	addi	sp,sp,-80
    80002942:	e486                	sd	ra,72(sp)
    80002944:	e0a2                	sd	s0,64(sp)
    80002946:	fc26                	sd	s1,56(sp)
    80002948:	f84a                	sd	s2,48(sp)
    8000294a:	f44e                	sd	s3,40(sp)
    8000294c:	f052                	sd	s4,32(sp)
    8000294e:	ec56                	sd	s5,24(sp)
    80002950:	e85a                	sd	s6,16(sp)
    80002952:	e45e                	sd	s7,8(sp)
    80002954:	0880                	addi	s0,sp,80
      [RUNNING] "run   ",
      [ZOMBIE] "zombie"};
  struct proc *p;
  char *state;

  printf("\n");
    80002956:	00005517          	auipc	a0,0x5
    8000295a:	77250513          	addi	a0,a0,1906 # 800080c8 <digits+0x88>
    8000295e:	ffffe097          	auipc	ra,0xffffe
    80002962:	c2a080e7          	jalr	-982(ra) # 80000588 <printf>
  for (p = proc; p < &proc[NPROC]; p++)
    80002966:	0000e497          	auipc	s1,0xe
    8000296a:	7a248493          	addi	s1,s1,1954 # 80011108 <proc+0x158>
    8000296e:	00014917          	auipc	s2,0x14
    80002972:	19a90913          	addi	s2,s2,410 # 80016b08 <bcache+0x140>
  {
    if (p->state == UNUSED)
      continue;
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002976:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80002978:	00006997          	auipc	s3,0x6
    8000297c:	93898993          	addi	s3,s3,-1736 # 800082b0 <digits+0x270>
    printf("%d %s %s", p->pid, state, p->name);
    80002980:	00006a97          	auipc	s5,0x6
    80002984:	938a8a93          	addi	s5,s5,-1736 # 800082b8 <digits+0x278>
    printf("\n");
    80002988:	00005a17          	auipc	s4,0x5
    8000298c:	740a0a13          	addi	s4,s4,1856 # 800080c8 <digits+0x88>
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002990:	00006b97          	auipc	s7,0x6
    80002994:	968b8b93          	addi	s7,s7,-1688 # 800082f8 <digits>
    80002998:	a00d                	j	800029ba <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    8000299a:	ed86a583          	lw	a1,-296(a3)
    8000299e:	8556                	mv	a0,s5
    800029a0:	ffffe097          	auipc	ra,0xffffe
    800029a4:	be8080e7          	jalr	-1048(ra) # 80000588 <printf>
    printf("\n");
    800029a8:	8552                	mv	a0,s4
    800029aa:	ffffe097          	auipc	ra,0xffffe
    800029ae:	bde080e7          	jalr	-1058(ra) # 80000588 <printf>
  for (p = proc; p < &proc[NPROC]; p++)
    800029b2:	16848493          	addi	s1,s1,360
    800029b6:	03248163          	beq	s1,s2,800029d8 <procdump+0x98>
    if (p->state == UNUSED)
    800029ba:	86a6                	mv	a3,s1
    800029bc:	ec04a783          	lw	a5,-320(s1)
    800029c0:	dbed                	beqz	a5,800029b2 <procdump+0x72>
      state = "???";
    800029c2:	864e                	mv	a2,s3
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800029c4:	fcfb6be3          	bltu	s6,a5,8000299a <procdump+0x5a>
    800029c8:	1782                	slli	a5,a5,0x20
    800029ca:	9381                	srli	a5,a5,0x20
    800029cc:	078e                	slli	a5,a5,0x3
    800029ce:	97de                	add	a5,a5,s7
    800029d0:	6f90                	ld	a2,24(a5)
    800029d2:	f661                	bnez	a2,8000299a <procdump+0x5a>
      state = "???";
    800029d4:	864e                	mv	a2,s3
    800029d6:	b7d1                	j	8000299a <procdump+0x5a>
  }
}
    800029d8:	60a6                	ld	ra,72(sp)
    800029da:	6406                	ld	s0,64(sp)
    800029dc:	74e2                	ld	s1,56(sp)
    800029de:	7942                	ld	s2,48(sp)
    800029e0:	79a2                	ld	s3,40(sp)
    800029e2:	7a02                	ld	s4,32(sp)
    800029e4:	6ae2                	ld	s5,24(sp)
    800029e6:	6b42                	ld	s6,16(sp)
    800029e8:	6ba2                	ld	s7,8(sp)
    800029ea:	6161                	addi	sp,sp,80
    800029ec:	8082                	ret

00000000800029ee <swtch>:
    800029ee:	00153023          	sd	ra,0(a0)
    800029f2:	00253423          	sd	sp,8(a0)
    800029f6:	e900                	sd	s0,16(a0)
    800029f8:	ed04                	sd	s1,24(a0)
    800029fa:	03253023          	sd	s2,32(a0)
    800029fe:	03353423          	sd	s3,40(a0)
    80002a02:	03453823          	sd	s4,48(a0)
    80002a06:	03553c23          	sd	s5,56(a0)
    80002a0a:	05653023          	sd	s6,64(a0)
    80002a0e:	05753423          	sd	s7,72(a0)
    80002a12:	05853823          	sd	s8,80(a0)
    80002a16:	05953c23          	sd	s9,88(a0)
    80002a1a:	07a53023          	sd	s10,96(a0)
    80002a1e:	07b53423          	sd	s11,104(a0)
    80002a22:	0005b083          	ld	ra,0(a1)
    80002a26:	0085b103          	ld	sp,8(a1)
    80002a2a:	6980                	ld	s0,16(a1)
    80002a2c:	6d84                	ld	s1,24(a1)
    80002a2e:	0205b903          	ld	s2,32(a1)
    80002a32:	0285b983          	ld	s3,40(a1)
    80002a36:	0305ba03          	ld	s4,48(a1)
    80002a3a:	0385ba83          	ld	s5,56(a1)
    80002a3e:	0405bb03          	ld	s6,64(a1)
    80002a42:	0485bb83          	ld	s7,72(a1)
    80002a46:	0505bc03          	ld	s8,80(a1)
    80002a4a:	0585bc83          	ld	s9,88(a1)
    80002a4e:	0605bd03          	ld	s10,96(a1)
    80002a52:	0685bd83          	ld	s11,104(a1)
    80002a56:	8082                	ret

0000000080002a58 <trapinit>:
    80002a58:	1141                	addi	sp,sp,-16
    80002a5a:	e406                	sd	ra,8(sp)
    80002a5c:	e022                	sd	s0,0(sp)
    80002a5e:	0800                	addi	s0,sp,16
    80002a60:	00006597          	auipc	a1,0x6
    80002a64:	8e058593          	addi	a1,a1,-1824 # 80008340 <states.0+0x30>
    80002a68:	00014517          	auipc	a0,0x14
    80002a6c:	f4850513          	addi	a0,a0,-184 # 800169b0 <tickslock>
    80002a70:	ffffe097          	auipc	ra,0xffffe
    80002a74:	0d6080e7          	jalr	214(ra) # 80000b46 <initlock>
    80002a78:	60a2                	ld	ra,8(sp)
    80002a7a:	6402                	ld	s0,0(sp)
    80002a7c:	0141                	addi	sp,sp,16
    80002a7e:	8082                	ret

0000000080002a80 <trapinithart>:
    80002a80:	1141                	addi	sp,sp,-16
    80002a82:	e422                	sd	s0,8(sp)
    80002a84:	0800                	addi	s0,sp,16
    80002a86:	00003797          	auipc	a5,0x3
    80002a8a:	4ea78793          	addi	a5,a5,1258 # 80005f70 <kernelvec>
    80002a8e:	10579073          	csrw	stvec,a5
    80002a92:	6422                	ld	s0,8(sp)
    80002a94:	0141                	addi	sp,sp,16
    80002a96:	8082                	ret

0000000080002a98 <usertrapret>:
    80002a98:	1141                	addi	sp,sp,-16
    80002a9a:	e406                	sd	ra,8(sp)
    80002a9c:	e022                	sd	s0,0(sp)
    80002a9e:	0800                	addi	s0,sp,16
    80002aa0:	fffff097          	auipc	ra,0xfffff
    80002aa4:	f0c080e7          	jalr	-244(ra) # 800019ac <myproc>
    80002aa8:	100027f3          	csrr	a5,sstatus
    80002aac:	9bf5                	andi	a5,a5,-3
    80002aae:	10079073          	csrw	sstatus,a5
    80002ab2:	00004617          	auipc	a2,0x4
    80002ab6:	54e60613          	addi	a2,a2,1358 # 80007000 <_trampoline>
    80002aba:	00004697          	auipc	a3,0x4
    80002abe:	54668693          	addi	a3,a3,1350 # 80007000 <_trampoline>
    80002ac2:	8e91                	sub	a3,a3,a2
    80002ac4:	040007b7          	lui	a5,0x4000
    80002ac8:	17fd                	addi	a5,a5,-1
    80002aca:	07b2                	slli	a5,a5,0xc
    80002acc:	96be                	add	a3,a3,a5
    80002ace:	10569073          	csrw	stvec,a3
    80002ad2:	6d38                	ld	a4,88(a0)
    80002ad4:	180026f3          	csrr	a3,satp
    80002ad8:	e314                	sd	a3,0(a4)
    80002ada:	6d38                	ld	a4,88(a0)
    80002adc:	6134                	ld	a3,64(a0)
    80002ade:	6585                	lui	a1,0x1
    80002ae0:	96ae                	add	a3,a3,a1
    80002ae2:	e714                	sd	a3,8(a4)
    80002ae4:	6d38                	ld	a4,88(a0)
    80002ae6:	00000697          	auipc	a3,0x0
    80002aea:	13068693          	addi	a3,a3,304 # 80002c16 <usertrap>
    80002aee:	eb14                	sd	a3,16(a4)
    80002af0:	6d38                	ld	a4,88(a0)
    80002af2:	8692                	mv	a3,tp
    80002af4:	f314                	sd	a3,32(a4)
    80002af6:	100026f3          	csrr	a3,sstatus
    80002afa:	eff6f693          	andi	a3,a3,-257
    80002afe:	0206e693          	ori	a3,a3,32
    80002b02:	10069073          	csrw	sstatus,a3
    80002b06:	6d38                	ld	a4,88(a0)
    80002b08:	6f18                	ld	a4,24(a4)
    80002b0a:	14171073          	csrw	sepc,a4
    80002b0e:	6928                	ld	a0,80(a0)
    80002b10:	8131                	srli	a0,a0,0xc
    80002b12:	00004717          	auipc	a4,0x4
    80002b16:	58a70713          	addi	a4,a4,1418 # 8000709c <userret>
    80002b1a:	8f11                	sub	a4,a4,a2
    80002b1c:	97ba                	add	a5,a5,a4
    80002b1e:	577d                	li	a4,-1
    80002b20:	177e                	slli	a4,a4,0x3f
    80002b22:	8d59                	or	a0,a0,a4
    80002b24:	9782                	jalr	a5
    80002b26:	60a2                	ld	ra,8(sp)
    80002b28:	6402                	ld	s0,0(sp)
    80002b2a:	0141                	addi	sp,sp,16
    80002b2c:	8082                	ret

0000000080002b2e <clockintr>:
    80002b2e:	1101                	addi	sp,sp,-32
    80002b30:	ec06                	sd	ra,24(sp)
    80002b32:	e822                	sd	s0,16(sp)
    80002b34:	e426                	sd	s1,8(sp)
    80002b36:	1000                	addi	s0,sp,32
    80002b38:	00014497          	auipc	s1,0x14
    80002b3c:	e7848493          	addi	s1,s1,-392 # 800169b0 <tickslock>
    80002b40:	8526                	mv	a0,s1
    80002b42:	ffffe097          	auipc	ra,0xffffe
    80002b46:	094080e7          	jalr	148(ra) # 80000bd6 <acquire>
    80002b4a:	00006517          	auipc	a0,0x6
    80002b4e:	dc650513          	addi	a0,a0,-570 # 80008910 <ticks>
    80002b52:	411c                	lw	a5,0(a0)
    80002b54:	2785                	addiw	a5,a5,1
    80002b56:	c11c                	sw	a5,0(a0)
    80002b58:	fffff097          	auipc	ra,0xfffff
    80002b5c:	560080e7          	jalr	1376(ra) # 800020b8 <wakeup>
    80002b60:	8526                	mv	a0,s1
    80002b62:	ffffe097          	auipc	ra,0xffffe
    80002b66:	128080e7          	jalr	296(ra) # 80000c8a <release>
    80002b6a:	60e2                	ld	ra,24(sp)
    80002b6c:	6442                	ld	s0,16(sp)
    80002b6e:	64a2                	ld	s1,8(sp)
    80002b70:	6105                	addi	sp,sp,32
    80002b72:	8082                	ret

0000000080002b74 <devintr>:
    80002b74:	1101                	addi	sp,sp,-32
    80002b76:	ec06                	sd	ra,24(sp)
    80002b78:	e822                	sd	s0,16(sp)
    80002b7a:	e426                	sd	s1,8(sp)
    80002b7c:	1000                	addi	s0,sp,32
    80002b7e:	14202773          	csrr	a4,scause
    80002b82:	00074d63          	bltz	a4,80002b9c <devintr+0x28>
    80002b86:	57fd                	li	a5,-1
    80002b88:	17fe                	slli	a5,a5,0x3f
    80002b8a:	0785                	addi	a5,a5,1
    80002b8c:	4501                	li	a0,0
    80002b8e:	06f70363          	beq	a4,a5,80002bf4 <devintr+0x80>
    80002b92:	60e2                	ld	ra,24(sp)
    80002b94:	6442                	ld	s0,16(sp)
    80002b96:	64a2                	ld	s1,8(sp)
    80002b98:	6105                	addi	sp,sp,32
    80002b9a:	8082                	ret
    80002b9c:	0ff77793          	andi	a5,a4,255
    80002ba0:	46a5                	li	a3,9
    80002ba2:	fed792e3          	bne	a5,a3,80002b86 <devintr+0x12>
    80002ba6:	00003097          	auipc	ra,0x3
    80002baa:	4d2080e7          	jalr	1234(ra) # 80006078 <plic_claim>
    80002bae:	84aa                	mv	s1,a0
    80002bb0:	47a9                	li	a5,10
    80002bb2:	02f50763          	beq	a0,a5,80002be0 <devintr+0x6c>
    80002bb6:	4785                	li	a5,1
    80002bb8:	02f50963          	beq	a0,a5,80002bea <devintr+0x76>
    80002bbc:	4505                	li	a0,1
    80002bbe:	d8f1                	beqz	s1,80002b92 <devintr+0x1e>
    80002bc0:	85a6                	mv	a1,s1
    80002bc2:	00005517          	auipc	a0,0x5
    80002bc6:	78650513          	addi	a0,a0,1926 # 80008348 <states.0+0x38>
    80002bca:	ffffe097          	auipc	ra,0xffffe
    80002bce:	9be080e7          	jalr	-1602(ra) # 80000588 <printf>
    80002bd2:	8526                	mv	a0,s1
    80002bd4:	00003097          	auipc	ra,0x3
    80002bd8:	4c8080e7          	jalr	1224(ra) # 8000609c <plic_complete>
    80002bdc:	4505                	li	a0,1
    80002bde:	bf55                	j	80002b92 <devintr+0x1e>
    80002be0:	ffffe097          	auipc	ra,0xffffe
    80002be4:	dba080e7          	jalr	-582(ra) # 8000099a <uartintr>
    80002be8:	b7ed                	j	80002bd2 <devintr+0x5e>
    80002bea:	00004097          	auipc	ra,0x4
    80002bee:	97e080e7          	jalr	-1666(ra) # 80006568 <virtio_disk_intr>
    80002bf2:	b7c5                	j	80002bd2 <devintr+0x5e>
    80002bf4:	fffff097          	auipc	ra,0xfffff
    80002bf8:	d8c080e7          	jalr	-628(ra) # 80001980 <cpuid>
    80002bfc:	c901                	beqz	a0,80002c0c <devintr+0x98>
    80002bfe:	144027f3          	csrr	a5,sip
    80002c02:	9bf5                	andi	a5,a5,-3
    80002c04:	14479073          	csrw	sip,a5
    80002c08:	4509                	li	a0,2
    80002c0a:	b761                	j	80002b92 <devintr+0x1e>
    80002c0c:	00000097          	auipc	ra,0x0
    80002c10:	f22080e7          	jalr	-222(ra) # 80002b2e <clockintr>
    80002c14:	b7ed                	j	80002bfe <devintr+0x8a>

0000000080002c16 <usertrap>:
    80002c16:	1101                	addi	sp,sp,-32
    80002c18:	ec06                	sd	ra,24(sp)
    80002c1a:	e822                	sd	s0,16(sp)
    80002c1c:	e426                	sd	s1,8(sp)
    80002c1e:	e04a                	sd	s2,0(sp)
    80002c20:	1000                	addi	s0,sp,32
    80002c22:	100027f3          	csrr	a5,sstatus
    80002c26:	1007f793          	andi	a5,a5,256
    80002c2a:	e3b1                	bnez	a5,80002c6e <usertrap+0x58>
    80002c2c:	00003797          	auipc	a5,0x3
    80002c30:	34478793          	addi	a5,a5,836 # 80005f70 <kernelvec>
    80002c34:	10579073          	csrw	stvec,a5
    80002c38:	fffff097          	auipc	ra,0xfffff
    80002c3c:	d74080e7          	jalr	-652(ra) # 800019ac <myproc>
    80002c40:	84aa                	mv	s1,a0
    80002c42:	6d3c                	ld	a5,88(a0)
    80002c44:	14102773          	csrr	a4,sepc
    80002c48:	ef98                	sd	a4,24(a5)
    80002c4a:	14202773          	csrr	a4,scause
    80002c4e:	47a1                	li	a5,8
    80002c50:	02f70763          	beq	a4,a5,80002c7e <usertrap+0x68>
    80002c54:	00000097          	auipc	ra,0x0
    80002c58:	f20080e7          	jalr	-224(ra) # 80002b74 <devintr>
    80002c5c:	892a                	mv	s2,a0
    80002c5e:	c151                	beqz	a0,80002ce2 <usertrap+0xcc>
    80002c60:	8526                	mv	a0,s1
    80002c62:	00000097          	auipc	ra,0x0
    80002c66:	ad2080e7          	jalr	-1326(ra) # 80002734 <killed>
    80002c6a:	c929                	beqz	a0,80002cbc <usertrap+0xa6>
    80002c6c:	a099                	j	80002cb2 <usertrap+0x9c>
    80002c6e:	00005517          	auipc	a0,0x5
    80002c72:	6fa50513          	addi	a0,a0,1786 # 80008368 <states.0+0x58>
    80002c76:	ffffe097          	auipc	ra,0xffffe
    80002c7a:	8c8080e7          	jalr	-1848(ra) # 8000053e <panic>
    80002c7e:	00000097          	auipc	ra,0x0
    80002c82:	ab6080e7          	jalr	-1354(ra) # 80002734 <killed>
    80002c86:	e921                	bnez	a0,80002cd6 <usertrap+0xc0>
    80002c88:	6cb8                	ld	a4,88(s1)
    80002c8a:	6f1c                	ld	a5,24(a4)
    80002c8c:	0791                	addi	a5,a5,4
    80002c8e:	ef1c                	sd	a5,24(a4)
    80002c90:	100027f3          	csrr	a5,sstatus
    80002c94:	0027e793          	ori	a5,a5,2
    80002c98:	10079073          	csrw	sstatus,a5
    80002c9c:	00000097          	auipc	ra,0x0
    80002ca0:	2d4080e7          	jalr	724(ra) # 80002f70 <syscall>
    80002ca4:	8526                	mv	a0,s1
    80002ca6:	00000097          	auipc	ra,0x0
    80002caa:	a8e080e7          	jalr	-1394(ra) # 80002734 <killed>
    80002cae:	c911                	beqz	a0,80002cc2 <usertrap+0xac>
    80002cb0:	4901                	li	s2,0
    80002cb2:	557d                	li	a0,-1
    80002cb4:	fffff097          	auipc	ra,0xfffff
    80002cb8:	4d4080e7          	jalr	1236(ra) # 80002188 <exit>
    80002cbc:	4789                	li	a5,2
    80002cbe:	04f90f63          	beq	s2,a5,80002d1c <usertrap+0x106>
    80002cc2:	00000097          	auipc	ra,0x0
    80002cc6:	dd6080e7          	jalr	-554(ra) # 80002a98 <usertrapret>
    80002cca:	60e2                	ld	ra,24(sp)
    80002ccc:	6442                	ld	s0,16(sp)
    80002cce:	64a2                	ld	s1,8(sp)
    80002cd0:	6902                	ld	s2,0(sp)
    80002cd2:	6105                	addi	sp,sp,32
    80002cd4:	8082                	ret
    80002cd6:	557d                	li	a0,-1
    80002cd8:	fffff097          	auipc	ra,0xfffff
    80002cdc:	4b0080e7          	jalr	1200(ra) # 80002188 <exit>
    80002ce0:	b765                	j	80002c88 <usertrap+0x72>
    80002ce2:	142025f3          	csrr	a1,scause
    80002ce6:	5890                	lw	a2,48(s1)
    80002ce8:	00005517          	auipc	a0,0x5
    80002cec:	6a050513          	addi	a0,a0,1696 # 80008388 <states.0+0x78>
    80002cf0:	ffffe097          	auipc	ra,0xffffe
    80002cf4:	898080e7          	jalr	-1896(ra) # 80000588 <printf>
    80002cf8:	141025f3          	csrr	a1,sepc
    80002cfc:	14302673          	csrr	a2,stval
    80002d00:	00005517          	auipc	a0,0x5
    80002d04:	6b850513          	addi	a0,a0,1720 # 800083b8 <states.0+0xa8>
    80002d08:	ffffe097          	auipc	ra,0xffffe
    80002d0c:	880080e7          	jalr	-1920(ra) # 80000588 <printf>
    80002d10:	8526                	mv	a0,s1
    80002d12:	00000097          	auipc	ra,0x0
    80002d16:	9f6080e7          	jalr	-1546(ra) # 80002708 <setkilled>
    80002d1a:	b769                	j	80002ca4 <usertrap+0x8e>
    80002d1c:	fffff097          	auipc	ra,0xfffff
    80002d20:	2fc080e7          	jalr	764(ra) # 80002018 <yield>
    80002d24:	bf79                	j	80002cc2 <usertrap+0xac>

0000000080002d26 <kerneltrap>:
    80002d26:	7179                	addi	sp,sp,-48
    80002d28:	f406                	sd	ra,40(sp)
    80002d2a:	f022                	sd	s0,32(sp)
    80002d2c:	ec26                	sd	s1,24(sp)
    80002d2e:	e84a                	sd	s2,16(sp)
    80002d30:	e44e                	sd	s3,8(sp)
    80002d32:	1800                	addi	s0,sp,48
    80002d34:	14102973          	csrr	s2,sepc
    80002d38:	100024f3          	csrr	s1,sstatus
    80002d3c:	142029f3          	csrr	s3,scause
    80002d40:	1004f793          	andi	a5,s1,256
    80002d44:	cb85                	beqz	a5,80002d74 <kerneltrap+0x4e>
    80002d46:	100027f3          	csrr	a5,sstatus
    80002d4a:	8b89                	andi	a5,a5,2
    80002d4c:	ef85                	bnez	a5,80002d84 <kerneltrap+0x5e>
    80002d4e:	00000097          	auipc	ra,0x0
    80002d52:	e26080e7          	jalr	-474(ra) # 80002b74 <devintr>
    80002d56:	cd1d                	beqz	a0,80002d94 <kerneltrap+0x6e>
    80002d58:	4789                	li	a5,2
    80002d5a:	06f50a63          	beq	a0,a5,80002dce <kerneltrap+0xa8>
    80002d5e:	14191073          	csrw	sepc,s2
    80002d62:	10049073          	csrw	sstatus,s1
    80002d66:	70a2                	ld	ra,40(sp)
    80002d68:	7402                	ld	s0,32(sp)
    80002d6a:	64e2                	ld	s1,24(sp)
    80002d6c:	6942                	ld	s2,16(sp)
    80002d6e:	69a2                	ld	s3,8(sp)
    80002d70:	6145                	addi	sp,sp,48
    80002d72:	8082                	ret
    80002d74:	00005517          	auipc	a0,0x5
    80002d78:	66450513          	addi	a0,a0,1636 # 800083d8 <states.0+0xc8>
    80002d7c:	ffffd097          	auipc	ra,0xffffd
    80002d80:	7c2080e7          	jalr	1986(ra) # 8000053e <panic>
    80002d84:	00005517          	auipc	a0,0x5
    80002d88:	67c50513          	addi	a0,a0,1660 # 80008400 <states.0+0xf0>
    80002d8c:	ffffd097          	auipc	ra,0xffffd
    80002d90:	7b2080e7          	jalr	1970(ra) # 8000053e <panic>
    80002d94:	85ce                	mv	a1,s3
    80002d96:	00005517          	auipc	a0,0x5
    80002d9a:	68a50513          	addi	a0,a0,1674 # 80008420 <states.0+0x110>
    80002d9e:	ffffd097          	auipc	ra,0xffffd
    80002da2:	7ea080e7          	jalr	2026(ra) # 80000588 <printf>
    80002da6:	141025f3          	csrr	a1,sepc
    80002daa:	14302673          	csrr	a2,stval
    80002dae:	00005517          	auipc	a0,0x5
    80002db2:	68250513          	addi	a0,a0,1666 # 80008430 <states.0+0x120>
    80002db6:	ffffd097          	auipc	ra,0xffffd
    80002dba:	7d2080e7          	jalr	2002(ra) # 80000588 <printf>
    80002dbe:	00005517          	auipc	a0,0x5
    80002dc2:	68a50513          	addi	a0,a0,1674 # 80008448 <states.0+0x138>
    80002dc6:	ffffd097          	auipc	ra,0xffffd
    80002dca:	778080e7          	jalr	1912(ra) # 8000053e <panic>
    80002dce:	fffff097          	auipc	ra,0xfffff
    80002dd2:	bde080e7          	jalr	-1058(ra) # 800019ac <myproc>
    80002dd6:	d541                	beqz	a0,80002d5e <kerneltrap+0x38>
    80002dd8:	fffff097          	auipc	ra,0xfffff
    80002ddc:	bd4080e7          	jalr	-1068(ra) # 800019ac <myproc>
    80002de0:	4d18                	lw	a4,24(a0)
    80002de2:	4791                	li	a5,4
    80002de4:	f6f71de3          	bne	a4,a5,80002d5e <kerneltrap+0x38>
    80002de8:	fffff097          	auipc	ra,0xfffff
    80002dec:	230080e7          	jalr	560(ra) # 80002018 <yield>
    80002df0:	b7bd                	j	80002d5e <kerneltrap+0x38>

0000000080002df2 <argraw>:
    80002df2:	1101                	addi	sp,sp,-32
    80002df4:	ec06                	sd	ra,24(sp)
    80002df6:	e822                	sd	s0,16(sp)
    80002df8:	e426                	sd	s1,8(sp)
    80002dfa:	1000                	addi	s0,sp,32
    80002dfc:	84aa                	mv	s1,a0
    80002dfe:	fffff097          	auipc	ra,0xfffff
    80002e02:	bae080e7          	jalr	-1106(ra) # 800019ac <myproc>
    80002e06:	4795                	li	a5,5
    80002e08:	0497e163          	bltu	a5,s1,80002e4a <argraw+0x58>
    80002e0c:	048a                	slli	s1,s1,0x2
    80002e0e:	00005717          	auipc	a4,0x5
    80002e12:	67270713          	addi	a4,a4,1650 # 80008480 <states.0+0x170>
    80002e16:	94ba                	add	s1,s1,a4
    80002e18:	409c                	lw	a5,0(s1)
    80002e1a:	97ba                	add	a5,a5,a4
    80002e1c:	8782                	jr	a5
    80002e1e:	6d3c                	ld	a5,88(a0)
    80002e20:	7ba8                	ld	a0,112(a5)
    80002e22:	60e2                	ld	ra,24(sp)
    80002e24:	6442                	ld	s0,16(sp)
    80002e26:	64a2                	ld	s1,8(sp)
    80002e28:	6105                	addi	sp,sp,32
    80002e2a:	8082                	ret
    80002e2c:	6d3c                	ld	a5,88(a0)
    80002e2e:	7fa8                	ld	a0,120(a5)
    80002e30:	bfcd                	j	80002e22 <argraw+0x30>
    80002e32:	6d3c                	ld	a5,88(a0)
    80002e34:	63c8                	ld	a0,128(a5)
    80002e36:	b7f5                	j	80002e22 <argraw+0x30>
    80002e38:	6d3c                	ld	a5,88(a0)
    80002e3a:	67c8                	ld	a0,136(a5)
    80002e3c:	b7dd                	j	80002e22 <argraw+0x30>
    80002e3e:	6d3c                	ld	a5,88(a0)
    80002e40:	6bc8                	ld	a0,144(a5)
    80002e42:	b7c5                	j	80002e22 <argraw+0x30>
    80002e44:	6d3c                	ld	a5,88(a0)
    80002e46:	6fc8                	ld	a0,152(a5)
    80002e48:	bfe9                	j	80002e22 <argraw+0x30>
    80002e4a:	00005517          	auipc	a0,0x5
    80002e4e:	60e50513          	addi	a0,a0,1550 # 80008458 <states.0+0x148>
    80002e52:	ffffd097          	auipc	ra,0xffffd
    80002e56:	6ec080e7          	jalr	1772(ra) # 8000053e <panic>

0000000080002e5a <fetchaddr>:
    80002e5a:	1101                	addi	sp,sp,-32
    80002e5c:	ec06                	sd	ra,24(sp)
    80002e5e:	e822                	sd	s0,16(sp)
    80002e60:	e426                	sd	s1,8(sp)
    80002e62:	e04a                	sd	s2,0(sp)
    80002e64:	1000                	addi	s0,sp,32
    80002e66:	84aa                	mv	s1,a0
    80002e68:	892e                	mv	s2,a1
    80002e6a:	fffff097          	auipc	ra,0xfffff
    80002e6e:	b42080e7          	jalr	-1214(ra) # 800019ac <myproc>
    80002e72:	653c                	ld	a5,72(a0)
    80002e74:	02f4f863          	bgeu	s1,a5,80002ea4 <fetchaddr+0x4a>
    80002e78:	00848713          	addi	a4,s1,8
    80002e7c:	02e7e663          	bltu	a5,a4,80002ea8 <fetchaddr+0x4e>
    80002e80:	46a1                	li	a3,8
    80002e82:	8626                	mv	a2,s1
    80002e84:	85ca                	mv	a1,s2
    80002e86:	6928                	ld	a0,80(a0)
    80002e88:	fffff097          	auipc	ra,0xfffff
    80002e8c:	86c080e7          	jalr	-1940(ra) # 800016f4 <copyin>
    80002e90:	00a03533          	snez	a0,a0
    80002e94:	40a00533          	neg	a0,a0
    80002e98:	60e2                	ld	ra,24(sp)
    80002e9a:	6442                	ld	s0,16(sp)
    80002e9c:	64a2                	ld	s1,8(sp)
    80002e9e:	6902                	ld	s2,0(sp)
    80002ea0:	6105                	addi	sp,sp,32
    80002ea2:	8082                	ret
    80002ea4:	557d                	li	a0,-1
    80002ea6:	bfcd                	j	80002e98 <fetchaddr+0x3e>
    80002ea8:	557d                	li	a0,-1
    80002eaa:	b7fd                	j	80002e98 <fetchaddr+0x3e>

0000000080002eac <fetchstr>:
    80002eac:	7179                	addi	sp,sp,-48
    80002eae:	f406                	sd	ra,40(sp)
    80002eb0:	f022                	sd	s0,32(sp)
    80002eb2:	ec26                	sd	s1,24(sp)
    80002eb4:	e84a                	sd	s2,16(sp)
    80002eb6:	e44e                	sd	s3,8(sp)
    80002eb8:	1800                	addi	s0,sp,48
    80002eba:	892a                	mv	s2,a0
    80002ebc:	84ae                	mv	s1,a1
    80002ebe:	89b2                	mv	s3,a2
    80002ec0:	fffff097          	auipc	ra,0xfffff
    80002ec4:	aec080e7          	jalr	-1300(ra) # 800019ac <myproc>
    80002ec8:	86ce                	mv	a3,s3
    80002eca:	864a                	mv	a2,s2
    80002ecc:	85a6                	mv	a1,s1
    80002ece:	6928                	ld	a0,80(a0)
    80002ed0:	fffff097          	auipc	ra,0xfffff
    80002ed4:	8b2080e7          	jalr	-1870(ra) # 80001782 <copyinstr>
    80002ed8:	00054e63          	bltz	a0,80002ef4 <fetchstr+0x48>
    80002edc:	8526                	mv	a0,s1
    80002ede:	ffffe097          	auipc	ra,0xffffe
    80002ee2:	f70080e7          	jalr	-144(ra) # 80000e4e <strlen>
    80002ee6:	70a2                	ld	ra,40(sp)
    80002ee8:	7402                	ld	s0,32(sp)
    80002eea:	64e2                	ld	s1,24(sp)
    80002eec:	6942                	ld	s2,16(sp)
    80002eee:	69a2                	ld	s3,8(sp)
    80002ef0:	6145                	addi	sp,sp,48
    80002ef2:	8082                	ret
    80002ef4:	557d                	li	a0,-1
    80002ef6:	bfc5                	j	80002ee6 <fetchstr+0x3a>

0000000080002ef8 <argint>:
    80002ef8:	1101                	addi	sp,sp,-32
    80002efa:	ec06                	sd	ra,24(sp)
    80002efc:	e822                	sd	s0,16(sp)
    80002efe:	e426                	sd	s1,8(sp)
    80002f00:	1000                	addi	s0,sp,32
    80002f02:	84ae                	mv	s1,a1
    80002f04:	00000097          	auipc	ra,0x0
    80002f08:	eee080e7          	jalr	-274(ra) # 80002df2 <argraw>
    80002f0c:	c088                	sw	a0,0(s1)
    80002f0e:	60e2                	ld	ra,24(sp)
    80002f10:	6442                	ld	s0,16(sp)
    80002f12:	64a2                	ld	s1,8(sp)
    80002f14:	6105                	addi	sp,sp,32
    80002f16:	8082                	ret

0000000080002f18 <argaddr>:
    80002f18:	1101                	addi	sp,sp,-32
    80002f1a:	ec06                	sd	ra,24(sp)
    80002f1c:	e822                	sd	s0,16(sp)
    80002f1e:	e426                	sd	s1,8(sp)
    80002f20:	1000                	addi	s0,sp,32
    80002f22:	84ae                	mv	s1,a1
    80002f24:	00000097          	auipc	ra,0x0
    80002f28:	ece080e7          	jalr	-306(ra) # 80002df2 <argraw>
    80002f2c:	e088                	sd	a0,0(s1)
    80002f2e:	60e2                	ld	ra,24(sp)
    80002f30:	6442                	ld	s0,16(sp)
    80002f32:	64a2                	ld	s1,8(sp)
    80002f34:	6105                	addi	sp,sp,32
    80002f36:	8082                	ret

0000000080002f38 <argstr>:
    80002f38:	7179                	addi	sp,sp,-48
    80002f3a:	f406                	sd	ra,40(sp)
    80002f3c:	f022                	sd	s0,32(sp)
    80002f3e:	ec26                	sd	s1,24(sp)
    80002f40:	e84a                	sd	s2,16(sp)
    80002f42:	1800                	addi	s0,sp,48
    80002f44:	84ae                	mv	s1,a1
    80002f46:	8932                	mv	s2,a2
    80002f48:	fd840593          	addi	a1,s0,-40
    80002f4c:	00000097          	auipc	ra,0x0
    80002f50:	fcc080e7          	jalr	-52(ra) # 80002f18 <argaddr>
    80002f54:	864a                	mv	a2,s2
    80002f56:	85a6                	mv	a1,s1
    80002f58:	fd843503          	ld	a0,-40(s0)
    80002f5c:	00000097          	auipc	ra,0x0
    80002f60:	f50080e7          	jalr	-176(ra) # 80002eac <fetchstr>
    80002f64:	70a2                	ld	ra,40(sp)
    80002f66:	7402                	ld	s0,32(sp)
    80002f68:	64e2                	ld	s1,24(sp)
    80002f6a:	6942                	ld	s2,16(sp)
    80002f6c:	6145                	addi	sp,sp,48
    80002f6e:	8082                	ret

0000000080002f70 <syscall>:
    80002f70:	1101                	addi	sp,sp,-32
    80002f72:	ec06                	sd	ra,24(sp)
    80002f74:	e822                	sd	s0,16(sp)
    80002f76:	e426                	sd	s1,8(sp)
    80002f78:	e04a                	sd	s2,0(sp)
    80002f7a:	1000                	addi	s0,sp,32
    80002f7c:	fffff097          	auipc	ra,0xfffff
    80002f80:	a30080e7          	jalr	-1488(ra) # 800019ac <myproc>
    80002f84:	84aa                	mv	s1,a0
    80002f86:	05853903          	ld	s2,88(a0)
    80002f8a:	0a893783          	ld	a5,168(s2)
    80002f8e:	0007869b          	sext.w	a3,a5
    80002f92:	37fd                	addiw	a5,a5,-1
    80002f94:	4755                	li	a4,21
    80002f96:	00f76f63          	bltu	a4,a5,80002fb4 <syscall+0x44>
    80002f9a:	00369713          	slli	a4,a3,0x3
    80002f9e:	00005797          	auipc	a5,0x5
    80002fa2:	4fa78793          	addi	a5,a5,1274 # 80008498 <syscalls>
    80002fa6:	97ba                	add	a5,a5,a4
    80002fa8:	639c                	ld	a5,0(a5)
    80002faa:	c789                	beqz	a5,80002fb4 <syscall+0x44>
    80002fac:	9782                	jalr	a5
    80002fae:	06a93823          	sd	a0,112(s2)
    80002fb2:	a839                	j	80002fd0 <syscall+0x60>
    80002fb4:	15848613          	addi	a2,s1,344
    80002fb8:	588c                	lw	a1,48(s1)
    80002fba:	00005517          	auipc	a0,0x5
    80002fbe:	4a650513          	addi	a0,a0,1190 # 80008460 <states.0+0x150>
    80002fc2:	ffffd097          	auipc	ra,0xffffd
    80002fc6:	5c6080e7          	jalr	1478(ra) # 80000588 <printf>
    80002fca:	6cbc                	ld	a5,88(s1)
    80002fcc:	577d                	li	a4,-1
    80002fce:	fbb8                	sd	a4,112(a5)
    80002fd0:	60e2                	ld	ra,24(sp)
    80002fd2:	6442                	ld	s0,16(sp)
    80002fd4:	64a2                	ld	s1,8(sp)
    80002fd6:	6902                	ld	s2,0(sp)
    80002fd8:	6105                	addi	sp,sp,32
    80002fda:	8082                	ret

0000000080002fdc <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    80002fdc:	1101                	addi	sp,sp,-32
    80002fde:	ec06                	sd	ra,24(sp)
    80002fe0:	e822                	sd	s0,16(sp)
    80002fe2:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    80002fe4:	fec40593          	addi	a1,s0,-20
    80002fe8:	4501                	li	a0,0
    80002fea:	00000097          	auipc	ra,0x0
    80002fee:	f0e080e7          	jalr	-242(ra) # 80002ef8 <argint>
  exit(n);
    80002ff2:	fec42503          	lw	a0,-20(s0)
    80002ff6:	fffff097          	auipc	ra,0xfffff
    80002ffa:	192080e7          	jalr	402(ra) # 80002188 <exit>
  return 0; // not reached
}
    80002ffe:	4501                	li	a0,0
    80003000:	60e2                	ld	ra,24(sp)
    80003002:	6442                	ld	s0,16(sp)
    80003004:	6105                	addi	sp,sp,32
    80003006:	8082                	ret

0000000080003008 <sys_getpid>:

uint64
sys_getpid(void)
{
    80003008:	1141                	addi	sp,sp,-16
    8000300a:	e406                	sd	ra,8(sp)
    8000300c:	e022                	sd	s0,0(sp)
    8000300e:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80003010:	fffff097          	auipc	ra,0xfffff
    80003014:	99c080e7          	jalr	-1636(ra) # 800019ac <myproc>
}
    80003018:	5908                	lw	a0,48(a0)
    8000301a:	60a2                	ld	ra,8(sp)
    8000301c:	6402                	ld	s0,0(sp)
    8000301e:	0141                	addi	sp,sp,16
    80003020:	8082                	ret

0000000080003022 <sys_fork>:

uint64
sys_fork(void)
{
    80003022:	1141                	addi	sp,sp,-16
    80003024:	e406                	sd	ra,8(sp)
    80003026:	e022                	sd	s0,0(sp)
    80003028:	0800                	addi	s0,sp,16
  return fork();
    8000302a:	fffff097          	auipc	ra,0xfffff
    8000302e:	d38080e7          	jalr	-712(ra) # 80001d62 <fork>
}
    80003032:	60a2                	ld	ra,8(sp)
    80003034:	6402                	ld	s0,0(sp)
    80003036:	0141                	addi	sp,sp,16
    80003038:	8082                	ret

000000008000303a <sys_wait>:

uint64
sys_wait(void)
{
    8000303a:	1101                	addi	sp,sp,-32
    8000303c:	ec06                	sd	ra,24(sp)
    8000303e:	e822                	sd	s0,16(sp)
    80003040:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    80003042:	fe840593          	addi	a1,s0,-24
    80003046:	4501                	li	a0,0
    80003048:	00000097          	auipc	ra,0x0
    8000304c:	ed0080e7          	jalr	-304(ra) # 80002f18 <argaddr>
  return wait(p);
    80003050:	fe843503          	ld	a0,-24(s0)
    80003054:	fffff097          	auipc	ra,0xfffff
    80003058:	712080e7          	jalr	1810(ra) # 80002766 <wait>
}
    8000305c:	60e2                	ld	ra,24(sp)
    8000305e:	6442                	ld	s0,16(sp)
    80003060:	6105                	addi	sp,sp,32
    80003062:	8082                	ret

0000000080003064 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80003064:	7179                	addi	sp,sp,-48
    80003066:	f406                	sd	ra,40(sp)
    80003068:	f022                	sd	s0,32(sp)
    8000306a:	ec26                	sd	s1,24(sp)
    8000306c:	1800                	addi	s0,sp,48
  uint64 addr;
  int n;

  argint(0, &n);
    8000306e:	fdc40593          	addi	a1,s0,-36
    80003072:	4501                	li	a0,0
    80003074:	00000097          	auipc	ra,0x0
    80003078:	e84080e7          	jalr	-380(ra) # 80002ef8 <argint>
  addr = myproc()->sz;
    8000307c:	fffff097          	auipc	ra,0xfffff
    80003080:	930080e7          	jalr	-1744(ra) # 800019ac <myproc>
    80003084:	6524                	ld	s1,72(a0)
  if (growproc(n) < 0)
    80003086:	fdc42503          	lw	a0,-36(s0)
    8000308a:	fffff097          	auipc	ra,0xfffff
    8000308e:	c7c080e7          	jalr	-900(ra) # 80001d06 <growproc>
    80003092:	00054863          	bltz	a0,800030a2 <sys_sbrk+0x3e>
    return -1;
  return addr;
}
    80003096:	8526                	mv	a0,s1
    80003098:	70a2                	ld	ra,40(sp)
    8000309a:	7402                	ld	s0,32(sp)
    8000309c:	64e2                	ld	s1,24(sp)
    8000309e:	6145                	addi	sp,sp,48
    800030a0:	8082                	ret
    return -1;
    800030a2:	54fd                	li	s1,-1
    800030a4:	bfcd                	j	80003096 <sys_sbrk+0x32>

00000000800030a6 <sys_sleep>:

uint64
sys_sleep(void)
{
    800030a6:	7139                	addi	sp,sp,-64
    800030a8:	fc06                	sd	ra,56(sp)
    800030aa:	f822                	sd	s0,48(sp)
    800030ac:	f426                	sd	s1,40(sp)
    800030ae:	f04a                	sd	s2,32(sp)
    800030b0:	ec4e                	sd	s3,24(sp)
    800030b2:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    800030b4:	fcc40593          	addi	a1,s0,-52
    800030b8:	4501                	li	a0,0
    800030ba:	00000097          	auipc	ra,0x0
    800030be:	e3e080e7          	jalr	-450(ra) # 80002ef8 <argint>
  acquire(&tickslock);
    800030c2:	00014517          	auipc	a0,0x14
    800030c6:	8ee50513          	addi	a0,a0,-1810 # 800169b0 <tickslock>
    800030ca:	ffffe097          	auipc	ra,0xffffe
    800030ce:	b0c080e7          	jalr	-1268(ra) # 80000bd6 <acquire>
  ticks0 = ticks;
    800030d2:	00006917          	auipc	s2,0x6
    800030d6:	83e92903          	lw	s2,-1986(s2) # 80008910 <ticks>
  while (ticks - ticks0 < n)
    800030da:	fcc42783          	lw	a5,-52(s0)
    800030de:	cf9d                	beqz	a5,8000311c <sys_sleep+0x76>
    if (killed(myproc()))
    {
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    800030e0:	00014997          	auipc	s3,0x14
    800030e4:	8d098993          	addi	s3,s3,-1840 # 800169b0 <tickslock>
    800030e8:	00006497          	auipc	s1,0x6
    800030ec:	82848493          	addi	s1,s1,-2008 # 80008910 <ticks>
    if (killed(myproc()))
    800030f0:	fffff097          	auipc	ra,0xfffff
    800030f4:	8bc080e7          	jalr	-1860(ra) # 800019ac <myproc>
    800030f8:	fffff097          	auipc	ra,0xfffff
    800030fc:	63c080e7          	jalr	1596(ra) # 80002734 <killed>
    80003100:	ed15                	bnez	a0,8000313c <sys_sleep+0x96>
    sleep(&ticks, &tickslock);
    80003102:	85ce                	mv	a1,s3
    80003104:	8526                	mv	a0,s1
    80003106:	fffff097          	auipc	ra,0xfffff
    8000310a:	f4e080e7          	jalr	-178(ra) # 80002054 <sleep>
  while (ticks - ticks0 < n)
    8000310e:	409c                	lw	a5,0(s1)
    80003110:	412787bb          	subw	a5,a5,s2
    80003114:	fcc42703          	lw	a4,-52(s0)
    80003118:	fce7ece3          	bltu	a5,a4,800030f0 <sys_sleep+0x4a>
  }
  release(&tickslock);
    8000311c:	00014517          	auipc	a0,0x14
    80003120:	89450513          	addi	a0,a0,-1900 # 800169b0 <tickslock>
    80003124:	ffffe097          	auipc	ra,0xffffe
    80003128:	b66080e7          	jalr	-1178(ra) # 80000c8a <release>
  return 0;
    8000312c:	4501                	li	a0,0
}
    8000312e:	70e2                	ld	ra,56(sp)
    80003130:	7442                	ld	s0,48(sp)
    80003132:	74a2                	ld	s1,40(sp)
    80003134:	7902                	ld	s2,32(sp)
    80003136:	69e2                	ld	s3,24(sp)
    80003138:	6121                	addi	sp,sp,64
    8000313a:	8082                	ret
      release(&tickslock);
    8000313c:	00014517          	auipc	a0,0x14
    80003140:	87450513          	addi	a0,a0,-1932 # 800169b0 <tickslock>
    80003144:	ffffe097          	auipc	ra,0xffffe
    80003148:	b46080e7          	jalr	-1210(ra) # 80000c8a <release>
      return -1;
    8000314c:	557d                	li	a0,-1
    8000314e:	b7c5                	j	8000312e <sys_sleep+0x88>

0000000080003150 <sys_kill>:

uint64
sys_kill(void)
{
    80003150:	1101                	addi	sp,sp,-32
    80003152:	ec06                	sd	ra,24(sp)
    80003154:	e822                	sd	s0,16(sp)
    80003156:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    80003158:	fec40593          	addi	a1,s0,-20
    8000315c:	4501                	li	a0,0
    8000315e:	00000097          	auipc	ra,0x0
    80003162:	d9a080e7          	jalr	-614(ra) # 80002ef8 <argint>
  return kill(pid);
    80003166:	fec42503          	lw	a0,-20(s0)
    8000316a:	fffff097          	auipc	ra,0xfffff
    8000316e:	0f4080e7          	jalr	244(ra) # 8000225e <kill>
}
    80003172:	60e2                	ld	ra,24(sp)
    80003174:	6442                	ld	s0,16(sp)
    80003176:	6105                	addi	sp,sp,32
    80003178:	8082                	ret

000000008000317a <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    8000317a:	1101                	addi	sp,sp,-32
    8000317c:	ec06                	sd	ra,24(sp)
    8000317e:	e822                	sd	s0,16(sp)
    80003180:	e426                	sd	s1,8(sp)
    80003182:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80003184:	00014517          	auipc	a0,0x14
    80003188:	82c50513          	addi	a0,a0,-2004 # 800169b0 <tickslock>
    8000318c:	ffffe097          	auipc	ra,0xffffe
    80003190:	a4a080e7          	jalr	-1462(ra) # 80000bd6 <acquire>
  xticks = ticks;
    80003194:	00005497          	auipc	s1,0x5
    80003198:	77c4a483          	lw	s1,1916(s1) # 80008910 <ticks>
  release(&tickslock);
    8000319c:	00014517          	auipc	a0,0x14
    800031a0:	81450513          	addi	a0,a0,-2028 # 800169b0 <tickslock>
    800031a4:	ffffe097          	auipc	ra,0xffffe
    800031a8:	ae6080e7          	jalr	-1306(ra) # 80000c8a <release>
  return xticks;
}
    800031ac:	02049513          	slli	a0,s1,0x20
    800031b0:	9101                	srli	a0,a0,0x20
    800031b2:	60e2                	ld	ra,24(sp)
    800031b4:	6442                	ld	s0,16(sp)
    800031b6:	64a2                	ld	s1,8(sp)
    800031b8:	6105                	addi	sp,sp,32
    800031ba:	8082                	ret

00000000800031bc <sys_pigs>:

uint64 sys_pigs(void)
{
    800031bc:	1101                	addi	sp,sp,-32
    800031be:	ec06                	sd	ra,24(sp)
    800031c0:	e822                	sd	s0,16(sp)
    800031c2:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    800031c4:	fec40593          	addi	a1,s0,-20
    800031c8:	4501                	li	a0,0
    800031ca:	00000097          	auipc	ra,0x0
    800031ce:	d2e080e7          	jalr	-722(ra) # 80002ef8 <argint>
  return pigs(pid);
    800031d2:	fec42503          	lw	a0,-20(s0)
    800031d6:	fffff097          	auipc	ra,0xfffff
    800031da:	51a080e7          	jalr	1306(ra) # 800026f0 <pigs>
}
    800031de:	60e2                	ld	ra,24(sp)
    800031e0:	6442                	ld	s0,16(sp)
    800031e2:	6105                	addi	sp,sp,32
    800031e4:	8082                	ret

00000000800031e6 <binit>:
    800031e6:	7179                	addi	sp,sp,-48
    800031e8:	f406                	sd	ra,40(sp)
    800031ea:	f022                	sd	s0,32(sp)
    800031ec:	ec26                	sd	s1,24(sp)
    800031ee:	e84a                	sd	s2,16(sp)
    800031f0:	e44e                	sd	s3,8(sp)
    800031f2:	e052                	sd	s4,0(sp)
    800031f4:	1800                	addi	s0,sp,48
    800031f6:	00005597          	auipc	a1,0x5
    800031fa:	35a58593          	addi	a1,a1,858 # 80008550 <syscalls+0xb8>
    800031fe:	00013517          	auipc	a0,0x13
    80003202:	7ca50513          	addi	a0,a0,1994 # 800169c8 <bcache>
    80003206:	ffffe097          	auipc	ra,0xffffe
    8000320a:	940080e7          	jalr	-1728(ra) # 80000b46 <initlock>
    8000320e:	0001b797          	auipc	a5,0x1b
    80003212:	7ba78793          	addi	a5,a5,1978 # 8001e9c8 <bcache+0x8000>
    80003216:	0001c717          	auipc	a4,0x1c
    8000321a:	a1a70713          	addi	a4,a4,-1510 # 8001ec30 <bcache+0x8268>
    8000321e:	2ae7b823          	sd	a4,688(a5)
    80003222:	2ae7bc23          	sd	a4,696(a5)
    80003226:	00013497          	auipc	s1,0x13
    8000322a:	7ba48493          	addi	s1,s1,1978 # 800169e0 <bcache+0x18>
    8000322e:	893e                	mv	s2,a5
    80003230:	89ba                	mv	s3,a4
    80003232:	00005a17          	auipc	s4,0x5
    80003236:	326a0a13          	addi	s4,s4,806 # 80008558 <syscalls+0xc0>
    8000323a:	2b893783          	ld	a5,696(s2)
    8000323e:	e8bc                	sd	a5,80(s1)
    80003240:	0534b423          	sd	s3,72(s1)
    80003244:	85d2                	mv	a1,s4
    80003246:	01048513          	addi	a0,s1,16
    8000324a:	00001097          	auipc	ra,0x1
    8000324e:	4c4080e7          	jalr	1220(ra) # 8000470e <initsleeplock>
    80003252:	2b893783          	ld	a5,696(s2)
    80003256:	e7a4                	sd	s1,72(a5)
    80003258:	2a993c23          	sd	s1,696(s2)
    8000325c:	45848493          	addi	s1,s1,1112
    80003260:	fd349de3          	bne	s1,s3,8000323a <binit+0x54>
    80003264:	70a2                	ld	ra,40(sp)
    80003266:	7402                	ld	s0,32(sp)
    80003268:	64e2                	ld	s1,24(sp)
    8000326a:	6942                	ld	s2,16(sp)
    8000326c:	69a2                	ld	s3,8(sp)
    8000326e:	6a02                	ld	s4,0(sp)
    80003270:	6145                	addi	sp,sp,48
    80003272:	8082                	ret

0000000080003274 <bread>:
    80003274:	7179                	addi	sp,sp,-48
    80003276:	f406                	sd	ra,40(sp)
    80003278:	f022                	sd	s0,32(sp)
    8000327a:	ec26                	sd	s1,24(sp)
    8000327c:	e84a                	sd	s2,16(sp)
    8000327e:	e44e                	sd	s3,8(sp)
    80003280:	1800                	addi	s0,sp,48
    80003282:	892a                	mv	s2,a0
    80003284:	89ae                	mv	s3,a1
    80003286:	00013517          	auipc	a0,0x13
    8000328a:	74250513          	addi	a0,a0,1858 # 800169c8 <bcache>
    8000328e:	ffffe097          	auipc	ra,0xffffe
    80003292:	948080e7          	jalr	-1720(ra) # 80000bd6 <acquire>
    80003296:	0001c497          	auipc	s1,0x1c
    8000329a:	9ea4b483          	ld	s1,-1558(s1) # 8001ec80 <bcache+0x82b8>
    8000329e:	0001c797          	auipc	a5,0x1c
    800032a2:	99278793          	addi	a5,a5,-1646 # 8001ec30 <bcache+0x8268>
    800032a6:	02f48f63          	beq	s1,a5,800032e4 <bread+0x70>
    800032aa:	873e                	mv	a4,a5
    800032ac:	a021                	j	800032b4 <bread+0x40>
    800032ae:	68a4                	ld	s1,80(s1)
    800032b0:	02e48a63          	beq	s1,a4,800032e4 <bread+0x70>
    800032b4:	449c                	lw	a5,8(s1)
    800032b6:	ff279ce3          	bne	a5,s2,800032ae <bread+0x3a>
    800032ba:	44dc                	lw	a5,12(s1)
    800032bc:	ff3799e3          	bne	a5,s3,800032ae <bread+0x3a>
    800032c0:	40bc                	lw	a5,64(s1)
    800032c2:	2785                	addiw	a5,a5,1
    800032c4:	c0bc                	sw	a5,64(s1)
    800032c6:	00013517          	auipc	a0,0x13
    800032ca:	70250513          	addi	a0,a0,1794 # 800169c8 <bcache>
    800032ce:	ffffe097          	auipc	ra,0xffffe
    800032d2:	9bc080e7          	jalr	-1604(ra) # 80000c8a <release>
    800032d6:	01048513          	addi	a0,s1,16
    800032da:	00001097          	auipc	ra,0x1
    800032de:	46e080e7          	jalr	1134(ra) # 80004748 <acquiresleep>
    800032e2:	a8b9                	j	80003340 <bread+0xcc>
    800032e4:	0001c497          	auipc	s1,0x1c
    800032e8:	9944b483          	ld	s1,-1644(s1) # 8001ec78 <bcache+0x82b0>
    800032ec:	0001c797          	auipc	a5,0x1c
    800032f0:	94478793          	addi	a5,a5,-1724 # 8001ec30 <bcache+0x8268>
    800032f4:	00f48863          	beq	s1,a5,80003304 <bread+0x90>
    800032f8:	873e                	mv	a4,a5
    800032fa:	40bc                	lw	a5,64(s1)
    800032fc:	cf81                	beqz	a5,80003314 <bread+0xa0>
    800032fe:	64a4                	ld	s1,72(s1)
    80003300:	fee49de3          	bne	s1,a4,800032fa <bread+0x86>
    80003304:	00005517          	auipc	a0,0x5
    80003308:	25c50513          	addi	a0,a0,604 # 80008560 <syscalls+0xc8>
    8000330c:	ffffd097          	auipc	ra,0xffffd
    80003310:	232080e7          	jalr	562(ra) # 8000053e <panic>
    80003314:	0124a423          	sw	s2,8(s1)
    80003318:	0134a623          	sw	s3,12(s1)
    8000331c:	0004a023          	sw	zero,0(s1)
    80003320:	4785                	li	a5,1
    80003322:	c0bc                	sw	a5,64(s1)
    80003324:	00013517          	auipc	a0,0x13
    80003328:	6a450513          	addi	a0,a0,1700 # 800169c8 <bcache>
    8000332c:	ffffe097          	auipc	ra,0xffffe
    80003330:	95e080e7          	jalr	-1698(ra) # 80000c8a <release>
    80003334:	01048513          	addi	a0,s1,16
    80003338:	00001097          	auipc	ra,0x1
    8000333c:	410080e7          	jalr	1040(ra) # 80004748 <acquiresleep>
    80003340:	409c                	lw	a5,0(s1)
    80003342:	cb89                	beqz	a5,80003354 <bread+0xe0>
    80003344:	8526                	mv	a0,s1
    80003346:	70a2                	ld	ra,40(sp)
    80003348:	7402                	ld	s0,32(sp)
    8000334a:	64e2                	ld	s1,24(sp)
    8000334c:	6942                	ld	s2,16(sp)
    8000334e:	69a2                	ld	s3,8(sp)
    80003350:	6145                	addi	sp,sp,48
    80003352:	8082                	ret
    80003354:	4581                	li	a1,0
    80003356:	8526                	mv	a0,s1
    80003358:	00003097          	auipc	ra,0x3
    8000335c:	fdc080e7          	jalr	-36(ra) # 80006334 <virtio_disk_rw>
    80003360:	4785                	li	a5,1
    80003362:	c09c                	sw	a5,0(s1)
    80003364:	b7c5                	j	80003344 <bread+0xd0>

0000000080003366 <bwrite>:
    80003366:	1101                	addi	sp,sp,-32
    80003368:	ec06                	sd	ra,24(sp)
    8000336a:	e822                	sd	s0,16(sp)
    8000336c:	e426                	sd	s1,8(sp)
    8000336e:	1000                	addi	s0,sp,32
    80003370:	84aa                	mv	s1,a0
    80003372:	0541                	addi	a0,a0,16
    80003374:	00001097          	auipc	ra,0x1
    80003378:	46e080e7          	jalr	1134(ra) # 800047e2 <holdingsleep>
    8000337c:	cd01                	beqz	a0,80003394 <bwrite+0x2e>
    8000337e:	4585                	li	a1,1
    80003380:	8526                	mv	a0,s1
    80003382:	00003097          	auipc	ra,0x3
    80003386:	fb2080e7          	jalr	-78(ra) # 80006334 <virtio_disk_rw>
    8000338a:	60e2                	ld	ra,24(sp)
    8000338c:	6442                	ld	s0,16(sp)
    8000338e:	64a2                	ld	s1,8(sp)
    80003390:	6105                	addi	sp,sp,32
    80003392:	8082                	ret
    80003394:	00005517          	auipc	a0,0x5
    80003398:	1e450513          	addi	a0,a0,484 # 80008578 <syscalls+0xe0>
    8000339c:	ffffd097          	auipc	ra,0xffffd
    800033a0:	1a2080e7          	jalr	418(ra) # 8000053e <panic>

00000000800033a4 <brelse>:
    800033a4:	1101                	addi	sp,sp,-32
    800033a6:	ec06                	sd	ra,24(sp)
    800033a8:	e822                	sd	s0,16(sp)
    800033aa:	e426                	sd	s1,8(sp)
    800033ac:	e04a                	sd	s2,0(sp)
    800033ae:	1000                	addi	s0,sp,32
    800033b0:	84aa                	mv	s1,a0
    800033b2:	01050913          	addi	s2,a0,16
    800033b6:	854a                	mv	a0,s2
    800033b8:	00001097          	auipc	ra,0x1
    800033bc:	42a080e7          	jalr	1066(ra) # 800047e2 <holdingsleep>
    800033c0:	c92d                	beqz	a0,80003432 <brelse+0x8e>
    800033c2:	854a                	mv	a0,s2
    800033c4:	00001097          	auipc	ra,0x1
    800033c8:	3da080e7          	jalr	986(ra) # 8000479e <releasesleep>
    800033cc:	00013517          	auipc	a0,0x13
    800033d0:	5fc50513          	addi	a0,a0,1532 # 800169c8 <bcache>
    800033d4:	ffffe097          	auipc	ra,0xffffe
    800033d8:	802080e7          	jalr	-2046(ra) # 80000bd6 <acquire>
    800033dc:	40bc                	lw	a5,64(s1)
    800033de:	37fd                	addiw	a5,a5,-1
    800033e0:	0007871b          	sext.w	a4,a5
    800033e4:	c0bc                	sw	a5,64(s1)
    800033e6:	eb05                	bnez	a4,80003416 <brelse+0x72>
    800033e8:	68bc                	ld	a5,80(s1)
    800033ea:	64b8                	ld	a4,72(s1)
    800033ec:	e7b8                	sd	a4,72(a5)
    800033ee:	64bc                	ld	a5,72(s1)
    800033f0:	68b8                	ld	a4,80(s1)
    800033f2:	ebb8                	sd	a4,80(a5)
    800033f4:	0001b797          	auipc	a5,0x1b
    800033f8:	5d478793          	addi	a5,a5,1492 # 8001e9c8 <bcache+0x8000>
    800033fc:	2b87b703          	ld	a4,696(a5)
    80003400:	e8b8                	sd	a4,80(s1)
    80003402:	0001c717          	auipc	a4,0x1c
    80003406:	82e70713          	addi	a4,a4,-2002 # 8001ec30 <bcache+0x8268>
    8000340a:	e4b8                	sd	a4,72(s1)
    8000340c:	2b87b703          	ld	a4,696(a5)
    80003410:	e724                	sd	s1,72(a4)
    80003412:	2a97bc23          	sd	s1,696(a5)
    80003416:	00013517          	auipc	a0,0x13
    8000341a:	5b250513          	addi	a0,a0,1458 # 800169c8 <bcache>
    8000341e:	ffffe097          	auipc	ra,0xffffe
    80003422:	86c080e7          	jalr	-1940(ra) # 80000c8a <release>
    80003426:	60e2                	ld	ra,24(sp)
    80003428:	6442                	ld	s0,16(sp)
    8000342a:	64a2                	ld	s1,8(sp)
    8000342c:	6902                	ld	s2,0(sp)
    8000342e:	6105                	addi	sp,sp,32
    80003430:	8082                	ret
    80003432:	00005517          	auipc	a0,0x5
    80003436:	14e50513          	addi	a0,a0,334 # 80008580 <syscalls+0xe8>
    8000343a:	ffffd097          	auipc	ra,0xffffd
    8000343e:	104080e7          	jalr	260(ra) # 8000053e <panic>

0000000080003442 <bpin>:
    80003442:	1101                	addi	sp,sp,-32
    80003444:	ec06                	sd	ra,24(sp)
    80003446:	e822                	sd	s0,16(sp)
    80003448:	e426                	sd	s1,8(sp)
    8000344a:	1000                	addi	s0,sp,32
    8000344c:	84aa                	mv	s1,a0
    8000344e:	00013517          	auipc	a0,0x13
    80003452:	57a50513          	addi	a0,a0,1402 # 800169c8 <bcache>
    80003456:	ffffd097          	auipc	ra,0xffffd
    8000345a:	780080e7          	jalr	1920(ra) # 80000bd6 <acquire>
    8000345e:	40bc                	lw	a5,64(s1)
    80003460:	2785                	addiw	a5,a5,1
    80003462:	c0bc                	sw	a5,64(s1)
    80003464:	00013517          	auipc	a0,0x13
    80003468:	56450513          	addi	a0,a0,1380 # 800169c8 <bcache>
    8000346c:	ffffe097          	auipc	ra,0xffffe
    80003470:	81e080e7          	jalr	-2018(ra) # 80000c8a <release>
    80003474:	60e2                	ld	ra,24(sp)
    80003476:	6442                	ld	s0,16(sp)
    80003478:	64a2                	ld	s1,8(sp)
    8000347a:	6105                	addi	sp,sp,32
    8000347c:	8082                	ret

000000008000347e <bunpin>:
    8000347e:	1101                	addi	sp,sp,-32
    80003480:	ec06                	sd	ra,24(sp)
    80003482:	e822                	sd	s0,16(sp)
    80003484:	e426                	sd	s1,8(sp)
    80003486:	1000                	addi	s0,sp,32
    80003488:	84aa                	mv	s1,a0
    8000348a:	00013517          	auipc	a0,0x13
    8000348e:	53e50513          	addi	a0,a0,1342 # 800169c8 <bcache>
    80003492:	ffffd097          	auipc	ra,0xffffd
    80003496:	744080e7          	jalr	1860(ra) # 80000bd6 <acquire>
    8000349a:	40bc                	lw	a5,64(s1)
    8000349c:	37fd                	addiw	a5,a5,-1
    8000349e:	c0bc                	sw	a5,64(s1)
    800034a0:	00013517          	auipc	a0,0x13
    800034a4:	52850513          	addi	a0,a0,1320 # 800169c8 <bcache>
    800034a8:	ffffd097          	auipc	ra,0xffffd
    800034ac:	7e2080e7          	jalr	2018(ra) # 80000c8a <release>
    800034b0:	60e2                	ld	ra,24(sp)
    800034b2:	6442                	ld	s0,16(sp)
    800034b4:	64a2                	ld	s1,8(sp)
    800034b6:	6105                	addi	sp,sp,32
    800034b8:	8082                	ret

00000000800034ba <bfree>:
    800034ba:	1101                	addi	sp,sp,-32
    800034bc:	ec06                	sd	ra,24(sp)
    800034be:	e822                	sd	s0,16(sp)
    800034c0:	e426                	sd	s1,8(sp)
    800034c2:	e04a                	sd	s2,0(sp)
    800034c4:	1000                	addi	s0,sp,32
    800034c6:	84ae                	mv	s1,a1
    800034c8:	00d5d59b          	srliw	a1,a1,0xd
    800034cc:	0001c797          	auipc	a5,0x1c
    800034d0:	bd87a783          	lw	a5,-1064(a5) # 8001f0a4 <sb+0x1c>
    800034d4:	9dbd                	addw	a1,a1,a5
    800034d6:	00000097          	auipc	ra,0x0
    800034da:	d9e080e7          	jalr	-610(ra) # 80003274 <bread>
    800034de:	0074f713          	andi	a4,s1,7
    800034e2:	4785                	li	a5,1
    800034e4:	00e797bb          	sllw	a5,a5,a4
    800034e8:	14ce                	slli	s1,s1,0x33
    800034ea:	90d9                	srli	s1,s1,0x36
    800034ec:	00950733          	add	a4,a0,s1
    800034f0:	05874703          	lbu	a4,88(a4)
    800034f4:	00e7f6b3          	and	a3,a5,a4
    800034f8:	c69d                	beqz	a3,80003526 <bfree+0x6c>
    800034fa:	892a                	mv	s2,a0
    800034fc:	94aa                	add	s1,s1,a0
    800034fe:	fff7c793          	not	a5,a5
    80003502:	8ff9                	and	a5,a5,a4
    80003504:	04f48c23          	sb	a5,88(s1)
    80003508:	00001097          	auipc	ra,0x1
    8000350c:	120080e7          	jalr	288(ra) # 80004628 <log_write>
    80003510:	854a                	mv	a0,s2
    80003512:	00000097          	auipc	ra,0x0
    80003516:	e92080e7          	jalr	-366(ra) # 800033a4 <brelse>
    8000351a:	60e2                	ld	ra,24(sp)
    8000351c:	6442                	ld	s0,16(sp)
    8000351e:	64a2                	ld	s1,8(sp)
    80003520:	6902                	ld	s2,0(sp)
    80003522:	6105                	addi	sp,sp,32
    80003524:	8082                	ret
    80003526:	00005517          	auipc	a0,0x5
    8000352a:	06250513          	addi	a0,a0,98 # 80008588 <syscalls+0xf0>
    8000352e:	ffffd097          	auipc	ra,0xffffd
    80003532:	010080e7          	jalr	16(ra) # 8000053e <panic>

0000000080003536 <balloc>:
    80003536:	711d                	addi	sp,sp,-96
    80003538:	ec86                	sd	ra,88(sp)
    8000353a:	e8a2                	sd	s0,80(sp)
    8000353c:	e4a6                	sd	s1,72(sp)
    8000353e:	e0ca                	sd	s2,64(sp)
    80003540:	fc4e                	sd	s3,56(sp)
    80003542:	f852                	sd	s4,48(sp)
    80003544:	f456                	sd	s5,40(sp)
    80003546:	f05a                	sd	s6,32(sp)
    80003548:	ec5e                	sd	s7,24(sp)
    8000354a:	e862                	sd	s8,16(sp)
    8000354c:	e466                	sd	s9,8(sp)
    8000354e:	1080                	addi	s0,sp,96
    80003550:	0001c797          	auipc	a5,0x1c
    80003554:	b3c7a783          	lw	a5,-1220(a5) # 8001f08c <sb+0x4>
    80003558:	10078163          	beqz	a5,8000365a <balloc+0x124>
    8000355c:	8baa                	mv	s7,a0
    8000355e:	4a81                	li	s5,0
    80003560:	0001cb17          	auipc	s6,0x1c
    80003564:	b28b0b13          	addi	s6,s6,-1240 # 8001f088 <sb>
    80003568:	4c01                	li	s8,0
    8000356a:	4985                	li	s3,1
    8000356c:	6a09                	lui	s4,0x2
    8000356e:	6c89                	lui	s9,0x2
    80003570:	a061                	j	800035f8 <balloc+0xc2>
    80003572:	974a                	add	a4,a4,s2
    80003574:	8fd5                	or	a5,a5,a3
    80003576:	04f70c23          	sb	a5,88(a4)
    8000357a:	854a                	mv	a0,s2
    8000357c:	00001097          	auipc	ra,0x1
    80003580:	0ac080e7          	jalr	172(ra) # 80004628 <log_write>
    80003584:	854a                	mv	a0,s2
    80003586:	00000097          	auipc	ra,0x0
    8000358a:	e1e080e7          	jalr	-482(ra) # 800033a4 <brelse>
    8000358e:	85a6                	mv	a1,s1
    80003590:	855e                	mv	a0,s7
    80003592:	00000097          	auipc	ra,0x0
    80003596:	ce2080e7          	jalr	-798(ra) # 80003274 <bread>
    8000359a:	892a                	mv	s2,a0
    8000359c:	40000613          	li	a2,1024
    800035a0:	4581                	li	a1,0
    800035a2:	05850513          	addi	a0,a0,88
    800035a6:	ffffd097          	auipc	ra,0xffffd
    800035aa:	72c080e7          	jalr	1836(ra) # 80000cd2 <memset>
    800035ae:	854a                	mv	a0,s2
    800035b0:	00001097          	auipc	ra,0x1
    800035b4:	078080e7          	jalr	120(ra) # 80004628 <log_write>
    800035b8:	854a                	mv	a0,s2
    800035ba:	00000097          	auipc	ra,0x0
    800035be:	dea080e7          	jalr	-534(ra) # 800033a4 <brelse>
    800035c2:	8526                	mv	a0,s1
    800035c4:	60e6                	ld	ra,88(sp)
    800035c6:	6446                	ld	s0,80(sp)
    800035c8:	64a6                	ld	s1,72(sp)
    800035ca:	6906                	ld	s2,64(sp)
    800035cc:	79e2                	ld	s3,56(sp)
    800035ce:	7a42                	ld	s4,48(sp)
    800035d0:	7aa2                	ld	s5,40(sp)
    800035d2:	7b02                	ld	s6,32(sp)
    800035d4:	6be2                	ld	s7,24(sp)
    800035d6:	6c42                	ld	s8,16(sp)
    800035d8:	6ca2                	ld	s9,8(sp)
    800035da:	6125                	addi	sp,sp,96
    800035dc:	8082                	ret
    800035de:	854a                	mv	a0,s2
    800035e0:	00000097          	auipc	ra,0x0
    800035e4:	dc4080e7          	jalr	-572(ra) # 800033a4 <brelse>
    800035e8:	015c87bb          	addw	a5,s9,s5
    800035ec:	00078a9b          	sext.w	s5,a5
    800035f0:	004b2703          	lw	a4,4(s6)
    800035f4:	06eaf363          	bgeu	s5,a4,8000365a <balloc+0x124>
    800035f8:	41fad79b          	sraiw	a5,s5,0x1f
    800035fc:	0137d79b          	srliw	a5,a5,0x13
    80003600:	015787bb          	addw	a5,a5,s5
    80003604:	40d7d79b          	sraiw	a5,a5,0xd
    80003608:	01cb2583          	lw	a1,28(s6)
    8000360c:	9dbd                	addw	a1,a1,a5
    8000360e:	855e                	mv	a0,s7
    80003610:	00000097          	auipc	ra,0x0
    80003614:	c64080e7          	jalr	-924(ra) # 80003274 <bread>
    80003618:	892a                	mv	s2,a0
    8000361a:	004b2503          	lw	a0,4(s6)
    8000361e:	000a849b          	sext.w	s1,s5
    80003622:	8662                	mv	a2,s8
    80003624:	faa4fde3          	bgeu	s1,a0,800035de <balloc+0xa8>
    80003628:	41f6579b          	sraiw	a5,a2,0x1f
    8000362c:	01d7d69b          	srliw	a3,a5,0x1d
    80003630:	00c6873b          	addw	a4,a3,a2
    80003634:	00777793          	andi	a5,a4,7
    80003638:	9f95                	subw	a5,a5,a3
    8000363a:	00f997bb          	sllw	a5,s3,a5
    8000363e:	4037571b          	sraiw	a4,a4,0x3
    80003642:	00e906b3          	add	a3,s2,a4
    80003646:	0586c683          	lbu	a3,88(a3)
    8000364a:	00d7f5b3          	and	a1,a5,a3
    8000364e:	d195                	beqz	a1,80003572 <balloc+0x3c>
    80003650:	2605                	addiw	a2,a2,1
    80003652:	2485                	addiw	s1,s1,1
    80003654:	fd4618e3          	bne	a2,s4,80003624 <balloc+0xee>
    80003658:	b759                	j	800035de <balloc+0xa8>
    8000365a:	00005517          	auipc	a0,0x5
    8000365e:	f4650513          	addi	a0,a0,-186 # 800085a0 <syscalls+0x108>
    80003662:	ffffd097          	auipc	ra,0xffffd
    80003666:	f26080e7          	jalr	-218(ra) # 80000588 <printf>
    8000366a:	4481                	li	s1,0
    8000366c:	bf99                	j	800035c2 <balloc+0x8c>

000000008000366e <bmap>:
    8000366e:	7179                	addi	sp,sp,-48
    80003670:	f406                	sd	ra,40(sp)
    80003672:	f022                	sd	s0,32(sp)
    80003674:	ec26                	sd	s1,24(sp)
    80003676:	e84a                	sd	s2,16(sp)
    80003678:	e44e                	sd	s3,8(sp)
    8000367a:	e052                	sd	s4,0(sp)
    8000367c:	1800                	addi	s0,sp,48
    8000367e:	89aa                	mv	s3,a0
    80003680:	47ad                	li	a5,11
    80003682:	02b7e763          	bltu	a5,a1,800036b0 <bmap+0x42>
    80003686:	02059493          	slli	s1,a1,0x20
    8000368a:	9081                	srli	s1,s1,0x20
    8000368c:	048a                	slli	s1,s1,0x2
    8000368e:	94aa                	add	s1,s1,a0
    80003690:	0504a903          	lw	s2,80(s1)
    80003694:	06091e63          	bnez	s2,80003710 <bmap+0xa2>
    80003698:	4108                	lw	a0,0(a0)
    8000369a:	00000097          	auipc	ra,0x0
    8000369e:	e9c080e7          	jalr	-356(ra) # 80003536 <balloc>
    800036a2:	0005091b          	sext.w	s2,a0
    800036a6:	06090563          	beqz	s2,80003710 <bmap+0xa2>
    800036aa:	0524a823          	sw	s2,80(s1)
    800036ae:	a08d                	j	80003710 <bmap+0xa2>
    800036b0:	ff45849b          	addiw	s1,a1,-12
    800036b4:	0004871b          	sext.w	a4,s1
    800036b8:	0ff00793          	li	a5,255
    800036bc:	08e7e563          	bltu	a5,a4,80003746 <bmap+0xd8>
    800036c0:	08052903          	lw	s2,128(a0)
    800036c4:	00091d63          	bnez	s2,800036de <bmap+0x70>
    800036c8:	4108                	lw	a0,0(a0)
    800036ca:	00000097          	auipc	ra,0x0
    800036ce:	e6c080e7          	jalr	-404(ra) # 80003536 <balloc>
    800036d2:	0005091b          	sext.w	s2,a0
    800036d6:	02090d63          	beqz	s2,80003710 <bmap+0xa2>
    800036da:	0929a023          	sw	s2,128(s3)
    800036de:	85ca                	mv	a1,s2
    800036e0:	0009a503          	lw	a0,0(s3)
    800036e4:	00000097          	auipc	ra,0x0
    800036e8:	b90080e7          	jalr	-1136(ra) # 80003274 <bread>
    800036ec:	8a2a                	mv	s4,a0
    800036ee:	05850793          	addi	a5,a0,88
    800036f2:	02049593          	slli	a1,s1,0x20
    800036f6:	9181                	srli	a1,a1,0x20
    800036f8:	058a                	slli	a1,a1,0x2
    800036fa:	00b784b3          	add	s1,a5,a1
    800036fe:	0004a903          	lw	s2,0(s1)
    80003702:	02090063          	beqz	s2,80003722 <bmap+0xb4>
    80003706:	8552                	mv	a0,s4
    80003708:	00000097          	auipc	ra,0x0
    8000370c:	c9c080e7          	jalr	-868(ra) # 800033a4 <brelse>
    80003710:	854a                	mv	a0,s2
    80003712:	70a2                	ld	ra,40(sp)
    80003714:	7402                	ld	s0,32(sp)
    80003716:	64e2                	ld	s1,24(sp)
    80003718:	6942                	ld	s2,16(sp)
    8000371a:	69a2                	ld	s3,8(sp)
    8000371c:	6a02                	ld	s4,0(sp)
    8000371e:	6145                	addi	sp,sp,48
    80003720:	8082                	ret
    80003722:	0009a503          	lw	a0,0(s3)
    80003726:	00000097          	auipc	ra,0x0
    8000372a:	e10080e7          	jalr	-496(ra) # 80003536 <balloc>
    8000372e:	0005091b          	sext.w	s2,a0
    80003732:	fc090ae3          	beqz	s2,80003706 <bmap+0x98>
    80003736:	0124a023          	sw	s2,0(s1)
    8000373a:	8552                	mv	a0,s4
    8000373c:	00001097          	auipc	ra,0x1
    80003740:	eec080e7          	jalr	-276(ra) # 80004628 <log_write>
    80003744:	b7c9                	j	80003706 <bmap+0x98>
    80003746:	00005517          	auipc	a0,0x5
    8000374a:	e7250513          	addi	a0,a0,-398 # 800085b8 <syscalls+0x120>
    8000374e:	ffffd097          	auipc	ra,0xffffd
    80003752:	df0080e7          	jalr	-528(ra) # 8000053e <panic>

0000000080003756 <iget>:
    80003756:	7179                	addi	sp,sp,-48
    80003758:	f406                	sd	ra,40(sp)
    8000375a:	f022                	sd	s0,32(sp)
    8000375c:	ec26                	sd	s1,24(sp)
    8000375e:	e84a                	sd	s2,16(sp)
    80003760:	e44e                	sd	s3,8(sp)
    80003762:	e052                	sd	s4,0(sp)
    80003764:	1800                	addi	s0,sp,48
    80003766:	89aa                	mv	s3,a0
    80003768:	8a2e                	mv	s4,a1
    8000376a:	0001c517          	auipc	a0,0x1c
    8000376e:	93e50513          	addi	a0,a0,-1730 # 8001f0a8 <itable>
    80003772:	ffffd097          	auipc	ra,0xffffd
    80003776:	464080e7          	jalr	1124(ra) # 80000bd6 <acquire>
    8000377a:	4901                	li	s2,0
    8000377c:	0001c497          	auipc	s1,0x1c
    80003780:	94448493          	addi	s1,s1,-1724 # 8001f0c0 <itable+0x18>
    80003784:	0001d697          	auipc	a3,0x1d
    80003788:	3cc68693          	addi	a3,a3,972 # 80020b50 <log>
    8000378c:	a039                	j	8000379a <iget+0x44>
    8000378e:	02090b63          	beqz	s2,800037c4 <iget+0x6e>
    80003792:	08848493          	addi	s1,s1,136
    80003796:	02d48a63          	beq	s1,a3,800037ca <iget+0x74>
    8000379a:	449c                	lw	a5,8(s1)
    8000379c:	fef059e3          	blez	a5,8000378e <iget+0x38>
    800037a0:	4098                	lw	a4,0(s1)
    800037a2:	ff3716e3          	bne	a4,s3,8000378e <iget+0x38>
    800037a6:	40d8                	lw	a4,4(s1)
    800037a8:	ff4713e3          	bne	a4,s4,8000378e <iget+0x38>
    800037ac:	2785                	addiw	a5,a5,1
    800037ae:	c49c                	sw	a5,8(s1)
    800037b0:	0001c517          	auipc	a0,0x1c
    800037b4:	8f850513          	addi	a0,a0,-1800 # 8001f0a8 <itable>
    800037b8:	ffffd097          	auipc	ra,0xffffd
    800037bc:	4d2080e7          	jalr	1234(ra) # 80000c8a <release>
    800037c0:	8926                	mv	s2,s1
    800037c2:	a03d                	j	800037f0 <iget+0x9a>
    800037c4:	f7f9                	bnez	a5,80003792 <iget+0x3c>
    800037c6:	8926                	mv	s2,s1
    800037c8:	b7e9                	j	80003792 <iget+0x3c>
    800037ca:	02090c63          	beqz	s2,80003802 <iget+0xac>
    800037ce:	01392023          	sw	s3,0(s2)
    800037d2:	01492223          	sw	s4,4(s2)
    800037d6:	4785                	li	a5,1
    800037d8:	00f92423          	sw	a5,8(s2)
    800037dc:	04092023          	sw	zero,64(s2)
    800037e0:	0001c517          	auipc	a0,0x1c
    800037e4:	8c850513          	addi	a0,a0,-1848 # 8001f0a8 <itable>
    800037e8:	ffffd097          	auipc	ra,0xffffd
    800037ec:	4a2080e7          	jalr	1186(ra) # 80000c8a <release>
    800037f0:	854a                	mv	a0,s2
    800037f2:	70a2                	ld	ra,40(sp)
    800037f4:	7402                	ld	s0,32(sp)
    800037f6:	64e2                	ld	s1,24(sp)
    800037f8:	6942                	ld	s2,16(sp)
    800037fa:	69a2                	ld	s3,8(sp)
    800037fc:	6a02                	ld	s4,0(sp)
    800037fe:	6145                	addi	sp,sp,48
    80003800:	8082                	ret
    80003802:	00005517          	auipc	a0,0x5
    80003806:	dce50513          	addi	a0,a0,-562 # 800085d0 <syscalls+0x138>
    8000380a:	ffffd097          	auipc	ra,0xffffd
    8000380e:	d34080e7          	jalr	-716(ra) # 8000053e <panic>

0000000080003812 <fsinit>:
    80003812:	7179                	addi	sp,sp,-48
    80003814:	f406                	sd	ra,40(sp)
    80003816:	f022                	sd	s0,32(sp)
    80003818:	ec26                	sd	s1,24(sp)
    8000381a:	e84a                	sd	s2,16(sp)
    8000381c:	e44e                	sd	s3,8(sp)
    8000381e:	1800                	addi	s0,sp,48
    80003820:	892a                	mv	s2,a0
    80003822:	4585                	li	a1,1
    80003824:	00000097          	auipc	ra,0x0
    80003828:	a50080e7          	jalr	-1456(ra) # 80003274 <bread>
    8000382c:	84aa                	mv	s1,a0
    8000382e:	0001c997          	auipc	s3,0x1c
    80003832:	85a98993          	addi	s3,s3,-1958 # 8001f088 <sb>
    80003836:	02000613          	li	a2,32
    8000383a:	05850593          	addi	a1,a0,88
    8000383e:	854e                	mv	a0,s3
    80003840:	ffffd097          	auipc	ra,0xffffd
    80003844:	4ee080e7          	jalr	1262(ra) # 80000d2e <memmove>
    80003848:	8526                	mv	a0,s1
    8000384a:	00000097          	auipc	ra,0x0
    8000384e:	b5a080e7          	jalr	-1190(ra) # 800033a4 <brelse>
    80003852:	0009a703          	lw	a4,0(s3)
    80003856:	102037b7          	lui	a5,0x10203
    8000385a:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    8000385e:	02f71263          	bne	a4,a5,80003882 <fsinit+0x70>
    80003862:	0001c597          	auipc	a1,0x1c
    80003866:	82658593          	addi	a1,a1,-2010 # 8001f088 <sb>
    8000386a:	854a                	mv	a0,s2
    8000386c:	00001097          	auipc	ra,0x1
    80003870:	b40080e7          	jalr	-1216(ra) # 800043ac <initlog>
    80003874:	70a2                	ld	ra,40(sp)
    80003876:	7402                	ld	s0,32(sp)
    80003878:	64e2                	ld	s1,24(sp)
    8000387a:	6942                	ld	s2,16(sp)
    8000387c:	69a2                	ld	s3,8(sp)
    8000387e:	6145                	addi	sp,sp,48
    80003880:	8082                	ret
    80003882:	00005517          	auipc	a0,0x5
    80003886:	d5e50513          	addi	a0,a0,-674 # 800085e0 <syscalls+0x148>
    8000388a:	ffffd097          	auipc	ra,0xffffd
    8000388e:	cb4080e7          	jalr	-844(ra) # 8000053e <panic>

0000000080003892 <iinit>:
    80003892:	7179                	addi	sp,sp,-48
    80003894:	f406                	sd	ra,40(sp)
    80003896:	f022                	sd	s0,32(sp)
    80003898:	ec26                	sd	s1,24(sp)
    8000389a:	e84a                	sd	s2,16(sp)
    8000389c:	e44e                	sd	s3,8(sp)
    8000389e:	1800                	addi	s0,sp,48
    800038a0:	00005597          	auipc	a1,0x5
    800038a4:	d5858593          	addi	a1,a1,-680 # 800085f8 <syscalls+0x160>
    800038a8:	0001c517          	auipc	a0,0x1c
    800038ac:	80050513          	addi	a0,a0,-2048 # 8001f0a8 <itable>
    800038b0:	ffffd097          	auipc	ra,0xffffd
    800038b4:	296080e7          	jalr	662(ra) # 80000b46 <initlock>
    800038b8:	0001c497          	auipc	s1,0x1c
    800038bc:	81848493          	addi	s1,s1,-2024 # 8001f0d0 <itable+0x28>
    800038c0:	0001d997          	auipc	s3,0x1d
    800038c4:	2a098993          	addi	s3,s3,672 # 80020b60 <log+0x10>
    800038c8:	00005917          	auipc	s2,0x5
    800038cc:	d3890913          	addi	s2,s2,-712 # 80008600 <syscalls+0x168>
    800038d0:	85ca                	mv	a1,s2
    800038d2:	8526                	mv	a0,s1
    800038d4:	00001097          	auipc	ra,0x1
    800038d8:	e3a080e7          	jalr	-454(ra) # 8000470e <initsleeplock>
    800038dc:	08848493          	addi	s1,s1,136
    800038e0:	ff3498e3          	bne	s1,s3,800038d0 <iinit+0x3e>
    800038e4:	70a2                	ld	ra,40(sp)
    800038e6:	7402                	ld	s0,32(sp)
    800038e8:	64e2                	ld	s1,24(sp)
    800038ea:	6942                	ld	s2,16(sp)
    800038ec:	69a2                	ld	s3,8(sp)
    800038ee:	6145                	addi	sp,sp,48
    800038f0:	8082                	ret

00000000800038f2 <ialloc>:
    800038f2:	715d                	addi	sp,sp,-80
    800038f4:	e486                	sd	ra,72(sp)
    800038f6:	e0a2                	sd	s0,64(sp)
    800038f8:	fc26                	sd	s1,56(sp)
    800038fa:	f84a                	sd	s2,48(sp)
    800038fc:	f44e                	sd	s3,40(sp)
    800038fe:	f052                	sd	s4,32(sp)
    80003900:	ec56                	sd	s5,24(sp)
    80003902:	e85a                	sd	s6,16(sp)
    80003904:	e45e                	sd	s7,8(sp)
    80003906:	0880                	addi	s0,sp,80
    80003908:	0001b717          	auipc	a4,0x1b
    8000390c:	78c72703          	lw	a4,1932(a4) # 8001f094 <sb+0xc>
    80003910:	4785                	li	a5,1
    80003912:	04e7fa63          	bgeu	a5,a4,80003966 <ialloc+0x74>
    80003916:	8aaa                	mv	s5,a0
    80003918:	8bae                	mv	s7,a1
    8000391a:	4485                	li	s1,1
    8000391c:	0001ba17          	auipc	s4,0x1b
    80003920:	76ca0a13          	addi	s4,s4,1900 # 8001f088 <sb>
    80003924:	00048b1b          	sext.w	s6,s1
    80003928:	0044d793          	srli	a5,s1,0x4
    8000392c:	018a2583          	lw	a1,24(s4)
    80003930:	9dbd                	addw	a1,a1,a5
    80003932:	8556                	mv	a0,s5
    80003934:	00000097          	auipc	ra,0x0
    80003938:	940080e7          	jalr	-1728(ra) # 80003274 <bread>
    8000393c:	892a                	mv	s2,a0
    8000393e:	05850993          	addi	s3,a0,88
    80003942:	00f4f793          	andi	a5,s1,15
    80003946:	079a                	slli	a5,a5,0x6
    80003948:	99be                	add	s3,s3,a5
    8000394a:	00099783          	lh	a5,0(s3)
    8000394e:	c3a1                	beqz	a5,8000398e <ialloc+0x9c>
    80003950:	00000097          	auipc	ra,0x0
    80003954:	a54080e7          	jalr	-1452(ra) # 800033a4 <brelse>
    80003958:	0485                	addi	s1,s1,1
    8000395a:	00ca2703          	lw	a4,12(s4)
    8000395e:	0004879b          	sext.w	a5,s1
    80003962:	fce7e1e3          	bltu	a5,a4,80003924 <ialloc+0x32>
    80003966:	00005517          	auipc	a0,0x5
    8000396a:	ca250513          	addi	a0,a0,-862 # 80008608 <syscalls+0x170>
    8000396e:	ffffd097          	auipc	ra,0xffffd
    80003972:	c1a080e7          	jalr	-998(ra) # 80000588 <printf>
    80003976:	4501                	li	a0,0
    80003978:	60a6                	ld	ra,72(sp)
    8000397a:	6406                	ld	s0,64(sp)
    8000397c:	74e2                	ld	s1,56(sp)
    8000397e:	7942                	ld	s2,48(sp)
    80003980:	79a2                	ld	s3,40(sp)
    80003982:	7a02                	ld	s4,32(sp)
    80003984:	6ae2                	ld	s5,24(sp)
    80003986:	6b42                	ld	s6,16(sp)
    80003988:	6ba2                	ld	s7,8(sp)
    8000398a:	6161                	addi	sp,sp,80
    8000398c:	8082                	ret
    8000398e:	04000613          	li	a2,64
    80003992:	4581                	li	a1,0
    80003994:	854e                	mv	a0,s3
    80003996:	ffffd097          	auipc	ra,0xffffd
    8000399a:	33c080e7          	jalr	828(ra) # 80000cd2 <memset>
    8000399e:	01799023          	sh	s7,0(s3)
    800039a2:	854a                	mv	a0,s2
    800039a4:	00001097          	auipc	ra,0x1
    800039a8:	c84080e7          	jalr	-892(ra) # 80004628 <log_write>
    800039ac:	854a                	mv	a0,s2
    800039ae:	00000097          	auipc	ra,0x0
    800039b2:	9f6080e7          	jalr	-1546(ra) # 800033a4 <brelse>
    800039b6:	85da                	mv	a1,s6
    800039b8:	8556                	mv	a0,s5
    800039ba:	00000097          	auipc	ra,0x0
    800039be:	d9c080e7          	jalr	-612(ra) # 80003756 <iget>
    800039c2:	bf5d                	j	80003978 <ialloc+0x86>

00000000800039c4 <iupdate>:
    800039c4:	1101                	addi	sp,sp,-32
    800039c6:	ec06                	sd	ra,24(sp)
    800039c8:	e822                	sd	s0,16(sp)
    800039ca:	e426                	sd	s1,8(sp)
    800039cc:	e04a                	sd	s2,0(sp)
    800039ce:	1000                	addi	s0,sp,32
    800039d0:	84aa                	mv	s1,a0
    800039d2:	415c                	lw	a5,4(a0)
    800039d4:	0047d79b          	srliw	a5,a5,0x4
    800039d8:	0001b597          	auipc	a1,0x1b
    800039dc:	6c85a583          	lw	a1,1736(a1) # 8001f0a0 <sb+0x18>
    800039e0:	9dbd                	addw	a1,a1,a5
    800039e2:	4108                	lw	a0,0(a0)
    800039e4:	00000097          	auipc	ra,0x0
    800039e8:	890080e7          	jalr	-1904(ra) # 80003274 <bread>
    800039ec:	892a                	mv	s2,a0
    800039ee:	05850793          	addi	a5,a0,88
    800039f2:	40c8                	lw	a0,4(s1)
    800039f4:	893d                	andi	a0,a0,15
    800039f6:	051a                	slli	a0,a0,0x6
    800039f8:	953e                	add	a0,a0,a5
    800039fa:	04449703          	lh	a4,68(s1)
    800039fe:	00e51023          	sh	a4,0(a0)
    80003a02:	04649703          	lh	a4,70(s1)
    80003a06:	00e51123          	sh	a4,2(a0)
    80003a0a:	04849703          	lh	a4,72(s1)
    80003a0e:	00e51223          	sh	a4,4(a0)
    80003a12:	04a49703          	lh	a4,74(s1)
    80003a16:	00e51323          	sh	a4,6(a0)
    80003a1a:	44f8                	lw	a4,76(s1)
    80003a1c:	c518                	sw	a4,8(a0)
    80003a1e:	03400613          	li	a2,52
    80003a22:	05048593          	addi	a1,s1,80
    80003a26:	0531                	addi	a0,a0,12
    80003a28:	ffffd097          	auipc	ra,0xffffd
    80003a2c:	306080e7          	jalr	774(ra) # 80000d2e <memmove>
    80003a30:	854a                	mv	a0,s2
    80003a32:	00001097          	auipc	ra,0x1
    80003a36:	bf6080e7          	jalr	-1034(ra) # 80004628 <log_write>
    80003a3a:	854a                	mv	a0,s2
    80003a3c:	00000097          	auipc	ra,0x0
    80003a40:	968080e7          	jalr	-1688(ra) # 800033a4 <brelse>
    80003a44:	60e2                	ld	ra,24(sp)
    80003a46:	6442                	ld	s0,16(sp)
    80003a48:	64a2                	ld	s1,8(sp)
    80003a4a:	6902                	ld	s2,0(sp)
    80003a4c:	6105                	addi	sp,sp,32
    80003a4e:	8082                	ret

0000000080003a50 <idup>:
    80003a50:	1101                	addi	sp,sp,-32
    80003a52:	ec06                	sd	ra,24(sp)
    80003a54:	e822                	sd	s0,16(sp)
    80003a56:	e426                	sd	s1,8(sp)
    80003a58:	1000                	addi	s0,sp,32
    80003a5a:	84aa                	mv	s1,a0
    80003a5c:	0001b517          	auipc	a0,0x1b
    80003a60:	64c50513          	addi	a0,a0,1612 # 8001f0a8 <itable>
    80003a64:	ffffd097          	auipc	ra,0xffffd
    80003a68:	172080e7          	jalr	370(ra) # 80000bd6 <acquire>
    80003a6c:	449c                	lw	a5,8(s1)
    80003a6e:	2785                	addiw	a5,a5,1
    80003a70:	c49c                	sw	a5,8(s1)
    80003a72:	0001b517          	auipc	a0,0x1b
    80003a76:	63650513          	addi	a0,a0,1590 # 8001f0a8 <itable>
    80003a7a:	ffffd097          	auipc	ra,0xffffd
    80003a7e:	210080e7          	jalr	528(ra) # 80000c8a <release>
    80003a82:	8526                	mv	a0,s1
    80003a84:	60e2                	ld	ra,24(sp)
    80003a86:	6442                	ld	s0,16(sp)
    80003a88:	64a2                	ld	s1,8(sp)
    80003a8a:	6105                	addi	sp,sp,32
    80003a8c:	8082                	ret

0000000080003a8e <ilock>:
    80003a8e:	1101                	addi	sp,sp,-32
    80003a90:	ec06                	sd	ra,24(sp)
    80003a92:	e822                	sd	s0,16(sp)
    80003a94:	e426                	sd	s1,8(sp)
    80003a96:	e04a                	sd	s2,0(sp)
    80003a98:	1000                	addi	s0,sp,32
    80003a9a:	c115                	beqz	a0,80003abe <ilock+0x30>
    80003a9c:	84aa                	mv	s1,a0
    80003a9e:	451c                	lw	a5,8(a0)
    80003aa0:	00f05f63          	blez	a5,80003abe <ilock+0x30>
    80003aa4:	0541                	addi	a0,a0,16
    80003aa6:	00001097          	auipc	ra,0x1
    80003aaa:	ca2080e7          	jalr	-862(ra) # 80004748 <acquiresleep>
    80003aae:	40bc                	lw	a5,64(s1)
    80003ab0:	cf99                	beqz	a5,80003ace <ilock+0x40>
    80003ab2:	60e2                	ld	ra,24(sp)
    80003ab4:	6442                	ld	s0,16(sp)
    80003ab6:	64a2                	ld	s1,8(sp)
    80003ab8:	6902                	ld	s2,0(sp)
    80003aba:	6105                	addi	sp,sp,32
    80003abc:	8082                	ret
    80003abe:	00005517          	auipc	a0,0x5
    80003ac2:	b6250513          	addi	a0,a0,-1182 # 80008620 <syscalls+0x188>
    80003ac6:	ffffd097          	auipc	ra,0xffffd
    80003aca:	a78080e7          	jalr	-1416(ra) # 8000053e <panic>
    80003ace:	40dc                	lw	a5,4(s1)
    80003ad0:	0047d79b          	srliw	a5,a5,0x4
    80003ad4:	0001b597          	auipc	a1,0x1b
    80003ad8:	5cc5a583          	lw	a1,1484(a1) # 8001f0a0 <sb+0x18>
    80003adc:	9dbd                	addw	a1,a1,a5
    80003ade:	4088                	lw	a0,0(s1)
    80003ae0:	fffff097          	auipc	ra,0xfffff
    80003ae4:	794080e7          	jalr	1940(ra) # 80003274 <bread>
    80003ae8:	892a                	mv	s2,a0
    80003aea:	05850593          	addi	a1,a0,88
    80003aee:	40dc                	lw	a5,4(s1)
    80003af0:	8bbd                	andi	a5,a5,15
    80003af2:	079a                	slli	a5,a5,0x6
    80003af4:	95be                	add	a1,a1,a5
    80003af6:	00059783          	lh	a5,0(a1)
    80003afa:	04f49223          	sh	a5,68(s1)
    80003afe:	00259783          	lh	a5,2(a1)
    80003b02:	04f49323          	sh	a5,70(s1)
    80003b06:	00459783          	lh	a5,4(a1)
    80003b0a:	04f49423          	sh	a5,72(s1)
    80003b0e:	00659783          	lh	a5,6(a1)
    80003b12:	04f49523          	sh	a5,74(s1)
    80003b16:	459c                	lw	a5,8(a1)
    80003b18:	c4fc                	sw	a5,76(s1)
    80003b1a:	03400613          	li	a2,52
    80003b1e:	05b1                	addi	a1,a1,12
    80003b20:	05048513          	addi	a0,s1,80
    80003b24:	ffffd097          	auipc	ra,0xffffd
    80003b28:	20a080e7          	jalr	522(ra) # 80000d2e <memmove>
    80003b2c:	854a                	mv	a0,s2
    80003b2e:	00000097          	auipc	ra,0x0
    80003b32:	876080e7          	jalr	-1930(ra) # 800033a4 <brelse>
    80003b36:	4785                	li	a5,1
    80003b38:	c0bc                	sw	a5,64(s1)
    80003b3a:	04449783          	lh	a5,68(s1)
    80003b3e:	fbb5                	bnez	a5,80003ab2 <ilock+0x24>
    80003b40:	00005517          	auipc	a0,0x5
    80003b44:	ae850513          	addi	a0,a0,-1304 # 80008628 <syscalls+0x190>
    80003b48:	ffffd097          	auipc	ra,0xffffd
    80003b4c:	9f6080e7          	jalr	-1546(ra) # 8000053e <panic>

0000000080003b50 <iunlock>:
    80003b50:	1101                	addi	sp,sp,-32
    80003b52:	ec06                	sd	ra,24(sp)
    80003b54:	e822                	sd	s0,16(sp)
    80003b56:	e426                	sd	s1,8(sp)
    80003b58:	e04a                	sd	s2,0(sp)
    80003b5a:	1000                	addi	s0,sp,32
    80003b5c:	c905                	beqz	a0,80003b8c <iunlock+0x3c>
    80003b5e:	84aa                	mv	s1,a0
    80003b60:	01050913          	addi	s2,a0,16
    80003b64:	854a                	mv	a0,s2
    80003b66:	00001097          	auipc	ra,0x1
    80003b6a:	c7c080e7          	jalr	-900(ra) # 800047e2 <holdingsleep>
    80003b6e:	cd19                	beqz	a0,80003b8c <iunlock+0x3c>
    80003b70:	449c                	lw	a5,8(s1)
    80003b72:	00f05d63          	blez	a5,80003b8c <iunlock+0x3c>
    80003b76:	854a                	mv	a0,s2
    80003b78:	00001097          	auipc	ra,0x1
    80003b7c:	c26080e7          	jalr	-986(ra) # 8000479e <releasesleep>
    80003b80:	60e2                	ld	ra,24(sp)
    80003b82:	6442                	ld	s0,16(sp)
    80003b84:	64a2                	ld	s1,8(sp)
    80003b86:	6902                	ld	s2,0(sp)
    80003b88:	6105                	addi	sp,sp,32
    80003b8a:	8082                	ret
    80003b8c:	00005517          	auipc	a0,0x5
    80003b90:	aac50513          	addi	a0,a0,-1364 # 80008638 <syscalls+0x1a0>
    80003b94:	ffffd097          	auipc	ra,0xffffd
    80003b98:	9aa080e7          	jalr	-1622(ra) # 8000053e <panic>

0000000080003b9c <itrunc>:
    80003b9c:	7179                	addi	sp,sp,-48
    80003b9e:	f406                	sd	ra,40(sp)
    80003ba0:	f022                	sd	s0,32(sp)
    80003ba2:	ec26                	sd	s1,24(sp)
    80003ba4:	e84a                	sd	s2,16(sp)
    80003ba6:	e44e                	sd	s3,8(sp)
    80003ba8:	e052                	sd	s4,0(sp)
    80003baa:	1800                	addi	s0,sp,48
    80003bac:	89aa                	mv	s3,a0
    80003bae:	05050493          	addi	s1,a0,80
    80003bb2:	08050913          	addi	s2,a0,128
    80003bb6:	a021                	j	80003bbe <itrunc+0x22>
    80003bb8:	0491                	addi	s1,s1,4
    80003bba:	01248d63          	beq	s1,s2,80003bd4 <itrunc+0x38>
    80003bbe:	408c                	lw	a1,0(s1)
    80003bc0:	dde5                	beqz	a1,80003bb8 <itrunc+0x1c>
    80003bc2:	0009a503          	lw	a0,0(s3)
    80003bc6:	00000097          	auipc	ra,0x0
    80003bca:	8f4080e7          	jalr	-1804(ra) # 800034ba <bfree>
    80003bce:	0004a023          	sw	zero,0(s1)
    80003bd2:	b7dd                	j	80003bb8 <itrunc+0x1c>
    80003bd4:	0809a583          	lw	a1,128(s3)
    80003bd8:	e185                	bnez	a1,80003bf8 <itrunc+0x5c>
    80003bda:	0409a623          	sw	zero,76(s3)
    80003bde:	854e                	mv	a0,s3
    80003be0:	00000097          	auipc	ra,0x0
    80003be4:	de4080e7          	jalr	-540(ra) # 800039c4 <iupdate>
    80003be8:	70a2                	ld	ra,40(sp)
    80003bea:	7402                	ld	s0,32(sp)
    80003bec:	64e2                	ld	s1,24(sp)
    80003bee:	6942                	ld	s2,16(sp)
    80003bf0:	69a2                	ld	s3,8(sp)
    80003bf2:	6a02                	ld	s4,0(sp)
    80003bf4:	6145                	addi	sp,sp,48
    80003bf6:	8082                	ret
    80003bf8:	0009a503          	lw	a0,0(s3)
    80003bfc:	fffff097          	auipc	ra,0xfffff
    80003c00:	678080e7          	jalr	1656(ra) # 80003274 <bread>
    80003c04:	8a2a                	mv	s4,a0
    80003c06:	05850493          	addi	s1,a0,88
    80003c0a:	45850913          	addi	s2,a0,1112
    80003c0e:	a021                	j	80003c16 <itrunc+0x7a>
    80003c10:	0491                	addi	s1,s1,4
    80003c12:	01248b63          	beq	s1,s2,80003c28 <itrunc+0x8c>
    80003c16:	408c                	lw	a1,0(s1)
    80003c18:	dde5                	beqz	a1,80003c10 <itrunc+0x74>
    80003c1a:	0009a503          	lw	a0,0(s3)
    80003c1e:	00000097          	auipc	ra,0x0
    80003c22:	89c080e7          	jalr	-1892(ra) # 800034ba <bfree>
    80003c26:	b7ed                	j	80003c10 <itrunc+0x74>
    80003c28:	8552                	mv	a0,s4
    80003c2a:	fffff097          	auipc	ra,0xfffff
    80003c2e:	77a080e7          	jalr	1914(ra) # 800033a4 <brelse>
    80003c32:	0809a583          	lw	a1,128(s3)
    80003c36:	0009a503          	lw	a0,0(s3)
    80003c3a:	00000097          	auipc	ra,0x0
    80003c3e:	880080e7          	jalr	-1920(ra) # 800034ba <bfree>
    80003c42:	0809a023          	sw	zero,128(s3)
    80003c46:	bf51                	j	80003bda <itrunc+0x3e>

0000000080003c48 <iput>:
    80003c48:	1101                	addi	sp,sp,-32
    80003c4a:	ec06                	sd	ra,24(sp)
    80003c4c:	e822                	sd	s0,16(sp)
    80003c4e:	e426                	sd	s1,8(sp)
    80003c50:	e04a                	sd	s2,0(sp)
    80003c52:	1000                	addi	s0,sp,32
    80003c54:	84aa                	mv	s1,a0
    80003c56:	0001b517          	auipc	a0,0x1b
    80003c5a:	45250513          	addi	a0,a0,1106 # 8001f0a8 <itable>
    80003c5e:	ffffd097          	auipc	ra,0xffffd
    80003c62:	f78080e7          	jalr	-136(ra) # 80000bd6 <acquire>
    80003c66:	4498                	lw	a4,8(s1)
    80003c68:	4785                	li	a5,1
    80003c6a:	02f70363          	beq	a4,a5,80003c90 <iput+0x48>
    80003c6e:	449c                	lw	a5,8(s1)
    80003c70:	37fd                	addiw	a5,a5,-1
    80003c72:	c49c                	sw	a5,8(s1)
    80003c74:	0001b517          	auipc	a0,0x1b
    80003c78:	43450513          	addi	a0,a0,1076 # 8001f0a8 <itable>
    80003c7c:	ffffd097          	auipc	ra,0xffffd
    80003c80:	00e080e7          	jalr	14(ra) # 80000c8a <release>
    80003c84:	60e2                	ld	ra,24(sp)
    80003c86:	6442                	ld	s0,16(sp)
    80003c88:	64a2                	ld	s1,8(sp)
    80003c8a:	6902                	ld	s2,0(sp)
    80003c8c:	6105                	addi	sp,sp,32
    80003c8e:	8082                	ret
    80003c90:	40bc                	lw	a5,64(s1)
    80003c92:	dff1                	beqz	a5,80003c6e <iput+0x26>
    80003c94:	04a49783          	lh	a5,74(s1)
    80003c98:	fbf9                	bnez	a5,80003c6e <iput+0x26>
    80003c9a:	01048913          	addi	s2,s1,16
    80003c9e:	854a                	mv	a0,s2
    80003ca0:	00001097          	auipc	ra,0x1
    80003ca4:	aa8080e7          	jalr	-1368(ra) # 80004748 <acquiresleep>
    80003ca8:	0001b517          	auipc	a0,0x1b
    80003cac:	40050513          	addi	a0,a0,1024 # 8001f0a8 <itable>
    80003cb0:	ffffd097          	auipc	ra,0xffffd
    80003cb4:	fda080e7          	jalr	-38(ra) # 80000c8a <release>
    80003cb8:	8526                	mv	a0,s1
    80003cba:	00000097          	auipc	ra,0x0
    80003cbe:	ee2080e7          	jalr	-286(ra) # 80003b9c <itrunc>
    80003cc2:	04049223          	sh	zero,68(s1)
    80003cc6:	8526                	mv	a0,s1
    80003cc8:	00000097          	auipc	ra,0x0
    80003ccc:	cfc080e7          	jalr	-772(ra) # 800039c4 <iupdate>
    80003cd0:	0404a023          	sw	zero,64(s1)
    80003cd4:	854a                	mv	a0,s2
    80003cd6:	00001097          	auipc	ra,0x1
    80003cda:	ac8080e7          	jalr	-1336(ra) # 8000479e <releasesleep>
    80003cde:	0001b517          	auipc	a0,0x1b
    80003ce2:	3ca50513          	addi	a0,a0,970 # 8001f0a8 <itable>
    80003ce6:	ffffd097          	auipc	ra,0xffffd
    80003cea:	ef0080e7          	jalr	-272(ra) # 80000bd6 <acquire>
    80003cee:	b741                	j	80003c6e <iput+0x26>

0000000080003cf0 <iunlockput>:
    80003cf0:	1101                	addi	sp,sp,-32
    80003cf2:	ec06                	sd	ra,24(sp)
    80003cf4:	e822                	sd	s0,16(sp)
    80003cf6:	e426                	sd	s1,8(sp)
    80003cf8:	1000                	addi	s0,sp,32
    80003cfa:	84aa                	mv	s1,a0
    80003cfc:	00000097          	auipc	ra,0x0
    80003d00:	e54080e7          	jalr	-428(ra) # 80003b50 <iunlock>
    80003d04:	8526                	mv	a0,s1
    80003d06:	00000097          	auipc	ra,0x0
    80003d0a:	f42080e7          	jalr	-190(ra) # 80003c48 <iput>
    80003d0e:	60e2                	ld	ra,24(sp)
    80003d10:	6442                	ld	s0,16(sp)
    80003d12:	64a2                	ld	s1,8(sp)
    80003d14:	6105                	addi	sp,sp,32
    80003d16:	8082                	ret

0000000080003d18 <stati>:
    80003d18:	1141                	addi	sp,sp,-16
    80003d1a:	e422                	sd	s0,8(sp)
    80003d1c:	0800                	addi	s0,sp,16
    80003d1e:	411c                	lw	a5,0(a0)
    80003d20:	c19c                	sw	a5,0(a1)
    80003d22:	415c                	lw	a5,4(a0)
    80003d24:	c1dc                	sw	a5,4(a1)
    80003d26:	04451783          	lh	a5,68(a0)
    80003d2a:	00f59423          	sh	a5,8(a1)
    80003d2e:	04a51783          	lh	a5,74(a0)
    80003d32:	00f59523          	sh	a5,10(a1)
    80003d36:	04c56783          	lwu	a5,76(a0)
    80003d3a:	e99c                	sd	a5,16(a1)
    80003d3c:	6422                	ld	s0,8(sp)
    80003d3e:	0141                	addi	sp,sp,16
    80003d40:	8082                	ret

0000000080003d42 <readi>:
    80003d42:	457c                	lw	a5,76(a0)
    80003d44:	0ed7e963          	bltu	a5,a3,80003e36 <readi+0xf4>
    80003d48:	7159                	addi	sp,sp,-112
    80003d4a:	f486                	sd	ra,104(sp)
    80003d4c:	f0a2                	sd	s0,96(sp)
    80003d4e:	eca6                	sd	s1,88(sp)
    80003d50:	e8ca                	sd	s2,80(sp)
    80003d52:	e4ce                	sd	s3,72(sp)
    80003d54:	e0d2                	sd	s4,64(sp)
    80003d56:	fc56                	sd	s5,56(sp)
    80003d58:	f85a                	sd	s6,48(sp)
    80003d5a:	f45e                	sd	s7,40(sp)
    80003d5c:	f062                	sd	s8,32(sp)
    80003d5e:	ec66                	sd	s9,24(sp)
    80003d60:	e86a                	sd	s10,16(sp)
    80003d62:	e46e                	sd	s11,8(sp)
    80003d64:	1880                	addi	s0,sp,112
    80003d66:	8b2a                	mv	s6,a0
    80003d68:	8bae                	mv	s7,a1
    80003d6a:	8a32                	mv	s4,a2
    80003d6c:	84b6                	mv	s1,a3
    80003d6e:	8aba                	mv	s5,a4
    80003d70:	9f35                	addw	a4,a4,a3
    80003d72:	4501                	li	a0,0
    80003d74:	0ad76063          	bltu	a4,a3,80003e14 <readi+0xd2>
    80003d78:	00e7f463          	bgeu	a5,a4,80003d80 <readi+0x3e>
    80003d7c:	40d78abb          	subw	s5,a5,a3
    80003d80:	0a0a8963          	beqz	s5,80003e32 <readi+0xf0>
    80003d84:	4981                	li	s3,0
    80003d86:	40000c93          	li	s9,1024
    80003d8a:	5c7d                	li	s8,-1
    80003d8c:	a82d                	j	80003dc6 <readi+0x84>
    80003d8e:	020d1d93          	slli	s11,s10,0x20
    80003d92:	020ddd93          	srli	s11,s11,0x20
    80003d96:	05890793          	addi	a5,s2,88
    80003d9a:	86ee                	mv	a3,s11
    80003d9c:	963e                	add	a2,a2,a5
    80003d9e:	85d2                	mv	a1,s4
    80003da0:	855e                	mv	a0,s7
    80003da2:	fffff097          	auipc	ra,0xfffff
    80003da6:	af2080e7          	jalr	-1294(ra) # 80002894 <either_copyout>
    80003daa:	05850d63          	beq	a0,s8,80003e04 <readi+0xc2>
    80003dae:	854a                	mv	a0,s2
    80003db0:	fffff097          	auipc	ra,0xfffff
    80003db4:	5f4080e7          	jalr	1524(ra) # 800033a4 <brelse>
    80003db8:	013d09bb          	addw	s3,s10,s3
    80003dbc:	009d04bb          	addw	s1,s10,s1
    80003dc0:	9a6e                	add	s4,s4,s11
    80003dc2:	0559f763          	bgeu	s3,s5,80003e10 <readi+0xce>
    80003dc6:	00a4d59b          	srliw	a1,s1,0xa
    80003dca:	855a                	mv	a0,s6
    80003dcc:	00000097          	auipc	ra,0x0
    80003dd0:	8a2080e7          	jalr	-1886(ra) # 8000366e <bmap>
    80003dd4:	0005059b          	sext.w	a1,a0
    80003dd8:	cd85                	beqz	a1,80003e10 <readi+0xce>
    80003dda:	000b2503          	lw	a0,0(s6)
    80003dde:	fffff097          	auipc	ra,0xfffff
    80003de2:	496080e7          	jalr	1174(ra) # 80003274 <bread>
    80003de6:	892a                	mv	s2,a0
    80003de8:	3ff4f613          	andi	a2,s1,1023
    80003dec:	40cc87bb          	subw	a5,s9,a2
    80003df0:	413a873b          	subw	a4,s5,s3
    80003df4:	8d3e                	mv	s10,a5
    80003df6:	2781                	sext.w	a5,a5
    80003df8:	0007069b          	sext.w	a3,a4
    80003dfc:	f8f6f9e3          	bgeu	a3,a5,80003d8e <readi+0x4c>
    80003e00:	8d3a                	mv	s10,a4
    80003e02:	b771                	j	80003d8e <readi+0x4c>
    80003e04:	854a                	mv	a0,s2
    80003e06:	fffff097          	auipc	ra,0xfffff
    80003e0a:	59e080e7          	jalr	1438(ra) # 800033a4 <brelse>
    80003e0e:	59fd                	li	s3,-1
    80003e10:	0009851b          	sext.w	a0,s3
    80003e14:	70a6                	ld	ra,104(sp)
    80003e16:	7406                	ld	s0,96(sp)
    80003e18:	64e6                	ld	s1,88(sp)
    80003e1a:	6946                	ld	s2,80(sp)
    80003e1c:	69a6                	ld	s3,72(sp)
    80003e1e:	6a06                	ld	s4,64(sp)
    80003e20:	7ae2                	ld	s5,56(sp)
    80003e22:	7b42                	ld	s6,48(sp)
    80003e24:	7ba2                	ld	s7,40(sp)
    80003e26:	7c02                	ld	s8,32(sp)
    80003e28:	6ce2                	ld	s9,24(sp)
    80003e2a:	6d42                	ld	s10,16(sp)
    80003e2c:	6da2                	ld	s11,8(sp)
    80003e2e:	6165                	addi	sp,sp,112
    80003e30:	8082                	ret
    80003e32:	89d6                	mv	s3,s5
    80003e34:	bff1                	j	80003e10 <readi+0xce>
    80003e36:	4501                	li	a0,0
    80003e38:	8082                	ret

0000000080003e3a <writei>:
    80003e3a:	457c                	lw	a5,76(a0)
    80003e3c:	10d7e863          	bltu	a5,a3,80003f4c <writei+0x112>
    80003e40:	7159                	addi	sp,sp,-112
    80003e42:	f486                	sd	ra,104(sp)
    80003e44:	f0a2                	sd	s0,96(sp)
    80003e46:	eca6                	sd	s1,88(sp)
    80003e48:	e8ca                	sd	s2,80(sp)
    80003e4a:	e4ce                	sd	s3,72(sp)
    80003e4c:	e0d2                	sd	s4,64(sp)
    80003e4e:	fc56                	sd	s5,56(sp)
    80003e50:	f85a                	sd	s6,48(sp)
    80003e52:	f45e                	sd	s7,40(sp)
    80003e54:	f062                	sd	s8,32(sp)
    80003e56:	ec66                	sd	s9,24(sp)
    80003e58:	e86a                	sd	s10,16(sp)
    80003e5a:	e46e                	sd	s11,8(sp)
    80003e5c:	1880                	addi	s0,sp,112
    80003e5e:	8aaa                	mv	s5,a0
    80003e60:	8bae                	mv	s7,a1
    80003e62:	8a32                	mv	s4,a2
    80003e64:	8936                	mv	s2,a3
    80003e66:	8b3a                	mv	s6,a4
    80003e68:	00e687bb          	addw	a5,a3,a4
    80003e6c:	0ed7e263          	bltu	a5,a3,80003f50 <writei+0x116>
    80003e70:	00043737          	lui	a4,0x43
    80003e74:	0ef76063          	bltu	a4,a5,80003f54 <writei+0x11a>
    80003e78:	0c0b0863          	beqz	s6,80003f48 <writei+0x10e>
    80003e7c:	4981                	li	s3,0
    80003e7e:	40000c93          	li	s9,1024
    80003e82:	5c7d                	li	s8,-1
    80003e84:	a091                	j	80003ec8 <writei+0x8e>
    80003e86:	020d1d93          	slli	s11,s10,0x20
    80003e8a:	020ddd93          	srli	s11,s11,0x20
    80003e8e:	05848793          	addi	a5,s1,88
    80003e92:	86ee                	mv	a3,s11
    80003e94:	8652                	mv	a2,s4
    80003e96:	85de                	mv	a1,s7
    80003e98:	953e                	add	a0,a0,a5
    80003e9a:	fffff097          	auipc	ra,0xfffff
    80003e9e:	a50080e7          	jalr	-1456(ra) # 800028ea <either_copyin>
    80003ea2:	07850263          	beq	a0,s8,80003f06 <writei+0xcc>
    80003ea6:	8526                	mv	a0,s1
    80003ea8:	00000097          	auipc	ra,0x0
    80003eac:	780080e7          	jalr	1920(ra) # 80004628 <log_write>
    80003eb0:	8526                	mv	a0,s1
    80003eb2:	fffff097          	auipc	ra,0xfffff
    80003eb6:	4f2080e7          	jalr	1266(ra) # 800033a4 <brelse>
    80003eba:	013d09bb          	addw	s3,s10,s3
    80003ebe:	012d093b          	addw	s2,s10,s2
    80003ec2:	9a6e                	add	s4,s4,s11
    80003ec4:	0569f663          	bgeu	s3,s6,80003f10 <writei+0xd6>
    80003ec8:	00a9559b          	srliw	a1,s2,0xa
    80003ecc:	8556                	mv	a0,s5
    80003ece:	fffff097          	auipc	ra,0xfffff
    80003ed2:	7a0080e7          	jalr	1952(ra) # 8000366e <bmap>
    80003ed6:	0005059b          	sext.w	a1,a0
    80003eda:	c99d                	beqz	a1,80003f10 <writei+0xd6>
    80003edc:	000aa503          	lw	a0,0(s5)
    80003ee0:	fffff097          	auipc	ra,0xfffff
    80003ee4:	394080e7          	jalr	916(ra) # 80003274 <bread>
    80003ee8:	84aa                	mv	s1,a0
    80003eea:	3ff97513          	andi	a0,s2,1023
    80003eee:	40ac87bb          	subw	a5,s9,a0
    80003ef2:	413b073b          	subw	a4,s6,s3
    80003ef6:	8d3e                	mv	s10,a5
    80003ef8:	2781                	sext.w	a5,a5
    80003efa:	0007069b          	sext.w	a3,a4
    80003efe:	f8f6f4e3          	bgeu	a3,a5,80003e86 <writei+0x4c>
    80003f02:	8d3a                	mv	s10,a4
    80003f04:	b749                	j	80003e86 <writei+0x4c>
    80003f06:	8526                	mv	a0,s1
    80003f08:	fffff097          	auipc	ra,0xfffff
    80003f0c:	49c080e7          	jalr	1180(ra) # 800033a4 <brelse>
    80003f10:	04caa783          	lw	a5,76(s5)
    80003f14:	0127f463          	bgeu	a5,s2,80003f1c <writei+0xe2>
    80003f18:	052aa623          	sw	s2,76(s5)
    80003f1c:	8556                	mv	a0,s5
    80003f1e:	00000097          	auipc	ra,0x0
    80003f22:	aa6080e7          	jalr	-1370(ra) # 800039c4 <iupdate>
    80003f26:	0009851b          	sext.w	a0,s3
    80003f2a:	70a6                	ld	ra,104(sp)
    80003f2c:	7406                	ld	s0,96(sp)
    80003f2e:	64e6                	ld	s1,88(sp)
    80003f30:	6946                	ld	s2,80(sp)
    80003f32:	69a6                	ld	s3,72(sp)
    80003f34:	6a06                	ld	s4,64(sp)
    80003f36:	7ae2                	ld	s5,56(sp)
    80003f38:	7b42                	ld	s6,48(sp)
    80003f3a:	7ba2                	ld	s7,40(sp)
    80003f3c:	7c02                	ld	s8,32(sp)
    80003f3e:	6ce2                	ld	s9,24(sp)
    80003f40:	6d42                	ld	s10,16(sp)
    80003f42:	6da2                	ld	s11,8(sp)
    80003f44:	6165                	addi	sp,sp,112
    80003f46:	8082                	ret
    80003f48:	89da                	mv	s3,s6
    80003f4a:	bfc9                	j	80003f1c <writei+0xe2>
    80003f4c:	557d                	li	a0,-1
    80003f4e:	8082                	ret
    80003f50:	557d                	li	a0,-1
    80003f52:	bfe1                	j	80003f2a <writei+0xf0>
    80003f54:	557d                	li	a0,-1
    80003f56:	bfd1                	j	80003f2a <writei+0xf0>

0000000080003f58 <namecmp>:
    80003f58:	1141                	addi	sp,sp,-16
    80003f5a:	e406                	sd	ra,8(sp)
    80003f5c:	e022                	sd	s0,0(sp)
    80003f5e:	0800                	addi	s0,sp,16
    80003f60:	4639                	li	a2,14
    80003f62:	ffffd097          	auipc	ra,0xffffd
    80003f66:	e40080e7          	jalr	-448(ra) # 80000da2 <strncmp>
    80003f6a:	60a2                	ld	ra,8(sp)
    80003f6c:	6402                	ld	s0,0(sp)
    80003f6e:	0141                	addi	sp,sp,16
    80003f70:	8082                	ret

0000000080003f72 <dirlookup>:
    80003f72:	7139                	addi	sp,sp,-64
    80003f74:	fc06                	sd	ra,56(sp)
    80003f76:	f822                	sd	s0,48(sp)
    80003f78:	f426                	sd	s1,40(sp)
    80003f7a:	f04a                	sd	s2,32(sp)
    80003f7c:	ec4e                	sd	s3,24(sp)
    80003f7e:	e852                	sd	s4,16(sp)
    80003f80:	0080                	addi	s0,sp,64
    80003f82:	04451703          	lh	a4,68(a0)
    80003f86:	4785                	li	a5,1
    80003f88:	00f71a63          	bne	a4,a5,80003f9c <dirlookup+0x2a>
    80003f8c:	892a                	mv	s2,a0
    80003f8e:	89ae                	mv	s3,a1
    80003f90:	8a32                	mv	s4,a2
    80003f92:	457c                	lw	a5,76(a0)
    80003f94:	4481                	li	s1,0
    80003f96:	4501                	li	a0,0
    80003f98:	e79d                	bnez	a5,80003fc6 <dirlookup+0x54>
    80003f9a:	a8a5                	j	80004012 <dirlookup+0xa0>
    80003f9c:	00004517          	auipc	a0,0x4
    80003fa0:	6a450513          	addi	a0,a0,1700 # 80008640 <syscalls+0x1a8>
    80003fa4:	ffffc097          	auipc	ra,0xffffc
    80003fa8:	59a080e7          	jalr	1434(ra) # 8000053e <panic>
    80003fac:	00004517          	auipc	a0,0x4
    80003fb0:	6ac50513          	addi	a0,a0,1708 # 80008658 <syscalls+0x1c0>
    80003fb4:	ffffc097          	auipc	ra,0xffffc
    80003fb8:	58a080e7          	jalr	1418(ra) # 8000053e <panic>
    80003fbc:	24c1                	addiw	s1,s1,16
    80003fbe:	04c92783          	lw	a5,76(s2)
    80003fc2:	04f4f763          	bgeu	s1,a5,80004010 <dirlookup+0x9e>
    80003fc6:	4741                	li	a4,16
    80003fc8:	86a6                	mv	a3,s1
    80003fca:	fc040613          	addi	a2,s0,-64
    80003fce:	4581                	li	a1,0
    80003fd0:	854a                	mv	a0,s2
    80003fd2:	00000097          	auipc	ra,0x0
    80003fd6:	d70080e7          	jalr	-656(ra) # 80003d42 <readi>
    80003fda:	47c1                	li	a5,16
    80003fdc:	fcf518e3          	bne	a0,a5,80003fac <dirlookup+0x3a>
    80003fe0:	fc045783          	lhu	a5,-64(s0)
    80003fe4:	dfe1                	beqz	a5,80003fbc <dirlookup+0x4a>
    80003fe6:	fc240593          	addi	a1,s0,-62
    80003fea:	854e                	mv	a0,s3
    80003fec:	00000097          	auipc	ra,0x0
    80003ff0:	f6c080e7          	jalr	-148(ra) # 80003f58 <namecmp>
    80003ff4:	f561                	bnez	a0,80003fbc <dirlookup+0x4a>
    80003ff6:	000a0463          	beqz	s4,80003ffe <dirlookup+0x8c>
    80003ffa:	009a2023          	sw	s1,0(s4)
    80003ffe:	fc045583          	lhu	a1,-64(s0)
    80004002:	00092503          	lw	a0,0(s2)
    80004006:	fffff097          	auipc	ra,0xfffff
    8000400a:	750080e7          	jalr	1872(ra) # 80003756 <iget>
    8000400e:	a011                	j	80004012 <dirlookup+0xa0>
    80004010:	4501                	li	a0,0
    80004012:	70e2                	ld	ra,56(sp)
    80004014:	7442                	ld	s0,48(sp)
    80004016:	74a2                	ld	s1,40(sp)
    80004018:	7902                	ld	s2,32(sp)
    8000401a:	69e2                	ld	s3,24(sp)
    8000401c:	6a42                	ld	s4,16(sp)
    8000401e:	6121                	addi	sp,sp,64
    80004020:	8082                	ret

0000000080004022 <namex>:
    80004022:	711d                	addi	sp,sp,-96
    80004024:	ec86                	sd	ra,88(sp)
    80004026:	e8a2                	sd	s0,80(sp)
    80004028:	e4a6                	sd	s1,72(sp)
    8000402a:	e0ca                	sd	s2,64(sp)
    8000402c:	fc4e                	sd	s3,56(sp)
    8000402e:	f852                	sd	s4,48(sp)
    80004030:	f456                	sd	s5,40(sp)
    80004032:	f05a                	sd	s6,32(sp)
    80004034:	ec5e                	sd	s7,24(sp)
    80004036:	e862                	sd	s8,16(sp)
    80004038:	e466                	sd	s9,8(sp)
    8000403a:	1080                	addi	s0,sp,96
    8000403c:	84aa                	mv	s1,a0
    8000403e:	8aae                	mv	s5,a1
    80004040:	8a32                	mv	s4,a2
    80004042:	00054703          	lbu	a4,0(a0)
    80004046:	02f00793          	li	a5,47
    8000404a:	02f70363          	beq	a4,a5,80004070 <namex+0x4e>
    8000404e:	ffffe097          	auipc	ra,0xffffe
    80004052:	95e080e7          	jalr	-1698(ra) # 800019ac <myproc>
    80004056:	15053503          	ld	a0,336(a0)
    8000405a:	00000097          	auipc	ra,0x0
    8000405e:	9f6080e7          	jalr	-1546(ra) # 80003a50 <idup>
    80004062:	89aa                	mv	s3,a0
    80004064:	02f00913          	li	s2,47
    80004068:	4b01                	li	s6,0
    8000406a:	4c35                	li	s8,13
    8000406c:	4b85                	li	s7,1
    8000406e:	a865                	j	80004126 <namex+0x104>
    80004070:	4585                	li	a1,1
    80004072:	4505                	li	a0,1
    80004074:	fffff097          	auipc	ra,0xfffff
    80004078:	6e2080e7          	jalr	1762(ra) # 80003756 <iget>
    8000407c:	89aa                	mv	s3,a0
    8000407e:	b7dd                	j	80004064 <namex+0x42>
    80004080:	854e                	mv	a0,s3
    80004082:	00000097          	auipc	ra,0x0
    80004086:	c6e080e7          	jalr	-914(ra) # 80003cf0 <iunlockput>
    8000408a:	4981                	li	s3,0
    8000408c:	854e                	mv	a0,s3
    8000408e:	60e6                	ld	ra,88(sp)
    80004090:	6446                	ld	s0,80(sp)
    80004092:	64a6                	ld	s1,72(sp)
    80004094:	6906                	ld	s2,64(sp)
    80004096:	79e2                	ld	s3,56(sp)
    80004098:	7a42                	ld	s4,48(sp)
    8000409a:	7aa2                	ld	s5,40(sp)
    8000409c:	7b02                	ld	s6,32(sp)
    8000409e:	6be2                	ld	s7,24(sp)
    800040a0:	6c42                	ld	s8,16(sp)
    800040a2:	6ca2                	ld	s9,8(sp)
    800040a4:	6125                	addi	sp,sp,96
    800040a6:	8082                	ret
    800040a8:	854e                	mv	a0,s3
    800040aa:	00000097          	auipc	ra,0x0
    800040ae:	aa6080e7          	jalr	-1370(ra) # 80003b50 <iunlock>
    800040b2:	bfe9                	j	8000408c <namex+0x6a>
    800040b4:	854e                	mv	a0,s3
    800040b6:	00000097          	auipc	ra,0x0
    800040ba:	c3a080e7          	jalr	-966(ra) # 80003cf0 <iunlockput>
    800040be:	89e6                	mv	s3,s9
    800040c0:	b7f1                	j	8000408c <namex+0x6a>
    800040c2:	40b48633          	sub	a2,s1,a1
    800040c6:	00060c9b          	sext.w	s9,a2
    800040ca:	099c5463          	bge	s8,s9,80004152 <namex+0x130>
    800040ce:	4639                	li	a2,14
    800040d0:	8552                	mv	a0,s4
    800040d2:	ffffd097          	auipc	ra,0xffffd
    800040d6:	c5c080e7          	jalr	-932(ra) # 80000d2e <memmove>
    800040da:	0004c783          	lbu	a5,0(s1)
    800040de:	01279763          	bne	a5,s2,800040ec <namex+0xca>
    800040e2:	0485                	addi	s1,s1,1
    800040e4:	0004c783          	lbu	a5,0(s1)
    800040e8:	ff278de3          	beq	a5,s2,800040e2 <namex+0xc0>
    800040ec:	854e                	mv	a0,s3
    800040ee:	00000097          	auipc	ra,0x0
    800040f2:	9a0080e7          	jalr	-1632(ra) # 80003a8e <ilock>
    800040f6:	04499783          	lh	a5,68(s3)
    800040fa:	f97793e3          	bne	a5,s7,80004080 <namex+0x5e>
    800040fe:	000a8563          	beqz	s5,80004108 <namex+0xe6>
    80004102:	0004c783          	lbu	a5,0(s1)
    80004106:	d3cd                	beqz	a5,800040a8 <namex+0x86>
    80004108:	865a                	mv	a2,s6
    8000410a:	85d2                	mv	a1,s4
    8000410c:	854e                	mv	a0,s3
    8000410e:	00000097          	auipc	ra,0x0
    80004112:	e64080e7          	jalr	-412(ra) # 80003f72 <dirlookup>
    80004116:	8caa                	mv	s9,a0
    80004118:	dd51                	beqz	a0,800040b4 <namex+0x92>
    8000411a:	854e                	mv	a0,s3
    8000411c:	00000097          	auipc	ra,0x0
    80004120:	bd4080e7          	jalr	-1068(ra) # 80003cf0 <iunlockput>
    80004124:	89e6                	mv	s3,s9
    80004126:	0004c783          	lbu	a5,0(s1)
    8000412a:	05279763          	bne	a5,s2,80004178 <namex+0x156>
    8000412e:	0485                	addi	s1,s1,1
    80004130:	0004c783          	lbu	a5,0(s1)
    80004134:	ff278de3          	beq	a5,s2,8000412e <namex+0x10c>
    80004138:	c79d                	beqz	a5,80004166 <namex+0x144>
    8000413a:	85a6                	mv	a1,s1
    8000413c:	8cda                	mv	s9,s6
    8000413e:	865a                	mv	a2,s6
    80004140:	01278963          	beq	a5,s2,80004152 <namex+0x130>
    80004144:	dfbd                	beqz	a5,800040c2 <namex+0xa0>
    80004146:	0485                	addi	s1,s1,1
    80004148:	0004c783          	lbu	a5,0(s1)
    8000414c:	ff279ce3          	bne	a5,s2,80004144 <namex+0x122>
    80004150:	bf8d                	j	800040c2 <namex+0xa0>
    80004152:	2601                	sext.w	a2,a2
    80004154:	8552                	mv	a0,s4
    80004156:	ffffd097          	auipc	ra,0xffffd
    8000415a:	bd8080e7          	jalr	-1064(ra) # 80000d2e <memmove>
    8000415e:	9cd2                	add	s9,s9,s4
    80004160:	000c8023          	sb	zero,0(s9) # 2000 <_entry-0x7fffe000>
    80004164:	bf9d                	j	800040da <namex+0xb8>
    80004166:	f20a83e3          	beqz	s5,8000408c <namex+0x6a>
    8000416a:	854e                	mv	a0,s3
    8000416c:	00000097          	auipc	ra,0x0
    80004170:	adc080e7          	jalr	-1316(ra) # 80003c48 <iput>
    80004174:	4981                	li	s3,0
    80004176:	bf19                	j	8000408c <namex+0x6a>
    80004178:	d7fd                	beqz	a5,80004166 <namex+0x144>
    8000417a:	0004c783          	lbu	a5,0(s1)
    8000417e:	85a6                	mv	a1,s1
    80004180:	b7d1                	j	80004144 <namex+0x122>

0000000080004182 <dirlink>:
    80004182:	7139                	addi	sp,sp,-64
    80004184:	fc06                	sd	ra,56(sp)
    80004186:	f822                	sd	s0,48(sp)
    80004188:	f426                	sd	s1,40(sp)
    8000418a:	f04a                	sd	s2,32(sp)
    8000418c:	ec4e                	sd	s3,24(sp)
    8000418e:	e852                	sd	s4,16(sp)
    80004190:	0080                	addi	s0,sp,64
    80004192:	892a                	mv	s2,a0
    80004194:	8a2e                	mv	s4,a1
    80004196:	89b2                	mv	s3,a2
    80004198:	4601                	li	a2,0
    8000419a:	00000097          	auipc	ra,0x0
    8000419e:	dd8080e7          	jalr	-552(ra) # 80003f72 <dirlookup>
    800041a2:	e93d                	bnez	a0,80004218 <dirlink+0x96>
    800041a4:	04c92483          	lw	s1,76(s2)
    800041a8:	c49d                	beqz	s1,800041d6 <dirlink+0x54>
    800041aa:	4481                	li	s1,0
    800041ac:	4741                	li	a4,16
    800041ae:	86a6                	mv	a3,s1
    800041b0:	fc040613          	addi	a2,s0,-64
    800041b4:	4581                	li	a1,0
    800041b6:	854a                	mv	a0,s2
    800041b8:	00000097          	auipc	ra,0x0
    800041bc:	b8a080e7          	jalr	-1142(ra) # 80003d42 <readi>
    800041c0:	47c1                	li	a5,16
    800041c2:	06f51163          	bne	a0,a5,80004224 <dirlink+0xa2>
    800041c6:	fc045783          	lhu	a5,-64(s0)
    800041ca:	c791                	beqz	a5,800041d6 <dirlink+0x54>
    800041cc:	24c1                	addiw	s1,s1,16
    800041ce:	04c92783          	lw	a5,76(s2)
    800041d2:	fcf4ede3          	bltu	s1,a5,800041ac <dirlink+0x2a>
    800041d6:	4639                	li	a2,14
    800041d8:	85d2                	mv	a1,s4
    800041da:	fc240513          	addi	a0,s0,-62
    800041de:	ffffd097          	auipc	ra,0xffffd
    800041e2:	c00080e7          	jalr	-1024(ra) # 80000dde <strncpy>
    800041e6:	fd341023          	sh	s3,-64(s0)
    800041ea:	4741                	li	a4,16
    800041ec:	86a6                	mv	a3,s1
    800041ee:	fc040613          	addi	a2,s0,-64
    800041f2:	4581                	li	a1,0
    800041f4:	854a                	mv	a0,s2
    800041f6:	00000097          	auipc	ra,0x0
    800041fa:	c44080e7          	jalr	-956(ra) # 80003e3a <writei>
    800041fe:	1541                	addi	a0,a0,-16
    80004200:	00a03533          	snez	a0,a0
    80004204:	40a00533          	neg	a0,a0
    80004208:	70e2                	ld	ra,56(sp)
    8000420a:	7442                	ld	s0,48(sp)
    8000420c:	74a2                	ld	s1,40(sp)
    8000420e:	7902                	ld	s2,32(sp)
    80004210:	69e2                	ld	s3,24(sp)
    80004212:	6a42                	ld	s4,16(sp)
    80004214:	6121                	addi	sp,sp,64
    80004216:	8082                	ret
    80004218:	00000097          	auipc	ra,0x0
    8000421c:	a30080e7          	jalr	-1488(ra) # 80003c48 <iput>
    80004220:	557d                	li	a0,-1
    80004222:	b7dd                	j	80004208 <dirlink+0x86>
    80004224:	00004517          	auipc	a0,0x4
    80004228:	44450513          	addi	a0,a0,1092 # 80008668 <syscalls+0x1d0>
    8000422c:	ffffc097          	auipc	ra,0xffffc
    80004230:	312080e7          	jalr	786(ra) # 8000053e <panic>

0000000080004234 <namei>:
    80004234:	1101                	addi	sp,sp,-32
    80004236:	ec06                	sd	ra,24(sp)
    80004238:	e822                	sd	s0,16(sp)
    8000423a:	1000                	addi	s0,sp,32
    8000423c:	fe040613          	addi	a2,s0,-32
    80004240:	4581                	li	a1,0
    80004242:	00000097          	auipc	ra,0x0
    80004246:	de0080e7          	jalr	-544(ra) # 80004022 <namex>
    8000424a:	60e2                	ld	ra,24(sp)
    8000424c:	6442                	ld	s0,16(sp)
    8000424e:	6105                	addi	sp,sp,32
    80004250:	8082                	ret

0000000080004252 <nameiparent>:
    80004252:	1141                	addi	sp,sp,-16
    80004254:	e406                	sd	ra,8(sp)
    80004256:	e022                	sd	s0,0(sp)
    80004258:	0800                	addi	s0,sp,16
    8000425a:	862e                	mv	a2,a1
    8000425c:	4585                	li	a1,1
    8000425e:	00000097          	auipc	ra,0x0
    80004262:	dc4080e7          	jalr	-572(ra) # 80004022 <namex>
    80004266:	60a2                	ld	ra,8(sp)
    80004268:	6402                	ld	s0,0(sp)
    8000426a:	0141                	addi	sp,sp,16
    8000426c:	8082                	ret

000000008000426e <write_head>:
    8000426e:	1101                	addi	sp,sp,-32
    80004270:	ec06                	sd	ra,24(sp)
    80004272:	e822                	sd	s0,16(sp)
    80004274:	e426                	sd	s1,8(sp)
    80004276:	e04a                	sd	s2,0(sp)
    80004278:	1000                	addi	s0,sp,32
    8000427a:	0001d917          	auipc	s2,0x1d
    8000427e:	8d690913          	addi	s2,s2,-1834 # 80020b50 <log>
    80004282:	01892583          	lw	a1,24(s2)
    80004286:	02892503          	lw	a0,40(s2)
    8000428a:	fffff097          	auipc	ra,0xfffff
    8000428e:	fea080e7          	jalr	-22(ra) # 80003274 <bread>
    80004292:	84aa                	mv	s1,a0
    80004294:	02c92683          	lw	a3,44(s2)
    80004298:	cd34                	sw	a3,88(a0)
    8000429a:	02d05763          	blez	a3,800042c8 <write_head+0x5a>
    8000429e:	0001d797          	auipc	a5,0x1d
    800042a2:	8e278793          	addi	a5,a5,-1822 # 80020b80 <log+0x30>
    800042a6:	05c50713          	addi	a4,a0,92
    800042aa:	36fd                	addiw	a3,a3,-1
    800042ac:	1682                	slli	a3,a3,0x20
    800042ae:	9281                	srli	a3,a3,0x20
    800042b0:	068a                	slli	a3,a3,0x2
    800042b2:	0001d617          	auipc	a2,0x1d
    800042b6:	8d260613          	addi	a2,a2,-1838 # 80020b84 <log+0x34>
    800042ba:	96b2                	add	a3,a3,a2
    800042bc:	4390                	lw	a2,0(a5)
    800042be:	c310                	sw	a2,0(a4)
    800042c0:	0791                	addi	a5,a5,4
    800042c2:	0711                	addi	a4,a4,4
    800042c4:	fed79ce3          	bne	a5,a3,800042bc <write_head+0x4e>
    800042c8:	8526                	mv	a0,s1
    800042ca:	fffff097          	auipc	ra,0xfffff
    800042ce:	09c080e7          	jalr	156(ra) # 80003366 <bwrite>
    800042d2:	8526                	mv	a0,s1
    800042d4:	fffff097          	auipc	ra,0xfffff
    800042d8:	0d0080e7          	jalr	208(ra) # 800033a4 <brelse>
    800042dc:	60e2                	ld	ra,24(sp)
    800042de:	6442                	ld	s0,16(sp)
    800042e0:	64a2                	ld	s1,8(sp)
    800042e2:	6902                	ld	s2,0(sp)
    800042e4:	6105                	addi	sp,sp,32
    800042e6:	8082                	ret

00000000800042e8 <install_trans>:
    800042e8:	0001d797          	auipc	a5,0x1d
    800042ec:	8947a783          	lw	a5,-1900(a5) # 80020b7c <log+0x2c>
    800042f0:	0af05d63          	blez	a5,800043aa <install_trans+0xc2>
    800042f4:	7139                	addi	sp,sp,-64
    800042f6:	fc06                	sd	ra,56(sp)
    800042f8:	f822                	sd	s0,48(sp)
    800042fa:	f426                	sd	s1,40(sp)
    800042fc:	f04a                	sd	s2,32(sp)
    800042fe:	ec4e                	sd	s3,24(sp)
    80004300:	e852                	sd	s4,16(sp)
    80004302:	e456                	sd	s5,8(sp)
    80004304:	e05a                	sd	s6,0(sp)
    80004306:	0080                	addi	s0,sp,64
    80004308:	8b2a                	mv	s6,a0
    8000430a:	0001da97          	auipc	s5,0x1d
    8000430e:	876a8a93          	addi	s5,s5,-1930 # 80020b80 <log+0x30>
    80004312:	4a01                	li	s4,0
    80004314:	0001d997          	auipc	s3,0x1d
    80004318:	83c98993          	addi	s3,s3,-1988 # 80020b50 <log>
    8000431c:	a00d                	j	8000433e <install_trans+0x56>
    8000431e:	854a                	mv	a0,s2
    80004320:	fffff097          	auipc	ra,0xfffff
    80004324:	084080e7          	jalr	132(ra) # 800033a4 <brelse>
    80004328:	8526                	mv	a0,s1
    8000432a:	fffff097          	auipc	ra,0xfffff
    8000432e:	07a080e7          	jalr	122(ra) # 800033a4 <brelse>
    80004332:	2a05                	addiw	s4,s4,1
    80004334:	0a91                	addi	s5,s5,4
    80004336:	02c9a783          	lw	a5,44(s3)
    8000433a:	04fa5e63          	bge	s4,a5,80004396 <install_trans+0xae>
    8000433e:	0189a583          	lw	a1,24(s3)
    80004342:	014585bb          	addw	a1,a1,s4
    80004346:	2585                	addiw	a1,a1,1
    80004348:	0289a503          	lw	a0,40(s3)
    8000434c:	fffff097          	auipc	ra,0xfffff
    80004350:	f28080e7          	jalr	-216(ra) # 80003274 <bread>
    80004354:	892a                	mv	s2,a0
    80004356:	000aa583          	lw	a1,0(s5)
    8000435a:	0289a503          	lw	a0,40(s3)
    8000435e:	fffff097          	auipc	ra,0xfffff
    80004362:	f16080e7          	jalr	-234(ra) # 80003274 <bread>
    80004366:	84aa                	mv	s1,a0
    80004368:	40000613          	li	a2,1024
    8000436c:	05890593          	addi	a1,s2,88
    80004370:	05850513          	addi	a0,a0,88
    80004374:	ffffd097          	auipc	ra,0xffffd
    80004378:	9ba080e7          	jalr	-1606(ra) # 80000d2e <memmove>
    8000437c:	8526                	mv	a0,s1
    8000437e:	fffff097          	auipc	ra,0xfffff
    80004382:	fe8080e7          	jalr	-24(ra) # 80003366 <bwrite>
    80004386:	f80b1ce3          	bnez	s6,8000431e <install_trans+0x36>
    8000438a:	8526                	mv	a0,s1
    8000438c:	fffff097          	auipc	ra,0xfffff
    80004390:	0f2080e7          	jalr	242(ra) # 8000347e <bunpin>
    80004394:	b769                	j	8000431e <install_trans+0x36>
    80004396:	70e2                	ld	ra,56(sp)
    80004398:	7442                	ld	s0,48(sp)
    8000439a:	74a2                	ld	s1,40(sp)
    8000439c:	7902                	ld	s2,32(sp)
    8000439e:	69e2                	ld	s3,24(sp)
    800043a0:	6a42                	ld	s4,16(sp)
    800043a2:	6aa2                	ld	s5,8(sp)
    800043a4:	6b02                	ld	s6,0(sp)
    800043a6:	6121                	addi	sp,sp,64
    800043a8:	8082                	ret
    800043aa:	8082                	ret

00000000800043ac <initlog>:
    800043ac:	7179                	addi	sp,sp,-48
    800043ae:	f406                	sd	ra,40(sp)
    800043b0:	f022                	sd	s0,32(sp)
    800043b2:	ec26                	sd	s1,24(sp)
    800043b4:	e84a                	sd	s2,16(sp)
    800043b6:	e44e                	sd	s3,8(sp)
    800043b8:	1800                	addi	s0,sp,48
    800043ba:	892a                	mv	s2,a0
    800043bc:	89ae                	mv	s3,a1
    800043be:	0001c497          	auipc	s1,0x1c
    800043c2:	79248493          	addi	s1,s1,1938 # 80020b50 <log>
    800043c6:	00004597          	auipc	a1,0x4
    800043ca:	2b258593          	addi	a1,a1,690 # 80008678 <syscalls+0x1e0>
    800043ce:	8526                	mv	a0,s1
    800043d0:	ffffc097          	auipc	ra,0xffffc
    800043d4:	776080e7          	jalr	1910(ra) # 80000b46 <initlock>
    800043d8:	0149a583          	lw	a1,20(s3)
    800043dc:	cc8c                	sw	a1,24(s1)
    800043de:	0109a783          	lw	a5,16(s3)
    800043e2:	ccdc                	sw	a5,28(s1)
    800043e4:	0324a423          	sw	s2,40(s1)
    800043e8:	854a                	mv	a0,s2
    800043ea:	fffff097          	auipc	ra,0xfffff
    800043ee:	e8a080e7          	jalr	-374(ra) # 80003274 <bread>
    800043f2:	4d34                	lw	a3,88(a0)
    800043f4:	d4d4                	sw	a3,44(s1)
    800043f6:	02d05563          	blez	a3,80004420 <initlog+0x74>
    800043fa:	05c50793          	addi	a5,a0,92
    800043fe:	0001c717          	auipc	a4,0x1c
    80004402:	78270713          	addi	a4,a4,1922 # 80020b80 <log+0x30>
    80004406:	36fd                	addiw	a3,a3,-1
    80004408:	1682                	slli	a3,a3,0x20
    8000440a:	9281                	srli	a3,a3,0x20
    8000440c:	068a                	slli	a3,a3,0x2
    8000440e:	06050613          	addi	a2,a0,96
    80004412:	96b2                	add	a3,a3,a2
    80004414:	4390                	lw	a2,0(a5)
    80004416:	c310                	sw	a2,0(a4)
    80004418:	0791                	addi	a5,a5,4
    8000441a:	0711                	addi	a4,a4,4
    8000441c:	fed79ce3          	bne	a5,a3,80004414 <initlog+0x68>
    80004420:	fffff097          	auipc	ra,0xfffff
    80004424:	f84080e7          	jalr	-124(ra) # 800033a4 <brelse>
    80004428:	4505                	li	a0,1
    8000442a:	00000097          	auipc	ra,0x0
    8000442e:	ebe080e7          	jalr	-322(ra) # 800042e8 <install_trans>
    80004432:	0001c797          	auipc	a5,0x1c
    80004436:	7407a523          	sw	zero,1866(a5) # 80020b7c <log+0x2c>
    8000443a:	00000097          	auipc	ra,0x0
    8000443e:	e34080e7          	jalr	-460(ra) # 8000426e <write_head>
    80004442:	70a2                	ld	ra,40(sp)
    80004444:	7402                	ld	s0,32(sp)
    80004446:	64e2                	ld	s1,24(sp)
    80004448:	6942                	ld	s2,16(sp)
    8000444a:	69a2                	ld	s3,8(sp)
    8000444c:	6145                	addi	sp,sp,48
    8000444e:	8082                	ret

0000000080004450 <begin_op>:
    80004450:	1101                	addi	sp,sp,-32
    80004452:	ec06                	sd	ra,24(sp)
    80004454:	e822                	sd	s0,16(sp)
    80004456:	e426                	sd	s1,8(sp)
    80004458:	e04a                	sd	s2,0(sp)
    8000445a:	1000                	addi	s0,sp,32
    8000445c:	0001c517          	auipc	a0,0x1c
    80004460:	6f450513          	addi	a0,a0,1780 # 80020b50 <log>
    80004464:	ffffc097          	auipc	ra,0xffffc
    80004468:	772080e7          	jalr	1906(ra) # 80000bd6 <acquire>
    8000446c:	0001c497          	auipc	s1,0x1c
    80004470:	6e448493          	addi	s1,s1,1764 # 80020b50 <log>
    80004474:	4979                	li	s2,30
    80004476:	a039                	j	80004484 <begin_op+0x34>
    80004478:	85a6                	mv	a1,s1
    8000447a:	8526                	mv	a0,s1
    8000447c:	ffffe097          	auipc	ra,0xffffe
    80004480:	bd8080e7          	jalr	-1064(ra) # 80002054 <sleep>
    80004484:	50dc                	lw	a5,36(s1)
    80004486:	fbed                	bnez	a5,80004478 <begin_op+0x28>
    80004488:	509c                	lw	a5,32(s1)
    8000448a:	0017871b          	addiw	a4,a5,1
    8000448e:	0007069b          	sext.w	a3,a4
    80004492:	0027179b          	slliw	a5,a4,0x2
    80004496:	9fb9                	addw	a5,a5,a4
    80004498:	0017979b          	slliw	a5,a5,0x1
    8000449c:	54d8                	lw	a4,44(s1)
    8000449e:	9fb9                	addw	a5,a5,a4
    800044a0:	00f95963          	bge	s2,a5,800044b2 <begin_op+0x62>
    800044a4:	85a6                	mv	a1,s1
    800044a6:	8526                	mv	a0,s1
    800044a8:	ffffe097          	auipc	ra,0xffffe
    800044ac:	bac080e7          	jalr	-1108(ra) # 80002054 <sleep>
    800044b0:	bfd1                	j	80004484 <begin_op+0x34>
    800044b2:	0001c517          	auipc	a0,0x1c
    800044b6:	69e50513          	addi	a0,a0,1694 # 80020b50 <log>
    800044ba:	d114                	sw	a3,32(a0)
    800044bc:	ffffc097          	auipc	ra,0xffffc
    800044c0:	7ce080e7          	jalr	1998(ra) # 80000c8a <release>
    800044c4:	60e2                	ld	ra,24(sp)
    800044c6:	6442                	ld	s0,16(sp)
    800044c8:	64a2                	ld	s1,8(sp)
    800044ca:	6902                	ld	s2,0(sp)
    800044cc:	6105                	addi	sp,sp,32
    800044ce:	8082                	ret

00000000800044d0 <end_op>:
    800044d0:	7139                	addi	sp,sp,-64
    800044d2:	fc06                	sd	ra,56(sp)
    800044d4:	f822                	sd	s0,48(sp)
    800044d6:	f426                	sd	s1,40(sp)
    800044d8:	f04a                	sd	s2,32(sp)
    800044da:	ec4e                	sd	s3,24(sp)
    800044dc:	e852                	sd	s4,16(sp)
    800044de:	e456                	sd	s5,8(sp)
    800044e0:	0080                	addi	s0,sp,64
    800044e2:	0001c497          	auipc	s1,0x1c
    800044e6:	66e48493          	addi	s1,s1,1646 # 80020b50 <log>
    800044ea:	8526                	mv	a0,s1
    800044ec:	ffffc097          	auipc	ra,0xffffc
    800044f0:	6ea080e7          	jalr	1770(ra) # 80000bd6 <acquire>
    800044f4:	509c                	lw	a5,32(s1)
    800044f6:	37fd                	addiw	a5,a5,-1
    800044f8:	0007891b          	sext.w	s2,a5
    800044fc:	d09c                	sw	a5,32(s1)
    800044fe:	50dc                	lw	a5,36(s1)
    80004500:	e7b9                	bnez	a5,8000454e <end_op+0x7e>
    80004502:	04091e63          	bnez	s2,8000455e <end_op+0x8e>
    80004506:	0001c497          	auipc	s1,0x1c
    8000450a:	64a48493          	addi	s1,s1,1610 # 80020b50 <log>
    8000450e:	4785                	li	a5,1
    80004510:	d0dc                	sw	a5,36(s1)
    80004512:	8526                	mv	a0,s1
    80004514:	ffffc097          	auipc	ra,0xffffc
    80004518:	776080e7          	jalr	1910(ra) # 80000c8a <release>
    8000451c:	54dc                	lw	a5,44(s1)
    8000451e:	06f04763          	bgtz	a5,8000458c <end_op+0xbc>
    80004522:	0001c497          	auipc	s1,0x1c
    80004526:	62e48493          	addi	s1,s1,1582 # 80020b50 <log>
    8000452a:	8526                	mv	a0,s1
    8000452c:	ffffc097          	auipc	ra,0xffffc
    80004530:	6aa080e7          	jalr	1706(ra) # 80000bd6 <acquire>
    80004534:	0204a223          	sw	zero,36(s1)
    80004538:	8526                	mv	a0,s1
    8000453a:	ffffe097          	auipc	ra,0xffffe
    8000453e:	b7e080e7          	jalr	-1154(ra) # 800020b8 <wakeup>
    80004542:	8526                	mv	a0,s1
    80004544:	ffffc097          	auipc	ra,0xffffc
    80004548:	746080e7          	jalr	1862(ra) # 80000c8a <release>
    8000454c:	a03d                	j	8000457a <end_op+0xaa>
    8000454e:	00004517          	auipc	a0,0x4
    80004552:	13250513          	addi	a0,a0,306 # 80008680 <syscalls+0x1e8>
    80004556:	ffffc097          	auipc	ra,0xffffc
    8000455a:	fe8080e7          	jalr	-24(ra) # 8000053e <panic>
    8000455e:	0001c497          	auipc	s1,0x1c
    80004562:	5f248493          	addi	s1,s1,1522 # 80020b50 <log>
    80004566:	8526                	mv	a0,s1
    80004568:	ffffe097          	auipc	ra,0xffffe
    8000456c:	b50080e7          	jalr	-1200(ra) # 800020b8 <wakeup>
    80004570:	8526                	mv	a0,s1
    80004572:	ffffc097          	auipc	ra,0xffffc
    80004576:	718080e7          	jalr	1816(ra) # 80000c8a <release>
    8000457a:	70e2                	ld	ra,56(sp)
    8000457c:	7442                	ld	s0,48(sp)
    8000457e:	74a2                	ld	s1,40(sp)
    80004580:	7902                	ld	s2,32(sp)
    80004582:	69e2                	ld	s3,24(sp)
    80004584:	6a42                	ld	s4,16(sp)
    80004586:	6aa2                	ld	s5,8(sp)
    80004588:	6121                	addi	sp,sp,64
    8000458a:	8082                	ret
    8000458c:	0001ca97          	auipc	s5,0x1c
    80004590:	5f4a8a93          	addi	s5,s5,1524 # 80020b80 <log+0x30>
    80004594:	0001ca17          	auipc	s4,0x1c
    80004598:	5bca0a13          	addi	s4,s4,1468 # 80020b50 <log>
    8000459c:	018a2583          	lw	a1,24(s4)
    800045a0:	012585bb          	addw	a1,a1,s2
    800045a4:	2585                	addiw	a1,a1,1
    800045a6:	028a2503          	lw	a0,40(s4)
    800045aa:	fffff097          	auipc	ra,0xfffff
    800045ae:	cca080e7          	jalr	-822(ra) # 80003274 <bread>
    800045b2:	84aa                	mv	s1,a0
    800045b4:	000aa583          	lw	a1,0(s5)
    800045b8:	028a2503          	lw	a0,40(s4)
    800045bc:	fffff097          	auipc	ra,0xfffff
    800045c0:	cb8080e7          	jalr	-840(ra) # 80003274 <bread>
    800045c4:	89aa                	mv	s3,a0
    800045c6:	40000613          	li	a2,1024
    800045ca:	05850593          	addi	a1,a0,88
    800045ce:	05848513          	addi	a0,s1,88
    800045d2:	ffffc097          	auipc	ra,0xffffc
    800045d6:	75c080e7          	jalr	1884(ra) # 80000d2e <memmove>
    800045da:	8526                	mv	a0,s1
    800045dc:	fffff097          	auipc	ra,0xfffff
    800045e0:	d8a080e7          	jalr	-630(ra) # 80003366 <bwrite>
    800045e4:	854e                	mv	a0,s3
    800045e6:	fffff097          	auipc	ra,0xfffff
    800045ea:	dbe080e7          	jalr	-578(ra) # 800033a4 <brelse>
    800045ee:	8526                	mv	a0,s1
    800045f0:	fffff097          	auipc	ra,0xfffff
    800045f4:	db4080e7          	jalr	-588(ra) # 800033a4 <brelse>
    800045f8:	2905                	addiw	s2,s2,1
    800045fa:	0a91                	addi	s5,s5,4
    800045fc:	02ca2783          	lw	a5,44(s4)
    80004600:	f8f94ee3          	blt	s2,a5,8000459c <end_op+0xcc>
    80004604:	00000097          	auipc	ra,0x0
    80004608:	c6a080e7          	jalr	-918(ra) # 8000426e <write_head>
    8000460c:	4501                	li	a0,0
    8000460e:	00000097          	auipc	ra,0x0
    80004612:	cda080e7          	jalr	-806(ra) # 800042e8 <install_trans>
    80004616:	0001c797          	auipc	a5,0x1c
    8000461a:	5607a323          	sw	zero,1382(a5) # 80020b7c <log+0x2c>
    8000461e:	00000097          	auipc	ra,0x0
    80004622:	c50080e7          	jalr	-944(ra) # 8000426e <write_head>
    80004626:	bdf5                	j	80004522 <end_op+0x52>

0000000080004628 <log_write>:
    80004628:	1101                	addi	sp,sp,-32
    8000462a:	ec06                	sd	ra,24(sp)
    8000462c:	e822                	sd	s0,16(sp)
    8000462e:	e426                	sd	s1,8(sp)
    80004630:	e04a                	sd	s2,0(sp)
    80004632:	1000                	addi	s0,sp,32
    80004634:	84aa                	mv	s1,a0
    80004636:	0001c917          	auipc	s2,0x1c
    8000463a:	51a90913          	addi	s2,s2,1306 # 80020b50 <log>
    8000463e:	854a                	mv	a0,s2
    80004640:	ffffc097          	auipc	ra,0xffffc
    80004644:	596080e7          	jalr	1430(ra) # 80000bd6 <acquire>
    80004648:	02c92603          	lw	a2,44(s2)
    8000464c:	47f5                	li	a5,29
    8000464e:	06c7c563          	blt	a5,a2,800046b8 <log_write+0x90>
    80004652:	0001c797          	auipc	a5,0x1c
    80004656:	51a7a783          	lw	a5,1306(a5) # 80020b6c <log+0x1c>
    8000465a:	37fd                	addiw	a5,a5,-1
    8000465c:	04f65e63          	bge	a2,a5,800046b8 <log_write+0x90>
    80004660:	0001c797          	auipc	a5,0x1c
    80004664:	5107a783          	lw	a5,1296(a5) # 80020b70 <log+0x20>
    80004668:	06f05063          	blez	a5,800046c8 <log_write+0xa0>
    8000466c:	4781                	li	a5,0
    8000466e:	06c05563          	blez	a2,800046d8 <log_write+0xb0>
    80004672:	44cc                	lw	a1,12(s1)
    80004674:	0001c717          	auipc	a4,0x1c
    80004678:	50c70713          	addi	a4,a4,1292 # 80020b80 <log+0x30>
    8000467c:	4781                	li	a5,0
    8000467e:	4314                	lw	a3,0(a4)
    80004680:	04b68c63          	beq	a3,a1,800046d8 <log_write+0xb0>
    80004684:	2785                	addiw	a5,a5,1
    80004686:	0711                	addi	a4,a4,4
    80004688:	fef61be3          	bne	a2,a5,8000467e <log_write+0x56>
    8000468c:	0621                	addi	a2,a2,8
    8000468e:	060a                	slli	a2,a2,0x2
    80004690:	0001c797          	auipc	a5,0x1c
    80004694:	4c078793          	addi	a5,a5,1216 # 80020b50 <log>
    80004698:	963e                	add	a2,a2,a5
    8000469a:	44dc                	lw	a5,12(s1)
    8000469c:	ca1c                	sw	a5,16(a2)
    8000469e:	8526                	mv	a0,s1
    800046a0:	fffff097          	auipc	ra,0xfffff
    800046a4:	da2080e7          	jalr	-606(ra) # 80003442 <bpin>
    800046a8:	0001c717          	auipc	a4,0x1c
    800046ac:	4a870713          	addi	a4,a4,1192 # 80020b50 <log>
    800046b0:	575c                	lw	a5,44(a4)
    800046b2:	2785                	addiw	a5,a5,1
    800046b4:	d75c                	sw	a5,44(a4)
    800046b6:	a835                	j	800046f2 <log_write+0xca>
    800046b8:	00004517          	auipc	a0,0x4
    800046bc:	fd850513          	addi	a0,a0,-40 # 80008690 <syscalls+0x1f8>
    800046c0:	ffffc097          	auipc	ra,0xffffc
    800046c4:	e7e080e7          	jalr	-386(ra) # 8000053e <panic>
    800046c8:	00004517          	auipc	a0,0x4
    800046cc:	fe050513          	addi	a0,a0,-32 # 800086a8 <syscalls+0x210>
    800046d0:	ffffc097          	auipc	ra,0xffffc
    800046d4:	e6e080e7          	jalr	-402(ra) # 8000053e <panic>
    800046d8:	00878713          	addi	a4,a5,8
    800046dc:	00271693          	slli	a3,a4,0x2
    800046e0:	0001c717          	auipc	a4,0x1c
    800046e4:	47070713          	addi	a4,a4,1136 # 80020b50 <log>
    800046e8:	9736                	add	a4,a4,a3
    800046ea:	44d4                	lw	a3,12(s1)
    800046ec:	cb14                	sw	a3,16(a4)
    800046ee:	faf608e3          	beq	a2,a5,8000469e <log_write+0x76>
    800046f2:	0001c517          	auipc	a0,0x1c
    800046f6:	45e50513          	addi	a0,a0,1118 # 80020b50 <log>
    800046fa:	ffffc097          	auipc	ra,0xffffc
    800046fe:	590080e7          	jalr	1424(ra) # 80000c8a <release>
    80004702:	60e2                	ld	ra,24(sp)
    80004704:	6442                	ld	s0,16(sp)
    80004706:	64a2                	ld	s1,8(sp)
    80004708:	6902                	ld	s2,0(sp)
    8000470a:	6105                	addi	sp,sp,32
    8000470c:	8082                	ret

000000008000470e <initsleeplock>:
    8000470e:	1101                	addi	sp,sp,-32
    80004710:	ec06                	sd	ra,24(sp)
    80004712:	e822                	sd	s0,16(sp)
    80004714:	e426                	sd	s1,8(sp)
    80004716:	e04a                	sd	s2,0(sp)
    80004718:	1000                	addi	s0,sp,32
    8000471a:	84aa                	mv	s1,a0
    8000471c:	892e                	mv	s2,a1
    8000471e:	00004597          	auipc	a1,0x4
    80004722:	faa58593          	addi	a1,a1,-86 # 800086c8 <syscalls+0x230>
    80004726:	0521                	addi	a0,a0,8
    80004728:	ffffc097          	auipc	ra,0xffffc
    8000472c:	41e080e7          	jalr	1054(ra) # 80000b46 <initlock>
    80004730:	0324b023          	sd	s2,32(s1)
    80004734:	0004a023          	sw	zero,0(s1)
    80004738:	0204a423          	sw	zero,40(s1)
    8000473c:	60e2                	ld	ra,24(sp)
    8000473e:	6442                	ld	s0,16(sp)
    80004740:	64a2                	ld	s1,8(sp)
    80004742:	6902                	ld	s2,0(sp)
    80004744:	6105                	addi	sp,sp,32
    80004746:	8082                	ret

0000000080004748 <acquiresleep>:
    80004748:	1101                	addi	sp,sp,-32
    8000474a:	ec06                	sd	ra,24(sp)
    8000474c:	e822                	sd	s0,16(sp)
    8000474e:	e426                	sd	s1,8(sp)
    80004750:	e04a                	sd	s2,0(sp)
    80004752:	1000                	addi	s0,sp,32
    80004754:	84aa                	mv	s1,a0
    80004756:	00850913          	addi	s2,a0,8
    8000475a:	854a                	mv	a0,s2
    8000475c:	ffffc097          	auipc	ra,0xffffc
    80004760:	47a080e7          	jalr	1146(ra) # 80000bd6 <acquire>
    80004764:	409c                	lw	a5,0(s1)
    80004766:	cb89                	beqz	a5,80004778 <acquiresleep+0x30>
    80004768:	85ca                	mv	a1,s2
    8000476a:	8526                	mv	a0,s1
    8000476c:	ffffe097          	auipc	ra,0xffffe
    80004770:	8e8080e7          	jalr	-1816(ra) # 80002054 <sleep>
    80004774:	409c                	lw	a5,0(s1)
    80004776:	fbed                	bnez	a5,80004768 <acquiresleep+0x20>
    80004778:	4785                	li	a5,1
    8000477a:	c09c                	sw	a5,0(s1)
    8000477c:	ffffd097          	auipc	ra,0xffffd
    80004780:	230080e7          	jalr	560(ra) # 800019ac <myproc>
    80004784:	591c                	lw	a5,48(a0)
    80004786:	d49c                	sw	a5,40(s1)
    80004788:	854a                	mv	a0,s2
    8000478a:	ffffc097          	auipc	ra,0xffffc
    8000478e:	500080e7          	jalr	1280(ra) # 80000c8a <release>
    80004792:	60e2                	ld	ra,24(sp)
    80004794:	6442                	ld	s0,16(sp)
    80004796:	64a2                	ld	s1,8(sp)
    80004798:	6902                	ld	s2,0(sp)
    8000479a:	6105                	addi	sp,sp,32
    8000479c:	8082                	ret

000000008000479e <releasesleep>:
    8000479e:	1101                	addi	sp,sp,-32
    800047a0:	ec06                	sd	ra,24(sp)
    800047a2:	e822                	sd	s0,16(sp)
    800047a4:	e426                	sd	s1,8(sp)
    800047a6:	e04a                	sd	s2,0(sp)
    800047a8:	1000                	addi	s0,sp,32
    800047aa:	84aa                	mv	s1,a0
    800047ac:	00850913          	addi	s2,a0,8
    800047b0:	854a                	mv	a0,s2
    800047b2:	ffffc097          	auipc	ra,0xffffc
    800047b6:	424080e7          	jalr	1060(ra) # 80000bd6 <acquire>
    800047ba:	0004a023          	sw	zero,0(s1)
    800047be:	0204a423          	sw	zero,40(s1)
    800047c2:	8526                	mv	a0,s1
    800047c4:	ffffe097          	auipc	ra,0xffffe
    800047c8:	8f4080e7          	jalr	-1804(ra) # 800020b8 <wakeup>
    800047cc:	854a                	mv	a0,s2
    800047ce:	ffffc097          	auipc	ra,0xffffc
    800047d2:	4bc080e7          	jalr	1212(ra) # 80000c8a <release>
    800047d6:	60e2                	ld	ra,24(sp)
    800047d8:	6442                	ld	s0,16(sp)
    800047da:	64a2                	ld	s1,8(sp)
    800047dc:	6902                	ld	s2,0(sp)
    800047de:	6105                	addi	sp,sp,32
    800047e0:	8082                	ret

00000000800047e2 <holdingsleep>:
    800047e2:	7179                	addi	sp,sp,-48
    800047e4:	f406                	sd	ra,40(sp)
    800047e6:	f022                	sd	s0,32(sp)
    800047e8:	ec26                	sd	s1,24(sp)
    800047ea:	e84a                	sd	s2,16(sp)
    800047ec:	e44e                	sd	s3,8(sp)
    800047ee:	1800                	addi	s0,sp,48
    800047f0:	84aa                	mv	s1,a0
    800047f2:	00850913          	addi	s2,a0,8
    800047f6:	854a                	mv	a0,s2
    800047f8:	ffffc097          	auipc	ra,0xffffc
    800047fc:	3de080e7          	jalr	990(ra) # 80000bd6 <acquire>
    80004800:	409c                	lw	a5,0(s1)
    80004802:	ef99                	bnez	a5,80004820 <holdingsleep+0x3e>
    80004804:	4481                	li	s1,0
    80004806:	854a                	mv	a0,s2
    80004808:	ffffc097          	auipc	ra,0xffffc
    8000480c:	482080e7          	jalr	1154(ra) # 80000c8a <release>
    80004810:	8526                	mv	a0,s1
    80004812:	70a2                	ld	ra,40(sp)
    80004814:	7402                	ld	s0,32(sp)
    80004816:	64e2                	ld	s1,24(sp)
    80004818:	6942                	ld	s2,16(sp)
    8000481a:	69a2                	ld	s3,8(sp)
    8000481c:	6145                	addi	sp,sp,48
    8000481e:	8082                	ret
    80004820:	0284a983          	lw	s3,40(s1)
    80004824:	ffffd097          	auipc	ra,0xffffd
    80004828:	188080e7          	jalr	392(ra) # 800019ac <myproc>
    8000482c:	5904                	lw	s1,48(a0)
    8000482e:	413484b3          	sub	s1,s1,s3
    80004832:	0014b493          	seqz	s1,s1
    80004836:	bfc1                	j	80004806 <holdingsleep+0x24>

0000000080004838 <fileinit>:
    80004838:	1141                	addi	sp,sp,-16
    8000483a:	e406                	sd	ra,8(sp)
    8000483c:	e022                	sd	s0,0(sp)
    8000483e:	0800                	addi	s0,sp,16
    80004840:	00004597          	auipc	a1,0x4
    80004844:	e9858593          	addi	a1,a1,-360 # 800086d8 <syscalls+0x240>
    80004848:	0001c517          	auipc	a0,0x1c
    8000484c:	45050513          	addi	a0,a0,1104 # 80020c98 <ftable>
    80004850:	ffffc097          	auipc	ra,0xffffc
    80004854:	2f6080e7          	jalr	758(ra) # 80000b46 <initlock>
    80004858:	60a2                	ld	ra,8(sp)
    8000485a:	6402                	ld	s0,0(sp)
    8000485c:	0141                	addi	sp,sp,16
    8000485e:	8082                	ret

0000000080004860 <filealloc>:
    80004860:	1101                	addi	sp,sp,-32
    80004862:	ec06                	sd	ra,24(sp)
    80004864:	e822                	sd	s0,16(sp)
    80004866:	e426                	sd	s1,8(sp)
    80004868:	1000                	addi	s0,sp,32
    8000486a:	0001c517          	auipc	a0,0x1c
    8000486e:	42e50513          	addi	a0,a0,1070 # 80020c98 <ftable>
    80004872:	ffffc097          	auipc	ra,0xffffc
    80004876:	364080e7          	jalr	868(ra) # 80000bd6 <acquire>
    8000487a:	0001c497          	auipc	s1,0x1c
    8000487e:	43648493          	addi	s1,s1,1078 # 80020cb0 <ftable+0x18>
    80004882:	0001d717          	auipc	a4,0x1d
    80004886:	3ce70713          	addi	a4,a4,974 # 80021c50 <disk>
    8000488a:	40dc                	lw	a5,4(s1)
    8000488c:	cf99                	beqz	a5,800048aa <filealloc+0x4a>
    8000488e:	02848493          	addi	s1,s1,40
    80004892:	fee49ce3          	bne	s1,a4,8000488a <filealloc+0x2a>
    80004896:	0001c517          	auipc	a0,0x1c
    8000489a:	40250513          	addi	a0,a0,1026 # 80020c98 <ftable>
    8000489e:	ffffc097          	auipc	ra,0xffffc
    800048a2:	3ec080e7          	jalr	1004(ra) # 80000c8a <release>
    800048a6:	4481                	li	s1,0
    800048a8:	a819                	j	800048be <filealloc+0x5e>
    800048aa:	4785                	li	a5,1
    800048ac:	c0dc                	sw	a5,4(s1)
    800048ae:	0001c517          	auipc	a0,0x1c
    800048b2:	3ea50513          	addi	a0,a0,1002 # 80020c98 <ftable>
    800048b6:	ffffc097          	auipc	ra,0xffffc
    800048ba:	3d4080e7          	jalr	980(ra) # 80000c8a <release>
    800048be:	8526                	mv	a0,s1
    800048c0:	60e2                	ld	ra,24(sp)
    800048c2:	6442                	ld	s0,16(sp)
    800048c4:	64a2                	ld	s1,8(sp)
    800048c6:	6105                	addi	sp,sp,32
    800048c8:	8082                	ret

00000000800048ca <filedup>:
    800048ca:	1101                	addi	sp,sp,-32
    800048cc:	ec06                	sd	ra,24(sp)
    800048ce:	e822                	sd	s0,16(sp)
    800048d0:	e426                	sd	s1,8(sp)
    800048d2:	1000                	addi	s0,sp,32
    800048d4:	84aa                	mv	s1,a0
    800048d6:	0001c517          	auipc	a0,0x1c
    800048da:	3c250513          	addi	a0,a0,962 # 80020c98 <ftable>
    800048de:	ffffc097          	auipc	ra,0xffffc
    800048e2:	2f8080e7          	jalr	760(ra) # 80000bd6 <acquire>
    800048e6:	40dc                	lw	a5,4(s1)
    800048e8:	02f05263          	blez	a5,8000490c <filedup+0x42>
    800048ec:	2785                	addiw	a5,a5,1
    800048ee:	c0dc                	sw	a5,4(s1)
    800048f0:	0001c517          	auipc	a0,0x1c
    800048f4:	3a850513          	addi	a0,a0,936 # 80020c98 <ftable>
    800048f8:	ffffc097          	auipc	ra,0xffffc
    800048fc:	392080e7          	jalr	914(ra) # 80000c8a <release>
    80004900:	8526                	mv	a0,s1
    80004902:	60e2                	ld	ra,24(sp)
    80004904:	6442                	ld	s0,16(sp)
    80004906:	64a2                	ld	s1,8(sp)
    80004908:	6105                	addi	sp,sp,32
    8000490a:	8082                	ret
    8000490c:	00004517          	auipc	a0,0x4
    80004910:	dd450513          	addi	a0,a0,-556 # 800086e0 <syscalls+0x248>
    80004914:	ffffc097          	auipc	ra,0xffffc
    80004918:	c2a080e7          	jalr	-982(ra) # 8000053e <panic>

000000008000491c <fileclose>:
    8000491c:	7139                	addi	sp,sp,-64
    8000491e:	fc06                	sd	ra,56(sp)
    80004920:	f822                	sd	s0,48(sp)
    80004922:	f426                	sd	s1,40(sp)
    80004924:	f04a                	sd	s2,32(sp)
    80004926:	ec4e                	sd	s3,24(sp)
    80004928:	e852                	sd	s4,16(sp)
    8000492a:	e456                	sd	s5,8(sp)
    8000492c:	0080                	addi	s0,sp,64
    8000492e:	84aa                	mv	s1,a0
    80004930:	0001c517          	auipc	a0,0x1c
    80004934:	36850513          	addi	a0,a0,872 # 80020c98 <ftable>
    80004938:	ffffc097          	auipc	ra,0xffffc
    8000493c:	29e080e7          	jalr	670(ra) # 80000bd6 <acquire>
    80004940:	40dc                	lw	a5,4(s1)
    80004942:	06f05163          	blez	a5,800049a4 <fileclose+0x88>
    80004946:	37fd                	addiw	a5,a5,-1
    80004948:	0007871b          	sext.w	a4,a5
    8000494c:	c0dc                	sw	a5,4(s1)
    8000494e:	06e04363          	bgtz	a4,800049b4 <fileclose+0x98>
    80004952:	0004a903          	lw	s2,0(s1)
    80004956:	0094ca83          	lbu	s5,9(s1)
    8000495a:	0104ba03          	ld	s4,16(s1)
    8000495e:	0184b983          	ld	s3,24(s1)
    80004962:	0004a223          	sw	zero,4(s1)
    80004966:	0004a023          	sw	zero,0(s1)
    8000496a:	0001c517          	auipc	a0,0x1c
    8000496e:	32e50513          	addi	a0,a0,814 # 80020c98 <ftable>
    80004972:	ffffc097          	auipc	ra,0xffffc
    80004976:	318080e7          	jalr	792(ra) # 80000c8a <release>
    8000497a:	4785                	li	a5,1
    8000497c:	04f90d63          	beq	s2,a5,800049d6 <fileclose+0xba>
    80004980:	3979                	addiw	s2,s2,-2
    80004982:	4785                	li	a5,1
    80004984:	0527e063          	bltu	a5,s2,800049c4 <fileclose+0xa8>
    80004988:	00000097          	auipc	ra,0x0
    8000498c:	ac8080e7          	jalr	-1336(ra) # 80004450 <begin_op>
    80004990:	854e                	mv	a0,s3
    80004992:	fffff097          	auipc	ra,0xfffff
    80004996:	2b6080e7          	jalr	694(ra) # 80003c48 <iput>
    8000499a:	00000097          	auipc	ra,0x0
    8000499e:	b36080e7          	jalr	-1226(ra) # 800044d0 <end_op>
    800049a2:	a00d                	j	800049c4 <fileclose+0xa8>
    800049a4:	00004517          	auipc	a0,0x4
    800049a8:	d4450513          	addi	a0,a0,-700 # 800086e8 <syscalls+0x250>
    800049ac:	ffffc097          	auipc	ra,0xffffc
    800049b0:	b92080e7          	jalr	-1134(ra) # 8000053e <panic>
    800049b4:	0001c517          	auipc	a0,0x1c
    800049b8:	2e450513          	addi	a0,a0,740 # 80020c98 <ftable>
    800049bc:	ffffc097          	auipc	ra,0xffffc
    800049c0:	2ce080e7          	jalr	718(ra) # 80000c8a <release>
    800049c4:	70e2                	ld	ra,56(sp)
    800049c6:	7442                	ld	s0,48(sp)
    800049c8:	74a2                	ld	s1,40(sp)
    800049ca:	7902                	ld	s2,32(sp)
    800049cc:	69e2                	ld	s3,24(sp)
    800049ce:	6a42                	ld	s4,16(sp)
    800049d0:	6aa2                	ld	s5,8(sp)
    800049d2:	6121                	addi	sp,sp,64
    800049d4:	8082                	ret
    800049d6:	85d6                	mv	a1,s5
    800049d8:	8552                	mv	a0,s4
    800049da:	00000097          	auipc	ra,0x0
    800049de:	34c080e7          	jalr	844(ra) # 80004d26 <pipeclose>
    800049e2:	b7cd                	j	800049c4 <fileclose+0xa8>

00000000800049e4 <filestat>:
    800049e4:	715d                	addi	sp,sp,-80
    800049e6:	e486                	sd	ra,72(sp)
    800049e8:	e0a2                	sd	s0,64(sp)
    800049ea:	fc26                	sd	s1,56(sp)
    800049ec:	f84a                	sd	s2,48(sp)
    800049ee:	f44e                	sd	s3,40(sp)
    800049f0:	0880                	addi	s0,sp,80
    800049f2:	84aa                	mv	s1,a0
    800049f4:	89ae                	mv	s3,a1
    800049f6:	ffffd097          	auipc	ra,0xffffd
    800049fa:	fb6080e7          	jalr	-74(ra) # 800019ac <myproc>
    800049fe:	409c                	lw	a5,0(s1)
    80004a00:	37f9                	addiw	a5,a5,-2
    80004a02:	4705                	li	a4,1
    80004a04:	04f76763          	bltu	a4,a5,80004a52 <filestat+0x6e>
    80004a08:	892a                	mv	s2,a0
    80004a0a:	6c88                	ld	a0,24(s1)
    80004a0c:	fffff097          	auipc	ra,0xfffff
    80004a10:	082080e7          	jalr	130(ra) # 80003a8e <ilock>
    80004a14:	fb840593          	addi	a1,s0,-72
    80004a18:	6c88                	ld	a0,24(s1)
    80004a1a:	fffff097          	auipc	ra,0xfffff
    80004a1e:	2fe080e7          	jalr	766(ra) # 80003d18 <stati>
    80004a22:	6c88                	ld	a0,24(s1)
    80004a24:	fffff097          	auipc	ra,0xfffff
    80004a28:	12c080e7          	jalr	300(ra) # 80003b50 <iunlock>
    80004a2c:	46e1                	li	a3,24
    80004a2e:	fb840613          	addi	a2,s0,-72
    80004a32:	85ce                	mv	a1,s3
    80004a34:	05093503          	ld	a0,80(s2)
    80004a38:	ffffd097          	auipc	ra,0xffffd
    80004a3c:	c30080e7          	jalr	-976(ra) # 80001668 <copyout>
    80004a40:	41f5551b          	sraiw	a0,a0,0x1f
    80004a44:	60a6                	ld	ra,72(sp)
    80004a46:	6406                	ld	s0,64(sp)
    80004a48:	74e2                	ld	s1,56(sp)
    80004a4a:	7942                	ld	s2,48(sp)
    80004a4c:	79a2                	ld	s3,40(sp)
    80004a4e:	6161                	addi	sp,sp,80
    80004a50:	8082                	ret
    80004a52:	557d                	li	a0,-1
    80004a54:	bfc5                	j	80004a44 <filestat+0x60>

0000000080004a56 <fileread>:
    80004a56:	7179                	addi	sp,sp,-48
    80004a58:	f406                	sd	ra,40(sp)
    80004a5a:	f022                	sd	s0,32(sp)
    80004a5c:	ec26                	sd	s1,24(sp)
    80004a5e:	e84a                	sd	s2,16(sp)
    80004a60:	e44e                	sd	s3,8(sp)
    80004a62:	1800                	addi	s0,sp,48
    80004a64:	00854783          	lbu	a5,8(a0)
    80004a68:	c3d5                	beqz	a5,80004b0c <fileread+0xb6>
    80004a6a:	84aa                	mv	s1,a0
    80004a6c:	89ae                	mv	s3,a1
    80004a6e:	8932                	mv	s2,a2
    80004a70:	411c                	lw	a5,0(a0)
    80004a72:	4705                	li	a4,1
    80004a74:	04e78963          	beq	a5,a4,80004ac6 <fileread+0x70>
    80004a78:	470d                	li	a4,3
    80004a7a:	04e78d63          	beq	a5,a4,80004ad4 <fileread+0x7e>
    80004a7e:	4709                	li	a4,2
    80004a80:	06e79e63          	bne	a5,a4,80004afc <fileread+0xa6>
    80004a84:	6d08                	ld	a0,24(a0)
    80004a86:	fffff097          	auipc	ra,0xfffff
    80004a8a:	008080e7          	jalr	8(ra) # 80003a8e <ilock>
    80004a8e:	874a                	mv	a4,s2
    80004a90:	5094                	lw	a3,32(s1)
    80004a92:	864e                	mv	a2,s3
    80004a94:	4585                	li	a1,1
    80004a96:	6c88                	ld	a0,24(s1)
    80004a98:	fffff097          	auipc	ra,0xfffff
    80004a9c:	2aa080e7          	jalr	682(ra) # 80003d42 <readi>
    80004aa0:	892a                	mv	s2,a0
    80004aa2:	00a05563          	blez	a0,80004aac <fileread+0x56>
    80004aa6:	509c                	lw	a5,32(s1)
    80004aa8:	9fa9                	addw	a5,a5,a0
    80004aaa:	d09c                	sw	a5,32(s1)
    80004aac:	6c88                	ld	a0,24(s1)
    80004aae:	fffff097          	auipc	ra,0xfffff
    80004ab2:	0a2080e7          	jalr	162(ra) # 80003b50 <iunlock>
    80004ab6:	854a                	mv	a0,s2
    80004ab8:	70a2                	ld	ra,40(sp)
    80004aba:	7402                	ld	s0,32(sp)
    80004abc:	64e2                	ld	s1,24(sp)
    80004abe:	6942                	ld	s2,16(sp)
    80004ac0:	69a2                	ld	s3,8(sp)
    80004ac2:	6145                	addi	sp,sp,48
    80004ac4:	8082                	ret
    80004ac6:	6908                	ld	a0,16(a0)
    80004ac8:	00000097          	auipc	ra,0x0
    80004acc:	3c6080e7          	jalr	966(ra) # 80004e8e <piperead>
    80004ad0:	892a                	mv	s2,a0
    80004ad2:	b7d5                	j	80004ab6 <fileread+0x60>
    80004ad4:	02451783          	lh	a5,36(a0)
    80004ad8:	03079693          	slli	a3,a5,0x30
    80004adc:	92c1                	srli	a3,a3,0x30
    80004ade:	4725                	li	a4,9
    80004ae0:	02d76863          	bltu	a4,a3,80004b10 <fileread+0xba>
    80004ae4:	0792                	slli	a5,a5,0x4
    80004ae6:	0001c717          	auipc	a4,0x1c
    80004aea:	11270713          	addi	a4,a4,274 # 80020bf8 <devsw>
    80004aee:	97ba                	add	a5,a5,a4
    80004af0:	639c                	ld	a5,0(a5)
    80004af2:	c38d                	beqz	a5,80004b14 <fileread+0xbe>
    80004af4:	4505                	li	a0,1
    80004af6:	9782                	jalr	a5
    80004af8:	892a                	mv	s2,a0
    80004afa:	bf75                	j	80004ab6 <fileread+0x60>
    80004afc:	00004517          	auipc	a0,0x4
    80004b00:	bfc50513          	addi	a0,a0,-1028 # 800086f8 <syscalls+0x260>
    80004b04:	ffffc097          	auipc	ra,0xffffc
    80004b08:	a3a080e7          	jalr	-1478(ra) # 8000053e <panic>
    80004b0c:	597d                	li	s2,-1
    80004b0e:	b765                	j	80004ab6 <fileread+0x60>
    80004b10:	597d                	li	s2,-1
    80004b12:	b755                	j	80004ab6 <fileread+0x60>
    80004b14:	597d                	li	s2,-1
    80004b16:	b745                	j	80004ab6 <fileread+0x60>

0000000080004b18 <filewrite>:
    80004b18:	715d                	addi	sp,sp,-80
    80004b1a:	e486                	sd	ra,72(sp)
    80004b1c:	e0a2                	sd	s0,64(sp)
    80004b1e:	fc26                	sd	s1,56(sp)
    80004b20:	f84a                	sd	s2,48(sp)
    80004b22:	f44e                	sd	s3,40(sp)
    80004b24:	f052                	sd	s4,32(sp)
    80004b26:	ec56                	sd	s5,24(sp)
    80004b28:	e85a                	sd	s6,16(sp)
    80004b2a:	e45e                	sd	s7,8(sp)
    80004b2c:	e062                	sd	s8,0(sp)
    80004b2e:	0880                	addi	s0,sp,80
    80004b30:	00954783          	lbu	a5,9(a0)
    80004b34:	10078663          	beqz	a5,80004c40 <filewrite+0x128>
    80004b38:	892a                	mv	s2,a0
    80004b3a:	8aae                	mv	s5,a1
    80004b3c:	8a32                	mv	s4,a2
    80004b3e:	411c                	lw	a5,0(a0)
    80004b40:	4705                	li	a4,1
    80004b42:	02e78263          	beq	a5,a4,80004b66 <filewrite+0x4e>
    80004b46:	470d                	li	a4,3
    80004b48:	02e78663          	beq	a5,a4,80004b74 <filewrite+0x5c>
    80004b4c:	4709                	li	a4,2
    80004b4e:	0ee79163          	bne	a5,a4,80004c30 <filewrite+0x118>
    80004b52:	0ac05d63          	blez	a2,80004c0c <filewrite+0xf4>
    80004b56:	4981                	li	s3,0
    80004b58:	6b05                	lui	s6,0x1
    80004b5a:	c00b0b13          	addi	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    80004b5e:	6b85                	lui	s7,0x1
    80004b60:	c00b8b9b          	addiw	s7,s7,-1024
    80004b64:	a861                	j	80004bfc <filewrite+0xe4>
    80004b66:	6908                	ld	a0,16(a0)
    80004b68:	00000097          	auipc	ra,0x0
    80004b6c:	22e080e7          	jalr	558(ra) # 80004d96 <pipewrite>
    80004b70:	8a2a                	mv	s4,a0
    80004b72:	a045                	j	80004c12 <filewrite+0xfa>
    80004b74:	02451783          	lh	a5,36(a0)
    80004b78:	03079693          	slli	a3,a5,0x30
    80004b7c:	92c1                	srli	a3,a3,0x30
    80004b7e:	4725                	li	a4,9
    80004b80:	0cd76263          	bltu	a4,a3,80004c44 <filewrite+0x12c>
    80004b84:	0792                	slli	a5,a5,0x4
    80004b86:	0001c717          	auipc	a4,0x1c
    80004b8a:	07270713          	addi	a4,a4,114 # 80020bf8 <devsw>
    80004b8e:	97ba                	add	a5,a5,a4
    80004b90:	679c                	ld	a5,8(a5)
    80004b92:	cbdd                	beqz	a5,80004c48 <filewrite+0x130>
    80004b94:	4505                	li	a0,1
    80004b96:	9782                	jalr	a5
    80004b98:	8a2a                	mv	s4,a0
    80004b9a:	a8a5                	j	80004c12 <filewrite+0xfa>
    80004b9c:	00048c1b          	sext.w	s8,s1
    80004ba0:	00000097          	auipc	ra,0x0
    80004ba4:	8b0080e7          	jalr	-1872(ra) # 80004450 <begin_op>
    80004ba8:	01893503          	ld	a0,24(s2)
    80004bac:	fffff097          	auipc	ra,0xfffff
    80004bb0:	ee2080e7          	jalr	-286(ra) # 80003a8e <ilock>
    80004bb4:	8762                	mv	a4,s8
    80004bb6:	02092683          	lw	a3,32(s2)
    80004bba:	01598633          	add	a2,s3,s5
    80004bbe:	4585                	li	a1,1
    80004bc0:	01893503          	ld	a0,24(s2)
    80004bc4:	fffff097          	auipc	ra,0xfffff
    80004bc8:	276080e7          	jalr	630(ra) # 80003e3a <writei>
    80004bcc:	84aa                	mv	s1,a0
    80004bce:	00a05763          	blez	a0,80004bdc <filewrite+0xc4>
    80004bd2:	02092783          	lw	a5,32(s2)
    80004bd6:	9fa9                	addw	a5,a5,a0
    80004bd8:	02f92023          	sw	a5,32(s2)
    80004bdc:	01893503          	ld	a0,24(s2)
    80004be0:	fffff097          	auipc	ra,0xfffff
    80004be4:	f70080e7          	jalr	-144(ra) # 80003b50 <iunlock>
    80004be8:	00000097          	auipc	ra,0x0
    80004bec:	8e8080e7          	jalr	-1816(ra) # 800044d0 <end_op>
    80004bf0:	009c1f63          	bne	s8,s1,80004c0e <filewrite+0xf6>
    80004bf4:	013489bb          	addw	s3,s1,s3
    80004bf8:	0149db63          	bge	s3,s4,80004c0e <filewrite+0xf6>
    80004bfc:	413a07bb          	subw	a5,s4,s3
    80004c00:	84be                	mv	s1,a5
    80004c02:	2781                	sext.w	a5,a5
    80004c04:	f8fb5ce3          	bge	s6,a5,80004b9c <filewrite+0x84>
    80004c08:	84de                	mv	s1,s7
    80004c0a:	bf49                	j	80004b9c <filewrite+0x84>
    80004c0c:	4981                	li	s3,0
    80004c0e:	013a1f63          	bne	s4,s3,80004c2c <filewrite+0x114>
    80004c12:	8552                	mv	a0,s4
    80004c14:	60a6                	ld	ra,72(sp)
    80004c16:	6406                	ld	s0,64(sp)
    80004c18:	74e2                	ld	s1,56(sp)
    80004c1a:	7942                	ld	s2,48(sp)
    80004c1c:	79a2                	ld	s3,40(sp)
    80004c1e:	7a02                	ld	s4,32(sp)
    80004c20:	6ae2                	ld	s5,24(sp)
    80004c22:	6b42                	ld	s6,16(sp)
    80004c24:	6ba2                	ld	s7,8(sp)
    80004c26:	6c02                	ld	s8,0(sp)
    80004c28:	6161                	addi	sp,sp,80
    80004c2a:	8082                	ret
    80004c2c:	5a7d                	li	s4,-1
    80004c2e:	b7d5                	j	80004c12 <filewrite+0xfa>
    80004c30:	00004517          	auipc	a0,0x4
    80004c34:	ad850513          	addi	a0,a0,-1320 # 80008708 <syscalls+0x270>
    80004c38:	ffffc097          	auipc	ra,0xffffc
    80004c3c:	906080e7          	jalr	-1786(ra) # 8000053e <panic>
    80004c40:	5a7d                	li	s4,-1
    80004c42:	bfc1                	j	80004c12 <filewrite+0xfa>
    80004c44:	5a7d                	li	s4,-1
    80004c46:	b7f1                	j	80004c12 <filewrite+0xfa>
    80004c48:	5a7d                	li	s4,-1
    80004c4a:	b7e1                	j	80004c12 <filewrite+0xfa>

0000000080004c4c <pipealloc>:
    80004c4c:	7179                	addi	sp,sp,-48
    80004c4e:	f406                	sd	ra,40(sp)
    80004c50:	f022                	sd	s0,32(sp)
    80004c52:	ec26                	sd	s1,24(sp)
    80004c54:	e84a                	sd	s2,16(sp)
    80004c56:	e44e                	sd	s3,8(sp)
    80004c58:	e052                	sd	s4,0(sp)
    80004c5a:	1800                	addi	s0,sp,48
    80004c5c:	84aa                	mv	s1,a0
    80004c5e:	8a2e                	mv	s4,a1
    80004c60:	0005b023          	sd	zero,0(a1)
    80004c64:	00053023          	sd	zero,0(a0)
    80004c68:	00000097          	auipc	ra,0x0
    80004c6c:	bf8080e7          	jalr	-1032(ra) # 80004860 <filealloc>
    80004c70:	e088                	sd	a0,0(s1)
    80004c72:	c551                	beqz	a0,80004cfe <pipealloc+0xb2>
    80004c74:	00000097          	auipc	ra,0x0
    80004c78:	bec080e7          	jalr	-1044(ra) # 80004860 <filealloc>
    80004c7c:	00aa3023          	sd	a0,0(s4)
    80004c80:	c92d                	beqz	a0,80004cf2 <pipealloc+0xa6>
    80004c82:	ffffc097          	auipc	ra,0xffffc
    80004c86:	e64080e7          	jalr	-412(ra) # 80000ae6 <kalloc>
    80004c8a:	892a                	mv	s2,a0
    80004c8c:	c125                	beqz	a0,80004cec <pipealloc+0xa0>
    80004c8e:	4985                	li	s3,1
    80004c90:	23352023          	sw	s3,544(a0)
    80004c94:	23352223          	sw	s3,548(a0)
    80004c98:	20052e23          	sw	zero,540(a0)
    80004c9c:	20052c23          	sw	zero,536(a0)
    80004ca0:	00004597          	auipc	a1,0x4
    80004ca4:	a7858593          	addi	a1,a1,-1416 # 80008718 <syscalls+0x280>
    80004ca8:	ffffc097          	auipc	ra,0xffffc
    80004cac:	e9e080e7          	jalr	-354(ra) # 80000b46 <initlock>
    80004cb0:	609c                	ld	a5,0(s1)
    80004cb2:	0137a023          	sw	s3,0(a5)
    80004cb6:	609c                	ld	a5,0(s1)
    80004cb8:	01378423          	sb	s3,8(a5)
    80004cbc:	609c                	ld	a5,0(s1)
    80004cbe:	000784a3          	sb	zero,9(a5)
    80004cc2:	609c                	ld	a5,0(s1)
    80004cc4:	0127b823          	sd	s2,16(a5)
    80004cc8:	000a3783          	ld	a5,0(s4)
    80004ccc:	0137a023          	sw	s3,0(a5)
    80004cd0:	000a3783          	ld	a5,0(s4)
    80004cd4:	00078423          	sb	zero,8(a5)
    80004cd8:	000a3783          	ld	a5,0(s4)
    80004cdc:	013784a3          	sb	s3,9(a5)
    80004ce0:	000a3783          	ld	a5,0(s4)
    80004ce4:	0127b823          	sd	s2,16(a5)
    80004ce8:	4501                	li	a0,0
    80004cea:	a025                	j	80004d12 <pipealloc+0xc6>
    80004cec:	6088                	ld	a0,0(s1)
    80004cee:	e501                	bnez	a0,80004cf6 <pipealloc+0xaa>
    80004cf0:	a039                	j	80004cfe <pipealloc+0xb2>
    80004cf2:	6088                	ld	a0,0(s1)
    80004cf4:	c51d                	beqz	a0,80004d22 <pipealloc+0xd6>
    80004cf6:	00000097          	auipc	ra,0x0
    80004cfa:	c26080e7          	jalr	-986(ra) # 8000491c <fileclose>
    80004cfe:	000a3783          	ld	a5,0(s4)
    80004d02:	557d                	li	a0,-1
    80004d04:	c799                	beqz	a5,80004d12 <pipealloc+0xc6>
    80004d06:	853e                	mv	a0,a5
    80004d08:	00000097          	auipc	ra,0x0
    80004d0c:	c14080e7          	jalr	-1004(ra) # 8000491c <fileclose>
    80004d10:	557d                	li	a0,-1
    80004d12:	70a2                	ld	ra,40(sp)
    80004d14:	7402                	ld	s0,32(sp)
    80004d16:	64e2                	ld	s1,24(sp)
    80004d18:	6942                	ld	s2,16(sp)
    80004d1a:	69a2                	ld	s3,8(sp)
    80004d1c:	6a02                	ld	s4,0(sp)
    80004d1e:	6145                	addi	sp,sp,48
    80004d20:	8082                	ret
    80004d22:	557d                	li	a0,-1
    80004d24:	b7fd                	j	80004d12 <pipealloc+0xc6>

0000000080004d26 <pipeclose>:
    80004d26:	1101                	addi	sp,sp,-32
    80004d28:	ec06                	sd	ra,24(sp)
    80004d2a:	e822                	sd	s0,16(sp)
    80004d2c:	e426                	sd	s1,8(sp)
    80004d2e:	e04a                	sd	s2,0(sp)
    80004d30:	1000                	addi	s0,sp,32
    80004d32:	84aa                	mv	s1,a0
    80004d34:	892e                	mv	s2,a1
    80004d36:	ffffc097          	auipc	ra,0xffffc
    80004d3a:	ea0080e7          	jalr	-352(ra) # 80000bd6 <acquire>
    80004d3e:	02090d63          	beqz	s2,80004d78 <pipeclose+0x52>
    80004d42:	2204a223          	sw	zero,548(s1)
    80004d46:	21848513          	addi	a0,s1,536
    80004d4a:	ffffd097          	auipc	ra,0xffffd
    80004d4e:	36e080e7          	jalr	878(ra) # 800020b8 <wakeup>
    80004d52:	2204b783          	ld	a5,544(s1)
    80004d56:	eb95                	bnez	a5,80004d8a <pipeclose+0x64>
    80004d58:	8526                	mv	a0,s1
    80004d5a:	ffffc097          	auipc	ra,0xffffc
    80004d5e:	f30080e7          	jalr	-208(ra) # 80000c8a <release>
    80004d62:	8526                	mv	a0,s1
    80004d64:	ffffc097          	auipc	ra,0xffffc
    80004d68:	c86080e7          	jalr	-890(ra) # 800009ea <kfree>
    80004d6c:	60e2                	ld	ra,24(sp)
    80004d6e:	6442                	ld	s0,16(sp)
    80004d70:	64a2                	ld	s1,8(sp)
    80004d72:	6902                	ld	s2,0(sp)
    80004d74:	6105                	addi	sp,sp,32
    80004d76:	8082                	ret
    80004d78:	2204a023          	sw	zero,544(s1)
    80004d7c:	21c48513          	addi	a0,s1,540
    80004d80:	ffffd097          	auipc	ra,0xffffd
    80004d84:	338080e7          	jalr	824(ra) # 800020b8 <wakeup>
    80004d88:	b7e9                	j	80004d52 <pipeclose+0x2c>
    80004d8a:	8526                	mv	a0,s1
    80004d8c:	ffffc097          	auipc	ra,0xffffc
    80004d90:	efe080e7          	jalr	-258(ra) # 80000c8a <release>
    80004d94:	bfe1                	j	80004d6c <pipeclose+0x46>

0000000080004d96 <pipewrite>:
    80004d96:	711d                	addi	sp,sp,-96
    80004d98:	ec86                	sd	ra,88(sp)
    80004d9a:	e8a2                	sd	s0,80(sp)
    80004d9c:	e4a6                	sd	s1,72(sp)
    80004d9e:	e0ca                	sd	s2,64(sp)
    80004da0:	fc4e                	sd	s3,56(sp)
    80004da2:	f852                	sd	s4,48(sp)
    80004da4:	f456                	sd	s5,40(sp)
    80004da6:	f05a                	sd	s6,32(sp)
    80004da8:	ec5e                	sd	s7,24(sp)
    80004daa:	e862                	sd	s8,16(sp)
    80004dac:	1080                	addi	s0,sp,96
    80004dae:	84aa                	mv	s1,a0
    80004db0:	8aae                	mv	s5,a1
    80004db2:	8a32                	mv	s4,a2
    80004db4:	ffffd097          	auipc	ra,0xffffd
    80004db8:	bf8080e7          	jalr	-1032(ra) # 800019ac <myproc>
    80004dbc:	89aa                	mv	s3,a0
    80004dbe:	8526                	mv	a0,s1
    80004dc0:	ffffc097          	auipc	ra,0xffffc
    80004dc4:	e16080e7          	jalr	-490(ra) # 80000bd6 <acquire>
    80004dc8:	0b405663          	blez	s4,80004e74 <pipewrite+0xde>
    80004dcc:	4901                	li	s2,0
    80004dce:	5b7d                	li	s6,-1
    80004dd0:	21848c13          	addi	s8,s1,536
    80004dd4:	21c48b93          	addi	s7,s1,540
    80004dd8:	a089                	j	80004e1a <pipewrite+0x84>
    80004dda:	8526                	mv	a0,s1
    80004ddc:	ffffc097          	auipc	ra,0xffffc
    80004de0:	eae080e7          	jalr	-338(ra) # 80000c8a <release>
    80004de4:	597d                	li	s2,-1
    80004de6:	854a                	mv	a0,s2
    80004de8:	60e6                	ld	ra,88(sp)
    80004dea:	6446                	ld	s0,80(sp)
    80004dec:	64a6                	ld	s1,72(sp)
    80004dee:	6906                	ld	s2,64(sp)
    80004df0:	79e2                	ld	s3,56(sp)
    80004df2:	7a42                	ld	s4,48(sp)
    80004df4:	7aa2                	ld	s5,40(sp)
    80004df6:	7b02                	ld	s6,32(sp)
    80004df8:	6be2                	ld	s7,24(sp)
    80004dfa:	6c42                	ld	s8,16(sp)
    80004dfc:	6125                	addi	sp,sp,96
    80004dfe:	8082                	ret
    80004e00:	8562                	mv	a0,s8
    80004e02:	ffffd097          	auipc	ra,0xffffd
    80004e06:	2b6080e7          	jalr	694(ra) # 800020b8 <wakeup>
    80004e0a:	85a6                	mv	a1,s1
    80004e0c:	855e                	mv	a0,s7
    80004e0e:	ffffd097          	auipc	ra,0xffffd
    80004e12:	246080e7          	jalr	582(ra) # 80002054 <sleep>
    80004e16:	07495063          	bge	s2,s4,80004e76 <pipewrite+0xe0>
    80004e1a:	2204a783          	lw	a5,544(s1)
    80004e1e:	dfd5                	beqz	a5,80004dda <pipewrite+0x44>
    80004e20:	854e                	mv	a0,s3
    80004e22:	ffffe097          	auipc	ra,0xffffe
    80004e26:	912080e7          	jalr	-1774(ra) # 80002734 <killed>
    80004e2a:	f945                	bnez	a0,80004dda <pipewrite+0x44>
    80004e2c:	2184a783          	lw	a5,536(s1)
    80004e30:	21c4a703          	lw	a4,540(s1)
    80004e34:	2007879b          	addiw	a5,a5,512
    80004e38:	fcf704e3          	beq	a4,a5,80004e00 <pipewrite+0x6a>
    80004e3c:	4685                	li	a3,1
    80004e3e:	01590633          	add	a2,s2,s5
    80004e42:	faf40593          	addi	a1,s0,-81
    80004e46:	0509b503          	ld	a0,80(s3)
    80004e4a:	ffffd097          	auipc	ra,0xffffd
    80004e4e:	8aa080e7          	jalr	-1878(ra) # 800016f4 <copyin>
    80004e52:	03650263          	beq	a0,s6,80004e76 <pipewrite+0xe0>
    80004e56:	21c4a783          	lw	a5,540(s1)
    80004e5a:	0017871b          	addiw	a4,a5,1
    80004e5e:	20e4ae23          	sw	a4,540(s1)
    80004e62:	1ff7f793          	andi	a5,a5,511
    80004e66:	97a6                	add	a5,a5,s1
    80004e68:	faf44703          	lbu	a4,-81(s0)
    80004e6c:	00e78c23          	sb	a4,24(a5)
    80004e70:	2905                	addiw	s2,s2,1
    80004e72:	b755                	j	80004e16 <pipewrite+0x80>
    80004e74:	4901                	li	s2,0
    80004e76:	21848513          	addi	a0,s1,536
    80004e7a:	ffffd097          	auipc	ra,0xffffd
    80004e7e:	23e080e7          	jalr	574(ra) # 800020b8 <wakeup>
    80004e82:	8526                	mv	a0,s1
    80004e84:	ffffc097          	auipc	ra,0xffffc
    80004e88:	e06080e7          	jalr	-506(ra) # 80000c8a <release>
    80004e8c:	bfa9                	j	80004de6 <pipewrite+0x50>

0000000080004e8e <piperead>:
    80004e8e:	715d                	addi	sp,sp,-80
    80004e90:	e486                	sd	ra,72(sp)
    80004e92:	e0a2                	sd	s0,64(sp)
    80004e94:	fc26                	sd	s1,56(sp)
    80004e96:	f84a                	sd	s2,48(sp)
    80004e98:	f44e                	sd	s3,40(sp)
    80004e9a:	f052                	sd	s4,32(sp)
    80004e9c:	ec56                	sd	s5,24(sp)
    80004e9e:	e85a                	sd	s6,16(sp)
    80004ea0:	0880                	addi	s0,sp,80
    80004ea2:	84aa                	mv	s1,a0
    80004ea4:	892e                	mv	s2,a1
    80004ea6:	8ab2                	mv	s5,a2
    80004ea8:	ffffd097          	auipc	ra,0xffffd
    80004eac:	b04080e7          	jalr	-1276(ra) # 800019ac <myproc>
    80004eb0:	8a2a                	mv	s4,a0
    80004eb2:	8526                	mv	a0,s1
    80004eb4:	ffffc097          	auipc	ra,0xffffc
    80004eb8:	d22080e7          	jalr	-734(ra) # 80000bd6 <acquire>
    80004ebc:	2184a703          	lw	a4,536(s1)
    80004ec0:	21c4a783          	lw	a5,540(s1)
    80004ec4:	21848993          	addi	s3,s1,536
    80004ec8:	02f71763          	bne	a4,a5,80004ef6 <piperead+0x68>
    80004ecc:	2244a783          	lw	a5,548(s1)
    80004ed0:	c39d                	beqz	a5,80004ef6 <piperead+0x68>
    80004ed2:	8552                	mv	a0,s4
    80004ed4:	ffffe097          	auipc	ra,0xffffe
    80004ed8:	860080e7          	jalr	-1952(ra) # 80002734 <killed>
    80004edc:	e941                	bnez	a0,80004f6c <piperead+0xde>
    80004ede:	85a6                	mv	a1,s1
    80004ee0:	854e                	mv	a0,s3
    80004ee2:	ffffd097          	auipc	ra,0xffffd
    80004ee6:	172080e7          	jalr	370(ra) # 80002054 <sleep>
    80004eea:	2184a703          	lw	a4,536(s1)
    80004eee:	21c4a783          	lw	a5,540(s1)
    80004ef2:	fcf70de3          	beq	a4,a5,80004ecc <piperead+0x3e>
    80004ef6:	4981                	li	s3,0
    80004ef8:	5b7d                	li	s6,-1
    80004efa:	05505363          	blez	s5,80004f40 <piperead+0xb2>
    80004efe:	2184a783          	lw	a5,536(s1)
    80004f02:	21c4a703          	lw	a4,540(s1)
    80004f06:	02f70d63          	beq	a4,a5,80004f40 <piperead+0xb2>
    80004f0a:	0017871b          	addiw	a4,a5,1
    80004f0e:	20e4ac23          	sw	a4,536(s1)
    80004f12:	1ff7f793          	andi	a5,a5,511
    80004f16:	97a6                	add	a5,a5,s1
    80004f18:	0187c783          	lbu	a5,24(a5)
    80004f1c:	faf40fa3          	sb	a5,-65(s0)
    80004f20:	4685                	li	a3,1
    80004f22:	fbf40613          	addi	a2,s0,-65
    80004f26:	85ca                	mv	a1,s2
    80004f28:	050a3503          	ld	a0,80(s4)
    80004f2c:	ffffc097          	auipc	ra,0xffffc
    80004f30:	73c080e7          	jalr	1852(ra) # 80001668 <copyout>
    80004f34:	01650663          	beq	a0,s6,80004f40 <piperead+0xb2>
    80004f38:	2985                	addiw	s3,s3,1
    80004f3a:	0905                	addi	s2,s2,1
    80004f3c:	fd3a91e3          	bne	s5,s3,80004efe <piperead+0x70>
    80004f40:	21c48513          	addi	a0,s1,540
    80004f44:	ffffd097          	auipc	ra,0xffffd
    80004f48:	174080e7          	jalr	372(ra) # 800020b8 <wakeup>
    80004f4c:	8526                	mv	a0,s1
    80004f4e:	ffffc097          	auipc	ra,0xffffc
    80004f52:	d3c080e7          	jalr	-708(ra) # 80000c8a <release>
    80004f56:	854e                	mv	a0,s3
    80004f58:	60a6                	ld	ra,72(sp)
    80004f5a:	6406                	ld	s0,64(sp)
    80004f5c:	74e2                	ld	s1,56(sp)
    80004f5e:	7942                	ld	s2,48(sp)
    80004f60:	79a2                	ld	s3,40(sp)
    80004f62:	7a02                	ld	s4,32(sp)
    80004f64:	6ae2                	ld	s5,24(sp)
    80004f66:	6b42                	ld	s6,16(sp)
    80004f68:	6161                	addi	sp,sp,80
    80004f6a:	8082                	ret
    80004f6c:	8526                	mv	a0,s1
    80004f6e:	ffffc097          	auipc	ra,0xffffc
    80004f72:	d1c080e7          	jalr	-740(ra) # 80000c8a <release>
    80004f76:	59fd                	li	s3,-1
    80004f78:	bff9                	j	80004f56 <piperead+0xc8>

0000000080004f7a <flags2perm>:
    80004f7a:	1141                	addi	sp,sp,-16
    80004f7c:	e422                	sd	s0,8(sp)
    80004f7e:	0800                	addi	s0,sp,16
    80004f80:	87aa                	mv	a5,a0
    80004f82:	8905                	andi	a0,a0,1
    80004f84:	c111                	beqz	a0,80004f88 <flags2perm+0xe>
    80004f86:	4521                	li	a0,8
    80004f88:	8b89                	andi	a5,a5,2
    80004f8a:	c399                	beqz	a5,80004f90 <flags2perm+0x16>
    80004f8c:	00456513          	ori	a0,a0,4
    80004f90:	6422                	ld	s0,8(sp)
    80004f92:	0141                	addi	sp,sp,16
    80004f94:	8082                	ret

0000000080004f96 <exec>:
    80004f96:	de010113          	addi	sp,sp,-544
    80004f9a:	20113c23          	sd	ra,536(sp)
    80004f9e:	20813823          	sd	s0,528(sp)
    80004fa2:	20913423          	sd	s1,520(sp)
    80004fa6:	21213023          	sd	s2,512(sp)
    80004faa:	ffce                	sd	s3,504(sp)
    80004fac:	fbd2                	sd	s4,496(sp)
    80004fae:	f7d6                	sd	s5,488(sp)
    80004fb0:	f3da                	sd	s6,480(sp)
    80004fb2:	efde                	sd	s7,472(sp)
    80004fb4:	ebe2                	sd	s8,464(sp)
    80004fb6:	e7e6                	sd	s9,456(sp)
    80004fb8:	e3ea                	sd	s10,448(sp)
    80004fba:	ff6e                	sd	s11,440(sp)
    80004fbc:	1400                	addi	s0,sp,544
    80004fbe:	892a                	mv	s2,a0
    80004fc0:	dea43423          	sd	a0,-536(s0)
    80004fc4:	deb43823          	sd	a1,-528(s0)
    80004fc8:	ffffd097          	auipc	ra,0xffffd
    80004fcc:	9e4080e7          	jalr	-1564(ra) # 800019ac <myproc>
    80004fd0:	84aa                	mv	s1,a0
    80004fd2:	fffff097          	auipc	ra,0xfffff
    80004fd6:	47e080e7          	jalr	1150(ra) # 80004450 <begin_op>
    80004fda:	854a                	mv	a0,s2
    80004fdc:	fffff097          	auipc	ra,0xfffff
    80004fe0:	258080e7          	jalr	600(ra) # 80004234 <namei>
    80004fe4:	c93d                	beqz	a0,8000505a <exec+0xc4>
    80004fe6:	8aaa                	mv	s5,a0
    80004fe8:	fffff097          	auipc	ra,0xfffff
    80004fec:	aa6080e7          	jalr	-1370(ra) # 80003a8e <ilock>
    80004ff0:	04000713          	li	a4,64
    80004ff4:	4681                	li	a3,0
    80004ff6:	e5040613          	addi	a2,s0,-432
    80004ffa:	4581                	li	a1,0
    80004ffc:	8556                	mv	a0,s5
    80004ffe:	fffff097          	auipc	ra,0xfffff
    80005002:	d44080e7          	jalr	-700(ra) # 80003d42 <readi>
    80005006:	04000793          	li	a5,64
    8000500a:	00f51a63          	bne	a0,a5,8000501e <exec+0x88>
    8000500e:	e5042703          	lw	a4,-432(s0)
    80005012:	464c47b7          	lui	a5,0x464c4
    80005016:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    8000501a:	04f70663          	beq	a4,a5,80005066 <exec+0xd0>
    8000501e:	8556                	mv	a0,s5
    80005020:	fffff097          	auipc	ra,0xfffff
    80005024:	cd0080e7          	jalr	-816(ra) # 80003cf0 <iunlockput>
    80005028:	fffff097          	auipc	ra,0xfffff
    8000502c:	4a8080e7          	jalr	1192(ra) # 800044d0 <end_op>
    80005030:	557d                	li	a0,-1
    80005032:	21813083          	ld	ra,536(sp)
    80005036:	21013403          	ld	s0,528(sp)
    8000503a:	20813483          	ld	s1,520(sp)
    8000503e:	20013903          	ld	s2,512(sp)
    80005042:	79fe                	ld	s3,504(sp)
    80005044:	7a5e                	ld	s4,496(sp)
    80005046:	7abe                	ld	s5,488(sp)
    80005048:	7b1e                	ld	s6,480(sp)
    8000504a:	6bfe                	ld	s7,472(sp)
    8000504c:	6c5e                	ld	s8,464(sp)
    8000504e:	6cbe                	ld	s9,456(sp)
    80005050:	6d1e                	ld	s10,448(sp)
    80005052:	7dfa                	ld	s11,440(sp)
    80005054:	22010113          	addi	sp,sp,544
    80005058:	8082                	ret
    8000505a:	fffff097          	auipc	ra,0xfffff
    8000505e:	476080e7          	jalr	1142(ra) # 800044d0 <end_op>
    80005062:	557d                	li	a0,-1
    80005064:	b7f9                	j	80005032 <exec+0x9c>
    80005066:	8526                	mv	a0,s1
    80005068:	ffffd097          	auipc	ra,0xffffd
    8000506c:	a08080e7          	jalr	-1528(ra) # 80001a70 <proc_pigtable>
    80005070:	8b2a                	mv	s6,a0
    80005072:	d555                	beqz	a0,8000501e <exec+0x88>
    80005074:	e7042783          	lw	a5,-400(s0)
    80005078:	e8845703          	lhu	a4,-376(s0)
    8000507c:	c735                	beqz	a4,800050e8 <exec+0x152>
    8000507e:	4901                	li	s2,0
    80005080:	e0043423          	sd	zero,-504(s0)
    80005084:	6a05                	lui	s4,0x1
    80005086:	fffa0713          	addi	a4,s4,-1 # fff <_entry-0x7ffff001>
    8000508a:	dee43023          	sd	a4,-544(s0)
    8000508e:	6d85                	lui	s11,0x1
    80005090:	7d7d                	lui	s10,0xfffff
    80005092:	a481                	j	800052d2 <exec+0x33c>
    80005094:	00003517          	auipc	a0,0x3
    80005098:	68c50513          	addi	a0,a0,1676 # 80008720 <syscalls+0x288>
    8000509c:	ffffb097          	auipc	ra,0xffffb
    800050a0:	4a2080e7          	jalr	1186(ra) # 8000053e <panic>
    800050a4:	874a                	mv	a4,s2
    800050a6:	009c86bb          	addw	a3,s9,s1
    800050aa:	4581                	li	a1,0
    800050ac:	8556                	mv	a0,s5
    800050ae:	fffff097          	auipc	ra,0xfffff
    800050b2:	c94080e7          	jalr	-876(ra) # 80003d42 <readi>
    800050b6:	2501                	sext.w	a0,a0
    800050b8:	1aa91a63          	bne	s2,a0,8000526c <exec+0x2d6>
    800050bc:	009d84bb          	addw	s1,s11,s1
    800050c0:	013d09bb          	addw	s3,s10,s3
    800050c4:	1f74f763          	bgeu	s1,s7,800052b2 <exec+0x31c>
    800050c8:	02049593          	slli	a1,s1,0x20
    800050cc:	9181                	srli	a1,a1,0x20
    800050ce:	95e2                	add	a1,a1,s8
    800050d0:	855a                	mv	a0,s6
    800050d2:	ffffc097          	auipc	ra,0xffffc
    800050d6:	f8a080e7          	jalr	-118(ra) # 8000105c <walkaddr>
    800050da:	862a                	mv	a2,a0
    800050dc:	dd45                	beqz	a0,80005094 <exec+0xfe>
    800050de:	8952                	mv	s2,s4
    800050e0:	fd49f2e3          	bgeu	s3,s4,800050a4 <exec+0x10e>
    800050e4:	894e                	mv	s2,s3
    800050e6:	bf7d                	j	800050a4 <exec+0x10e>
    800050e8:	4901                	li	s2,0
    800050ea:	8556                	mv	a0,s5
    800050ec:	fffff097          	auipc	ra,0xfffff
    800050f0:	c04080e7          	jalr	-1020(ra) # 80003cf0 <iunlockput>
    800050f4:	fffff097          	auipc	ra,0xfffff
    800050f8:	3dc080e7          	jalr	988(ra) # 800044d0 <end_op>
    800050fc:	ffffd097          	auipc	ra,0xffffd
    80005100:	8b0080e7          	jalr	-1872(ra) # 800019ac <myproc>
    80005104:	8baa                	mv	s7,a0
    80005106:	04853d03          	ld	s10,72(a0)
    8000510a:	6785                	lui	a5,0x1
    8000510c:	17fd                	addi	a5,a5,-1
    8000510e:	993e                	add	s2,s2,a5
    80005110:	77fd                	lui	a5,0xfffff
    80005112:	00f977b3          	and	a5,s2,a5
    80005116:	def43c23          	sd	a5,-520(s0)
    8000511a:	4691                	li	a3,4
    8000511c:	6609                	lui	a2,0x2
    8000511e:	963e                	add	a2,a2,a5
    80005120:	85be                	mv	a1,a5
    80005122:	855a                	mv	a0,s6
    80005124:	ffffc097          	auipc	ra,0xffffc
    80005128:	2ec080e7          	jalr	748(ra) # 80001410 <uvmalloc>
    8000512c:	8c2a                	mv	s8,a0
    8000512e:	4a81                	li	s5,0
    80005130:	12050e63          	beqz	a0,8000526c <exec+0x2d6>
    80005134:	75f9                	lui	a1,0xffffe
    80005136:	95aa                	add	a1,a1,a0
    80005138:	855a                	mv	a0,s6
    8000513a:	ffffc097          	auipc	ra,0xffffc
    8000513e:	4fc080e7          	jalr	1276(ra) # 80001636 <uvmclear>
    80005142:	7afd                	lui	s5,0xfffff
    80005144:	9ae2                	add	s5,s5,s8
    80005146:	df043783          	ld	a5,-528(s0)
    8000514a:	6388                	ld	a0,0(a5)
    8000514c:	c925                	beqz	a0,800051bc <exec+0x226>
    8000514e:	e9040993          	addi	s3,s0,-368
    80005152:	f9040c93          	addi	s9,s0,-112
    80005156:	8962                	mv	s2,s8
    80005158:	4481                	li	s1,0
    8000515a:	ffffc097          	auipc	ra,0xffffc
    8000515e:	cf4080e7          	jalr	-780(ra) # 80000e4e <strlen>
    80005162:	0015079b          	addiw	a5,a0,1
    80005166:	40f90933          	sub	s2,s2,a5
    8000516a:	ff097913          	andi	s2,s2,-16
    8000516e:	13596663          	bltu	s2,s5,8000529a <exec+0x304>
    80005172:	df043d83          	ld	s11,-528(s0)
    80005176:	000dba03          	ld	s4,0(s11) # 1000 <_entry-0x7ffff000>
    8000517a:	8552                	mv	a0,s4
    8000517c:	ffffc097          	auipc	ra,0xffffc
    80005180:	cd2080e7          	jalr	-814(ra) # 80000e4e <strlen>
    80005184:	0015069b          	addiw	a3,a0,1
    80005188:	8652                	mv	a2,s4
    8000518a:	85ca                	mv	a1,s2
    8000518c:	855a                	mv	a0,s6
    8000518e:	ffffc097          	auipc	ra,0xffffc
    80005192:	4da080e7          	jalr	1242(ra) # 80001668 <copyout>
    80005196:	10054663          	bltz	a0,800052a2 <exec+0x30c>
    8000519a:	0129b023          	sd	s2,0(s3)
    8000519e:	0485                	addi	s1,s1,1
    800051a0:	008d8793          	addi	a5,s11,8
    800051a4:	def43823          	sd	a5,-528(s0)
    800051a8:	008db503          	ld	a0,8(s11)
    800051ac:	c911                	beqz	a0,800051c0 <exec+0x22a>
    800051ae:	09a1                	addi	s3,s3,8
    800051b0:	fb3c95e3          	bne	s9,s3,8000515a <exec+0x1c4>
    800051b4:	df843c23          	sd	s8,-520(s0)
    800051b8:	4a81                	li	s5,0
    800051ba:	a84d                	j	8000526c <exec+0x2d6>
    800051bc:	8962                	mv	s2,s8
    800051be:	4481                	li	s1,0
    800051c0:	00349793          	slli	a5,s1,0x3
    800051c4:	f9040713          	addi	a4,s0,-112
    800051c8:	97ba                	add	a5,a5,a4
    800051ca:	f007b023          	sd	zero,-256(a5) # ffffffffffffef00 <end+0xffffffff7ffdd170>
    800051ce:	00148693          	addi	a3,s1,1
    800051d2:	068e                	slli	a3,a3,0x3
    800051d4:	40d90933          	sub	s2,s2,a3
    800051d8:	ff097913          	andi	s2,s2,-16
    800051dc:	01597663          	bgeu	s2,s5,800051e8 <exec+0x252>
    800051e0:	df843c23          	sd	s8,-520(s0)
    800051e4:	4a81                	li	s5,0
    800051e6:	a059                	j	8000526c <exec+0x2d6>
    800051e8:	e9040613          	addi	a2,s0,-368
    800051ec:	85ca                	mv	a1,s2
    800051ee:	855a                	mv	a0,s6
    800051f0:	ffffc097          	auipc	ra,0xffffc
    800051f4:	478080e7          	jalr	1144(ra) # 80001668 <copyout>
    800051f8:	0a054963          	bltz	a0,800052aa <exec+0x314>
    800051fc:	058bb783          	ld	a5,88(s7) # 1058 <_entry-0x7fffefa8>
    80005200:	0727bc23          	sd	s2,120(a5)
    80005204:	de843783          	ld	a5,-536(s0)
    80005208:	0007c703          	lbu	a4,0(a5)
    8000520c:	cf11                	beqz	a4,80005228 <exec+0x292>
    8000520e:	0785                	addi	a5,a5,1
    80005210:	02f00693          	li	a3,47
    80005214:	a039                	j	80005222 <exec+0x28c>
    80005216:	def43423          	sd	a5,-536(s0)
    8000521a:	0785                	addi	a5,a5,1
    8000521c:	fff7c703          	lbu	a4,-1(a5)
    80005220:	c701                	beqz	a4,80005228 <exec+0x292>
    80005222:	fed71ce3          	bne	a4,a3,8000521a <exec+0x284>
    80005226:	bfc5                	j	80005216 <exec+0x280>
    80005228:	4641                	li	a2,16
    8000522a:	de843583          	ld	a1,-536(s0)
    8000522e:	158b8513          	addi	a0,s7,344
    80005232:	ffffc097          	auipc	ra,0xffffc
    80005236:	bea080e7          	jalr	-1046(ra) # 80000e1c <safestrcpy>
    8000523a:	050bb503          	ld	a0,80(s7)
    8000523e:	056bb823          	sd	s6,80(s7)
    80005242:	058bb423          	sd	s8,72(s7)
    80005246:	058bb783          	ld	a5,88(s7)
    8000524a:	e6843703          	ld	a4,-408(s0)
    8000524e:	ef98                	sd	a4,24(a5)
    80005250:	058bb783          	ld	a5,88(s7)
    80005254:	0327b823          	sd	s2,48(a5)
    80005258:	85ea                	mv	a1,s10
    8000525a:	ffffd097          	auipc	ra,0xffffd
    8000525e:	8b2080e7          	jalr	-1870(ra) # 80001b0c <proc_freepigtable>
    80005262:	0004851b          	sext.w	a0,s1
    80005266:	b3f1                	j	80005032 <exec+0x9c>
    80005268:	df243c23          	sd	s2,-520(s0)
    8000526c:	df843583          	ld	a1,-520(s0)
    80005270:	855a                	mv	a0,s6
    80005272:	ffffd097          	auipc	ra,0xffffd
    80005276:	89a080e7          	jalr	-1894(ra) # 80001b0c <proc_freepigtable>
    8000527a:	da0a92e3          	bnez	s5,8000501e <exec+0x88>
    8000527e:	557d                	li	a0,-1
    80005280:	bb4d                	j	80005032 <exec+0x9c>
    80005282:	df243c23          	sd	s2,-520(s0)
    80005286:	b7dd                	j	8000526c <exec+0x2d6>
    80005288:	df243c23          	sd	s2,-520(s0)
    8000528c:	b7c5                	j	8000526c <exec+0x2d6>
    8000528e:	df243c23          	sd	s2,-520(s0)
    80005292:	bfe9                	j	8000526c <exec+0x2d6>
    80005294:	df243c23          	sd	s2,-520(s0)
    80005298:	bfd1                	j	8000526c <exec+0x2d6>
    8000529a:	df843c23          	sd	s8,-520(s0)
    8000529e:	4a81                	li	s5,0
    800052a0:	b7f1                	j	8000526c <exec+0x2d6>
    800052a2:	df843c23          	sd	s8,-520(s0)
    800052a6:	4a81                	li	s5,0
    800052a8:	b7d1                	j	8000526c <exec+0x2d6>
    800052aa:	df843c23          	sd	s8,-520(s0)
    800052ae:	4a81                	li	s5,0
    800052b0:	bf75                	j	8000526c <exec+0x2d6>
    800052b2:	df843903          	ld	s2,-520(s0)
    800052b6:	e0843783          	ld	a5,-504(s0)
    800052ba:	0017869b          	addiw	a3,a5,1
    800052be:	e0d43423          	sd	a3,-504(s0)
    800052c2:	e0043783          	ld	a5,-512(s0)
    800052c6:	0387879b          	addiw	a5,a5,56
    800052ca:	e8845703          	lhu	a4,-376(s0)
    800052ce:	e0e6dee3          	bge	a3,a4,800050ea <exec+0x154>
    800052d2:	2781                	sext.w	a5,a5
    800052d4:	e0f43023          	sd	a5,-512(s0)
    800052d8:	03800713          	li	a4,56
    800052dc:	86be                	mv	a3,a5
    800052de:	e1840613          	addi	a2,s0,-488
    800052e2:	4581                	li	a1,0
    800052e4:	8556                	mv	a0,s5
    800052e6:	fffff097          	auipc	ra,0xfffff
    800052ea:	a5c080e7          	jalr	-1444(ra) # 80003d42 <readi>
    800052ee:	03800793          	li	a5,56
    800052f2:	f6f51be3          	bne	a0,a5,80005268 <exec+0x2d2>
    800052f6:	e1842783          	lw	a5,-488(s0)
    800052fa:	4705                	li	a4,1
    800052fc:	fae79de3          	bne	a5,a4,800052b6 <exec+0x320>
    80005300:	e4043483          	ld	s1,-448(s0)
    80005304:	e3843783          	ld	a5,-456(s0)
    80005308:	f6f4ede3          	bltu	s1,a5,80005282 <exec+0x2ec>
    8000530c:	e2843783          	ld	a5,-472(s0)
    80005310:	94be                	add	s1,s1,a5
    80005312:	f6f4ebe3          	bltu	s1,a5,80005288 <exec+0x2f2>
    80005316:	de043703          	ld	a4,-544(s0)
    8000531a:	8ff9                	and	a5,a5,a4
    8000531c:	fbad                	bnez	a5,8000528e <exec+0x2f8>
    8000531e:	e1c42503          	lw	a0,-484(s0)
    80005322:	00000097          	auipc	ra,0x0
    80005326:	c58080e7          	jalr	-936(ra) # 80004f7a <flags2perm>
    8000532a:	86aa                	mv	a3,a0
    8000532c:	8626                	mv	a2,s1
    8000532e:	85ca                	mv	a1,s2
    80005330:	855a                	mv	a0,s6
    80005332:	ffffc097          	auipc	ra,0xffffc
    80005336:	0de080e7          	jalr	222(ra) # 80001410 <uvmalloc>
    8000533a:	dea43c23          	sd	a0,-520(s0)
    8000533e:	d939                	beqz	a0,80005294 <exec+0x2fe>
    80005340:	e2843c03          	ld	s8,-472(s0)
    80005344:	e2042c83          	lw	s9,-480(s0)
    80005348:	e3842b83          	lw	s7,-456(s0)
    8000534c:	f60b83e3          	beqz	s7,800052b2 <exec+0x31c>
    80005350:	89de                	mv	s3,s7
    80005352:	4481                	li	s1,0
    80005354:	bb95                	j	800050c8 <exec+0x132>

0000000080005356 <argfd>:
    80005356:	7179                	addi	sp,sp,-48
    80005358:	f406                	sd	ra,40(sp)
    8000535a:	f022                	sd	s0,32(sp)
    8000535c:	ec26                	sd	s1,24(sp)
    8000535e:	e84a                	sd	s2,16(sp)
    80005360:	1800                	addi	s0,sp,48
    80005362:	892e                	mv	s2,a1
    80005364:	84b2                	mv	s1,a2
    80005366:	fdc40593          	addi	a1,s0,-36
    8000536a:	ffffe097          	auipc	ra,0xffffe
    8000536e:	b8e080e7          	jalr	-1138(ra) # 80002ef8 <argint>
    80005372:	fdc42703          	lw	a4,-36(s0)
    80005376:	47bd                	li	a5,15
    80005378:	02e7eb63          	bltu	a5,a4,800053ae <argfd+0x58>
    8000537c:	ffffc097          	auipc	ra,0xffffc
    80005380:	630080e7          	jalr	1584(ra) # 800019ac <myproc>
    80005384:	fdc42703          	lw	a4,-36(s0)
    80005388:	01a70793          	addi	a5,a4,26
    8000538c:	078e                	slli	a5,a5,0x3
    8000538e:	953e                	add	a0,a0,a5
    80005390:	611c                	ld	a5,0(a0)
    80005392:	c385                	beqz	a5,800053b2 <argfd+0x5c>
    80005394:	00090463          	beqz	s2,8000539c <argfd+0x46>
    80005398:	00e92023          	sw	a4,0(s2)
    8000539c:	4501                	li	a0,0
    8000539e:	c091                	beqz	s1,800053a2 <argfd+0x4c>
    800053a0:	e09c                	sd	a5,0(s1)
    800053a2:	70a2                	ld	ra,40(sp)
    800053a4:	7402                	ld	s0,32(sp)
    800053a6:	64e2                	ld	s1,24(sp)
    800053a8:	6942                	ld	s2,16(sp)
    800053aa:	6145                	addi	sp,sp,48
    800053ac:	8082                	ret
    800053ae:	557d                	li	a0,-1
    800053b0:	bfcd                	j	800053a2 <argfd+0x4c>
    800053b2:	557d                	li	a0,-1
    800053b4:	b7fd                	j	800053a2 <argfd+0x4c>

00000000800053b6 <fdalloc>:
    800053b6:	1101                	addi	sp,sp,-32
    800053b8:	ec06                	sd	ra,24(sp)
    800053ba:	e822                	sd	s0,16(sp)
    800053bc:	e426                	sd	s1,8(sp)
    800053be:	1000                	addi	s0,sp,32
    800053c0:	84aa                	mv	s1,a0
    800053c2:	ffffc097          	auipc	ra,0xffffc
    800053c6:	5ea080e7          	jalr	1514(ra) # 800019ac <myproc>
    800053ca:	862a                	mv	a2,a0
    800053cc:	0d050793          	addi	a5,a0,208
    800053d0:	4501                	li	a0,0
    800053d2:	46c1                	li	a3,16
    800053d4:	6398                	ld	a4,0(a5)
    800053d6:	cb19                	beqz	a4,800053ec <fdalloc+0x36>
    800053d8:	2505                	addiw	a0,a0,1
    800053da:	07a1                	addi	a5,a5,8
    800053dc:	fed51ce3          	bne	a0,a3,800053d4 <fdalloc+0x1e>
    800053e0:	557d                	li	a0,-1
    800053e2:	60e2                	ld	ra,24(sp)
    800053e4:	6442                	ld	s0,16(sp)
    800053e6:	64a2                	ld	s1,8(sp)
    800053e8:	6105                	addi	sp,sp,32
    800053ea:	8082                	ret
    800053ec:	01a50793          	addi	a5,a0,26
    800053f0:	078e                	slli	a5,a5,0x3
    800053f2:	963e                	add	a2,a2,a5
    800053f4:	e204                	sd	s1,0(a2)
    800053f6:	b7f5                	j	800053e2 <fdalloc+0x2c>

00000000800053f8 <create>:
    800053f8:	715d                	addi	sp,sp,-80
    800053fa:	e486                	sd	ra,72(sp)
    800053fc:	e0a2                	sd	s0,64(sp)
    800053fe:	fc26                	sd	s1,56(sp)
    80005400:	f84a                	sd	s2,48(sp)
    80005402:	f44e                	sd	s3,40(sp)
    80005404:	f052                	sd	s4,32(sp)
    80005406:	ec56                	sd	s5,24(sp)
    80005408:	e85a                	sd	s6,16(sp)
    8000540a:	0880                	addi	s0,sp,80
    8000540c:	8b2e                	mv	s6,a1
    8000540e:	89b2                	mv	s3,a2
    80005410:	8936                	mv	s2,a3
    80005412:	fb040593          	addi	a1,s0,-80
    80005416:	fffff097          	auipc	ra,0xfffff
    8000541a:	e3c080e7          	jalr	-452(ra) # 80004252 <nameiparent>
    8000541e:	84aa                	mv	s1,a0
    80005420:	14050f63          	beqz	a0,8000557e <create+0x186>
    80005424:	ffffe097          	auipc	ra,0xffffe
    80005428:	66a080e7          	jalr	1642(ra) # 80003a8e <ilock>
    8000542c:	4601                	li	a2,0
    8000542e:	fb040593          	addi	a1,s0,-80
    80005432:	8526                	mv	a0,s1
    80005434:	fffff097          	auipc	ra,0xfffff
    80005438:	b3e080e7          	jalr	-1218(ra) # 80003f72 <dirlookup>
    8000543c:	8aaa                	mv	s5,a0
    8000543e:	c931                	beqz	a0,80005492 <create+0x9a>
    80005440:	8526                	mv	a0,s1
    80005442:	fffff097          	auipc	ra,0xfffff
    80005446:	8ae080e7          	jalr	-1874(ra) # 80003cf0 <iunlockput>
    8000544a:	8556                	mv	a0,s5
    8000544c:	ffffe097          	auipc	ra,0xffffe
    80005450:	642080e7          	jalr	1602(ra) # 80003a8e <ilock>
    80005454:	000b059b          	sext.w	a1,s6
    80005458:	4789                	li	a5,2
    8000545a:	02f59563          	bne	a1,a5,80005484 <create+0x8c>
    8000545e:	044ad783          	lhu	a5,68(s5) # fffffffffffff044 <end+0xffffffff7ffdd2b4>
    80005462:	37f9                	addiw	a5,a5,-2
    80005464:	17c2                	slli	a5,a5,0x30
    80005466:	93c1                	srli	a5,a5,0x30
    80005468:	4705                	li	a4,1
    8000546a:	00f76d63          	bltu	a4,a5,80005484 <create+0x8c>
    8000546e:	8556                	mv	a0,s5
    80005470:	60a6                	ld	ra,72(sp)
    80005472:	6406                	ld	s0,64(sp)
    80005474:	74e2                	ld	s1,56(sp)
    80005476:	7942                	ld	s2,48(sp)
    80005478:	79a2                	ld	s3,40(sp)
    8000547a:	7a02                	ld	s4,32(sp)
    8000547c:	6ae2                	ld	s5,24(sp)
    8000547e:	6b42                	ld	s6,16(sp)
    80005480:	6161                	addi	sp,sp,80
    80005482:	8082                	ret
    80005484:	8556                	mv	a0,s5
    80005486:	fffff097          	auipc	ra,0xfffff
    8000548a:	86a080e7          	jalr	-1942(ra) # 80003cf0 <iunlockput>
    8000548e:	4a81                	li	s5,0
    80005490:	bff9                	j	8000546e <create+0x76>
    80005492:	85da                	mv	a1,s6
    80005494:	4088                	lw	a0,0(s1)
    80005496:	ffffe097          	auipc	ra,0xffffe
    8000549a:	45c080e7          	jalr	1116(ra) # 800038f2 <ialloc>
    8000549e:	8a2a                	mv	s4,a0
    800054a0:	c539                	beqz	a0,800054ee <create+0xf6>
    800054a2:	ffffe097          	auipc	ra,0xffffe
    800054a6:	5ec080e7          	jalr	1516(ra) # 80003a8e <ilock>
    800054aa:	053a1323          	sh	s3,70(s4)
    800054ae:	052a1423          	sh	s2,72(s4)
    800054b2:	4905                	li	s2,1
    800054b4:	052a1523          	sh	s2,74(s4)
    800054b8:	8552                	mv	a0,s4
    800054ba:	ffffe097          	auipc	ra,0xffffe
    800054be:	50a080e7          	jalr	1290(ra) # 800039c4 <iupdate>
    800054c2:	000b059b          	sext.w	a1,s6
    800054c6:	03258b63          	beq	a1,s2,800054fc <create+0x104>
    800054ca:	004a2603          	lw	a2,4(s4)
    800054ce:	fb040593          	addi	a1,s0,-80
    800054d2:	8526                	mv	a0,s1
    800054d4:	fffff097          	auipc	ra,0xfffff
    800054d8:	cae080e7          	jalr	-850(ra) # 80004182 <dirlink>
    800054dc:	06054f63          	bltz	a0,8000555a <create+0x162>
    800054e0:	8526                	mv	a0,s1
    800054e2:	fffff097          	auipc	ra,0xfffff
    800054e6:	80e080e7          	jalr	-2034(ra) # 80003cf0 <iunlockput>
    800054ea:	8ad2                	mv	s5,s4
    800054ec:	b749                	j	8000546e <create+0x76>
    800054ee:	8526                	mv	a0,s1
    800054f0:	fffff097          	auipc	ra,0xfffff
    800054f4:	800080e7          	jalr	-2048(ra) # 80003cf0 <iunlockput>
    800054f8:	8ad2                	mv	s5,s4
    800054fa:	bf95                	j	8000546e <create+0x76>
    800054fc:	004a2603          	lw	a2,4(s4)
    80005500:	00003597          	auipc	a1,0x3
    80005504:	24058593          	addi	a1,a1,576 # 80008740 <syscalls+0x2a8>
    80005508:	8552                	mv	a0,s4
    8000550a:	fffff097          	auipc	ra,0xfffff
    8000550e:	c78080e7          	jalr	-904(ra) # 80004182 <dirlink>
    80005512:	04054463          	bltz	a0,8000555a <create+0x162>
    80005516:	40d0                	lw	a2,4(s1)
    80005518:	00003597          	auipc	a1,0x3
    8000551c:	23058593          	addi	a1,a1,560 # 80008748 <syscalls+0x2b0>
    80005520:	8552                	mv	a0,s4
    80005522:	fffff097          	auipc	ra,0xfffff
    80005526:	c60080e7          	jalr	-928(ra) # 80004182 <dirlink>
    8000552a:	02054863          	bltz	a0,8000555a <create+0x162>
    8000552e:	004a2603          	lw	a2,4(s4)
    80005532:	fb040593          	addi	a1,s0,-80
    80005536:	8526                	mv	a0,s1
    80005538:	fffff097          	auipc	ra,0xfffff
    8000553c:	c4a080e7          	jalr	-950(ra) # 80004182 <dirlink>
    80005540:	00054d63          	bltz	a0,8000555a <create+0x162>
    80005544:	04a4d783          	lhu	a5,74(s1)
    80005548:	2785                	addiw	a5,a5,1
    8000554a:	04f49523          	sh	a5,74(s1)
    8000554e:	8526                	mv	a0,s1
    80005550:	ffffe097          	auipc	ra,0xffffe
    80005554:	474080e7          	jalr	1140(ra) # 800039c4 <iupdate>
    80005558:	b761                	j	800054e0 <create+0xe8>
    8000555a:	040a1523          	sh	zero,74(s4)
    8000555e:	8552                	mv	a0,s4
    80005560:	ffffe097          	auipc	ra,0xffffe
    80005564:	464080e7          	jalr	1124(ra) # 800039c4 <iupdate>
    80005568:	8552                	mv	a0,s4
    8000556a:	ffffe097          	auipc	ra,0xffffe
    8000556e:	786080e7          	jalr	1926(ra) # 80003cf0 <iunlockput>
    80005572:	8526                	mv	a0,s1
    80005574:	ffffe097          	auipc	ra,0xffffe
    80005578:	77c080e7          	jalr	1916(ra) # 80003cf0 <iunlockput>
    8000557c:	bdcd                	j	8000546e <create+0x76>
    8000557e:	8aaa                	mv	s5,a0
    80005580:	b5fd                	j	8000546e <create+0x76>

0000000080005582 <sys_dup>:
    80005582:	7179                	addi	sp,sp,-48
    80005584:	f406                	sd	ra,40(sp)
    80005586:	f022                	sd	s0,32(sp)
    80005588:	ec26                	sd	s1,24(sp)
    8000558a:	1800                	addi	s0,sp,48
    8000558c:	fd840613          	addi	a2,s0,-40
    80005590:	4581                	li	a1,0
    80005592:	4501                	li	a0,0
    80005594:	00000097          	auipc	ra,0x0
    80005598:	dc2080e7          	jalr	-574(ra) # 80005356 <argfd>
    8000559c:	57fd                	li	a5,-1
    8000559e:	02054363          	bltz	a0,800055c4 <sys_dup+0x42>
    800055a2:	fd843503          	ld	a0,-40(s0)
    800055a6:	00000097          	auipc	ra,0x0
    800055aa:	e10080e7          	jalr	-496(ra) # 800053b6 <fdalloc>
    800055ae:	84aa                	mv	s1,a0
    800055b0:	57fd                	li	a5,-1
    800055b2:	00054963          	bltz	a0,800055c4 <sys_dup+0x42>
    800055b6:	fd843503          	ld	a0,-40(s0)
    800055ba:	fffff097          	auipc	ra,0xfffff
    800055be:	310080e7          	jalr	784(ra) # 800048ca <filedup>
    800055c2:	87a6                	mv	a5,s1
    800055c4:	853e                	mv	a0,a5
    800055c6:	70a2                	ld	ra,40(sp)
    800055c8:	7402                	ld	s0,32(sp)
    800055ca:	64e2                	ld	s1,24(sp)
    800055cc:	6145                	addi	sp,sp,48
    800055ce:	8082                	ret

00000000800055d0 <sys_read>:
    800055d0:	7179                	addi	sp,sp,-48
    800055d2:	f406                	sd	ra,40(sp)
    800055d4:	f022                	sd	s0,32(sp)
    800055d6:	1800                	addi	s0,sp,48
    800055d8:	fd840593          	addi	a1,s0,-40
    800055dc:	4505                	li	a0,1
    800055de:	ffffe097          	auipc	ra,0xffffe
    800055e2:	93a080e7          	jalr	-1734(ra) # 80002f18 <argaddr>
    800055e6:	fe440593          	addi	a1,s0,-28
    800055ea:	4509                	li	a0,2
    800055ec:	ffffe097          	auipc	ra,0xffffe
    800055f0:	90c080e7          	jalr	-1780(ra) # 80002ef8 <argint>
    800055f4:	fe840613          	addi	a2,s0,-24
    800055f8:	4581                	li	a1,0
    800055fa:	4501                	li	a0,0
    800055fc:	00000097          	auipc	ra,0x0
    80005600:	d5a080e7          	jalr	-678(ra) # 80005356 <argfd>
    80005604:	87aa                	mv	a5,a0
    80005606:	557d                	li	a0,-1
    80005608:	0007cc63          	bltz	a5,80005620 <sys_read+0x50>
    8000560c:	fe442603          	lw	a2,-28(s0)
    80005610:	fd843583          	ld	a1,-40(s0)
    80005614:	fe843503          	ld	a0,-24(s0)
    80005618:	fffff097          	auipc	ra,0xfffff
    8000561c:	43e080e7          	jalr	1086(ra) # 80004a56 <fileread>
    80005620:	70a2                	ld	ra,40(sp)
    80005622:	7402                	ld	s0,32(sp)
    80005624:	6145                	addi	sp,sp,48
    80005626:	8082                	ret

0000000080005628 <sys_write>:
    80005628:	7179                	addi	sp,sp,-48
    8000562a:	f406                	sd	ra,40(sp)
    8000562c:	f022                	sd	s0,32(sp)
    8000562e:	1800                	addi	s0,sp,48
    80005630:	fd840593          	addi	a1,s0,-40
    80005634:	4505                	li	a0,1
    80005636:	ffffe097          	auipc	ra,0xffffe
    8000563a:	8e2080e7          	jalr	-1822(ra) # 80002f18 <argaddr>
    8000563e:	fe440593          	addi	a1,s0,-28
    80005642:	4509                	li	a0,2
    80005644:	ffffe097          	auipc	ra,0xffffe
    80005648:	8b4080e7          	jalr	-1868(ra) # 80002ef8 <argint>
    8000564c:	fe840613          	addi	a2,s0,-24
    80005650:	4581                	li	a1,0
    80005652:	4501                	li	a0,0
    80005654:	00000097          	auipc	ra,0x0
    80005658:	d02080e7          	jalr	-766(ra) # 80005356 <argfd>
    8000565c:	87aa                	mv	a5,a0
    8000565e:	557d                	li	a0,-1
    80005660:	0007cc63          	bltz	a5,80005678 <sys_write+0x50>
    80005664:	fe442603          	lw	a2,-28(s0)
    80005668:	fd843583          	ld	a1,-40(s0)
    8000566c:	fe843503          	ld	a0,-24(s0)
    80005670:	fffff097          	auipc	ra,0xfffff
    80005674:	4a8080e7          	jalr	1192(ra) # 80004b18 <filewrite>
    80005678:	70a2                	ld	ra,40(sp)
    8000567a:	7402                	ld	s0,32(sp)
    8000567c:	6145                	addi	sp,sp,48
    8000567e:	8082                	ret

0000000080005680 <sys_close>:
    80005680:	1101                	addi	sp,sp,-32
    80005682:	ec06                	sd	ra,24(sp)
    80005684:	e822                	sd	s0,16(sp)
    80005686:	1000                	addi	s0,sp,32
    80005688:	fe040613          	addi	a2,s0,-32
    8000568c:	fec40593          	addi	a1,s0,-20
    80005690:	4501                	li	a0,0
    80005692:	00000097          	auipc	ra,0x0
    80005696:	cc4080e7          	jalr	-828(ra) # 80005356 <argfd>
    8000569a:	57fd                	li	a5,-1
    8000569c:	02054463          	bltz	a0,800056c4 <sys_close+0x44>
    800056a0:	ffffc097          	auipc	ra,0xffffc
    800056a4:	30c080e7          	jalr	780(ra) # 800019ac <myproc>
    800056a8:	fec42783          	lw	a5,-20(s0)
    800056ac:	07e9                	addi	a5,a5,26
    800056ae:	078e                	slli	a5,a5,0x3
    800056b0:	97aa                	add	a5,a5,a0
    800056b2:	0007b023          	sd	zero,0(a5)
    800056b6:	fe043503          	ld	a0,-32(s0)
    800056ba:	fffff097          	auipc	ra,0xfffff
    800056be:	262080e7          	jalr	610(ra) # 8000491c <fileclose>
    800056c2:	4781                	li	a5,0
    800056c4:	853e                	mv	a0,a5
    800056c6:	60e2                	ld	ra,24(sp)
    800056c8:	6442                	ld	s0,16(sp)
    800056ca:	6105                	addi	sp,sp,32
    800056cc:	8082                	ret

00000000800056ce <sys_fstat>:
    800056ce:	1101                	addi	sp,sp,-32
    800056d0:	ec06                	sd	ra,24(sp)
    800056d2:	e822                	sd	s0,16(sp)
    800056d4:	1000                	addi	s0,sp,32
    800056d6:	fe040593          	addi	a1,s0,-32
    800056da:	4505                	li	a0,1
    800056dc:	ffffe097          	auipc	ra,0xffffe
    800056e0:	83c080e7          	jalr	-1988(ra) # 80002f18 <argaddr>
    800056e4:	fe840613          	addi	a2,s0,-24
    800056e8:	4581                	li	a1,0
    800056ea:	4501                	li	a0,0
    800056ec:	00000097          	auipc	ra,0x0
    800056f0:	c6a080e7          	jalr	-918(ra) # 80005356 <argfd>
    800056f4:	87aa                	mv	a5,a0
    800056f6:	557d                	li	a0,-1
    800056f8:	0007ca63          	bltz	a5,8000570c <sys_fstat+0x3e>
    800056fc:	fe043583          	ld	a1,-32(s0)
    80005700:	fe843503          	ld	a0,-24(s0)
    80005704:	fffff097          	auipc	ra,0xfffff
    80005708:	2e0080e7          	jalr	736(ra) # 800049e4 <filestat>
    8000570c:	60e2                	ld	ra,24(sp)
    8000570e:	6442                	ld	s0,16(sp)
    80005710:	6105                	addi	sp,sp,32
    80005712:	8082                	ret

0000000080005714 <sys_link>:
    80005714:	7169                	addi	sp,sp,-304
    80005716:	f606                	sd	ra,296(sp)
    80005718:	f222                	sd	s0,288(sp)
    8000571a:	ee26                	sd	s1,280(sp)
    8000571c:	ea4a                	sd	s2,272(sp)
    8000571e:	1a00                	addi	s0,sp,304
    80005720:	08000613          	li	a2,128
    80005724:	ed040593          	addi	a1,s0,-304
    80005728:	4501                	li	a0,0
    8000572a:	ffffe097          	auipc	ra,0xffffe
    8000572e:	80e080e7          	jalr	-2034(ra) # 80002f38 <argstr>
    80005732:	57fd                	li	a5,-1
    80005734:	10054e63          	bltz	a0,80005850 <sys_link+0x13c>
    80005738:	08000613          	li	a2,128
    8000573c:	f5040593          	addi	a1,s0,-176
    80005740:	4505                	li	a0,1
    80005742:	ffffd097          	auipc	ra,0xffffd
    80005746:	7f6080e7          	jalr	2038(ra) # 80002f38 <argstr>
    8000574a:	57fd                	li	a5,-1
    8000574c:	10054263          	bltz	a0,80005850 <sys_link+0x13c>
    80005750:	fffff097          	auipc	ra,0xfffff
    80005754:	d00080e7          	jalr	-768(ra) # 80004450 <begin_op>
    80005758:	ed040513          	addi	a0,s0,-304
    8000575c:	fffff097          	auipc	ra,0xfffff
    80005760:	ad8080e7          	jalr	-1320(ra) # 80004234 <namei>
    80005764:	84aa                	mv	s1,a0
    80005766:	c551                	beqz	a0,800057f2 <sys_link+0xde>
    80005768:	ffffe097          	auipc	ra,0xffffe
    8000576c:	326080e7          	jalr	806(ra) # 80003a8e <ilock>
    80005770:	04449703          	lh	a4,68(s1)
    80005774:	4785                	li	a5,1
    80005776:	08f70463          	beq	a4,a5,800057fe <sys_link+0xea>
    8000577a:	04a4d783          	lhu	a5,74(s1)
    8000577e:	2785                	addiw	a5,a5,1
    80005780:	04f49523          	sh	a5,74(s1)
    80005784:	8526                	mv	a0,s1
    80005786:	ffffe097          	auipc	ra,0xffffe
    8000578a:	23e080e7          	jalr	574(ra) # 800039c4 <iupdate>
    8000578e:	8526                	mv	a0,s1
    80005790:	ffffe097          	auipc	ra,0xffffe
    80005794:	3c0080e7          	jalr	960(ra) # 80003b50 <iunlock>
    80005798:	fd040593          	addi	a1,s0,-48
    8000579c:	f5040513          	addi	a0,s0,-176
    800057a0:	fffff097          	auipc	ra,0xfffff
    800057a4:	ab2080e7          	jalr	-1358(ra) # 80004252 <nameiparent>
    800057a8:	892a                	mv	s2,a0
    800057aa:	c935                	beqz	a0,8000581e <sys_link+0x10a>
    800057ac:	ffffe097          	auipc	ra,0xffffe
    800057b0:	2e2080e7          	jalr	738(ra) # 80003a8e <ilock>
    800057b4:	00092703          	lw	a4,0(s2)
    800057b8:	409c                	lw	a5,0(s1)
    800057ba:	04f71d63          	bne	a4,a5,80005814 <sys_link+0x100>
    800057be:	40d0                	lw	a2,4(s1)
    800057c0:	fd040593          	addi	a1,s0,-48
    800057c4:	854a                	mv	a0,s2
    800057c6:	fffff097          	auipc	ra,0xfffff
    800057ca:	9bc080e7          	jalr	-1604(ra) # 80004182 <dirlink>
    800057ce:	04054363          	bltz	a0,80005814 <sys_link+0x100>
    800057d2:	854a                	mv	a0,s2
    800057d4:	ffffe097          	auipc	ra,0xffffe
    800057d8:	51c080e7          	jalr	1308(ra) # 80003cf0 <iunlockput>
    800057dc:	8526                	mv	a0,s1
    800057de:	ffffe097          	auipc	ra,0xffffe
    800057e2:	46a080e7          	jalr	1130(ra) # 80003c48 <iput>
    800057e6:	fffff097          	auipc	ra,0xfffff
    800057ea:	cea080e7          	jalr	-790(ra) # 800044d0 <end_op>
    800057ee:	4781                	li	a5,0
    800057f0:	a085                	j	80005850 <sys_link+0x13c>
    800057f2:	fffff097          	auipc	ra,0xfffff
    800057f6:	cde080e7          	jalr	-802(ra) # 800044d0 <end_op>
    800057fa:	57fd                	li	a5,-1
    800057fc:	a891                	j	80005850 <sys_link+0x13c>
    800057fe:	8526                	mv	a0,s1
    80005800:	ffffe097          	auipc	ra,0xffffe
    80005804:	4f0080e7          	jalr	1264(ra) # 80003cf0 <iunlockput>
    80005808:	fffff097          	auipc	ra,0xfffff
    8000580c:	cc8080e7          	jalr	-824(ra) # 800044d0 <end_op>
    80005810:	57fd                	li	a5,-1
    80005812:	a83d                	j	80005850 <sys_link+0x13c>
    80005814:	854a                	mv	a0,s2
    80005816:	ffffe097          	auipc	ra,0xffffe
    8000581a:	4da080e7          	jalr	1242(ra) # 80003cf0 <iunlockput>
    8000581e:	8526                	mv	a0,s1
    80005820:	ffffe097          	auipc	ra,0xffffe
    80005824:	26e080e7          	jalr	622(ra) # 80003a8e <ilock>
    80005828:	04a4d783          	lhu	a5,74(s1)
    8000582c:	37fd                	addiw	a5,a5,-1
    8000582e:	04f49523          	sh	a5,74(s1)
    80005832:	8526                	mv	a0,s1
    80005834:	ffffe097          	auipc	ra,0xffffe
    80005838:	190080e7          	jalr	400(ra) # 800039c4 <iupdate>
    8000583c:	8526                	mv	a0,s1
    8000583e:	ffffe097          	auipc	ra,0xffffe
    80005842:	4b2080e7          	jalr	1202(ra) # 80003cf0 <iunlockput>
    80005846:	fffff097          	auipc	ra,0xfffff
    8000584a:	c8a080e7          	jalr	-886(ra) # 800044d0 <end_op>
    8000584e:	57fd                	li	a5,-1
    80005850:	853e                	mv	a0,a5
    80005852:	70b2                	ld	ra,296(sp)
    80005854:	7412                	ld	s0,288(sp)
    80005856:	64f2                	ld	s1,280(sp)
    80005858:	6952                	ld	s2,272(sp)
    8000585a:	6155                	addi	sp,sp,304
    8000585c:	8082                	ret

000000008000585e <sys_unlink>:
    8000585e:	7151                	addi	sp,sp,-240
    80005860:	f586                	sd	ra,232(sp)
    80005862:	f1a2                	sd	s0,224(sp)
    80005864:	eda6                	sd	s1,216(sp)
    80005866:	e9ca                	sd	s2,208(sp)
    80005868:	e5ce                	sd	s3,200(sp)
    8000586a:	1980                	addi	s0,sp,240
    8000586c:	08000613          	li	a2,128
    80005870:	f3040593          	addi	a1,s0,-208
    80005874:	4501                	li	a0,0
    80005876:	ffffd097          	auipc	ra,0xffffd
    8000587a:	6c2080e7          	jalr	1730(ra) # 80002f38 <argstr>
    8000587e:	18054163          	bltz	a0,80005a00 <sys_unlink+0x1a2>
    80005882:	fffff097          	auipc	ra,0xfffff
    80005886:	bce080e7          	jalr	-1074(ra) # 80004450 <begin_op>
    8000588a:	fb040593          	addi	a1,s0,-80
    8000588e:	f3040513          	addi	a0,s0,-208
    80005892:	fffff097          	auipc	ra,0xfffff
    80005896:	9c0080e7          	jalr	-1600(ra) # 80004252 <nameiparent>
    8000589a:	84aa                	mv	s1,a0
    8000589c:	c979                	beqz	a0,80005972 <sys_unlink+0x114>
    8000589e:	ffffe097          	auipc	ra,0xffffe
    800058a2:	1f0080e7          	jalr	496(ra) # 80003a8e <ilock>
    800058a6:	00003597          	auipc	a1,0x3
    800058aa:	e9a58593          	addi	a1,a1,-358 # 80008740 <syscalls+0x2a8>
    800058ae:	fb040513          	addi	a0,s0,-80
    800058b2:	ffffe097          	auipc	ra,0xffffe
    800058b6:	6a6080e7          	jalr	1702(ra) # 80003f58 <namecmp>
    800058ba:	14050a63          	beqz	a0,80005a0e <sys_unlink+0x1b0>
    800058be:	00003597          	auipc	a1,0x3
    800058c2:	e8a58593          	addi	a1,a1,-374 # 80008748 <syscalls+0x2b0>
    800058c6:	fb040513          	addi	a0,s0,-80
    800058ca:	ffffe097          	auipc	ra,0xffffe
    800058ce:	68e080e7          	jalr	1678(ra) # 80003f58 <namecmp>
    800058d2:	12050e63          	beqz	a0,80005a0e <sys_unlink+0x1b0>
    800058d6:	f2c40613          	addi	a2,s0,-212
    800058da:	fb040593          	addi	a1,s0,-80
    800058de:	8526                	mv	a0,s1
    800058e0:	ffffe097          	auipc	ra,0xffffe
    800058e4:	692080e7          	jalr	1682(ra) # 80003f72 <dirlookup>
    800058e8:	892a                	mv	s2,a0
    800058ea:	12050263          	beqz	a0,80005a0e <sys_unlink+0x1b0>
    800058ee:	ffffe097          	auipc	ra,0xffffe
    800058f2:	1a0080e7          	jalr	416(ra) # 80003a8e <ilock>
    800058f6:	04a91783          	lh	a5,74(s2)
    800058fa:	08f05263          	blez	a5,8000597e <sys_unlink+0x120>
    800058fe:	04491703          	lh	a4,68(s2)
    80005902:	4785                	li	a5,1
    80005904:	08f70563          	beq	a4,a5,8000598e <sys_unlink+0x130>
    80005908:	4641                	li	a2,16
    8000590a:	4581                	li	a1,0
    8000590c:	fc040513          	addi	a0,s0,-64
    80005910:	ffffb097          	auipc	ra,0xffffb
    80005914:	3c2080e7          	jalr	962(ra) # 80000cd2 <memset>
    80005918:	4741                	li	a4,16
    8000591a:	f2c42683          	lw	a3,-212(s0)
    8000591e:	fc040613          	addi	a2,s0,-64
    80005922:	4581                	li	a1,0
    80005924:	8526                	mv	a0,s1
    80005926:	ffffe097          	auipc	ra,0xffffe
    8000592a:	514080e7          	jalr	1300(ra) # 80003e3a <writei>
    8000592e:	47c1                	li	a5,16
    80005930:	0af51563          	bne	a0,a5,800059da <sys_unlink+0x17c>
    80005934:	04491703          	lh	a4,68(s2)
    80005938:	4785                	li	a5,1
    8000593a:	0af70863          	beq	a4,a5,800059ea <sys_unlink+0x18c>
    8000593e:	8526                	mv	a0,s1
    80005940:	ffffe097          	auipc	ra,0xffffe
    80005944:	3b0080e7          	jalr	944(ra) # 80003cf0 <iunlockput>
    80005948:	04a95783          	lhu	a5,74(s2)
    8000594c:	37fd                	addiw	a5,a5,-1
    8000594e:	04f91523          	sh	a5,74(s2)
    80005952:	854a                	mv	a0,s2
    80005954:	ffffe097          	auipc	ra,0xffffe
    80005958:	070080e7          	jalr	112(ra) # 800039c4 <iupdate>
    8000595c:	854a                	mv	a0,s2
    8000595e:	ffffe097          	auipc	ra,0xffffe
    80005962:	392080e7          	jalr	914(ra) # 80003cf0 <iunlockput>
    80005966:	fffff097          	auipc	ra,0xfffff
    8000596a:	b6a080e7          	jalr	-1174(ra) # 800044d0 <end_op>
    8000596e:	4501                	li	a0,0
    80005970:	a84d                	j	80005a22 <sys_unlink+0x1c4>
    80005972:	fffff097          	auipc	ra,0xfffff
    80005976:	b5e080e7          	jalr	-1186(ra) # 800044d0 <end_op>
    8000597a:	557d                	li	a0,-1
    8000597c:	a05d                	j	80005a22 <sys_unlink+0x1c4>
    8000597e:	00003517          	auipc	a0,0x3
    80005982:	dd250513          	addi	a0,a0,-558 # 80008750 <syscalls+0x2b8>
    80005986:	ffffb097          	auipc	ra,0xffffb
    8000598a:	bb8080e7          	jalr	-1096(ra) # 8000053e <panic>
    8000598e:	04c92703          	lw	a4,76(s2)
    80005992:	02000793          	li	a5,32
    80005996:	f6e7f9e3          	bgeu	a5,a4,80005908 <sys_unlink+0xaa>
    8000599a:	02000993          	li	s3,32
    8000599e:	4741                	li	a4,16
    800059a0:	86ce                	mv	a3,s3
    800059a2:	f1840613          	addi	a2,s0,-232
    800059a6:	4581                	li	a1,0
    800059a8:	854a                	mv	a0,s2
    800059aa:	ffffe097          	auipc	ra,0xffffe
    800059ae:	398080e7          	jalr	920(ra) # 80003d42 <readi>
    800059b2:	47c1                	li	a5,16
    800059b4:	00f51b63          	bne	a0,a5,800059ca <sys_unlink+0x16c>
    800059b8:	f1845783          	lhu	a5,-232(s0)
    800059bc:	e7a1                	bnez	a5,80005a04 <sys_unlink+0x1a6>
    800059be:	29c1                	addiw	s3,s3,16
    800059c0:	04c92783          	lw	a5,76(s2)
    800059c4:	fcf9ede3          	bltu	s3,a5,8000599e <sys_unlink+0x140>
    800059c8:	b781                	j	80005908 <sys_unlink+0xaa>
    800059ca:	00003517          	auipc	a0,0x3
    800059ce:	d9e50513          	addi	a0,a0,-610 # 80008768 <syscalls+0x2d0>
    800059d2:	ffffb097          	auipc	ra,0xffffb
    800059d6:	b6c080e7          	jalr	-1172(ra) # 8000053e <panic>
    800059da:	00003517          	auipc	a0,0x3
    800059de:	da650513          	addi	a0,a0,-602 # 80008780 <syscalls+0x2e8>
    800059e2:	ffffb097          	auipc	ra,0xffffb
    800059e6:	b5c080e7          	jalr	-1188(ra) # 8000053e <panic>
    800059ea:	04a4d783          	lhu	a5,74(s1)
    800059ee:	37fd                	addiw	a5,a5,-1
    800059f0:	04f49523          	sh	a5,74(s1)
    800059f4:	8526                	mv	a0,s1
    800059f6:	ffffe097          	auipc	ra,0xffffe
    800059fa:	fce080e7          	jalr	-50(ra) # 800039c4 <iupdate>
    800059fe:	b781                	j	8000593e <sys_unlink+0xe0>
    80005a00:	557d                	li	a0,-1
    80005a02:	a005                	j	80005a22 <sys_unlink+0x1c4>
    80005a04:	854a                	mv	a0,s2
    80005a06:	ffffe097          	auipc	ra,0xffffe
    80005a0a:	2ea080e7          	jalr	746(ra) # 80003cf0 <iunlockput>
    80005a0e:	8526                	mv	a0,s1
    80005a10:	ffffe097          	auipc	ra,0xffffe
    80005a14:	2e0080e7          	jalr	736(ra) # 80003cf0 <iunlockput>
    80005a18:	fffff097          	auipc	ra,0xfffff
    80005a1c:	ab8080e7          	jalr	-1352(ra) # 800044d0 <end_op>
    80005a20:	557d                	li	a0,-1
    80005a22:	70ae                	ld	ra,232(sp)
    80005a24:	740e                	ld	s0,224(sp)
    80005a26:	64ee                	ld	s1,216(sp)
    80005a28:	694e                	ld	s2,208(sp)
    80005a2a:	69ae                	ld	s3,200(sp)
    80005a2c:	616d                	addi	sp,sp,240
    80005a2e:	8082                	ret

0000000080005a30 <sys_open>:
    80005a30:	7131                	addi	sp,sp,-192
    80005a32:	fd06                	sd	ra,184(sp)
    80005a34:	f922                	sd	s0,176(sp)
    80005a36:	f526                	sd	s1,168(sp)
    80005a38:	f14a                	sd	s2,160(sp)
    80005a3a:	ed4e                	sd	s3,152(sp)
    80005a3c:	0180                	addi	s0,sp,192
    80005a3e:	f4c40593          	addi	a1,s0,-180
    80005a42:	4505                	li	a0,1
    80005a44:	ffffd097          	auipc	ra,0xffffd
    80005a48:	4b4080e7          	jalr	1204(ra) # 80002ef8 <argint>
    80005a4c:	08000613          	li	a2,128
    80005a50:	f5040593          	addi	a1,s0,-176
    80005a54:	4501                	li	a0,0
    80005a56:	ffffd097          	auipc	ra,0xffffd
    80005a5a:	4e2080e7          	jalr	1250(ra) # 80002f38 <argstr>
    80005a5e:	87aa                	mv	a5,a0
    80005a60:	557d                	li	a0,-1
    80005a62:	0a07c963          	bltz	a5,80005b14 <sys_open+0xe4>
    80005a66:	fffff097          	auipc	ra,0xfffff
    80005a6a:	9ea080e7          	jalr	-1558(ra) # 80004450 <begin_op>
    80005a6e:	f4c42783          	lw	a5,-180(s0)
    80005a72:	2007f793          	andi	a5,a5,512
    80005a76:	cfc5                	beqz	a5,80005b2e <sys_open+0xfe>
    80005a78:	4681                	li	a3,0
    80005a7a:	4601                	li	a2,0
    80005a7c:	4589                	li	a1,2
    80005a7e:	f5040513          	addi	a0,s0,-176
    80005a82:	00000097          	auipc	ra,0x0
    80005a86:	976080e7          	jalr	-1674(ra) # 800053f8 <create>
    80005a8a:	84aa                	mv	s1,a0
    80005a8c:	c959                	beqz	a0,80005b22 <sys_open+0xf2>
    80005a8e:	04449703          	lh	a4,68(s1)
    80005a92:	478d                	li	a5,3
    80005a94:	00f71763          	bne	a4,a5,80005aa2 <sys_open+0x72>
    80005a98:	0464d703          	lhu	a4,70(s1)
    80005a9c:	47a5                	li	a5,9
    80005a9e:	0ce7ed63          	bltu	a5,a4,80005b78 <sys_open+0x148>
    80005aa2:	fffff097          	auipc	ra,0xfffff
    80005aa6:	dbe080e7          	jalr	-578(ra) # 80004860 <filealloc>
    80005aaa:	89aa                	mv	s3,a0
    80005aac:	10050363          	beqz	a0,80005bb2 <sys_open+0x182>
    80005ab0:	00000097          	auipc	ra,0x0
    80005ab4:	906080e7          	jalr	-1786(ra) # 800053b6 <fdalloc>
    80005ab8:	892a                	mv	s2,a0
    80005aba:	0e054763          	bltz	a0,80005ba8 <sys_open+0x178>
    80005abe:	04449703          	lh	a4,68(s1)
    80005ac2:	478d                	li	a5,3
    80005ac4:	0cf70563          	beq	a4,a5,80005b8e <sys_open+0x15e>
    80005ac8:	4789                	li	a5,2
    80005aca:	00f9a023          	sw	a5,0(s3)
    80005ace:	0209a023          	sw	zero,32(s3)
    80005ad2:	0099bc23          	sd	s1,24(s3)
    80005ad6:	f4c42783          	lw	a5,-180(s0)
    80005ada:	0017c713          	xori	a4,a5,1
    80005ade:	8b05                	andi	a4,a4,1
    80005ae0:	00e98423          	sb	a4,8(s3)
    80005ae4:	0037f713          	andi	a4,a5,3
    80005ae8:	00e03733          	snez	a4,a4
    80005aec:	00e984a3          	sb	a4,9(s3)
    80005af0:	4007f793          	andi	a5,a5,1024
    80005af4:	c791                	beqz	a5,80005b00 <sys_open+0xd0>
    80005af6:	04449703          	lh	a4,68(s1)
    80005afa:	4789                	li	a5,2
    80005afc:	0af70063          	beq	a4,a5,80005b9c <sys_open+0x16c>
    80005b00:	8526                	mv	a0,s1
    80005b02:	ffffe097          	auipc	ra,0xffffe
    80005b06:	04e080e7          	jalr	78(ra) # 80003b50 <iunlock>
    80005b0a:	fffff097          	auipc	ra,0xfffff
    80005b0e:	9c6080e7          	jalr	-1594(ra) # 800044d0 <end_op>
    80005b12:	854a                	mv	a0,s2
    80005b14:	70ea                	ld	ra,184(sp)
    80005b16:	744a                	ld	s0,176(sp)
    80005b18:	74aa                	ld	s1,168(sp)
    80005b1a:	790a                	ld	s2,160(sp)
    80005b1c:	69ea                	ld	s3,152(sp)
    80005b1e:	6129                	addi	sp,sp,192
    80005b20:	8082                	ret
    80005b22:	fffff097          	auipc	ra,0xfffff
    80005b26:	9ae080e7          	jalr	-1618(ra) # 800044d0 <end_op>
    80005b2a:	557d                	li	a0,-1
    80005b2c:	b7e5                	j	80005b14 <sys_open+0xe4>
    80005b2e:	f5040513          	addi	a0,s0,-176
    80005b32:	ffffe097          	auipc	ra,0xffffe
    80005b36:	702080e7          	jalr	1794(ra) # 80004234 <namei>
    80005b3a:	84aa                	mv	s1,a0
    80005b3c:	c905                	beqz	a0,80005b6c <sys_open+0x13c>
    80005b3e:	ffffe097          	auipc	ra,0xffffe
    80005b42:	f50080e7          	jalr	-176(ra) # 80003a8e <ilock>
    80005b46:	04449703          	lh	a4,68(s1)
    80005b4a:	4785                	li	a5,1
    80005b4c:	f4f711e3          	bne	a4,a5,80005a8e <sys_open+0x5e>
    80005b50:	f4c42783          	lw	a5,-180(s0)
    80005b54:	d7b9                	beqz	a5,80005aa2 <sys_open+0x72>
    80005b56:	8526                	mv	a0,s1
    80005b58:	ffffe097          	auipc	ra,0xffffe
    80005b5c:	198080e7          	jalr	408(ra) # 80003cf0 <iunlockput>
    80005b60:	fffff097          	auipc	ra,0xfffff
    80005b64:	970080e7          	jalr	-1680(ra) # 800044d0 <end_op>
    80005b68:	557d                	li	a0,-1
    80005b6a:	b76d                	j	80005b14 <sys_open+0xe4>
    80005b6c:	fffff097          	auipc	ra,0xfffff
    80005b70:	964080e7          	jalr	-1692(ra) # 800044d0 <end_op>
    80005b74:	557d                	li	a0,-1
    80005b76:	bf79                	j	80005b14 <sys_open+0xe4>
    80005b78:	8526                	mv	a0,s1
    80005b7a:	ffffe097          	auipc	ra,0xffffe
    80005b7e:	176080e7          	jalr	374(ra) # 80003cf0 <iunlockput>
    80005b82:	fffff097          	auipc	ra,0xfffff
    80005b86:	94e080e7          	jalr	-1714(ra) # 800044d0 <end_op>
    80005b8a:	557d                	li	a0,-1
    80005b8c:	b761                	j	80005b14 <sys_open+0xe4>
    80005b8e:	00f9a023          	sw	a5,0(s3)
    80005b92:	04649783          	lh	a5,70(s1)
    80005b96:	02f99223          	sh	a5,36(s3)
    80005b9a:	bf25                	j	80005ad2 <sys_open+0xa2>
    80005b9c:	8526                	mv	a0,s1
    80005b9e:	ffffe097          	auipc	ra,0xffffe
    80005ba2:	ffe080e7          	jalr	-2(ra) # 80003b9c <itrunc>
    80005ba6:	bfa9                	j	80005b00 <sys_open+0xd0>
    80005ba8:	854e                	mv	a0,s3
    80005baa:	fffff097          	auipc	ra,0xfffff
    80005bae:	d72080e7          	jalr	-654(ra) # 8000491c <fileclose>
    80005bb2:	8526                	mv	a0,s1
    80005bb4:	ffffe097          	auipc	ra,0xffffe
    80005bb8:	13c080e7          	jalr	316(ra) # 80003cf0 <iunlockput>
    80005bbc:	fffff097          	auipc	ra,0xfffff
    80005bc0:	914080e7          	jalr	-1772(ra) # 800044d0 <end_op>
    80005bc4:	557d                	li	a0,-1
    80005bc6:	b7b9                	j	80005b14 <sys_open+0xe4>

0000000080005bc8 <sys_mkdir>:
    80005bc8:	7175                	addi	sp,sp,-144
    80005bca:	e506                	sd	ra,136(sp)
    80005bcc:	e122                	sd	s0,128(sp)
    80005bce:	0900                	addi	s0,sp,144
    80005bd0:	fffff097          	auipc	ra,0xfffff
    80005bd4:	880080e7          	jalr	-1920(ra) # 80004450 <begin_op>
    80005bd8:	08000613          	li	a2,128
    80005bdc:	f7040593          	addi	a1,s0,-144
    80005be0:	4501                	li	a0,0
    80005be2:	ffffd097          	auipc	ra,0xffffd
    80005be6:	356080e7          	jalr	854(ra) # 80002f38 <argstr>
    80005bea:	02054963          	bltz	a0,80005c1c <sys_mkdir+0x54>
    80005bee:	4681                	li	a3,0
    80005bf0:	4601                	li	a2,0
    80005bf2:	4585                	li	a1,1
    80005bf4:	f7040513          	addi	a0,s0,-144
    80005bf8:	00000097          	auipc	ra,0x0
    80005bfc:	800080e7          	jalr	-2048(ra) # 800053f8 <create>
    80005c00:	cd11                	beqz	a0,80005c1c <sys_mkdir+0x54>
    80005c02:	ffffe097          	auipc	ra,0xffffe
    80005c06:	0ee080e7          	jalr	238(ra) # 80003cf0 <iunlockput>
    80005c0a:	fffff097          	auipc	ra,0xfffff
    80005c0e:	8c6080e7          	jalr	-1850(ra) # 800044d0 <end_op>
    80005c12:	4501                	li	a0,0
    80005c14:	60aa                	ld	ra,136(sp)
    80005c16:	640a                	ld	s0,128(sp)
    80005c18:	6149                	addi	sp,sp,144
    80005c1a:	8082                	ret
    80005c1c:	fffff097          	auipc	ra,0xfffff
    80005c20:	8b4080e7          	jalr	-1868(ra) # 800044d0 <end_op>
    80005c24:	557d                	li	a0,-1
    80005c26:	b7fd                	j	80005c14 <sys_mkdir+0x4c>

0000000080005c28 <sys_mknod>:
    80005c28:	7135                	addi	sp,sp,-160
    80005c2a:	ed06                	sd	ra,152(sp)
    80005c2c:	e922                	sd	s0,144(sp)
    80005c2e:	1100                	addi	s0,sp,160
    80005c30:	fffff097          	auipc	ra,0xfffff
    80005c34:	820080e7          	jalr	-2016(ra) # 80004450 <begin_op>
    80005c38:	f6c40593          	addi	a1,s0,-148
    80005c3c:	4505                	li	a0,1
    80005c3e:	ffffd097          	auipc	ra,0xffffd
    80005c42:	2ba080e7          	jalr	698(ra) # 80002ef8 <argint>
    80005c46:	f6840593          	addi	a1,s0,-152
    80005c4a:	4509                	li	a0,2
    80005c4c:	ffffd097          	auipc	ra,0xffffd
    80005c50:	2ac080e7          	jalr	684(ra) # 80002ef8 <argint>
    80005c54:	08000613          	li	a2,128
    80005c58:	f7040593          	addi	a1,s0,-144
    80005c5c:	4501                	li	a0,0
    80005c5e:	ffffd097          	auipc	ra,0xffffd
    80005c62:	2da080e7          	jalr	730(ra) # 80002f38 <argstr>
    80005c66:	02054b63          	bltz	a0,80005c9c <sys_mknod+0x74>
    80005c6a:	f6841683          	lh	a3,-152(s0)
    80005c6e:	f6c41603          	lh	a2,-148(s0)
    80005c72:	458d                	li	a1,3
    80005c74:	f7040513          	addi	a0,s0,-144
    80005c78:	fffff097          	auipc	ra,0xfffff
    80005c7c:	780080e7          	jalr	1920(ra) # 800053f8 <create>
    80005c80:	cd11                	beqz	a0,80005c9c <sys_mknod+0x74>
    80005c82:	ffffe097          	auipc	ra,0xffffe
    80005c86:	06e080e7          	jalr	110(ra) # 80003cf0 <iunlockput>
    80005c8a:	fffff097          	auipc	ra,0xfffff
    80005c8e:	846080e7          	jalr	-1978(ra) # 800044d0 <end_op>
    80005c92:	4501                	li	a0,0
    80005c94:	60ea                	ld	ra,152(sp)
    80005c96:	644a                	ld	s0,144(sp)
    80005c98:	610d                	addi	sp,sp,160
    80005c9a:	8082                	ret
    80005c9c:	fffff097          	auipc	ra,0xfffff
    80005ca0:	834080e7          	jalr	-1996(ra) # 800044d0 <end_op>
    80005ca4:	557d                	li	a0,-1
    80005ca6:	b7fd                	j	80005c94 <sys_mknod+0x6c>

0000000080005ca8 <sys_chdir>:
    80005ca8:	7135                	addi	sp,sp,-160
    80005caa:	ed06                	sd	ra,152(sp)
    80005cac:	e922                	sd	s0,144(sp)
    80005cae:	e526                	sd	s1,136(sp)
    80005cb0:	e14a                	sd	s2,128(sp)
    80005cb2:	1100                	addi	s0,sp,160
    80005cb4:	ffffc097          	auipc	ra,0xffffc
    80005cb8:	cf8080e7          	jalr	-776(ra) # 800019ac <myproc>
    80005cbc:	892a                	mv	s2,a0
    80005cbe:	ffffe097          	auipc	ra,0xffffe
    80005cc2:	792080e7          	jalr	1938(ra) # 80004450 <begin_op>
    80005cc6:	08000613          	li	a2,128
    80005cca:	f6040593          	addi	a1,s0,-160
    80005cce:	4501                	li	a0,0
    80005cd0:	ffffd097          	auipc	ra,0xffffd
    80005cd4:	268080e7          	jalr	616(ra) # 80002f38 <argstr>
    80005cd8:	04054b63          	bltz	a0,80005d2e <sys_chdir+0x86>
    80005cdc:	f6040513          	addi	a0,s0,-160
    80005ce0:	ffffe097          	auipc	ra,0xffffe
    80005ce4:	554080e7          	jalr	1364(ra) # 80004234 <namei>
    80005ce8:	84aa                	mv	s1,a0
    80005cea:	c131                	beqz	a0,80005d2e <sys_chdir+0x86>
    80005cec:	ffffe097          	auipc	ra,0xffffe
    80005cf0:	da2080e7          	jalr	-606(ra) # 80003a8e <ilock>
    80005cf4:	04449703          	lh	a4,68(s1)
    80005cf8:	4785                	li	a5,1
    80005cfa:	04f71063          	bne	a4,a5,80005d3a <sys_chdir+0x92>
    80005cfe:	8526                	mv	a0,s1
    80005d00:	ffffe097          	auipc	ra,0xffffe
    80005d04:	e50080e7          	jalr	-432(ra) # 80003b50 <iunlock>
    80005d08:	15093503          	ld	a0,336(s2)
    80005d0c:	ffffe097          	auipc	ra,0xffffe
    80005d10:	f3c080e7          	jalr	-196(ra) # 80003c48 <iput>
    80005d14:	ffffe097          	auipc	ra,0xffffe
    80005d18:	7bc080e7          	jalr	1980(ra) # 800044d0 <end_op>
    80005d1c:	14993823          	sd	s1,336(s2)
    80005d20:	4501                	li	a0,0
    80005d22:	60ea                	ld	ra,152(sp)
    80005d24:	644a                	ld	s0,144(sp)
    80005d26:	64aa                	ld	s1,136(sp)
    80005d28:	690a                	ld	s2,128(sp)
    80005d2a:	610d                	addi	sp,sp,160
    80005d2c:	8082                	ret
    80005d2e:	ffffe097          	auipc	ra,0xffffe
    80005d32:	7a2080e7          	jalr	1954(ra) # 800044d0 <end_op>
    80005d36:	557d                	li	a0,-1
    80005d38:	b7ed                	j	80005d22 <sys_chdir+0x7a>
    80005d3a:	8526                	mv	a0,s1
    80005d3c:	ffffe097          	auipc	ra,0xffffe
    80005d40:	fb4080e7          	jalr	-76(ra) # 80003cf0 <iunlockput>
    80005d44:	ffffe097          	auipc	ra,0xffffe
    80005d48:	78c080e7          	jalr	1932(ra) # 800044d0 <end_op>
    80005d4c:	557d                	li	a0,-1
    80005d4e:	bfd1                	j	80005d22 <sys_chdir+0x7a>

0000000080005d50 <sys_exec>:
    80005d50:	7145                	addi	sp,sp,-464
    80005d52:	e786                	sd	ra,456(sp)
    80005d54:	e3a2                	sd	s0,448(sp)
    80005d56:	ff26                	sd	s1,440(sp)
    80005d58:	fb4a                	sd	s2,432(sp)
    80005d5a:	f74e                	sd	s3,424(sp)
    80005d5c:	f352                	sd	s4,416(sp)
    80005d5e:	ef56                	sd	s5,408(sp)
    80005d60:	0b80                	addi	s0,sp,464
    80005d62:	e3840593          	addi	a1,s0,-456
    80005d66:	4505                	li	a0,1
    80005d68:	ffffd097          	auipc	ra,0xffffd
    80005d6c:	1b0080e7          	jalr	432(ra) # 80002f18 <argaddr>
    80005d70:	08000613          	li	a2,128
    80005d74:	f4040593          	addi	a1,s0,-192
    80005d78:	4501                	li	a0,0
    80005d7a:	ffffd097          	auipc	ra,0xffffd
    80005d7e:	1be080e7          	jalr	446(ra) # 80002f38 <argstr>
    80005d82:	87aa                	mv	a5,a0
    80005d84:	557d                	li	a0,-1
    80005d86:	0c07c263          	bltz	a5,80005e4a <sys_exec+0xfa>
    80005d8a:	10000613          	li	a2,256
    80005d8e:	4581                	li	a1,0
    80005d90:	e4040513          	addi	a0,s0,-448
    80005d94:	ffffb097          	auipc	ra,0xffffb
    80005d98:	f3e080e7          	jalr	-194(ra) # 80000cd2 <memset>
    80005d9c:	e4040493          	addi	s1,s0,-448
    80005da0:	89a6                	mv	s3,s1
    80005da2:	4901                	li	s2,0
    80005da4:	02000a13          	li	s4,32
    80005da8:	00090a9b          	sext.w	s5,s2
    80005dac:	00391793          	slli	a5,s2,0x3
    80005db0:	e3040593          	addi	a1,s0,-464
    80005db4:	e3843503          	ld	a0,-456(s0)
    80005db8:	953e                	add	a0,a0,a5
    80005dba:	ffffd097          	auipc	ra,0xffffd
    80005dbe:	0a0080e7          	jalr	160(ra) # 80002e5a <fetchaddr>
    80005dc2:	02054a63          	bltz	a0,80005df6 <sys_exec+0xa6>
    80005dc6:	e3043783          	ld	a5,-464(s0)
    80005dca:	c3b9                	beqz	a5,80005e10 <sys_exec+0xc0>
    80005dcc:	ffffb097          	auipc	ra,0xffffb
    80005dd0:	d1a080e7          	jalr	-742(ra) # 80000ae6 <kalloc>
    80005dd4:	85aa                	mv	a1,a0
    80005dd6:	00a9b023          	sd	a0,0(s3)
    80005dda:	cd11                	beqz	a0,80005df6 <sys_exec+0xa6>
    80005ddc:	6605                	lui	a2,0x1
    80005dde:	e3043503          	ld	a0,-464(s0)
    80005de2:	ffffd097          	auipc	ra,0xffffd
    80005de6:	0ca080e7          	jalr	202(ra) # 80002eac <fetchstr>
    80005dea:	00054663          	bltz	a0,80005df6 <sys_exec+0xa6>
    80005dee:	0905                	addi	s2,s2,1
    80005df0:	09a1                	addi	s3,s3,8
    80005df2:	fb491be3          	bne	s2,s4,80005da8 <sys_exec+0x58>
    80005df6:	10048913          	addi	s2,s1,256
    80005dfa:	6088                	ld	a0,0(s1)
    80005dfc:	c531                	beqz	a0,80005e48 <sys_exec+0xf8>
    80005dfe:	ffffb097          	auipc	ra,0xffffb
    80005e02:	bec080e7          	jalr	-1044(ra) # 800009ea <kfree>
    80005e06:	04a1                	addi	s1,s1,8
    80005e08:	ff2499e3          	bne	s1,s2,80005dfa <sys_exec+0xaa>
    80005e0c:	557d                	li	a0,-1
    80005e0e:	a835                	j	80005e4a <sys_exec+0xfa>
    80005e10:	0a8e                	slli	s5,s5,0x3
    80005e12:	fc040793          	addi	a5,s0,-64
    80005e16:	9abe                	add	s5,s5,a5
    80005e18:	e80ab023          	sd	zero,-384(s5)
    80005e1c:	e4040593          	addi	a1,s0,-448
    80005e20:	f4040513          	addi	a0,s0,-192
    80005e24:	fffff097          	auipc	ra,0xfffff
    80005e28:	172080e7          	jalr	370(ra) # 80004f96 <exec>
    80005e2c:	892a                	mv	s2,a0
    80005e2e:	10048993          	addi	s3,s1,256
    80005e32:	6088                	ld	a0,0(s1)
    80005e34:	c901                	beqz	a0,80005e44 <sys_exec+0xf4>
    80005e36:	ffffb097          	auipc	ra,0xffffb
    80005e3a:	bb4080e7          	jalr	-1100(ra) # 800009ea <kfree>
    80005e3e:	04a1                	addi	s1,s1,8
    80005e40:	ff3499e3          	bne	s1,s3,80005e32 <sys_exec+0xe2>
    80005e44:	854a                	mv	a0,s2
    80005e46:	a011                	j	80005e4a <sys_exec+0xfa>
    80005e48:	557d                	li	a0,-1
    80005e4a:	60be                	ld	ra,456(sp)
    80005e4c:	641e                	ld	s0,448(sp)
    80005e4e:	74fa                	ld	s1,440(sp)
    80005e50:	795a                	ld	s2,432(sp)
    80005e52:	79ba                	ld	s3,424(sp)
    80005e54:	7a1a                	ld	s4,416(sp)
    80005e56:	6afa                	ld	s5,408(sp)
    80005e58:	6179                	addi	sp,sp,464
    80005e5a:	8082                	ret

0000000080005e5c <sys_pipe>:
    80005e5c:	7139                	addi	sp,sp,-64
    80005e5e:	fc06                	sd	ra,56(sp)
    80005e60:	f822                	sd	s0,48(sp)
    80005e62:	f426                	sd	s1,40(sp)
    80005e64:	0080                	addi	s0,sp,64
    80005e66:	ffffc097          	auipc	ra,0xffffc
    80005e6a:	b46080e7          	jalr	-1210(ra) # 800019ac <myproc>
    80005e6e:	84aa                	mv	s1,a0
    80005e70:	fd840593          	addi	a1,s0,-40
    80005e74:	4501                	li	a0,0
    80005e76:	ffffd097          	auipc	ra,0xffffd
    80005e7a:	0a2080e7          	jalr	162(ra) # 80002f18 <argaddr>
    80005e7e:	fc840593          	addi	a1,s0,-56
    80005e82:	fd040513          	addi	a0,s0,-48
    80005e86:	fffff097          	auipc	ra,0xfffff
    80005e8a:	dc6080e7          	jalr	-570(ra) # 80004c4c <pipealloc>
    80005e8e:	57fd                	li	a5,-1
    80005e90:	0c054463          	bltz	a0,80005f58 <sys_pipe+0xfc>
    80005e94:	fcf42223          	sw	a5,-60(s0)
    80005e98:	fd043503          	ld	a0,-48(s0)
    80005e9c:	fffff097          	auipc	ra,0xfffff
    80005ea0:	51a080e7          	jalr	1306(ra) # 800053b6 <fdalloc>
    80005ea4:	fca42223          	sw	a0,-60(s0)
    80005ea8:	08054b63          	bltz	a0,80005f3e <sys_pipe+0xe2>
    80005eac:	fc843503          	ld	a0,-56(s0)
    80005eb0:	fffff097          	auipc	ra,0xfffff
    80005eb4:	506080e7          	jalr	1286(ra) # 800053b6 <fdalloc>
    80005eb8:	fca42023          	sw	a0,-64(s0)
    80005ebc:	06054863          	bltz	a0,80005f2c <sys_pipe+0xd0>
    80005ec0:	4691                	li	a3,4
    80005ec2:	fc440613          	addi	a2,s0,-60
    80005ec6:	fd843583          	ld	a1,-40(s0)
    80005eca:	68a8                	ld	a0,80(s1)
    80005ecc:	ffffb097          	auipc	ra,0xffffb
    80005ed0:	79c080e7          	jalr	1948(ra) # 80001668 <copyout>
    80005ed4:	02054063          	bltz	a0,80005ef4 <sys_pipe+0x98>
    80005ed8:	4691                	li	a3,4
    80005eda:	fc040613          	addi	a2,s0,-64
    80005ede:	fd843583          	ld	a1,-40(s0)
    80005ee2:	0591                	addi	a1,a1,4
    80005ee4:	68a8                	ld	a0,80(s1)
    80005ee6:	ffffb097          	auipc	ra,0xffffb
    80005eea:	782080e7          	jalr	1922(ra) # 80001668 <copyout>
    80005eee:	4781                	li	a5,0
    80005ef0:	06055463          	bgez	a0,80005f58 <sys_pipe+0xfc>
    80005ef4:	fc442783          	lw	a5,-60(s0)
    80005ef8:	07e9                	addi	a5,a5,26
    80005efa:	078e                	slli	a5,a5,0x3
    80005efc:	97a6                	add	a5,a5,s1
    80005efe:	0007b023          	sd	zero,0(a5)
    80005f02:	fc042503          	lw	a0,-64(s0)
    80005f06:	0569                	addi	a0,a0,26
    80005f08:	050e                	slli	a0,a0,0x3
    80005f0a:	94aa                	add	s1,s1,a0
    80005f0c:	0004b023          	sd	zero,0(s1)
    80005f10:	fd043503          	ld	a0,-48(s0)
    80005f14:	fffff097          	auipc	ra,0xfffff
    80005f18:	a08080e7          	jalr	-1528(ra) # 8000491c <fileclose>
    80005f1c:	fc843503          	ld	a0,-56(s0)
    80005f20:	fffff097          	auipc	ra,0xfffff
    80005f24:	9fc080e7          	jalr	-1540(ra) # 8000491c <fileclose>
    80005f28:	57fd                	li	a5,-1
    80005f2a:	a03d                	j	80005f58 <sys_pipe+0xfc>
    80005f2c:	fc442783          	lw	a5,-60(s0)
    80005f30:	0007c763          	bltz	a5,80005f3e <sys_pipe+0xe2>
    80005f34:	07e9                	addi	a5,a5,26
    80005f36:	078e                	slli	a5,a5,0x3
    80005f38:	94be                	add	s1,s1,a5
    80005f3a:	0004b023          	sd	zero,0(s1)
    80005f3e:	fd043503          	ld	a0,-48(s0)
    80005f42:	fffff097          	auipc	ra,0xfffff
    80005f46:	9da080e7          	jalr	-1574(ra) # 8000491c <fileclose>
    80005f4a:	fc843503          	ld	a0,-56(s0)
    80005f4e:	fffff097          	auipc	ra,0xfffff
    80005f52:	9ce080e7          	jalr	-1586(ra) # 8000491c <fileclose>
    80005f56:	57fd                	li	a5,-1
    80005f58:	853e                	mv	a0,a5
    80005f5a:	70e2                	ld	ra,56(sp)
    80005f5c:	7442                	ld	s0,48(sp)
    80005f5e:	74a2                	ld	s1,40(sp)
    80005f60:	6121                	addi	sp,sp,64
    80005f62:	8082                	ret
	...

0000000080005f70 <kernelvec>:
    80005f70:	7111                	addi	sp,sp,-256
    80005f72:	e006                	sd	ra,0(sp)
    80005f74:	e40a                	sd	sp,8(sp)
    80005f76:	e80e                	sd	gp,16(sp)
    80005f78:	ec12                	sd	tp,24(sp)
    80005f7a:	f016                	sd	t0,32(sp)
    80005f7c:	f41a                	sd	t1,40(sp)
    80005f7e:	f81e                	sd	t2,48(sp)
    80005f80:	fc22                	sd	s0,56(sp)
    80005f82:	e0a6                	sd	s1,64(sp)
    80005f84:	e4aa                	sd	a0,72(sp)
    80005f86:	e8ae                	sd	a1,80(sp)
    80005f88:	ecb2                	sd	a2,88(sp)
    80005f8a:	f0b6                	sd	a3,96(sp)
    80005f8c:	f4ba                	sd	a4,104(sp)
    80005f8e:	f8be                	sd	a5,112(sp)
    80005f90:	fcc2                	sd	a6,120(sp)
    80005f92:	e146                	sd	a7,128(sp)
    80005f94:	e54a                	sd	s2,136(sp)
    80005f96:	e94e                	sd	s3,144(sp)
    80005f98:	ed52                	sd	s4,152(sp)
    80005f9a:	f156                	sd	s5,160(sp)
    80005f9c:	f55a                	sd	s6,168(sp)
    80005f9e:	f95e                	sd	s7,176(sp)
    80005fa0:	fd62                	sd	s8,184(sp)
    80005fa2:	e1e6                	sd	s9,192(sp)
    80005fa4:	e5ea                	sd	s10,200(sp)
    80005fa6:	e9ee                	sd	s11,208(sp)
    80005fa8:	edf2                	sd	t3,216(sp)
    80005faa:	f1f6                	sd	t4,224(sp)
    80005fac:	f5fa                	sd	t5,232(sp)
    80005fae:	f9fe                	sd	t6,240(sp)
    80005fb0:	d77fc0ef          	jal	ra,80002d26 <kerneltrap>
    80005fb4:	6082                	ld	ra,0(sp)
    80005fb6:	6122                	ld	sp,8(sp)
    80005fb8:	61c2                	ld	gp,16(sp)
    80005fba:	7282                	ld	t0,32(sp)
    80005fbc:	7322                	ld	t1,40(sp)
    80005fbe:	73c2                	ld	t2,48(sp)
    80005fc0:	7462                	ld	s0,56(sp)
    80005fc2:	6486                	ld	s1,64(sp)
    80005fc4:	6526                	ld	a0,72(sp)
    80005fc6:	65c6                	ld	a1,80(sp)
    80005fc8:	6666                	ld	a2,88(sp)
    80005fca:	7686                	ld	a3,96(sp)
    80005fcc:	7726                	ld	a4,104(sp)
    80005fce:	77c6                	ld	a5,112(sp)
    80005fd0:	7866                	ld	a6,120(sp)
    80005fd2:	688a                	ld	a7,128(sp)
    80005fd4:	692a                	ld	s2,136(sp)
    80005fd6:	69ca                	ld	s3,144(sp)
    80005fd8:	6a6a                	ld	s4,152(sp)
    80005fda:	7a8a                	ld	s5,160(sp)
    80005fdc:	7b2a                	ld	s6,168(sp)
    80005fde:	7bca                	ld	s7,176(sp)
    80005fe0:	7c6a                	ld	s8,184(sp)
    80005fe2:	6c8e                	ld	s9,192(sp)
    80005fe4:	6d2e                	ld	s10,200(sp)
    80005fe6:	6dce                	ld	s11,208(sp)
    80005fe8:	6e6e                	ld	t3,216(sp)
    80005fea:	7e8e                	ld	t4,224(sp)
    80005fec:	7f2e                	ld	t5,232(sp)
    80005fee:	7fce                	ld	t6,240(sp)
    80005ff0:	6111                	addi	sp,sp,256
    80005ff2:	10200073          	sret
    80005ff6:	00000013          	nop
    80005ffa:	00000013          	nop
    80005ffe:	0001                	nop

0000000080006000 <timervec>:
    80006000:	34051573          	csrrw	a0,mscratch,a0
    80006004:	e10c                	sd	a1,0(a0)
    80006006:	e510                	sd	a2,8(a0)
    80006008:	e914                	sd	a3,16(a0)
    8000600a:	6d0c                	ld	a1,24(a0)
    8000600c:	7110                	ld	a2,32(a0)
    8000600e:	6194                	ld	a3,0(a1)
    80006010:	96b2                	add	a3,a3,a2
    80006012:	e194                	sd	a3,0(a1)
    80006014:	4589                	li	a1,2
    80006016:	14459073          	csrw	sip,a1
    8000601a:	6914                	ld	a3,16(a0)
    8000601c:	6510                	ld	a2,8(a0)
    8000601e:	610c                	ld	a1,0(a0)
    80006020:	34051573          	csrrw	a0,mscratch,a0
    80006024:	30200073          	mret
	...

000000008000602a <plicinit>:
    8000602a:	1141                	addi	sp,sp,-16
    8000602c:	e422                	sd	s0,8(sp)
    8000602e:	0800                	addi	s0,sp,16
    80006030:	0c0007b7          	lui	a5,0xc000
    80006034:	4705                	li	a4,1
    80006036:	d798                	sw	a4,40(a5)
    80006038:	c3d8                	sw	a4,4(a5)
    8000603a:	6422                	ld	s0,8(sp)
    8000603c:	0141                	addi	sp,sp,16
    8000603e:	8082                	ret

0000000080006040 <plicinithart>:
    80006040:	1141                	addi	sp,sp,-16
    80006042:	e406                	sd	ra,8(sp)
    80006044:	e022                	sd	s0,0(sp)
    80006046:	0800                	addi	s0,sp,16
    80006048:	ffffc097          	auipc	ra,0xffffc
    8000604c:	938080e7          	jalr	-1736(ra) # 80001980 <cpuid>
    80006050:	0085171b          	slliw	a4,a0,0x8
    80006054:	0c0027b7          	lui	a5,0xc002
    80006058:	97ba                	add	a5,a5,a4
    8000605a:	40200713          	li	a4,1026
    8000605e:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80006062:	00d5151b          	slliw	a0,a0,0xd
    80006066:	0c2017b7          	lui	a5,0xc201
    8000606a:	953e                	add	a0,a0,a5
    8000606c:	00052023          	sw	zero,0(a0)
    80006070:	60a2                	ld	ra,8(sp)
    80006072:	6402                	ld	s0,0(sp)
    80006074:	0141                	addi	sp,sp,16
    80006076:	8082                	ret

0000000080006078 <plic_claim>:
    80006078:	1141                	addi	sp,sp,-16
    8000607a:	e406                	sd	ra,8(sp)
    8000607c:	e022                	sd	s0,0(sp)
    8000607e:	0800                	addi	s0,sp,16
    80006080:	ffffc097          	auipc	ra,0xffffc
    80006084:	900080e7          	jalr	-1792(ra) # 80001980 <cpuid>
    80006088:	00d5179b          	slliw	a5,a0,0xd
    8000608c:	0c201537          	lui	a0,0xc201
    80006090:	953e                	add	a0,a0,a5
    80006092:	4148                	lw	a0,4(a0)
    80006094:	60a2                	ld	ra,8(sp)
    80006096:	6402                	ld	s0,0(sp)
    80006098:	0141                	addi	sp,sp,16
    8000609a:	8082                	ret

000000008000609c <plic_complete>:
    8000609c:	1101                	addi	sp,sp,-32
    8000609e:	ec06                	sd	ra,24(sp)
    800060a0:	e822                	sd	s0,16(sp)
    800060a2:	e426                	sd	s1,8(sp)
    800060a4:	1000                	addi	s0,sp,32
    800060a6:	84aa                	mv	s1,a0
    800060a8:	ffffc097          	auipc	ra,0xffffc
    800060ac:	8d8080e7          	jalr	-1832(ra) # 80001980 <cpuid>
    800060b0:	00d5151b          	slliw	a0,a0,0xd
    800060b4:	0c2017b7          	lui	a5,0xc201
    800060b8:	97aa                	add	a5,a5,a0
    800060ba:	c3c4                	sw	s1,4(a5)
    800060bc:	60e2                	ld	ra,24(sp)
    800060be:	6442                	ld	s0,16(sp)
    800060c0:	64a2                	ld	s1,8(sp)
    800060c2:	6105                	addi	sp,sp,32
    800060c4:	8082                	ret

00000000800060c6 <free_desc>:
    800060c6:	1141                	addi	sp,sp,-16
    800060c8:	e406                	sd	ra,8(sp)
    800060ca:	e022                	sd	s0,0(sp)
    800060cc:	0800                	addi	s0,sp,16
    800060ce:	479d                	li	a5,7
    800060d0:	04a7cc63          	blt	a5,a0,80006128 <free_desc+0x62>
    800060d4:	0001c797          	auipc	a5,0x1c
    800060d8:	b7c78793          	addi	a5,a5,-1156 # 80021c50 <disk>
    800060dc:	97aa                	add	a5,a5,a0
    800060de:	0187c783          	lbu	a5,24(a5)
    800060e2:	ebb9                	bnez	a5,80006138 <free_desc+0x72>
    800060e4:	00451613          	slli	a2,a0,0x4
    800060e8:	0001c797          	auipc	a5,0x1c
    800060ec:	b6878793          	addi	a5,a5,-1176 # 80021c50 <disk>
    800060f0:	6394                	ld	a3,0(a5)
    800060f2:	96b2                	add	a3,a3,a2
    800060f4:	0006b023          	sd	zero,0(a3)
    800060f8:	6398                	ld	a4,0(a5)
    800060fa:	9732                	add	a4,a4,a2
    800060fc:	00072423          	sw	zero,8(a4)
    80006100:	00071623          	sh	zero,12(a4)
    80006104:	00071723          	sh	zero,14(a4)
    80006108:	953e                	add	a0,a0,a5
    8000610a:	4785                	li	a5,1
    8000610c:	00f50c23          	sb	a5,24(a0) # c201018 <_entry-0x73dfefe8>
    80006110:	0001c517          	auipc	a0,0x1c
    80006114:	b5850513          	addi	a0,a0,-1192 # 80021c68 <disk+0x18>
    80006118:	ffffc097          	auipc	ra,0xffffc
    8000611c:	fa0080e7          	jalr	-96(ra) # 800020b8 <wakeup>
    80006120:	60a2                	ld	ra,8(sp)
    80006122:	6402                	ld	s0,0(sp)
    80006124:	0141                	addi	sp,sp,16
    80006126:	8082                	ret
    80006128:	00002517          	auipc	a0,0x2
    8000612c:	66850513          	addi	a0,a0,1640 # 80008790 <syscalls+0x2f8>
    80006130:	ffffa097          	auipc	ra,0xffffa
    80006134:	40e080e7          	jalr	1038(ra) # 8000053e <panic>
    80006138:	00002517          	auipc	a0,0x2
    8000613c:	66850513          	addi	a0,a0,1640 # 800087a0 <syscalls+0x308>
    80006140:	ffffa097          	auipc	ra,0xffffa
    80006144:	3fe080e7          	jalr	1022(ra) # 8000053e <panic>

0000000080006148 <virtio_disk_init>:
    80006148:	1101                	addi	sp,sp,-32
    8000614a:	ec06                	sd	ra,24(sp)
    8000614c:	e822                	sd	s0,16(sp)
    8000614e:	e426                	sd	s1,8(sp)
    80006150:	e04a                	sd	s2,0(sp)
    80006152:	1000                	addi	s0,sp,32
    80006154:	00002597          	auipc	a1,0x2
    80006158:	65c58593          	addi	a1,a1,1628 # 800087b0 <syscalls+0x318>
    8000615c:	0001c517          	auipc	a0,0x1c
    80006160:	c1c50513          	addi	a0,a0,-996 # 80021d78 <disk+0x128>
    80006164:	ffffb097          	auipc	ra,0xffffb
    80006168:	9e2080e7          	jalr	-1566(ra) # 80000b46 <initlock>
    8000616c:	100017b7          	lui	a5,0x10001
    80006170:	4398                	lw	a4,0(a5)
    80006172:	2701                	sext.w	a4,a4
    80006174:	747277b7          	lui	a5,0x74727
    80006178:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    8000617c:	14f71c63          	bne	a4,a5,800062d4 <virtio_disk_init+0x18c>
    80006180:	100017b7          	lui	a5,0x10001
    80006184:	43dc                	lw	a5,4(a5)
    80006186:	2781                	sext.w	a5,a5
    80006188:	4709                	li	a4,2
    8000618a:	14e79563          	bne	a5,a4,800062d4 <virtio_disk_init+0x18c>
    8000618e:	100017b7          	lui	a5,0x10001
    80006192:	479c                	lw	a5,8(a5)
    80006194:	2781                	sext.w	a5,a5
    80006196:	12e79f63          	bne	a5,a4,800062d4 <virtio_disk_init+0x18c>
    8000619a:	100017b7          	lui	a5,0x10001
    8000619e:	47d8                	lw	a4,12(a5)
    800061a0:	2701                	sext.w	a4,a4
    800061a2:	554d47b7          	lui	a5,0x554d4
    800061a6:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    800061aa:	12f71563          	bne	a4,a5,800062d4 <virtio_disk_init+0x18c>
    800061ae:	100017b7          	lui	a5,0x10001
    800061b2:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
    800061b6:	4705                	li	a4,1
    800061b8:	dbb8                	sw	a4,112(a5)
    800061ba:	470d                	li	a4,3
    800061bc:	dbb8                	sw	a4,112(a5)
    800061be:	4b94                	lw	a3,16(a5)
    800061c0:	c7ffe737          	lui	a4,0xc7ffe
    800061c4:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fdc9cf>
    800061c8:	8f75                	and	a4,a4,a3
    800061ca:	2701                	sext.w	a4,a4
    800061cc:	d398                	sw	a4,32(a5)
    800061ce:	472d                	li	a4,11
    800061d0:	dbb8                	sw	a4,112(a5)
    800061d2:	5bbc                	lw	a5,112(a5)
    800061d4:	0007891b          	sext.w	s2,a5
    800061d8:	8ba1                	andi	a5,a5,8
    800061da:	10078563          	beqz	a5,800062e4 <virtio_disk_init+0x19c>
    800061de:	100017b7          	lui	a5,0x10001
    800061e2:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
    800061e6:	43fc                	lw	a5,68(a5)
    800061e8:	2781                	sext.w	a5,a5
    800061ea:	10079563          	bnez	a5,800062f4 <virtio_disk_init+0x1ac>
    800061ee:	100017b7          	lui	a5,0x10001
    800061f2:	5bdc                	lw	a5,52(a5)
    800061f4:	2781                	sext.w	a5,a5
    800061f6:	10078763          	beqz	a5,80006304 <virtio_disk_init+0x1bc>
    800061fa:	471d                	li	a4,7
    800061fc:	10f77c63          	bgeu	a4,a5,80006314 <virtio_disk_init+0x1cc>
    80006200:	ffffb097          	auipc	ra,0xffffb
    80006204:	8e6080e7          	jalr	-1818(ra) # 80000ae6 <kalloc>
    80006208:	0001c497          	auipc	s1,0x1c
    8000620c:	a4848493          	addi	s1,s1,-1464 # 80021c50 <disk>
    80006210:	e088                	sd	a0,0(s1)
    80006212:	ffffb097          	auipc	ra,0xffffb
    80006216:	8d4080e7          	jalr	-1836(ra) # 80000ae6 <kalloc>
    8000621a:	e488                	sd	a0,8(s1)
    8000621c:	ffffb097          	auipc	ra,0xffffb
    80006220:	8ca080e7          	jalr	-1846(ra) # 80000ae6 <kalloc>
    80006224:	87aa                	mv	a5,a0
    80006226:	e888                	sd	a0,16(s1)
    80006228:	6088                	ld	a0,0(s1)
    8000622a:	cd6d                	beqz	a0,80006324 <virtio_disk_init+0x1dc>
    8000622c:	0001c717          	auipc	a4,0x1c
    80006230:	a2c73703          	ld	a4,-1492(a4) # 80021c58 <disk+0x8>
    80006234:	cb65                	beqz	a4,80006324 <virtio_disk_init+0x1dc>
    80006236:	c7fd                	beqz	a5,80006324 <virtio_disk_init+0x1dc>
    80006238:	6605                	lui	a2,0x1
    8000623a:	4581                	li	a1,0
    8000623c:	ffffb097          	auipc	ra,0xffffb
    80006240:	a96080e7          	jalr	-1386(ra) # 80000cd2 <memset>
    80006244:	0001c497          	auipc	s1,0x1c
    80006248:	a0c48493          	addi	s1,s1,-1524 # 80021c50 <disk>
    8000624c:	6605                	lui	a2,0x1
    8000624e:	4581                	li	a1,0
    80006250:	6488                	ld	a0,8(s1)
    80006252:	ffffb097          	auipc	ra,0xffffb
    80006256:	a80080e7          	jalr	-1408(ra) # 80000cd2 <memset>
    8000625a:	6605                	lui	a2,0x1
    8000625c:	4581                	li	a1,0
    8000625e:	6888                	ld	a0,16(s1)
    80006260:	ffffb097          	auipc	ra,0xffffb
    80006264:	a72080e7          	jalr	-1422(ra) # 80000cd2 <memset>
    80006268:	100017b7          	lui	a5,0x10001
    8000626c:	4721                	li	a4,8
    8000626e:	df98                	sw	a4,56(a5)
    80006270:	4098                	lw	a4,0(s1)
    80006272:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
    80006276:	40d8                	lw	a4,4(s1)
    80006278:	08e7a223          	sw	a4,132(a5)
    8000627c:	6498                	ld	a4,8(s1)
    8000627e:	0007069b          	sext.w	a3,a4
    80006282:	08d7a823          	sw	a3,144(a5)
    80006286:	9701                	srai	a4,a4,0x20
    80006288:	08e7aa23          	sw	a4,148(a5)
    8000628c:	6898                	ld	a4,16(s1)
    8000628e:	0007069b          	sext.w	a3,a4
    80006292:	0ad7a023          	sw	a3,160(a5)
    80006296:	9701                	srai	a4,a4,0x20
    80006298:	0ae7a223          	sw	a4,164(a5)
    8000629c:	4705                	li	a4,1
    8000629e:	c3f8                	sw	a4,68(a5)
    800062a0:	00e48c23          	sb	a4,24(s1)
    800062a4:	00e48ca3          	sb	a4,25(s1)
    800062a8:	00e48d23          	sb	a4,26(s1)
    800062ac:	00e48da3          	sb	a4,27(s1)
    800062b0:	00e48e23          	sb	a4,28(s1)
    800062b4:	00e48ea3          	sb	a4,29(s1)
    800062b8:	00e48f23          	sb	a4,30(s1)
    800062bc:	00e48fa3          	sb	a4,31(s1)
    800062c0:	00496913          	ori	s2,s2,4
    800062c4:	0727a823          	sw	s2,112(a5)
    800062c8:	60e2                	ld	ra,24(sp)
    800062ca:	6442                	ld	s0,16(sp)
    800062cc:	64a2                	ld	s1,8(sp)
    800062ce:	6902                	ld	s2,0(sp)
    800062d0:	6105                	addi	sp,sp,32
    800062d2:	8082                	ret
    800062d4:	00002517          	auipc	a0,0x2
    800062d8:	4ec50513          	addi	a0,a0,1260 # 800087c0 <syscalls+0x328>
    800062dc:	ffffa097          	auipc	ra,0xffffa
    800062e0:	262080e7          	jalr	610(ra) # 8000053e <panic>
    800062e4:	00002517          	auipc	a0,0x2
    800062e8:	4fc50513          	addi	a0,a0,1276 # 800087e0 <syscalls+0x348>
    800062ec:	ffffa097          	auipc	ra,0xffffa
    800062f0:	252080e7          	jalr	594(ra) # 8000053e <panic>
    800062f4:	00002517          	auipc	a0,0x2
    800062f8:	50c50513          	addi	a0,a0,1292 # 80008800 <syscalls+0x368>
    800062fc:	ffffa097          	auipc	ra,0xffffa
    80006300:	242080e7          	jalr	578(ra) # 8000053e <panic>
    80006304:	00002517          	auipc	a0,0x2
    80006308:	51c50513          	addi	a0,a0,1308 # 80008820 <syscalls+0x388>
    8000630c:	ffffa097          	auipc	ra,0xffffa
    80006310:	232080e7          	jalr	562(ra) # 8000053e <panic>
    80006314:	00002517          	auipc	a0,0x2
    80006318:	52c50513          	addi	a0,a0,1324 # 80008840 <syscalls+0x3a8>
    8000631c:	ffffa097          	auipc	ra,0xffffa
    80006320:	222080e7          	jalr	546(ra) # 8000053e <panic>
    80006324:	00002517          	auipc	a0,0x2
    80006328:	53c50513          	addi	a0,a0,1340 # 80008860 <syscalls+0x3c8>
    8000632c:	ffffa097          	auipc	ra,0xffffa
    80006330:	212080e7          	jalr	530(ra) # 8000053e <panic>

0000000080006334 <virtio_disk_rw>:
    80006334:	7119                	addi	sp,sp,-128
    80006336:	fc86                	sd	ra,120(sp)
    80006338:	f8a2                	sd	s0,112(sp)
    8000633a:	f4a6                	sd	s1,104(sp)
    8000633c:	f0ca                	sd	s2,96(sp)
    8000633e:	ecce                	sd	s3,88(sp)
    80006340:	e8d2                	sd	s4,80(sp)
    80006342:	e4d6                	sd	s5,72(sp)
    80006344:	e0da                	sd	s6,64(sp)
    80006346:	fc5e                	sd	s7,56(sp)
    80006348:	f862                	sd	s8,48(sp)
    8000634a:	f466                	sd	s9,40(sp)
    8000634c:	f06a                	sd	s10,32(sp)
    8000634e:	ec6e                	sd	s11,24(sp)
    80006350:	0100                	addi	s0,sp,128
    80006352:	8aaa                	mv	s5,a0
    80006354:	8c2e                	mv	s8,a1
    80006356:	00c52d03          	lw	s10,12(a0)
    8000635a:	001d1d1b          	slliw	s10,s10,0x1
    8000635e:	1d02                	slli	s10,s10,0x20
    80006360:	020d5d13          	srli	s10,s10,0x20
    80006364:	0001c517          	auipc	a0,0x1c
    80006368:	a1450513          	addi	a0,a0,-1516 # 80021d78 <disk+0x128>
    8000636c:	ffffb097          	auipc	ra,0xffffb
    80006370:	86a080e7          	jalr	-1942(ra) # 80000bd6 <acquire>
    80006374:	4981                	li	s3,0
    80006376:	44a1                	li	s1,8
    80006378:	0001cb97          	auipc	s7,0x1c
    8000637c:	8d8b8b93          	addi	s7,s7,-1832 # 80021c50 <disk>
    80006380:	4b0d                	li	s6,3
    80006382:	0001cc97          	auipc	s9,0x1c
    80006386:	9f6c8c93          	addi	s9,s9,-1546 # 80021d78 <disk+0x128>
    8000638a:	a08d                	j	800063ec <virtio_disk_rw+0xb8>
    8000638c:	00fb8733          	add	a4,s7,a5
    80006390:	00070c23          	sb	zero,24(a4)
    80006394:	c19c                	sw	a5,0(a1)
    80006396:	0207c563          	bltz	a5,800063c0 <virtio_disk_rw+0x8c>
    8000639a:	2905                	addiw	s2,s2,1
    8000639c:	0611                	addi	a2,a2,4
    8000639e:	05690c63          	beq	s2,s6,800063f6 <virtio_disk_rw+0xc2>
    800063a2:	85b2                	mv	a1,a2
    800063a4:	0001c717          	auipc	a4,0x1c
    800063a8:	8ac70713          	addi	a4,a4,-1876 # 80021c50 <disk>
    800063ac:	87ce                	mv	a5,s3
    800063ae:	01874683          	lbu	a3,24(a4)
    800063b2:	fee9                	bnez	a3,8000638c <virtio_disk_rw+0x58>
    800063b4:	2785                	addiw	a5,a5,1
    800063b6:	0705                	addi	a4,a4,1
    800063b8:	fe979be3          	bne	a5,s1,800063ae <virtio_disk_rw+0x7a>
    800063bc:	57fd                	li	a5,-1
    800063be:	c19c                	sw	a5,0(a1)
    800063c0:	01205d63          	blez	s2,800063da <virtio_disk_rw+0xa6>
    800063c4:	8dce                	mv	s11,s3
    800063c6:	000a2503          	lw	a0,0(s4)
    800063ca:	00000097          	auipc	ra,0x0
    800063ce:	cfc080e7          	jalr	-772(ra) # 800060c6 <free_desc>
    800063d2:	2d85                	addiw	s11,s11,1
    800063d4:	0a11                	addi	s4,s4,4
    800063d6:	ffb918e3          	bne	s2,s11,800063c6 <virtio_disk_rw+0x92>
    800063da:	85e6                	mv	a1,s9
    800063dc:	0001c517          	auipc	a0,0x1c
    800063e0:	88c50513          	addi	a0,a0,-1908 # 80021c68 <disk+0x18>
    800063e4:	ffffc097          	auipc	ra,0xffffc
    800063e8:	c70080e7          	jalr	-912(ra) # 80002054 <sleep>
    800063ec:	f8040a13          	addi	s4,s0,-128
    800063f0:	8652                	mv	a2,s4
    800063f2:	894e                	mv	s2,s3
    800063f4:	b77d                	j	800063a2 <virtio_disk_rw+0x6e>
    800063f6:	f8042583          	lw	a1,-128(s0)
    800063fa:	00a58793          	addi	a5,a1,10
    800063fe:	0792                	slli	a5,a5,0x4
    80006400:	0001c617          	auipc	a2,0x1c
    80006404:	85060613          	addi	a2,a2,-1968 # 80021c50 <disk>
    80006408:	00f60733          	add	a4,a2,a5
    8000640c:	018036b3          	snez	a3,s8
    80006410:	c714                	sw	a3,8(a4)
    80006412:	00072623          	sw	zero,12(a4)
    80006416:	01a73823          	sd	s10,16(a4)
    8000641a:	f6078693          	addi	a3,a5,-160
    8000641e:	6218                	ld	a4,0(a2)
    80006420:	9736                	add	a4,a4,a3
    80006422:	00878513          	addi	a0,a5,8
    80006426:	9532                	add	a0,a0,a2
    80006428:	e308                	sd	a0,0(a4)
    8000642a:	6208                	ld	a0,0(a2)
    8000642c:	96aa                	add	a3,a3,a0
    8000642e:	4741                	li	a4,16
    80006430:	c698                	sw	a4,8(a3)
    80006432:	4705                	li	a4,1
    80006434:	00e69623          	sh	a4,12(a3)
    80006438:	f8442703          	lw	a4,-124(s0)
    8000643c:	00e69723          	sh	a4,14(a3)
    80006440:	0712                	slli	a4,a4,0x4
    80006442:	953a                	add	a0,a0,a4
    80006444:	058a8693          	addi	a3,s5,88
    80006448:	e114                	sd	a3,0(a0)
    8000644a:	6208                	ld	a0,0(a2)
    8000644c:	972a                	add	a4,a4,a0
    8000644e:	40000693          	li	a3,1024
    80006452:	c714                	sw	a3,8(a4)
    80006454:	001c3c13          	seqz	s8,s8
    80006458:	0c06                	slli	s8,s8,0x1
    8000645a:	001c6c13          	ori	s8,s8,1
    8000645e:	01871623          	sh	s8,12(a4)
    80006462:	f8842603          	lw	a2,-120(s0)
    80006466:	00c71723          	sh	a2,14(a4)
    8000646a:	0001b697          	auipc	a3,0x1b
    8000646e:	7e668693          	addi	a3,a3,2022 # 80021c50 <disk>
    80006472:	00258713          	addi	a4,a1,2
    80006476:	0712                	slli	a4,a4,0x4
    80006478:	9736                	add	a4,a4,a3
    8000647a:	587d                	li	a6,-1
    8000647c:	01070823          	sb	a6,16(a4)
    80006480:	0612                	slli	a2,a2,0x4
    80006482:	9532                	add	a0,a0,a2
    80006484:	f9078793          	addi	a5,a5,-112
    80006488:	97b6                	add	a5,a5,a3
    8000648a:	e11c                	sd	a5,0(a0)
    8000648c:	629c                	ld	a5,0(a3)
    8000648e:	97b2                	add	a5,a5,a2
    80006490:	4605                	li	a2,1
    80006492:	c790                	sw	a2,8(a5)
    80006494:	4509                	li	a0,2
    80006496:	00a79623          	sh	a0,12(a5)
    8000649a:	00079723          	sh	zero,14(a5)
    8000649e:	00caa223          	sw	a2,4(s5)
    800064a2:	01573423          	sd	s5,8(a4)
    800064a6:	6698                	ld	a4,8(a3)
    800064a8:	00275783          	lhu	a5,2(a4)
    800064ac:	8b9d                	andi	a5,a5,7
    800064ae:	0786                	slli	a5,a5,0x1
    800064b0:	97ba                	add	a5,a5,a4
    800064b2:	00b79223          	sh	a1,4(a5)
    800064b6:	0ff0000f          	fence
    800064ba:	6698                	ld	a4,8(a3)
    800064bc:	00275783          	lhu	a5,2(a4)
    800064c0:	2785                	addiw	a5,a5,1
    800064c2:	00f71123          	sh	a5,2(a4)
    800064c6:	0ff0000f          	fence
    800064ca:	100017b7          	lui	a5,0x10001
    800064ce:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>
    800064d2:	004aa783          	lw	a5,4(s5)
    800064d6:	02c79163          	bne	a5,a2,800064f8 <virtio_disk_rw+0x1c4>
    800064da:	0001c917          	auipc	s2,0x1c
    800064de:	89e90913          	addi	s2,s2,-1890 # 80021d78 <disk+0x128>
    800064e2:	4485                	li	s1,1
    800064e4:	85ca                	mv	a1,s2
    800064e6:	8556                	mv	a0,s5
    800064e8:	ffffc097          	auipc	ra,0xffffc
    800064ec:	b6c080e7          	jalr	-1172(ra) # 80002054 <sleep>
    800064f0:	004aa783          	lw	a5,4(s5)
    800064f4:	fe9788e3          	beq	a5,s1,800064e4 <virtio_disk_rw+0x1b0>
    800064f8:	f8042903          	lw	s2,-128(s0)
    800064fc:	00290793          	addi	a5,s2,2
    80006500:	00479713          	slli	a4,a5,0x4
    80006504:	0001b797          	auipc	a5,0x1b
    80006508:	74c78793          	addi	a5,a5,1868 # 80021c50 <disk>
    8000650c:	97ba                	add	a5,a5,a4
    8000650e:	0007b423          	sd	zero,8(a5)
    80006512:	0001b997          	auipc	s3,0x1b
    80006516:	73e98993          	addi	s3,s3,1854 # 80021c50 <disk>
    8000651a:	00491713          	slli	a4,s2,0x4
    8000651e:	0009b783          	ld	a5,0(s3)
    80006522:	97ba                	add	a5,a5,a4
    80006524:	00c7d483          	lhu	s1,12(a5)
    80006528:	854a                	mv	a0,s2
    8000652a:	00e7d903          	lhu	s2,14(a5)
    8000652e:	00000097          	auipc	ra,0x0
    80006532:	b98080e7          	jalr	-1128(ra) # 800060c6 <free_desc>
    80006536:	8885                	andi	s1,s1,1
    80006538:	f0ed                	bnez	s1,8000651a <virtio_disk_rw+0x1e6>
    8000653a:	0001c517          	auipc	a0,0x1c
    8000653e:	83e50513          	addi	a0,a0,-1986 # 80021d78 <disk+0x128>
    80006542:	ffffa097          	auipc	ra,0xffffa
    80006546:	748080e7          	jalr	1864(ra) # 80000c8a <release>
    8000654a:	70e6                	ld	ra,120(sp)
    8000654c:	7446                	ld	s0,112(sp)
    8000654e:	74a6                	ld	s1,104(sp)
    80006550:	7906                	ld	s2,96(sp)
    80006552:	69e6                	ld	s3,88(sp)
    80006554:	6a46                	ld	s4,80(sp)
    80006556:	6aa6                	ld	s5,72(sp)
    80006558:	6b06                	ld	s6,64(sp)
    8000655a:	7be2                	ld	s7,56(sp)
    8000655c:	7c42                	ld	s8,48(sp)
    8000655e:	7ca2                	ld	s9,40(sp)
    80006560:	7d02                	ld	s10,32(sp)
    80006562:	6de2                	ld	s11,24(sp)
    80006564:	6109                	addi	sp,sp,128
    80006566:	8082                	ret

0000000080006568 <virtio_disk_intr>:
    80006568:	1101                	addi	sp,sp,-32
    8000656a:	ec06                	sd	ra,24(sp)
    8000656c:	e822                	sd	s0,16(sp)
    8000656e:	e426                	sd	s1,8(sp)
    80006570:	1000                	addi	s0,sp,32
    80006572:	0001b497          	auipc	s1,0x1b
    80006576:	6de48493          	addi	s1,s1,1758 # 80021c50 <disk>
    8000657a:	0001b517          	auipc	a0,0x1b
    8000657e:	7fe50513          	addi	a0,a0,2046 # 80021d78 <disk+0x128>
    80006582:	ffffa097          	auipc	ra,0xffffa
    80006586:	654080e7          	jalr	1620(ra) # 80000bd6 <acquire>
    8000658a:	10001737          	lui	a4,0x10001
    8000658e:	533c                	lw	a5,96(a4)
    80006590:	8b8d                	andi	a5,a5,3
    80006592:	d37c                	sw	a5,100(a4)
    80006594:	0ff0000f          	fence
    80006598:	689c                	ld	a5,16(s1)
    8000659a:	0204d703          	lhu	a4,32(s1)
    8000659e:	0027d783          	lhu	a5,2(a5)
    800065a2:	04f70863          	beq	a4,a5,800065f2 <virtio_disk_intr+0x8a>
    800065a6:	0ff0000f          	fence
    800065aa:	6898                	ld	a4,16(s1)
    800065ac:	0204d783          	lhu	a5,32(s1)
    800065b0:	8b9d                	andi	a5,a5,7
    800065b2:	078e                	slli	a5,a5,0x3
    800065b4:	97ba                	add	a5,a5,a4
    800065b6:	43dc                	lw	a5,4(a5)
    800065b8:	00278713          	addi	a4,a5,2
    800065bc:	0712                	slli	a4,a4,0x4
    800065be:	9726                	add	a4,a4,s1
    800065c0:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    800065c4:	e721                	bnez	a4,8000660c <virtio_disk_intr+0xa4>
    800065c6:	0789                	addi	a5,a5,2
    800065c8:	0792                	slli	a5,a5,0x4
    800065ca:	97a6                	add	a5,a5,s1
    800065cc:	6788                	ld	a0,8(a5)
    800065ce:	00052223          	sw	zero,4(a0)
    800065d2:	ffffc097          	auipc	ra,0xffffc
    800065d6:	ae6080e7          	jalr	-1306(ra) # 800020b8 <wakeup>
    800065da:	0204d783          	lhu	a5,32(s1)
    800065de:	2785                	addiw	a5,a5,1
    800065e0:	17c2                	slli	a5,a5,0x30
    800065e2:	93c1                	srli	a5,a5,0x30
    800065e4:	02f49023          	sh	a5,32(s1)
    800065e8:	6898                	ld	a4,16(s1)
    800065ea:	00275703          	lhu	a4,2(a4)
    800065ee:	faf71ce3          	bne	a4,a5,800065a6 <virtio_disk_intr+0x3e>
    800065f2:	0001b517          	auipc	a0,0x1b
    800065f6:	78650513          	addi	a0,a0,1926 # 80021d78 <disk+0x128>
    800065fa:	ffffa097          	auipc	ra,0xffffa
    800065fe:	690080e7          	jalr	1680(ra) # 80000c8a <release>
    80006602:	60e2                	ld	ra,24(sp)
    80006604:	6442                	ld	s0,16(sp)
    80006606:	64a2                	ld	s1,8(sp)
    80006608:	6105                	addi	sp,sp,32
    8000660a:	8082                	ret
    8000660c:	00002517          	auipc	a0,0x2
    80006610:	26c50513          	addi	a0,a0,620 # 80008878 <syscalls+0x3e0>
    80006614:	ffffa097          	auipc	ra,0xffffa
    80006618:	f2a080e7          	jalr	-214(ra) # 8000053e <panic>
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
