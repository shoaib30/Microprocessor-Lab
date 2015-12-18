ldr 	r10,=a
mov	r1,#0 	;lower limit
mov	r2,#9	;upper limit
mov	r3,#1	;key to search

loop:
	cmp	r1,r2
	ldrgt	r0,=notFound
	swigt	0X02 	;printin wats in r0
	swigt	0x11	;terminating the program
	add 	r4,r1,r2
	mov		r4,r4,LSR#1
	ldrb	r5,[r10,r4]
	cmp		r3,r5
	ldreq	r0,=found
	swieq	0x02
	swieq	0x11
	addgt 	r1,r4,#1
    sublt 	r2,r4,#1
	b loop

.data
a:.byte 1,2,3,4,5,6,7,8,9
found:.asciz	"Found"
notFound:.asciz	"not found"
.end
