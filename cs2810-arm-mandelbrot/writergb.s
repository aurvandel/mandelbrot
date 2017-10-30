                .global writeRGB

                .text

		@ r4 = buffer
		@ r5 = length
		@ r1 = color
		@ r6 = new rgb

@ writeRGB(buffer, rgb) -> number of bytes written
writeRGB:
		push	{r4,r5,r6,lr}
		mov	r4, r0			@ set buffer to r4
		mov	r6, r1			@ put rgb in r6
		mov	r5, #0			@ length to 0

		@ put red value in buffer
		mov	r1, #0xff		@ set bits in r1 to 1
		and	r1, r1, r6, lsr #16	@ puts red in r1 and sets other bits to 0
		add	r0, r4, r5		@ setup buffer prior to calling itoa
		@ r1 is set to red value
		bl	itoa			@ call itoa returns number of bytes written
		add	r5, r5, r0		@ add itoa return to length

		@ add space to buffer
		mov	r1, #' '
		strb	r1, [r4, r5]
		add	r5, r5, #1

		@ put green value in buffer
		mov	r1, #0xff
		and	r1, r1, r6, lsr #8
		add	r0, r4, r5
		@ r1 is now green value
		bl	itoa
		add	r5, r5, r0

		# add space to buffer
		mov	r1, #' '
		strb	r1, [r4, r5]
		add	r5, r5, #1

		@ put blue value in buffer
		mov	r1, #0xff
		and	r1, r1, r6
		add	r0, r4, r5
		@ r1 is now blue value
		bl	itoa
		add	r5, r5, r0

		@ return
		mov	r0, r5		@ put length into r0
		pop	{r4,r5,r6,pc}
