.section .init
.globl _start
_start:
	b main

.section .text
main:
	mov sp,#0x8000

	pinNum .req r0
	pinFunc .req r1
	mov pinNum,#16
	mov pinFunc,#1
	bl SetGpioFunction
	.unreq pinNum
	.unreq pinFunc

	ptrn .req r4
	ldr ptrn,=pattern
	ldr ptrn,[ptrn]
	seq .req r5
	mov seq,#0

	loop$:
	
	mov r0,#16
	mov r1,#1
	lsl r1,seq
	and r1,ptrn
	bl SetGpio
	
	/* Delay for 0.25 sec */
	ldr r0,=250000
	bl WaitTill

	add seq,#1
	and seq,#0b11111
	b loop$

.section .data
.align 2
pattern:
	.int 0b11111111101010100010001000101010






