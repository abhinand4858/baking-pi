.globl GetTimerBaseAddr
GetTimerBaseAddr:
	ldr r0,=0x20003000
	mov pc, lr

.globl GetTime
GetTime:
	push {lr}
	bl GetTimerBaseAddr
	ldrd r0,r1,[r0,#4]
	pop {pc}

.globl WaitTill
WaitTill:
	delay .req r2
	mov delay, r0
	push {lr}
	bl GetTime
	start .req r3
	mov start, r0

	loop$:
		bl GetTime
		elap .req r1
		sub elap, r0, start
		cmp elap, delay
		.unreq elap
		bls loop$

	.unreq delay
	.unreq start
	pop {pc}
