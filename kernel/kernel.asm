
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	a5010113          	addi	sp,sp,-1456 # 80008a50 <stack0>
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
    80000056:	8be70713          	addi	a4,a4,-1858 # 80008910 <timer_scratch>
    8000005a:	9736                	add	a4,a4,a3
    8000005c:	ef1c                	sd	a5,24(a4)
    8000005e:	f310                	sd	a2,32(a4)
    80000060:	34071073          	csrw	mscratch,a4
    80000064:	00006797          	auipc	a5,0x6
    80000068:	f6c78793          	addi	a5,a5,-148 # 80005fd0 <timervec>
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
    8000009c:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffdca7f>
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
    80000130:	796080e7          	jalr	1942(ra) # 800028c2 <either_copyin>
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
    8000018e:	8c650513          	addi	a0,a0,-1850 # 80010a50 <cons>
    80000192:	00001097          	auipc	ra,0x1
    80000196:	a44080e7          	jalr	-1468(ra) # 80000bd6 <acquire>
    8000019a:	00011497          	auipc	s1,0x11
    8000019e:	8b648493          	addi	s1,s1,-1866 # 80010a50 <cons>
    800001a2:	00011917          	auipc	s2,0x11
    800001a6:	94690913          	addi	s2,s2,-1722 # 80010ae8 <cons+0x98>
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
    800001cc:	544080e7          	jalr	1348(ra) # 8000270c <killed>
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
    80000216:	65a080e7          	jalr	1626(ra) # 8000286c <either_copyout>
    8000021a:	01850663          	beq	a0,s8,80000226 <consoleread+0xc2>
    8000021e:	0a05                	addi	s4,s4,1
    80000220:	39fd                	addiw	s3,s3,-1
    80000222:	f99d17e3          	bne	s10,s9,800001b0 <consoleread+0x4c>
    80000226:	00011517          	auipc	a0,0x11
    8000022a:	82a50513          	addi	a0,a0,-2006 # 80010a50 <cons>
    8000022e:	00001097          	auipc	ra,0x1
    80000232:	a5c080e7          	jalr	-1444(ra) # 80000c8a <release>
    80000236:	413b053b          	subw	a0,s6,s3
    8000023a:	a811                	j	8000024e <consoleread+0xea>
    8000023c:	00011517          	auipc	a0,0x11
    80000240:	81450513          	addi	a0,a0,-2028 # 80010a50 <cons>
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
    80000276:	86f72b23          	sw	a5,-1930(a4) # 80010ae8 <cons+0x98>
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
    800002d0:	78450513          	addi	a0,a0,1924 # 80010a50 <cons>
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
    800002f6:	626080e7          	jalr	1574(ra) # 80002918 <procdump>
    800002fa:	00010517          	auipc	a0,0x10
    800002fe:	75650513          	addi	a0,a0,1878 # 80010a50 <cons>
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
    80000322:	73270713          	addi	a4,a4,1842 # 80010a50 <cons>
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
    8000034c:	70878793          	addi	a5,a5,1800 # 80010a50 <cons>
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
    8000037a:	7727a783          	lw	a5,1906(a5) # 80010ae8 <cons+0x98>
    8000037e:	9f1d                	subw	a4,a4,a5
    80000380:	08000793          	li	a5,128
    80000384:	f6f71be3          	bne	a4,a5,800002fa <consoleintr+0x3c>
    80000388:	a07d                	j	80000436 <consoleintr+0x178>
    8000038a:	00010717          	auipc	a4,0x10
    8000038e:	6c670713          	addi	a4,a4,1734 # 80010a50 <cons>
    80000392:	0a072783          	lw	a5,160(a4)
    80000396:	09c72703          	lw	a4,156(a4)
    8000039a:	00010497          	auipc	s1,0x10
    8000039e:	6b648493          	addi	s1,s1,1718 # 80010a50 <cons>
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
    800003da:	67a70713          	addi	a4,a4,1658 # 80010a50 <cons>
    800003de:	0a072783          	lw	a5,160(a4)
    800003e2:	09c72703          	lw	a4,156(a4)
    800003e6:	f0f70ae3          	beq	a4,a5,800002fa <consoleintr+0x3c>
    800003ea:	37fd                	addiw	a5,a5,-1
    800003ec:	00010717          	auipc	a4,0x10
    800003f0:	70f72223          	sw	a5,1796(a4) # 80010af0 <cons+0xa0>
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
    80000416:	63e78793          	addi	a5,a5,1598 # 80010a50 <cons>
    8000041a:	0a07a703          	lw	a4,160(a5)
    8000041e:	0017069b          	addiw	a3,a4,1
    80000422:	0006861b          	sext.w	a2,a3
    80000426:	0ad7a023          	sw	a3,160(a5)
    8000042a:	07f77713          	andi	a4,a4,127
    8000042e:	97ba                	add	a5,a5,a4
    80000430:	4729                	li	a4,10
    80000432:	00e78c23          	sb	a4,24(a5)
    80000436:	00010797          	auipc	a5,0x10
    8000043a:	6ac7ab23          	sw	a2,1718(a5) # 80010aec <cons+0x9c>
    8000043e:	00010517          	auipc	a0,0x10
    80000442:	6aa50513          	addi	a0,a0,1706 # 80010ae8 <cons+0x98>
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
    80000464:	5f050513          	addi	a0,a0,1520 # 80010a50 <cons>
    80000468:	00000097          	auipc	ra,0x0
    8000046c:	6de080e7          	jalr	1758(ra) # 80000b46 <initlock>
    80000470:	00000097          	auipc	ra,0x0
    80000474:	32a080e7          	jalr	810(ra) # 8000079a <uartinit>
    80000478:	00020797          	auipc	a5,0x20
    8000047c:	77078793          	addi	a5,a5,1904 # 80020be8 <devsw>
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
    8000054e:	5c07a323          	sw	zero,1478(a5) # 80010b10 <pr+0x18>
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
    80000582:	34f72923          	sw	a5,850(a4) # 800088d0 <panicked>
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
    800005be:	556dad83          	lw	s11,1366(s11) # 80010b10 <pr+0x18>
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
    800005fc:	50050513          	addi	a0,a0,1280 # 80010af8 <pr>
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
    8000075a:	3a250513          	addi	a0,a0,930 # 80010af8 <pr>
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
    80000776:	38648493          	addi	s1,s1,902 # 80010af8 <pr>
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
    800007d6:	34650513          	addi	a0,a0,838 # 80010b18 <uart_tx_lock>
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
    80000802:	0d27a783          	lw	a5,210(a5) # 800088d0 <panicked>
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
    8000083a:	0a27b783          	ld	a5,162(a5) # 800088d8 <uart_tx_r>
    8000083e:	00008717          	auipc	a4,0x8
    80000842:	0a273703          	ld	a4,162(a4) # 800088e0 <uart_tx_w>
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
    80000864:	2b8a0a13          	addi	s4,s4,696 # 80010b18 <uart_tx_lock>
    80000868:	00008497          	auipc	s1,0x8
    8000086c:	07048493          	addi	s1,s1,112 # 800088d8 <uart_tx_r>
    80000870:	00008997          	auipc	s3,0x8
    80000874:	07098993          	addi	s3,s3,112 # 800088e0 <uart_tx_w>
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
    800008d2:	24a50513          	addi	a0,a0,586 # 80010b18 <uart_tx_lock>
    800008d6:	00000097          	auipc	ra,0x0
    800008da:	300080e7          	jalr	768(ra) # 80000bd6 <acquire>
    800008de:	00008797          	auipc	a5,0x8
    800008e2:	ff27a783          	lw	a5,-14(a5) # 800088d0 <panicked>
    800008e6:	e7c9                	bnez	a5,80000970 <uartputc+0xb4>
    800008e8:	00008717          	auipc	a4,0x8
    800008ec:	ff873703          	ld	a4,-8(a4) # 800088e0 <uart_tx_w>
    800008f0:	00008797          	auipc	a5,0x8
    800008f4:	fe87b783          	ld	a5,-24(a5) # 800088d8 <uart_tx_r>
    800008f8:	02078793          	addi	a5,a5,32
    800008fc:	00010997          	auipc	s3,0x10
    80000900:	21c98993          	addi	s3,s3,540 # 80010b18 <uart_tx_lock>
    80000904:	00008497          	auipc	s1,0x8
    80000908:	fd448493          	addi	s1,s1,-44 # 800088d8 <uart_tx_r>
    8000090c:	00008917          	auipc	s2,0x8
    80000910:	fd490913          	addi	s2,s2,-44 # 800088e0 <uart_tx_w>
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
    80000936:	1e648493          	addi	s1,s1,486 # 80010b18 <uart_tx_lock>
    8000093a:	01f77793          	andi	a5,a4,31
    8000093e:	97a6                	add	a5,a5,s1
    80000940:	01478c23          	sb	s4,24(a5)
    80000944:	0705                	addi	a4,a4,1
    80000946:	00008797          	auipc	a5,0x8
    8000094a:	f8e7bd23          	sd	a4,-102(a5) # 800088e0 <uart_tx_w>
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
    800009c0:	15c48493          	addi	s1,s1,348 # 80010b18 <uart_tx_lock>
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
    80000a02:	38278793          	addi	a5,a5,898 # 80021d80 <end>
    80000a06:	04f56563          	bltu	a0,a5,80000a50 <kfree+0x66>
    80000a0a:	47c5                	li	a5,17
    80000a0c:	07ee                	slli	a5,a5,0x1b
    80000a0e:	04f57163          	bgeu	a0,a5,80000a50 <kfree+0x66>
    80000a12:	6605                	lui	a2,0x1
    80000a14:	4585                	li	a1,1
    80000a16:	00000097          	auipc	ra,0x0
    80000a1a:	2bc080e7          	jalr	700(ra) # 80000cd2 <memset>
    80000a1e:	00010917          	auipc	s2,0x10
    80000a22:	13290913          	addi	s2,s2,306 # 80010b50 <kmem>
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
    80000abe:	09650513          	addi	a0,a0,150 # 80010b50 <kmem>
    80000ac2:	00000097          	auipc	ra,0x0
    80000ac6:	084080e7          	jalr	132(ra) # 80000b46 <initlock>
    80000aca:	45c5                	li	a1,17
    80000acc:	05ee                	slli	a1,a1,0x1b
    80000ace:	00021517          	auipc	a0,0x21
    80000ad2:	2b250513          	addi	a0,a0,690 # 80021d80 <end>
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
    80000af4:	06048493          	addi	s1,s1,96 # 80010b50 <kmem>
    80000af8:	8526                	mv	a0,s1
    80000afa:	00000097          	auipc	ra,0x0
    80000afe:	0dc080e7          	jalr	220(ra) # 80000bd6 <acquire>
    80000b02:	6c84                	ld	s1,24(s1)
    80000b04:	c885                	beqz	s1,80000b34 <kalloc+0x4e>
    80000b06:	609c                	ld	a5,0(s1)
    80000b08:	00010517          	auipc	a0,0x10
    80000b0c:	04850513          	addi	a0,a0,72 # 80010b50 <kmem>
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
    80000b38:	01c50513          	addi	a0,a0,28 # 80010b50 <kmem>
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
    80000e8c:	a6070713          	addi	a4,a4,-1440 # 800088e8 <started>
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
    80000ec2:	b9a080e7          	jalr	-1126(ra) # 80002a58 <trapinithart>
    80000ec6:	00005097          	auipc	ra,0x5
    80000eca:	14a080e7          	jalr	330(ra) # 80006010 <plicinithart>
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
    80000f3a:	afa080e7          	jalr	-1286(ra) # 80002a30 <trapinit>
    80000f3e:	00002097          	auipc	ra,0x2
    80000f42:	b1a080e7          	jalr	-1254(ra) # 80002a58 <trapinithart>
    80000f46:	00005097          	auipc	ra,0x5
    80000f4a:	0b4080e7          	jalr	180(ra) # 80005ffa <plicinit>
    80000f4e:	00005097          	auipc	ra,0x5
    80000f52:	0c2080e7          	jalr	194(ra) # 80006010 <plicinithart>
    80000f56:	00002097          	auipc	ra,0x2
    80000f5a:	268080e7          	jalr	616(ra) # 800031be <binit>
    80000f5e:	00003097          	auipc	ra,0x3
    80000f62:	90c080e7          	jalr	-1780(ra) # 8000386a <iinit>
    80000f66:	00004097          	auipc	ra,0x4
    80000f6a:	8aa080e7          	jalr	-1878(ra) # 80004810 <fileinit>
    80000f6e:	00005097          	auipc	ra,0x5
    80000f72:	1aa080e7          	jalr	426(ra) # 80006118 <virtio_disk_init>
    80000f76:	00001097          	auipc	ra,0x1
    80000f7a:	d0e080e7          	jalr	-754(ra) # 80001c84 <userinit>
    80000f7e:	0ff0000f          	fence
    80000f82:	4785                	li	a5,1
    80000f84:	00008717          	auipc	a4,0x8
    80000f88:	96f72223          	sw	a5,-1692(a4) # 800088e8 <started>
    80000f8c:	b789                	j	80000ece <main+0x56>

0000000080000f8e <kvminithart>:
    80000f8e:	1141                	addi	sp,sp,-16
    80000f90:	e422                	sd	s0,8(sp)
    80000f92:	0800                	addi	s0,sp,16
    80000f94:	12000073          	sfence.vma
    80000f98:	00008797          	auipc	a5,0x8
    80000f9c:	9587b783          	ld	a5,-1704(a5) # 800088f0 <kernel_pigtable>
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
    80001258:	68a7be23          	sd	a0,1692(a5) # 800088f0 <kernel_pigtable>
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
    80001850:	75448493          	addi	s1,s1,1876 # 80010fa0 <proc>
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
    8000186a:	13aa0a13          	addi	s4,s4,314 # 800169a0 <tickslock>
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
    800018ec:	28850513          	addi	a0,a0,648 # 80010b70 <pid_lock>
    800018f0:	fffff097          	auipc	ra,0xfffff
    800018f4:	256080e7          	jalr	598(ra) # 80000b46 <initlock>
  initlock(&wait_lock, "wait_lock");
    800018f8:	00007597          	auipc	a1,0x7
    800018fc:	8f058593          	addi	a1,a1,-1808 # 800081e8 <digits+0x1a8>
    80001900:	0000f517          	auipc	a0,0xf
    80001904:	28850513          	addi	a0,a0,648 # 80010b88 <wait_lock>
    80001908:	fffff097          	auipc	ra,0xfffff
    8000190c:	23e080e7          	jalr	574(ra) # 80000b46 <initlock>
  for (p = proc; p < &proc[NPROC]; p++)
    80001910:	0000f497          	auipc	s1,0xf
    80001914:	69048493          	addi	s1,s1,1680 # 80010fa0 <proc>
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
    80001936:	06e98993          	addi	s3,s3,110 # 800169a0 <tickslock>
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
    800019a0:	20450513          	addi	a0,a0,516 # 80010ba0 <cpus>
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
    800019c8:	1ac70713          	addi	a4,a4,428 # 80010b70 <pid_lock>
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
    80001a00:	e847a783          	lw	a5,-380(a5) # 80008880 <first.1>
    80001a04:	eb89                	bnez	a5,80001a16 <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    80001a06:	00001097          	auipc	ra,0x1
    80001a0a:	06a080e7          	jalr	106(ra) # 80002a70 <usertrapret>
}
    80001a0e:	60a2                	ld	ra,8(sp)
    80001a10:	6402                	ld	s0,0(sp)
    80001a12:	0141                	addi	sp,sp,16
    80001a14:	8082                	ret
    first = 0;
    80001a16:	00007797          	auipc	a5,0x7
    80001a1a:	e607a523          	sw	zero,-406(a5) # 80008880 <first.1>
    fsinit(ROOTDEV);
    80001a1e:	4505                	li	a0,1
    80001a20:	00002097          	auipc	ra,0x2
    80001a24:	dca080e7          	jalr	-566(ra) # 800037ea <fsinit>
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
    80001a3a:	13a90913          	addi	s2,s2,314 # 80010b70 <pid_lock>
    80001a3e:	854a                	mv	a0,s2
    80001a40:	fffff097          	auipc	ra,0xfffff
    80001a44:	196080e7          	jalr	406(ra) # 80000bd6 <acquire>
  pid = nextpid;
    80001a48:	00007797          	auipc	a5,0x7
    80001a4c:	e3c78793          	addi	a5,a5,-452 # 80008884 <nextpid>
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
    80001bc6:	3de48493          	addi	s1,s1,990 # 80010fa0 <proc>
    80001bca:	00015917          	auipc	s2,0x15
    80001bce:	dd690913          	addi	s2,s2,-554 # 800169a0 <tickslock>
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
    80001c9c:	c6a7b023          	sd	a0,-928(a5) # 800088f8 <initproc>
  uvmfirst(p->pigtable, initcode, sizeof(initcode));
    80001ca0:	03400613          	li	a2,52
    80001ca4:	00007597          	auipc	a1,0x7
    80001ca8:	bec58593          	addi	a1,a1,-1044 # 80008890 <initcode>
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
    80001ce6:	52a080e7          	jalr	1322(ra) # 8000420c <namei>
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
    80001e16:	a90080e7          	jalr	-1392(ra) # 800048a2 <filedup>
    80001e1a:	00a93023          	sd	a0,0(s2)
    80001e1e:	b7e5                	j	80001e06 <fork+0xa4>
  np->cwd = idup(p->cwd);
    80001e20:	150ab503          	ld	a0,336(s5)
    80001e24:	00002097          	auipc	ra,0x2
    80001e28:	c04080e7          	jalr	-1020(ra) # 80003a28 <idup>
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
    80001e54:	d3848493          	addi	s1,s1,-712 # 80010b88 <wait_lock>
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
    80001ec2:	cb270713          	addi	a4,a4,-846 # 80010b70 <pid_lock>
    80001ec6:	9756                	add	a4,a4,s5
    80001ec8:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    80001ecc:	0000f717          	auipc	a4,0xf
    80001ed0:	cdc70713          	addi	a4,a4,-804 # 80010ba8 <cpus+0x8>
    80001ed4:	9aba                	add	s5,s5,a4
      if (p->state == RUNNABLE)
    80001ed6:	498d                	li	s3,3
        p->state = RUNNING;
    80001ed8:	4b11                	li	s6,4
        c->proc = p;
    80001eda:	079e                	slli	a5,a5,0x7
    80001edc:	0000fa17          	auipc	s4,0xf
    80001ee0:	c94a0a13          	addi	s4,s4,-876 # 80010b70 <pid_lock>
    80001ee4:	9a3e                	add	s4,s4,a5
    for (p = proc; p < &proc[NPROC]; p++)
    80001ee6:	00015917          	auipc	s2,0x15
    80001eea:	aba90913          	addi	s2,s2,-1350 # 800169a0 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001eee:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001ef2:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001ef6:	10079073          	csrw	sstatus,a5
    80001efa:	0000f497          	auipc	s1,0xf
    80001efe:	0a648493          	addi	s1,s1,166 # 80010fa0 <proc>
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
    80001f38:	a92080e7          	jalr	-1390(ra) # 800029c6 <swtch>
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
    80001f6e:	c0670713          	addi	a4,a4,-1018 # 80010b70 <pid_lock>
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
    80001f94:	be090913          	addi	s2,s2,-1056 # 80010b70 <pid_lock>
    80001f98:	2781                	sext.w	a5,a5
    80001f9a:	079e                	slli	a5,a5,0x7
    80001f9c:	97ca                	add	a5,a5,s2
    80001f9e:	0ac7a983          	lw	s3,172(a5)
    80001fa2:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    80001fa4:	2781                	sext.w	a5,a5
    80001fa6:	079e                	slli	a5,a5,0x7
    80001fa8:	0000f597          	auipc	a1,0xf
    80001fac:	c0058593          	addi	a1,a1,-1024 # 80010ba8 <cpus+0x8>
    80001fb0:	95be                	add	a1,a1,a5
    80001fb2:	06048513          	addi	a0,s1,96
    80001fb6:	00001097          	auipc	ra,0x1
    80001fba:	a10080e7          	jalr	-1520(ra) # 800029c6 <swtch>
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
    800020d0:	ed448493          	addi	s1,s1,-300 # 80010fa0 <proc>
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
    800020dc:	8c890913          	addi	s2,s2,-1848 # 800169a0 <tickslock>
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
    80002144:	e6048493          	addi	s1,s1,-416 # 80010fa0 <proc>
      pp->parent = initproc;
    80002148:	00006a17          	auipc	s4,0x6
    8000214c:	7b0a0a13          	addi	s4,s4,1968 # 800088f8 <initproc>
  for (pp = proc; pp < &proc[NPROC]; pp++)
    80002150:	00015997          	auipc	s3,0x15
    80002154:	85098993          	addi	s3,s3,-1968 # 800169a0 <tickslock>
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
    800021a8:	7547b783          	ld	a5,1876(a5) # 800088f8 <initproc>
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
    800021cc:	72c080e7          	jalr	1836(ra) # 800048f4 <fileclose>
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
    800021e4:	248080e7          	jalr	584(ra) # 80004428 <begin_op>
  iput(p->cwd);
    800021e8:	1509b503          	ld	a0,336(s3)
    800021ec:	00002097          	auipc	ra,0x2
    800021f0:	a34080e7          	jalr	-1484(ra) # 80003c20 <iput>
  end_op();
    800021f4:	00002097          	auipc	ra,0x2
    800021f8:	2b4080e7          	jalr	692(ra) # 800044a8 <end_op>
  p->cwd = 0;
    800021fc:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    80002200:	0000f497          	auipc	s1,0xf
    80002204:	98848493          	addi	s1,s1,-1656 # 80010b88 <wait_lock>
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
    80002272:	d3248493          	addi	s1,s1,-718 # 80010fa0 <proc>
    80002276:	00014997          	auipc	s3,0x14
    8000227a:	72a98993          	addi	s3,s3,1834 # 800169a0 <tickslock>
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
    800022d2:	34b7cf63          	blt	a5,a1,80002630 <print_pigs+0x360>
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
    80002340:	fac98993          	addi	s3,s3,-84 # 800082e8 <digits>
        print_pigs(child, pigdepth + 1);
    80002344:	001b869b          	addiw	a3,s7,1
    80002348:	ecd43c23          	sd	a3,-296(s0)
    8000234c:	ef140b13          	addi	s6,s0,-271
    80002350:	4785                	li	a5,1
    80002352:	9f99                	subw	a5,a5,a4
    80002354:	1782                	slli	a5,a5,0x20
    80002356:	9381                	srli	a5,a5,0x20
    80002358:	9b3e                	add	s6,s6,a5
    8000235a:	a461                	j	800025e2 <print_pigs+0x312>
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
    80002480:	aa99                	j	800025d6 <print_pigs+0x306>
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
    800025a6:	f9040713          	addi	a4,s0,-112
    800025aa:	97ba                	add	a5,a5,a4
    800025ac:	fad78823          	sb	a3,-80(a5)
        str[d++] = '\n';
    800025b0:	00a4879b          	addiw	a5,s1,10
    800025b4:	97ba                	add	a5,a5,a4
    800025b6:	4729                	li	a4,10
    800025b8:	fae78823          	sb	a4,-80(a5)
        str[d++] = '\0';
    800025bc:	24ad                	addiw	s1,s1,11
    800025be:	f9040793          	addi	a5,s0,-112
    800025c2:	94be                	add	s1,s1,a5
    800025c4:	fa048823          	sb	zero,-80(s1)

        printf(str, pte);
    800025c8:	85ca                	mv	a1,s2
    800025ca:	f4040513          	addi	a0,s0,-192
    800025ce:	ffffe097          	auipc	ra,0xffffe
    800025d2:	fba080e7          	jalr	-70(ra) # 80000588 <printf>
    for (int i = 0; i < 512; i++)
    800025d6:	2a05                	addiw	s4,s4,1
    800025d8:	0aa1                	addi	s5,s5,8
    800025da:	20000793          	li	a5,512
    800025de:	02fa0a63          	beq	s4,a5,80002612 <print_pigs+0x342>
      pte_t pte = pigtable[i];
    800025e2:	000ab903          	ld	s2,0(s5)
      if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
    800025e6:	00f97713          	andi	a4,s2,15
    800025ea:	4785                	li	a5,1
    800025ec:	d6f708e3          	beq	a4,a5,8000235c <print_pigs+0x8c>
      else if ((pte & PTE_V))
    800025f0:	00197793          	andi	a5,s2,1
    800025f4:	d3ed                	beqz	a5,800025d6 <print_pigs+0x306>
        int d = 0;
    800025f6:	4481                	li	s1,0
        for (; d < pigdepth; d++)
    800025f8:	e97058e3          	blez	s7,80002488 <print_pigs+0x1b8>
          str[d] = '\t';
    800025fc:	47a5                	li	a5,9
    800025fe:	f4f40023          	sb	a5,-192(s0)
        for (; d < pigdepth; d++)
    80002602:	4789                	li	a5,2
    80002604:	84de                	mv	s1,s7
    80002606:	e8fb91e3          	bne	s7,a5,80002488 <print_pigs+0x1b8>
          str[d] = '\t';
    8000260a:	47a5                	li	a5,9
    8000260c:	f4f400a3          	sb	a5,-191(s0)
        for (; d < pigdepth; d++)
    80002610:	bda5                	j	80002488 <print_pigs+0x1b8>
      }
    }
  }
}
    80002612:	70f2                	ld	ra,312(sp)
    80002614:	7452                	ld	s0,304(sp)
    80002616:	74b2                	ld	s1,296(sp)
    80002618:	7912                	ld	s2,288(sp)
    8000261a:	69f2                	ld	s3,280(sp)
    8000261c:	6a52                	ld	s4,272(sp)
    8000261e:	6ab2                	ld	s5,264(sp)
    80002620:	6b12                	ld	s6,256(sp)
    80002622:	7bee                	ld	s7,248(sp)
    80002624:	7c4e                	ld	s8,240(sp)
    80002626:	7cae                	ld	s9,232(sp)
    80002628:	7d0e                	ld	s10,224(sp)
    8000262a:	6dee                	ld	s11,216(sp)
    8000262c:	6131                	addi	sp,sp,320
    8000262e:	8082                	ret
    80002630:	8082                	ret

0000000080002632 <pigwalk>:

int pigwalk(int pid)
{
    80002632:	7179                	addi	sp,sp,-48
    80002634:	f406                	sd	ra,40(sp)
    80002636:	f022                	sd	s0,32(sp)
    80002638:	ec26                	sd	s1,24(sp)
    8000263a:	e84a                	sd	s2,16(sp)
    8000263c:	e44e                	sd	s3,8(sp)
    8000263e:	1800                	addi	s0,sp,48
    80002640:	892a                	mv	s2,a0
  if (pid == 0)
  {
    printf("invalid pig: %d\n", pid);
    return -1;
  }
  for (p = proc; p < &proc[NPROC]; p++)
    80002642:	0000f497          	auipc	s1,0xf
    80002646:	95e48493          	addi	s1,s1,-1698 # 80010fa0 <proc>
    8000264a:	00014997          	auipc	s3,0x14
    8000264e:	35698993          	addi	s3,s3,854 # 800169a0 <tickslock>
  if (pid == 0)
    80002652:	cd0d                	beqz	a0,8000268c <pigwalk+0x5a>
  {
    acquire(&p->lock);
    80002654:	8526                	mv	a0,s1
    80002656:	ffffe097          	auipc	ra,0xffffe
    8000265a:	580080e7          	jalr	1408(ra) # 80000bd6 <acquire>
    if (p->pid == pid)
    8000265e:	589c                	lw	a5,48(s1)
    80002660:	05278163          	beq	a5,s2,800026a2 <pigwalk+0x70>
      pigtable_t pigtable = p->pigtable;
      print_pigs(pigtable, 0);
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80002664:	8526                	mv	a0,s1
    80002666:	ffffe097          	auipc	ra,0xffffe
    8000266a:	624080e7          	jalr	1572(ra) # 80000c8a <release>
  for (p = proc; p < &proc[NPROC]; p++)
    8000266e:	16848493          	addi	s1,s1,360
    80002672:	ff3491e3          	bne	s1,s3,80002654 <pigwalk+0x22>
  }
  printf("invalid pig: %d\n", pid);
    80002676:	85ca                	mv	a1,s2
    80002678:	00006517          	auipc	a0,0x6
    8000267c:	c1050513          	addi	a0,a0,-1008 # 80008288 <digits+0x248>
    80002680:	ffffe097          	auipc	ra,0xffffe
    80002684:	f08080e7          	jalr	-248(ra) # 80000588 <printf>
  return -1;
    80002688:	557d                	li	a0,-1
    8000268a:	a805                	j	800026ba <pigwalk+0x88>
    printf("invalid pig: %d\n", pid);
    8000268c:	4581                	li	a1,0
    8000268e:	00006517          	auipc	a0,0x6
    80002692:	bfa50513          	addi	a0,a0,-1030 # 80008288 <digits+0x248>
    80002696:	ffffe097          	auipc	ra,0xffffe
    8000269a:	ef2080e7          	jalr	-270(ra) # 80000588 <printf>
    return -1;
    8000269e:	557d                	li	a0,-1
    800026a0:	a829                	j	800026ba <pigwalk+0x88>
      print_pigs(pigtable, 0);
    800026a2:	4581                	li	a1,0
    800026a4:	68a8                	ld	a0,80(s1)
    800026a6:	00000097          	auipc	ra,0x0
    800026aa:	c2a080e7          	jalr	-982(ra) # 800022d0 <print_pigs>
      release(&p->lock);
    800026ae:	8526                	mv	a0,s1
    800026b0:	ffffe097          	auipc	ra,0xffffe
    800026b4:	5da080e7          	jalr	1498(ra) # 80000c8a <release>
      return 0;
    800026b8:	4501                	li	a0,0
}
    800026ba:	70a2                	ld	ra,40(sp)
    800026bc:	7402                	ld	s0,32(sp)
    800026be:	64e2                	ld	s1,24(sp)
    800026c0:	6942                	ld	s2,16(sp)
    800026c2:	69a2                	ld	s3,8(sp)
    800026c4:	6145                	addi	sp,sp,48
    800026c6:	8082                	ret

00000000800026c8 <pigs>:

int pigs(int pid)
{
    800026c8:	1141                	addi	sp,sp,-16
    800026ca:	e406                	sd	ra,8(sp)
    800026cc:	e022                	sd	s0,0(sp)
    800026ce:	0800                	addi	s0,sp,16
  return pigwalk(pid);
    800026d0:	00000097          	auipc	ra,0x0
    800026d4:	f62080e7          	jalr	-158(ra) # 80002632 <pigwalk>
}
    800026d8:	60a2                	ld	ra,8(sp)
    800026da:	6402                	ld	s0,0(sp)
    800026dc:	0141                	addi	sp,sp,16
    800026de:	8082                	ret

00000000800026e0 <setkilled>:

void setkilled(struct proc *p)
{
    800026e0:	1101                	addi	sp,sp,-32
    800026e2:	ec06                	sd	ra,24(sp)
    800026e4:	e822                	sd	s0,16(sp)
    800026e6:	e426                	sd	s1,8(sp)
    800026e8:	1000                	addi	s0,sp,32
    800026ea:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800026ec:	ffffe097          	auipc	ra,0xffffe
    800026f0:	4ea080e7          	jalr	1258(ra) # 80000bd6 <acquire>
  p->killed = 1;
    800026f4:	4785                	li	a5,1
    800026f6:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    800026f8:	8526                	mv	a0,s1
    800026fa:	ffffe097          	auipc	ra,0xffffe
    800026fe:	590080e7          	jalr	1424(ra) # 80000c8a <release>
}
    80002702:	60e2                	ld	ra,24(sp)
    80002704:	6442                	ld	s0,16(sp)
    80002706:	64a2                	ld	s1,8(sp)
    80002708:	6105                	addi	sp,sp,32
    8000270a:	8082                	ret

000000008000270c <killed>:

int killed(struct proc *p)
{
    8000270c:	1101                	addi	sp,sp,-32
    8000270e:	ec06                	sd	ra,24(sp)
    80002710:	e822                	sd	s0,16(sp)
    80002712:	e426                	sd	s1,8(sp)
    80002714:	e04a                	sd	s2,0(sp)
    80002716:	1000                	addi	s0,sp,32
    80002718:	84aa                	mv	s1,a0
  int k;

  acquire(&p->lock);
    8000271a:	ffffe097          	auipc	ra,0xffffe
    8000271e:	4bc080e7          	jalr	1212(ra) # 80000bd6 <acquire>
  k = p->killed;
    80002722:	0284a903          	lw	s2,40(s1)
  release(&p->lock);
    80002726:	8526                	mv	a0,s1
    80002728:	ffffe097          	auipc	ra,0xffffe
    8000272c:	562080e7          	jalr	1378(ra) # 80000c8a <release>
  return k;
}
    80002730:	854a                	mv	a0,s2
    80002732:	60e2                	ld	ra,24(sp)
    80002734:	6442                	ld	s0,16(sp)
    80002736:	64a2                	ld	s1,8(sp)
    80002738:	6902                	ld	s2,0(sp)
    8000273a:	6105                	addi	sp,sp,32
    8000273c:	8082                	ret

000000008000273e <wait>:
{
    8000273e:	715d                	addi	sp,sp,-80
    80002740:	e486                	sd	ra,72(sp)
    80002742:	e0a2                	sd	s0,64(sp)
    80002744:	fc26                	sd	s1,56(sp)
    80002746:	f84a                	sd	s2,48(sp)
    80002748:	f44e                	sd	s3,40(sp)
    8000274a:	f052                	sd	s4,32(sp)
    8000274c:	ec56                	sd	s5,24(sp)
    8000274e:	e85a                	sd	s6,16(sp)
    80002750:	e45e                	sd	s7,8(sp)
    80002752:	e062                	sd	s8,0(sp)
    80002754:	0880                	addi	s0,sp,80
    80002756:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    80002758:	fffff097          	auipc	ra,0xfffff
    8000275c:	254080e7          	jalr	596(ra) # 800019ac <myproc>
    80002760:	892a                	mv	s2,a0
  acquire(&wait_lock);
    80002762:	0000e517          	auipc	a0,0xe
    80002766:	42650513          	addi	a0,a0,1062 # 80010b88 <wait_lock>
    8000276a:	ffffe097          	auipc	ra,0xffffe
    8000276e:	46c080e7          	jalr	1132(ra) # 80000bd6 <acquire>
    havekids = 0;
    80002772:	4b81                	li	s7,0
        if (pp->state == ZOMBIE)
    80002774:	4a15                	li	s4,5
        havekids = 1;
    80002776:	4a85                	li	s5,1
    for (pp = proc; pp < &proc[NPROC]; pp++)
    80002778:	00014997          	auipc	s3,0x14
    8000277c:	22898993          	addi	s3,s3,552 # 800169a0 <tickslock>
    sleep(p, &wait_lock); // DOC: wait-sleep
    80002780:	0000ec17          	auipc	s8,0xe
    80002784:	408c0c13          	addi	s8,s8,1032 # 80010b88 <wait_lock>
    havekids = 0;
    80002788:	875e                	mv	a4,s7
    for (pp = proc; pp < &proc[NPROC]; pp++)
    8000278a:	0000f497          	auipc	s1,0xf
    8000278e:	81648493          	addi	s1,s1,-2026 # 80010fa0 <proc>
    80002792:	a0bd                	j	80002800 <wait+0xc2>
          pid = pp->pid;
    80002794:	0304a983          	lw	s3,48(s1)
          if (addr != 0 && copyout(p->pigtable, addr, (char *)&pp->xstate,
    80002798:	000b0e63          	beqz	s6,800027b4 <wait+0x76>
    8000279c:	4691                	li	a3,4
    8000279e:	02c48613          	addi	a2,s1,44
    800027a2:	85da                	mv	a1,s6
    800027a4:	05093503          	ld	a0,80(s2)
    800027a8:	fffff097          	auipc	ra,0xfffff
    800027ac:	ec0080e7          	jalr	-320(ra) # 80001668 <copyout>
    800027b0:	02054563          	bltz	a0,800027da <wait+0x9c>
          freeproc(pp);
    800027b4:	8526                	mv	a0,s1
    800027b6:	fffff097          	auipc	ra,0xfffff
    800027ba:	3a8080e7          	jalr	936(ra) # 80001b5e <freeproc>
          release(&pp->lock);
    800027be:	8526                	mv	a0,s1
    800027c0:	ffffe097          	auipc	ra,0xffffe
    800027c4:	4ca080e7          	jalr	1226(ra) # 80000c8a <release>
          release(&wait_lock);
    800027c8:	0000e517          	auipc	a0,0xe
    800027cc:	3c050513          	addi	a0,a0,960 # 80010b88 <wait_lock>
    800027d0:	ffffe097          	auipc	ra,0xffffe
    800027d4:	4ba080e7          	jalr	1210(ra) # 80000c8a <release>
          return pid;
    800027d8:	a0b5                	j	80002844 <wait+0x106>
            release(&pp->lock);
    800027da:	8526                	mv	a0,s1
    800027dc:	ffffe097          	auipc	ra,0xffffe
    800027e0:	4ae080e7          	jalr	1198(ra) # 80000c8a <release>
            release(&wait_lock);
    800027e4:	0000e517          	auipc	a0,0xe
    800027e8:	3a450513          	addi	a0,a0,932 # 80010b88 <wait_lock>
    800027ec:	ffffe097          	auipc	ra,0xffffe
    800027f0:	49e080e7          	jalr	1182(ra) # 80000c8a <release>
            return -1;
    800027f4:	59fd                	li	s3,-1
    800027f6:	a0b9                	j	80002844 <wait+0x106>
    for (pp = proc; pp < &proc[NPROC]; pp++)
    800027f8:	16848493          	addi	s1,s1,360
    800027fc:	03348463          	beq	s1,s3,80002824 <wait+0xe6>
      if (pp->parent == p)
    80002800:	7c9c                	ld	a5,56(s1)
    80002802:	ff279be3          	bne	a5,s2,800027f8 <wait+0xba>
        acquire(&pp->lock);
    80002806:	8526                	mv	a0,s1
    80002808:	ffffe097          	auipc	ra,0xffffe
    8000280c:	3ce080e7          	jalr	974(ra) # 80000bd6 <acquire>
        if (pp->state == ZOMBIE)
    80002810:	4c9c                	lw	a5,24(s1)
    80002812:	f94781e3          	beq	a5,s4,80002794 <wait+0x56>
        release(&pp->lock);
    80002816:	8526                	mv	a0,s1
    80002818:	ffffe097          	auipc	ra,0xffffe
    8000281c:	472080e7          	jalr	1138(ra) # 80000c8a <release>
        havekids = 1;
    80002820:	8756                	mv	a4,s5
    80002822:	bfd9                	j	800027f8 <wait+0xba>
    if (!havekids || killed(p))
    80002824:	c719                	beqz	a4,80002832 <wait+0xf4>
    80002826:	854a                	mv	a0,s2
    80002828:	00000097          	auipc	ra,0x0
    8000282c:	ee4080e7          	jalr	-284(ra) # 8000270c <killed>
    80002830:	c51d                	beqz	a0,8000285e <wait+0x120>
      release(&wait_lock);
    80002832:	0000e517          	auipc	a0,0xe
    80002836:	35650513          	addi	a0,a0,854 # 80010b88 <wait_lock>
    8000283a:	ffffe097          	auipc	ra,0xffffe
    8000283e:	450080e7          	jalr	1104(ra) # 80000c8a <release>
      return -1;
    80002842:	59fd                	li	s3,-1
}
    80002844:	854e                	mv	a0,s3
    80002846:	60a6                	ld	ra,72(sp)
    80002848:	6406                	ld	s0,64(sp)
    8000284a:	74e2                	ld	s1,56(sp)
    8000284c:	7942                	ld	s2,48(sp)
    8000284e:	79a2                	ld	s3,40(sp)
    80002850:	7a02                	ld	s4,32(sp)
    80002852:	6ae2                	ld	s5,24(sp)
    80002854:	6b42                	ld	s6,16(sp)
    80002856:	6ba2                	ld	s7,8(sp)
    80002858:	6c02                	ld	s8,0(sp)
    8000285a:	6161                	addi	sp,sp,80
    8000285c:	8082                	ret
    sleep(p, &wait_lock); // DOC: wait-sleep
    8000285e:	85e2                	mv	a1,s8
    80002860:	854a                	mv	a0,s2
    80002862:	fffff097          	auipc	ra,0xfffff
    80002866:	7f2080e7          	jalr	2034(ra) # 80002054 <sleep>
    havekids = 0;
    8000286a:	bf39                	j	80002788 <wait+0x4a>

000000008000286c <either_copyout>:

// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    8000286c:	7179                	addi	sp,sp,-48
    8000286e:	f406                	sd	ra,40(sp)
    80002870:	f022                	sd	s0,32(sp)
    80002872:	ec26                	sd	s1,24(sp)
    80002874:	e84a                	sd	s2,16(sp)
    80002876:	e44e                	sd	s3,8(sp)
    80002878:	e052                	sd	s4,0(sp)
    8000287a:	1800                	addi	s0,sp,48
    8000287c:	84aa                	mv	s1,a0
    8000287e:	892e                	mv	s2,a1
    80002880:	89b2                	mv	s3,a2
    80002882:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80002884:	fffff097          	auipc	ra,0xfffff
    80002888:	128080e7          	jalr	296(ra) # 800019ac <myproc>
  if (user_dst)
    8000288c:	c08d                	beqz	s1,800028ae <either_copyout+0x42>
  {
    return copyout(p->pigtable, dst, src, len);
    8000288e:	86d2                	mv	a3,s4
    80002890:	864e                	mv	a2,s3
    80002892:	85ca                	mv	a1,s2
    80002894:	6928                	ld	a0,80(a0)
    80002896:	fffff097          	auipc	ra,0xfffff
    8000289a:	dd2080e7          	jalr	-558(ra) # 80001668 <copyout>
  else
  {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    8000289e:	70a2                	ld	ra,40(sp)
    800028a0:	7402                	ld	s0,32(sp)
    800028a2:	64e2                	ld	s1,24(sp)
    800028a4:	6942                	ld	s2,16(sp)
    800028a6:	69a2                	ld	s3,8(sp)
    800028a8:	6a02                	ld	s4,0(sp)
    800028aa:	6145                	addi	sp,sp,48
    800028ac:	8082                	ret
    memmove((char *)dst, src, len);
    800028ae:	000a061b          	sext.w	a2,s4
    800028b2:	85ce                	mv	a1,s3
    800028b4:	854a                	mv	a0,s2
    800028b6:	ffffe097          	auipc	ra,0xffffe
    800028ba:	478080e7          	jalr	1144(ra) # 80000d2e <memmove>
    return 0;
    800028be:	8526                	mv	a0,s1
    800028c0:	bff9                	j	8000289e <either_copyout+0x32>

00000000800028c2 <either_copyin>:

// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    800028c2:	7179                	addi	sp,sp,-48
    800028c4:	f406                	sd	ra,40(sp)
    800028c6:	f022                	sd	s0,32(sp)
    800028c8:	ec26                	sd	s1,24(sp)
    800028ca:	e84a                	sd	s2,16(sp)
    800028cc:	e44e                	sd	s3,8(sp)
    800028ce:	e052                	sd	s4,0(sp)
    800028d0:	1800                	addi	s0,sp,48
    800028d2:	892a                	mv	s2,a0
    800028d4:	84ae                	mv	s1,a1
    800028d6:	89b2                	mv	s3,a2
    800028d8:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800028da:	fffff097          	auipc	ra,0xfffff
    800028de:	0d2080e7          	jalr	210(ra) # 800019ac <myproc>
  if (user_src)
    800028e2:	c08d                	beqz	s1,80002904 <either_copyin+0x42>
  {
    return copyin(p->pigtable, dst, src, len);
    800028e4:	86d2                	mv	a3,s4
    800028e6:	864e                	mv	a2,s3
    800028e8:	85ca                	mv	a1,s2
    800028ea:	6928                	ld	a0,80(a0)
    800028ec:	fffff097          	auipc	ra,0xfffff
    800028f0:	e08080e7          	jalr	-504(ra) # 800016f4 <copyin>
  else
  {
    memmove(dst, (char *)src, len);
    return 0;
  }
}
    800028f4:	70a2                	ld	ra,40(sp)
    800028f6:	7402                	ld	s0,32(sp)
    800028f8:	64e2                	ld	s1,24(sp)
    800028fa:	6942                	ld	s2,16(sp)
    800028fc:	69a2                	ld	s3,8(sp)
    800028fe:	6a02                	ld	s4,0(sp)
    80002900:	6145                	addi	sp,sp,48
    80002902:	8082                	ret
    memmove(dst, (char *)src, len);
    80002904:	000a061b          	sext.w	a2,s4
    80002908:	85ce                	mv	a1,s3
    8000290a:	854a                	mv	a0,s2
    8000290c:	ffffe097          	auipc	ra,0xffffe
    80002910:	422080e7          	jalr	1058(ra) # 80000d2e <memmove>
    return 0;
    80002914:	8526                	mv	a0,s1
    80002916:	bff9                	j	800028f4 <either_copyin+0x32>

0000000080002918 <procdump>:

// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void procdump(void)
{
    80002918:	715d                	addi	sp,sp,-80
    8000291a:	e486                	sd	ra,72(sp)
    8000291c:	e0a2                	sd	s0,64(sp)
    8000291e:	fc26                	sd	s1,56(sp)
    80002920:	f84a                	sd	s2,48(sp)
    80002922:	f44e                	sd	s3,40(sp)
    80002924:	f052                	sd	s4,32(sp)
    80002926:	ec56                	sd	s5,24(sp)
    80002928:	e85a                	sd	s6,16(sp)
    8000292a:	e45e                	sd	s7,8(sp)
    8000292c:	0880                	addi	s0,sp,80
      [RUNNING] "run   ",
      [ZOMBIE] "zombie"};
  struct proc *p;
  char *state;

  printf("\n");
    8000292e:	00005517          	auipc	a0,0x5
    80002932:	79a50513          	addi	a0,a0,1946 # 800080c8 <digits+0x88>
    80002936:	ffffe097          	auipc	ra,0xffffe
    8000293a:	c52080e7          	jalr	-942(ra) # 80000588 <printf>
  for (p = proc; p < &proc[NPROC]; p++)
    8000293e:	0000e497          	auipc	s1,0xe
    80002942:	7ba48493          	addi	s1,s1,1978 # 800110f8 <proc+0x158>
    80002946:	00014917          	auipc	s2,0x14
    8000294a:	1b290913          	addi	s2,s2,434 # 80016af8 <bcache+0x140>
  {
    if (p->state == UNUSED)
      continue;
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    8000294e:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80002950:	00006997          	auipc	s3,0x6
    80002954:	95098993          	addi	s3,s3,-1712 # 800082a0 <digits+0x260>
    printf("%d %s %s", p->pid, state, p->name);
    80002958:	00006a97          	auipc	s5,0x6
    8000295c:	950a8a93          	addi	s5,s5,-1712 # 800082a8 <digits+0x268>
    printf("\n");
    80002960:	00005a17          	auipc	s4,0x5
    80002964:	768a0a13          	addi	s4,s4,1896 # 800080c8 <digits+0x88>
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002968:	00006b97          	auipc	s7,0x6
    8000296c:	980b8b93          	addi	s7,s7,-1664 # 800082e8 <digits>
    80002970:	a00d                	j	80002992 <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    80002972:	ed86a583          	lw	a1,-296(a3)
    80002976:	8556                	mv	a0,s5
    80002978:	ffffe097          	auipc	ra,0xffffe
    8000297c:	c10080e7          	jalr	-1008(ra) # 80000588 <printf>
    printf("\n");
    80002980:	8552                	mv	a0,s4
    80002982:	ffffe097          	auipc	ra,0xffffe
    80002986:	c06080e7          	jalr	-1018(ra) # 80000588 <printf>
  for (p = proc; p < &proc[NPROC]; p++)
    8000298a:	16848493          	addi	s1,s1,360
    8000298e:	03248163          	beq	s1,s2,800029b0 <procdump+0x98>
    if (p->state == UNUSED)
    80002992:	86a6                	mv	a3,s1
    80002994:	ec04a783          	lw	a5,-320(s1)
    80002998:	dbed                	beqz	a5,8000298a <procdump+0x72>
      state = "???";
    8000299a:	864e                	mv	a2,s3
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    8000299c:	fcfb6be3          	bltu	s6,a5,80002972 <procdump+0x5a>
    800029a0:	1782                	slli	a5,a5,0x20
    800029a2:	9381                	srli	a5,a5,0x20
    800029a4:	078e                	slli	a5,a5,0x3
    800029a6:	97de                	add	a5,a5,s7
    800029a8:	6f90                	ld	a2,24(a5)
    800029aa:	f661                	bnez	a2,80002972 <procdump+0x5a>
      state = "???";
    800029ac:	864e                	mv	a2,s3
    800029ae:	b7d1                	j	80002972 <procdump+0x5a>
  }
}
    800029b0:	60a6                	ld	ra,72(sp)
    800029b2:	6406                	ld	s0,64(sp)
    800029b4:	74e2                	ld	s1,56(sp)
    800029b6:	7942                	ld	s2,48(sp)
    800029b8:	79a2                	ld	s3,40(sp)
    800029ba:	7a02                	ld	s4,32(sp)
    800029bc:	6ae2                	ld	s5,24(sp)
    800029be:	6b42                	ld	s6,16(sp)
    800029c0:	6ba2                	ld	s7,8(sp)
    800029c2:	6161                	addi	sp,sp,80
    800029c4:	8082                	ret

00000000800029c6 <swtch>:
    800029c6:	00153023          	sd	ra,0(a0)
    800029ca:	00253423          	sd	sp,8(a0)
    800029ce:	e900                	sd	s0,16(a0)
    800029d0:	ed04                	sd	s1,24(a0)
    800029d2:	03253023          	sd	s2,32(a0)
    800029d6:	03353423          	sd	s3,40(a0)
    800029da:	03453823          	sd	s4,48(a0)
    800029de:	03553c23          	sd	s5,56(a0)
    800029e2:	05653023          	sd	s6,64(a0)
    800029e6:	05753423          	sd	s7,72(a0)
    800029ea:	05853823          	sd	s8,80(a0)
    800029ee:	05953c23          	sd	s9,88(a0)
    800029f2:	07a53023          	sd	s10,96(a0)
    800029f6:	07b53423          	sd	s11,104(a0)
    800029fa:	0005b083          	ld	ra,0(a1)
    800029fe:	0085b103          	ld	sp,8(a1)
    80002a02:	6980                	ld	s0,16(a1)
    80002a04:	6d84                	ld	s1,24(a1)
    80002a06:	0205b903          	ld	s2,32(a1)
    80002a0a:	0285b983          	ld	s3,40(a1)
    80002a0e:	0305ba03          	ld	s4,48(a1)
    80002a12:	0385ba83          	ld	s5,56(a1)
    80002a16:	0405bb03          	ld	s6,64(a1)
    80002a1a:	0485bb83          	ld	s7,72(a1)
    80002a1e:	0505bc03          	ld	s8,80(a1)
    80002a22:	0585bc83          	ld	s9,88(a1)
    80002a26:	0605bd03          	ld	s10,96(a1)
    80002a2a:	0685bd83          	ld	s11,104(a1)
    80002a2e:	8082                	ret

0000000080002a30 <trapinit>:
    80002a30:	1141                	addi	sp,sp,-16
    80002a32:	e406                	sd	ra,8(sp)
    80002a34:	e022                	sd	s0,0(sp)
    80002a36:	0800                	addi	s0,sp,16
    80002a38:	00006597          	auipc	a1,0x6
    80002a3c:	8f858593          	addi	a1,a1,-1800 # 80008330 <states.0+0x30>
    80002a40:	00014517          	auipc	a0,0x14
    80002a44:	f6050513          	addi	a0,a0,-160 # 800169a0 <tickslock>
    80002a48:	ffffe097          	auipc	ra,0xffffe
    80002a4c:	0fe080e7          	jalr	254(ra) # 80000b46 <initlock>
    80002a50:	60a2                	ld	ra,8(sp)
    80002a52:	6402                	ld	s0,0(sp)
    80002a54:	0141                	addi	sp,sp,16
    80002a56:	8082                	ret

0000000080002a58 <trapinithart>:
    80002a58:	1141                	addi	sp,sp,-16
    80002a5a:	e422                	sd	s0,8(sp)
    80002a5c:	0800                	addi	s0,sp,16
    80002a5e:	00003797          	auipc	a5,0x3
    80002a62:	4e278793          	addi	a5,a5,1250 # 80005f40 <kernelvec>
    80002a66:	10579073          	csrw	stvec,a5
    80002a6a:	6422                	ld	s0,8(sp)
    80002a6c:	0141                	addi	sp,sp,16
    80002a6e:	8082                	ret

0000000080002a70 <usertrapret>:
    80002a70:	1141                	addi	sp,sp,-16
    80002a72:	e406                	sd	ra,8(sp)
    80002a74:	e022                	sd	s0,0(sp)
    80002a76:	0800                	addi	s0,sp,16
    80002a78:	fffff097          	auipc	ra,0xfffff
    80002a7c:	f34080e7          	jalr	-204(ra) # 800019ac <myproc>
    80002a80:	100027f3          	csrr	a5,sstatus
    80002a84:	9bf5                	andi	a5,a5,-3
    80002a86:	10079073          	csrw	sstatus,a5
    80002a8a:	00004617          	auipc	a2,0x4
    80002a8e:	57660613          	addi	a2,a2,1398 # 80007000 <_trampoline>
    80002a92:	00004697          	auipc	a3,0x4
    80002a96:	56e68693          	addi	a3,a3,1390 # 80007000 <_trampoline>
    80002a9a:	8e91                	sub	a3,a3,a2
    80002a9c:	040007b7          	lui	a5,0x4000
    80002aa0:	17fd                	addi	a5,a5,-1
    80002aa2:	07b2                	slli	a5,a5,0xc
    80002aa4:	96be                	add	a3,a3,a5
    80002aa6:	10569073          	csrw	stvec,a3
    80002aaa:	6d38                	ld	a4,88(a0)
    80002aac:	180026f3          	csrr	a3,satp
    80002ab0:	e314                	sd	a3,0(a4)
    80002ab2:	6d38                	ld	a4,88(a0)
    80002ab4:	6134                	ld	a3,64(a0)
    80002ab6:	6585                	lui	a1,0x1
    80002ab8:	96ae                	add	a3,a3,a1
    80002aba:	e714                	sd	a3,8(a4)
    80002abc:	6d38                	ld	a4,88(a0)
    80002abe:	00000697          	auipc	a3,0x0
    80002ac2:	13068693          	addi	a3,a3,304 # 80002bee <usertrap>
    80002ac6:	eb14                	sd	a3,16(a4)
    80002ac8:	6d38                	ld	a4,88(a0)
    80002aca:	8692                	mv	a3,tp
    80002acc:	f314                	sd	a3,32(a4)
    80002ace:	100026f3          	csrr	a3,sstatus
    80002ad2:	eff6f693          	andi	a3,a3,-257
    80002ad6:	0206e693          	ori	a3,a3,32
    80002ada:	10069073          	csrw	sstatus,a3
    80002ade:	6d38                	ld	a4,88(a0)
    80002ae0:	6f18                	ld	a4,24(a4)
    80002ae2:	14171073          	csrw	sepc,a4
    80002ae6:	6928                	ld	a0,80(a0)
    80002ae8:	8131                	srli	a0,a0,0xc
    80002aea:	00004717          	auipc	a4,0x4
    80002aee:	5b270713          	addi	a4,a4,1458 # 8000709c <userret>
    80002af2:	8f11                	sub	a4,a4,a2
    80002af4:	97ba                	add	a5,a5,a4
    80002af6:	577d                	li	a4,-1
    80002af8:	177e                	slli	a4,a4,0x3f
    80002afa:	8d59                	or	a0,a0,a4
    80002afc:	9782                	jalr	a5
    80002afe:	60a2                	ld	ra,8(sp)
    80002b00:	6402                	ld	s0,0(sp)
    80002b02:	0141                	addi	sp,sp,16
    80002b04:	8082                	ret

0000000080002b06 <clockintr>:
    80002b06:	1101                	addi	sp,sp,-32
    80002b08:	ec06                	sd	ra,24(sp)
    80002b0a:	e822                	sd	s0,16(sp)
    80002b0c:	e426                	sd	s1,8(sp)
    80002b0e:	1000                	addi	s0,sp,32
    80002b10:	00014497          	auipc	s1,0x14
    80002b14:	e9048493          	addi	s1,s1,-368 # 800169a0 <tickslock>
    80002b18:	8526                	mv	a0,s1
    80002b1a:	ffffe097          	auipc	ra,0xffffe
    80002b1e:	0bc080e7          	jalr	188(ra) # 80000bd6 <acquire>
    80002b22:	00006517          	auipc	a0,0x6
    80002b26:	dde50513          	addi	a0,a0,-546 # 80008900 <ticks>
    80002b2a:	411c                	lw	a5,0(a0)
    80002b2c:	2785                	addiw	a5,a5,1
    80002b2e:	c11c                	sw	a5,0(a0)
    80002b30:	fffff097          	auipc	ra,0xfffff
    80002b34:	588080e7          	jalr	1416(ra) # 800020b8 <wakeup>
    80002b38:	8526                	mv	a0,s1
    80002b3a:	ffffe097          	auipc	ra,0xffffe
    80002b3e:	150080e7          	jalr	336(ra) # 80000c8a <release>
    80002b42:	60e2                	ld	ra,24(sp)
    80002b44:	6442                	ld	s0,16(sp)
    80002b46:	64a2                	ld	s1,8(sp)
    80002b48:	6105                	addi	sp,sp,32
    80002b4a:	8082                	ret

0000000080002b4c <devintr>:
    80002b4c:	1101                	addi	sp,sp,-32
    80002b4e:	ec06                	sd	ra,24(sp)
    80002b50:	e822                	sd	s0,16(sp)
    80002b52:	e426                	sd	s1,8(sp)
    80002b54:	1000                	addi	s0,sp,32
    80002b56:	14202773          	csrr	a4,scause
    80002b5a:	00074d63          	bltz	a4,80002b74 <devintr+0x28>
    80002b5e:	57fd                	li	a5,-1
    80002b60:	17fe                	slli	a5,a5,0x3f
    80002b62:	0785                	addi	a5,a5,1
    80002b64:	4501                	li	a0,0
    80002b66:	06f70363          	beq	a4,a5,80002bcc <devintr+0x80>
    80002b6a:	60e2                	ld	ra,24(sp)
    80002b6c:	6442                	ld	s0,16(sp)
    80002b6e:	64a2                	ld	s1,8(sp)
    80002b70:	6105                	addi	sp,sp,32
    80002b72:	8082                	ret
    80002b74:	0ff77793          	andi	a5,a4,255
    80002b78:	46a5                	li	a3,9
    80002b7a:	fed792e3          	bne	a5,a3,80002b5e <devintr+0x12>
    80002b7e:	00003097          	auipc	ra,0x3
    80002b82:	4ca080e7          	jalr	1226(ra) # 80006048 <plic_claim>
    80002b86:	84aa                	mv	s1,a0
    80002b88:	47a9                	li	a5,10
    80002b8a:	02f50763          	beq	a0,a5,80002bb8 <devintr+0x6c>
    80002b8e:	4785                	li	a5,1
    80002b90:	02f50963          	beq	a0,a5,80002bc2 <devintr+0x76>
    80002b94:	4505                	li	a0,1
    80002b96:	d8f1                	beqz	s1,80002b6a <devintr+0x1e>
    80002b98:	85a6                	mv	a1,s1
    80002b9a:	00005517          	auipc	a0,0x5
    80002b9e:	79e50513          	addi	a0,a0,1950 # 80008338 <states.0+0x38>
    80002ba2:	ffffe097          	auipc	ra,0xffffe
    80002ba6:	9e6080e7          	jalr	-1562(ra) # 80000588 <printf>
    80002baa:	8526                	mv	a0,s1
    80002bac:	00003097          	auipc	ra,0x3
    80002bb0:	4c0080e7          	jalr	1216(ra) # 8000606c <plic_complete>
    80002bb4:	4505                	li	a0,1
    80002bb6:	bf55                	j	80002b6a <devintr+0x1e>
    80002bb8:	ffffe097          	auipc	ra,0xffffe
    80002bbc:	de2080e7          	jalr	-542(ra) # 8000099a <uartintr>
    80002bc0:	b7ed                	j	80002baa <devintr+0x5e>
    80002bc2:	00004097          	auipc	ra,0x4
    80002bc6:	976080e7          	jalr	-1674(ra) # 80006538 <virtio_disk_intr>
    80002bca:	b7c5                	j	80002baa <devintr+0x5e>
    80002bcc:	fffff097          	auipc	ra,0xfffff
    80002bd0:	db4080e7          	jalr	-588(ra) # 80001980 <cpuid>
    80002bd4:	c901                	beqz	a0,80002be4 <devintr+0x98>
    80002bd6:	144027f3          	csrr	a5,sip
    80002bda:	9bf5                	andi	a5,a5,-3
    80002bdc:	14479073          	csrw	sip,a5
    80002be0:	4509                	li	a0,2
    80002be2:	b761                	j	80002b6a <devintr+0x1e>
    80002be4:	00000097          	auipc	ra,0x0
    80002be8:	f22080e7          	jalr	-222(ra) # 80002b06 <clockintr>
    80002bec:	b7ed                	j	80002bd6 <devintr+0x8a>

0000000080002bee <usertrap>:
    80002bee:	1101                	addi	sp,sp,-32
    80002bf0:	ec06                	sd	ra,24(sp)
    80002bf2:	e822                	sd	s0,16(sp)
    80002bf4:	e426                	sd	s1,8(sp)
    80002bf6:	e04a                	sd	s2,0(sp)
    80002bf8:	1000                	addi	s0,sp,32
    80002bfa:	100027f3          	csrr	a5,sstatus
    80002bfe:	1007f793          	andi	a5,a5,256
    80002c02:	e3b1                	bnez	a5,80002c46 <usertrap+0x58>
    80002c04:	00003797          	auipc	a5,0x3
    80002c08:	33c78793          	addi	a5,a5,828 # 80005f40 <kernelvec>
    80002c0c:	10579073          	csrw	stvec,a5
    80002c10:	fffff097          	auipc	ra,0xfffff
    80002c14:	d9c080e7          	jalr	-612(ra) # 800019ac <myproc>
    80002c18:	84aa                	mv	s1,a0
    80002c1a:	6d3c                	ld	a5,88(a0)
    80002c1c:	14102773          	csrr	a4,sepc
    80002c20:	ef98                	sd	a4,24(a5)
    80002c22:	14202773          	csrr	a4,scause
    80002c26:	47a1                	li	a5,8
    80002c28:	02f70763          	beq	a4,a5,80002c56 <usertrap+0x68>
    80002c2c:	00000097          	auipc	ra,0x0
    80002c30:	f20080e7          	jalr	-224(ra) # 80002b4c <devintr>
    80002c34:	892a                	mv	s2,a0
    80002c36:	c151                	beqz	a0,80002cba <usertrap+0xcc>
    80002c38:	8526                	mv	a0,s1
    80002c3a:	00000097          	auipc	ra,0x0
    80002c3e:	ad2080e7          	jalr	-1326(ra) # 8000270c <killed>
    80002c42:	c929                	beqz	a0,80002c94 <usertrap+0xa6>
    80002c44:	a099                	j	80002c8a <usertrap+0x9c>
    80002c46:	00005517          	auipc	a0,0x5
    80002c4a:	71250513          	addi	a0,a0,1810 # 80008358 <states.0+0x58>
    80002c4e:	ffffe097          	auipc	ra,0xffffe
    80002c52:	8f0080e7          	jalr	-1808(ra) # 8000053e <panic>
    80002c56:	00000097          	auipc	ra,0x0
    80002c5a:	ab6080e7          	jalr	-1354(ra) # 8000270c <killed>
    80002c5e:	e921                	bnez	a0,80002cae <usertrap+0xc0>
    80002c60:	6cb8                	ld	a4,88(s1)
    80002c62:	6f1c                	ld	a5,24(a4)
    80002c64:	0791                	addi	a5,a5,4
    80002c66:	ef1c                	sd	a5,24(a4)
    80002c68:	100027f3          	csrr	a5,sstatus
    80002c6c:	0027e793          	ori	a5,a5,2
    80002c70:	10079073          	csrw	sstatus,a5
    80002c74:	00000097          	auipc	ra,0x0
    80002c78:	2d4080e7          	jalr	724(ra) # 80002f48 <syscall>
    80002c7c:	8526                	mv	a0,s1
    80002c7e:	00000097          	auipc	ra,0x0
    80002c82:	a8e080e7          	jalr	-1394(ra) # 8000270c <killed>
    80002c86:	c911                	beqz	a0,80002c9a <usertrap+0xac>
    80002c88:	4901                	li	s2,0
    80002c8a:	557d                	li	a0,-1
    80002c8c:	fffff097          	auipc	ra,0xfffff
    80002c90:	4fc080e7          	jalr	1276(ra) # 80002188 <exit>
    80002c94:	4789                	li	a5,2
    80002c96:	04f90f63          	beq	s2,a5,80002cf4 <usertrap+0x106>
    80002c9a:	00000097          	auipc	ra,0x0
    80002c9e:	dd6080e7          	jalr	-554(ra) # 80002a70 <usertrapret>
    80002ca2:	60e2                	ld	ra,24(sp)
    80002ca4:	6442                	ld	s0,16(sp)
    80002ca6:	64a2                	ld	s1,8(sp)
    80002ca8:	6902                	ld	s2,0(sp)
    80002caa:	6105                	addi	sp,sp,32
    80002cac:	8082                	ret
    80002cae:	557d                	li	a0,-1
    80002cb0:	fffff097          	auipc	ra,0xfffff
    80002cb4:	4d8080e7          	jalr	1240(ra) # 80002188 <exit>
    80002cb8:	b765                	j	80002c60 <usertrap+0x72>
    80002cba:	142025f3          	csrr	a1,scause
    80002cbe:	5890                	lw	a2,48(s1)
    80002cc0:	00005517          	auipc	a0,0x5
    80002cc4:	6b850513          	addi	a0,a0,1720 # 80008378 <states.0+0x78>
    80002cc8:	ffffe097          	auipc	ra,0xffffe
    80002ccc:	8c0080e7          	jalr	-1856(ra) # 80000588 <printf>
    80002cd0:	141025f3          	csrr	a1,sepc
    80002cd4:	14302673          	csrr	a2,stval
    80002cd8:	00005517          	auipc	a0,0x5
    80002cdc:	6d050513          	addi	a0,a0,1744 # 800083a8 <states.0+0xa8>
    80002ce0:	ffffe097          	auipc	ra,0xffffe
    80002ce4:	8a8080e7          	jalr	-1880(ra) # 80000588 <printf>
    80002ce8:	8526                	mv	a0,s1
    80002cea:	00000097          	auipc	ra,0x0
    80002cee:	9f6080e7          	jalr	-1546(ra) # 800026e0 <setkilled>
    80002cf2:	b769                	j	80002c7c <usertrap+0x8e>
    80002cf4:	fffff097          	auipc	ra,0xfffff
    80002cf8:	324080e7          	jalr	804(ra) # 80002018 <yield>
    80002cfc:	bf79                	j	80002c9a <usertrap+0xac>

0000000080002cfe <kerneltrap>:
    80002cfe:	7179                	addi	sp,sp,-48
    80002d00:	f406                	sd	ra,40(sp)
    80002d02:	f022                	sd	s0,32(sp)
    80002d04:	ec26                	sd	s1,24(sp)
    80002d06:	e84a                	sd	s2,16(sp)
    80002d08:	e44e                	sd	s3,8(sp)
    80002d0a:	1800                	addi	s0,sp,48
    80002d0c:	14102973          	csrr	s2,sepc
    80002d10:	100024f3          	csrr	s1,sstatus
    80002d14:	142029f3          	csrr	s3,scause
    80002d18:	1004f793          	andi	a5,s1,256
    80002d1c:	cb85                	beqz	a5,80002d4c <kerneltrap+0x4e>
    80002d1e:	100027f3          	csrr	a5,sstatus
    80002d22:	8b89                	andi	a5,a5,2
    80002d24:	ef85                	bnez	a5,80002d5c <kerneltrap+0x5e>
    80002d26:	00000097          	auipc	ra,0x0
    80002d2a:	e26080e7          	jalr	-474(ra) # 80002b4c <devintr>
    80002d2e:	cd1d                	beqz	a0,80002d6c <kerneltrap+0x6e>
    80002d30:	4789                	li	a5,2
    80002d32:	06f50a63          	beq	a0,a5,80002da6 <kerneltrap+0xa8>
    80002d36:	14191073          	csrw	sepc,s2
    80002d3a:	10049073          	csrw	sstatus,s1
    80002d3e:	70a2                	ld	ra,40(sp)
    80002d40:	7402                	ld	s0,32(sp)
    80002d42:	64e2                	ld	s1,24(sp)
    80002d44:	6942                	ld	s2,16(sp)
    80002d46:	69a2                	ld	s3,8(sp)
    80002d48:	6145                	addi	sp,sp,48
    80002d4a:	8082                	ret
    80002d4c:	00005517          	auipc	a0,0x5
    80002d50:	67c50513          	addi	a0,a0,1660 # 800083c8 <states.0+0xc8>
    80002d54:	ffffd097          	auipc	ra,0xffffd
    80002d58:	7ea080e7          	jalr	2026(ra) # 8000053e <panic>
    80002d5c:	00005517          	auipc	a0,0x5
    80002d60:	69450513          	addi	a0,a0,1684 # 800083f0 <states.0+0xf0>
    80002d64:	ffffd097          	auipc	ra,0xffffd
    80002d68:	7da080e7          	jalr	2010(ra) # 8000053e <panic>
    80002d6c:	85ce                	mv	a1,s3
    80002d6e:	00005517          	auipc	a0,0x5
    80002d72:	6a250513          	addi	a0,a0,1698 # 80008410 <states.0+0x110>
    80002d76:	ffffe097          	auipc	ra,0xffffe
    80002d7a:	812080e7          	jalr	-2030(ra) # 80000588 <printf>
    80002d7e:	141025f3          	csrr	a1,sepc
    80002d82:	14302673          	csrr	a2,stval
    80002d86:	00005517          	auipc	a0,0x5
    80002d8a:	69a50513          	addi	a0,a0,1690 # 80008420 <states.0+0x120>
    80002d8e:	ffffd097          	auipc	ra,0xffffd
    80002d92:	7fa080e7          	jalr	2042(ra) # 80000588 <printf>
    80002d96:	00005517          	auipc	a0,0x5
    80002d9a:	6a250513          	addi	a0,a0,1698 # 80008438 <states.0+0x138>
    80002d9e:	ffffd097          	auipc	ra,0xffffd
    80002da2:	7a0080e7          	jalr	1952(ra) # 8000053e <panic>
    80002da6:	fffff097          	auipc	ra,0xfffff
    80002daa:	c06080e7          	jalr	-1018(ra) # 800019ac <myproc>
    80002dae:	d541                	beqz	a0,80002d36 <kerneltrap+0x38>
    80002db0:	fffff097          	auipc	ra,0xfffff
    80002db4:	bfc080e7          	jalr	-1028(ra) # 800019ac <myproc>
    80002db8:	4d18                	lw	a4,24(a0)
    80002dba:	4791                	li	a5,4
    80002dbc:	f6f71de3          	bne	a4,a5,80002d36 <kerneltrap+0x38>
    80002dc0:	fffff097          	auipc	ra,0xfffff
    80002dc4:	258080e7          	jalr	600(ra) # 80002018 <yield>
    80002dc8:	b7bd                	j	80002d36 <kerneltrap+0x38>

0000000080002dca <argraw>:
    80002dca:	1101                	addi	sp,sp,-32
    80002dcc:	ec06                	sd	ra,24(sp)
    80002dce:	e822                	sd	s0,16(sp)
    80002dd0:	e426                	sd	s1,8(sp)
    80002dd2:	1000                	addi	s0,sp,32
    80002dd4:	84aa                	mv	s1,a0
    80002dd6:	fffff097          	auipc	ra,0xfffff
    80002dda:	bd6080e7          	jalr	-1066(ra) # 800019ac <myproc>
    80002dde:	4795                	li	a5,5
    80002de0:	0497e163          	bltu	a5,s1,80002e22 <argraw+0x58>
    80002de4:	048a                	slli	s1,s1,0x2
    80002de6:	00005717          	auipc	a4,0x5
    80002dea:	68a70713          	addi	a4,a4,1674 # 80008470 <states.0+0x170>
    80002dee:	94ba                	add	s1,s1,a4
    80002df0:	409c                	lw	a5,0(s1)
    80002df2:	97ba                	add	a5,a5,a4
    80002df4:	8782                	jr	a5
    80002df6:	6d3c                	ld	a5,88(a0)
    80002df8:	7ba8                	ld	a0,112(a5)
    80002dfa:	60e2                	ld	ra,24(sp)
    80002dfc:	6442                	ld	s0,16(sp)
    80002dfe:	64a2                	ld	s1,8(sp)
    80002e00:	6105                	addi	sp,sp,32
    80002e02:	8082                	ret
    80002e04:	6d3c                	ld	a5,88(a0)
    80002e06:	7fa8                	ld	a0,120(a5)
    80002e08:	bfcd                	j	80002dfa <argraw+0x30>
    80002e0a:	6d3c                	ld	a5,88(a0)
    80002e0c:	63c8                	ld	a0,128(a5)
    80002e0e:	b7f5                	j	80002dfa <argraw+0x30>
    80002e10:	6d3c                	ld	a5,88(a0)
    80002e12:	67c8                	ld	a0,136(a5)
    80002e14:	b7dd                	j	80002dfa <argraw+0x30>
    80002e16:	6d3c                	ld	a5,88(a0)
    80002e18:	6bc8                	ld	a0,144(a5)
    80002e1a:	b7c5                	j	80002dfa <argraw+0x30>
    80002e1c:	6d3c                	ld	a5,88(a0)
    80002e1e:	6fc8                	ld	a0,152(a5)
    80002e20:	bfe9                	j	80002dfa <argraw+0x30>
    80002e22:	00005517          	auipc	a0,0x5
    80002e26:	62650513          	addi	a0,a0,1574 # 80008448 <states.0+0x148>
    80002e2a:	ffffd097          	auipc	ra,0xffffd
    80002e2e:	714080e7          	jalr	1812(ra) # 8000053e <panic>

0000000080002e32 <fetchaddr>:
    80002e32:	1101                	addi	sp,sp,-32
    80002e34:	ec06                	sd	ra,24(sp)
    80002e36:	e822                	sd	s0,16(sp)
    80002e38:	e426                	sd	s1,8(sp)
    80002e3a:	e04a                	sd	s2,0(sp)
    80002e3c:	1000                	addi	s0,sp,32
    80002e3e:	84aa                	mv	s1,a0
    80002e40:	892e                	mv	s2,a1
    80002e42:	fffff097          	auipc	ra,0xfffff
    80002e46:	b6a080e7          	jalr	-1174(ra) # 800019ac <myproc>
    80002e4a:	653c                	ld	a5,72(a0)
    80002e4c:	02f4f863          	bgeu	s1,a5,80002e7c <fetchaddr+0x4a>
    80002e50:	00848713          	addi	a4,s1,8
    80002e54:	02e7e663          	bltu	a5,a4,80002e80 <fetchaddr+0x4e>
    80002e58:	46a1                	li	a3,8
    80002e5a:	8626                	mv	a2,s1
    80002e5c:	85ca                	mv	a1,s2
    80002e5e:	6928                	ld	a0,80(a0)
    80002e60:	fffff097          	auipc	ra,0xfffff
    80002e64:	894080e7          	jalr	-1900(ra) # 800016f4 <copyin>
    80002e68:	00a03533          	snez	a0,a0
    80002e6c:	40a00533          	neg	a0,a0
    80002e70:	60e2                	ld	ra,24(sp)
    80002e72:	6442                	ld	s0,16(sp)
    80002e74:	64a2                	ld	s1,8(sp)
    80002e76:	6902                	ld	s2,0(sp)
    80002e78:	6105                	addi	sp,sp,32
    80002e7a:	8082                	ret
    80002e7c:	557d                	li	a0,-1
    80002e7e:	bfcd                	j	80002e70 <fetchaddr+0x3e>
    80002e80:	557d                	li	a0,-1
    80002e82:	b7fd                	j	80002e70 <fetchaddr+0x3e>

0000000080002e84 <fetchstr>:
    80002e84:	7179                	addi	sp,sp,-48
    80002e86:	f406                	sd	ra,40(sp)
    80002e88:	f022                	sd	s0,32(sp)
    80002e8a:	ec26                	sd	s1,24(sp)
    80002e8c:	e84a                	sd	s2,16(sp)
    80002e8e:	e44e                	sd	s3,8(sp)
    80002e90:	1800                	addi	s0,sp,48
    80002e92:	892a                	mv	s2,a0
    80002e94:	84ae                	mv	s1,a1
    80002e96:	89b2                	mv	s3,a2
    80002e98:	fffff097          	auipc	ra,0xfffff
    80002e9c:	b14080e7          	jalr	-1260(ra) # 800019ac <myproc>
    80002ea0:	86ce                	mv	a3,s3
    80002ea2:	864a                	mv	a2,s2
    80002ea4:	85a6                	mv	a1,s1
    80002ea6:	6928                	ld	a0,80(a0)
    80002ea8:	fffff097          	auipc	ra,0xfffff
    80002eac:	8da080e7          	jalr	-1830(ra) # 80001782 <copyinstr>
    80002eb0:	00054e63          	bltz	a0,80002ecc <fetchstr+0x48>
    80002eb4:	8526                	mv	a0,s1
    80002eb6:	ffffe097          	auipc	ra,0xffffe
    80002eba:	f98080e7          	jalr	-104(ra) # 80000e4e <strlen>
    80002ebe:	70a2                	ld	ra,40(sp)
    80002ec0:	7402                	ld	s0,32(sp)
    80002ec2:	64e2                	ld	s1,24(sp)
    80002ec4:	6942                	ld	s2,16(sp)
    80002ec6:	69a2                	ld	s3,8(sp)
    80002ec8:	6145                	addi	sp,sp,48
    80002eca:	8082                	ret
    80002ecc:	557d                	li	a0,-1
    80002ece:	bfc5                	j	80002ebe <fetchstr+0x3a>

0000000080002ed0 <argint>:
    80002ed0:	1101                	addi	sp,sp,-32
    80002ed2:	ec06                	sd	ra,24(sp)
    80002ed4:	e822                	sd	s0,16(sp)
    80002ed6:	e426                	sd	s1,8(sp)
    80002ed8:	1000                	addi	s0,sp,32
    80002eda:	84ae                	mv	s1,a1
    80002edc:	00000097          	auipc	ra,0x0
    80002ee0:	eee080e7          	jalr	-274(ra) # 80002dca <argraw>
    80002ee4:	c088                	sw	a0,0(s1)
    80002ee6:	60e2                	ld	ra,24(sp)
    80002ee8:	6442                	ld	s0,16(sp)
    80002eea:	64a2                	ld	s1,8(sp)
    80002eec:	6105                	addi	sp,sp,32
    80002eee:	8082                	ret

0000000080002ef0 <argaddr>:
    80002ef0:	1101                	addi	sp,sp,-32
    80002ef2:	ec06                	sd	ra,24(sp)
    80002ef4:	e822                	sd	s0,16(sp)
    80002ef6:	e426                	sd	s1,8(sp)
    80002ef8:	1000                	addi	s0,sp,32
    80002efa:	84ae                	mv	s1,a1
    80002efc:	00000097          	auipc	ra,0x0
    80002f00:	ece080e7          	jalr	-306(ra) # 80002dca <argraw>
    80002f04:	e088                	sd	a0,0(s1)
    80002f06:	60e2                	ld	ra,24(sp)
    80002f08:	6442                	ld	s0,16(sp)
    80002f0a:	64a2                	ld	s1,8(sp)
    80002f0c:	6105                	addi	sp,sp,32
    80002f0e:	8082                	ret

0000000080002f10 <argstr>:
    80002f10:	7179                	addi	sp,sp,-48
    80002f12:	f406                	sd	ra,40(sp)
    80002f14:	f022                	sd	s0,32(sp)
    80002f16:	ec26                	sd	s1,24(sp)
    80002f18:	e84a                	sd	s2,16(sp)
    80002f1a:	1800                	addi	s0,sp,48
    80002f1c:	84ae                	mv	s1,a1
    80002f1e:	8932                	mv	s2,a2
    80002f20:	fd840593          	addi	a1,s0,-40
    80002f24:	00000097          	auipc	ra,0x0
    80002f28:	fcc080e7          	jalr	-52(ra) # 80002ef0 <argaddr>
    80002f2c:	864a                	mv	a2,s2
    80002f2e:	85a6                	mv	a1,s1
    80002f30:	fd843503          	ld	a0,-40(s0)
    80002f34:	00000097          	auipc	ra,0x0
    80002f38:	f50080e7          	jalr	-176(ra) # 80002e84 <fetchstr>
    80002f3c:	70a2                	ld	ra,40(sp)
    80002f3e:	7402                	ld	s0,32(sp)
    80002f40:	64e2                	ld	s1,24(sp)
    80002f42:	6942                	ld	s2,16(sp)
    80002f44:	6145                	addi	sp,sp,48
    80002f46:	8082                	ret

0000000080002f48 <syscall>:
    80002f48:	1101                	addi	sp,sp,-32
    80002f4a:	ec06                	sd	ra,24(sp)
    80002f4c:	e822                	sd	s0,16(sp)
    80002f4e:	e426                	sd	s1,8(sp)
    80002f50:	e04a                	sd	s2,0(sp)
    80002f52:	1000                	addi	s0,sp,32
    80002f54:	fffff097          	auipc	ra,0xfffff
    80002f58:	a58080e7          	jalr	-1448(ra) # 800019ac <myproc>
    80002f5c:	84aa                	mv	s1,a0
    80002f5e:	05853903          	ld	s2,88(a0)
    80002f62:	0a893783          	ld	a5,168(s2)
    80002f66:	0007869b          	sext.w	a3,a5
    80002f6a:	37fd                	addiw	a5,a5,-1
    80002f6c:	4755                	li	a4,21
    80002f6e:	00f76f63          	bltu	a4,a5,80002f8c <syscall+0x44>
    80002f72:	00369713          	slli	a4,a3,0x3
    80002f76:	00005797          	auipc	a5,0x5
    80002f7a:	51278793          	addi	a5,a5,1298 # 80008488 <syscalls>
    80002f7e:	97ba                	add	a5,a5,a4
    80002f80:	639c                	ld	a5,0(a5)
    80002f82:	c789                	beqz	a5,80002f8c <syscall+0x44>
    80002f84:	9782                	jalr	a5
    80002f86:	06a93823          	sd	a0,112(s2)
    80002f8a:	a839                	j	80002fa8 <syscall+0x60>
    80002f8c:	15848613          	addi	a2,s1,344
    80002f90:	588c                	lw	a1,48(s1)
    80002f92:	00005517          	auipc	a0,0x5
    80002f96:	4be50513          	addi	a0,a0,1214 # 80008450 <states.0+0x150>
    80002f9a:	ffffd097          	auipc	ra,0xffffd
    80002f9e:	5ee080e7          	jalr	1518(ra) # 80000588 <printf>
    80002fa2:	6cbc                	ld	a5,88(s1)
    80002fa4:	577d                	li	a4,-1
    80002fa6:	fbb8                	sd	a4,112(a5)
    80002fa8:	60e2                	ld	ra,24(sp)
    80002faa:	6442                	ld	s0,16(sp)
    80002fac:	64a2                	ld	s1,8(sp)
    80002fae:	6902                	ld	s2,0(sp)
    80002fb0:	6105                	addi	sp,sp,32
    80002fb2:	8082                	ret

0000000080002fb4 <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    80002fb4:	1101                	addi	sp,sp,-32
    80002fb6:	ec06                	sd	ra,24(sp)
    80002fb8:	e822                	sd	s0,16(sp)
    80002fba:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    80002fbc:	fec40593          	addi	a1,s0,-20
    80002fc0:	4501                	li	a0,0
    80002fc2:	00000097          	auipc	ra,0x0
    80002fc6:	f0e080e7          	jalr	-242(ra) # 80002ed0 <argint>
  exit(n);
    80002fca:	fec42503          	lw	a0,-20(s0)
    80002fce:	fffff097          	auipc	ra,0xfffff
    80002fd2:	1ba080e7          	jalr	442(ra) # 80002188 <exit>
  return 0; // not reached
}
    80002fd6:	4501                	li	a0,0
    80002fd8:	60e2                	ld	ra,24(sp)
    80002fda:	6442                	ld	s0,16(sp)
    80002fdc:	6105                	addi	sp,sp,32
    80002fde:	8082                	ret

0000000080002fe0 <sys_getpid>:

uint64
sys_getpid(void)
{
    80002fe0:	1141                	addi	sp,sp,-16
    80002fe2:	e406                	sd	ra,8(sp)
    80002fe4:	e022                	sd	s0,0(sp)
    80002fe6:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80002fe8:	fffff097          	auipc	ra,0xfffff
    80002fec:	9c4080e7          	jalr	-1596(ra) # 800019ac <myproc>
}
    80002ff0:	5908                	lw	a0,48(a0)
    80002ff2:	60a2                	ld	ra,8(sp)
    80002ff4:	6402                	ld	s0,0(sp)
    80002ff6:	0141                	addi	sp,sp,16
    80002ff8:	8082                	ret

0000000080002ffa <sys_fork>:

uint64
sys_fork(void)
{
    80002ffa:	1141                	addi	sp,sp,-16
    80002ffc:	e406                	sd	ra,8(sp)
    80002ffe:	e022                	sd	s0,0(sp)
    80003000:	0800                	addi	s0,sp,16
  return fork();
    80003002:	fffff097          	auipc	ra,0xfffff
    80003006:	d60080e7          	jalr	-672(ra) # 80001d62 <fork>
}
    8000300a:	60a2                	ld	ra,8(sp)
    8000300c:	6402                	ld	s0,0(sp)
    8000300e:	0141                	addi	sp,sp,16
    80003010:	8082                	ret

0000000080003012 <sys_wait>:

uint64
sys_wait(void)
{
    80003012:	1101                	addi	sp,sp,-32
    80003014:	ec06                	sd	ra,24(sp)
    80003016:	e822                	sd	s0,16(sp)
    80003018:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    8000301a:	fe840593          	addi	a1,s0,-24
    8000301e:	4501                	li	a0,0
    80003020:	00000097          	auipc	ra,0x0
    80003024:	ed0080e7          	jalr	-304(ra) # 80002ef0 <argaddr>
  return wait(p);
    80003028:	fe843503          	ld	a0,-24(s0)
    8000302c:	fffff097          	auipc	ra,0xfffff
    80003030:	712080e7          	jalr	1810(ra) # 8000273e <wait>
}
    80003034:	60e2                	ld	ra,24(sp)
    80003036:	6442                	ld	s0,16(sp)
    80003038:	6105                	addi	sp,sp,32
    8000303a:	8082                	ret

000000008000303c <sys_sbrk>:

uint64
sys_sbrk(void)
{
    8000303c:	7179                	addi	sp,sp,-48
    8000303e:	f406                	sd	ra,40(sp)
    80003040:	f022                	sd	s0,32(sp)
    80003042:	ec26                	sd	s1,24(sp)
    80003044:	1800                	addi	s0,sp,48
  uint64 addr;
  int n;

  argint(0, &n);
    80003046:	fdc40593          	addi	a1,s0,-36
    8000304a:	4501                	li	a0,0
    8000304c:	00000097          	auipc	ra,0x0
    80003050:	e84080e7          	jalr	-380(ra) # 80002ed0 <argint>
  addr = myproc()->sz;
    80003054:	fffff097          	auipc	ra,0xfffff
    80003058:	958080e7          	jalr	-1704(ra) # 800019ac <myproc>
    8000305c:	6524                	ld	s1,72(a0)
  if (growproc(n) < 0)
    8000305e:	fdc42503          	lw	a0,-36(s0)
    80003062:	fffff097          	auipc	ra,0xfffff
    80003066:	ca4080e7          	jalr	-860(ra) # 80001d06 <growproc>
    8000306a:	00054863          	bltz	a0,8000307a <sys_sbrk+0x3e>
    return -1;
  return addr;
}
    8000306e:	8526                	mv	a0,s1
    80003070:	70a2                	ld	ra,40(sp)
    80003072:	7402                	ld	s0,32(sp)
    80003074:	64e2                	ld	s1,24(sp)
    80003076:	6145                	addi	sp,sp,48
    80003078:	8082                	ret
    return -1;
    8000307a:	54fd                	li	s1,-1
    8000307c:	bfcd                	j	8000306e <sys_sbrk+0x32>

000000008000307e <sys_sleep>:

uint64
sys_sleep(void)
{
    8000307e:	7139                	addi	sp,sp,-64
    80003080:	fc06                	sd	ra,56(sp)
    80003082:	f822                	sd	s0,48(sp)
    80003084:	f426                	sd	s1,40(sp)
    80003086:	f04a                	sd	s2,32(sp)
    80003088:	ec4e                	sd	s3,24(sp)
    8000308a:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    8000308c:	fcc40593          	addi	a1,s0,-52
    80003090:	4501                	li	a0,0
    80003092:	00000097          	auipc	ra,0x0
    80003096:	e3e080e7          	jalr	-450(ra) # 80002ed0 <argint>
  acquire(&tickslock);
    8000309a:	00014517          	auipc	a0,0x14
    8000309e:	90650513          	addi	a0,a0,-1786 # 800169a0 <tickslock>
    800030a2:	ffffe097          	auipc	ra,0xffffe
    800030a6:	b34080e7          	jalr	-1228(ra) # 80000bd6 <acquire>
  ticks0 = ticks;
    800030aa:	00006917          	auipc	s2,0x6
    800030ae:	85692903          	lw	s2,-1962(s2) # 80008900 <ticks>
  while (ticks - ticks0 < n)
    800030b2:	fcc42783          	lw	a5,-52(s0)
    800030b6:	cf9d                	beqz	a5,800030f4 <sys_sleep+0x76>
    if (killed(myproc()))
    {
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    800030b8:	00014997          	auipc	s3,0x14
    800030bc:	8e898993          	addi	s3,s3,-1816 # 800169a0 <tickslock>
    800030c0:	00006497          	auipc	s1,0x6
    800030c4:	84048493          	addi	s1,s1,-1984 # 80008900 <ticks>
    if (killed(myproc()))
    800030c8:	fffff097          	auipc	ra,0xfffff
    800030cc:	8e4080e7          	jalr	-1820(ra) # 800019ac <myproc>
    800030d0:	fffff097          	auipc	ra,0xfffff
    800030d4:	63c080e7          	jalr	1596(ra) # 8000270c <killed>
    800030d8:	ed15                	bnez	a0,80003114 <sys_sleep+0x96>
    sleep(&ticks, &tickslock);
    800030da:	85ce                	mv	a1,s3
    800030dc:	8526                	mv	a0,s1
    800030de:	fffff097          	auipc	ra,0xfffff
    800030e2:	f76080e7          	jalr	-138(ra) # 80002054 <sleep>
  while (ticks - ticks0 < n)
    800030e6:	409c                	lw	a5,0(s1)
    800030e8:	412787bb          	subw	a5,a5,s2
    800030ec:	fcc42703          	lw	a4,-52(s0)
    800030f0:	fce7ece3          	bltu	a5,a4,800030c8 <sys_sleep+0x4a>
  }
  release(&tickslock);
    800030f4:	00014517          	auipc	a0,0x14
    800030f8:	8ac50513          	addi	a0,a0,-1876 # 800169a0 <tickslock>
    800030fc:	ffffe097          	auipc	ra,0xffffe
    80003100:	b8e080e7          	jalr	-1138(ra) # 80000c8a <release>
  return 0;
    80003104:	4501                	li	a0,0
}
    80003106:	70e2                	ld	ra,56(sp)
    80003108:	7442                	ld	s0,48(sp)
    8000310a:	74a2                	ld	s1,40(sp)
    8000310c:	7902                	ld	s2,32(sp)
    8000310e:	69e2                	ld	s3,24(sp)
    80003110:	6121                	addi	sp,sp,64
    80003112:	8082                	ret
      release(&tickslock);
    80003114:	00014517          	auipc	a0,0x14
    80003118:	88c50513          	addi	a0,a0,-1908 # 800169a0 <tickslock>
    8000311c:	ffffe097          	auipc	ra,0xffffe
    80003120:	b6e080e7          	jalr	-1170(ra) # 80000c8a <release>
      return -1;
    80003124:	557d                	li	a0,-1
    80003126:	b7c5                	j	80003106 <sys_sleep+0x88>

0000000080003128 <sys_kill>:

uint64
sys_kill(void)
{
    80003128:	1101                	addi	sp,sp,-32
    8000312a:	ec06                	sd	ra,24(sp)
    8000312c:	e822                	sd	s0,16(sp)
    8000312e:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    80003130:	fec40593          	addi	a1,s0,-20
    80003134:	4501                	li	a0,0
    80003136:	00000097          	auipc	ra,0x0
    8000313a:	d9a080e7          	jalr	-614(ra) # 80002ed0 <argint>
  return kill(pid);
    8000313e:	fec42503          	lw	a0,-20(s0)
    80003142:	fffff097          	auipc	ra,0xfffff
    80003146:	11c080e7          	jalr	284(ra) # 8000225e <kill>
}
    8000314a:	60e2                	ld	ra,24(sp)
    8000314c:	6442                	ld	s0,16(sp)
    8000314e:	6105                	addi	sp,sp,32
    80003150:	8082                	ret

0000000080003152 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80003152:	1101                	addi	sp,sp,-32
    80003154:	ec06                	sd	ra,24(sp)
    80003156:	e822                	sd	s0,16(sp)
    80003158:	e426                	sd	s1,8(sp)
    8000315a:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    8000315c:	00014517          	auipc	a0,0x14
    80003160:	84450513          	addi	a0,a0,-1980 # 800169a0 <tickslock>
    80003164:	ffffe097          	auipc	ra,0xffffe
    80003168:	a72080e7          	jalr	-1422(ra) # 80000bd6 <acquire>
  xticks = ticks;
    8000316c:	00005497          	auipc	s1,0x5
    80003170:	7944a483          	lw	s1,1940(s1) # 80008900 <ticks>
  release(&tickslock);
    80003174:	00014517          	auipc	a0,0x14
    80003178:	82c50513          	addi	a0,a0,-2004 # 800169a0 <tickslock>
    8000317c:	ffffe097          	auipc	ra,0xffffe
    80003180:	b0e080e7          	jalr	-1266(ra) # 80000c8a <release>
  return xticks;
}
    80003184:	02049513          	slli	a0,s1,0x20
    80003188:	9101                	srli	a0,a0,0x20
    8000318a:	60e2                	ld	ra,24(sp)
    8000318c:	6442                	ld	s0,16(sp)
    8000318e:	64a2                	ld	s1,8(sp)
    80003190:	6105                	addi	sp,sp,32
    80003192:	8082                	ret

0000000080003194 <sys_pigs>:

uint64 sys_pigs(void)
{
    80003194:	1101                	addi	sp,sp,-32
    80003196:	ec06                	sd	ra,24(sp)
    80003198:	e822                	sd	s0,16(sp)
    8000319a:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    8000319c:	fec40593          	addi	a1,s0,-20
    800031a0:	4501                	li	a0,0
    800031a2:	00000097          	auipc	ra,0x0
    800031a6:	d2e080e7          	jalr	-722(ra) # 80002ed0 <argint>
  return pigs(pid);
    800031aa:	fec42503          	lw	a0,-20(s0)
    800031ae:	fffff097          	auipc	ra,0xfffff
    800031b2:	51a080e7          	jalr	1306(ra) # 800026c8 <pigs>
}
    800031b6:	60e2                	ld	ra,24(sp)
    800031b8:	6442                	ld	s0,16(sp)
    800031ba:	6105                	addi	sp,sp,32
    800031bc:	8082                	ret

00000000800031be <binit>:
    800031be:	7179                	addi	sp,sp,-48
    800031c0:	f406                	sd	ra,40(sp)
    800031c2:	f022                	sd	s0,32(sp)
    800031c4:	ec26                	sd	s1,24(sp)
    800031c6:	e84a                	sd	s2,16(sp)
    800031c8:	e44e                	sd	s3,8(sp)
    800031ca:	e052                	sd	s4,0(sp)
    800031cc:	1800                	addi	s0,sp,48
    800031ce:	00005597          	auipc	a1,0x5
    800031d2:	37258593          	addi	a1,a1,882 # 80008540 <syscalls+0xb8>
    800031d6:	00013517          	auipc	a0,0x13
    800031da:	7e250513          	addi	a0,a0,2018 # 800169b8 <bcache>
    800031de:	ffffe097          	auipc	ra,0xffffe
    800031e2:	968080e7          	jalr	-1688(ra) # 80000b46 <initlock>
    800031e6:	0001b797          	auipc	a5,0x1b
    800031ea:	7d278793          	addi	a5,a5,2002 # 8001e9b8 <bcache+0x8000>
    800031ee:	0001c717          	auipc	a4,0x1c
    800031f2:	a3270713          	addi	a4,a4,-1486 # 8001ec20 <bcache+0x8268>
    800031f6:	2ae7b823          	sd	a4,688(a5)
    800031fa:	2ae7bc23          	sd	a4,696(a5)
    800031fe:	00013497          	auipc	s1,0x13
    80003202:	7d248493          	addi	s1,s1,2002 # 800169d0 <bcache+0x18>
    80003206:	893e                	mv	s2,a5
    80003208:	89ba                	mv	s3,a4
    8000320a:	00005a17          	auipc	s4,0x5
    8000320e:	33ea0a13          	addi	s4,s4,830 # 80008548 <syscalls+0xc0>
    80003212:	2b893783          	ld	a5,696(s2)
    80003216:	e8bc                	sd	a5,80(s1)
    80003218:	0534b423          	sd	s3,72(s1)
    8000321c:	85d2                	mv	a1,s4
    8000321e:	01048513          	addi	a0,s1,16
    80003222:	00001097          	auipc	ra,0x1
    80003226:	4c4080e7          	jalr	1220(ra) # 800046e6 <initsleeplock>
    8000322a:	2b893783          	ld	a5,696(s2)
    8000322e:	e7a4                	sd	s1,72(a5)
    80003230:	2a993c23          	sd	s1,696(s2)
    80003234:	45848493          	addi	s1,s1,1112
    80003238:	fd349de3          	bne	s1,s3,80003212 <binit+0x54>
    8000323c:	70a2                	ld	ra,40(sp)
    8000323e:	7402                	ld	s0,32(sp)
    80003240:	64e2                	ld	s1,24(sp)
    80003242:	6942                	ld	s2,16(sp)
    80003244:	69a2                	ld	s3,8(sp)
    80003246:	6a02                	ld	s4,0(sp)
    80003248:	6145                	addi	sp,sp,48
    8000324a:	8082                	ret

000000008000324c <bread>:
    8000324c:	7179                	addi	sp,sp,-48
    8000324e:	f406                	sd	ra,40(sp)
    80003250:	f022                	sd	s0,32(sp)
    80003252:	ec26                	sd	s1,24(sp)
    80003254:	e84a                	sd	s2,16(sp)
    80003256:	e44e                	sd	s3,8(sp)
    80003258:	1800                	addi	s0,sp,48
    8000325a:	892a                	mv	s2,a0
    8000325c:	89ae                	mv	s3,a1
    8000325e:	00013517          	auipc	a0,0x13
    80003262:	75a50513          	addi	a0,a0,1882 # 800169b8 <bcache>
    80003266:	ffffe097          	auipc	ra,0xffffe
    8000326a:	970080e7          	jalr	-1680(ra) # 80000bd6 <acquire>
    8000326e:	0001c497          	auipc	s1,0x1c
    80003272:	a024b483          	ld	s1,-1534(s1) # 8001ec70 <bcache+0x82b8>
    80003276:	0001c797          	auipc	a5,0x1c
    8000327a:	9aa78793          	addi	a5,a5,-1622 # 8001ec20 <bcache+0x8268>
    8000327e:	02f48f63          	beq	s1,a5,800032bc <bread+0x70>
    80003282:	873e                	mv	a4,a5
    80003284:	a021                	j	8000328c <bread+0x40>
    80003286:	68a4                	ld	s1,80(s1)
    80003288:	02e48a63          	beq	s1,a4,800032bc <bread+0x70>
    8000328c:	449c                	lw	a5,8(s1)
    8000328e:	ff279ce3          	bne	a5,s2,80003286 <bread+0x3a>
    80003292:	44dc                	lw	a5,12(s1)
    80003294:	ff3799e3          	bne	a5,s3,80003286 <bread+0x3a>
    80003298:	40bc                	lw	a5,64(s1)
    8000329a:	2785                	addiw	a5,a5,1
    8000329c:	c0bc                	sw	a5,64(s1)
    8000329e:	00013517          	auipc	a0,0x13
    800032a2:	71a50513          	addi	a0,a0,1818 # 800169b8 <bcache>
    800032a6:	ffffe097          	auipc	ra,0xffffe
    800032aa:	9e4080e7          	jalr	-1564(ra) # 80000c8a <release>
    800032ae:	01048513          	addi	a0,s1,16
    800032b2:	00001097          	auipc	ra,0x1
    800032b6:	46e080e7          	jalr	1134(ra) # 80004720 <acquiresleep>
    800032ba:	a8b9                	j	80003318 <bread+0xcc>
    800032bc:	0001c497          	auipc	s1,0x1c
    800032c0:	9ac4b483          	ld	s1,-1620(s1) # 8001ec68 <bcache+0x82b0>
    800032c4:	0001c797          	auipc	a5,0x1c
    800032c8:	95c78793          	addi	a5,a5,-1700 # 8001ec20 <bcache+0x8268>
    800032cc:	00f48863          	beq	s1,a5,800032dc <bread+0x90>
    800032d0:	873e                	mv	a4,a5
    800032d2:	40bc                	lw	a5,64(s1)
    800032d4:	cf81                	beqz	a5,800032ec <bread+0xa0>
    800032d6:	64a4                	ld	s1,72(s1)
    800032d8:	fee49de3          	bne	s1,a4,800032d2 <bread+0x86>
    800032dc:	00005517          	auipc	a0,0x5
    800032e0:	27450513          	addi	a0,a0,628 # 80008550 <syscalls+0xc8>
    800032e4:	ffffd097          	auipc	ra,0xffffd
    800032e8:	25a080e7          	jalr	602(ra) # 8000053e <panic>
    800032ec:	0124a423          	sw	s2,8(s1)
    800032f0:	0134a623          	sw	s3,12(s1)
    800032f4:	0004a023          	sw	zero,0(s1)
    800032f8:	4785                	li	a5,1
    800032fa:	c0bc                	sw	a5,64(s1)
    800032fc:	00013517          	auipc	a0,0x13
    80003300:	6bc50513          	addi	a0,a0,1724 # 800169b8 <bcache>
    80003304:	ffffe097          	auipc	ra,0xffffe
    80003308:	986080e7          	jalr	-1658(ra) # 80000c8a <release>
    8000330c:	01048513          	addi	a0,s1,16
    80003310:	00001097          	auipc	ra,0x1
    80003314:	410080e7          	jalr	1040(ra) # 80004720 <acquiresleep>
    80003318:	409c                	lw	a5,0(s1)
    8000331a:	cb89                	beqz	a5,8000332c <bread+0xe0>
    8000331c:	8526                	mv	a0,s1
    8000331e:	70a2                	ld	ra,40(sp)
    80003320:	7402                	ld	s0,32(sp)
    80003322:	64e2                	ld	s1,24(sp)
    80003324:	6942                	ld	s2,16(sp)
    80003326:	69a2                	ld	s3,8(sp)
    80003328:	6145                	addi	sp,sp,48
    8000332a:	8082                	ret
    8000332c:	4581                	li	a1,0
    8000332e:	8526                	mv	a0,s1
    80003330:	00003097          	auipc	ra,0x3
    80003334:	fd4080e7          	jalr	-44(ra) # 80006304 <virtio_disk_rw>
    80003338:	4785                	li	a5,1
    8000333a:	c09c                	sw	a5,0(s1)
    8000333c:	b7c5                	j	8000331c <bread+0xd0>

000000008000333e <bwrite>:
    8000333e:	1101                	addi	sp,sp,-32
    80003340:	ec06                	sd	ra,24(sp)
    80003342:	e822                	sd	s0,16(sp)
    80003344:	e426                	sd	s1,8(sp)
    80003346:	1000                	addi	s0,sp,32
    80003348:	84aa                	mv	s1,a0
    8000334a:	0541                	addi	a0,a0,16
    8000334c:	00001097          	auipc	ra,0x1
    80003350:	46e080e7          	jalr	1134(ra) # 800047ba <holdingsleep>
    80003354:	cd01                	beqz	a0,8000336c <bwrite+0x2e>
    80003356:	4585                	li	a1,1
    80003358:	8526                	mv	a0,s1
    8000335a:	00003097          	auipc	ra,0x3
    8000335e:	faa080e7          	jalr	-86(ra) # 80006304 <virtio_disk_rw>
    80003362:	60e2                	ld	ra,24(sp)
    80003364:	6442                	ld	s0,16(sp)
    80003366:	64a2                	ld	s1,8(sp)
    80003368:	6105                	addi	sp,sp,32
    8000336a:	8082                	ret
    8000336c:	00005517          	auipc	a0,0x5
    80003370:	1fc50513          	addi	a0,a0,508 # 80008568 <syscalls+0xe0>
    80003374:	ffffd097          	auipc	ra,0xffffd
    80003378:	1ca080e7          	jalr	458(ra) # 8000053e <panic>

000000008000337c <brelse>:
    8000337c:	1101                	addi	sp,sp,-32
    8000337e:	ec06                	sd	ra,24(sp)
    80003380:	e822                	sd	s0,16(sp)
    80003382:	e426                	sd	s1,8(sp)
    80003384:	e04a                	sd	s2,0(sp)
    80003386:	1000                	addi	s0,sp,32
    80003388:	84aa                	mv	s1,a0
    8000338a:	01050913          	addi	s2,a0,16
    8000338e:	854a                	mv	a0,s2
    80003390:	00001097          	auipc	ra,0x1
    80003394:	42a080e7          	jalr	1066(ra) # 800047ba <holdingsleep>
    80003398:	c92d                	beqz	a0,8000340a <brelse+0x8e>
    8000339a:	854a                	mv	a0,s2
    8000339c:	00001097          	auipc	ra,0x1
    800033a0:	3da080e7          	jalr	986(ra) # 80004776 <releasesleep>
    800033a4:	00013517          	auipc	a0,0x13
    800033a8:	61450513          	addi	a0,a0,1556 # 800169b8 <bcache>
    800033ac:	ffffe097          	auipc	ra,0xffffe
    800033b0:	82a080e7          	jalr	-2006(ra) # 80000bd6 <acquire>
    800033b4:	40bc                	lw	a5,64(s1)
    800033b6:	37fd                	addiw	a5,a5,-1
    800033b8:	0007871b          	sext.w	a4,a5
    800033bc:	c0bc                	sw	a5,64(s1)
    800033be:	eb05                	bnez	a4,800033ee <brelse+0x72>
    800033c0:	68bc                	ld	a5,80(s1)
    800033c2:	64b8                	ld	a4,72(s1)
    800033c4:	e7b8                	sd	a4,72(a5)
    800033c6:	64bc                	ld	a5,72(s1)
    800033c8:	68b8                	ld	a4,80(s1)
    800033ca:	ebb8                	sd	a4,80(a5)
    800033cc:	0001b797          	auipc	a5,0x1b
    800033d0:	5ec78793          	addi	a5,a5,1516 # 8001e9b8 <bcache+0x8000>
    800033d4:	2b87b703          	ld	a4,696(a5)
    800033d8:	e8b8                	sd	a4,80(s1)
    800033da:	0001c717          	auipc	a4,0x1c
    800033de:	84670713          	addi	a4,a4,-1978 # 8001ec20 <bcache+0x8268>
    800033e2:	e4b8                	sd	a4,72(s1)
    800033e4:	2b87b703          	ld	a4,696(a5)
    800033e8:	e724                	sd	s1,72(a4)
    800033ea:	2a97bc23          	sd	s1,696(a5)
    800033ee:	00013517          	auipc	a0,0x13
    800033f2:	5ca50513          	addi	a0,a0,1482 # 800169b8 <bcache>
    800033f6:	ffffe097          	auipc	ra,0xffffe
    800033fa:	894080e7          	jalr	-1900(ra) # 80000c8a <release>
    800033fe:	60e2                	ld	ra,24(sp)
    80003400:	6442                	ld	s0,16(sp)
    80003402:	64a2                	ld	s1,8(sp)
    80003404:	6902                	ld	s2,0(sp)
    80003406:	6105                	addi	sp,sp,32
    80003408:	8082                	ret
    8000340a:	00005517          	auipc	a0,0x5
    8000340e:	16650513          	addi	a0,a0,358 # 80008570 <syscalls+0xe8>
    80003412:	ffffd097          	auipc	ra,0xffffd
    80003416:	12c080e7          	jalr	300(ra) # 8000053e <panic>

000000008000341a <bpin>:
    8000341a:	1101                	addi	sp,sp,-32
    8000341c:	ec06                	sd	ra,24(sp)
    8000341e:	e822                	sd	s0,16(sp)
    80003420:	e426                	sd	s1,8(sp)
    80003422:	1000                	addi	s0,sp,32
    80003424:	84aa                	mv	s1,a0
    80003426:	00013517          	auipc	a0,0x13
    8000342a:	59250513          	addi	a0,a0,1426 # 800169b8 <bcache>
    8000342e:	ffffd097          	auipc	ra,0xffffd
    80003432:	7a8080e7          	jalr	1960(ra) # 80000bd6 <acquire>
    80003436:	40bc                	lw	a5,64(s1)
    80003438:	2785                	addiw	a5,a5,1
    8000343a:	c0bc                	sw	a5,64(s1)
    8000343c:	00013517          	auipc	a0,0x13
    80003440:	57c50513          	addi	a0,a0,1404 # 800169b8 <bcache>
    80003444:	ffffe097          	auipc	ra,0xffffe
    80003448:	846080e7          	jalr	-1978(ra) # 80000c8a <release>
    8000344c:	60e2                	ld	ra,24(sp)
    8000344e:	6442                	ld	s0,16(sp)
    80003450:	64a2                	ld	s1,8(sp)
    80003452:	6105                	addi	sp,sp,32
    80003454:	8082                	ret

0000000080003456 <bunpin>:
    80003456:	1101                	addi	sp,sp,-32
    80003458:	ec06                	sd	ra,24(sp)
    8000345a:	e822                	sd	s0,16(sp)
    8000345c:	e426                	sd	s1,8(sp)
    8000345e:	1000                	addi	s0,sp,32
    80003460:	84aa                	mv	s1,a0
    80003462:	00013517          	auipc	a0,0x13
    80003466:	55650513          	addi	a0,a0,1366 # 800169b8 <bcache>
    8000346a:	ffffd097          	auipc	ra,0xffffd
    8000346e:	76c080e7          	jalr	1900(ra) # 80000bd6 <acquire>
    80003472:	40bc                	lw	a5,64(s1)
    80003474:	37fd                	addiw	a5,a5,-1
    80003476:	c0bc                	sw	a5,64(s1)
    80003478:	00013517          	auipc	a0,0x13
    8000347c:	54050513          	addi	a0,a0,1344 # 800169b8 <bcache>
    80003480:	ffffe097          	auipc	ra,0xffffe
    80003484:	80a080e7          	jalr	-2038(ra) # 80000c8a <release>
    80003488:	60e2                	ld	ra,24(sp)
    8000348a:	6442                	ld	s0,16(sp)
    8000348c:	64a2                	ld	s1,8(sp)
    8000348e:	6105                	addi	sp,sp,32
    80003490:	8082                	ret

0000000080003492 <bfree>:
    80003492:	1101                	addi	sp,sp,-32
    80003494:	ec06                	sd	ra,24(sp)
    80003496:	e822                	sd	s0,16(sp)
    80003498:	e426                	sd	s1,8(sp)
    8000349a:	e04a                	sd	s2,0(sp)
    8000349c:	1000                	addi	s0,sp,32
    8000349e:	84ae                	mv	s1,a1
    800034a0:	00d5d59b          	srliw	a1,a1,0xd
    800034a4:	0001c797          	auipc	a5,0x1c
    800034a8:	bf07a783          	lw	a5,-1040(a5) # 8001f094 <sb+0x1c>
    800034ac:	9dbd                	addw	a1,a1,a5
    800034ae:	00000097          	auipc	ra,0x0
    800034b2:	d9e080e7          	jalr	-610(ra) # 8000324c <bread>
    800034b6:	0074f713          	andi	a4,s1,7
    800034ba:	4785                	li	a5,1
    800034bc:	00e797bb          	sllw	a5,a5,a4
    800034c0:	14ce                	slli	s1,s1,0x33
    800034c2:	90d9                	srli	s1,s1,0x36
    800034c4:	00950733          	add	a4,a0,s1
    800034c8:	05874703          	lbu	a4,88(a4)
    800034cc:	00e7f6b3          	and	a3,a5,a4
    800034d0:	c69d                	beqz	a3,800034fe <bfree+0x6c>
    800034d2:	892a                	mv	s2,a0
    800034d4:	94aa                	add	s1,s1,a0
    800034d6:	fff7c793          	not	a5,a5
    800034da:	8ff9                	and	a5,a5,a4
    800034dc:	04f48c23          	sb	a5,88(s1)
    800034e0:	00001097          	auipc	ra,0x1
    800034e4:	120080e7          	jalr	288(ra) # 80004600 <log_write>
    800034e8:	854a                	mv	a0,s2
    800034ea:	00000097          	auipc	ra,0x0
    800034ee:	e92080e7          	jalr	-366(ra) # 8000337c <brelse>
    800034f2:	60e2                	ld	ra,24(sp)
    800034f4:	6442                	ld	s0,16(sp)
    800034f6:	64a2                	ld	s1,8(sp)
    800034f8:	6902                	ld	s2,0(sp)
    800034fa:	6105                	addi	sp,sp,32
    800034fc:	8082                	ret
    800034fe:	00005517          	auipc	a0,0x5
    80003502:	07a50513          	addi	a0,a0,122 # 80008578 <syscalls+0xf0>
    80003506:	ffffd097          	auipc	ra,0xffffd
    8000350a:	038080e7          	jalr	56(ra) # 8000053e <panic>

000000008000350e <balloc>:
    8000350e:	711d                	addi	sp,sp,-96
    80003510:	ec86                	sd	ra,88(sp)
    80003512:	e8a2                	sd	s0,80(sp)
    80003514:	e4a6                	sd	s1,72(sp)
    80003516:	e0ca                	sd	s2,64(sp)
    80003518:	fc4e                	sd	s3,56(sp)
    8000351a:	f852                	sd	s4,48(sp)
    8000351c:	f456                	sd	s5,40(sp)
    8000351e:	f05a                	sd	s6,32(sp)
    80003520:	ec5e                	sd	s7,24(sp)
    80003522:	e862                	sd	s8,16(sp)
    80003524:	e466                	sd	s9,8(sp)
    80003526:	1080                	addi	s0,sp,96
    80003528:	0001c797          	auipc	a5,0x1c
    8000352c:	b547a783          	lw	a5,-1196(a5) # 8001f07c <sb+0x4>
    80003530:	10078163          	beqz	a5,80003632 <balloc+0x124>
    80003534:	8baa                	mv	s7,a0
    80003536:	4a81                	li	s5,0
    80003538:	0001cb17          	auipc	s6,0x1c
    8000353c:	b40b0b13          	addi	s6,s6,-1216 # 8001f078 <sb>
    80003540:	4c01                	li	s8,0
    80003542:	4985                	li	s3,1
    80003544:	6a09                	lui	s4,0x2
    80003546:	6c89                	lui	s9,0x2
    80003548:	a061                	j	800035d0 <balloc+0xc2>
    8000354a:	974a                	add	a4,a4,s2
    8000354c:	8fd5                	or	a5,a5,a3
    8000354e:	04f70c23          	sb	a5,88(a4)
    80003552:	854a                	mv	a0,s2
    80003554:	00001097          	auipc	ra,0x1
    80003558:	0ac080e7          	jalr	172(ra) # 80004600 <log_write>
    8000355c:	854a                	mv	a0,s2
    8000355e:	00000097          	auipc	ra,0x0
    80003562:	e1e080e7          	jalr	-482(ra) # 8000337c <brelse>
    80003566:	85a6                	mv	a1,s1
    80003568:	855e                	mv	a0,s7
    8000356a:	00000097          	auipc	ra,0x0
    8000356e:	ce2080e7          	jalr	-798(ra) # 8000324c <bread>
    80003572:	892a                	mv	s2,a0
    80003574:	40000613          	li	a2,1024
    80003578:	4581                	li	a1,0
    8000357a:	05850513          	addi	a0,a0,88
    8000357e:	ffffd097          	auipc	ra,0xffffd
    80003582:	754080e7          	jalr	1876(ra) # 80000cd2 <memset>
    80003586:	854a                	mv	a0,s2
    80003588:	00001097          	auipc	ra,0x1
    8000358c:	078080e7          	jalr	120(ra) # 80004600 <log_write>
    80003590:	854a                	mv	a0,s2
    80003592:	00000097          	auipc	ra,0x0
    80003596:	dea080e7          	jalr	-534(ra) # 8000337c <brelse>
    8000359a:	8526                	mv	a0,s1
    8000359c:	60e6                	ld	ra,88(sp)
    8000359e:	6446                	ld	s0,80(sp)
    800035a0:	64a6                	ld	s1,72(sp)
    800035a2:	6906                	ld	s2,64(sp)
    800035a4:	79e2                	ld	s3,56(sp)
    800035a6:	7a42                	ld	s4,48(sp)
    800035a8:	7aa2                	ld	s5,40(sp)
    800035aa:	7b02                	ld	s6,32(sp)
    800035ac:	6be2                	ld	s7,24(sp)
    800035ae:	6c42                	ld	s8,16(sp)
    800035b0:	6ca2                	ld	s9,8(sp)
    800035b2:	6125                	addi	sp,sp,96
    800035b4:	8082                	ret
    800035b6:	854a                	mv	a0,s2
    800035b8:	00000097          	auipc	ra,0x0
    800035bc:	dc4080e7          	jalr	-572(ra) # 8000337c <brelse>
    800035c0:	015c87bb          	addw	a5,s9,s5
    800035c4:	00078a9b          	sext.w	s5,a5
    800035c8:	004b2703          	lw	a4,4(s6)
    800035cc:	06eaf363          	bgeu	s5,a4,80003632 <balloc+0x124>
    800035d0:	41fad79b          	sraiw	a5,s5,0x1f
    800035d4:	0137d79b          	srliw	a5,a5,0x13
    800035d8:	015787bb          	addw	a5,a5,s5
    800035dc:	40d7d79b          	sraiw	a5,a5,0xd
    800035e0:	01cb2583          	lw	a1,28(s6)
    800035e4:	9dbd                	addw	a1,a1,a5
    800035e6:	855e                	mv	a0,s7
    800035e8:	00000097          	auipc	ra,0x0
    800035ec:	c64080e7          	jalr	-924(ra) # 8000324c <bread>
    800035f0:	892a                	mv	s2,a0
    800035f2:	004b2503          	lw	a0,4(s6)
    800035f6:	000a849b          	sext.w	s1,s5
    800035fa:	8662                	mv	a2,s8
    800035fc:	faa4fde3          	bgeu	s1,a0,800035b6 <balloc+0xa8>
    80003600:	41f6579b          	sraiw	a5,a2,0x1f
    80003604:	01d7d69b          	srliw	a3,a5,0x1d
    80003608:	00c6873b          	addw	a4,a3,a2
    8000360c:	00777793          	andi	a5,a4,7
    80003610:	9f95                	subw	a5,a5,a3
    80003612:	00f997bb          	sllw	a5,s3,a5
    80003616:	4037571b          	sraiw	a4,a4,0x3
    8000361a:	00e906b3          	add	a3,s2,a4
    8000361e:	0586c683          	lbu	a3,88(a3)
    80003622:	00d7f5b3          	and	a1,a5,a3
    80003626:	d195                	beqz	a1,8000354a <balloc+0x3c>
    80003628:	2605                	addiw	a2,a2,1
    8000362a:	2485                	addiw	s1,s1,1
    8000362c:	fd4618e3          	bne	a2,s4,800035fc <balloc+0xee>
    80003630:	b759                	j	800035b6 <balloc+0xa8>
    80003632:	00005517          	auipc	a0,0x5
    80003636:	f5e50513          	addi	a0,a0,-162 # 80008590 <syscalls+0x108>
    8000363a:	ffffd097          	auipc	ra,0xffffd
    8000363e:	f4e080e7          	jalr	-178(ra) # 80000588 <printf>
    80003642:	4481                	li	s1,0
    80003644:	bf99                	j	8000359a <balloc+0x8c>

0000000080003646 <bmap>:
    80003646:	7179                	addi	sp,sp,-48
    80003648:	f406                	sd	ra,40(sp)
    8000364a:	f022                	sd	s0,32(sp)
    8000364c:	ec26                	sd	s1,24(sp)
    8000364e:	e84a                	sd	s2,16(sp)
    80003650:	e44e                	sd	s3,8(sp)
    80003652:	e052                	sd	s4,0(sp)
    80003654:	1800                	addi	s0,sp,48
    80003656:	89aa                	mv	s3,a0
    80003658:	47ad                	li	a5,11
    8000365a:	02b7e763          	bltu	a5,a1,80003688 <bmap+0x42>
    8000365e:	02059493          	slli	s1,a1,0x20
    80003662:	9081                	srli	s1,s1,0x20
    80003664:	048a                	slli	s1,s1,0x2
    80003666:	94aa                	add	s1,s1,a0
    80003668:	0504a903          	lw	s2,80(s1)
    8000366c:	06091e63          	bnez	s2,800036e8 <bmap+0xa2>
    80003670:	4108                	lw	a0,0(a0)
    80003672:	00000097          	auipc	ra,0x0
    80003676:	e9c080e7          	jalr	-356(ra) # 8000350e <balloc>
    8000367a:	0005091b          	sext.w	s2,a0
    8000367e:	06090563          	beqz	s2,800036e8 <bmap+0xa2>
    80003682:	0524a823          	sw	s2,80(s1)
    80003686:	a08d                	j	800036e8 <bmap+0xa2>
    80003688:	ff45849b          	addiw	s1,a1,-12
    8000368c:	0004871b          	sext.w	a4,s1
    80003690:	0ff00793          	li	a5,255
    80003694:	08e7e563          	bltu	a5,a4,8000371e <bmap+0xd8>
    80003698:	08052903          	lw	s2,128(a0)
    8000369c:	00091d63          	bnez	s2,800036b6 <bmap+0x70>
    800036a0:	4108                	lw	a0,0(a0)
    800036a2:	00000097          	auipc	ra,0x0
    800036a6:	e6c080e7          	jalr	-404(ra) # 8000350e <balloc>
    800036aa:	0005091b          	sext.w	s2,a0
    800036ae:	02090d63          	beqz	s2,800036e8 <bmap+0xa2>
    800036b2:	0929a023          	sw	s2,128(s3)
    800036b6:	85ca                	mv	a1,s2
    800036b8:	0009a503          	lw	a0,0(s3)
    800036bc:	00000097          	auipc	ra,0x0
    800036c0:	b90080e7          	jalr	-1136(ra) # 8000324c <bread>
    800036c4:	8a2a                	mv	s4,a0
    800036c6:	05850793          	addi	a5,a0,88
    800036ca:	02049593          	slli	a1,s1,0x20
    800036ce:	9181                	srli	a1,a1,0x20
    800036d0:	058a                	slli	a1,a1,0x2
    800036d2:	00b784b3          	add	s1,a5,a1
    800036d6:	0004a903          	lw	s2,0(s1)
    800036da:	02090063          	beqz	s2,800036fa <bmap+0xb4>
    800036de:	8552                	mv	a0,s4
    800036e0:	00000097          	auipc	ra,0x0
    800036e4:	c9c080e7          	jalr	-868(ra) # 8000337c <brelse>
    800036e8:	854a                	mv	a0,s2
    800036ea:	70a2                	ld	ra,40(sp)
    800036ec:	7402                	ld	s0,32(sp)
    800036ee:	64e2                	ld	s1,24(sp)
    800036f0:	6942                	ld	s2,16(sp)
    800036f2:	69a2                	ld	s3,8(sp)
    800036f4:	6a02                	ld	s4,0(sp)
    800036f6:	6145                	addi	sp,sp,48
    800036f8:	8082                	ret
    800036fa:	0009a503          	lw	a0,0(s3)
    800036fe:	00000097          	auipc	ra,0x0
    80003702:	e10080e7          	jalr	-496(ra) # 8000350e <balloc>
    80003706:	0005091b          	sext.w	s2,a0
    8000370a:	fc090ae3          	beqz	s2,800036de <bmap+0x98>
    8000370e:	0124a023          	sw	s2,0(s1)
    80003712:	8552                	mv	a0,s4
    80003714:	00001097          	auipc	ra,0x1
    80003718:	eec080e7          	jalr	-276(ra) # 80004600 <log_write>
    8000371c:	b7c9                	j	800036de <bmap+0x98>
    8000371e:	00005517          	auipc	a0,0x5
    80003722:	e8a50513          	addi	a0,a0,-374 # 800085a8 <syscalls+0x120>
    80003726:	ffffd097          	auipc	ra,0xffffd
    8000372a:	e18080e7          	jalr	-488(ra) # 8000053e <panic>

000000008000372e <iget>:
    8000372e:	7179                	addi	sp,sp,-48
    80003730:	f406                	sd	ra,40(sp)
    80003732:	f022                	sd	s0,32(sp)
    80003734:	ec26                	sd	s1,24(sp)
    80003736:	e84a                	sd	s2,16(sp)
    80003738:	e44e                	sd	s3,8(sp)
    8000373a:	e052                	sd	s4,0(sp)
    8000373c:	1800                	addi	s0,sp,48
    8000373e:	89aa                	mv	s3,a0
    80003740:	8a2e                	mv	s4,a1
    80003742:	0001c517          	auipc	a0,0x1c
    80003746:	95650513          	addi	a0,a0,-1706 # 8001f098 <itable>
    8000374a:	ffffd097          	auipc	ra,0xffffd
    8000374e:	48c080e7          	jalr	1164(ra) # 80000bd6 <acquire>
    80003752:	4901                	li	s2,0
    80003754:	0001c497          	auipc	s1,0x1c
    80003758:	95c48493          	addi	s1,s1,-1700 # 8001f0b0 <itable+0x18>
    8000375c:	0001d697          	auipc	a3,0x1d
    80003760:	3e468693          	addi	a3,a3,996 # 80020b40 <log>
    80003764:	a039                	j	80003772 <iget+0x44>
    80003766:	02090b63          	beqz	s2,8000379c <iget+0x6e>
    8000376a:	08848493          	addi	s1,s1,136
    8000376e:	02d48a63          	beq	s1,a3,800037a2 <iget+0x74>
    80003772:	449c                	lw	a5,8(s1)
    80003774:	fef059e3          	blez	a5,80003766 <iget+0x38>
    80003778:	4098                	lw	a4,0(s1)
    8000377a:	ff3716e3          	bne	a4,s3,80003766 <iget+0x38>
    8000377e:	40d8                	lw	a4,4(s1)
    80003780:	ff4713e3          	bne	a4,s4,80003766 <iget+0x38>
    80003784:	2785                	addiw	a5,a5,1
    80003786:	c49c                	sw	a5,8(s1)
    80003788:	0001c517          	auipc	a0,0x1c
    8000378c:	91050513          	addi	a0,a0,-1776 # 8001f098 <itable>
    80003790:	ffffd097          	auipc	ra,0xffffd
    80003794:	4fa080e7          	jalr	1274(ra) # 80000c8a <release>
    80003798:	8926                	mv	s2,s1
    8000379a:	a03d                	j	800037c8 <iget+0x9a>
    8000379c:	f7f9                	bnez	a5,8000376a <iget+0x3c>
    8000379e:	8926                	mv	s2,s1
    800037a0:	b7e9                	j	8000376a <iget+0x3c>
    800037a2:	02090c63          	beqz	s2,800037da <iget+0xac>
    800037a6:	01392023          	sw	s3,0(s2)
    800037aa:	01492223          	sw	s4,4(s2)
    800037ae:	4785                	li	a5,1
    800037b0:	00f92423          	sw	a5,8(s2)
    800037b4:	04092023          	sw	zero,64(s2)
    800037b8:	0001c517          	auipc	a0,0x1c
    800037bc:	8e050513          	addi	a0,a0,-1824 # 8001f098 <itable>
    800037c0:	ffffd097          	auipc	ra,0xffffd
    800037c4:	4ca080e7          	jalr	1226(ra) # 80000c8a <release>
    800037c8:	854a                	mv	a0,s2
    800037ca:	70a2                	ld	ra,40(sp)
    800037cc:	7402                	ld	s0,32(sp)
    800037ce:	64e2                	ld	s1,24(sp)
    800037d0:	6942                	ld	s2,16(sp)
    800037d2:	69a2                	ld	s3,8(sp)
    800037d4:	6a02                	ld	s4,0(sp)
    800037d6:	6145                	addi	sp,sp,48
    800037d8:	8082                	ret
    800037da:	00005517          	auipc	a0,0x5
    800037de:	de650513          	addi	a0,a0,-538 # 800085c0 <syscalls+0x138>
    800037e2:	ffffd097          	auipc	ra,0xffffd
    800037e6:	d5c080e7          	jalr	-676(ra) # 8000053e <panic>

00000000800037ea <fsinit>:
    800037ea:	7179                	addi	sp,sp,-48
    800037ec:	f406                	sd	ra,40(sp)
    800037ee:	f022                	sd	s0,32(sp)
    800037f0:	ec26                	sd	s1,24(sp)
    800037f2:	e84a                	sd	s2,16(sp)
    800037f4:	e44e                	sd	s3,8(sp)
    800037f6:	1800                	addi	s0,sp,48
    800037f8:	892a                	mv	s2,a0
    800037fa:	4585                	li	a1,1
    800037fc:	00000097          	auipc	ra,0x0
    80003800:	a50080e7          	jalr	-1456(ra) # 8000324c <bread>
    80003804:	84aa                	mv	s1,a0
    80003806:	0001c997          	auipc	s3,0x1c
    8000380a:	87298993          	addi	s3,s3,-1934 # 8001f078 <sb>
    8000380e:	02000613          	li	a2,32
    80003812:	05850593          	addi	a1,a0,88
    80003816:	854e                	mv	a0,s3
    80003818:	ffffd097          	auipc	ra,0xffffd
    8000381c:	516080e7          	jalr	1302(ra) # 80000d2e <memmove>
    80003820:	8526                	mv	a0,s1
    80003822:	00000097          	auipc	ra,0x0
    80003826:	b5a080e7          	jalr	-1190(ra) # 8000337c <brelse>
    8000382a:	0009a703          	lw	a4,0(s3)
    8000382e:	102037b7          	lui	a5,0x10203
    80003832:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80003836:	02f71263          	bne	a4,a5,8000385a <fsinit+0x70>
    8000383a:	0001c597          	auipc	a1,0x1c
    8000383e:	83e58593          	addi	a1,a1,-1986 # 8001f078 <sb>
    80003842:	854a                	mv	a0,s2
    80003844:	00001097          	auipc	ra,0x1
    80003848:	b40080e7          	jalr	-1216(ra) # 80004384 <initlog>
    8000384c:	70a2                	ld	ra,40(sp)
    8000384e:	7402                	ld	s0,32(sp)
    80003850:	64e2                	ld	s1,24(sp)
    80003852:	6942                	ld	s2,16(sp)
    80003854:	69a2                	ld	s3,8(sp)
    80003856:	6145                	addi	sp,sp,48
    80003858:	8082                	ret
    8000385a:	00005517          	auipc	a0,0x5
    8000385e:	d7650513          	addi	a0,a0,-650 # 800085d0 <syscalls+0x148>
    80003862:	ffffd097          	auipc	ra,0xffffd
    80003866:	cdc080e7          	jalr	-804(ra) # 8000053e <panic>

000000008000386a <iinit>:
    8000386a:	7179                	addi	sp,sp,-48
    8000386c:	f406                	sd	ra,40(sp)
    8000386e:	f022                	sd	s0,32(sp)
    80003870:	ec26                	sd	s1,24(sp)
    80003872:	e84a                	sd	s2,16(sp)
    80003874:	e44e                	sd	s3,8(sp)
    80003876:	1800                	addi	s0,sp,48
    80003878:	00005597          	auipc	a1,0x5
    8000387c:	d7058593          	addi	a1,a1,-656 # 800085e8 <syscalls+0x160>
    80003880:	0001c517          	auipc	a0,0x1c
    80003884:	81850513          	addi	a0,a0,-2024 # 8001f098 <itable>
    80003888:	ffffd097          	auipc	ra,0xffffd
    8000388c:	2be080e7          	jalr	702(ra) # 80000b46 <initlock>
    80003890:	0001c497          	auipc	s1,0x1c
    80003894:	83048493          	addi	s1,s1,-2000 # 8001f0c0 <itable+0x28>
    80003898:	0001d997          	auipc	s3,0x1d
    8000389c:	2b898993          	addi	s3,s3,696 # 80020b50 <log+0x10>
    800038a0:	00005917          	auipc	s2,0x5
    800038a4:	d5090913          	addi	s2,s2,-688 # 800085f0 <syscalls+0x168>
    800038a8:	85ca                	mv	a1,s2
    800038aa:	8526                	mv	a0,s1
    800038ac:	00001097          	auipc	ra,0x1
    800038b0:	e3a080e7          	jalr	-454(ra) # 800046e6 <initsleeplock>
    800038b4:	08848493          	addi	s1,s1,136
    800038b8:	ff3498e3          	bne	s1,s3,800038a8 <iinit+0x3e>
    800038bc:	70a2                	ld	ra,40(sp)
    800038be:	7402                	ld	s0,32(sp)
    800038c0:	64e2                	ld	s1,24(sp)
    800038c2:	6942                	ld	s2,16(sp)
    800038c4:	69a2                	ld	s3,8(sp)
    800038c6:	6145                	addi	sp,sp,48
    800038c8:	8082                	ret

00000000800038ca <ialloc>:
    800038ca:	715d                	addi	sp,sp,-80
    800038cc:	e486                	sd	ra,72(sp)
    800038ce:	e0a2                	sd	s0,64(sp)
    800038d0:	fc26                	sd	s1,56(sp)
    800038d2:	f84a                	sd	s2,48(sp)
    800038d4:	f44e                	sd	s3,40(sp)
    800038d6:	f052                	sd	s4,32(sp)
    800038d8:	ec56                	sd	s5,24(sp)
    800038da:	e85a                	sd	s6,16(sp)
    800038dc:	e45e                	sd	s7,8(sp)
    800038de:	0880                	addi	s0,sp,80
    800038e0:	0001b717          	auipc	a4,0x1b
    800038e4:	7a472703          	lw	a4,1956(a4) # 8001f084 <sb+0xc>
    800038e8:	4785                	li	a5,1
    800038ea:	04e7fa63          	bgeu	a5,a4,8000393e <ialloc+0x74>
    800038ee:	8aaa                	mv	s5,a0
    800038f0:	8bae                	mv	s7,a1
    800038f2:	4485                	li	s1,1
    800038f4:	0001ba17          	auipc	s4,0x1b
    800038f8:	784a0a13          	addi	s4,s4,1924 # 8001f078 <sb>
    800038fc:	00048b1b          	sext.w	s6,s1
    80003900:	0044d793          	srli	a5,s1,0x4
    80003904:	018a2583          	lw	a1,24(s4)
    80003908:	9dbd                	addw	a1,a1,a5
    8000390a:	8556                	mv	a0,s5
    8000390c:	00000097          	auipc	ra,0x0
    80003910:	940080e7          	jalr	-1728(ra) # 8000324c <bread>
    80003914:	892a                	mv	s2,a0
    80003916:	05850993          	addi	s3,a0,88
    8000391a:	00f4f793          	andi	a5,s1,15
    8000391e:	079a                	slli	a5,a5,0x6
    80003920:	99be                	add	s3,s3,a5
    80003922:	00099783          	lh	a5,0(s3)
    80003926:	c3a1                	beqz	a5,80003966 <ialloc+0x9c>
    80003928:	00000097          	auipc	ra,0x0
    8000392c:	a54080e7          	jalr	-1452(ra) # 8000337c <brelse>
    80003930:	0485                	addi	s1,s1,1
    80003932:	00ca2703          	lw	a4,12(s4)
    80003936:	0004879b          	sext.w	a5,s1
    8000393a:	fce7e1e3          	bltu	a5,a4,800038fc <ialloc+0x32>
    8000393e:	00005517          	auipc	a0,0x5
    80003942:	cba50513          	addi	a0,a0,-838 # 800085f8 <syscalls+0x170>
    80003946:	ffffd097          	auipc	ra,0xffffd
    8000394a:	c42080e7          	jalr	-958(ra) # 80000588 <printf>
    8000394e:	4501                	li	a0,0
    80003950:	60a6                	ld	ra,72(sp)
    80003952:	6406                	ld	s0,64(sp)
    80003954:	74e2                	ld	s1,56(sp)
    80003956:	7942                	ld	s2,48(sp)
    80003958:	79a2                	ld	s3,40(sp)
    8000395a:	7a02                	ld	s4,32(sp)
    8000395c:	6ae2                	ld	s5,24(sp)
    8000395e:	6b42                	ld	s6,16(sp)
    80003960:	6ba2                	ld	s7,8(sp)
    80003962:	6161                	addi	sp,sp,80
    80003964:	8082                	ret
    80003966:	04000613          	li	a2,64
    8000396a:	4581                	li	a1,0
    8000396c:	854e                	mv	a0,s3
    8000396e:	ffffd097          	auipc	ra,0xffffd
    80003972:	364080e7          	jalr	868(ra) # 80000cd2 <memset>
    80003976:	01799023          	sh	s7,0(s3)
    8000397a:	854a                	mv	a0,s2
    8000397c:	00001097          	auipc	ra,0x1
    80003980:	c84080e7          	jalr	-892(ra) # 80004600 <log_write>
    80003984:	854a                	mv	a0,s2
    80003986:	00000097          	auipc	ra,0x0
    8000398a:	9f6080e7          	jalr	-1546(ra) # 8000337c <brelse>
    8000398e:	85da                	mv	a1,s6
    80003990:	8556                	mv	a0,s5
    80003992:	00000097          	auipc	ra,0x0
    80003996:	d9c080e7          	jalr	-612(ra) # 8000372e <iget>
    8000399a:	bf5d                	j	80003950 <ialloc+0x86>

000000008000399c <iupdate>:
    8000399c:	1101                	addi	sp,sp,-32
    8000399e:	ec06                	sd	ra,24(sp)
    800039a0:	e822                	sd	s0,16(sp)
    800039a2:	e426                	sd	s1,8(sp)
    800039a4:	e04a                	sd	s2,0(sp)
    800039a6:	1000                	addi	s0,sp,32
    800039a8:	84aa                	mv	s1,a0
    800039aa:	415c                	lw	a5,4(a0)
    800039ac:	0047d79b          	srliw	a5,a5,0x4
    800039b0:	0001b597          	auipc	a1,0x1b
    800039b4:	6e05a583          	lw	a1,1760(a1) # 8001f090 <sb+0x18>
    800039b8:	9dbd                	addw	a1,a1,a5
    800039ba:	4108                	lw	a0,0(a0)
    800039bc:	00000097          	auipc	ra,0x0
    800039c0:	890080e7          	jalr	-1904(ra) # 8000324c <bread>
    800039c4:	892a                	mv	s2,a0
    800039c6:	05850793          	addi	a5,a0,88
    800039ca:	40c8                	lw	a0,4(s1)
    800039cc:	893d                	andi	a0,a0,15
    800039ce:	051a                	slli	a0,a0,0x6
    800039d0:	953e                	add	a0,a0,a5
    800039d2:	04449703          	lh	a4,68(s1)
    800039d6:	00e51023          	sh	a4,0(a0)
    800039da:	04649703          	lh	a4,70(s1)
    800039de:	00e51123          	sh	a4,2(a0)
    800039e2:	04849703          	lh	a4,72(s1)
    800039e6:	00e51223          	sh	a4,4(a0)
    800039ea:	04a49703          	lh	a4,74(s1)
    800039ee:	00e51323          	sh	a4,6(a0)
    800039f2:	44f8                	lw	a4,76(s1)
    800039f4:	c518                	sw	a4,8(a0)
    800039f6:	03400613          	li	a2,52
    800039fa:	05048593          	addi	a1,s1,80
    800039fe:	0531                	addi	a0,a0,12
    80003a00:	ffffd097          	auipc	ra,0xffffd
    80003a04:	32e080e7          	jalr	814(ra) # 80000d2e <memmove>
    80003a08:	854a                	mv	a0,s2
    80003a0a:	00001097          	auipc	ra,0x1
    80003a0e:	bf6080e7          	jalr	-1034(ra) # 80004600 <log_write>
    80003a12:	854a                	mv	a0,s2
    80003a14:	00000097          	auipc	ra,0x0
    80003a18:	968080e7          	jalr	-1688(ra) # 8000337c <brelse>
    80003a1c:	60e2                	ld	ra,24(sp)
    80003a1e:	6442                	ld	s0,16(sp)
    80003a20:	64a2                	ld	s1,8(sp)
    80003a22:	6902                	ld	s2,0(sp)
    80003a24:	6105                	addi	sp,sp,32
    80003a26:	8082                	ret

0000000080003a28 <idup>:
    80003a28:	1101                	addi	sp,sp,-32
    80003a2a:	ec06                	sd	ra,24(sp)
    80003a2c:	e822                	sd	s0,16(sp)
    80003a2e:	e426                	sd	s1,8(sp)
    80003a30:	1000                	addi	s0,sp,32
    80003a32:	84aa                	mv	s1,a0
    80003a34:	0001b517          	auipc	a0,0x1b
    80003a38:	66450513          	addi	a0,a0,1636 # 8001f098 <itable>
    80003a3c:	ffffd097          	auipc	ra,0xffffd
    80003a40:	19a080e7          	jalr	410(ra) # 80000bd6 <acquire>
    80003a44:	449c                	lw	a5,8(s1)
    80003a46:	2785                	addiw	a5,a5,1
    80003a48:	c49c                	sw	a5,8(s1)
    80003a4a:	0001b517          	auipc	a0,0x1b
    80003a4e:	64e50513          	addi	a0,a0,1614 # 8001f098 <itable>
    80003a52:	ffffd097          	auipc	ra,0xffffd
    80003a56:	238080e7          	jalr	568(ra) # 80000c8a <release>
    80003a5a:	8526                	mv	a0,s1
    80003a5c:	60e2                	ld	ra,24(sp)
    80003a5e:	6442                	ld	s0,16(sp)
    80003a60:	64a2                	ld	s1,8(sp)
    80003a62:	6105                	addi	sp,sp,32
    80003a64:	8082                	ret

0000000080003a66 <ilock>:
    80003a66:	1101                	addi	sp,sp,-32
    80003a68:	ec06                	sd	ra,24(sp)
    80003a6a:	e822                	sd	s0,16(sp)
    80003a6c:	e426                	sd	s1,8(sp)
    80003a6e:	e04a                	sd	s2,0(sp)
    80003a70:	1000                	addi	s0,sp,32
    80003a72:	c115                	beqz	a0,80003a96 <ilock+0x30>
    80003a74:	84aa                	mv	s1,a0
    80003a76:	451c                	lw	a5,8(a0)
    80003a78:	00f05f63          	blez	a5,80003a96 <ilock+0x30>
    80003a7c:	0541                	addi	a0,a0,16
    80003a7e:	00001097          	auipc	ra,0x1
    80003a82:	ca2080e7          	jalr	-862(ra) # 80004720 <acquiresleep>
    80003a86:	40bc                	lw	a5,64(s1)
    80003a88:	cf99                	beqz	a5,80003aa6 <ilock+0x40>
    80003a8a:	60e2                	ld	ra,24(sp)
    80003a8c:	6442                	ld	s0,16(sp)
    80003a8e:	64a2                	ld	s1,8(sp)
    80003a90:	6902                	ld	s2,0(sp)
    80003a92:	6105                	addi	sp,sp,32
    80003a94:	8082                	ret
    80003a96:	00005517          	auipc	a0,0x5
    80003a9a:	b7a50513          	addi	a0,a0,-1158 # 80008610 <syscalls+0x188>
    80003a9e:	ffffd097          	auipc	ra,0xffffd
    80003aa2:	aa0080e7          	jalr	-1376(ra) # 8000053e <panic>
    80003aa6:	40dc                	lw	a5,4(s1)
    80003aa8:	0047d79b          	srliw	a5,a5,0x4
    80003aac:	0001b597          	auipc	a1,0x1b
    80003ab0:	5e45a583          	lw	a1,1508(a1) # 8001f090 <sb+0x18>
    80003ab4:	9dbd                	addw	a1,a1,a5
    80003ab6:	4088                	lw	a0,0(s1)
    80003ab8:	fffff097          	auipc	ra,0xfffff
    80003abc:	794080e7          	jalr	1940(ra) # 8000324c <bread>
    80003ac0:	892a                	mv	s2,a0
    80003ac2:	05850593          	addi	a1,a0,88
    80003ac6:	40dc                	lw	a5,4(s1)
    80003ac8:	8bbd                	andi	a5,a5,15
    80003aca:	079a                	slli	a5,a5,0x6
    80003acc:	95be                	add	a1,a1,a5
    80003ace:	00059783          	lh	a5,0(a1)
    80003ad2:	04f49223          	sh	a5,68(s1)
    80003ad6:	00259783          	lh	a5,2(a1)
    80003ada:	04f49323          	sh	a5,70(s1)
    80003ade:	00459783          	lh	a5,4(a1)
    80003ae2:	04f49423          	sh	a5,72(s1)
    80003ae6:	00659783          	lh	a5,6(a1)
    80003aea:	04f49523          	sh	a5,74(s1)
    80003aee:	459c                	lw	a5,8(a1)
    80003af0:	c4fc                	sw	a5,76(s1)
    80003af2:	03400613          	li	a2,52
    80003af6:	05b1                	addi	a1,a1,12
    80003af8:	05048513          	addi	a0,s1,80
    80003afc:	ffffd097          	auipc	ra,0xffffd
    80003b00:	232080e7          	jalr	562(ra) # 80000d2e <memmove>
    80003b04:	854a                	mv	a0,s2
    80003b06:	00000097          	auipc	ra,0x0
    80003b0a:	876080e7          	jalr	-1930(ra) # 8000337c <brelse>
    80003b0e:	4785                	li	a5,1
    80003b10:	c0bc                	sw	a5,64(s1)
    80003b12:	04449783          	lh	a5,68(s1)
    80003b16:	fbb5                	bnez	a5,80003a8a <ilock+0x24>
    80003b18:	00005517          	auipc	a0,0x5
    80003b1c:	b0050513          	addi	a0,a0,-1280 # 80008618 <syscalls+0x190>
    80003b20:	ffffd097          	auipc	ra,0xffffd
    80003b24:	a1e080e7          	jalr	-1506(ra) # 8000053e <panic>

0000000080003b28 <iunlock>:
    80003b28:	1101                	addi	sp,sp,-32
    80003b2a:	ec06                	sd	ra,24(sp)
    80003b2c:	e822                	sd	s0,16(sp)
    80003b2e:	e426                	sd	s1,8(sp)
    80003b30:	e04a                	sd	s2,0(sp)
    80003b32:	1000                	addi	s0,sp,32
    80003b34:	c905                	beqz	a0,80003b64 <iunlock+0x3c>
    80003b36:	84aa                	mv	s1,a0
    80003b38:	01050913          	addi	s2,a0,16
    80003b3c:	854a                	mv	a0,s2
    80003b3e:	00001097          	auipc	ra,0x1
    80003b42:	c7c080e7          	jalr	-900(ra) # 800047ba <holdingsleep>
    80003b46:	cd19                	beqz	a0,80003b64 <iunlock+0x3c>
    80003b48:	449c                	lw	a5,8(s1)
    80003b4a:	00f05d63          	blez	a5,80003b64 <iunlock+0x3c>
    80003b4e:	854a                	mv	a0,s2
    80003b50:	00001097          	auipc	ra,0x1
    80003b54:	c26080e7          	jalr	-986(ra) # 80004776 <releasesleep>
    80003b58:	60e2                	ld	ra,24(sp)
    80003b5a:	6442                	ld	s0,16(sp)
    80003b5c:	64a2                	ld	s1,8(sp)
    80003b5e:	6902                	ld	s2,0(sp)
    80003b60:	6105                	addi	sp,sp,32
    80003b62:	8082                	ret
    80003b64:	00005517          	auipc	a0,0x5
    80003b68:	ac450513          	addi	a0,a0,-1340 # 80008628 <syscalls+0x1a0>
    80003b6c:	ffffd097          	auipc	ra,0xffffd
    80003b70:	9d2080e7          	jalr	-1582(ra) # 8000053e <panic>

0000000080003b74 <itrunc>:
    80003b74:	7179                	addi	sp,sp,-48
    80003b76:	f406                	sd	ra,40(sp)
    80003b78:	f022                	sd	s0,32(sp)
    80003b7a:	ec26                	sd	s1,24(sp)
    80003b7c:	e84a                	sd	s2,16(sp)
    80003b7e:	e44e                	sd	s3,8(sp)
    80003b80:	e052                	sd	s4,0(sp)
    80003b82:	1800                	addi	s0,sp,48
    80003b84:	89aa                	mv	s3,a0
    80003b86:	05050493          	addi	s1,a0,80
    80003b8a:	08050913          	addi	s2,a0,128
    80003b8e:	a021                	j	80003b96 <itrunc+0x22>
    80003b90:	0491                	addi	s1,s1,4
    80003b92:	01248d63          	beq	s1,s2,80003bac <itrunc+0x38>
    80003b96:	408c                	lw	a1,0(s1)
    80003b98:	dde5                	beqz	a1,80003b90 <itrunc+0x1c>
    80003b9a:	0009a503          	lw	a0,0(s3)
    80003b9e:	00000097          	auipc	ra,0x0
    80003ba2:	8f4080e7          	jalr	-1804(ra) # 80003492 <bfree>
    80003ba6:	0004a023          	sw	zero,0(s1)
    80003baa:	b7dd                	j	80003b90 <itrunc+0x1c>
    80003bac:	0809a583          	lw	a1,128(s3)
    80003bb0:	e185                	bnez	a1,80003bd0 <itrunc+0x5c>
    80003bb2:	0409a623          	sw	zero,76(s3)
    80003bb6:	854e                	mv	a0,s3
    80003bb8:	00000097          	auipc	ra,0x0
    80003bbc:	de4080e7          	jalr	-540(ra) # 8000399c <iupdate>
    80003bc0:	70a2                	ld	ra,40(sp)
    80003bc2:	7402                	ld	s0,32(sp)
    80003bc4:	64e2                	ld	s1,24(sp)
    80003bc6:	6942                	ld	s2,16(sp)
    80003bc8:	69a2                	ld	s3,8(sp)
    80003bca:	6a02                	ld	s4,0(sp)
    80003bcc:	6145                	addi	sp,sp,48
    80003bce:	8082                	ret
    80003bd0:	0009a503          	lw	a0,0(s3)
    80003bd4:	fffff097          	auipc	ra,0xfffff
    80003bd8:	678080e7          	jalr	1656(ra) # 8000324c <bread>
    80003bdc:	8a2a                	mv	s4,a0
    80003bde:	05850493          	addi	s1,a0,88
    80003be2:	45850913          	addi	s2,a0,1112
    80003be6:	a021                	j	80003bee <itrunc+0x7a>
    80003be8:	0491                	addi	s1,s1,4
    80003bea:	01248b63          	beq	s1,s2,80003c00 <itrunc+0x8c>
    80003bee:	408c                	lw	a1,0(s1)
    80003bf0:	dde5                	beqz	a1,80003be8 <itrunc+0x74>
    80003bf2:	0009a503          	lw	a0,0(s3)
    80003bf6:	00000097          	auipc	ra,0x0
    80003bfa:	89c080e7          	jalr	-1892(ra) # 80003492 <bfree>
    80003bfe:	b7ed                	j	80003be8 <itrunc+0x74>
    80003c00:	8552                	mv	a0,s4
    80003c02:	fffff097          	auipc	ra,0xfffff
    80003c06:	77a080e7          	jalr	1914(ra) # 8000337c <brelse>
    80003c0a:	0809a583          	lw	a1,128(s3)
    80003c0e:	0009a503          	lw	a0,0(s3)
    80003c12:	00000097          	auipc	ra,0x0
    80003c16:	880080e7          	jalr	-1920(ra) # 80003492 <bfree>
    80003c1a:	0809a023          	sw	zero,128(s3)
    80003c1e:	bf51                	j	80003bb2 <itrunc+0x3e>

0000000080003c20 <iput>:
    80003c20:	1101                	addi	sp,sp,-32
    80003c22:	ec06                	sd	ra,24(sp)
    80003c24:	e822                	sd	s0,16(sp)
    80003c26:	e426                	sd	s1,8(sp)
    80003c28:	e04a                	sd	s2,0(sp)
    80003c2a:	1000                	addi	s0,sp,32
    80003c2c:	84aa                	mv	s1,a0
    80003c2e:	0001b517          	auipc	a0,0x1b
    80003c32:	46a50513          	addi	a0,a0,1130 # 8001f098 <itable>
    80003c36:	ffffd097          	auipc	ra,0xffffd
    80003c3a:	fa0080e7          	jalr	-96(ra) # 80000bd6 <acquire>
    80003c3e:	4498                	lw	a4,8(s1)
    80003c40:	4785                	li	a5,1
    80003c42:	02f70363          	beq	a4,a5,80003c68 <iput+0x48>
    80003c46:	449c                	lw	a5,8(s1)
    80003c48:	37fd                	addiw	a5,a5,-1
    80003c4a:	c49c                	sw	a5,8(s1)
    80003c4c:	0001b517          	auipc	a0,0x1b
    80003c50:	44c50513          	addi	a0,a0,1100 # 8001f098 <itable>
    80003c54:	ffffd097          	auipc	ra,0xffffd
    80003c58:	036080e7          	jalr	54(ra) # 80000c8a <release>
    80003c5c:	60e2                	ld	ra,24(sp)
    80003c5e:	6442                	ld	s0,16(sp)
    80003c60:	64a2                	ld	s1,8(sp)
    80003c62:	6902                	ld	s2,0(sp)
    80003c64:	6105                	addi	sp,sp,32
    80003c66:	8082                	ret
    80003c68:	40bc                	lw	a5,64(s1)
    80003c6a:	dff1                	beqz	a5,80003c46 <iput+0x26>
    80003c6c:	04a49783          	lh	a5,74(s1)
    80003c70:	fbf9                	bnez	a5,80003c46 <iput+0x26>
    80003c72:	01048913          	addi	s2,s1,16
    80003c76:	854a                	mv	a0,s2
    80003c78:	00001097          	auipc	ra,0x1
    80003c7c:	aa8080e7          	jalr	-1368(ra) # 80004720 <acquiresleep>
    80003c80:	0001b517          	auipc	a0,0x1b
    80003c84:	41850513          	addi	a0,a0,1048 # 8001f098 <itable>
    80003c88:	ffffd097          	auipc	ra,0xffffd
    80003c8c:	002080e7          	jalr	2(ra) # 80000c8a <release>
    80003c90:	8526                	mv	a0,s1
    80003c92:	00000097          	auipc	ra,0x0
    80003c96:	ee2080e7          	jalr	-286(ra) # 80003b74 <itrunc>
    80003c9a:	04049223          	sh	zero,68(s1)
    80003c9e:	8526                	mv	a0,s1
    80003ca0:	00000097          	auipc	ra,0x0
    80003ca4:	cfc080e7          	jalr	-772(ra) # 8000399c <iupdate>
    80003ca8:	0404a023          	sw	zero,64(s1)
    80003cac:	854a                	mv	a0,s2
    80003cae:	00001097          	auipc	ra,0x1
    80003cb2:	ac8080e7          	jalr	-1336(ra) # 80004776 <releasesleep>
    80003cb6:	0001b517          	auipc	a0,0x1b
    80003cba:	3e250513          	addi	a0,a0,994 # 8001f098 <itable>
    80003cbe:	ffffd097          	auipc	ra,0xffffd
    80003cc2:	f18080e7          	jalr	-232(ra) # 80000bd6 <acquire>
    80003cc6:	b741                	j	80003c46 <iput+0x26>

0000000080003cc8 <iunlockput>:
    80003cc8:	1101                	addi	sp,sp,-32
    80003cca:	ec06                	sd	ra,24(sp)
    80003ccc:	e822                	sd	s0,16(sp)
    80003cce:	e426                	sd	s1,8(sp)
    80003cd0:	1000                	addi	s0,sp,32
    80003cd2:	84aa                	mv	s1,a0
    80003cd4:	00000097          	auipc	ra,0x0
    80003cd8:	e54080e7          	jalr	-428(ra) # 80003b28 <iunlock>
    80003cdc:	8526                	mv	a0,s1
    80003cde:	00000097          	auipc	ra,0x0
    80003ce2:	f42080e7          	jalr	-190(ra) # 80003c20 <iput>
    80003ce6:	60e2                	ld	ra,24(sp)
    80003ce8:	6442                	ld	s0,16(sp)
    80003cea:	64a2                	ld	s1,8(sp)
    80003cec:	6105                	addi	sp,sp,32
    80003cee:	8082                	ret

0000000080003cf0 <stati>:
    80003cf0:	1141                	addi	sp,sp,-16
    80003cf2:	e422                	sd	s0,8(sp)
    80003cf4:	0800                	addi	s0,sp,16
    80003cf6:	411c                	lw	a5,0(a0)
    80003cf8:	c19c                	sw	a5,0(a1)
    80003cfa:	415c                	lw	a5,4(a0)
    80003cfc:	c1dc                	sw	a5,4(a1)
    80003cfe:	04451783          	lh	a5,68(a0)
    80003d02:	00f59423          	sh	a5,8(a1)
    80003d06:	04a51783          	lh	a5,74(a0)
    80003d0a:	00f59523          	sh	a5,10(a1)
    80003d0e:	04c56783          	lwu	a5,76(a0)
    80003d12:	e99c                	sd	a5,16(a1)
    80003d14:	6422                	ld	s0,8(sp)
    80003d16:	0141                	addi	sp,sp,16
    80003d18:	8082                	ret

0000000080003d1a <readi>:
    80003d1a:	457c                	lw	a5,76(a0)
    80003d1c:	0ed7e963          	bltu	a5,a3,80003e0e <readi+0xf4>
    80003d20:	7159                	addi	sp,sp,-112
    80003d22:	f486                	sd	ra,104(sp)
    80003d24:	f0a2                	sd	s0,96(sp)
    80003d26:	eca6                	sd	s1,88(sp)
    80003d28:	e8ca                	sd	s2,80(sp)
    80003d2a:	e4ce                	sd	s3,72(sp)
    80003d2c:	e0d2                	sd	s4,64(sp)
    80003d2e:	fc56                	sd	s5,56(sp)
    80003d30:	f85a                	sd	s6,48(sp)
    80003d32:	f45e                	sd	s7,40(sp)
    80003d34:	f062                	sd	s8,32(sp)
    80003d36:	ec66                	sd	s9,24(sp)
    80003d38:	e86a                	sd	s10,16(sp)
    80003d3a:	e46e                	sd	s11,8(sp)
    80003d3c:	1880                	addi	s0,sp,112
    80003d3e:	8b2a                	mv	s6,a0
    80003d40:	8bae                	mv	s7,a1
    80003d42:	8a32                	mv	s4,a2
    80003d44:	84b6                	mv	s1,a3
    80003d46:	8aba                	mv	s5,a4
    80003d48:	9f35                	addw	a4,a4,a3
    80003d4a:	4501                	li	a0,0
    80003d4c:	0ad76063          	bltu	a4,a3,80003dec <readi+0xd2>
    80003d50:	00e7f463          	bgeu	a5,a4,80003d58 <readi+0x3e>
    80003d54:	40d78abb          	subw	s5,a5,a3
    80003d58:	0a0a8963          	beqz	s5,80003e0a <readi+0xf0>
    80003d5c:	4981                	li	s3,0
    80003d5e:	40000c93          	li	s9,1024
    80003d62:	5c7d                	li	s8,-1
    80003d64:	a82d                	j	80003d9e <readi+0x84>
    80003d66:	020d1d93          	slli	s11,s10,0x20
    80003d6a:	020ddd93          	srli	s11,s11,0x20
    80003d6e:	05890793          	addi	a5,s2,88
    80003d72:	86ee                	mv	a3,s11
    80003d74:	963e                	add	a2,a2,a5
    80003d76:	85d2                	mv	a1,s4
    80003d78:	855e                	mv	a0,s7
    80003d7a:	fffff097          	auipc	ra,0xfffff
    80003d7e:	af2080e7          	jalr	-1294(ra) # 8000286c <either_copyout>
    80003d82:	05850d63          	beq	a0,s8,80003ddc <readi+0xc2>
    80003d86:	854a                	mv	a0,s2
    80003d88:	fffff097          	auipc	ra,0xfffff
    80003d8c:	5f4080e7          	jalr	1524(ra) # 8000337c <brelse>
    80003d90:	013d09bb          	addw	s3,s10,s3
    80003d94:	009d04bb          	addw	s1,s10,s1
    80003d98:	9a6e                	add	s4,s4,s11
    80003d9a:	0559f763          	bgeu	s3,s5,80003de8 <readi+0xce>
    80003d9e:	00a4d59b          	srliw	a1,s1,0xa
    80003da2:	855a                	mv	a0,s6
    80003da4:	00000097          	auipc	ra,0x0
    80003da8:	8a2080e7          	jalr	-1886(ra) # 80003646 <bmap>
    80003dac:	0005059b          	sext.w	a1,a0
    80003db0:	cd85                	beqz	a1,80003de8 <readi+0xce>
    80003db2:	000b2503          	lw	a0,0(s6)
    80003db6:	fffff097          	auipc	ra,0xfffff
    80003dba:	496080e7          	jalr	1174(ra) # 8000324c <bread>
    80003dbe:	892a                	mv	s2,a0
    80003dc0:	3ff4f613          	andi	a2,s1,1023
    80003dc4:	40cc87bb          	subw	a5,s9,a2
    80003dc8:	413a873b          	subw	a4,s5,s3
    80003dcc:	8d3e                	mv	s10,a5
    80003dce:	2781                	sext.w	a5,a5
    80003dd0:	0007069b          	sext.w	a3,a4
    80003dd4:	f8f6f9e3          	bgeu	a3,a5,80003d66 <readi+0x4c>
    80003dd8:	8d3a                	mv	s10,a4
    80003dda:	b771                	j	80003d66 <readi+0x4c>
    80003ddc:	854a                	mv	a0,s2
    80003dde:	fffff097          	auipc	ra,0xfffff
    80003de2:	59e080e7          	jalr	1438(ra) # 8000337c <brelse>
    80003de6:	59fd                	li	s3,-1
    80003de8:	0009851b          	sext.w	a0,s3
    80003dec:	70a6                	ld	ra,104(sp)
    80003dee:	7406                	ld	s0,96(sp)
    80003df0:	64e6                	ld	s1,88(sp)
    80003df2:	6946                	ld	s2,80(sp)
    80003df4:	69a6                	ld	s3,72(sp)
    80003df6:	6a06                	ld	s4,64(sp)
    80003df8:	7ae2                	ld	s5,56(sp)
    80003dfa:	7b42                	ld	s6,48(sp)
    80003dfc:	7ba2                	ld	s7,40(sp)
    80003dfe:	7c02                	ld	s8,32(sp)
    80003e00:	6ce2                	ld	s9,24(sp)
    80003e02:	6d42                	ld	s10,16(sp)
    80003e04:	6da2                	ld	s11,8(sp)
    80003e06:	6165                	addi	sp,sp,112
    80003e08:	8082                	ret
    80003e0a:	89d6                	mv	s3,s5
    80003e0c:	bff1                	j	80003de8 <readi+0xce>
    80003e0e:	4501                	li	a0,0
    80003e10:	8082                	ret

0000000080003e12 <writei>:
    80003e12:	457c                	lw	a5,76(a0)
    80003e14:	10d7e863          	bltu	a5,a3,80003f24 <writei+0x112>
    80003e18:	7159                	addi	sp,sp,-112
    80003e1a:	f486                	sd	ra,104(sp)
    80003e1c:	f0a2                	sd	s0,96(sp)
    80003e1e:	eca6                	sd	s1,88(sp)
    80003e20:	e8ca                	sd	s2,80(sp)
    80003e22:	e4ce                	sd	s3,72(sp)
    80003e24:	e0d2                	sd	s4,64(sp)
    80003e26:	fc56                	sd	s5,56(sp)
    80003e28:	f85a                	sd	s6,48(sp)
    80003e2a:	f45e                	sd	s7,40(sp)
    80003e2c:	f062                	sd	s8,32(sp)
    80003e2e:	ec66                	sd	s9,24(sp)
    80003e30:	e86a                	sd	s10,16(sp)
    80003e32:	e46e                	sd	s11,8(sp)
    80003e34:	1880                	addi	s0,sp,112
    80003e36:	8aaa                	mv	s5,a0
    80003e38:	8bae                	mv	s7,a1
    80003e3a:	8a32                	mv	s4,a2
    80003e3c:	8936                	mv	s2,a3
    80003e3e:	8b3a                	mv	s6,a4
    80003e40:	00e687bb          	addw	a5,a3,a4
    80003e44:	0ed7e263          	bltu	a5,a3,80003f28 <writei+0x116>
    80003e48:	00043737          	lui	a4,0x43
    80003e4c:	0ef76063          	bltu	a4,a5,80003f2c <writei+0x11a>
    80003e50:	0c0b0863          	beqz	s6,80003f20 <writei+0x10e>
    80003e54:	4981                	li	s3,0
    80003e56:	40000c93          	li	s9,1024
    80003e5a:	5c7d                	li	s8,-1
    80003e5c:	a091                	j	80003ea0 <writei+0x8e>
    80003e5e:	020d1d93          	slli	s11,s10,0x20
    80003e62:	020ddd93          	srli	s11,s11,0x20
    80003e66:	05848793          	addi	a5,s1,88
    80003e6a:	86ee                	mv	a3,s11
    80003e6c:	8652                	mv	a2,s4
    80003e6e:	85de                	mv	a1,s7
    80003e70:	953e                	add	a0,a0,a5
    80003e72:	fffff097          	auipc	ra,0xfffff
    80003e76:	a50080e7          	jalr	-1456(ra) # 800028c2 <either_copyin>
    80003e7a:	07850263          	beq	a0,s8,80003ede <writei+0xcc>
    80003e7e:	8526                	mv	a0,s1
    80003e80:	00000097          	auipc	ra,0x0
    80003e84:	780080e7          	jalr	1920(ra) # 80004600 <log_write>
    80003e88:	8526                	mv	a0,s1
    80003e8a:	fffff097          	auipc	ra,0xfffff
    80003e8e:	4f2080e7          	jalr	1266(ra) # 8000337c <brelse>
    80003e92:	013d09bb          	addw	s3,s10,s3
    80003e96:	012d093b          	addw	s2,s10,s2
    80003e9a:	9a6e                	add	s4,s4,s11
    80003e9c:	0569f663          	bgeu	s3,s6,80003ee8 <writei+0xd6>
    80003ea0:	00a9559b          	srliw	a1,s2,0xa
    80003ea4:	8556                	mv	a0,s5
    80003ea6:	fffff097          	auipc	ra,0xfffff
    80003eaa:	7a0080e7          	jalr	1952(ra) # 80003646 <bmap>
    80003eae:	0005059b          	sext.w	a1,a0
    80003eb2:	c99d                	beqz	a1,80003ee8 <writei+0xd6>
    80003eb4:	000aa503          	lw	a0,0(s5)
    80003eb8:	fffff097          	auipc	ra,0xfffff
    80003ebc:	394080e7          	jalr	916(ra) # 8000324c <bread>
    80003ec0:	84aa                	mv	s1,a0
    80003ec2:	3ff97513          	andi	a0,s2,1023
    80003ec6:	40ac87bb          	subw	a5,s9,a0
    80003eca:	413b073b          	subw	a4,s6,s3
    80003ece:	8d3e                	mv	s10,a5
    80003ed0:	2781                	sext.w	a5,a5
    80003ed2:	0007069b          	sext.w	a3,a4
    80003ed6:	f8f6f4e3          	bgeu	a3,a5,80003e5e <writei+0x4c>
    80003eda:	8d3a                	mv	s10,a4
    80003edc:	b749                	j	80003e5e <writei+0x4c>
    80003ede:	8526                	mv	a0,s1
    80003ee0:	fffff097          	auipc	ra,0xfffff
    80003ee4:	49c080e7          	jalr	1180(ra) # 8000337c <brelse>
    80003ee8:	04caa783          	lw	a5,76(s5)
    80003eec:	0127f463          	bgeu	a5,s2,80003ef4 <writei+0xe2>
    80003ef0:	052aa623          	sw	s2,76(s5)
    80003ef4:	8556                	mv	a0,s5
    80003ef6:	00000097          	auipc	ra,0x0
    80003efa:	aa6080e7          	jalr	-1370(ra) # 8000399c <iupdate>
    80003efe:	0009851b          	sext.w	a0,s3
    80003f02:	70a6                	ld	ra,104(sp)
    80003f04:	7406                	ld	s0,96(sp)
    80003f06:	64e6                	ld	s1,88(sp)
    80003f08:	6946                	ld	s2,80(sp)
    80003f0a:	69a6                	ld	s3,72(sp)
    80003f0c:	6a06                	ld	s4,64(sp)
    80003f0e:	7ae2                	ld	s5,56(sp)
    80003f10:	7b42                	ld	s6,48(sp)
    80003f12:	7ba2                	ld	s7,40(sp)
    80003f14:	7c02                	ld	s8,32(sp)
    80003f16:	6ce2                	ld	s9,24(sp)
    80003f18:	6d42                	ld	s10,16(sp)
    80003f1a:	6da2                	ld	s11,8(sp)
    80003f1c:	6165                	addi	sp,sp,112
    80003f1e:	8082                	ret
    80003f20:	89da                	mv	s3,s6
    80003f22:	bfc9                	j	80003ef4 <writei+0xe2>
    80003f24:	557d                	li	a0,-1
    80003f26:	8082                	ret
    80003f28:	557d                	li	a0,-1
    80003f2a:	bfe1                	j	80003f02 <writei+0xf0>
    80003f2c:	557d                	li	a0,-1
    80003f2e:	bfd1                	j	80003f02 <writei+0xf0>

0000000080003f30 <namecmp>:
    80003f30:	1141                	addi	sp,sp,-16
    80003f32:	e406                	sd	ra,8(sp)
    80003f34:	e022                	sd	s0,0(sp)
    80003f36:	0800                	addi	s0,sp,16
    80003f38:	4639                	li	a2,14
    80003f3a:	ffffd097          	auipc	ra,0xffffd
    80003f3e:	e68080e7          	jalr	-408(ra) # 80000da2 <strncmp>
    80003f42:	60a2                	ld	ra,8(sp)
    80003f44:	6402                	ld	s0,0(sp)
    80003f46:	0141                	addi	sp,sp,16
    80003f48:	8082                	ret

0000000080003f4a <dirlookup>:
    80003f4a:	7139                	addi	sp,sp,-64
    80003f4c:	fc06                	sd	ra,56(sp)
    80003f4e:	f822                	sd	s0,48(sp)
    80003f50:	f426                	sd	s1,40(sp)
    80003f52:	f04a                	sd	s2,32(sp)
    80003f54:	ec4e                	sd	s3,24(sp)
    80003f56:	e852                	sd	s4,16(sp)
    80003f58:	0080                	addi	s0,sp,64
    80003f5a:	04451703          	lh	a4,68(a0)
    80003f5e:	4785                	li	a5,1
    80003f60:	00f71a63          	bne	a4,a5,80003f74 <dirlookup+0x2a>
    80003f64:	892a                	mv	s2,a0
    80003f66:	89ae                	mv	s3,a1
    80003f68:	8a32                	mv	s4,a2
    80003f6a:	457c                	lw	a5,76(a0)
    80003f6c:	4481                	li	s1,0
    80003f6e:	4501                	li	a0,0
    80003f70:	e79d                	bnez	a5,80003f9e <dirlookup+0x54>
    80003f72:	a8a5                	j	80003fea <dirlookup+0xa0>
    80003f74:	00004517          	auipc	a0,0x4
    80003f78:	6bc50513          	addi	a0,a0,1724 # 80008630 <syscalls+0x1a8>
    80003f7c:	ffffc097          	auipc	ra,0xffffc
    80003f80:	5c2080e7          	jalr	1474(ra) # 8000053e <panic>
    80003f84:	00004517          	auipc	a0,0x4
    80003f88:	6c450513          	addi	a0,a0,1732 # 80008648 <syscalls+0x1c0>
    80003f8c:	ffffc097          	auipc	ra,0xffffc
    80003f90:	5b2080e7          	jalr	1458(ra) # 8000053e <panic>
    80003f94:	24c1                	addiw	s1,s1,16
    80003f96:	04c92783          	lw	a5,76(s2)
    80003f9a:	04f4f763          	bgeu	s1,a5,80003fe8 <dirlookup+0x9e>
    80003f9e:	4741                	li	a4,16
    80003fa0:	86a6                	mv	a3,s1
    80003fa2:	fc040613          	addi	a2,s0,-64
    80003fa6:	4581                	li	a1,0
    80003fa8:	854a                	mv	a0,s2
    80003faa:	00000097          	auipc	ra,0x0
    80003fae:	d70080e7          	jalr	-656(ra) # 80003d1a <readi>
    80003fb2:	47c1                	li	a5,16
    80003fb4:	fcf518e3          	bne	a0,a5,80003f84 <dirlookup+0x3a>
    80003fb8:	fc045783          	lhu	a5,-64(s0)
    80003fbc:	dfe1                	beqz	a5,80003f94 <dirlookup+0x4a>
    80003fbe:	fc240593          	addi	a1,s0,-62
    80003fc2:	854e                	mv	a0,s3
    80003fc4:	00000097          	auipc	ra,0x0
    80003fc8:	f6c080e7          	jalr	-148(ra) # 80003f30 <namecmp>
    80003fcc:	f561                	bnez	a0,80003f94 <dirlookup+0x4a>
    80003fce:	000a0463          	beqz	s4,80003fd6 <dirlookup+0x8c>
    80003fd2:	009a2023          	sw	s1,0(s4)
    80003fd6:	fc045583          	lhu	a1,-64(s0)
    80003fda:	00092503          	lw	a0,0(s2)
    80003fde:	fffff097          	auipc	ra,0xfffff
    80003fe2:	750080e7          	jalr	1872(ra) # 8000372e <iget>
    80003fe6:	a011                	j	80003fea <dirlookup+0xa0>
    80003fe8:	4501                	li	a0,0
    80003fea:	70e2                	ld	ra,56(sp)
    80003fec:	7442                	ld	s0,48(sp)
    80003fee:	74a2                	ld	s1,40(sp)
    80003ff0:	7902                	ld	s2,32(sp)
    80003ff2:	69e2                	ld	s3,24(sp)
    80003ff4:	6a42                	ld	s4,16(sp)
    80003ff6:	6121                	addi	sp,sp,64
    80003ff8:	8082                	ret

0000000080003ffa <namex>:
    80003ffa:	711d                	addi	sp,sp,-96
    80003ffc:	ec86                	sd	ra,88(sp)
    80003ffe:	e8a2                	sd	s0,80(sp)
    80004000:	e4a6                	sd	s1,72(sp)
    80004002:	e0ca                	sd	s2,64(sp)
    80004004:	fc4e                	sd	s3,56(sp)
    80004006:	f852                	sd	s4,48(sp)
    80004008:	f456                	sd	s5,40(sp)
    8000400a:	f05a                	sd	s6,32(sp)
    8000400c:	ec5e                	sd	s7,24(sp)
    8000400e:	e862                	sd	s8,16(sp)
    80004010:	e466                	sd	s9,8(sp)
    80004012:	1080                	addi	s0,sp,96
    80004014:	84aa                	mv	s1,a0
    80004016:	8aae                	mv	s5,a1
    80004018:	8a32                	mv	s4,a2
    8000401a:	00054703          	lbu	a4,0(a0)
    8000401e:	02f00793          	li	a5,47
    80004022:	02f70363          	beq	a4,a5,80004048 <namex+0x4e>
    80004026:	ffffe097          	auipc	ra,0xffffe
    8000402a:	986080e7          	jalr	-1658(ra) # 800019ac <myproc>
    8000402e:	15053503          	ld	a0,336(a0)
    80004032:	00000097          	auipc	ra,0x0
    80004036:	9f6080e7          	jalr	-1546(ra) # 80003a28 <idup>
    8000403a:	89aa                	mv	s3,a0
    8000403c:	02f00913          	li	s2,47
    80004040:	4b01                	li	s6,0
    80004042:	4c35                	li	s8,13
    80004044:	4b85                	li	s7,1
    80004046:	a865                	j	800040fe <namex+0x104>
    80004048:	4585                	li	a1,1
    8000404a:	4505                	li	a0,1
    8000404c:	fffff097          	auipc	ra,0xfffff
    80004050:	6e2080e7          	jalr	1762(ra) # 8000372e <iget>
    80004054:	89aa                	mv	s3,a0
    80004056:	b7dd                	j	8000403c <namex+0x42>
    80004058:	854e                	mv	a0,s3
    8000405a:	00000097          	auipc	ra,0x0
    8000405e:	c6e080e7          	jalr	-914(ra) # 80003cc8 <iunlockput>
    80004062:	4981                	li	s3,0
    80004064:	854e                	mv	a0,s3
    80004066:	60e6                	ld	ra,88(sp)
    80004068:	6446                	ld	s0,80(sp)
    8000406a:	64a6                	ld	s1,72(sp)
    8000406c:	6906                	ld	s2,64(sp)
    8000406e:	79e2                	ld	s3,56(sp)
    80004070:	7a42                	ld	s4,48(sp)
    80004072:	7aa2                	ld	s5,40(sp)
    80004074:	7b02                	ld	s6,32(sp)
    80004076:	6be2                	ld	s7,24(sp)
    80004078:	6c42                	ld	s8,16(sp)
    8000407a:	6ca2                	ld	s9,8(sp)
    8000407c:	6125                	addi	sp,sp,96
    8000407e:	8082                	ret
    80004080:	854e                	mv	a0,s3
    80004082:	00000097          	auipc	ra,0x0
    80004086:	aa6080e7          	jalr	-1370(ra) # 80003b28 <iunlock>
    8000408a:	bfe9                	j	80004064 <namex+0x6a>
    8000408c:	854e                	mv	a0,s3
    8000408e:	00000097          	auipc	ra,0x0
    80004092:	c3a080e7          	jalr	-966(ra) # 80003cc8 <iunlockput>
    80004096:	89e6                	mv	s3,s9
    80004098:	b7f1                	j	80004064 <namex+0x6a>
    8000409a:	40b48633          	sub	a2,s1,a1
    8000409e:	00060c9b          	sext.w	s9,a2
    800040a2:	099c5463          	bge	s8,s9,8000412a <namex+0x130>
    800040a6:	4639                	li	a2,14
    800040a8:	8552                	mv	a0,s4
    800040aa:	ffffd097          	auipc	ra,0xffffd
    800040ae:	c84080e7          	jalr	-892(ra) # 80000d2e <memmove>
    800040b2:	0004c783          	lbu	a5,0(s1)
    800040b6:	01279763          	bne	a5,s2,800040c4 <namex+0xca>
    800040ba:	0485                	addi	s1,s1,1
    800040bc:	0004c783          	lbu	a5,0(s1)
    800040c0:	ff278de3          	beq	a5,s2,800040ba <namex+0xc0>
    800040c4:	854e                	mv	a0,s3
    800040c6:	00000097          	auipc	ra,0x0
    800040ca:	9a0080e7          	jalr	-1632(ra) # 80003a66 <ilock>
    800040ce:	04499783          	lh	a5,68(s3)
    800040d2:	f97793e3          	bne	a5,s7,80004058 <namex+0x5e>
    800040d6:	000a8563          	beqz	s5,800040e0 <namex+0xe6>
    800040da:	0004c783          	lbu	a5,0(s1)
    800040de:	d3cd                	beqz	a5,80004080 <namex+0x86>
    800040e0:	865a                	mv	a2,s6
    800040e2:	85d2                	mv	a1,s4
    800040e4:	854e                	mv	a0,s3
    800040e6:	00000097          	auipc	ra,0x0
    800040ea:	e64080e7          	jalr	-412(ra) # 80003f4a <dirlookup>
    800040ee:	8caa                	mv	s9,a0
    800040f0:	dd51                	beqz	a0,8000408c <namex+0x92>
    800040f2:	854e                	mv	a0,s3
    800040f4:	00000097          	auipc	ra,0x0
    800040f8:	bd4080e7          	jalr	-1068(ra) # 80003cc8 <iunlockput>
    800040fc:	89e6                	mv	s3,s9
    800040fe:	0004c783          	lbu	a5,0(s1)
    80004102:	05279763          	bne	a5,s2,80004150 <namex+0x156>
    80004106:	0485                	addi	s1,s1,1
    80004108:	0004c783          	lbu	a5,0(s1)
    8000410c:	ff278de3          	beq	a5,s2,80004106 <namex+0x10c>
    80004110:	c79d                	beqz	a5,8000413e <namex+0x144>
    80004112:	85a6                	mv	a1,s1
    80004114:	8cda                	mv	s9,s6
    80004116:	865a                	mv	a2,s6
    80004118:	01278963          	beq	a5,s2,8000412a <namex+0x130>
    8000411c:	dfbd                	beqz	a5,8000409a <namex+0xa0>
    8000411e:	0485                	addi	s1,s1,1
    80004120:	0004c783          	lbu	a5,0(s1)
    80004124:	ff279ce3          	bne	a5,s2,8000411c <namex+0x122>
    80004128:	bf8d                	j	8000409a <namex+0xa0>
    8000412a:	2601                	sext.w	a2,a2
    8000412c:	8552                	mv	a0,s4
    8000412e:	ffffd097          	auipc	ra,0xffffd
    80004132:	c00080e7          	jalr	-1024(ra) # 80000d2e <memmove>
    80004136:	9cd2                	add	s9,s9,s4
    80004138:	000c8023          	sb	zero,0(s9) # 2000 <_entry-0x7fffe000>
    8000413c:	bf9d                	j	800040b2 <namex+0xb8>
    8000413e:	f20a83e3          	beqz	s5,80004064 <namex+0x6a>
    80004142:	854e                	mv	a0,s3
    80004144:	00000097          	auipc	ra,0x0
    80004148:	adc080e7          	jalr	-1316(ra) # 80003c20 <iput>
    8000414c:	4981                	li	s3,0
    8000414e:	bf19                	j	80004064 <namex+0x6a>
    80004150:	d7fd                	beqz	a5,8000413e <namex+0x144>
    80004152:	0004c783          	lbu	a5,0(s1)
    80004156:	85a6                	mv	a1,s1
    80004158:	b7d1                	j	8000411c <namex+0x122>

000000008000415a <dirlink>:
    8000415a:	7139                	addi	sp,sp,-64
    8000415c:	fc06                	sd	ra,56(sp)
    8000415e:	f822                	sd	s0,48(sp)
    80004160:	f426                	sd	s1,40(sp)
    80004162:	f04a                	sd	s2,32(sp)
    80004164:	ec4e                	sd	s3,24(sp)
    80004166:	e852                	sd	s4,16(sp)
    80004168:	0080                	addi	s0,sp,64
    8000416a:	892a                	mv	s2,a0
    8000416c:	8a2e                	mv	s4,a1
    8000416e:	89b2                	mv	s3,a2
    80004170:	4601                	li	a2,0
    80004172:	00000097          	auipc	ra,0x0
    80004176:	dd8080e7          	jalr	-552(ra) # 80003f4a <dirlookup>
    8000417a:	e93d                	bnez	a0,800041f0 <dirlink+0x96>
    8000417c:	04c92483          	lw	s1,76(s2)
    80004180:	c49d                	beqz	s1,800041ae <dirlink+0x54>
    80004182:	4481                	li	s1,0
    80004184:	4741                	li	a4,16
    80004186:	86a6                	mv	a3,s1
    80004188:	fc040613          	addi	a2,s0,-64
    8000418c:	4581                	li	a1,0
    8000418e:	854a                	mv	a0,s2
    80004190:	00000097          	auipc	ra,0x0
    80004194:	b8a080e7          	jalr	-1142(ra) # 80003d1a <readi>
    80004198:	47c1                	li	a5,16
    8000419a:	06f51163          	bne	a0,a5,800041fc <dirlink+0xa2>
    8000419e:	fc045783          	lhu	a5,-64(s0)
    800041a2:	c791                	beqz	a5,800041ae <dirlink+0x54>
    800041a4:	24c1                	addiw	s1,s1,16
    800041a6:	04c92783          	lw	a5,76(s2)
    800041aa:	fcf4ede3          	bltu	s1,a5,80004184 <dirlink+0x2a>
    800041ae:	4639                	li	a2,14
    800041b0:	85d2                	mv	a1,s4
    800041b2:	fc240513          	addi	a0,s0,-62
    800041b6:	ffffd097          	auipc	ra,0xffffd
    800041ba:	c28080e7          	jalr	-984(ra) # 80000dde <strncpy>
    800041be:	fd341023          	sh	s3,-64(s0)
    800041c2:	4741                	li	a4,16
    800041c4:	86a6                	mv	a3,s1
    800041c6:	fc040613          	addi	a2,s0,-64
    800041ca:	4581                	li	a1,0
    800041cc:	854a                	mv	a0,s2
    800041ce:	00000097          	auipc	ra,0x0
    800041d2:	c44080e7          	jalr	-956(ra) # 80003e12 <writei>
    800041d6:	1541                	addi	a0,a0,-16
    800041d8:	00a03533          	snez	a0,a0
    800041dc:	40a00533          	neg	a0,a0
    800041e0:	70e2                	ld	ra,56(sp)
    800041e2:	7442                	ld	s0,48(sp)
    800041e4:	74a2                	ld	s1,40(sp)
    800041e6:	7902                	ld	s2,32(sp)
    800041e8:	69e2                	ld	s3,24(sp)
    800041ea:	6a42                	ld	s4,16(sp)
    800041ec:	6121                	addi	sp,sp,64
    800041ee:	8082                	ret
    800041f0:	00000097          	auipc	ra,0x0
    800041f4:	a30080e7          	jalr	-1488(ra) # 80003c20 <iput>
    800041f8:	557d                	li	a0,-1
    800041fa:	b7dd                	j	800041e0 <dirlink+0x86>
    800041fc:	00004517          	auipc	a0,0x4
    80004200:	45c50513          	addi	a0,a0,1116 # 80008658 <syscalls+0x1d0>
    80004204:	ffffc097          	auipc	ra,0xffffc
    80004208:	33a080e7          	jalr	826(ra) # 8000053e <panic>

000000008000420c <namei>:
    8000420c:	1101                	addi	sp,sp,-32
    8000420e:	ec06                	sd	ra,24(sp)
    80004210:	e822                	sd	s0,16(sp)
    80004212:	1000                	addi	s0,sp,32
    80004214:	fe040613          	addi	a2,s0,-32
    80004218:	4581                	li	a1,0
    8000421a:	00000097          	auipc	ra,0x0
    8000421e:	de0080e7          	jalr	-544(ra) # 80003ffa <namex>
    80004222:	60e2                	ld	ra,24(sp)
    80004224:	6442                	ld	s0,16(sp)
    80004226:	6105                	addi	sp,sp,32
    80004228:	8082                	ret

000000008000422a <nameiparent>:
    8000422a:	1141                	addi	sp,sp,-16
    8000422c:	e406                	sd	ra,8(sp)
    8000422e:	e022                	sd	s0,0(sp)
    80004230:	0800                	addi	s0,sp,16
    80004232:	862e                	mv	a2,a1
    80004234:	4585                	li	a1,1
    80004236:	00000097          	auipc	ra,0x0
    8000423a:	dc4080e7          	jalr	-572(ra) # 80003ffa <namex>
    8000423e:	60a2                	ld	ra,8(sp)
    80004240:	6402                	ld	s0,0(sp)
    80004242:	0141                	addi	sp,sp,16
    80004244:	8082                	ret

0000000080004246 <write_head>:
    80004246:	1101                	addi	sp,sp,-32
    80004248:	ec06                	sd	ra,24(sp)
    8000424a:	e822                	sd	s0,16(sp)
    8000424c:	e426                	sd	s1,8(sp)
    8000424e:	e04a                	sd	s2,0(sp)
    80004250:	1000                	addi	s0,sp,32
    80004252:	0001d917          	auipc	s2,0x1d
    80004256:	8ee90913          	addi	s2,s2,-1810 # 80020b40 <log>
    8000425a:	01892583          	lw	a1,24(s2)
    8000425e:	02892503          	lw	a0,40(s2)
    80004262:	fffff097          	auipc	ra,0xfffff
    80004266:	fea080e7          	jalr	-22(ra) # 8000324c <bread>
    8000426a:	84aa                	mv	s1,a0
    8000426c:	02c92683          	lw	a3,44(s2)
    80004270:	cd34                	sw	a3,88(a0)
    80004272:	02d05763          	blez	a3,800042a0 <write_head+0x5a>
    80004276:	0001d797          	auipc	a5,0x1d
    8000427a:	8fa78793          	addi	a5,a5,-1798 # 80020b70 <log+0x30>
    8000427e:	05c50713          	addi	a4,a0,92
    80004282:	36fd                	addiw	a3,a3,-1
    80004284:	1682                	slli	a3,a3,0x20
    80004286:	9281                	srli	a3,a3,0x20
    80004288:	068a                	slli	a3,a3,0x2
    8000428a:	0001d617          	auipc	a2,0x1d
    8000428e:	8ea60613          	addi	a2,a2,-1814 # 80020b74 <log+0x34>
    80004292:	96b2                	add	a3,a3,a2
    80004294:	4390                	lw	a2,0(a5)
    80004296:	c310                	sw	a2,0(a4)
    80004298:	0791                	addi	a5,a5,4
    8000429a:	0711                	addi	a4,a4,4
    8000429c:	fed79ce3          	bne	a5,a3,80004294 <write_head+0x4e>
    800042a0:	8526                	mv	a0,s1
    800042a2:	fffff097          	auipc	ra,0xfffff
    800042a6:	09c080e7          	jalr	156(ra) # 8000333e <bwrite>
    800042aa:	8526                	mv	a0,s1
    800042ac:	fffff097          	auipc	ra,0xfffff
    800042b0:	0d0080e7          	jalr	208(ra) # 8000337c <brelse>
    800042b4:	60e2                	ld	ra,24(sp)
    800042b6:	6442                	ld	s0,16(sp)
    800042b8:	64a2                	ld	s1,8(sp)
    800042ba:	6902                	ld	s2,0(sp)
    800042bc:	6105                	addi	sp,sp,32
    800042be:	8082                	ret

00000000800042c0 <install_trans>:
    800042c0:	0001d797          	auipc	a5,0x1d
    800042c4:	8ac7a783          	lw	a5,-1876(a5) # 80020b6c <log+0x2c>
    800042c8:	0af05d63          	blez	a5,80004382 <install_trans+0xc2>
    800042cc:	7139                	addi	sp,sp,-64
    800042ce:	fc06                	sd	ra,56(sp)
    800042d0:	f822                	sd	s0,48(sp)
    800042d2:	f426                	sd	s1,40(sp)
    800042d4:	f04a                	sd	s2,32(sp)
    800042d6:	ec4e                	sd	s3,24(sp)
    800042d8:	e852                	sd	s4,16(sp)
    800042da:	e456                	sd	s5,8(sp)
    800042dc:	e05a                	sd	s6,0(sp)
    800042de:	0080                	addi	s0,sp,64
    800042e0:	8b2a                	mv	s6,a0
    800042e2:	0001da97          	auipc	s5,0x1d
    800042e6:	88ea8a93          	addi	s5,s5,-1906 # 80020b70 <log+0x30>
    800042ea:	4a01                	li	s4,0
    800042ec:	0001d997          	auipc	s3,0x1d
    800042f0:	85498993          	addi	s3,s3,-1964 # 80020b40 <log>
    800042f4:	a00d                	j	80004316 <install_trans+0x56>
    800042f6:	854a                	mv	a0,s2
    800042f8:	fffff097          	auipc	ra,0xfffff
    800042fc:	084080e7          	jalr	132(ra) # 8000337c <brelse>
    80004300:	8526                	mv	a0,s1
    80004302:	fffff097          	auipc	ra,0xfffff
    80004306:	07a080e7          	jalr	122(ra) # 8000337c <brelse>
    8000430a:	2a05                	addiw	s4,s4,1
    8000430c:	0a91                	addi	s5,s5,4
    8000430e:	02c9a783          	lw	a5,44(s3)
    80004312:	04fa5e63          	bge	s4,a5,8000436e <install_trans+0xae>
    80004316:	0189a583          	lw	a1,24(s3)
    8000431a:	014585bb          	addw	a1,a1,s4
    8000431e:	2585                	addiw	a1,a1,1
    80004320:	0289a503          	lw	a0,40(s3)
    80004324:	fffff097          	auipc	ra,0xfffff
    80004328:	f28080e7          	jalr	-216(ra) # 8000324c <bread>
    8000432c:	892a                	mv	s2,a0
    8000432e:	000aa583          	lw	a1,0(s5)
    80004332:	0289a503          	lw	a0,40(s3)
    80004336:	fffff097          	auipc	ra,0xfffff
    8000433a:	f16080e7          	jalr	-234(ra) # 8000324c <bread>
    8000433e:	84aa                	mv	s1,a0
    80004340:	40000613          	li	a2,1024
    80004344:	05890593          	addi	a1,s2,88
    80004348:	05850513          	addi	a0,a0,88
    8000434c:	ffffd097          	auipc	ra,0xffffd
    80004350:	9e2080e7          	jalr	-1566(ra) # 80000d2e <memmove>
    80004354:	8526                	mv	a0,s1
    80004356:	fffff097          	auipc	ra,0xfffff
    8000435a:	fe8080e7          	jalr	-24(ra) # 8000333e <bwrite>
    8000435e:	f80b1ce3          	bnez	s6,800042f6 <install_trans+0x36>
    80004362:	8526                	mv	a0,s1
    80004364:	fffff097          	auipc	ra,0xfffff
    80004368:	0f2080e7          	jalr	242(ra) # 80003456 <bunpin>
    8000436c:	b769                	j	800042f6 <install_trans+0x36>
    8000436e:	70e2                	ld	ra,56(sp)
    80004370:	7442                	ld	s0,48(sp)
    80004372:	74a2                	ld	s1,40(sp)
    80004374:	7902                	ld	s2,32(sp)
    80004376:	69e2                	ld	s3,24(sp)
    80004378:	6a42                	ld	s4,16(sp)
    8000437a:	6aa2                	ld	s5,8(sp)
    8000437c:	6b02                	ld	s6,0(sp)
    8000437e:	6121                	addi	sp,sp,64
    80004380:	8082                	ret
    80004382:	8082                	ret

0000000080004384 <initlog>:
    80004384:	7179                	addi	sp,sp,-48
    80004386:	f406                	sd	ra,40(sp)
    80004388:	f022                	sd	s0,32(sp)
    8000438a:	ec26                	sd	s1,24(sp)
    8000438c:	e84a                	sd	s2,16(sp)
    8000438e:	e44e                	sd	s3,8(sp)
    80004390:	1800                	addi	s0,sp,48
    80004392:	892a                	mv	s2,a0
    80004394:	89ae                	mv	s3,a1
    80004396:	0001c497          	auipc	s1,0x1c
    8000439a:	7aa48493          	addi	s1,s1,1962 # 80020b40 <log>
    8000439e:	00004597          	auipc	a1,0x4
    800043a2:	2ca58593          	addi	a1,a1,714 # 80008668 <syscalls+0x1e0>
    800043a6:	8526                	mv	a0,s1
    800043a8:	ffffc097          	auipc	ra,0xffffc
    800043ac:	79e080e7          	jalr	1950(ra) # 80000b46 <initlock>
    800043b0:	0149a583          	lw	a1,20(s3)
    800043b4:	cc8c                	sw	a1,24(s1)
    800043b6:	0109a783          	lw	a5,16(s3)
    800043ba:	ccdc                	sw	a5,28(s1)
    800043bc:	0324a423          	sw	s2,40(s1)
    800043c0:	854a                	mv	a0,s2
    800043c2:	fffff097          	auipc	ra,0xfffff
    800043c6:	e8a080e7          	jalr	-374(ra) # 8000324c <bread>
    800043ca:	4d34                	lw	a3,88(a0)
    800043cc:	d4d4                	sw	a3,44(s1)
    800043ce:	02d05563          	blez	a3,800043f8 <initlog+0x74>
    800043d2:	05c50793          	addi	a5,a0,92
    800043d6:	0001c717          	auipc	a4,0x1c
    800043da:	79a70713          	addi	a4,a4,1946 # 80020b70 <log+0x30>
    800043de:	36fd                	addiw	a3,a3,-1
    800043e0:	1682                	slli	a3,a3,0x20
    800043e2:	9281                	srli	a3,a3,0x20
    800043e4:	068a                	slli	a3,a3,0x2
    800043e6:	06050613          	addi	a2,a0,96
    800043ea:	96b2                	add	a3,a3,a2
    800043ec:	4390                	lw	a2,0(a5)
    800043ee:	c310                	sw	a2,0(a4)
    800043f0:	0791                	addi	a5,a5,4
    800043f2:	0711                	addi	a4,a4,4
    800043f4:	fed79ce3          	bne	a5,a3,800043ec <initlog+0x68>
    800043f8:	fffff097          	auipc	ra,0xfffff
    800043fc:	f84080e7          	jalr	-124(ra) # 8000337c <brelse>
    80004400:	4505                	li	a0,1
    80004402:	00000097          	auipc	ra,0x0
    80004406:	ebe080e7          	jalr	-322(ra) # 800042c0 <install_trans>
    8000440a:	0001c797          	auipc	a5,0x1c
    8000440e:	7607a123          	sw	zero,1890(a5) # 80020b6c <log+0x2c>
    80004412:	00000097          	auipc	ra,0x0
    80004416:	e34080e7          	jalr	-460(ra) # 80004246 <write_head>
    8000441a:	70a2                	ld	ra,40(sp)
    8000441c:	7402                	ld	s0,32(sp)
    8000441e:	64e2                	ld	s1,24(sp)
    80004420:	6942                	ld	s2,16(sp)
    80004422:	69a2                	ld	s3,8(sp)
    80004424:	6145                	addi	sp,sp,48
    80004426:	8082                	ret

0000000080004428 <begin_op>:
    80004428:	1101                	addi	sp,sp,-32
    8000442a:	ec06                	sd	ra,24(sp)
    8000442c:	e822                	sd	s0,16(sp)
    8000442e:	e426                	sd	s1,8(sp)
    80004430:	e04a                	sd	s2,0(sp)
    80004432:	1000                	addi	s0,sp,32
    80004434:	0001c517          	auipc	a0,0x1c
    80004438:	70c50513          	addi	a0,a0,1804 # 80020b40 <log>
    8000443c:	ffffc097          	auipc	ra,0xffffc
    80004440:	79a080e7          	jalr	1946(ra) # 80000bd6 <acquire>
    80004444:	0001c497          	auipc	s1,0x1c
    80004448:	6fc48493          	addi	s1,s1,1788 # 80020b40 <log>
    8000444c:	4979                	li	s2,30
    8000444e:	a039                	j	8000445c <begin_op+0x34>
    80004450:	85a6                	mv	a1,s1
    80004452:	8526                	mv	a0,s1
    80004454:	ffffe097          	auipc	ra,0xffffe
    80004458:	c00080e7          	jalr	-1024(ra) # 80002054 <sleep>
    8000445c:	50dc                	lw	a5,36(s1)
    8000445e:	fbed                	bnez	a5,80004450 <begin_op+0x28>
    80004460:	509c                	lw	a5,32(s1)
    80004462:	0017871b          	addiw	a4,a5,1
    80004466:	0007069b          	sext.w	a3,a4
    8000446a:	0027179b          	slliw	a5,a4,0x2
    8000446e:	9fb9                	addw	a5,a5,a4
    80004470:	0017979b          	slliw	a5,a5,0x1
    80004474:	54d8                	lw	a4,44(s1)
    80004476:	9fb9                	addw	a5,a5,a4
    80004478:	00f95963          	bge	s2,a5,8000448a <begin_op+0x62>
    8000447c:	85a6                	mv	a1,s1
    8000447e:	8526                	mv	a0,s1
    80004480:	ffffe097          	auipc	ra,0xffffe
    80004484:	bd4080e7          	jalr	-1068(ra) # 80002054 <sleep>
    80004488:	bfd1                	j	8000445c <begin_op+0x34>
    8000448a:	0001c517          	auipc	a0,0x1c
    8000448e:	6b650513          	addi	a0,a0,1718 # 80020b40 <log>
    80004492:	d114                	sw	a3,32(a0)
    80004494:	ffffc097          	auipc	ra,0xffffc
    80004498:	7f6080e7          	jalr	2038(ra) # 80000c8a <release>
    8000449c:	60e2                	ld	ra,24(sp)
    8000449e:	6442                	ld	s0,16(sp)
    800044a0:	64a2                	ld	s1,8(sp)
    800044a2:	6902                	ld	s2,0(sp)
    800044a4:	6105                	addi	sp,sp,32
    800044a6:	8082                	ret

00000000800044a8 <end_op>:
    800044a8:	7139                	addi	sp,sp,-64
    800044aa:	fc06                	sd	ra,56(sp)
    800044ac:	f822                	sd	s0,48(sp)
    800044ae:	f426                	sd	s1,40(sp)
    800044b0:	f04a                	sd	s2,32(sp)
    800044b2:	ec4e                	sd	s3,24(sp)
    800044b4:	e852                	sd	s4,16(sp)
    800044b6:	e456                	sd	s5,8(sp)
    800044b8:	0080                	addi	s0,sp,64
    800044ba:	0001c497          	auipc	s1,0x1c
    800044be:	68648493          	addi	s1,s1,1670 # 80020b40 <log>
    800044c2:	8526                	mv	a0,s1
    800044c4:	ffffc097          	auipc	ra,0xffffc
    800044c8:	712080e7          	jalr	1810(ra) # 80000bd6 <acquire>
    800044cc:	509c                	lw	a5,32(s1)
    800044ce:	37fd                	addiw	a5,a5,-1
    800044d0:	0007891b          	sext.w	s2,a5
    800044d4:	d09c                	sw	a5,32(s1)
    800044d6:	50dc                	lw	a5,36(s1)
    800044d8:	e7b9                	bnez	a5,80004526 <end_op+0x7e>
    800044da:	04091e63          	bnez	s2,80004536 <end_op+0x8e>
    800044de:	0001c497          	auipc	s1,0x1c
    800044e2:	66248493          	addi	s1,s1,1634 # 80020b40 <log>
    800044e6:	4785                	li	a5,1
    800044e8:	d0dc                	sw	a5,36(s1)
    800044ea:	8526                	mv	a0,s1
    800044ec:	ffffc097          	auipc	ra,0xffffc
    800044f0:	79e080e7          	jalr	1950(ra) # 80000c8a <release>
    800044f4:	54dc                	lw	a5,44(s1)
    800044f6:	06f04763          	bgtz	a5,80004564 <end_op+0xbc>
    800044fa:	0001c497          	auipc	s1,0x1c
    800044fe:	64648493          	addi	s1,s1,1606 # 80020b40 <log>
    80004502:	8526                	mv	a0,s1
    80004504:	ffffc097          	auipc	ra,0xffffc
    80004508:	6d2080e7          	jalr	1746(ra) # 80000bd6 <acquire>
    8000450c:	0204a223          	sw	zero,36(s1)
    80004510:	8526                	mv	a0,s1
    80004512:	ffffe097          	auipc	ra,0xffffe
    80004516:	ba6080e7          	jalr	-1114(ra) # 800020b8 <wakeup>
    8000451a:	8526                	mv	a0,s1
    8000451c:	ffffc097          	auipc	ra,0xffffc
    80004520:	76e080e7          	jalr	1902(ra) # 80000c8a <release>
    80004524:	a03d                	j	80004552 <end_op+0xaa>
    80004526:	00004517          	auipc	a0,0x4
    8000452a:	14a50513          	addi	a0,a0,330 # 80008670 <syscalls+0x1e8>
    8000452e:	ffffc097          	auipc	ra,0xffffc
    80004532:	010080e7          	jalr	16(ra) # 8000053e <panic>
    80004536:	0001c497          	auipc	s1,0x1c
    8000453a:	60a48493          	addi	s1,s1,1546 # 80020b40 <log>
    8000453e:	8526                	mv	a0,s1
    80004540:	ffffe097          	auipc	ra,0xffffe
    80004544:	b78080e7          	jalr	-1160(ra) # 800020b8 <wakeup>
    80004548:	8526                	mv	a0,s1
    8000454a:	ffffc097          	auipc	ra,0xffffc
    8000454e:	740080e7          	jalr	1856(ra) # 80000c8a <release>
    80004552:	70e2                	ld	ra,56(sp)
    80004554:	7442                	ld	s0,48(sp)
    80004556:	74a2                	ld	s1,40(sp)
    80004558:	7902                	ld	s2,32(sp)
    8000455a:	69e2                	ld	s3,24(sp)
    8000455c:	6a42                	ld	s4,16(sp)
    8000455e:	6aa2                	ld	s5,8(sp)
    80004560:	6121                	addi	sp,sp,64
    80004562:	8082                	ret
    80004564:	0001ca97          	auipc	s5,0x1c
    80004568:	60ca8a93          	addi	s5,s5,1548 # 80020b70 <log+0x30>
    8000456c:	0001ca17          	auipc	s4,0x1c
    80004570:	5d4a0a13          	addi	s4,s4,1492 # 80020b40 <log>
    80004574:	018a2583          	lw	a1,24(s4)
    80004578:	012585bb          	addw	a1,a1,s2
    8000457c:	2585                	addiw	a1,a1,1
    8000457e:	028a2503          	lw	a0,40(s4)
    80004582:	fffff097          	auipc	ra,0xfffff
    80004586:	cca080e7          	jalr	-822(ra) # 8000324c <bread>
    8000458a:	84aa                	mv	s1,a0
    8000458c:	000aa583          	lw	a1,0(s5)
    80004590:	028a2503          	lw	a0,40(s4)
    80004594:	fffff097          	auipc	ra,0xfffff
    80004598:	cb8080e7          	jalr	-840(ra) # 8000324c <bread>
    8000459c:	89aa                	mv	s3,a0
    8000459e:	40000613          	li	a2,1024
    800045a2:	05850593          	addi	a1,a0,88
    800045a6:	05848513          	addi	a0,s1,88
    800045aa:	ffffc097          	auipc	ra,0xffffc
    800045ae:	784080e7          	jalr	1924(ra) # 80000d2e <memmove>
    800045b2:	8526                	mv	a0,s1
    800045b4:	fffff097          	auipc	ra,0xfffff
    800045b8:	d8a080e7          	jalr	-630(ra) # 8000333e <bwrite>
    800045bc:	854e                	mv	a0,s3
    800045be:	fffff097          	auipc	ra,0xfffff
    800045c2:	dbe080e7          	jalr	-578(ra) # 8000337c <brelse>
    800045c6:	8526                	mv	a0,s1
    800045c8:	fffff097          	auipc	ra,0xfffff
    800045cc:	db4080e7          	jalr	-588(ra) # 8000337c <brelse>
    800045d0:	2905                	addiw	s2,s2,1
    800045d2:	0a91                	addi	s5,s5,4
    800045d4:	02ca2783          	lw	a5,44(s4)
    800045d8:	f8f94ee3          	blt	s2,a5,80004574 <end_op+0xcc>
    800045dc:	00000097          	auipc	ra,0x0
    800045e0:	c6a080e7          	jalr	-918(ra) # 80004246 <write_head>
    800045e4:	4501                	li	a0,0
    800045e6:	00000097          	auipc	ra,0x0
    800045ea:	cda080e7          	jalr	-806(ra) # 800042c0 <install_trans>
    800045ee:	0001c797          	auipc	a5,0x1c
    800045f2:	5607af23          	sw	zero,1406(a5) # 80020b6c <log+0x2c>
    800045f6:	00000097          	auipc	ra,0x0
    800045fa:	c50080e7          	jalr	-944(ra) # 80004246 <write_head>
    800045fe:	bdf5                	j	800044fa <end_op+0x52>

0000000080004600 <log_write>:
    80004600:	1101                	addi	sp,sp,-32
    80004602:	ec06                	sd	ra,24(sp)
    80004604:	e822                	sd	s0,16(sp)
    80004606:	e426                	sd	s1,8(sp)
    80004608:	e04a                	sd	s2,0(sp)
    8000460a:	1000                	addi	s0,sp,32
    8000460c:	84aa                	mv	s1,a0
    8000460e:	0001c917          	auipc	s2,0x1c
    80004612:	53290913          	addi	s2,s2,1330 # 80020b40 <log>
    80004616:	854a                	mv	a0,s2
    80004618:	ffffc097          	auipc	ra,0xffffc
    8000461c:	5be080e7          	jalr	1470(ra) # 80000bd6 <acquire>
    80004620:	02c92603          	lw	a2,44(s2)
    80004624:	47f5                	li	a5,29
    80004626:	06c7c563          	blt	a5,a2,80004690 <log_write+0x90>
    8000462a:	0001c797          	auipc	a5,0x1c
    8000462e:	5327a783          	lw	a5,1330(a5) # 80020b5c <log+0x1c>
    80004632:	37fd                	addiw	a5,a5,-1
    80004634:	04f65e63          	bge	a2,a5,80004690 <log_write+0x90>
    80004638:	0001c797          	auipc	a5,0x1c
    8000463c:	5287a783          	lw	a5,1320(a5) # 80020b60 <log+0x20>
    80004640:	06f05063          	blez	a5,800046a0 <log_write+0xa0>
    80004644:	4781                	li	a5,0
    80004646:	06c05563          	blez	a2,800046b0 <log_write+0xb0>
    8000464a:	44cc                	lw	a1,12(s1)
    8000464c:	0001c717          	auipc	a4,0x1c
    80004650:	52470713          	addi	a4,a4,1316 # 80020b70 <log+0x30>
    80004654:	4781                	li	a5,0
    80004656:	4314                	lw	a3,0(a4)
    80004658:	04b68c63          	beq	a3,a1,800046b0 <log_write+0xb0>
    8000465c:	2785                	addiw	a5,a5,1
    8000465e:	0711                	addi	a4,a4,4
    80004660:	fef61be3          	bne	a2,a5,80004656 <log_write+0x56>
    80004664:	0621                	addi	a2,a2,8
    80004666:	060a                	slli	a2,a2,0x2
    80004668:	0001c797          	auipc	a5,0x1c
    8000466c:	4d878793          	addi	a5,a5,1240 # 80020b40 <log>
    80004670:	963e                	add	a2,a2,a5
    80004672:	44dc                	lw	a5,12(s1)
    80004674:	ca1c                	sw	a5,16(a2)
    80004676:	8526                	mv	a0,s1
    80004678:	fffff097          	auipc	ra,0xfffff
    8000467c:	da2080e7          	jalr	-606(ra) # 8000341a <bpin>
    80004680:	0001c717          	auipc	a4,0x1c
    80004684:	4c070713          	addi	a4,a4,1216 # 80020b40 <log>
    80004688:	575c                	lw	a5,44(a4)
    8000468a:	2785                	addiw	a5,a5,1
    8000468c:	d75c                	sw	a5,44(a4)
    8000468e:	a835                	j	800046ca <log_write+0xca>
    80004690:	00004517          	auipc	a0,0x4
    80004694:	ff050513          	addi	a0,a0,-16 # 80008680 <syscalls+0x1f8>
    80004698:	ffffc097          	auipc	ra,0xffffc
    8000469c:	ea6080e7          	jalr	-346(ra) # 8000053e <panic>
    800046a0:	00004517          	auipc	a0,0x4
    800046a4:	ff850513          	addi	a0,a0,-8 # 80008698 <syscalls+0x210>
    800046a8:	ffffc097          	auipc	ra,0xffffc
    800046ac:	e96080e7          	jalr	-362(ra) # 8000053e <panic>
    800046b0:	00878713          	addi	a4,a5,8
    800046b4:	00271693          	slli	a3,a4,0x2
    800046b8:	0001c717          	auipc	a4,0x1c
    800046bc:	48870713          	addi	a4,a4,1160 # 80020b40 <log>
    800046c0:	9736                	add	a4,a4,a3
    800046c2:	44d4                	lw	a3,12(s1)
    800046c4:	cb14                	sw	a3,16(a4)
    800046c6:	faf608e3          	beq	a2,a5,80004676 <log_write+0x76>
    800046ca:	0001c517          	auipc	a0,0x1c
    800046ce:	47650513          	addi	a0,a0,1142 # 80020b40 <log>
    800046d2:	ffffc097          	auipc	ra,0xffffc
    800046d6:	5b8080e7          	jalr	1464(ra) # 80000c8a <release>
    800046da:	60e2                	ld	ra,24(sp)
    800046dc:	6442                	ld	s0,16(sp)
    800046de:	64a2                	ld	s1,8(sp)
    800046e0:	6902                	ld	s2,0(sp)
    800046e2:	6105                	addi	sp,sp,32
    800046e4:	8082                	ret

00000000800046e6 <initsleeplock>:
    800046e6:	1101                	addi	sp,sp,-32
    800046e8:	ec06                	sd	ra,24(sp)
    800046ea:	e822                	sd	s0,16(sp)
    800046ec:	e426                	sd	s1,8(sp)
    800046ee:	e04a                	sd	s2,0(sp)
    800046f0:	1000                	addi	s0,sp,32
    800046f2:	84aa                	mv	s1,a0
    800046f4:	892e                	mv	s2,a1
    800046f6:	00004597          	auipc	a1,0x4
    800046fa:	fc258593          	addi	a1,a1,-62 # 800086b8 <syscalls+0x230>
    800046fe:	0521                	addi	a0,a0,8
    80004700:	ffffc097          	auipc	ra,0xffffc
    80004704:	446080e7          	jalr	1094(ra) # 80000b46 <initlock>
    80004708:	0324b023          	sd	s2,32(s1)
    8000470c:	0004a023          	sw	zero,0(s1)
    80004710:	0204a423          	sw	zero,40(s1)
    80004714:	60e2                	ld	ra,24(sp)
    80004716:	6442                	ld	s0,16(sp)
    80004718:	64a2                	ld	s1,8(sp)
    8000471a:	6902                	ld	s2,0(sp)
    8000471c:	6105                	addi	sp,sp,32
    8000471e:	8082                	ret

0000000080004720 <acquiresleep>:
    80004720:	1101                	addi	sp,sp,-32
    80004722:	ec06                	sd	ra,24(sp)
    80004724:	e822                	sd	s0,16(sp)
    80004726:	e426                	sd	s1,8(sp)
    80004728:	e04a                	sd	s2,0(sp)
    8000472a:	1000                	addi	s0,sp,32
    8000472c:	84aa                	mv	s1,a0
    8000472e:	00850913          	addi	s2,a0,8
    80004732:	854a                	mv	a0,s2
    80004734:	ffffc097          	auipc	ra,0xffffc
    80004738:	4a2080e7          	jalr	1186(ra) # 80000bd6 <acquire>
    8000473c:	409c                	lw	a5,0(s1)
    8000473e:	cb89                	beqz	a5,80004750 <acquiresleep+0x30>
    80004740:	85ca                	mv	a1,s2
    80004742:	8526                	mv	a0,s1
    80004744:	ffffe097          	auipc	ra,0xffffe
    80004748:	910080e7          	jalr	-1776(ra) # 80002054 <sleep>
    8000474c:	409c                	lw	a5,0(s1)
    8000474e:	fbed                	bnez	a5,80004740 <acquiresleep+0x20>
    80004750:	4785                	li	a5,1
    80004752:	c09c                	sw	a5,0(s1)
    80004754:	ffffd097          	auipc	ra,0xffffd
    80004758:	258080e7          	jalr	600(ra) # 800019ac <myproc>
    8000475c:	591c                	lw	a5,48(a0)
    8000475e:	d49c                	sw	a5,40(s1)
    80004760:	854a                	mv	a0,s2
    80004762:	ffffc097          	auipc	ra,0xffffc
    80004766:	528080e7          	jalr	1320(ra) # 80000c8a <release>
    8000476a:	60e2                	ld	ra,24(sp)
    8000476c:	6442                	ld	s0,16(sp)
    8000476e:	64a2                	ld	s1,8(sp)
    80004770:	6902                	ld	s2,0(sp)
    80004772:	6105                	addi	sp,sp,32
    80004774:	8082                	ret

0000000080004776 <releasesleep>:
    80004776:	1101                	addi	sp,sp,-32
    80004778:	ec06                	sd	ra,24(sp)
    8000477a:	e822                	sd	s0,16(sp)
    8000477c:	e426                	sd	s1,8(sp)
    8000477e:	e04a                	sd	s2,0(sp)
    80004780:	1000                	addi	s0,sp,32
    80004782:	84aa                	mv	s1,a0
    80004784:	00850913          	addi	s2,a0,8
    80004788:	854a                	mv	a0,s2
    8000478a:	ffffc097          	auipc	ra,0xffffc
    8000478e:	44c080e7          	jalr	1100(ra) # 80000bd6 <acquire>
    80004792:	0004a023          	sw	zero,0(s1)
    80004796:	0204a423          	sw	zero,40(s1)
    8000479a:	8526                	mv	a0,s1
    8000479c:	ffffe097          	auipc	ra,0xffffe
    800047a0:	91c080e7          	jalr	-1764(ra) # 800020b8 <wakeup>
    800047a4:	854a                	mv	a0,s2
    800047a6:	ffffc097          	auipc	ra,0xffffc
    800047aa:	4e4080e7          	jalr	1252(ra) # 80000c8a <release>
    800047ae:	60e2                	ld	ra,24(sp)
    800047b0:	6442                	ld	s0,16(sp)
    800047b2:	64a2                	ld	s1,8(sp)
    800047b4:	6902                	ld	s2,0(sp)
    800047b6:	6105                	addi	sp,sp,32
    800047b8:	8082                	ret

00000000800047ba <holdingsleep>:
    800047ba:	7179                	addi	sp,sp,-48
    800047bc:	f406                	sd	ra,40(sp)
    800047be:	f022                	sd	s0,32(sp)
    800047c0:	ec26                	sd	s1,24(sp)
    800047c2:	e84a                	sd	s2,16(sp)
    800047c4:	e44e                	sd	s3,8(sp)
    800047c6:	1800                	addi	s0,sp,48
    800047c8:	84aa                	mv	s1,a0
    800047ca:	00850913          	addi	s2,a0,8
    800047ce:	854a                	mv	a0,s2
    800047d0:	ffffc097          	auipc	ra,0xffffc
    800047d4:	406080e7          	jalr	1030(ra) # 80000bd6 <acquire>
    800047d8:	409c                	lw	a5,0(s1)
    800047da:	ef99                	bnez	a5,800047f8 <holdingsleep+0x3e>
    800047dc:	4481                	li	s1,0
    800047de:	854a                	mv	a0,s2
    800047e0:	ffffc097          	auipc	ra,0xffffc
    800047e4:	4aa080e7          	jalr	1194(ra) # 80000c8a <release>
    800047e8:	8526                	mv	a0,s1
    800047ea:	70a2                	ld	ra,40(sp)
    800047ec:	7402                	ld	s0,32(sp)
    800047ee:	64e2                	ld	s1,24(sp)
    800047f0:	6942                	ld	s2,16(sp)
    800047f2:	69a2                	ld	s3,8(sp)
    800047f4:	6145                	addi	sp,sp,48
    800047f6:	8082                	ret
    800047f8:	0284a983          	lw	s3,40(s1)
    800047fc:	ffffd097          	auipc	ra,0xffffd
    80004800:	1b0080e7          	jalr	432(ra) # 800019ac <myproc>
    80004804:	5904                	lw	s1,48(a0)
    80004806:	413484b3          	sub	s1,s1,s3
    8000480a:	0014b493          	seqz	s1,s1
    8000480e:	bfc1                	j	800047de <holdingsleep+0x24>

0000000080004810 <fileinit>:
    80004810:	1141                	addi	sp,sp,-16
    80004812:	e406                	sd	ra,8(sp)
    80004814:	e022                	sd	s0,0(sp)
    80004816:	0800                	addi	s0,sp,16
    80004818:	00004597          	auipc	a1,0x4
    8000481c:	eb058593          	addi	a1,a1,-336 # 800086c8 <syscalls+0x240>
    80004820:	0001c517          	auipc	a0,0x1c
    80004824:	46850513          	addi	a0,a0,1128 # 80020c88 <ftable>
    80004828:	ffffc097          	auipc	ra,0xffffc
    8000482c:	31e080e7          	jalr	798(ra) # 80000b46 <initlock>
    80004830:	60a2                	ld	ra,8(sp)
    80004832:	6402                	ld	s0,0(sp)
    80004834:	0141                	addi	sp,sp,16
    80004836:	8082                	ret

0000000080004838 <filealloc>:
    80004838:	1101                	addi	sp,sp,-32
    8000483a:	ec06                	sd	ra,24(sp)
    8000483c:	e822                	sd	s0,16(sp)
    8000483e:	e426                	sd	s1,8(sp)
    80004840:	1000                	addi	s0,sp,32
    80004842:	0001c517          	auipc	a0,0x1c
    80004846:	44650513          	addi	a0,a0,1094 # 80020c88 <ftable>
    8000484a:	ffffc097          	auipc	ra,0xffffc
    8000484e:	38c080e7          	jalr	908(ra) # 80000bd6 <acquire>
    80004852:	0001c497          	auipc	s1,0x1c
    80004856:	44e48493          	addi	s1,s1,1102 # 80020ca0 <ftable+0x18>
    8000485a:	0001d717          	auipc	a4,0x1d
    8000485e:	3e670713          	addi	a4,a4,998 # 80021c40 <disk>
    80004862:	40dc                	lw	a5,4(s1)
    80004864:	cf99                	beqz	a5,80004882 <filealloc+0x4a>
    80004866:	02848493          	addi	s1,s1,40
    8000486a:	fee49ce3          	bne	s1,a4,80004862 <filealloc+0x2a>
    8000486e:	0001c517          	auipc	a0,0x1c
    80004872:	41a50513          	addi	a0,a0,1050 # 80020c88 <ftable>
    80004876:	ffffc097          	auipc	ra,0xffffc
    8000487a:	414080e7          	jalr	1044(ra) # 80000c8a <release>
    8000487e:	4481                	li	s1,0
    80004880:	a819                	j	80004896 <filealloc+0x5e>
    80004882:	4785                	li	a5,1
    80004884:	c0dc                	sw	a5,4(s1)
    80004886:	0001c517          	auipc	a0,0x1c
    8000488a:	40250513          	addi	a0,a0,1026 # 80020c88 <ftable>
    8000488e:	ffffc097          	auipc	ra,0xffffc
    80004892:	3fc080e7          	jalr	1020(ra) # 80000c8a <release>
    80004896:	8526                	mv	a0,s1
    80004898:	60e2                	ld	ra,24(sp)
    8000489a:	6442                	ld	s0,16(sp)
    8000489c:	64a2                	ld	s1,8(sp)
    8000489e:	6105                	addi	sp,sp,32
    800048a0:	8082                	ret

00000000800048a2 <filedup>:
    800048a2:	1101                	addi	sp,sp,-32
    800048a4:	ec06                	sd	ra,24(sp)
    800048a6:	e822                	sd	s0,16(sp)
    800048a8:	e426                	sd	s1,8(sp)
    800048aa:	1000                	addi	s0,sp,32
    800048ac:	84aa                	mv	s1,a0
    800048ae:	0001c517          	auipc	a0,0x1c
    800048b2:	3da50513          	addi	a0,a0,986 # 80020c88 <ftable>
    800048b6:	ffffc097          	auipc	ra,0xffffc
    800048ba:	320080e7          	jalr	800(ra) # 80000bd6 <acquire>
    800048be:	40dc                	lw	a5,4(s1)
    800048c0:	02f05263          	blez	a5,800048e4 <filedup+0x42>
    800048c4:	2785                	addiw	a5,a5,1
    800048c6:	c0dc                	sw	a5,4(s1)
    800048c8:	0001c517          	auipc	a0,0x1c
    800048cc:	3c050513          	addi	a0,a0,960 # 80020c88 <ftable>
    800048d0:	ffffc097          	auipc	ra,0xffffc
    800048d4:	3ba080e7          	jalr	954(ra) # 80000c8a <release>
    800048d8:	8526                	mv	a0,s1
    800048da:	60e2                	ld	ra,24(sp)
    800048dc:	6442                	ld	s0,16(sp)
    800048de:	64a2                	ld	s1,8(sp)
    800048e0:	6105                	addi	sp,sp,32
    800048e2:	8082                	ret
    800048e4:	00004517          	auipc	a0,0x4
    800048e8:	dec50513          	addi	a0,a0,-532 # 800086d0 <syscalls+0x248>
    800048ec:	ffffc097          	auipc	ra,0xffffc
    800048f0:	c52080e7          	jalr	-942(ra) # 8000053e <panic>

00000000800048f4 <fileclose>:
    800048f4:	7139                	addi	sp,sp,-64
    800048f6:	fc06                	sd	ra,56(sp)
    800048f8:	f822                	sd	s0,48(sp)
    800048fa:	f426                	sd	s1,40(sp)
    800048fc:	f04a                	sd	s2,32(sp)
    800048fe:	ec4e                	sd	s3,24(sp)
    80004900:	e852                	sd	s4,16(sp)
    80004902:	e456                	sd	s5,8(sp)
    80004904:	0080                	addi	s0,sp,64
    80004906:	84aa                	mv	s1,a0
    80004908:	0001c517          	auipc	a0,0x1c
    8000490c:	38050513          	addi	a0,a0,896 # 80020c88 <ftable>
    80004910:	ffffc097          	auipc	ra,0xffffc
    80004914:	2c6080e7          	jalr	710(ra) # 80000bd6 <acquire>
    80004918:	40dc                	lw	a5,4(s1)
    8000491a:	06f05163          	blez	a5,8000497c <fileclose+0x88>
    8000491e:	37fd                	addiw	a5,a5,-1
    80004920:	0007871b          	sext.w	a4,a5
    80004924:	c0dc                	sw	a5,4(s1)
    80004926:	06e04363          	bgtz	a4,8000498c <fileclose+0x98>
    8000492a:	0004a903          	lw	s2,0(s1)
    8000492e:	0094ca83          	lbu	s5,9(s1)
    80004932:	0104ba03          	ld	s4,16(s1)
    80004936:	0184b983          	ld	s3,24(s1)
    8000493a:	0004a223          	sw	zero,4(s1)
    8000493e:	0004a023          	sw	zero,0(s1)
    80004942:	0001c517          	auipc	a0,0x1c
    80004946:	34650513          	addi	a0,a0,838 # 80020c88 <ftable>
    8000494a:	ffffc097          	auipc	ra,0xffffc
    8000494e:	340080e7          	jalr	832(ra) # 80000c8a <release>
    80004952:	4785                	li	a5,1
    80004954:	04f90d63          	beq	s2,a5,800049ae <fileclose+0xba>
    80004958:	3979                	addiw	s2,s2,-2
    8000495a:	4785                	li	a5,1
    8000495c:	0527e063          	bltu	a5,s2,8000499c <fileclose+0xa8>
    80004960:	00000097          	auipc	ra,0x0
    80004964:	ac8080e7          	jalr	-1336(ra) # 80004428 <begin_op>
    80004968:	854e                	mv	a0,s3
    8000496a:	fffff097          	auipc	ra,0xfffff
    8000496e:	2b6080e7          	jalr	694(ra) # 80003c20 <iput>
    80004972:	00000097          	auipc	ra,0x0
    80004976:	b36080e7          	jalr	-1226(ra) # 800044a8 <end_op>
    8000497a:	a00d                	j	8000499c <fileclose+0xa8>
    8000497c:	00004517          	auipc	a0,0x4
    80004980:	d5c50513          	addi	a0,a0,-676 # 800086d8 <syscalls+0x250>
    80004984:	ffffc097          	auipc	ra,0xffffc
    80004988:	bba080e7          	jalr	-1094(ra) # 8000053e <panic>
    8000498c:	0001c517          	auipc	a0,0x1c
    80004990:	2fc50513          	addi	a0,a0,764 # 80020c88 <ftable>
    80004994:	ffffc097          	auipc	ra,0xffffc
    80004998:	2f6080e7          	jalr	758(ra) # 80000c8a <release>
    8000499c:	70e2                	ld	ra,56(sp)
    8000499e:	7442                	ld	s0,48(sp)
    800049a0:	74a2                	ld	s1,40(sp)
    800049a2:	7902                	ld	s2,32(sp)
    800049a4:	69e2                	ld	s3,24(sp)
    800049a6:	6a42                	ld	s4,16(sp)
    800049a8:	6aa2                	ld	s5,8(sp)
    800049aa:	6121                	addi	sp,sp,64
    800049ac:	8082                	ret
    800049ae:	85d6                	mv	a1,s5
    800049b0:	8552                	mv	a0,s4
    800049b2:	00000097          	auipc	ra,0x0
    800049b6:	34c080e7          	jalr	844(ra) # 80004cfe <pipeclose>
    800049ba:	b7cd                	j	8000499c <fileclose+0xa8>

00000000800049bc <filestat>:
    800049bc:	715d                	addi	sp,sp,-80
    800049be:	e486                	sd	ra,72(sp)
    800049c0:	e0a2                	sd	s0,64(sp)
    800049c2:	fc26                	sd	s1,56(sp)
    800049c4:	f84a                	sd	s2,48(sp)
    800049c6:	f44e                	sd	s3,40(sp)
    800049c8:	0880                	addi	s0,sp,80
    800049ca:	84aa                	mv	s1,a0
    800049cc:	89ae                	mv	s3,a1
    800049ce:	ffffd097          	auipc	ra,0xffffd
    800049d2:	fde080e7          	jalr	-34(ra) # 800019ac <myproc>
    800049d6:	409c                	lw	a5,0(s1)
    800049d8:	37f9                	addiw	a5,a5,-2
    800049da:	4705                	li	a4,1
    800049dc:	04f76763          	bltu	a4,a5,80004a2a <filestat+0x6e>
    800049e0:	892a                	mv	s2,a0
    800049e2:	6c88                	ld	a0,24(s1)
    800049e4:	fffff097          	auipc	ra,0xfffff
    800049e8:	082080e7          	jalr	130(ra) # 80003a66 <ilock>
    800049ec:	fb840593          	addi	a1,s0,-72
    800049f0:	6c88                	ld	a0,24(s1)
    800049f2:	fffff097          	auipc	ra,0xfffff
    800049f6:	2fe080e7          	jalr	766(ra) # 80003cf0 <stati>
    800049fa:	6c88                	ld	a0,24(s1)
    800049fc:	fffff097          	auipc	ra,0xfffff
    80004a00:	12c080e7          	jalr	300(ra) # 80003b28 <iunlock>
    80004a04:	46e1                	li	a3,24
    80004a06:	fb840613          	addi	a2,s0,-72
    80004a0a:	85ce                	mv	a1,s3
    80004a0c:	05093503          	ld	a0,80(s2)
    80004a10:	ffffd097          	auipc	ra,0xffffd
    80004a14:	c58080e7          	jalr	-936(ra) # 80001668 <copyout>
    80004a18:	41f5551b          	sraiw	a0,a0,0x1f
    80004a1c:	60a6                	ld	ra,72(sp)
    80004a1e:	6406                	ld	s0,64(sp)
    80004a20:	74e2                	ld	s1,56(sp)
    80004a22:	7942                	ld	s2,48(sp)
    80004a24:	79a2                	ld	s3,40(sp)
    80004a26:	6161                	addi	sp,sp,80
    80004a28:	8082                	ret
    80004a2a:	557d                	li	a0,-1
    80004a2c:	bfc5                	j	80004a1c <filestat+0x60>

0000000080004a2e <fileread>:
    80004a2e:	7179                	addi	sp,sp,-48
    80004a30:	f406                	sd	ra,40(sp)
    80004a32:	f022                	sd	s0,32(sp)
    80004a34:	ec26                	sd	s1,24(sp)
    80004a36:	e84a                	sd	s2,16(sp)
    80004a38:	e44e                	sd	s3,8(sp)
    80004a3a:	1800                	addi	s0,sp,48
    80004a3c:	00854783          	lbu	a5,8(a0)
    80004a40:	c3d5                	beqz	a5,80004ae4 <fileread+0xb6>
    80004a42:	84aa                	mv	s1,a0
    80004a44:	89ae                	mv	s3,a1
    80004a46:	8932                	mv	s2,a2
    80004a48:	411c                	lw	a5,0(a0)
    80004a4a:	4705                	li	a4,1
    80004a4c:	04e78963          	beq	a5,a4,80004a9e <fileread+0x70>
    80004a50:	470d                	li	a4,3
    80004a52:	04e78d63          	beq	a5,a4,80004aac <fileread+0x7e>
    80004a56:	4709                	li	a4,2
    80004a58:	06e79e63          	bne	a5,a4,80004ad4 <fileread+0xa6>
    80004a5c:	6d08                	ld	a0,24(a0)
    80004a5e:	fffff097          	auipc	ra,0xfffff
    80004a62:	008080e7          	jalr	8(ra) # 80003a66 <ilock>
    80004a66:	874a                	mv	a4,s2
    80004a68:	5094                	lw	a3,32(s1)
    80004a6a:	864e                	mv	a2,s3
    80004a6c:	4585                	li	a1,1
    80004a6e:	6c88                	ld	a0,24(s1)
    80004a70:	fffff097          	auipc	ra,0xfffff
    80004a74:	2aa080e7          	jalr	682(ra) # 80003d1a <readi>
    80004a78:	892a                	mv	s2,a0
    80004a7a:	00a05563          	blez	a0,80004a84 <fileread+0x56>
    80004a7e:	509c                	lw	a5,32(s1)
    80004a80:	9fa9                	addw	a5,a5,a0
    80004a82:	d09c                	sw	a5,32(s1)
    80004a84:	6c88                	ld	a0,24(s1)
    80004a86:	fffff097          	auipc	ra,0xfffff
    80004a8a:	0a2080e7          	jalr	162(ra) # 80003b28 <iunlock>
    80004a8e:	854a                	mv	a0,s2
    80004a90:	70a2                	ld	ra,40(sp)
    80004a92:	7402                	ld	s0,32(sp)
    80004a94:	64e2                	ld	s1,24(sp)
    80004a96:	6942                	ld	s2,16(sp)
    80004a98:	69a2                	ld	s3,8(sp)
    80004a9a:	6145                	addi	sp,sp,48
    80004a9c:	8082                	ret
    80004a9e:	6908                	ld	a0,16(a0)
    80004aa0:	00000097          	auipc	ra,0x0
    80004aa4:	3c6080e7          	jalr	966(ra) # 80004e66 <piperead>
    80004aa8:	892a                	mv	s2,a0
    80004aaa:	b7d5                	j	80004a8e <fileread+0x60>
    80004aac:	02451783          	lh	a5,36(a0)
    80004ab0:	03079693          	slli	a3,a5,0x30
    80004ab4:	92c1                	srli	a3,a3,0x30
    80004ab6:	4725                	li	a4,9
    80004ab8:	02d76863          	bltu	a4,a3,80004ae8 <fileread+0xba>
    80004abc:	0792                	slli	a5,a5,0x4
    80004abe:	0001c717          	auipc	a4,0x1c
    80004ac2:	12a70713          	addi	a4,a4,298 # 80020be8 <devsw>
    80004ac6:	97ba                	add	a5,a5,a4
    80004ac8:	639c                	ld	a5,0(a5)
    80004aca:	c38d                	beqz	a5,80004aec <fileread+0xbe>
    80004acc:	4505                	li	a0,1
    80004ace:	9782                	jalr	a5
    80004ad0:	892a                	mv	s2,a0
    80004ad2:	bf75                	j	80004a8e <fileread+0x60>
    80004ad4:	00004517          	auipc	a0,0x4
    80004ad8:	c1450513          	addi	a0,a0,-1004 # 800086e8 <syscalls+0x260>
    80004adc:	ffffc097          	auipc	ra,0xffffc
    80004ae0:	a62080e7          	jalr	-1438(ra) # 8000053e <panic>
    80004ae4:	597d                	li	s2,-1
    80004ae6:	b765                	j	80004a8e <fileread+0x60>
    80004ae8:	597d                	li	s2,-1
    80004aea:	b755                	j	80004a8e <fileread+0x60>
    80004aec:	597d                	li	s2,-1
    80004aee:	b745                	j	80004a8e <fileread+0x60>

0000000080004af0 <filewrite>:
    80004af0:	715d                	addi	sp,sp,-80
    80004af2:	e486                	sd	ra,72(sp)
    80004af4:	e0a2                	sd	s0,64(sp)
    80004af6:	fc26                	sd	s1,56(sp)
    80004af8:	f84a                	sd	s2,48(sp)
    80004afa:	f44e                	sd	s3,40(sp)
    80004afc:	f052                	sd	s4,32(sp)
    80004afe:	ec56                	sd	s5,24(sp)
    80004b00:	e85a                	sd	s6,16(sp)
    80004b02:	e45e                	sd	s7,8(sp)
    80004b04:	e062                	sd	s8,0(sp)
    80004b06:	0880                	addi	s0,sp,80
    80004b08:	00954783          	lbu	a5,9(a0)
    80004b0c:	10078663          	beqz	a5,80004c18 <filewrite+0x128>
    80004b10:	892a                	mv	s2,a0
    80004b12:	8aae                	mv	s5,a1
    80004b14:	8a32                	mv	s4,a2
    80004b16:	411c                	lw	a5,0(a0)
    80004b18:	4705                	li	a4,1
    80004b1a:	02e78263          	beq	a5,a4,80004b3e <filewrite+0x4e>
    80004b1e:	470d                	li	a4,3
    80004b20:	02e78663          	beq	a5,a4,80004b4c <filewrite+0x5c>
    80004b24:	4709                	li	a4,2
    80004b26:	0ee79163          	bne	a5,a4,80004c08 <filewrite+0x118>
    80004b2a:	0ac05d63          	blez	a2,80004be4 <filewrite+0xf4>
    80004b2e:	4981                	li	s3,0
    80004b30:	6b05                	lui	s6,0x1
    80004b32:	c00b0b13          	addi	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    80004b36:	6b85                	lui	s7,0x1
    80004b38:	c00b8b9b          	addiw	s7,s7,-1024
    80004b3c:	a861                	j	80004bd4 <filewrite+0xe4>
    80004b3e:	6908                	ld	a0,16(a0)
    80004b40:	00000097          	auipc	ra,0x0
    80004b44:	22e080e7          	jalr	558(ra) # 80004d6e <pipewrite>
    80004b48:	8a2a                	mv	s4,a0
    80004b4a:	a045                	j	80004bea <filewrite+0xfa>
    80004b4c:	02451783          	lh	a5,36(a0)
    80004b50:	03079693          	slli	a3,a5,0x30
    80004b54:	92c1                	srli	a3,a3,0x30
    80004b56:	4725                	li	a4,9
    80004b58:	0cd76263          	bltu	a4,a3,80004c1c <filewrite+0x12c>
    80004b5c:	0792                	slli	a5,a5,0x4
    80004b5e:	0001c717          	auipc	a4,0x1c
    80004b62:	08a70713          	addi	a4,a4,138 # 80020be8 <devsw>
    80004b66:	97ba                	add	a5,a5,a4
    80004b68:	679c                	ld	a5,8(a5)
    80004b6a:	cbdd                	beqz	a5,80004c20 <filewrite+0x130>
    80004b6c:	4505                	li	a0,1
    80004b6e:	9782                	jalr	a5
    80004b70:	8a2a                	mv	s4,a0
    80004b72:	a8a5                	j	80004bea <filewrite+0xfa>
    80004b74:	00048c1b          	sext.w	s8,s1
    80004b78:	00000097          	auipc	ra,0x0
    80004b7c:	8b0080e7          	jalr	-1872(ra) # 80004428 <begin_op>
    80004b80:	01893503          	ld	a0,24(s2)
    80004b84:	fffff097          	auipc	ra,0xfffff
    80004b88:	ee2080e7          	jalr	-286(ra) # 80003a66 <ilock>
    80004b8c:	8762                	mv	a4,s8
    80004b8e:	02092683          	lw	a3,32(s2)
    80004b92:	01598633          	add	a2,s3,s5
    80004b96:	4585                	li	a1,1
    80004b98:	01893503          	ld	a0,24(s2)
    80004b9c:	fffff097          	auipc	ra,0xfffff
    80004ba0:	276080e7          	jalr	630(ra) # 80003e12 <writei>
    80004ba4:	84aa                	mv	s1,a0
    80004ba6:	00a05763          	blez	a0,80004bb4 <filewrite+0xc4>
    80004baa:	02092783          	lw	a5,32(s2)
    80004bae:	9fa9                	addw	a5,a5,a0
    80004bb0:	02f92023          	sw	a5,32(s2)
    80004bb4:	01893503          	ld	a0,24(s2)
    80004bb8:	fffff097          	auipc	ra,0xfffff
    80004bbc:	f70080e7          	jalr	-144(ra) # 80003b28 <iunlock>
    80004bc0:	00000097          	auipc	ra,0x0
    80004bc4:	8e8080e7          	jalr	-1816(ra) # 800044a8 <end_op>
    80004bc8:	009c1f63          	bne	s8,s1,80004be6 <filewrite+0xf6>
    80004bcc:	013489bb          	addw	s3,s1,s3
    80004bd0:	0149db63          	bge	s3,s4,80004be6 <filewrite+0xf6>
    80004bd4:	413a07bb          	subw	a5,s4,s3
    80004bd8:	84be                	mv	s1,a5
    80004bda:	2781                	sext.w	a5,a5
    80004bdc:	f8fb5ce3          	bge	s6,a5,80004b74 <filewrite+0x84>
    80004be0:	84de                	mv	s1,s7
    80004be2:	bf49                	j	80004b74 <filewrite+0x84>
    80004be4:	4981                	li	s3,0
    80004be6:	013a1f63          	bne	s4,s3,80004c04 <filewrite+0x114>
    80004bea:	8552                	mv	a0,s4
    80004bec:	60a6                	ld	ra,72(sp)
    80004bee:	6406                	ld	s0,64(sp)
    80004bf0:	74e2                	ld	s1,56(sp)
    80004bf2:	7942                	ld	s2,48(sp)
    80004bf4:	79a2                	ld	s3,40(sp)
    80004bf6:	7a02                	ld	s4,32(sp)
    80004bf8:	6ae2                	ld	s5,24(sp)
    80004bfa:	6b42                	ld	s6,16(sp)
    80004bfc:	6ba2                	ld	s7,8(sp)
    80004bfe:	6c02                	ld	s8,0(sp)
    80004c00:	6161                	addi	sp,sp,80
    80004c02:	8082                	ret
    80004c04:	5a7d                	li	s4,-1
    80004c06:	b7d5                	j	80004bea <filewrite+0xfa>
    80004c08:	00004517          	auipc	a0,0x4
    80004c0c:	af050513          	addi	a0,a0,-1296 # 800086f8 <syscalls+0x270>
    80004c10:	ffffc097          	auipc	ra,0xffffc
    80004c14:	92e080e7          	jalr	-1746(ra) # 8000053e <panic>
    80004c18:	5a7d                	li	s4,-1
    80004c1a:	bfc1                	j	80004bea <filewrite+0xfa>
    80004c1c:	5a7d                	li	s4,-1
    80004c1e:	b7f1                	j	80004bea <filewrite+0xfa>
    80004c20:	5a7d                	li	s4,-1
    80004c22:	b7e1                	j	80004bea <filewrite+0xfa>

0000000080004c24 <pipealloc>:
    80004c24:	7179                	addi	sp,sp,-48
    80004c26:	f406                	sd	ra,40(sp)
    80004c28:	f022                	sd	s0,32(sp)
    80004c2a:	ec26                	sd	s1,24(sp)
    80004c2c:	e84a                	sd	s2,16(sp)
    80004c2e:	e44e                	sd	s3,8(sp)
    80004c30:	e052                	sd	s4,0(sp)
    80004c32:	1800                	addi	s0,sp,48
    80004c34:	84aa                	mv	s1,a0
    80004c36:	8a2e                	mv	s4,a1
    80004c38:	0005b023          	sd	zero,0(a1)
    80004c3c:	00053023          	sd	zero,0(a0)
    80004c40:	00000097          	auipc	ra,0x0
    80004c44:	bf8080e7          	jalr	-1032(ra) # 80004838 <filealloc>
    80004c48:	e088                	sd	a0,0(s1)
    80004c4a:	c551                	beqz	a0,80004cd6 <pipealloc+0xb2>
    80004c4c:	00000097          	auipc	ra,0x0
    80004c50:	bec080e7          	jalr	-1044(ra) # 80004838 <filealloc>
    80004c54:	00aa3023          	sd	a0,0(s4)
    80004c58:	c92d                	beqz	a0,80004cca <pipealloc+0xa6>
    80004c5a:	ffffc097          	auipc	ra,0xffffc
    80004c5e:	e8c080e7          	jalr	-372(ra) # 80000ae6 <kalloc>
    80004c62:	892a                	mv	s2,a0
    80004c64:	c125                	beqz	a0,80004cc4 <pipealloc+0xa0>
    80004c66:	4985                	li	s3,1
    80004c68:	23352023          	sw	s3,544(a0)
    80004c6c:	23352223          	sw	s3,548(a0)
    80004c70:	20052e23          	sw	zero,540(a0)
    80004c74:	20052c23          	sw	zero,536(a0)
    80004c78:	00004597          	auipc	a1,0x4
    80004c7c:	a9058593          	addi	a1,a1,-1392 # 80008708 <syscalls+0x280>
    80004c80:	ffffc097          	auipc	ra,0xffffc
    80004c84:	ec6080e7          	jalr	-314(ra) # 80000b46 <initlock>
    80004c88:	609c                	ld	a5,0(s1)
    80004c8a:	0137a023          	sw	s3,0(a5)
    80004c8e:	609c                	ld	a5,0(s1)
    80004c90:	01378423          	sb	s3,8(a5)
    80004c94:	609c                	ld	a5,0(s1)
    80004c96:	000784a3          	sb	zero,9(a5)
    80004c9a:	609c                	ld	a5,0(s1)
    80004c9c:	0127b823          	sd	s2,16(a5)
    80004ca0:	000a3783          	ld	a5,0(s4)
    80004ca4:	0137a023          	sw	s3,0(a5)
    80004ca8:	000a3783          	ld	a5,0(s4)
    80004cac:	00078423          	sb	zero,8(a5)
    80004cb0:	000a3783          	ld	a5,0(s4)
    80004cb4:	013784a3          	sb	s3,9(a5)
    80004cb8:	000a3783          	ld	a5,0(s4)
    80004cbc:	0127b823          	sd	s2,16(a5)
    80004cc0:	4501                	li	a0,0
    80004cc2:	a025                	j	80004cea <pipealloc+0xc6>
    80004cc4:	6088                	ld	a0,0(s1)
    80004cc6:	e501                	bnez	a0,80004cce <pipealloc+0xaa>
    80004cc8:	a039                	j	80004cd6 <pipealloc+0xb2>
    80004cca:	6088                	ld	a0,0(s1)
    80004ccc:	c51d                	beqz	a0,80004cfa <pipealloc+0xd6>
    80004cce:	00000097          	auipc	ra,0x0
    80004cd2:	c26080e7          	jalr	-986(ra) # 800048f4 <fileclose>
    80004cd6:	000a3783          	ld	a5,0(s4)
    80004cda:	557d                	li	a0,-1
    80004cdc:	c799                	beqz	a5,80004cea <pipealloc+0xc6>
    80004cde:	853e                	mv	a0,a5
    80004ce0:	00000097          	auipc	ra,0x0
    80004ce4:	c14080e7          	jalr	-1004(ra) # 800048f4 <fileclose>
    80004ce8:	557d                	li	a0,-1
    80004cea:	70a2                	ld	ra,40(sp)
    80004cec:	7402                	ld	s0,32(sp)
    80004cee:	64e2                	ld	s1,24(sp)
    80004cf0:	6942                	ld	s2,16(sp)
    80004cf2:	69a2                	ld	s3,8(sp)
    80004cf4:	6a02                	ld	s4,0(sp)
    80004cf6:	6145                	addi	sp,sp,48
    80004cf8:	8082                	ret
    80004cfa:	557d                	li	a0,-1
    80004cfc:	b7fd                	j	80004cea <pipealloc+0xc6>

0000000080004cfe <pipeclose>:
    80004cfe:	1101                	addi	sp,sp,-32
    80004d00:	ec06                	sd	ra,24(sp)
    80004d02:	e822                	sd	s0,16(sp)
    80004d04:	e426                	sd	s1,8(sp)
    80004d06:	e04a                	sd	s2,0(sp)
    80004d08:	1000                	addi	s0,sp,32
    80004d0a:	84aa                	mv	s1,a0
    80004d0c:	892e                	mv	s2,a1
    80004d0e:	ffffc097          	auipc	ra,0xffffc
    80004d12:	ec8080e7          	jalr	-312(ra) # 80000bd6 <acquire>
    80004d16:	02090d63          	beqz	s2,80004d50 <pipeclose+0x52>
    80004d1a:	2204a223          	sw	zero,548(s1)
    80004d1e:	21848513          	addi	a0,s1,536
    80004d22:	ffffd097          	auipc	ra,0xffffd
    80004d26:	396080e7          	jalr	918(ra) # 800020b8 <wakeup>
    80004d2a:	2204b783          	ld	a5,544(s1)
    80004d2e:	eb95                	bnez	a5,80004d62 <pipeclose+0x64>
    80004d30:	8526                	mv	a0,s1
    80004d32:	ffffc097          	auipc	ra,0xffffc
    80004d36:	f58080e7          	jalr	-168(ra) # 80000c8a <release>
    80004d3a:	8526                	mv	a0,s1
    80004d3c:	ffffc097          	auipc	ra,0xffffc
    80004d40:	cae080e7          	jalr	-850(ra) # 800009ea <kfree>
    80004d44:	60e2                	ld	ra,24(sp)
    80004d46:	6442                	ld	s0,16(sp)
    80004d48:	64a2                	ld	s1,8(sp)
    80004d4a:	6902                	ld	s2,0(sp)
    80004d4c:	6105                	addi	sp,sp,32
    80004d4e:	8082                	ret
    80004d50:	2204a023          	sw	zero,544(s1)
    80004d54:	21c48513          	addi	a0,s1,540
    80004d58:	ffffd097          	auipc	ra,0xffffd
    80004d5c:	360080e7          	jalr	864(ra) # 800020b8 <wakeup>
    80004d60:	b7e9                	j	80004d2a <pipeclose+0x2c>
    80004d62:	8526                	mv	a0,s1
    80004d64:	ffffc097          	auipc	ra,0xffffc
    80004d68:	f26080e7          	jalr	-218(ra) # 80000c8a <release>
    80004d6c:	bfe1                	j	80004d44 <pipeclose+0x46>

0000000080004d6e <pipewrite>:
    80004d6e:	711d                	addi	sp,sp,-96
    80004d70:	ec86                	sd	ra,88(sp)
    80004d72:	e8a2                	sd	s0,80(sp)
    80004d74:	e4a6                	sd	s1,72(sp)
    80004d76:	e0ca                	sd	s2,64(sp)
    80004d78:	fc4e                	sd	s3,56(sp)
    80004d7a:	f852                	sd	s4,48(sp)
    80004d7c:	f456                	sd	s5,40(sp)
    80004d7e:	f05a                	sd	s6,32(sp)
    80004d80:	ec5e                	sd	s7,24(sp)
    80004d82:	e862                	sd	s8,16(sp)
    80004d84:	1080                	addi	s0,sp,96
    80004d86:	84aa                	mv	s1,a0
    80004d88:	8aae                	mv	s5,a1
    80004d8a:	8a32                	mv	s4,a2
    80004d8c:	ffffd097          	auipc	ra,0xffffd
    80004d90:	c20080e7          	jalr	-992(ra) # 800019ac <myproc>
    80004d94:	89aa                	mv	s3,a0
    80004d96:	8526                	mv	a0,s1
    80004d98:	ffffc097          	auipc	ra,0xffffc
    80004d9c:	e3e080e7          	jalr	-450(ra) # 80000bd6 <acquire>
    80004da0:	0b405663          	blez	s4,80004e4c <pipewrite+0xde>
    80004da4:	4901                	li	s2,0
    80004da6:	5b7d                	li	s6,-1
    80004da8:	21848c13          	addi	s8,s1,536
    80004dac:	21c48b93          	addi	s7,s1,540
    80004db0:	a089                	j	80004df2 <pipewrite+0x84>
    80004db2:	8526                	mv	a0,s1
    80004db4:	ffffc097          	auipc	ra,0xffffc
    80004db8:	ed6080e7          	jalr	-298(ra) # 80000c8a <release>
    80004dbc:	597d                	li	s2,-1
    80004dbe:	854a                	mv	a0,s2
    80004dc0:	60e6                	ld	ra,88(sp)
    80004dc2:	6446                	ld	s0,80(sp)
    80004dc4:	64a6                	ld	s1,72(sp)
    80004dc6:	6906                	ld	s2,64(sp)
    80004dc8:	79e2                	ld	s3,56(sp)
    80004dca:	7a42                	ld	s4,48(sp)
    80004dcc:	7aa2                	ld	s5,40(sp)
    80004dce:	7b02                	ld	s6,32(sp)
    80004dd0:	6be2                	ld	s7,24(sp)
    80004dd2:	6c42                	ld	s8,16(sp)
    80004dd4:	6125                	addi	sp,sp,96
    80004dd6:	8082                	ret
    80004dd8:	8562                	mv	a0,s8
    80004dda:	ffffd097          	auipc	ra,0xffffd
    80004dde:	2de080e7          	jalr	734(ra) # 800020b8 <wakeup>
    80004de2:	85a6                	mv	a1,s1
    80004de4:	855e                	mv	a0,s7
    80004de6:	ffffd097          	auipc	ra,0xffffd
    80004dea:	26e080e7          	jalr	622(ra) # 80002054 <sleep>
    80004dee:	07495063          	bge	s2,s4,80004e4e <pipewrite+0xe0>
    80004df2:	2204a783          	lw	a5,544(s1)
    80004df6:	dfd5                	beqz	a5,80004db2 <pipewrite+0x44>
    80004df8:	854e                	mv	a0,s3
    80004dfa:	ffffe097          	auipc	ra,0xffffe
    80004dfe:	912080e7          	jalr	-1774(ra) # 8000270c <killed>
    80004e02:	f945                	bnez	a0,80004db2 <pipewrite+0x44>
    80004e04:	2184a783          	lw	a5,536(s1)
    80004e08:	21c4a703          	lw	a4,540(s1)
    80004e0c:	2007879b          	addiw	a5,a5,512
    80004e10:	fcf704e3          	beq	a4,a5,80004dd8 <pipewrite+0x6a>
    80004e14:	4685                	li	a3,1
    80004e16:	01590633          	add	a2,s2,s5
    80004e1a:	faf40593          	addi	a1,s0,-81
    80004e1e:	0509b503          	ld	a0,80(s3)
    80004e22:	ffffd097          	auipc	ra,0xffffd
    80004e26:	8d2080e7          	jalr	-1838(ra) # 800016f4 <copyin>
    80004e2a:	03650263          	beq	a0,s6,80004e4e <pipewrite+0xe0>
    80004e2e:	21c4a783          	lw	a5,540(s1)
    80004e32:	0017871b          	addiw	a4,a5,1
    80004e36:	20e4ae23          	sw	a4,540(s1)
    80004e3a:	1ff7f793          	andi	a5,a5,511
    80004e3e:	97a6                	add	a5,a5,s1
    80004e40:	faf44703          	lbu	a4,-81(s0)
    80004e44:	00e78c23          	sb	a4,24(a5)
    80004e48:	2905                	addiw	s2,s2,1
    80004e4a:	b755                	j	80004dee <pipewrite+0x80>
    80004e4c:	4901                	li	s2,0
    80004e4e:	21848513          	addi	a0,s1,536
    80004e52:	ffffd097          	auipc	ra,0xffffd
    80004e56:	266080e7          	jalr	614(ra) # 800020b8 <wakeup>
    80004e5a:	8526                	mv	a0,s1
    80004e5c:	ffffc097          	auipc	ra,0xffffc
    80004e60:	e2e080e7          	jalr	-466(ra) # 80000c8a <release>
    80004e64:	bfa9                	j	80004dbe <pipewrite+0x50>

0000000080004e66 <piperead>:
    80004e66:	715d                	addi	sp,sp,-80
    80004e68:	e486                	sd	ra,72(sp)
    80004e6a:	e0a2                	sd	s0,64(sp)
    80004e6c:	fc26                	sd	s1,56(sp)
    80004e6e:	f84a                	sd	s2,48(sp)
    80004e70:	f44e                	sd	s3,40(sp)
    80004e72:	f052                	sd	s4,32(sp)
    80004e74:	ec56                	sd	s5,24(sp)
    80004e76:	e85a                	sd	s6,16(sp)
    80004e78:	0880                	addi	s0,sp,80
    80004e7a:	84aa                	mv	s1,a0
    80004e7c:	892e                	mv	s2,a1
    80004e7e:	8ab2                	mv	s5,a2
    80004e80:	ffffd097          	auipc	ra,0xffffd
    80004e84:	b2c080e7          	jalr	-1236(ra) # 800019ac <myproc>
    80004e88:	8a2a                	mv	s4,a0
    80004e8a:	8526                	mv	a0,s1
    80004e8c:	ffffc097          	auipc	ra,0xffffc
    80004e90:	d4a080e7          	jalr	-694(ra) # 80000bd6 <acquire>
    80004e94:	2184a703          	lw	a4,536(s1)
    80004e98:	21c4a783          	lw	a5,540(s1)
    80004e9c:	21848993          	addi	s3,s1,536
    80004ea0:	02f71763          	bne	a4,a5,80004ece <piperead+0x68>
    80004ea4:	2244a783          	lw	a5,548(s1)
    80004ea8:	c39d                	beqz	a5,80004ece <piperead+0x68>
    80004eaa:	8552                	mv	a0,s4
    80004eac:	ffffe097          	auipc	ra,0xffffe
    80004eb0:	860080e7          	jalr	-1952(ra) # 8000270c <killed>
    80004eb4:	e941                	bnez	a0,80004f44 <piperead+0xde>
    80004eb6:	85a6                	mv	a1,s1
    80004eb8:	854e                	mv	a0,s3
    80004eba:	ffffd097          	auipc	ra,0xffffd
    80004ebe:	19a080e7          	jalr	410(ra) # 80002054 <sleep>
    80004ec2:	2184a703          	lw	a4,536(s1)
    80004ec6:	21c4a783          	lw	a5,540(s1)
    80004eca:	fcf70de3          	beq	a4,a5,80004ea4 <piperead+0x3e>
    80004ece:	4981                	li	s3,0
    80004ed0:	5b7d                	li	s6,-1
    80004ed2:	05505363          	blez	s5,80004f18 <piperead+0xb2>
    80004ed6:	2184a783          	lw	a5,536(s1)
    80004eda:	21c4a703          	lw	a4,540(s1)
    80004ede:	02f70d63          	beq	a4,a5,80004f18 <piperead+0xb2>
    80004ee2:	0017871b          	addiw	a4,a5,1
    80004ee6:	20e4ac23          	sw	a4,536(s1)
    80004eea:	1ff7f793          	andi	a5,a5,511
    80004eee:	97a6                	add	a5,a5,s1
    80004ef0:	0187c783          	lbu	a5,24(a5)
    80004ef4:	faf40fa3          	sb	a5,-65(s0)
    80004ef8:	4685                	li	a3,1
    80004efa:	fbf40613          	addi	a2,s0,-65
    80004efe:	85ca                	mv	a1,s2
    80004f00:	050a3503          	ld	a0,80(s4)
    80004f04:	ffffc097          	auipc	ra,0xffffc
    80004f08:	764080e7          	jalr	1892(ra) # 80001668 <copyout>
    80004f0c:	01650663          	beq	a0,s6,80004f18 <piperead+0xb2>
    80004f10:	2985                	addiw	s3,s3,1
    80004f12:	0905                	addi	s2,s2,1
    80004f14:	fd3a91e3          	bne	s5,s3,80004ed6 <piperead+0x70>
    80004f18:	21c48513          	addi	a0,s1,540
    80004f1c:	ffffd097          	auipc	ra,0xffffd
    80004f20:	19c080e7          	jalr	412(ra) # 800020b8 <wakeup>
    80004f24:	8526                	mv	a0,s1
    80004f26:	ffffc097          	auipc	ra,0xffffc
    80004f2a:	d64080e7          	jalr	-668(ra) # 80000c8a <release>
    80004f2e:	854e                	mv	a0,s3
    80004f30:	60a6                	ld	ra,72(sp)
    80004f32:	6406                	ld	s0,64(sp)
    80004f34:	74e2                	ld	s1,56(sp)
    80004f36:	7942                	ld	s2,48(sp)
    80004f38:	79a2                	ld	s3,40(sp)
    80004f3a:	7a02                	ld	s4,32(sp)
    80004f3c:	6ae2                	ld	s5,24(sp)
    80004f3e:	6b42                	ld	s6,16(sp)
    80004f40:	6161                	addi	sp,sp,80
    80004f42:	8082                	ret
    80004f44:	8526                	mv	a0,s1
    80004f46:	ffffc097          	auipc	ra,0xffffc
    80004f4a:	d44080e7          	jalr	-700(ra) # 80000c8a <release>
    80004f4e:	59fd                	li	s3,-1
    80004f50:	bff9                	j	80004f2e <piperead+0xc8>

0000000080004f52 <flags2perm>:
    80004f52:	1141                	addi	sp,sp,-16
    80004f54:	e422                	sd	s0,8(sp)
    80004f56:	0800                	addi	s0,sp,16
    80004f58:	87aa                	mv	a5,a0
    80004f5a:	8905                	andi	a0,a0,1
    80004f5c:	c111                	beqz	a0,80004f60 <flags2perm+0xe>
    80004f5e:	4521                	li	a0,8
    80004f60:	8b89                	andi	a5,a5,2
    80004f62:	c399                	beqz	a5,80004f68 <flags2perm+0x16>
    80004f64:	00456513          	ori	a0,a0,4
    80004f68:	6422                	ld	s0,8(sp)
    80004f6a:	0141                	addi	sp,sp,16
    80004f6c:	8082                	ret

0000000080004f6e <exec>:
    80004f6e:	de010113          	addi	sp,sp,-544
    80004f72:	20113c23          	sd	ra,536(sp)
    80004f76:	20813823          	sd	s0,528(sp)
    80004f7a:	20913423          	sd	s1,520(sp)
    80004f7e:	21213023          	sd	s2,512(sp)
    80004f82:	ffce                	sd	s3,504(sp)
    80004f84:	fbd2                	sd	s4,496(sp)
    80004f86:	f7d6                	sd	s5,488(sp)
    80004f88:	f3da                	sd	s6,480(sp)
    80004f8a:	efde                	sd	s7,472(sp)
    80004f8c:	ebe2                	sd	s8,464(sp)
    80004f8e:	e7e6                	sd	s9,456(sp)
    80004f90:	e3ea                	sd	s10,448(sp)
    80004f92:	ff6e                	sd	s11,440(sp)
    80004f94:	1400                	addi	s0,sp,544
    80004f96:	892a                	mv	s2,a0
    80004f98:	dea43423          	sd	a0,-536(s0)
    80004f9c:	deb43823          	sd	a1,-528(s0)
    80004fa0:	ffffd097          	auipc	ra,0xffffd
    80004fa4:	a0c080e7          	jalr	-1524(ra) # 800019ac <myproc>
    80004fa8:	84aa                	mv	s1,a0
    80004faa:	fffff097          	auipc	ra,0xfffff
    80004fae:	47e080e7          	jalr	1150(ra) # 80004428 <begin_op>
    80004fb2:	854a                	mv	a0,s2
    80004fb4:	fffff097          	auipc	ra,0xfffff
    80004fb8:	258080e7          	jalr	600(ra) # 8000420c <namei>
    80004fbc:	c93d                	beqz	a0,80005032 <exec+0xc4>
    80004fbe:	8aaa                	mv	s5,a0
    80004fc0:	fffff097          	auipc	ra,0xfffff
    80004fc4:	aa6080e7          	jalr	-1370(ra) # 80003a66 <ilock>
    80004fc8:	04000713          	li	a4,64
    80004fcc:	4681                	li	a3,0
    80004fce:	e5040613          	addi	a2,s0,-432
    80004fd2:	4581                	li	a1,0
    80004fd4:	8556                	mv	a0,s5
    80004fd6:	fffff097          	auipc	ra,0xfffff
    80004fda:	d44080e7          	jalr	-700(ra) # 80003d1a <readi>
    80004fde:	04000793          	li	a5,64
    80004fe2:	00f51a63          	bne	a0,a5,80004ff6 <exec+0x88>
    80004fe6:	e5042703          	lw	a4,-432(s0)
    80004fea:	464c47b7          	lui	a5,0x464c4
    80004fee:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80004ff2:	04f70663          	beq	a4,a5,8000503e <exec+0xd0>
    80004ff6:	8556                	mv	a0,s5
    80004ff8:	fffff097          	auipc	ra,0xfffff
    80004ffc:	cd0080e7          	jalr	-816(ra) # 80003cc8 <iunlockput>
    80005000:	fffff097          	auipc	ra,0xfffff
    80005004:	4a8080e7          	jalr	1192(ra) # 800044a8 <end_op>
    80005008:	557d                	li	a0,-1
    8000500a:	21813083          	ld	ra,536(sp)
    8000500e:	21013403          	ld	s0,528(sp)
    80005012:	20813483          	ld	s1,520(sp)
    80005016:	20013903          	ld	s2,512(sp)
    8000501a:	79fe                	ld	s3,504(sp)
    8000501c:	7a5e                	ld	s4,496(sp)
    8000501e:	7abe                	ld	s5,488(sp)
    80005020:	7b1e                	ld	s6,480(sp)
    80005022:	6bfe                	ld	s7,472(sp)
    80005024:	6c5e                	ld	s8,464(sp)
    80005026:	6cbe                	ld	s9,456(sp)
    80005028:	6d1e                	ld	s10,448(sp)
    8000502a:	7dfa                	ld	s11,440(sp)
    8000502c:	22010113          	addi	sp,sp,544
    80005030:	8082                	ret
    80005032:	fffff097          	auipc	ra,0xfffff
    80005036:	476080e7          	jalr	1142(ra) # 800044a8 <end_op>
    8000503a:	557d                	li	a0,-1
    8000503c:	b7f9                	j	8000500a <exec+0x9c>
    8000503e:	8526                	mv	a0,s1
    80005040:	ffffd097          	auipc	ra,0xffffd
    80005044:	a30080e7          	jalr	-1488(ra) # 80001a70 <proc_pigtable>
    80005048:	8b2a                	mv	s6,a0
    8000504a:	d555                	beqz	a0,80004ff6 <exec+0x88>
    8000504c:	e7042783          	lw	a5,-400(s0)
    80005050:	e8845703          	lhu	a4,-376(s0)
    80005054:	c735                	beqz	a4,800050c0 <exec+0x152>
    80005056:	4901                	li	s2,0
    80005058:	e0043423          	sd	zero,-504(s0)
    8000505c:	6a05                	lui	s4,0x1
    8000505e:	fffa0713          	addi	a4,s4,-1 # fff <_entry-0x7ffff001>
    80005062:	dee43023          	sd	a4,-544(s0)
    80005066:	6d85                	lui	s11,0x1
    80005068:	7d7d                	lui	s10,0xfffff
    8000506a:	a481                	j	800052aa <exec+0x33c>
    8000506c:	00003517          	auipc	a0,0x3
    80005070:	6a450513          	addi	a0,a0,1700 # 80008710 <syscalls+0x288>
    80005074:	ffffb097          	auipc	ra,0xffffb
    80005078:	4ca080e7          	jalr	1226(ra) # 8000053e <panic>
    8000507c:	874a                	mv	a4,s2
    8000507e:	009c86bb          	addw	a3,s9,s1
    80005082:	4581                	li	a1,0
    80005084:	8556                	mv	a0,s5
    80005086:	fffff097          	auipc	ra,0xfffff
    8000508a:	c94080e7          	jalr	-876(ra) # 80003d1a <readi>
    8000508e:	2501                	sext.w	a0,a0
    80005090:	1aa91a63          	bne	s2,a0,80005244 <exec+0x2d6>
    80005094:	009d84bb          	addw	s1,s11,s1
    80005098:	013d09bb          	addw	s3,s10,s3
    8000509c:	1f74f763          	bgeu	s1,s7,8000528a <exec+0x31c>
    800050a0:	02049593          	slli	a1,s1,0x20
    800050a4:	9181                	srli	a1,a1,0x20
    800050a6:	95e2                	add	a1,a1,s8
    800050a8:	855a                	mv	a0,s6
    800050aa:	ffffc097          	auipc	ra,0xffffc
    800050ae:	fb2080e7          	jalr	-78(ra) # 8000105c <walkaddr>
    800050b2:	862a                	mv	a2,a0
    800050b4:	dd45                	beqz	a0,8000506c <exec+0xfe>
    800050b6:	8952                	mv	s2,s4
    800050b8:	fd49f2e3          	bgeu	s3,s4,8000507c <exec+0x10e>
    800050bc:	894e                	mv	s2,s3
    800050be:	bf7d                	j	8000507c <exec+0x10e>
    800050c0:	4901                	li	s2,0
    800050c2:	8556                	mv	a0,s5
    800050c4:	fffff097          	auipc	ra,0xfffff
    800050c8:	c04080e7          	jalr	-1020(ra) # 80003cc8 <iunlockput>
    800050cc:	fffff097          	auipc	ra,0xfffff
    800050d0:	3dc080e7          	jalr	988(ra) # 800044a8 <end_op>
    800050d4:	ffffd097          	auipc	ra,0xffffd
    800050d8:	8d8080e7          	jalr	-1832(ra) # 800019ac <myproc>
    800050dc:	8baa                	mv	s7,a0
    800050de:	04853d03          	ld	s10,72(a0)
    800050e2:	6785                	lui	a5,0x1
    800050e4:	17fd                	addi	a5,a5,-1
    800050e6:	993e                	add	s2,s2,a5
    800050e8:	77fd                	lui	a5,0xfffff
    800050ea:	00f977b3          	and	a5,s2,a5
    800050ee:	def43c23          	sd	a5,-520(s0)
    800050f2:	4691                	li	a3,4
    800050f4:	6609                	lui	a2,0x2
    800050f6:	963e                	add	a2,a2,a5
    800050f8:	85be                	mv	a1,a5
    800050fa:	855a                	mv	a0,s6
    800050fc:	ffffc097          	auipc	ra,0xffffc
    80005100:	314080e7          	jalr	788(ra) # 80001410 <uvmalloc>
    80005104:	8c2a                	mv	s8,a0
    80005106:	4a81                	li	s5,0
    80005108:	12050e63          	beqz	a0,80005244 <exec+0x2d6>
    8000510c:	75f9                	lui	a1,0xffffe
    8000510e:	95aa                	add	a1,a1,a0
    80005110:	855a                	mv	a0,s6
    80005112:	ffffc097          	auipc	ra,0xffffc
    80005116:	524080e7          	jalr	1316(ra) # 80001636 <uvmclear>
    8000511a:	7afd                	lui	s5,0xfffff
    8000511c:	9ae2                	add	s5,s5,s8
    8000511e:	df043783          	ld	a5,-528(s0)
    80005122:	6388                	ld	a0,0(a5)
    80005124:	c925                	beqz	a0,80005194 <exec+0x226>
    80005126:	e9040993          	addi	s3,s0,-368
    8000512a:	f9040c93          	addi	s9,s0,-112
    8000512e:	8962                	mv	s2,s8
    80005130:	4481                	li	s1,0
    80005132:	ffffc097          	auipc	ra,0xffffc
    80005136:	d1c080e7          	jalr	-740(ra) # 80000e4e <strlen>
    8000513a:	0015079b          	addiw	a5,a0,1
    8000513e:	40f90933          	sub	s2,s2,a5
    80005142:	ff097913          	andi	s2,s2,-16
    80005146:	13596663          	bltu	s2,s5,80005272 <exec+0x304>
    8000514a:	df043d83          	ld	s11,-528(s0)
    8000514e:	000dba03          	ld	s4,0(s11) # 1000 <_entry-0x7ffff000>
    80005152:	8552                	mv	a0,s4
    80005154:	ffffc097          	auipc	ra,0xffffc
    80005158:	cfa080e7          	jalr	-774(ra) # 80000e4e <strlen>
    8000515c:	0015069b          	addiw	a3,a0,1
    80005160:	8652                	mv	a2,s4
    80005162:	85ca                	mv	a1,s2
    80005164:	855a                	mv	a0,s6
    80005166:	ffffc097          	auipc	ra,0xffffc
    8000516a:	502080e7          	jalr	1282(ra) # 80001668 <copyout>
    8000516e:	10054663          	bltz	a0,8000527a <exec+0x30c>
    80005172:	0129b023          	sd	s2,0(s3)
    80005176:	0485                	addi	s1,s1,1
    80005178:	008d8793          	addi	a5,s11,8
    8000517c:	def43823          	sd	a5,-528(s0)
    80005180:	008db503          	ld	a0,8(s11)
    80005184:	c911                	beqz	a0,80005198 <exec+0x22a>
    80005186:	09a1                	addi	s3,s3,8
    80005188:	fb3c95e3          	bne	s9,s3,80005132 <exec+0x1c4>
    8000518c:	df843c23          	sd	s8,-520(s0)
    80005190:	4a81                	li	s5,0
    80005192:	a84d                	j	80005244 <exec+0x2d6>
    80005194:	8962                	mv	s2,s8
    80005196:	4481                	li	s1,0
    80005198:	00349793          	slli	a5,s1,0x3
    8000519c:	f9040713          	addi	a4,s0,-112
    800051a0:	97ba                	add	a5,a5,a4
    800051a2:	f007b023          	sd	zero,-256(a5) # ffffffffffffef00 <end+0xffffffff7ffdd180>
    800051a6:	00148693          	addi	a3,s1,1
    800051aa:	068e                	slli	a3,a3,0x3
    800051ac:	40d90933          	sub	s2,s2,a3
    800051b0:	ff097913          	andi	s2,s2,-16
    800051b4:	01597663          	bgeu	s2,s5,800051c0 <exec+0x252>
    800051b8:	df843c23          	sd	s8,-520(s0)
    800051bc:	4a81                	li	s5,0
    800051be:	a059                	j	80005244 <exec+0x2d6>
    800051c0:	e9040613          	addi	a2,s0,-368
    800051c4:	85ca                	mv	a1,s2
    800051c6:	855a                	mv	a0,s6
    800051c8:	ffffc097          	auipc	ra,0xffffc
    800051cc:	4a0080e7          	jalr	1184(ra) # 80001668 <copyout>
    800051d0:	0a054963          	bltz	a0,80005282 <exec+0x314>
    800051d4:	058bb783          	ld	a5,88(s7) # 1058 <_entry-0x7fffefa8>
    800051d8:	0727bc23          	sd	s2,120(a5)
    800051dc:	de843783          	ld	a5,-536(s0)
    800051e0:	0007c703          	lbu	a4,0(a5)
    800051e4:	cf11                	beqz	a4,80005200 <exec+0x292>
    800051e6:	0785                	addi	a5,a5,1
    800051e8:	02f00693          	li	a3,47
    800051ec:	a039                	j	800051fa <exec+0x28c>
    800051ee:	def43423          	sd	a5,-536(s0)
    800051f2:	0785                	addi	a5,a5,1
    800051f4:	fff7c703          	lbu	a4,-1(a5)
    800051f8:	c701                	beqz	a4,80005200 <exec+0x292>
    800051fa:	fed71ce3          	bne	a4,a3,800051f2 <exec+0x284>
    800051fe:	bfc5                	j	800051ee <exec+0x280>
    80005200:	4641                	li	a2,16
    80005202:	de843583          	ld	a1,-536(s0)
    80005206:	158b8513          	addi	a0,s7,344
    8000520a:	ffffc097          	auipc	ra,0xffffc
    8000520e:	c12080e7          	jalr	-1006(ra) # 80000e1c <safestrcpy>
    80005212:	050bb503          	ld	a0,80(s7)
    80005216:	056bb823          	sd	s6,80(s7)
    8000521a:	058bb423          	sd	s8,72(s7)
    8000521e:	058bb783          	ld	a5,88(s7)
    80005222:	e6843703          	ld	a4,-408(s0)
    80005226:	ef98                	sd	a4,24(a5)
    80005228:	058bb783          	ld	a5,88(s7)
    8000522c:	0327b823          	sd	s2,48(a5)
    80005230:	85ea                	mv	a1,s10
    80005232:	ffffd097          	auipc	ra,0xffffd
    80005236:	8da080e7          	jalr	-1830(ra) # 80001b0c <proc_freepigtable>
    8000523a:	0004851b          	sext.w	a0,s1
    8000523e:	b3f1                	j	8000500a <exec+0x9c>
    80005240:	df243c23          	sd	s2,-520(s0)
    80005244:	df843583          	ld	a1,-520(s0)
    80005248:	855a                	mv	a0,s6
    8000524a:	ffffd097          	auipc	ra,0xffffd
    8000524e:	8c2080e7          	jalr	-1854(ra) # 80001b0c <proc_freepigtable>
    80005252:	da0a92e3          	bnez	s5,80004ff6 <exec+0x88>
    80005256:	557d                	li	a0,-1
    80005258:	bb4d                	j	8000500a <exec+0x9c>
    8000525a:	df243c23          	sd	s2,-520(s0)
    8000525e:	b7dd                	j	80005244 <exec+0x2d6>
    80005260:	df243c23          	sd	s2,-520(s0)
    80005264:	b7c5                	j	80005244 <exec+0x2d6>
    80005266:	df243c23          	sd	s2,-520(s0)
    8000526a:	bfe9                	j	80005244 <exec+0x2d6>
    8000526c:	df243c23          	sd	s2,-520(s0)
    80005270:	bfd1                	j	80005244 <exec+0x2d6>
    80005272:	df843c23          	sd	s8,-520(s0)
    80005276:	4a81                	li	s5,0
    80005278:	b7f1                	j	80005244 <exec+0x2d6>
    8000527a:	df843c23          	sd	s8,-520(s0)
    8000527e:	4a81                	li	s5,0
    80005280:	b7d1                	j	80005244 <exec+0x2d6>
    80005282:	df843c23          	sd	s8,-520(s0)
    80005286:	4a81                	li	s5,0
    80005288:	bf75                	j	80005244 <exec+0x2d6>
    8000528a:	df843903          	ld	s2,-520(s0)
    8000528e:	e0843783          	ld	a5,-504(s0)
    80005292:	0017869b          	addiw	a3,a5,1
    80005296:	e0d43423          	sd	a3,-504(s0)
    8000529a:	e0043783          	ld	a5,-512(s0)
    8000529e:	0387879b          	addiw	a5,a5,56
    800052a2:	e8845703          	lhu	a4,-376(s0)
    800052a6:	e0e6dee3          	bge	a3,a4,800050c2 <exec+0x154>
    800052aa:	2781                	sext.w	a5,a5
    800052ac:	e0f43023          	sd	a5,-512(s0)
    800052b0:	03800713          	li	a4,56
    800052b4:	86be                	mv	a3,a5
    800052b6:	e1840613          	addi	a2,s0,-488
    800052ba:	4581                	li	a1,0
    800052bc:	8556                	mv	a0,s5
    800052be:	fffff097          	auipc	ra,0xfffff
    800052c2:	a5c080e7          	jalr	-1444(ra) # 80003d1a <readi>
    800052c6:	03800793          	li	a5,56
    800052ca:	f6f51be3          	bne	a0,a5,80005240 <exec+0x2d2>
    800052ce:	e1842783          	lw	a5,-488(s0)
    800052d2:	4705                	li	a4,1
    800052d4:	fae79de3          	bne	a5,a4,8000528e <exec+0x320>
    800052d8:	e4043483          	ld	s1,-448(s0)
    800052dc:	e3843783          	ld	a5,-456(s0)
    800052e0:	f6f4ede3          	bltu	s1,a5,8000525a <exec+0x2ec>
    800052e4:	e2843783          	ld	a5,-472(s0)
    800052e8:	94be                	add	s1,s1,a5
    800052ea:	f6f4ebe3          	bltu	s1,a5,80005260 <exec+0x2f2>
    800052ee:	de043703          	ld	a4,-544(s0)
    800052f2:	8ff9                	and	a5,a5,a4
    800052f4:	fbad                	bnez	a5,80005266 <exec+0x2f8>
    800052f6:	e1c42503          	lw	a0,-484(s0)
    800052fa:	00000097          	auipc	ra,0x0
    800052fe:	c58080e7          	jalr	-936(ra) # 80004f52 <flags2perm>
    80005302:	86aa                	mv	a3,a0
    80005304:	8626                	mv	a2,s1
    80005306:	85ca                	mv	a1,s2
    80005308:	855a                	mv	a0,s6
    8000530a:	ffffc097          	auipc	ra,0xffffc
    8000530e:	106080e7          	jalr	262(ra) # 80001410 <uvmalloc>
    80005312:	dea43c23          	sd	a0,-520(s0)
    80005316:	d939                	beqz	a0,8000526c <exec+0x2fe>
    80005318:	e2843c03          	ld	s8,-472(s0)
    8000531c:	e2042c83          	lw	s9,-480(s0)
    80005320:	e3842b83          	lw	s7,-456(s0)
    80005324:	f60b83e3          	beqz	s7,8000528a <exec+0x31c>
    80005328:	89de                	mv	s3,s7
    8000532a:	4481                	li	s1,0
    8000532c:	bb95                	j	800050a0 <exec+0x132>

000000008000532e <argfd>:
    8000532e:	7179                	addi	sp,sp,-48
    80005330:	f406                	sd	ra,40(sp)
    80005332:	f022                	sd	s0,32(sp)
    80005334:	ec26                	sd	s1,24(sp)
    80005336:	e84a                	sd	s2,16(sp)
    80005338:	1800                	addi	s0,sp,48
    8000533a:	892e                	mv	s2,a1
    8000533c:	84b2                	mv	s1,a2
    8000533e:	fdc40593          	addi	a1,s0,-36
    80005342:	ffffe097          	auipc	ra,0xffffe
    80005346:	b8e080e7          	jalr	-1138(ra) # 80002ed0 <argint>
    8000534a:	fdc42703          	lw	a4,-36(s0)
    8000534e:	47bd                	li	a5,15
    80005350:	02e7eb63          	bltu	a5,a4,80005386 <argfd+0x58>
    80005354:	ffffc097          	auipc	ra,0xffffc
    80005358:	658080e7          	jalr	1624(ra) # 800019ac <myproc>
    8000535c:	fdc42703          	lw	a4,-36(s0)
    80005360:	01a70793          	addi	a5,a4,26
    80005364:	078e                	slli	a5,a5,0x3
    80005366:	953e                	add	a0,a0,a5
    80005368:	611c                	ld	a5,0(a0)
    8000536a:	c385                	beqz	a5,8000538a <argfd+0x5c>
    8000536c:	00090463          	beqz	s2,80005374 <argfd+0x46>
    80005370:	00e92023          	sw	a4,0(s2)
    80005374:	4501                	li	a0,0
    80005376:	c091                	beqz	s1,8000537a <argfd+0x4c>
    80005378:	e09c                	sd	a5,0(s1)
    8000537a:	70a2                	ld	ra,40(sp)
    8000537c:	7402                	ld	s0,32(sp)
    8000537e:	64e2                	ld	s1,24(sp)
    80005380:	6942                	ld	s2,16(sp)
    80005382:	6145                	addi	sp,sp,48
    80005384:	8082                	ret
    80005386:	557d                	li	a0,-1
    80005388:	bfcd                	j	8000537a <argfd+0x4c>
    8000538a:	557d                	li	a0,-1
    8000538c:	b7fd                	j	8000537a <argfd+0x4c>

000000008000538e <fdalloc>:
    8000538e:	1101                	addi	sp,sp,-32
    80005390:	ec06                	sd	ra,24(sp)
    80005392:	e822                	sd	s0,16(sp)
    80005394:	e426                	sd	s1,8(sp)
    80005396:	1000                	addi	s0,sp,32
    80005398:	84aa                	mv	s1,a0
    8000539a:	ffffc097          	auipc	ra,0xffffc
    8000539e:	612080e7          	jalr	1554(ra) # 800019ac <myproc>
    800053a2:	862a                	mv	a2,a0
    800053a4:	0d050793          	addi	a5,a0,208
    800053a8:	4501                	li	a0,0
    800053aa:	46c1                	li	a3,16
    800053ac:	6398                	ld	a4,0(a5)
    800053ae:	cb19                	beqz	a4,800053c4 <fdalloc+0x36>
    800053b0:	2505                	addiw	a0,a0,1
    800053b2:	07a1                	addi	a5,a5,8
    800053b4:	fed51ce3          	bne	a0,a3,800053ac <fdalloc+0x1e>
    800053b8:	557d                	li	a0,-1
    800053ba:	60e2                	ld	ra,24(sp)
    800053bc:	6442                	ld	s0,16(sp)
    800053be:	64a2                	ld	s1,8(sp)
    800053c0:	6105                	addi	sp,sp,32
    800053c2:	8082                	ret
    800053c4:	01a50793          	addi	a5,a0,26
    800053c8:	078e                	slli	a5,a5,0x3
    800053ca:	963e                	add	a2,a2,a5
    800053cc:	e204                	sd	s1,0(a2)
    800053ce:	b7f5                	j	800053ba <fdalloc+0x2c>

00000000800053d0 <create>:
    800053d0:	715d                	addi	sp,sp,-80
    800053d2:	e486                	sd	ra,72(sp)
    800053d4:	e0a2                	sd	s0,64(sp)
    800053d6:	fc26                	sd	s1,56(sp)
    800053d8:	f84a                	sd	s2,48(sp)
    800053da:	f44e                	sd	s3,40(sp)
    800053dc:	f052                	sd	s4,32(sp)
    800053de:	ec56                	sd	s5,24(sp)
    800053e0:	e85a                	sd	s6,16(sp)
    800053e2:	0880                	addi	s0,sp,80
    800053e4:	8b2e                	mv	s6,a1
    800053e6:	89b2                	mv	s3,a2
    800053e8:	8936                	mv	s2,a3
    800053ea:	fb040593          	addi	a1,s0,-80
    800053ee:	fffff097          	auipc	ra,0xfffff
    800053f2:	e3c080e7          	jalr	-452(ra) # 8000422a <nameiparent>
    800053f6:	84aa                	mv	s1,a0
    800053f8:	14050f63          	beqz	a0,80005556 <create+0x186>
    800053fc:	ffffe097          	auipc	ra,0xffffe
    80005400:	66a080e7          	jalr	1642(ra) # 80003a66 <ilock>
    80005404:	4601                	li	a2,0
    80005406:	fb040593          	addi	a1,s0,-80
    8000540a:	8526                	mv	a0,s1
    8000540c:	fffff097          	auipc	ra,0xfffff
    80005410:	b3e080e7          	jalr	-1218(ra) # 80003f4a <dirlookup>
    80005414:	8aaa                	mv	s5,a0
    80005416:	c931                	beqz	a0,8000546a <create+0x9a>
    80005418:	8526                	mv	a0,s1
    8000541a:	fffff097          	auipc	ra,0xfffff
    8000541e:	8ae080e7          	jalr	-1874(ra) # 80003cc8 <iunlockput>
    80005422:	8556                	mv	a0,s5
    80005424:	ffffe097          	auipc	ra,0xffffe
    80005428:	642080e7          	jalr	1602(ra) # 80003a66 <ilock>
    8000542c:	000b059b          	sext.w	a1,s6
    80005430:	4789                	li	a5,2
    80005432:	02f59563          	bne	a1,a5,8000545c <create+0x8c>
    80005436:	044ad783          	lhu	a5,68(s5) # fffffffffffff044 <end+0xffffffff7ffdd2c4>
    8000543a:	37f9                	addiw	a5,a5,-2
    8000543c:	17c2                	slli	a5,a5,0x30
    8000543e:	93c1                	srli	a5,a5,0x30
    80005440:	4705                	li	a4,1
    80005442:	00f76d63          	bltu	a4,a5,8000545c <create+0x8c>
    80005446:	8556                	mv	a0,s5
    80005448:	60a6                	ld	ra,72(sp)
    8000544a:	6406                	ld	s0,64(sp)
    8000544c:	74e2                	ld	s1,56(sp)
    8000544e:	7942                	ld	s2,48(sp)
    80005450:	79a2                	ld	s3,40(sp)
    80005452:	7a02                	ld	s4,32(sp)
    80005454:	6ae2                	ld	s5,24(sp)
    80005456:	6b42                	ld	s6,16(sp)
    80005458:	6161                	addi	sp,sp,80
    8000545a:	8082                	ret
    8000545c:	8556                	mv	a0,s5
    8000545e:	fffff097          	auipc	ra,0xfffff
    80005462:	86a080e7          	jalr	-1942(ra) # 80003cc8 <iunlockput>
    80005466:	4a81                	li	s5,0
    80005468:	bff9                	j	80005446 <create+0x76>
    8000546a:	85da                	mv	a1,s6
    8000546c:	4088                	lw	a0,0(s1)
    8000546e:	ffffe097          	auipc	ra,0xffffe
    80005472:	45c080e7          	jalr	1116(ra) # 800038ca <ialloc>
    80005476:	8a2a                	mv	s4,a0
    80005478:	c539                	beqz	a0,800054c6 <create+0xf6>
    8000547a:	ffffe097          	auipc	ra,0xffffe
    8000547e:	5ec080e7          	jalr	1516(ra) # 80003a66 <ilock>
    80005482:	053a1323          	sh	s3,70(s4)
    80005486:	052a1423          	sh	s2,72(s4)
    8000548a:	4905                	li	s2,1
    8000548c:	052a1523          	sh	s2,74(s4)
    80005490:	8552                	mv	a0,s4
    80005492:	ffffe097          	auipc	ra,0xffffe
    80005496:	50a080e7          	jalr	1290(ra) # 8000399c <iupdate>
    8000549a:	000b059b          	sext.w	a1,s6
    8000549e:	03258b63          	beq	a1,s2,800054d4 <create+0x104>
    800054a2:	004a2603          	lw	a2,4(s4)
    800054a6:	fb040593          	addi	a1,s0,-80
    800054aa:	8526                	mv	a0,s1
    800054ac:	fffff097          	auipc	ra,0xfffff
    800054b0:	cae080e7          	jalr	-850(ra) # 8000415a <dirlink>
    800054b4:	06054f63          	bltz	a0,80005532 <create+0x162>
    800054b8:	8526                	mv	a0,s1
    800054ba:	fffff097          	auipc	ra,0xfffff
    800054be:	80e080e7          	jalr	-2034(ra) # 80003cc8 <iunlockput>
    800054c2:	8ad2                	mv	s5,s4
    800054c4:	b749                	j	80005446 <create+0x76>
    800054c6:	8526                	mv	a0,s1
    800054c8:	fffff097          	auipc	ra,0xfffff
    800054cc:	800080e7          	jalr	-2048(ra) # 80003cc8 <iunlockput>
    800054d0:	8ad2                	mv	s5,s4
    800054d2:	bf95                	j	80005446 <create+0x76>
    800054d4:	004a2603          	lw	a2,4(s4)
    800054d8:	00003597          	auipc	a1,0x3
    800054dc:	25858593          	addi	a1,a1,600 # 80008730 <syscalls+0x2a8>
    800054e0:	8552                	mv	a0,s4
    800054e2:	fffff097          	auipc	ra,0xfffff
    800054e6:	c78080e7          	jalr	-904(ra) # 8000415a <dirlink>
    800054ea:	04054463          	bltz	a0,80005532 <create+0x162>
    800054ee:	40d0                	lw	a2,4(s1)
    800054f0:	00003597          	auipc	a1,0x3
    800054f4:	24858593          	addi	a1,a1,584 # 80008738 <syscalls+0x2b0>
    800054f8:	8552                	mv	a0,s4
    800054fa:	fffff097          	auipc	ra,0xfffff
    800054fe:	c60080e7          	jalr	-928(ra) # 8000415a <dirlink>
    80005502:	02054863          	bltz	a0,80005532 <create+0x162>
    80005506:	004a2603          	lw	a2,4(s4)
    8000550a:	fb040593          	addi	a1,s0,-80
    8000550e:	8526                	mv	a0,s1
    80005510:	fffff097          	auipc	ra,0xfffff
    80005514:	c4a080e7          	jalr	-950(ra) # 8000415a <dirlink>
    80005518:	00054d63          	bltz	a0,80005532 <create+0x162>
    8000551c:	04a4d783          	lhu	a5,74(s1)
    80005520:	2785                	addiw	a5,a5,1
    80005522:	04f49523          	sh	a5,74(s1)
    80005526:	8526                	mv	a0,s1
    80005528:	ffffe097          	auipc	ra,0xffffe
    8000552c:	474080e7          	jalr	1140(ra) # 8000399c <iupdate>
    80005530:	b761                	j	800054b8 <create+0xe8>
    80005532:	040a1523          	sh	zero,74(s4)
    80005536:	8552                	mv	a0,s4
    80005538:	ffffe097          	auipc	ra,0xffffe
    8000553c:	464080e7          	jalr	1124(ra) # 8000399c <iupdate>
    80005540:	8552                	mv	a0,s4
    80005542:	ffffe097          	auipc	ra,0xffffe
    80005546:	786080e7          	jalr	1926(ra) # 80003cc8 <iunlockput>
    8000554a:	8526                	mv	a0,s1
    8000554c:	ffffe097          	auipc	ra,0xffffe
    80005550:	77c080e7          	jalr	1916(ra) # 80003cc8 <iunlockput>
    80005554:	bdcd                	j	80005446 <create+0x76>
    80005556:	8aaa                	mv	s5,a0
    80005558:	b5fd                	j	80005446 <create+0x76>

000000008000555a <sys_dup>:
    8000555a:	7179                	addi	sp,sp,-48
    8000555c:	f406                	sd	ra,40(sp)
    8000555e:	f022                	sd	s0,32(sp)
    80005560:	ec26                	sd	s1,24(sp)
    80005562:	1800                	addi	s0,sp,48
    80005564:	fd840613          	addi	a2,s0,-40
    80005568:	4581                	li	a1,0
    8000556a:	4501                	li	a0,0
    8000556c:	00000097          	auipc	ra,0x0
    80005570:	dc2080e7          	jalr	-574(ra) # 8000532e <argfd>
    80005574:	57fd                	li	a5,-1
    80005576:	02054363          	bltz	a0,8000559c <sys_dup+0x42>
    8000557a:	fd843503          	ld	a0,-40(s0)
    8000557e:	00000097          	auipc	ra,0x0
    80005582:	e10080e7          	jalr	-496(ra) # 8000538e <fdalloc>
    80005586:	84aa                	mv	s1,a0
    80005588:	57fd                	li	a5,-1
    8000558a:	00054963          	bltz	a0,8000559c <sys_dup+0x42>
    8000558e:	fd843503          	ld	a0,-40(s0)
    80005592:	fffff097          	auipc	ra,0xfffff
    80005596:	310080e7          	jalr	784(ra) # 800048a2 <filedup>
    8000559a:	87a6                	mv	a5,s1
    8000559c:	853e                	mv	a0,a5
    8000559e:	70a2                	ld	ra,40(sp)
    800055a0:	7402                	ld	s0,32(sp)
    800055a2:	64e2                	ld	s1,24(sp)
    800055a4:	6145                	addi	sp,sp,48
    800055a6:	8082                	ret

00000000800055a8 <sys_read>:
    800055a8:	7179                	addi	sp,sp,-48
    800055aa:	f406                	sd	ra,40(sp)
    800055ac:	f022                	sd	s0,32(sp)
    800055ae:	1800                	addi	s0,sp,48
    800055b0:	fd840593          	addi	a1,s0,-40
    800055b4:	4505                	li	a0,1
    800055b6:	ffffe097          	auipc	ra,0xffffe
    800055ba:	93a080e7          	jalr	-1734(ra) # 80002ef0 <argaddr>
    800055be:	fe440593          	addi	a1,s0,-28
    800055c2:	4509                	li	a0,2
    800055c4:	ffffe097          	auipc	ra,0xffffe
    800055c8:	90c080e7          	jalr	-1780(ra) # 80002ed0 <argint>
    800055cc:	fe840613          	addi	a2,s0,-24
    800055d0:	4581                	li	a1,0
    800055d2:	4501                	li	a0,0
    800055d4:	00000097          	auipc	ra,0x0
    800055d8:	d5a080e7          	jalr	-678(ra) # 8000532e <argfd>
    800055dc:	87aa                	mv	a5,a0
    800055de:	557d                	li	a0,-1
    800055e0:	0007cc63          	bltz	a5,800055f8 <sys_read+0x50>
    800055e4:	fe442603          	lw	a2,-28(s0)
    800055e8:	fd843583          	ld	a1,-40(s0)
    800055ec:	fe843503          	ld	a0,-24(s0)
    800055f0:	fffff097          	auipc	ra,0xfffff
    800055f4:	43e080e7          	jalr	1086(ra) # 80004a2e <fileread>
    800055f8:	70a2                	ld	ra,40(sp)
    800055fa:	7402                	ld	s0,32(sp)
    800055fc:	6145                	addi	sp,sp,48
    800055fe:	8082                	ret

0000000080005600 <sys_write>:
    80005600:	7179                	addi	sp,sp,-48
    80005602:	f406                	sd	ra,40(sp)
    80005604:	f022                	sd	s0,32(sp)
    80005606:	1800                	addi	s0,sp,48
    80005608:	fd840593          	addi	a1,s0,-40
    8000560c:	4505                	li	a0,1
    8000560e:	ffffe097          	auipc	ra,0xffffe
    80005612:	8e2080e7          	jalr	-1822(ra) # 80002ef0 <argaddr>
    80005616:	fe440593          	addi	a1,s0,-28
    8000561a:	4509                	li	a0,2
    8000561c:	ffffe097          	auipc	ra,0xffffe
    80005620:	8b4080e7          	jalr	-1868(ra) # 80002ed0 <argint>
    80005624:	fe840613          	addi	a2,s0,-24
    80005628:	4581                	li	a1,0
    8000562a:	4501                	li	a0,0
    8000562c:	00000097          	auipc	ra,0x0
    80005630:	d02080e7          	jalr	-766(ra) # 8000532e <argfd>
    80005634:	87aa                	mv	a5,a0
    80005636:	557d                	li	a0,-1
    80005638:	0007cc63          	bltz	a5,80005650 <sys_write+0x50>
    8000563c:	fe442603          	lw	a2,-28(s0)
    80005640:	fd843583          	ld	a1,-40(s0)
    80005644:	fe843503          	ld	a0,-24(s0)
    80005648:	fffff097          	auipc	ra,0xfffff
    8000564c:	4a8080e7          	jalr	1192(ra) # 80004af0 <filewrite>
    80005650:	70a2                	ld	ra,40(sp)
    80005652:	7402                	ld	s0,32(sp)
    80005654:	6145                	addi	sp,sp,48
    80005656:	8082                	ret

0000000080005658 <sys_close>:
    80005658:	1101                	addi	sp,sp,-32
    8000565a:	ec06                	sd	ra,24(sp)
    8000565c:	e822                	sd	s0,16(sp)
    8000565e:	1000                	addi	s0,sp,32
    80005660:	fe040613          	addi	a2,s0,-32
    80005664:	fec40593          	addi	a1,s0,-20
    80005668:	4501                	li	a0,0
    8000566a:	00000097          	auipc	ra,0x0
    8000566e:	cc4080e7          	jalr	-828(ra) # 8000532e <argfd>
    80005672:	57fd                	li	a5,-1
    80005674:	02054463          	bltz	a0,8000569c <sys_close+0x44>
    80005678:	ffffc097          	auipc	ra,0xffffc
    8000567c:	334080e7          	jalr	820(ra) # 800019ac <myproc>
    80005680:	fec42783          	lw	a5,-20(s0)
    80005684:	07e9                	addi	a5,a5,26
    80005686:	078e                	slli	a5,a5,0x3
    80005688:	97aa                	add	a5,a5,a0
    8000568a:	0007b023          	sd	zero,0(a5)
    8000568e:	fe043503          	ld	a0,-32(s0)
    80005692:	fffff097          	auipc	ra,0xfffff
    80005696:	262080e7          	jalr	610(ra) # 800048f4 <fileclose>
    8000569a:	4781                	li	a5,0
    8000569c:	853e                	mv	a0,a5
    8000569e:	60e2                	ld	ra,24(sp)
    800056a0:	6442                	ld	s0,16(sp)
    800056a2:	6105                	addi	sp,sp,32
    800056a4:	8082                	ret

00000000800056a6 <sys_fstat>:
    800056a6:	1101                	addi	sp,sp,-32
    800056a8:	ec06                	sd	ra,24(sp)
    800056aa:	e822                	sd	s0,16(sp)
    800056ac:	1000                	addi	s0,sp,32
    800056ae:	fe040593          	addi	a1,s0,-32
    800056b2:	4505                	li	a0,1
    800056b4:	ffffe097          	auipc	ra,0xffffe
    800056b8:	83c080e7          	jalr	-1988(ra) # 80002ef0 <argaddr>
    800056bc:	fe840613          	addi	a2,s0,-24
    800056c0:	4581                	li	a1,0
    800056c2:	4501                	li	a0,0
    800056c4:	00000097          	auipc	ra,0x0
    800056c8:	c6a080e7          	jalr	-918(ra) # 8000532e <argfd>
    800056cc:	87aa                	mv	a5,a0
    800056ce:	557d                	li	a0,-1
    800056d0:	0007ca63          	bltz	a5,800056e4 <sys_fstat+0x3e>
    800056d4:	fe043583          	ld	a1,-32(s0)
    800056d8:	fe843503          	ld	a0,-24(s0)
    800056dc:	fffff097          	auipc	ra,0xfffff
    800056e0:	2e0080e7          	jalr	736(ra) # 800049bc <filestat>
    800056e4:	60e2                	ld	ra,24(sp)
    800056e6:	6442                	ld	s0,16(sp)
    800056e8:	6105                	addi	sp,sp,32
    800056ea:	8082                	ret

00000000800056ec <sys_link>:
    800056ec:	7169                	addi	sp,sp,-304
    800056ee:	f606                	sd	ra,296(sp)
    800056f0:	f222                	sd	s0,288(sp)
    800056f2:	ee26                	sd	s1,280(sp)
    800056f4:	ea4a                	sd	s2,272(sp)
    800056f6:	1a00                	addi	s0,sp,304
    800056f8:	08000613          	li	a2,128
    800056fc:	ed040593          	addi	a1,s0,-304
    80005700:	4501                	li	a0,0
    80005702:	ffffe097          	auipc	ra,0xffffe
    80005706:	80e080e7          	jalr	-2034(ra) # 80002f10 <argstr>
    8000570a:	57fd                	li	a5,-1
    8000570c:	10054e63          	bltz	a0,80005828 <sys_link+0x13c>
    80005710:	08000613          	li	a2,128
    80005714:	f5040593          	addi	a1,s0,-176
    80005718:	4505                	li	a0,1
    8000571a:	ffffd097          	auipc	ra,0xffffd
    8000571e:	7f6080e7          	jalr	2038(ra) # 80002f10 <argstr>
    80005722:	57fd                	li	a5,-1
    80005724:	10054263          	bltz	a0,80005828 <sys_link+0x13c>
    80005728:	fffff097          	auipc	ra,0xfffff
    8000572c:	d00080e7          	jalr	-768(ra) # 80004428 <begin_op>
    80005730:	ed040513          	addi	a0,s0,-304
    80005734:	fffff097          	auipc	ra,0xfffff
    80005738:	ad8080e7          	jalr	-1320(ra) # 8000420c <namei>
    8000573c:	84aa                	mv	s1,a0
    8000573e:	c551                	beqz	a0,800057ca <sys_link+0xde>
    80005740:	ffffe097          	auipc	ra,0xffffe
    80005744:	326080e7          	jalr	806(ra) # 80003a66 <ilock>
    80005748:	04449703          	lh	a4,68(s1)
    8000574c:	4785                	li	a5,1
    8000574e:	08f70463          	beq	a4,a5,800057d6 <sys_link+0xea>
    80005752:	04a4d783          	lhu	a5,74(s1)
    80005756:	2785                	addiw	a5,a5,1
    80005758:	04f49523          	sh	a5,74(s1)
    8000575c:	8526                	mv	a0,s1
    8000575e:	ffffe097          	auipc	ra,0xffffe
    80005762:	23e080e7          	jalr	574(ra) # 8000399c <iupdate>
    80005766:	8526                	mv	a0,s1
    80005768:	ffffe097          	auipc	ra,0xffffe
    8000576c:	3c0080e7          	jalr	960(ra) # 80003b28 <iunlock>
    80005770:	fd040593          	addi	a1,s0,-48
    80005774:	f5040513          	addi	a0,s0,-176
    80005778:	fffff097          	auipc	ra,0xfffff
    8000577c:	ab2080e7          	jalr	-1358(ra) # 8000422a <nameiparent>
    80005780:	892a                	mv	s2,a0
    80005782:	c935                	beqz	a0,800057f6 <sys_link+0x10a>
    80005784:	ffffe097          	auipc	ra,0xffffe
    80005788:	2e2080e7          	jalr	738(ra) # 80003a66 <ilock>
    8000578c:	00092703          	lw	a4,0(s2)
    80005790:	409c                	lw	a5,0(s1)
    80005792:	04f71d63          	bne	a4,a5,800057ec <sys_link+0x100>
    80005796:	40d0                	lw	a2,4(s1)
    80005798:	fd040593          	addi	a1,s0,-48
    8000579c:	854a                	mv	a0,s2
    8000579e:	fffff097          	auipc	ra,0xfffff
    800057a2:	9bc080e7          	jalr	-1604(ra) # 8000415a <dirlink>
    800057a6:	04054363          	bltz	a0,800057ec <sys_link+0x100>
    800057aa:	854a                	mv	a0,s2
    800057ac:	ffffe097          	auipc	ra,0xffffe
    800057b0:	51c080e7          	jalr	1308(ra) # 80003cc8 <iunlockput>
    800057b4:	8526                	mv	a0,s1
    800057b6:	ffffe097          	auipc	ra,0xffffe
    800057ba:	46a080e7          	jalr	1130(ra) # 80003c20 <iput>
    800057be:	fffff097          	auipc	ra,0xfffff
    800057c2:	cea080e7          	jalr	-790(ra) # 800044a8 <end_op>
    800057c6:	4781                	li	a5,0
    800057c8:	a085                	j	80005828 <sys_link+0x13c>
    800057ca:	fffff097          	auipc	ra,0xfffff
    800057ce:	cde080e7          	jalr	-802(ra) # 800044a8 <end_op>
    800057d2:	57fd                	li	a5,-1
    800057d4:	a891                	j	80005828 <sys_link+0x13c>
    800057d6:	8526                	mv	a0,s1
    800057d8:	ffffe097          	auipc	ra,0xffffe
    800057dc:	4f0080e7          	jalr	1264(ra) # 80003cc8 <iunlockput>
    800057e0:	fffff097          	auipc	ra,0xfffff
    800057e4:	cc8080e7          	jalr	-824(ra) # 800044a8 <end_op>
    800057e8:	57fd                	li	a5,-1
    800057ea:	a83d                	j	80005828 <sys_link+0x13c>
    800057ec:	854a                	mv	a0,s2
    800057ee:	ffffe097          	auipc	ra,0xffffe
    800057f2:	4da080e7          	jalr	1242(ra) # 80003cc8 <iunlockput>
    800057f6:	8526                	mv	a0,s1
    800057f8:	ffffe097          	auipc	ra,0xffffe
    800057fc:	26e080e7          	jalr	622(ra) # 80003a66 <ilock>
    80005800:	04a4d783          	lhu	a5,74(s1)
    80005804:	37fd                	addiw	a5,a5,-1
    80005806:	04f49523          	sh	a5,74(s1)
    8000580a:	8526                	mv	a0,s1
    8000580c:	ffffe097          	auipc	ra,0xffffe
    80005810:	190080e7          	jalr	400(ra) # 8000399c <iupdate>
    80005814:	8526                	mv	a0,s1
    80005816:	ffffe097          	auipc	ra,0xffffe
    8000581a:	4b2080e7          	jalr	1202(ra) # 80003cc8 <iunlockput>
    8000581e:	fffff097          	auipc	ra,0xfffff
    80005822:	c8a080e7          	jalr	-886(ra) # 800044a8 <end_op>
    80005826:	57fd                	li	a5,-1
    80005828:	853e                	mv	a0,a5
    8000582a:	70b2                	ld	ra,296(sp)
    8000582c:	7412                	ld	s0,288(sp)
    8000582e:	64f2                	ld	s1,280(sp)
    80005830:	6952                	ld	s2,272(sp)
    80005832:	6155                	addi	sp,sp,304
    80005834:	8082                	ret

0000000080005836 <sys_unlink>:
    80005836:	7151                	addi	sp,sp,-240
    80005838:	f586                	sd	ra,232(sp)
    8000583a:	f1a2                	sd	s0,224(sp)
    8000583c:	eda6                	sd	s1,216(sp)
    8000583e:	e9ca                	sd	s2,208(sp)
    80005840:	e5ce                	sd	s3,200(sp)
    80005842:	1980                	addi	s0,sp,240
    80005844:	08000613          	li	a2,128
    80005848:	f3040593          	addi	a1,s0,-208
    8000584c:	4501                	li	a0,0
    8000584e:	ffffd097          	auipc	ra,0xffffd
    80005852:	6c2080e7          	jalr	1730(ra) # 80002f10 <argstr>
    80005856:	18054163          	bltz	a0,800059d8 <sys_unlink+0x1a2>
    8000585a:	fffff097          	auipc	ra,0xfffff
    8000585e:	bce080e7          	jalr	-1074(ra) # 80004428 <begin_op>
    80005862:	fb040593          	addi	a1,s0,-80
    80005866:	f3040513          	addi	a0,s0,-208
    8000586a:	fffff097          	auipc	ra,0xfffff
    8000586e:	9c0080e7          	jalr	-1600(ra) # 8000422a <nameiparent>
    80005872:	84aa                	mv	s1,a0
    80005874:	c979                	beqz	a0,8000594a <sys_unlink+0x114>
    80005876:	ffffe097          	auipc	ra,0xffffe
    8000587a:	1f0080e7          	jalr	496(ra) # 80003a66 <ilock>
    8000587e:	00003597          	auipc	a1,0x3
    80005882:	eb258593          	addi	a1,a1,-334 # 80008730 <syscalls+0x2a8>
    80005886:	fb040513          	addi	a0,s0,-80
    8000588a:	ffffe097          	auipc	ra,0xffffe
    8000588e:	6a6080e7          	jalr	1702(ra) # 80003f30 <namecmp>
    80005892:	14050a63          	beqz	a0,800059e6 <sys_unlink+0x1b0>
    80005896:	00003597          	auipc	a1,0x3
    8000589a:	ea258593          	addi	a1,a1,-350 # 80008738 <syscalls+0x2b0>
    8000589e:	fb040513          	addi	a0,s0,-80
    800058a2:	ffffe097          	auipc	ra,0xffffe
    800058a6:	68e080e7          	jalr	1678(ra) # 80003f30 <namecmp>
    800058aa:	12050e63          	beqz	a0,800059e6 <sys_unlink+0x1b0>
    800058ae:	f2c40613          	addi	a2,s0,-212
    800058b2:	fb040593          	addi	a1,s0,-80
    800058b6:	8526                	mv	a0,s1
    800058b8:	ffffe097          	auipc	ra,0xffffe
    800058bc:	692080e7          	jalr	1682(ra) # 80003f4a <dirlookup>
    800058c0:	892a                	mv	s2,a0
    800058c2:	12050263          	beqz	a0,800059e6 <sys_unlink+0x1b0>
    800058c6:	ffffe097          	auipc	ra,0xffffe
    800058ca:	1a0080e7          	jalr	416(ra) # 80003a66 <ilock>
    800058ce:	04a91783          	lh	a5,74(s2)
    800058d2:	08f05263          	blez	a5,80005956 <sys_unlink+0x120>
    800058d6:	04491703          	lh	a4,68(s2)
    800058da:	4785                	li	a5,1
    800058dc:	08f70563          	beq	a4,a5,80005966 <sys_unlink+0x130>
    800058e0:	4641                	li	a2,16
    800058e2:	4581                	li	a1,0
    800058e4:	fc040513          	addi	a0,s0,-64
    800058e8:	ffffb097          	auipc	ra,0xffffb
    800058ec:	3ea080e7          	jalr	1002(ra) # 80000cd2 <memset>
    800058f0:	4741                	li	a4,16
    800058f2:	f2c42683          	lw	a3,-212(s0)
    800058f6:	fc040613          	addi	a2,s0,-64
    800058fa:	4581                	li	a1,0
    800058fc:	8526                	mv	a0,s1
    800058fe:	ffffe097          	auipc	ra,0xffffe
    80005902:	514080e7          	jalr	1300(ra) # 80003e12 <writei>
    80005906:	47c1                	li	a5,16
    80005908:	0af51563          	bne	a0,a5,800059b2 <sys_unlink+0x17c>
    8000590c:	04491703          	lh	a4,68(s2)
    80005910:	4785                	li	a5,1
    80005912:	0af70863          	beq	a4,a5,800059c2 <sys_unlink+0x18c>
    80005916:	8526                	mv	a0,s1
    80005918:	ffffe097          	auipc	ra,0xffffe
    8000591c:	3b0080e7          	jalr	944(ra) # 80003cc8 <iunlockput>
    80005920:	04a95783          	lhu	a5,74(s2)
    80005924:	37fd                	addiw	a5,a5,-1
    80005926:	04f91523          	sh	a5,74(s2)
    8000592a:	854a                	mv	a0,s2
    8000592c:	ffffe097          	auipc	ra,0xffffe
    80005930:	070080e7          	jalr	112(ra) # 8000399c <iupdate>
    80005934:	854a                	mv	a0,s2
    80005936:	ffffe097          	auipc	ra,0xffffe
    8000593a:	392080e7          	jalr	914(ra) # 80003cc8 <iunlockput>
    8000593e:	fffff097          	auipc	ra,0xfffff
    80005942:	b6a080e7          	jalr	-1174(ra) # 800044a8 <end_op>
    80005946:	4501                	li	a0,0
    80005948:	a84d                	j	800059fa <sys_unlink+0x1c4>
    8000594a:	fffff097          	auipc	ra,0xfffff
    8000594e:	b5e080e7          	jalr	-1186(ra) # 800044a8 <end_op>
    80005952:	557d                	li	a0,-1
    80005954:	a05d                	j	800059fa <sys_unlink+0x1c4>
    80005956:	00003517          	auipc	a0,0x3
    8000595a:	dea50513          	addi	a0,a0,-534 # 80008740 <syscalls+0x2b8>
    8000595e:	ffffb097          	auipc	ra,0xffffb
    80005962:	be0080e7          	jalr	-1056(ra) # 8000053e <panic>
    80005966:	04c92703          	lw	a4,76(s2)
    8000596a:	02000793          	li	a5,32
    8000596e:	f6e7f9e3          	bgeu	a5,a4,800058e0 <sys_unlink+0xaa>
    80005972:	02000993          	li	s3,32
    80005976:	4741                	li	a4,16
    80005978:	86ce                	mv	a3,s3
    8000597a:	f1840613          	addi	a2,s0,-232
    8000597e:	4581                	li	a1,0
    80005980:	854a                	mv	a0,s2
    80005982:	ffffe097          	auipc	ra,0xffffe
    80005986:	398080e7          	jalr	920(ra) # 80003d1a <readi>
    8000598a:	47c1                	li	a5,16
    8000598c:	00f51b63          	bne	a0,a5,800059a2 <sys_unlink+0x16c>
    80005990:	f1845783          	lhu	a5,-232(s0)
    80005994:	e7a1                	bnez	a5,800059dc <sys_unlink+0x1a6>
    80005996:	29c1                	addiw	s3,s3,16
    80005998:	04c92783          	lw	a5,76(s2)
    8000599c:	fcf9ede3          	bltu	s3,a5,80005976 <sys_unlink+0x140>
    800059a0:	b781                	j	800058e0 <sys_unlink+0xaa>
    800059a2:	00003517          	auipc	a0,0x3
    800059a6:	db650513          	addi	a0,a0,-586 # 80008758 <syscalls+0x2d0>
    800059aa:	ffffb097          	auipc	ra,0xffffb
    800059ae:	b94080e7          	jalr	-1132(ra) # 8000053e <panic>
    800059b2:	00003517          	auipc	a0,0x3
    800059b6:	dbe50513          	addi	a0,a0,-578 # 80008770 <syscalls+0x2e8>
    800059ba:	ffffb097          	auipc	ra,0xffffb
    800059be:	b84080e7          	jalr	-1148(ra) # 8000053e <panic>
    800059c2:	04a4d783          	lhu	a5,74(s1)
    800059c6:	37fd                	addiw	a5,a5,-1
    800059c8:	04f49523          	sh	a5,74(s1)
    800059cc:	8526                	mv	a0,s1
    800059ce:	ffffe097          	auipc	ra,0xffffe
    800059d2:	fce080e7          	jalr	-50(ra) # 8000399c <iupdate>
    800059d6:	b781                	j	80005916 <sys_unlink+0xe0>
    800059d8:	557d                	li	a0,-1
    800059da:	a005                	j	800059fa <sys_unlink+0x1c4>
    800059dc:	854a                	mv	a0,s2
    800059de:	ffffe097          	auipc	ra,0xffffe
    800059e2:	2ea080e7          	jalr	746(ra) # 80003cc8 <iunlockput>
    800059e6:	8526                	mv	a0,s1
    800059e8:	ffffe097          	auipc	ra,0xffffe
    800059ec:	2e0080e7          	jalr	736(ra) # 80003cc8 <iunlockput>
    800059f0:	fffff097          	auipc	ra,0xfffff
    800059f4:	ab8080e7          	jalr	-1352(ra) # 800044a8 <end_op>
    800059f8:	557d                	li	a0,-1
    800059fa:	70ae                	ld	ra,232(sp)
    800059fc:	740e                	ld	s0,224(sp)
    800059fe:	64ee                	ld	s1,216(sp)
    80005a00:	694e                	ld	s2,208(sp)
    80005a02:	69ae                	ld	s3,200(sp)
    80005a04:	616d                	addi	sp,sp,240
    80005a06:	8082                	ret

0000000080005a08 <sys_open>:
    80005a08:	7131                	addi	sp,sp,-192
    80005a0a:	fd06                	sd	ra,184(sp)
    80005a0c:	f922                	sd	s0,176(sp)
    80005a0e:	f526                	sd	s1,168(sp)
    80005a10:	f14a                	sd	s2,160(sp)
    80005a12:	ed4e                	sd	s3,152(sp)
    80005a14:	0180                	addi	s0,sp,192
    80005a16:	f4c40593          	addi	a1,s0,-180
    80005a1a:	4505                	li	a0,1
    80005a1c:	ffffd097          	auipc	ra,0xffffd
    80005a20:	4b4080e7          	jalr	1204(ra) # 80002ed0 <argint>
    80005a24:	08000613          	li	a2,128
    80005a28:	f5040593          	addi	a1,s0,-176
    80005a2c:	4501                	li	a0,0
    80005a2e:	ffffd097          	auipc	ra,0xffffd
    80005a32:	4e2080e7          	jalr	1250(ra) # 80002f10 <argstr>
    80005a36:	87aa                	mv	a5,a0
    80005a38:	557d                	li	a0,-1
    80005a3a:	0a07c963          	bltz	a5,80005aec <sys_open+0xe4>
    80005a3e:	fffff097          	auipc	ra,0xfffff
    80005a42:	9ea080e7          	jalr	-1558(ra) # 80004428 <begin_op>
    80005a46:	f4c42783          	lw	a5,-180(s0)
    80005a4a:	2007f793          	andi	a5,a5,512
    80005a4e:	cfc5                	beqz	a5,80005b06 <sys_open+0xfe>
    80005a50:	4681                	li	a3,0
    80005a52:	4601                	li	a2,0
    80005a54:	4589                	li	a1,2
    80005a56:	f5040513          	addi	a0,s0,-176
    80005a5a:	00000097          	auipc	ra,0x0
    80005a5e:	976080e7          	jalr	-1674(ra) # 800053d0 <create>
    80005a62:	84aa                	mv	s1,a0
    80005a64:	c959                	beqz	a0,80005afa <sys_open+0xf2>
    80005a66:	04449703          	lh	a4,68(s1)
    80005a6a:	478d                	li	a5,3
    80005a6c:	00f71763          	bne	a4,a5,80005a7a <sys_open+0x72>
    80005a70:	0464d703          	lhu	a4,70(s1)
    80005a74:	47a5                	li	a5,9
    80005a76:	0ce7ed63          	bltu	a5,a4,80005b50 <sys_open+0x148>
    80005a7a:	fffff097          	auipc	ra,0xfffff
    80005a7e:	dbe080e7          	jalr	-578(ra) # 80004838 <filealloc>
    80005a82:	89aa                	mv	s3,a0
    80005a84:	10050363          	beqz	a0,80005b8a <sys_open+0x182>
    80005a88:	00000097          	auipc	ra,0x0
    80005a8c:	906080e7          	jalr	-1786(ra) # 8000538e <fdalloc>
    80005a90:	892a                	mv	s2,a0
    80005a92:	0e054763          	bltz	a0,80005b80 <sys_open+0x178>
    80005a96:	04449703          	lh	a4,68(s1)
    80005a9a:	478d                	li	a5,3
    80005a9c:	0cf70563          	beq	a4,a5,80005b66 <sys_open+0x15e>
    80005aa0:	4789                	li	a5,2
    80005aa2:	00f9a023          	sw	a5,0(s3)
    80005aa6:	0209a023          	sw	zero,32(s3)
    80005aaa:	0099bc23          	sd	s1,24(s3)
    80005aae:	f4c42783          	lw	a5,-180(s0)
    80005ab2:	0017c713          	xori	a4,a5,1
    80005ab6:	8b05                	andi	a4,a4,1
    80005ab8:	00e98423          	sb	a4,8(s3)
    80005abc:	0037f713          	andi	a4,a5,3
    80005ac0:	00e03733          	snez	a4,a4
    80005ac4:	00e984a3          	sb	a4,9(s3)
    80005ac8:	4007f793          	andi	a5,a5,1024
    80005acc:	c791                	beqz	a5,80005ad8 <sys_open+0xd0>
    80005ace:	04449703          	lh	a4,68(s1)
    80005ad2:	4789                	li	a5,2
    80005ad4:	0af70063          	beq	a4,a5,80005b74 <sys_open+0x16c>
    80005ad8:	8526                	mv	a0,s1
    80005ada:	ffffe097          	auipc	ra,0xffffe
    80005ade:	04e080e7          	jalr	78(ra) # 80003b28 <iunlock>
    80005ae2:	fffff097          	auipc	ra,0xfffff
    80005ae6:	9c6080e7          	jalr	-1594(ra) # 800044a8 <end_op>
    80005aea:	854a                	mv	a0,s2
    80005aec:	70ea                	ld	ra,184(sp)
    80005aee:	744a                	ld	s0,176(sp)
    80005af0:	74aa                	ld	s1,168(sp)
    80005af2:	790a                	ld	s2,160(sp)
    80005af4:	69ea                	ld	s3,152(sp)
    80005af6:	6129                	addi	sp,sp,192
    80005af8:	8082                	ret
    80005afa:	fffff097          	auipc	ra,0xfffff
    80005afe:	9ae080e7          	jalr	-1618(ra) # 800044a8 <end_op>
    80005b02:	557d                	li	a0,-1
    80005b04:	b7e5                	j	80005aec <sys_open+0xe4>
    80005b06:	f5040513          	addi	a0,s0,-176
    80005b0a:	ffffe097          	auipc	ra,0xffffe
    80005b0e:	702080e7          	jalr	1794(ra) # 8000420c <namei>
    80005b12:	84aa                	mv	s1,a0
    80005b14:	c905                	beqz	a0,80005b44 <sys_open+0x13c>
    80005b16:	ffffe097          	auipc	ra,0xffffe
    80005b1a:	f50080e7          	jalr	-176(ra) # 80003a66 <ilock>
    80005b1e:	04449703          	lh	a4,68(s1)
    80005b22:	4785                	li	a5,1
    80005b24:	f4f711e3          	bne	a4,a5,80005a66 <sys_open+0x5e>
    80005b28:	f4c42783          	lw	a5,-180(s0)
    80005b2c:	d7b9                	beqz	a5,80005a7a <sys_open+0x72>
    80005b2e:	8526                	mv	a0,s1
    80005b30:	ffffe097          	auipc	ra,0xffffe
    80005b34:	198080e7          	jalr	408(ra) # 80003cc8 <iunlockput>
    80005b38:	fffff097          	auipc	ra,0xfffff
    80005b3c:	970080e7          	jalr	-1680(ra) # 800044a8 <end_op>
    80005b40:	557d                	li	a0,-1
    80005b42:	b76d                	j	80005aec <sys_open+0xe4>
    80005b44:	fffff097          	auipc	ra,0xfffff
    80005b48:	964080e7          	jalr	-1692(ra) # 800044a8 <end_op>
    80005b4c:	557d                	li	a0,-1
    80005b4e:	bf79                	j	80005aec <sys_open+0xe4>
    80005b50:	8526                	mv	a0,s1
    80005b52:	ffffe097          	auipc	ra,0xffffe
    80005b56:	176080e7          	jalr	374(ra) # 80003cc8 <iunlockput>
    80005b5a:	fffff097          	auipc	ra,0xfffff
    80005b5e:	94e080e7          	jalr	-1714(ra) # 800044a8 <end_op>
    80005b62:	557d                	li	a0,-1
    80005b64:	b761                	j	80005aec <sys_open+0xe4>
    80005b66:	00f9a023          	sw	a5,0(s3)
    80005b6a:	04649783          	lh	a5,70(s1)
    80005b6e:	02f99223          	sh	a5,36(s3)
    80005b72:	bf25                	j	80005aaa <sys_open+0xa2>
    80005b74:	8526                	mv	a0,s1
    80005b76:	ffffe097          	auipc	ra,0xffffe
    80005b7a:	ffe080e7          	jalr	-2(ra) # 80003b74 <itrunc>
    80005b7e:	bfa9                	j	80005ad8 <sys_open+0xd0>
    80005b80:	854e                	mv	a0,s3
    80005b82:	fffff097          	auipc	ra,0xfffff
    80005b86:	d72080e7          	jalr	-654(ra) # 800048f4 <fileclose>
    80005b8a:	8526                	mv	a0,s1
    80005b8c:	ffffe097          	auipc	ra,0xffffe
    80005b90:	13c080e7          	jalr	316(ra) # 80003cc8 <iunlockput>
    80005b94:	fffff097          	auipc	ra,0xfffff
    80005b98:	914080e7          	jalr	-1772(ra) # 800044a8 <end_op>
    80005b9c:	557d                	li	a0,-1
    80005b9e:	b7b9                	j	80005aec <sys_open+0xe4>

0000000080005ba0 <sys_mkdir>:
    80005ba0:	7175                	addi	sp,sp,-144
    80005ba2:	e506                	sd	ra,136(sp)
    80005ba4:	e122                	sd	s0,128(sp)
    80005ba6:	0900                	addi	s0,sp,144
    80005ba8:	fffff097          	auipc	ra,0xfffff
    80005bac:	880080e7          	jalr	-1920(ra) # 80004428 <begin_op>
    80005bb0:	08000613          	li	a2,128
    80005bb4:	f7040593          	addi	a1,s0,-144
    80005bb8:	4501                	li	a0,0
    80005bba:	ffffd097          	auipc	ra,0xffffd
    80005bbe:	356080e7          	jalr	854(ra) # 80002f10 <argstr>
    80005bc2:	02054963          	bltz	a0,80005bf4 <sys_mkdir+0x54>
    80005bc6:	4681                	li	a3,0
    80005bc8:	4601                	li	a2,0
    80005bca:	4585                	li	a1,1
    80005bcc:	f7040513          	addi	a0,s0,-144
    80005bd0:	00000097          	auipc	ra,0x0
    80005bd4:	800080e7          	jalr	-2048(ra) # 800053d0 <create>
    80005bd8:	cd11                	beqz	a0,80005bf4 <sys_mkdir+0x54>
    80005bda:	ffffe097          	auipc	ra,0xffffe
    80005bde:	0ee080e7          	jalr	238(ra) # 80003cc8 <iunlockput>
    80005be2:	fffff097          	auipc	ra,0xfffff
    80005be6:	8c6080e7          	jalr	-1850(ra) # 800044a8 <end_op>
    80005bea:	4501                	li	a0,0
    80005bec:	60aa                	ld	ra,136(sp)
    80005bee:	640a                	ld	s0,128(sp)
    80005bf0:	6149                	addi	sp,sp,144
    80005bf2:	8082                	ret
    80005bf4:	fffff097          	auipc	ra,0xfffff
    80005bf8:	8b4080e7          	jalr	-1868(ra) # 800044a8 <end_op>
    80005bfc:	557d                	li	a0,-1
    80005bfe:	b7fd                	j	80005bec <sys_mkdir+0x4c>

0000000080005c00 <sys_mknod>:
    80005c00:	7135                	addi	sp,sp,-160
    80005c02:	ed06                	sd	ra,152(sp)
    80005c04:	e922                	sd	s0,144(sp)
    80005c06:	1100                	addi	s0,sp,160
    80005c08:	fffff097          	auipc	ra,0xfffff
    80005c0c:	820080e7          	jalr	-2016(ra) # 80004428 <begin_op>
    80005c10:	f6c40593          	addi	a1,s0,-148
    80005c14:	4505                	li	a0,1
    80005c16:	ffffd097          	auipc	ra,0xffffd
    80005c1a:	2ba080e7          	jalr	698(ra) # 80002ed0 <argint>
    80005c1e:	f6840593          	addi	a1,s0,-152
    80005c22:	4509                	li	a0,2
    80005c24:	ffffd097          	auipc	ra,0xffffd
    80005c28:	2ac080e7          	jalr	684(ra) # 80002ed0 <argint>
    80005c2c:	08000613          	li	a2,128
    80005c30:	f7040593          	addi	a1,s0,-144
    80005c34:	4501                	li	a0,0
    80005c36:	ffffd097          	auipc	ra,0xffffd
    80005c3a:	2da080e7          	jalr	730(ra) # 80002f10 <argstr>
    80005c3e:	02054b63          	bltz	a0,80005c74 <sys_mknod+0x74>
    80005c42:	f6841683          	lh	a3,-152(s0)
    80005c46:	f6c41603          	lh	a2,-148(s0)
    80005c4a:	458d                	li	a1,3
    80005c4c:	f7040513          	addi	a0,s0,-144
    80005c50:	fffff097          	auipc	ra,0xfffff
    80005c54:	780080e7          	jalr	1920(ra) # 800053d0 <create>
    80005c58:	cd11                	beqz	a0,80005c74 <sys_mknod+0x74>
    80005c5a:	ffffe097          	auipc	ra,0xffffe
    80005c5e:	06e080e7          	jalr	110(ra) # 80003cc8 <iunlockput>
    80005c62:	fffff097          	auipc	ra,0xfffff
    80005c66:	846080e7          	jalr	-1978(ra) # 800044a8 <end_op>
    80005c6a:	4501                	li	a0,0
    80005c6c:	60ea                	ld	ra,152(sp)
    80005c6e:	644a                	ld	s0,144(sp)
    80005c70:	610d                	addi	sp,sp,160
    80005c72:	8082                	ret
    80005c74:	fffff097          	auipc	ra,0xfffff
    80005c78:	834080e7          	jalr	-1996(ra) # 800044a8 <end_op>
    80005c7c:	557d                	li	a0,-1
    80005c7e:	b7fd                	j	80005c6c <sys_mknod+0x6c>

0000000080005c80 <sys_chdir>:
    80005c80:	7135                	addi	sp,sp,-160
    80005c82:	ed06                	sd	ra,152(sp)
    80005c84:	e922                	sd	s0,144(sp)
    80005c86:	e526                	sd	s1,136(sp)
    80005c88:	e14a                	sd	s2,128(sp)
    80005c8a:	1100                	addi	s0,sp,160
    80005c8c:	ffffc097          	auipc	ra,0xffffc
    80005c90:	d20080e7          	jalr	-736(ra) # 800019ac <myproc>
    80005c94:	892a                	mv	s2,a0
    80005c96:	ffffe097          	auipc	ra,0xffffe
    80005c9a:	792080e7          	jalr	1938(ra) # 80004428 <begin_op>
    80005c9e:	08000613          	li	a2,128
    80005ca2:	f6040593          	addi	a1,s0,-160
    80005ca6:	4501                	li	a0,0
    80005ca8:	ffffd097          	auipc	ra,0xffffd
    80005cac:	268080e7          	jalr	616(ra) # 80002f10 <argstr>
    80005cb0:	04054b63          	bltz	a0,80005d06 <sys_chdir+0x86>
    80005cb4:	f6040513          	addi	a0,s0,-160
    80005cb8:	ffffe097          	auipc	ra,0xffffe
    80005cbc:	554080e7          	jalr	1364(ra) # 8000420c <namei>
    80005cc0:	84aa                	mv	s1,a0
    80005cc2:	c131                	beqz	a0,80005d06 <sys_chdir+0x86>
    80005cc4:	ffffe097          	auipc	ra,0xffffe
    80005cc8:	da2080e7          	jalr	-606(ra) # 80003a66 <ilock>
    80005ccc:	04449703          	lh	a4,68(s1)
    80005cd0:	4785                	li	a5,1
    80005cd2:	04f71063          	bne	a4,a5,80005d12 <sys_chdir+0x92>
    80005cd6:	8526                	mv	a0,s1
    80005cd8:	ffffe097          	auipc	ra,0xffffe
    80005cdc:	e50080e7          	jalr	-432(ra) # 80003b28 <iunlock>
    80005ce0:	15093503          	ld	a0,336(s2)
    80005ce4:	ffffe097          	auipc	ra,0xffffe
    80005ce8:	f3c080e7          	jalr	-196(ra) # 80003c20 <iput>
    80005cec:	ffffe097          	auipc	ra,0xffffe
    80005cf0:	7bc080e7          	jalr	1980(ra) # 800044a8 <end_op>
    80005cf4:	14993823          	sd	s1,336(s2)
    80005cf8:	4501                	li	a0,0
    80005cfa:	60ea                	ld	ra,152(sp)
    80005cfc:	644a                	ld	s0,144(sp)
    80005cfe:	64aa                	ld	s1,136(sp)
    80005d00:	690a                	ld	s2,128(sp)
    80005d02:	610d                	addi	sp,sp,160
    80005d04:	8082                	ret
    80005d06:	ffffe097          	auipc	ra,0xffffe
    80005d0a:	7a2080e7          	jalr	1954(ra) # 800044a8 <end_op>
    80005d0e:	557d                	li	a0,-1
    80005d10:	b7ed                	j	80005cfa <sys_chdir+0x7a>
    80005d12:	8526                	mv	a0,s1
    80005d14:	ffffe097          	auipc	ra,0xffffe
    80005d18:	fb4080e7          	jalr	-76(ra) # 80003cc8 <iunlockput>
    80005d1c:	ffffe097          	auipc	ra,0xffffe
    80005d20:	78c080e7          	jalr	1932(ra) # 800044a8 <end_op>
    80005d24:	557d                	li	a0,-1
    80005d26:	bfd1                	j	80005cfa <sys_chdir+0x7a>

0000000080005d28 <sys_exec>:
    80005d28:	7145                	addi	sp,sp,-464
    80005d2a:	e786                	sd	ra,456(sp)
    80005d2c:	e3a2                	sd	s0,448(sp)
    80005d2e:	ff26                	sd	s1,440(sp)
    80005d30:	fb4a                	sd	s2,432(sp)
    80005d32:	f74e                	sd	s3,424(sp)
    80005d34:	f352                	sd	s4,416(sp)
    80005d36:	ef56                	sd	s5,408(sp)
    80005d38:	0b80                	addi	s0,sp,464
    80005d3a:	e3840593          	addi	a1,s0,-456
    80005d3e:	4505                	li	a0,1
    80005d40:	ffffd097          	auipc	ra,0xffffd
    80005d44:	1b0080e7          	jalr	432(ra) # 80002ef0 <argaddr>
    80005d48:	08000613          	li	a2,128
    80005d4c:	f4040593          	addi	a1,s0,-192
    80005d50:	4501                	li	a0,0
    80005d52:	ffffd097          	auipc	ra,0xffffd
    80005d56:	1be080e7          	jalr	446(ra) # 80002f10 <argstr>
    80005d5a:	87aa                	mv	a5,a0
    80005d5c:	557d                	li	a0,-1
    80005d5e:	0c07c263          	bltz	a5,80005e22 <sys_exec+0xfa>
    80005d62:	10000613          	li	a2,256
    80005d66:	4581                	li	a1,0
    80005d68:	e4040513          	addi	a0,s0,-448
    80005d6c:	ffffb097          	auipc	ra,0xffffb
    80005d70:	f66080e7          	jalr	-154(ra) # 80000cd2 <memset>
    80005d74:	e4040493          	addi	s1,s0,-448
    80005d78:	89a6                	mv	s3,s1
    80005d7a:	4901                	li	s2,0
    80005d7c:	02000a13          	li	s4,32
    80005d80:	00090a9b          	sext.w	s5,s2
    80005d84:	00391793          	slli	a5,s2,0x3
    80005d88:	e3040593          	addi	a1,s0,-464
    80005d8c:	e3843503          	ld	a0,-456(s0)
    80005d90:	953e                	add	a0,a0,a5
    80005d92:	ffffd097          	auipc	ra,0xffffd
    80005d96:	0a0080e7          	jalr	160(ra) # 80002e32 <fetchaddr>
    80005d9a:	02054a63          	bltz	a0,80005dce <sys_exec+0xa6>
    80005d9e:	e3043783          	ld	a5,-464(s0)
    80005da2:	c3b9                	beqz	a5,80005de8 <sys_exec+0xc0>
    80005da4:	ffffb097          	auipc	ra,0xffffb
    80005da8:	d42080e7          	jalr	-702(ra) # 80000ae6 <kalloc>
    80005dac:	85aa                	mv	a1,a0
    80005dae:	00a9b023          	sd	a0,0(s3)
    80005db2:	cd11                	beqz	a0,80005dce <sys_exec+0xa6>
    80005db4:	6605                	lui	a2,0x1
    80005db6:	e3043503          	ld	a0,-464(s0)
    80005dba:	ffffd097          	auipc	ra,0xffffd
    80005dbe:	0ca080e7          	jalr	202(ra) # 80002e84 <fetchstr>
    80005dc2:	00054663          	bltz	a0,80005dce <sys_exec+0xa6>
    80005dc6:	0905                	addi	s2,s2,1
    80005dc8:	09a1                	addi	s3,s3,8
    80005dca:	fb491be3          	bne	s2,s4,80005d80 <sys_exec+0x58>
    80005dce:	10048913          	addi	s2,s1,256
    80005dd2:	6088                	ld	a0,0(s1)
    80005dd4:	c531                	beqz	a0,80005e20 <sys_exec+0xf8>
    80005dd6:	ffffb097          	auipc	ra,0xffffb
    80005dda:	c14080e7          	jalr	-1004(ra) # 800009ea <kfree>
    80005dde:	04a1                	addi	s1,s1,8
    80005de0:	ff2499e3          	bne	s1,s2,80005dd2 <sys_exec+0xaa>
    80005de4:	557d                	li	a0,-1
    80005de6:	a835                	j	80005e22 <sys_exec+0xfa>
    80005de8:	0a8e                	slli	s5,s5,0x3
    80005dea:	fc040793          	addi	a5,s0,-64
    80005dee:	9abe                	add	s5,s5,a5
    80005df0:	e80ab023          	sd	zero,-384(s5)
    80005df4:	e4040593          	addi	a1,s0,-448
    80005df8:	f4040513          	addi	a0,s0,-192
    80005dfc:	fffff097          	auipc	ra,0xfffff
    80005e00:	172080e7          	jalr	370(ra) # 80004f6e <exec>
    80005e04:	892a                	mv	s2,a0
    80005e06:	10048993          	addi	s3,s1,256
    80005e0a:	6088                	ld	a0,0(s1)
    80005e0c:	c901                	beqz	a0,80005e1c <sys_exec+0xf4>
    80005e0e:	ffffb097          	auipc	ra,0xffffb
    80005e12:	bdc080e7          	jalr	-1060(ra) # 800009ea <kfree>
    80005e16:	04a1                	addi	s1,s1,8
    80005e18:	ff3499e3          	bne	s1,s3,80005e0a <sys_exec+0xe2>
    80005e1c:	854a                	mv	a0,s2
    80005e1e:	a011                	j	80005e22 <sys_exec+0xfa>
    80005e20:	557d                	li	a0,-1
    80005e22:	60be                	ld	ra,456(sp)
    80005e24:	641e                	ld	s0,448(sp)
    80005e26:	74fa                	ld	s1,440(sp)
    80005e28:	795a                	ld	s2,432(sp)
    80005e2a:	79ba                	ld	s3,424(sp)
    80005e2c:	7a1a                	ld	s4,416(sp)
    80005e2e:	6afa                	ld	s5,408(sp)
    80005e30:	6179                	addi	sp,sp,464
    80005e32:	8082                	ret

0000000080005e34 <sys_pipe>:
    80005e34:	7139                	addi	sp,sp,-64
    80005e36:	fc06                	sd	ra,56(sp)
    80005e38:	f822                	sd	s0,48(sp)
    80005e3a:	f426                	sd	s1,40(sp)
    80005e3c:	0080                	addi	s0,sp,64
    80005e3e:	ffffc097          	auipc	ra,0xffffc
    80005e42:	b6e080e7          	jalr	-1170(ra) # 800019ac <myproc>
    80005e46:	84aa                	mv	s1,a0
    80005e48:	fd840593          	addi	a1,s0,-40
    80005e4c:	4501                	li	a0,0
    80005e4e:	ffffd097          	auipc	ra,0xffffd
    80005e52:	0a2080e7          	jalr	162(ra) # 80002ef0 <argaddr>
    80005e56:	fc840593          	addi	a1,s0,-56
    80005e5a:	fd040513          	addi	a0,s0,-48
    80005e5e:	fffff097          	auipc	ra,0xfffff
    80005e62:	dc6080e7          	jalr	-570(ra) # 80004c24 <pipealloc>
    80005e66:	57fd                	li	a5,-1
    80005e68:	0c054463          	bltz	a0,80005f30 <sys_pipe+0xfc>
    80005e6c:	fcf42223          	sw	a5,-60(s0)
    80005e70:	fd043503          	ld	a0,-48(s0)
    80005e74:	fffff097          	auipc	ra,0xfffff
    80005e78:	51a080e7          	jalr	1306(ra) # 8000538e <fdalloc>
    80005e7c:	fca42223          	sw	a0,-60(s0)
    80005e80:	08054b63          	bltz	a0,80005f16 <sys_pipe+0xe2>
    80005e84:	fc843503          	ld	a0,-56(s0)
    80005e88:	fffff097          	auipc	ra,0xfffff
    80005e8c:	506080e7          	jalr	1286(ra) # 8000538e <fdalloc>
    80005e90:	fca42023          	sw	a0,-64(s0)
    80005e94:	06054863          	bltz	a0,80005f04 <sys_pipe+0xd0>
    80005e98:	4691                	li	a3,4
    80005e9a:	fc440613          	addi	a2,s0,-60
    80005e9e:	fd843583          	ld	a1,-40(s0)
    80005ea2:	68a8                	ld	a0,80(s1)
    80005ea4:	ffffb097          	auipc	ra,0xffffb
    80005ea8:	7c4080e7          	jalr	1988(ra) # 80001668 <copyout>
    80005eac:	02054063          	bltz	a0,80005ecc <sys_pipe+0x98>
    80005eb0:	4691                	li	a3,4
    80005eb2:	fc040613          	addi	a2,s0,-64
    80005eb6:	fd843583          	ld	a1,-40(s0)
    80005eba:	0591                	addi	a1,a1,4
    80005ebc:	68a8                	ld	a0,80(s1)
    80005ebe:	ffffb097          	auipc	ra,0xffffb
    80005ec2:	7aa080e7          	jalr	1962(ra) # 80001668 <copyout>
    80005ec6:	4781                	li	a5,0
    80005ec8:	06055463          	bgez	a0,80005f30 <sys_pipe+0xfc>
    80005ecc:	fc442783          	lw	a5,-60(s0)
    80005ed0:	07e9                	addi	a5,a5,26
    80005ed2:	078e                	slli	a5,a5,0x3
    80005ed4:	97a6                	add	a5,a5,s1
    80005ed6:	0007b023          	sd	zero,0(a5)
    80005eda:	fc042503          	lw	a0,-64(s0)
    80005ede:	0569                	addi	a0,a0,26
    80005ee0:	050e                	slli	a0,a0,0x3
    80005ee2:	94aa                	add	s1,s1,a0
    80005ee4:	0004b023          	sd	zero,0(s1)
    80005ee8:	fd043503          	ld	a0,-48(s0)
    80005eec:	fffff097          	auipc	ra,0xfffff
    80005ef0:	a08080e7          	jalr	-1528(ra) # 800048f4 <fileclose>
    80005ef4:	fc843503          	ld	a0,-56(s0)
    80005ef8:	fffff097          	auipc	ra,0xfffff
    80005efc:	9fc080e7          	jalr	-1540(ra) # 800048f4 <fileclose>
    80005f00:	57fd                	li	a5,-1
    80005f02:	a03d                	j	80005f30 <sys_pipe+0xfc>
    80005f04:	fc442783          	lw	a5,-60(s0)
    80005f08:	0007c763          	bltz	a5,80005f16 <sys_pipe+0xe2>
    80005f0c:	07e9                	addi	a5,a5,26
    80005f0e:	078e                	slli	a5,a5,0x3
    80005f10:	94be                	add	s1,s1,a5
    80005f12:	0004b023          	sd	zero,0(s1)
    80005f16:	fd043503          	ld	a0,-48(s0)
    80005f1a:	fffff097          	auipc	ra,0xfffff
    80005f1e:	9da080e7          	jalr	-1574(ra) # 800048f4 <fileclose>
    80005f22:	fc843503          	ld	a0,-56(s0)
    80005f26:	fffff097          	auipc	ra,0xfffff
    80005f2a:	9ce080e7          	jalr	-1586(ra) # 800048f4 <fileclose>
    80005f2e:	57fd                	li	a5,-1
    80005f30:	853e                	mv	a0,a5
    80005f32:	70e2                	ld	ra,56(sp)
    80005f34:	7442                	ld	s0,48(sp)
    80005f36:	74a2                	ld	s1,40(sp)
    80005f38:	6121                	addi	sp,sp,64
    80005f3a:	8082                	ret
    80005f3c:	0000                	unimp
	...

0000000080005f40 <kernelvec>:
    80005f40:	7111                	addi	sp,sp,-256
    80005f42:	e006                	sd	ra,0(sp)
    80005f44:	e40a                	sd	sp,8(sp)
    80005f46:	e80e                	sd	gp,16(sp)
    80005f48:	ec12                	sd	tp,24(sp)
    80005f4a:	f016                	sd	t0,32(sp)
    80005f4c:	f41a                	sd	t1,40(sp)
    80005f4e:	f81e                	sd	t2,48(sp)
    80005f50:	fc22                	sd	s0,56(sp)
    80005f52:	e0a6                	sd	s1,64(sp)
    80005f54:	e4aa                	sd	a0,72(sp)
    80005f56:	e8ae                	sd	a1,80(sp)
    80005f58:	ecb2                	sd	a2,88(sp)
    80005f5a:	f0b6                	sd	a3,96(sp)
    80005f5c:	f4ba                	sd	a4,104(sp)
    80005f5e:	f8be                	sd	a5,112(sp)
    80005f60:	fcc2                	sd	a6,120(sp)
    80005f62:	e146                	sd	a7,128(sp)
    80005f64:	e54a                	sd	s2,136(sp)
    80005f66:	e94e                	sd	s3,144(sp)
    80005f68:	ed52                	sd	s4,152(sp)
    80005f6a:	f156                	sd	s5,160(sp)
    80005f6c:	f55a                	sd	s6,168(sp)
    80005f6e:	f95e                	sd	s7,176(sp)
    80005f70:	fd62                	sd	s8,184(sp)
    80005f72:	e1e6                	sd	s9,192(sp)
    80005f74:	e5ea                	sd	s10,200(sp)
    80005f76:	e9ee                	sd	s11,208(sp)
    80005f78:	edf2                	sd	t3,216(sp)
    80005f7a:	f1f6                	sd	t4,224(sp)
    80005f7c:	f5fa                	sd	t5,232(sp)
    80005f7e:	f9fe                	sd	t6,240(sp)
    80005f80:	d7ffc0ef          	jal	ra,80002cfe <kerneltrap>
    80005f84:	6082                	ld	ra,0(sp)
    80005f86:	6122                	ld	sp,8(sp)
    80005f88:	61c2                	ld	gp,16(sp)
    80005f8a:	7282                	ld	t0,32(sp)
    80005f8c:	7322                	ld	t1,40(sp)
    80005f8e:	73c2                	ld	t2,48(sp)
    80005f90:	7462                	ld	s0,56(sp)
    80005f92:	6486                	ld	s1,64(sp)
    80005f94:	6526                	ld	a0,72(sp)
    80005f96:	65c6                	ld	a1,80(sp)
    80005f98:	6666                	ld	a2,88(sp)
    80005f9a:	7686                	ld	a3,96(sp)
    80005f9c:	7726                	ld	a4,104(sp)
    80005f9e:	77c6                	ld	a5,112(sp)
    80005fa0:	7866                	ld	a6,120(sp)
    80005fa2:	688a                	ld	a7,128(sp)
    80005fa4:	692a                	ld	s2,136(sp)
    80005fa6:	69ca                	ld	s3,144(sp)
    80005fa8:	6a6a                	ld	s4,152(sp)
    80005faa:	7a8a                	ld	s5,160(sp)
    80005fac:	7b2a                	ld	s6,168(sp)
    80005fae:	7bca                	ld	s7,176(sp)
    80005fb0:	7c6a                	ld	s8,184(sp)
    80005fb2:	6c8e                	ld	s9,192(sp)
    80005fb4:	6d2e                	ld	s10,200(sp)
    80005fb6:	6dce                	ld	s11,208(sp)
    80005fb8:	6e6e                	ld	t3,216(sp)
    80005fba:	7e8e                	ld	t4,224(sp)
    80005fbc:	7f2e                	ld	t5,232(sp)
    80005fbe:	7fce                	ld	t6,240(sp)
    80005fc0:	6111                	addi	sp,sp,256
    80005fc2:	10200073          	sret
    80005fc6:	00000013          	nop
    80005fca:	00000013          	nop
    80005fce:	0001                	nop

0000000080005fd0 <timervec>:
    80005fd0:	34051573          	csrrw	a0,mscratch,a0
    80005fd4:	e10c                	sd	a1,0(a0)
    80005fd6:	e510                	sd	a2,8(a0)
    80005fd8:	e914                	sd	a3,16(a0)
    80005fda:	6d0c                	ld	a1,24(a0)
    80005fdc:	7110                	ld	a2,32(a0)
    80005fde:	6194                	ld	a3,0(a1)
    80005fe0:	96b2                	add	a3,a3,a2
    80005fe2:	e194                	sd	a3,0(a1)
    80005fe4:	4589                	li	a1,2
    80005fe6:	14459073          	csrw	sip,a1
    80005fea:	6914                	ld	a3,16(a0)
    80005fec:	6510                	ld	a2,8(a0)
    80005fee:	610c                	ld	a1,0(a0)
    80005ff0:	34051573          	csrrw	a0,mscratch,a0
    80005ff4:	30200073          	mret
	...

0000000080005ffa <plicinit>:
    80005ffa:	1141                	addi	sp,sp,-16
    80005ffc:	e422                	sd	s0,8(sp)
    80005ffe:	0800                	addi	s0,sp,16
    80006000:	0c0007b7          	lui	a5,0xc000
    80006004:	4705                	li	a4,1
    80006006:	d798                	sw	a4,40(a5)
    80006008:	c3d8                	sw	a4,4(a5)
    8000600a:	6422                	ld	s0,8(sp)
    8000600c:	0141                	addi	sp,sp,16
    8000600e:	8082                	ret

0000000080006010 <plicinithart>:
    80006010:	1141                	addi	sp,sp,-16
    80006012:	e406                	sd	ra,8(sp)
    80006014:	e022                	sd	s0,0(sp)
    80006016:	0800                	addi	s0,sp,16
    80006018:	ffffc097          	auipc	ra,0xffffc
    8000601c:	968080e7          	jalr	-1688(ra) # 80001980 <cpuid>
    80006020:	0085171b          	slliw	a4,a0,0x8
    80006024:	0c0027b7          	lui	a5,0xc002
    80006028:	97ba                	add	a5,a5,a4
    8000602a:	40200713          	li	a4,1026
    8000602e:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80006032:	00d5151b          	slliw	a0,a0,0xd
    80006036:	0c2017b7          	lui	a5,0xc201
    8000603a:	953e                	add	a0,a0,a5
    8000603c:	00052023          	sw	zero,0(a0)
    80006040:	60a2                	ld	ra,8(sp)
    80006042:	6402                	ld	s0,0(sp)
    80006044:	0141                	addi	sp,sp,16
    80006046:	8082                	ret

0000000080006048 <plic_claim>:
    80006048:	1141                	addi	sp,sp,-16
    8000604a:	e406                	sd	ra,8(sp)
    8000604c:	e022                	sd	s0,0(sp)
    8000604e:	0800                	addi	s0,sp,16
    80006050:	ffffc097          	auipc	ra,0xffffc
    80006054:	930080e7          	jalr	-1744(ra) # 80001980 <cpuid>
    80006058:	00d5179b          	slliw	a5,a0,0xd
    8000605c:	0c201537          	lui	a0,0xc201
    80006060:	953e                	add	a0,a0,a5
    80006062:	4148                	lw	a0,4(a0)
    80006064:	60a2                	ld	ra,8(sp)
    80006066:	6402                	ld	s0,0(sp)
    80006068:	0141                	addi	sp,sp,16
    8000606a:	8082                	ret

000000008000606c <plic_complete>:
    8000606c:	1101                	addi	sp,sp,-32
    8000606e:	ec06                	sd	ra,24(sp)
    80006070:	e822                	sd	s0,16(sp)
    80006072:	e426                	sd	s1,8(sp)
    80006074:	1000                	addi	s0,sp,32
    80006076:	84aa                	mv	s1,a0
    80006078:	ffffc097          	auipc	ra,0xffffc
    8000607c:	908080e7          	jalr	-1784(ra) # 80001980 <cpuid>
    80006080:	00d5151b          	slliw	a0,a0,0xd
    80006084:	0c2017b7          	lui	a5,0xc201
    80006088:	97aa                	add	a5,a5,a0
    8000608a:	c3c4                	sw	s1,4(a5)
    8000608c:	60e2                	ld	ra,24(sp)
    8000608e:	6442                	ld	s0,16(sp)
    80006090:	64a2                	ld	s1,8(sp)
    80006092:	6105                	addi	sp,sp,32
    80006094:	8082                	ret

0000000080006096 <free_desc>:
    80006096:	1141                	addi	sp,sp,-16
    80006098:	e406                	sd	ra,8(sp)
    8000609a:	e022                	sd	s0,0(sp)
    8000609c:	0800                	addi	s0,sp,16
    8000609e:	479d                	li	a5,7
    800060a0:	04a7cc63          	blt	a5,a0,800060f8 <free_desc+0x62>
    800060a4:	0001c797          	auipc	a5,0x1c
    800060a8:	b9c78793          	addi	a5,a5,-1124 # 80021c40 <disk>
    800060ac:	97aa                	add	a5,a5,a0
    800060ae:	0187c783          	lbu	a5,24(a5)
    800060b2:	ebb9                	bnez	a5,80006108 <free_desc+0x72>
    800060b4:	00451613          	slli	a2,a0,0x4
    800060b8:	0001c797          	auipc	a5,0x1c
    800060bc:	b8878793          	addi	a5,a5,-1144 # 80021c40 <disk>
    800060c0:	6394                	ld	a3,0(a5)
    800060c2:	96b2                	add	a3,a3,a2
    800060c4:	0006b023          	sd	zero,0(a3)
    800060c8:	6398                	ld	a4,0(a5)
    800060ca:	9732                	add	a4,a4,a2
    800060cc:	00072423          	sw	zero,8(a4)
    800060d0:	00071623          	sh	zero,12(a4)
    800060d4:	00071723          	sh	zero,14(a4)
    800060d8:	953e                	add	a0,a0,a5
    800060da:	4785                	li	a5,1
    800060dc:	00f50c23          	sb	a5,24(a0) # c201018 <_entry-0x73dfefe8>
    800060e0:	0001c517          	auipc	a0,0x1c
    800060e4:	b7850513          	addi	a0,a0,-1160 # 80021c58 <disk+0x18>
    800060e8:	ffffc097          	auipc	ra,0xffffc
    800060ec:	fd0080e7          	jalr	-48(ra) # 800020b8 <wakeup>
    800060f0:	60a2                	ld	ra,8(sp)
    800060f2:	6402                	ld	s0,0(sp)
    800060f4:	0141                	addi	sp,sp,16
    800060f6:	8082                	ret
    800060f8:	00002517          	auipc	a0,0x2
    800060fc:	68850513          	addi	a0,a0,1672 # 80008780 <syscalls+0x2f8>
    80006100:	ffffa097          	auipc	ra,0xffffa
    80006104:	43e080e7          	jalr	1086(ra) # 8000053e <panic>
    80006108:	00002517          	auipc	a0,0x2
    8000610c:	68850513          	addi	a0,a0,1672 # 80008790 <syscalls+0x308>
    80006110:	ffffa097          	auipc	ra,0xffffa
    80006114:	42e080e7          	jalr	1070(ra) # 8000053e <panic>

0000000080006118 <virtio_disk_init>:
    80006118:	1101                	addi	sp,sp,-32
    8000611a:	ec06                	sd	ra,24(sp)
    8000611c:	e822                	sd	s0,16(sp)
    8000611e:	e426                	sd	s1,8(sp)
    80006120:	e04a                	sd	s2,0(sp)
    80006122:	1000                	addi	s0,sp,32
    80006124:	00002597          	auipc	a1,0x2
    80006128:	67c58593          	addi	a1,a1,1660 # 800087a0 <syscalls+0x318>
    8000612c:	0001c517          	auipc	a0,0x1c
    80006130:	c3c50513          	addi	a0,a0,-964 # 80021d68 <disk+0x128>
    80006134:	ffffb097          	auipc	ra,0xffffb
    80006138:	a12080e7          	jalr	-1518(ra) # 80000b46 <initlock>
    8000613c:	100017b7          	lui	a5,0x10001
    80006140:	4398                	lw	a4,0(a5)
    80006142:	2701                	sext.w	a4,a4
    80006144:	747277b7          	lui	a5,0x74727
    80006148:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    8000614c:	14f71c63          	bne	a4,a5,800062a4 <virtio_disk_init+0x18c>
    80006150:	100017b7          	lui	a5,0x10001
    80006154:	43dc                	lw	a5,4(a5)
    80006156:	2781                	sext.w	a5,a5
    80006158:	4709                	li	a4,2
    8000615a:	14e79563          	bne	a5,a4,800062a4 <virtio_disk_init+0x18c>
    8000615e:	100017b7          	lui	a5,0x10001
    80006162:	479c                	lw	a5,8(a5)
    80006164:	2781                	sext.w	a5,a5
    80006166:	12e79f63          	bne	a5,a4,800062a4 <virtio_disk_init+0x18c>
    8000616a:	100017b7          	lui	a5,0x10001
    8000616e:	47d8                	lw	a4,12(a5)
    80006170:	2701                	sext.w	a4,a4
    80006172:	554d47b7          	lui	a5,0x554d4
    80006176:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    8000617a:	12f71563          	bne	a4,a5,800062a4 <virtio_disk_init+0x18c>
    8000617e:	100017b7          	lui	a5,0x10001
    80006182:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
    80006186:	4705                	li	a4,1
    80006188:	dbb8                	sw	a4,112(a5)
    8000618a:	470d                	li	a4,3
    8000618c:	dbb8                	sw	a4,112(a5)
    8000618e:	4b94                	lw	a3,16(a5)
    80006190:	c7ffe737          	lui	a4,0xc7ffe
    80006194:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fdc9df>
    80006198:	8f75                	and	a4,a4,a3
    8000619a:	2701                	sext.w	a4,a4
    8000619c:	d398                	sw	a4,32(a5)
    8000619e:	472d                	li	a4,11
    800061a0:	dbb8                	sw	a4,112(a5)
    800061a2:	5bbc                	lw	a5,112(a5)
    800061a4:	0007891b          	sext.w	s2,a5
    800061a8:	8ba1                	andi	a5,a5,8
    800061aa:	10078563          	beqz	a5,800062b4 <virtio_disk_init+0x19c>
    800061ae:	100017b7          	lui	a5,0x10001
    800061b2:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
    800061b6:	43fc                	lw	a5,68(a5)
    800061b8:	2781                	sext.w	a5,a5
    800061ba:	10079563          	bnez	a5,800062c4 <virtio_disk_init+0x1ac>
    800061be:	100017b7          	lui	a5,0x10001
    800061c2:	5bdc                	lw	a5,52(a5)
    800061c4:	2781                	sext.w	a5,a5
    800061c6:	10078763          	beqz	a5,800062d4 <virtio_disk_init+0x1bc>
    800061ca:	471d                	li	a4,7
    800061cc:	10f77c63          	bgeu	a4,a5,800062e4 <virtio_disk_init+0x1cc>
    800061d0:	ffffb097          	auipc	ra,0xffffb
    800061d4:	916080e7          	jalr	-1770(ra) # 80000ae6 <kalloc>
    800061d8:	0001c497          	auipc	s1,0x1c
    800061dc:	a6848493          	addi	s1,s1,-1432 # 80021c40 <disk>
    800061e0:	e088                	sd	a0,0(s1)
    800061e2:	ffffb097          	auipc	ra,0xffffb
    800061e6:	904080e7          	jalr	-1788(ra) # 80000ae6 <kalloc>
    800061ea:	e488                	sd	a0,8(s1)
    800061ec:	ffffb097          	auipc	ra,0xffffb
    800061f0:	8fa080e7          	jalr	-1798(ra) # 80000ae6 <kalloc>
    800061f4:	87aa                	mv	a5,a0
    800061f6:	e888                	sd	a0,16(s1)
    800061f8:	6088                	ld	a0,0(s1)
    800061fa:	cd6d                	beqz	a0,800062f4 <virtio_disk_init+0x1dc>
    800061fc:	0001c717          	auipc	a4,0x1c
    80006200:	a4c73703          	ld	a4,-1460(a4) # 80021c48 <disk+0x8>
    80006204:	cb65                	beqz	a4,800062f4 <virtio_disk_init+0x1dc>
    80006206:	c7fd                	beqz	a5,800062f4 <virtio_disk_init+0x1dc>
    80006208:	6605                	lui	a2,0x1
    8000620a:	4581                	li	a1,0
    8000620c:	ffffb097          	auipc	ra,0xffffb
    80006210:	ac6080e7          	jalr	-1338(ra) # 80000cd2 <memset>
    80006214:	0001c497          	auipc	s1,0x1c
    80006218:	a2c48493          	addi	s1,s1,-1492 # 80021c40 <disk>
    8000621c:	6605                	lui	a2,0x1
    8000621e:	4581                	li	a1,0
    80006220:	6488                	ld	a0,8(s1)
    80006222:	ffffb097          	auipc	ra,0xffffb
    80006226:	ab0080e7          	jalr	-1360(ra) # 80000cd2 <memset>
    8000622a:	6605                	lui	a2,0x1
    8000622c:	4581                	li	a1,0
    8000622e:	6888                	ld	a0,16(s1)
    80006230:	ffffb097          	auipc	ra,0xffffb
    80006234:	aa2080e7          	jalr	-1374(ra) # 80000cd2 <memset>
    80006238:	100017b7          	lui	a5,0x10001
    8000623c:	4721                	li	a4,8
    8000623e:	df98                	sw	a4,56(a5)
    80006240:	4098                	lw	a4,0(s1)
    80006242:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
    80006246:	40d8                	lw	a4,4(s1)
    80006248:	08e7a223          	sw	a4,132(a5)
    8000624c:	6498                	ld	a4,8(s1)
    8000624e:	0007069b          	sext.w	a3,a4
    80006252:	08d7a823          	sw	a3,144(a5)
    80006256:	9701                	srai	a4,a4,0x20
    80006258:	08e7aa23          	sw	a4,148(a5)
    8000625c:	6898                	ld	a4,16(s1)
    8000625e:	0007069b          	sext.w	a3,a4
    80006262:	0ad7a023          	sw	a3,160(a5)
    80006266:	9701                	srai	a4,a4,0x20
    80006268:	0ae7a223          	sw	a4,164(a5)
    8000626c:	4705                	li	a4,1
    8000626e:	c3f8                	sw	a4,68(a5)
    80006270:	00e48c23          	sb	a4,24(s1)
    80006274:	00e48ca3          	sb	a4,25(s1)
    80006278:	00e48d23          	sb	a4,26(s1)
    8000627c:	00e48da3          	sb	a4,27(s1)
    80006280:	00e48e23          	sb	a4,28(s1)
    80006284:	00e48ea3          	sb	a4,29(s1)
    80006288:	00e48f23          	sb	a4,30(s1)
    8000628c:	00e48fa3          	sb	a4,31(s1)
    80006290:	00496913          	ori	s2,s2,4
    80006294:	0727a823          	sw	s2,112(a5)
    80006298:	60e2                	ld	ra,24(sp)
    8000629a:	6442                	ld	s0,16(sp)
    8000629c:	64a2                	ld	s1,8(sp)
    8000629e:	6902                	ld	s2,0(sp)
    800062a0:	6105                	addi	sp,sp,32
    800062a2:	8082                	ret
    800062a4:	00002517          	auipc	a0,0x2
    800062a8:	50c50513          	addi	a0,a0,1292 # 800087b0 <syscalls+0x328>
    800062ac:	ffffa097          	auipc	ra,0xffffa
    800062b0:	292080e7          	jalr	658(ra) # 8000053e <panic>
    800062b4:	00002517          	auipc	a0,0x2
    800062b8:	51c50513          	addi	a0,a0,1308 # 800087d0 <syscalls+0x348>
    800062bc:	ffffa097          	auipc	ra,0xffffa
    800062c0:	282080e7          	jalr	642(ra) # 8000053e <panic>
    800062c4:	00002517          	auipc	a0,0x2
    800062c8:	52c50513          	addi	a0,a0,1324 # 800087f0 <syscalls+0x368>
    800062cc:	ffffa097          	auipc	ra,0xffffa
    800062d0:	272080e7          	jalr	626(ra) # 8000053e <panic>
    800062d4:	00002517          	auipc	a0,0x2
    800062d8:	53c50513          	addi	a0,a0,1340 # 80008810 <syscalls+0x388>
    800062dc:	ffffa097          	auipc	ra,0xffffa
    800062e0:	262080e7          	jalr	610(ra) # 8000053e <panic>
    800062e4:	00002517          	auipc	a0,0x2
    800062e8:	54c50513          	addi	a0,a0,1356 # 80008830 <syscalls+0x3a8>
    800062ec:	ffffa097          	auipc	ra,0xffffa
    800062f0:	252080e7          	jalr	594(ra) # 8000053e <panic>
    800062f4:	00002517          	auipc	a0,0x2
    800062f8:	55c50513          	addi	a0,a0,1372 # 80008850 <syscalls+0x3c8>
    800062fc:	ffffa097          	auipc	ra,0xffffa
    80006300:	242080e7          	jalr	578(ra) # 8000053e <panic>

0000000080006304 <virtio_disk_rw>:
    80006304:	7119                	addi	sp,sp,-128
    80006306:	fc86                	sd	ra,120(sp)
    80006308:	f8a2                	sd	s0,112(sp)
    8000630a:	f4a6                	sd	s1,104(sp)
    8000630c:	f0ca                	sd	s2,96(sp)
    8000630e:	ecce                	sd	s3,88(sp)
    80006310:	e8d2                	sd	s4,80(sp)
    80006312:	e4d6                	sd	s5,72(sp)
    80006314:	e0da                	sd	s6,64(sp)
    80006316:	fc5e                	sd	s7,56(sp)
    80006318:	f862                	sd	s8,48(sp)
    8000631a:	f466                	sd	s9,40(sp)
    8000631c:	f06a                	sd	s10,32(sp)
    8000631e:	ec6e                	sd	s11,24(sp)
    80006320:	0100                	addi	s0,sp,128
    80006322:	8aaa                	mv	s5,a0
    80006324:	8c2e                	mv	s8,a1
    80006326:	00c52d03          	lw	s10,12(a0)
    8000632a:	001d1d1b          	slliw	s10,s10,0x1
    8000632e:	1d02                	slli	s10,s10,0x20
    80006330:	020d5d13          	srli	s10,s10,0x20
    80006334:	0001c517          	auipc	a0,0x1c
    80006338:	a3450513          	addi	a0,a0,-1484 # 80021d68 <disk+0x128>
    8000633c:	ffffb097          	auipc	ra,0xffffb
    80006340:	89a080e7          	jalr	-1894(ra) # 80000bd6 <acquire>
    80006344:	4981                	li	s3,0
    80006346:	44a1                	li	s1,8
    80006348:	0001cb97          	auipc	s7,0x1c
    8000634c:	8f8b8b93          	addi	s7,s7,-1800 # 80021c40 <disk>
    80006350:	4b0d                	li	s6,3
    80006352:	0001cc97          	auipc	s9,0x1c
    80006356:	a16c8c93          	addi	s9,s9,-1514 # 80021d68 <disk+0x128>
    8000635a:	a08d                	j	800063bc <virtio_disk_rw+0xb8>
    8000635c:	00fb8733          	add	a4,s7,a5
    80006360:	00070c23          	sb	zero,24(a4)
    80006364:	c19c                	sw	a5,0(a1)
    80006366:	0207c563          	bltz	a5,80006390 <virtio_disk_rw+0x8c>
    8000636a:	2905                	addiw	s2,s2,1
    8000636c:	0611                	addi	a2,a2,4
    8000636e:	05690c63          	beq	s2,s6,800063c6 <virtio_disk_rw+0xc2>
    80006372:	85b2                	mv	a1,a2
    80006374:	0001c717          	auipc	a4,0x1c
    80006378:	8cc70713          	addi	a4,a4,-1844 # 80021c40 <disk>
    8000637c:	87ce                	mv	a5,s3
    8000637e:	01874683          	lbu	a3,24(a4)
    80006382:	fee9                	bnez	a3,8000635c <virtio_disk_rw+0x58>
    80006384:	2785                	addiw	a5,a5,1
    80006386:	0705                	addi	a4,a4,1
    80006388:	fe979be3          	bne	a5,s1,8000637e <virtio_disk_rw+0x7a>
    8000638c:	57fd                	li	a5,-1
    8000638e:	c19c                	sw	a5,0(a1)
    80006390:	01205d63          	blez	s2,800063aa <virtio_disk_rw+0xa6>
    80006394:	8dce                	mv	s11,s3
    80006396:	000a2503          	lw	a0,0(s4)
    8000639a:	00000097          	auipc	ra,0x0
    8000639e:	cfc080e7          	jalr	-772(ra) # 80006096 <free_desc>
    800063a2:	2d85                	addiw	s11,s11,1
    800063a4:	0a11                	addi	s4,s4,4
    800063a6:	ffb918e3          	bne	s2,s11,80006396 <virtio_disk_rw+0x92>
    800063aa:	85e6                	mv	a1,s9
    800063ac:	0001c517          	auipc	a0,0x1c
    800063b0:	8ac50513          	addi	a0,a0,-1876 # 80021c58 <disk+0x18>
    800063b4:	ffffc097          	auipc	ra,0xffffc
    800063b8:	ca0080e7          	jalr	-864(ra) # 80002054 <sleep>
    800063bc:	f8040a13          	addi	s4,s0,-128
    800063c0:	8652                	mv	a2,s4
    800063c2:	894e                	mv	s2,s3
    800063c4:	b77d                	j	80006372 <virtio_disk_rw+0x6e>
    800063c6:	f8042583          	lw	a1,-128(s0)
    800063ca:	00a58793          	addi	a5,a1,10
    800063ce:	0792                	slli	a5,a5,0x4
    800063d0:	0001c617          	auipc	a2,0x1c
    800063d4:	87060613          	addi	a2,a2,-1936 # 80021c40 <disk>
    800063d8:	00f60733          	add	a4,a2,a5
    800063dc:	018036b3          	snez	a3,s8
    800063e0:	c714                	sw	a3,8(a4)
    800063e2:	00072623          	sw	zero,12(a4)
    800063e6:	01a73823          	sd	s10,16(a4)
    800063ea:	f6078693          	addi	a3,a5,-160
    800063ee:	6218                	ld	a4,0(a2)
    800063f0:	9736                	add	a4,a4,a3
    800063f2:	00878513          	addi	a0,a5,8
    800063f6:	9532                	add	a0,a0,a2
    800063f8:	e308                	sd	a0,0(a4)
    800063fa:	6208                	ld	a0,0(a2)
    800063fc:	96aa                	add	a3,a3,a0
    800063fe:	4741                	li	a4,16
    80006400:	c698                	sw	a4,8(a3)
    80006402:	4705                	li	a4,1
    80006404:	00e69623          	sh	a4,12(a3)
    80006408:	f8442703          	lw	a4,-124(s0)
    8000640c:	00e69723          	sh	a4,14(a3)
    80006410:	0712                	slli	a4,a4,0x4
    80006412:	953a                	add	a0,a0,a4
    80006414:	058a8693          	addi	a3,s5,88
    80006418:	e114                	sd	a3,0(a0)
    8000641a:	6208                	ld	a0,0(a2)
    8000641c:	972a                	add	a4,a4,a0
    8000641e:	40000693          	li	a3,1024
    80006422:	c714                	sw	a3,8(a4)
    80006424:	001c3c13          	seqz	s8,s8
    80006428:	0c06                	slli	s8,s8,0x1
    8000642a:	001c6c13          	ori	s8,s8,1
    8000642e:	01871623          	sh	s8,12(a4)
    80006432:	f8842603          	lw	a2,-120(s0)
    80006436:	00c71723          	sh	a2,14(a4)
    8000643a:	0001c697          	auipc	a3,0x1c
    8000643e:	80668693          	addi	a3,a3,-2042 # 80021c40 <disk>
    80006442:	00258713          	addi	a4,a1,2
    80006446:	0712                	slli	a4,a4,0x4
    80006448:	9736                	add	a4,a4,a3
    8000644a:	587d                	li	a6,-1
    8000644c:	01070823          	sb	a6,16(a4)
    80006450:	0612                	slli	a2,a2,0x4
    80006452:	9532                	add	a0,a0,a2
    80006454:	f9078793          	addi	a5,a5,-112
    80006458:	97b6                	add	a5,a5,a3
    8000645a:	e11c                	sd	a5,0(a0)
    8000645c:	629c                	ld	a5,0(a3)
    8000645e:	97b2                	add	a5,a5,a2
    80006460:	4605                	li	a2,1
    80006462:	c790                	sw	a2,8(a5)
    80006464:	4509                	li	a0,2
    80006466:	00a79623          	sh	a0,12(a5)
    8000646a:	00079723          	sh	zero,14(a5)
    8000646e:	00caa223          	sw	a2,4(s5)
    80006472:	01573423          	sd	s5,8(a4)
    80006476:	6698                	ld	a4,8(a3)
    80006478:	00275783          	lhu	a5,2(a4)
    8000647c:	8b9d                	andi	a5,a5,7
    8000647e:	0786                	slli	a5,a5,0x1
    80006480:	97ba                	add	a5,a5,a4
    80006482:	00b79223          	sh	a1,4(a5)
    80006486:	0ff0000f          	fence
    8000648a:	6698                	ld	a4,8(a3)
    8000648c:	00275783          	lhu	a5,2(a4)
    80006490:	2785                	addiw	a5,a5,1
    80006492:	00f71123          	sh	a5,2(a4)
    80006496:	0ff0000f          	fence
    8000649a:	100017b7          	lui	a5,0x10001
    8000649e:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>
    800064a2:	004aa783          	lw	a5,4(s5)
    800064a6:	02c79163          	bne	a5,a2,800064c8 <virtio_disk_rw+0x1c4>
    800064aa:	0001c917          	auipc	s2,0x1c
    800064ae:	8be90913          	addi	s2,s2,-1858 # 80021d68 <disk+0x128>
    800064b2:	4485                	li	s1,1
    800064b4:	85ca                	mv	a1,s2
    800064b6:	8556                	mv	a0,s5
    800064b8:	ffffc097          	auipc	ra,0xffffc
    800064bc:	b9c080e7          	jalr	-1124(ra) # 80002054 <sleep>
    800064c0:	004aa783          	lw	a5,4(s5)
    800064c4:	fe9788e3          	beq	a5,s1,800064b4 <virtio_disk_rw+0x1b0>
    800064c8:	f8042903          	lw	s2,-128(s0)
    800064cc:	00290793          	addi	a5,s2,2
    800064d0:	00479713          	slli	a4,a5,0x4
    800064d4:	0001b797          	auipc	a5,0x1b
    800064d8:	76c78793          	addi	a5,a5,1900 # 80021c40 <disk>
    800064dc:	97ba                	add	a5,a5,a4
    800064de:	0007b423          	sd	zero,8(a5)
    800064e2:	0001b997          	auipc	s3,0x1b
    800064e6:	75e98993          	addi	s3,s3,1886 # 80021c40 <disk>
    800064ea:	00491713          	slli	a4,s2,0x4
    800064ee:	0009b783          	ld	a5,0(s3)
    800064f2:	97ba                	add	a5,a5,a4
    800064f4:	00c7d483          	lhu	s1,12(a5)
    800064f8:	854a                	mv	a0,s2
    800064fa:	00e7d903          	lhu	s2,14(a5)
    800064fe:	00000097          	auipc	ra,0x0
    80006502:	b98080e7          	jalr	-1128(ra) # 80006096 <free_desc>
    80006506:	8885                	andi	s1,s1,1
    80006508:	f0ed                	bnez	s1,800064ea <virtio_disk_rw+0x1e6>
    8000650a:	0001c517          	auipc	a0,0x1c
    8000650e:	85e50513          	addi	a0,a0,-1954 # 80021d68 <disk+0x128>
    80006512:	ffffa097          	auipc	ra,0xffffa
    80006516:	778080e7          	jalr	1912(ra) # 80000c8a <release>
    8000651a:	70e6                	ld	ra,120(sp)
    8000651c:	7446                	ld	s0,112(sp)
    8000651e:	74a6                	ld	s1,104(sp)
    80006520:	7906                	ld	s2,96(sp)
    80006522:	69e6                	ld	s3,88(sp)
    80006524:	6a46                	ld	s4,80(sp)
    80006526:	6aa6                	ld	s5,72(sp)
    80006528:	6b06                	ld	s6,64(sp)
    8000652a:	7be2                	ld	s7,56(sp)
    8000652c:	7c42                	ld	s8,48(sp)
    8000652e:	7ca2                	ld	s9,40(sp)
    80006530:	7d02                	ld	s10,32(sp)
    80006532:	6de2                	ld	s11,24(sp)
    80006534:	6109                	addi	sp,sp,128
    80006536:	8082                	ret

0000000080006538 <virtio_disk_intr>:
    80006538:	1101                	addi	sp,sp,-32
    8000653a:	ec06                	sd	ra,24(sp)
    8000653c:	e822                	sd	s0,16(sp)
    8000653e:	e426                	sd	s1,8(sp)
    80006540:	1000                	addi	s0,sp,32
    80006542:	0001b497          	auipc	s1,0x1b
    80006546:	6fe48493          	addi	s1,s1,1790 # 80021c40 <disk>
    8000654a:	0001c517          	auipc	a0,0x1c
    8000654e:	81e50513          	addi	a0,a0,-2018 # 80021d68 <disk+0x128>
    80006552:	ffffa097          	auipc	ra,0xffffa
    80006556:	684080e7          	jalr	1668(ra) # 80000bd6 <acquire>
    8000655a:	10001737          	lui	a4,0x10001
    8000655e:	533c                	lw	a5,96(a4)
    80006560:	8b8d                	andi	a5,a5,3
    80006562:	d37c                	sw	a5,100(a4)
    80006564:	0ff0000f          	fence
    80006568:	689c                	ld	a5,16(s1)
    8000656a:	0204d703          	lhu	a4,32(s1)
    8000656e:	0027d783          	lhu	a5,2(a5)
    80006572:	04f70863          	beq	a4,a5,800065c2 <virtio_disk_intr+0x8a>
    80006576:	0ff0000f          	fence
    8000657a:	6898                	ld	a4,16(s1)
    8000657c:	0204d783          	lhu	a5,32(s1)
    80006580:	8b9d                	andi	a5,a5,7
    80006582:	078e                	slli	a5,a5,0x3
    80006584:	97ba                	add	a5,a5,a4
    80006586:	43dc                	lw	a5,4(a5)
    80006588:	00278713          	addi	a4,a5,2
    8000658c:	0712                	slli	a4,a4,0x4
    8000658e:	9726                	add	a4,a4,s1
    80006590:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    80006594:	e721                	bnez	a4,800065dc <virtio_disk_intr+0xa4>
    80006596:	0789                	addi	a5,a5,2
    80006598:	0792                	slli	a5,a5,0x4
    8000659a:	97a6                	add	a5,a5,s1
    8000659c:	6788                	ld	a0,8(a5)
    8000659e:	00052223          	sw	zero,4(a0)
    800065a2:	ffffc097          	auipc	ra,0xffffc
    800065a6:	b16080e7          	jalr	-1258(ra) # 800020b8 <wakeup>
    800065aa:	0204d783          	lhu	a5,32(s1)
    800065ae:	2785                	addiw	a5,a5,1
    800065b0:	17c2                	slli	a5,a5,0x30
    800065b2:	93c1                	srli	a5,a5,0x30
    800065b4:	02f49023          	sh	a5,32(s1)
    800065b8:	6898                	ld	a4,16(s1)
    800065ba:	00275703          	lhu	a4,2(a4)
    800065be:	faf71ce3          	bne	a4,a5,80006576 <virtio_disk_intr+0x3e>
    800065c2:	0001b517          	auipc	a0,0x1b
    800065c6:	7a650513          	addi	a0,a0,1958 # 80021d68 <disk+0x128>
    800065ca:	ffffa097          	auipc	ra,0xffffa
    800065ce:	6c0080e7          	jalr	1728(ra) # 80000c8a <release>
    800065d2:	60e2                	ld	ra,24(sp)
    800065d4:	6442                	ld	s0,16(sp)
    800065d6:	64a2                	ld	s1,8(sp)
    800065d8:	6105                	addi	sp,sp,32
    800065da:	8082                	ret
    800065dc:	00002517          	auipc	a0,0x2
    800065e0:	28c50513          	addi	a0,a0,652 # 80008868 <syscalls+0x3e0>
    800065e4:	ffffa097          	auipc	ra,0xffffa
    800065e8:	f5a080e7          	jalr	-166(ra) # 8000053e <panic>
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
