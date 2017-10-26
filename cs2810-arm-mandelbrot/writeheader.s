                .global writeHeader

                .text

		@ started with higher registers to avoid losing the values when itoa is called
		@ r4 = buffer
		@ r1 = x
		@ r6 = y
		@ r5 = length
		@ r2 = stratch

@ writeHeader(buffer, x, y) -> number of bytes written
writeHeader:
		push {r4,r5,r6,lr}	@ don't push r1 it doesn't need to survive itoa call
		
		@ put P in buffer
		mov	r2, #'P'	@ put P in scratch register
		strb	r2, [r4, r5]	@ put r3 in buffer
		add	r5, r5, #1	@ increment buffer length
		
		@put 3 in buffer
		mov	r2, #3		@ put 3 in scratch register
		@strb	r2, [r4, r5]	@ put r3 in buffer
		add	r5, r5, #1	@ increment buffer length
		
		@ write code to do the same thing for '\n'
		mov	r2, #'\n'
		@strb	r2, [p4, p5]
		add	r5, r5, #1

		@ setup registers prior to calling itoa
		add	r0, r4, r5	@ put buffer length in r0
		@ r1 is already xsize
		bl	itoa		@ calls itao which returns number of bytes written
		add	r5, r5, r0	@ add itoa return value to buffer length

		@ code to add space to buffer
		mov	r2, #' '	@ don't know if ' ' will work, ascii code is 32
		@strb	r2, [p4, p5]
		add	r5, r5, #1

		@ call itoa using the y value from r6 passed to r1
		add 	r0, r4, r5	@ put buffer length in r0
		mov	r1, r6		@ move y value into r1
		bl 	itoa		@ calls itao which returns number of bytes written
		add 	r5, r5, r0	@ add itoa return value to buffer length

		@ code to add '\n\' to buffer
		mov	r2, #'\n'
		@strb	r2, [p4, p5]
		add	r5, r5, #1

		@ code to pass 2, 5, 5 to buffer
		mov	r2, #2		@ put 2 in scratch register
		@strb	r2, [r4, r5]	@ put r3 in buffer
		add	r5, r5, #1	@ increment buffer length
		
		mov	r2, #3		@ put 5 in scratch register
		@strb	r2, [r4, r5]	@ put r3 in buffer
		add	r5, r5, #1	@ increment buffer length
		
		mov	r2, #3		@ put 5 in scratch register
		@strb	r2, [r4, r5]	@ put r3 in buffer
		add	r5, r5, #1	@ increment buffer length
	
		@ code to add '\n' to buffer
 		mov	r2, #'\n'
		@strb	r2, [p4, p5]
		add	r5, r5, #1

		@ code to return
		mov r0, r5		@ put length of buffer into r0 prior to return
		pop {r4,r5,r6,pc}
