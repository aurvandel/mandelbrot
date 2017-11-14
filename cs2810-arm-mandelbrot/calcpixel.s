                .global calcPixel

                .text

		@d3 = 255.0 / 4.0
		@d4 = x
		@d5 = y

@ calcPixel(maxiters, col, row) -> rgb
calcPixel:

		fldd	d3, 255		@setup d3 = 255.0 / 4
		fldd	d4, four
		fdivd	d3, d3, d4
					@assume 256x256
					@x = (col - 128) / (255.0 / 4.0)
		sub	r1, r1, #128	@r1 = col - 128
		
					@y = -(row - 128) / (255.0 / 4.0)

255:		.double	255.0

four:		.double	4.0
