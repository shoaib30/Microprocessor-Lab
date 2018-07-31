.text
.global start
start:

wait:
	swi 	0x202
	cmp	r0,#0
	beq 	wait
	ldr	r5,=zero
	ldr	r3,=nine
	mov	r1,#0
	cmp	r0,#1
	bgt	loop2

loop1:
	ldrb	r0,[r5]
	add	r1,r1,#1
	cmp	r1,#11
	beq	end
	swi	0x200
	add	r5,r5,#1
	bl	count
	b	loop1

loop2:
	ldrb	r0,[r3]
	add	r1,r1,#1
	cmp	r1,#11
	beq	end
	swi	0x200
	add	r3,r3,#1
	bl	count
	b	loop2

count:	mov	r4,#6400
count1:	cmp	r4,#0
	subgt	r4,r4,#1
	bgt	count1
	;swi	0x206
	mov	pc,lr

end:	
	b	wait

.data
	zero: .byte 0b11111101
	one: .byte 0b01110000
	two: .byte 0b11011110
	three: .byte 0b11111010
	four: .byte 0b01110011
	five: .byte 0b10111011
	six: .byte 0b10111111
	seven: .byte 0b11110000
	eight: .byte 0b11111111
	nine: .byte 0b11111011
