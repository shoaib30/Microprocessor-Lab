ldr 	r10,=a
mov	r1,#0
mov	r2,#9
mov	r3,#1

loop:
	cmp	r1,r2
	ldrge	r0,=notFound
	swige	0X02
	swige	0x11
	mov	r4,r1
	add	r4,r2,r4
	mov	r4,r4,LSR#1
	ldrb	r5,[r10,r4]
	cmp	r3,r5
	ldreq	r0,=found
	swieq	0x02
	swieq	0x11
	addgt 	r1,r4,#1
       	movlt 	r2,r4
	b loop

.data
a:.byte 1,2,3,4,5,6,7,8,9
found:.asciz	"Found"
notFound:.asciz	"not found"
.end	
	


