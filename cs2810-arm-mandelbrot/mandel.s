                .global mandel

                .text

		@d0 = x
		@d1 = y
		@d2 = a
		@d3 = b
		@d4 = a^2
		@d5 = b^2
		@d6 = a^2 + b^2
		@d7 = 4.0

@ mandel(maxiters, x, y) -> iters
mandel:
		fldd	d7, four	@load 4.0 into d7
		mov	r1, r0		@copy maxIterations to r1
		mov	r0, #1		@set r0 (number of iterations) to 1
		fcpyd	d2, d0		@copy x into a, and y into b
		fcpyd	d3, d1
1:					@forever loop:
		fcpyd	d4, d2			@compute a²  
		fmuld	d4, d4, d4
		fcpyd	d5, d3			@compute b²
		fmuld	d5, d5, d5
		fcpyd	d6, #0
		faddd	d6, d4, d5		@a² + b²
						@if a² + b² ≥ 4.0, return iterations(r0) (mov pc, lr)
		add	r0, r0, #1		@increment iteration count
		mov 	pc, lr			@if iterations > maxIterations, return 0
						@compute b = 2ab + y (this can be computed in-place, overwriting the old value of b)
						@compute a = a² - b² + x (this can be computed in-place, overwriting the old value of a; note that a² and b² are already computed)
		b	1b

four:		.double 4.0
