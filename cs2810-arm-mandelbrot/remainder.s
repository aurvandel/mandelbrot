                .global remainder

                .text

		@r0 = numerator
		@r1 = denominator
		@r2 = shift
		@r3 = numerator leading 0
		@r4 = denominator leading 0

@ remainder(numerator, denominator) -> remainder
remainder:
		push	{r4,lr}
    		cmp	r0, r1		@if n < d:
        	
		bne	1f		@if n = d put 0 in r0 and return
		mov	r0, #0
		pop	{r4,pc}
		
		bgt	1f		  
		pop	{r4,pc}		  @return n
		
1:
    		clz	r3, r0		@shift = (# leading zeros in d) - (# leading zeros in n)
		clz	r4, r1
		sub	r2, r4, r3
		b	3f		@goto while test
2:
    					@while shift >= 0:
        	cmp	r0, r1, lsl r2	  @if n >= d<<shift:
            	subge	r0, r0, r1, lsl r2    @n = n - d<<shift
        	sub	r2, r2, #1	  @shift = shift - 1
3:					@ while test
		cmp	r2, #0
		bge	2b		@loop if shift >= 0

		pop	{r4,pc}		@return n
