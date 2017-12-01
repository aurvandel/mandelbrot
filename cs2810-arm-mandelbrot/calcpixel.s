                .global calcPixel
		@.equ	neg_one, -1
                .text

		@r0 = iters
		@r1 = col
		@r2 = row
		@r3 = xsize
		@r4 = ysize
		@r5 = minsize
		
		@d0 = xcenter		s0,s1
		@d1 = ycenter		s2,s3
		@d2 = magnification	s4,s5
		@d3 = 2.0		s6,s7
		@d4 = xsize/2.0		s8,s9
		@d5 = ysize/2.0		s10,s11
		@d6 = mag * minsize-1	s12,s13
		@d7 = col - d4		s14,s15
		@d8 = row - d5		s16,s17
		
		@x = xcenter + (column - xsize/2.0) / (magnification * (minsize - 1))
		@y = ycenter - (row - ysize/2.0) / (magnification * (minsize - 1))
		
@calcPixel(int(maxiters, column, row, xsize, ysize), float(xcenter, ycenter, magnification))→rgb
calcPixel:

		push	{r4,r5,r6,lr}
		ldr	r4, [sp, #8]	@retrieve ysize from stack
		fldd	d3, two
		
		@find minsize
		cmp	r3, r4		
		movle	r3, r5
		movgt	r4, r5
		
		@calculate denominators (magnification * (minsize - 1)
		sub	r5, r5, #1	@r5 = minsize -1
		vmov	s13, r5		@copy minsize -1 to s13
		fsitod	d6, s13		@convert int in s13 to float
		fmuld	d6, d6, d2	@d6 = mag * (minsize - 1)

		@convert xsize to float / 2.0
		vmov	s9, r3		
		fsitod	d4, s9
		fdivd	d4, d4, d3
		
		@convert ysize to float / 2.0
		vmov	s11, r4		
		fsitod	d5, s11
		fdivd	d5, d5, d3	
		
		@convert col(r1) to float - d4
		vmov	s15, r1
		fsitod	d7, s15
		fsubd	d7, d7, d4
		
		@convert row(r2) to float - d5
		vmov	s17, r2
		fsitod	d8, s17
		fsubd	d8, d8, d5
		
		@xcenter + d7
		faddd	d0, d0, d7
		
		@ycenter - d8
		fsubd	d1, d1, d8
		
		bl	mandel		@mandel(maxiters, x, y) --> iters

		bl	getColor
		
		pop	{r4,r5,r6,pc}
		
two:		.double	2.0
