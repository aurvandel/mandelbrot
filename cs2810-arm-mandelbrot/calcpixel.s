                .global calcPixel
		.equ	neg_one, -1
                .text

		@d3 = 255.0 / 4.0
		@d0 = x
		@d1 = y

@ calcPixel(maxiters, col, row) -> rgb
calcPixel:
		push	{ip,lr}
		fldd	d3, constant	@setup d3 = 255.0 / 4
		fldd	d4, four
		fdivd	d3, d3, d4
					@assume 256x256
					@x = (col - 128) / (255.0 / 4.0)
		sub	r1, r1, #128	@r1 = col - 128
		vmov	s10, r1		@put r1 into s10
		fsitod	d0, s10		@convert s10 to float and put in d0
		fdivd	d0, d0, d3	
					@y = -(row - 128) / (255.0 / 4.0)
		sub	r2, r2, #128
		ldr	r3, =neg_one	
		mul	r2, r2, r3
		vmov	s10, r2
		fsitod	d1, s10
		fdivd	d1, d1, d3

		bl	mandel		@mandel(maxiters, x, y) --> iters

		bl	getColor

		pop	{ip,pc}

constant:	.double	255.0

four:		.double	4.0
