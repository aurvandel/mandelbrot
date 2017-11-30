                .global getColor

                .text
		
		@r0 = iters
		
@ getColor(iters) -> rgb
getColor:
                push    {ip,lr}
                @ make sure the input is < 256
                and     r0, r0, #0xff

                @ special case if iters = 0
		cmp	r0, #0
		bne	1f
		ldr	r0, =black
		ldr	r0, [r0]
		pop	{ip,pc}

1:					@colorIndex = (iterations - 1) % palette_size
		sub	r0, r0, #1	@iters - 1 as n
		ldr	r1, =palette_size
		ldr	r1, [r1]
		bl	remainder
		
		@r0 = colorIndex
		ldr	r1, =palette
		ldrb	r2, [r1, r0, lsl #2]	@r2 = palette[colorIndex*4] 
		mov	r0, r2

                pop     {ip,pc}
