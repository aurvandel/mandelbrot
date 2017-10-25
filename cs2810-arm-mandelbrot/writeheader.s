                .global writeHeader

                .text

		@ started with higher registers to avoid losing the values when itoa is called
		@ r4 = buffer
		@ r1 = x
		@ r6 = y
		@ r5 = length
		@ r4 = stratch

@ writeHeader(buffer, x, y) -> number of bytes written
writeHeader:
		@ rewrite code for new register values
		push {r4,r5,r6,lr}	@ don't push r1 it doesn't need to survive itoa call
		mov	r4, #'P'	@ put P in r4
		strb	r4, [r0, r3]	@ put r4 value in buffer
		add	r3, r3, #1	@ increment buffer counter
		
		@ write code to do the same thing for '3'
		
		@ write code to do the same thing for '\n'
		
		@ setup registers prior to calling itoa
		add r0, r4, r5		@ put buffer length in r0
		@ r1 is already xsize
		bl itoa			@ calls itao which returns number of bytes written
		add r5, r5, r0		@ add itoa return value(r0) to buffer length

		@ code to add space to buffer

		@ call itoa using the y value from r6 passed to r1

		@ code to add '\n\' to buffer

		@ code to pass 2, 5, 5 to buffer

		@ code to add '\n' to buffer
 
		@ code to return
		pop {r4,r5,r6,pc}
