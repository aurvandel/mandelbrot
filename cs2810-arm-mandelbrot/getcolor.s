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
		pop	{ip,pc}

1:					@colorIndex = (iterations - 1) % palette_size
		sub	r0, r0, #1	@iters - 1 as n
		ldr	r1, =palette_size
		bl	remainder
		
		@ use r0 as all three color channels
                @orr     r1, r0, r0, lsl #8
                @orr     r0, r1, r0, lsl #16
                pop     {ip,pc}
