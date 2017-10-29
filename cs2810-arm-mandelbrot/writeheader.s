                .global writeHeader

                .text

		@ started with higher registers to avoid losing the values when itoa is called
		@ r4 = buffer
		@ r1 = x
		@ r6 = y
		@ r5 = length
		@ r3 = stratch

@ writeHeader(buffer, x, y) -> number of bytes written
writeHeader:
		push	{r4,r5,r6,lr}	@ don't push r1 it doesn't need to survive itoa call
		mov	r5, #0		@ initilize length to 0
		mov	r4, r0		@ initilize buffer to r4
		mov	r6, r2		@ put y value in r6
	
		@ put P in buffer
		mov	r3, #'P'	@ put P in scratch register
		strb	r3, [r4, r5]	@ put r3 in buffer
		add	r5, r5, #1	@ increment buffer length
		
		@ put 3 in buffer
		mov    r3, #'3'		@ put 3 in scratch register
		strb   r3, [r4, r5]   	@ put r3 in buffer
		add    r5, r5, #1     	@ increment buffer length
                
		@ write code to do the same thing for '\n'
		mov    r3, #'\n'
		strb   r3, [r4, r5]
		add    r5, r5, #1

		@ setup registers prior to calling itoa
		add    r0, r4, r5     	@ put buffer length in r0
		@r1 is already xsize
		bl     itoa           	@ calls itao which returns number of bytes written
		add    r5, r5, r0     	@ add itoa return value to buffer length

		@ code to add space to buffer
		mov    r3, #' '
		strb   r3, [r4, r5]
		add    r5, r5, #1

		@ call itoa using the y value from r6 passed to r1
		add    r0, r4, r5    	@ put buffer length in r0
		mov    r1, r6        	@ move y value into r1
		bl     itoa          	@ calls itao which returns number of bytes written
		add    r5, r5, r0    	@ add itoa return value to buffer length

		@ code to add '\n\' to buffer
		mov    r3, #'\n'
		strb   r3, [r4, r5]
		add    r5, r5, #1

		@ code to pass 2, 5, 5 to buffer
		mov    r3, #'2'     	@ put 2 in scratch register
		strb   r3, [r4, r5]   	@ put r3 in buffer
		add    r5, r5, #1     	@ increment buffer length
                
		mov    r3, #'5'      	@ put 5 in scratch register
		strb   r3, [r4, r5]   	@ put r3 in buffer
		add    r5, r5, #1     	@ increment buffer length
                
		mov    r3, #'5'     	@ put 5 in scratch register
		strb   r3, [r4, r5]   	@ put r3 in buffer
		add    r5, r5, #1     	@ increment buffer length
      
		@ code to add '\n' to buffer
		mov    r3, #'\n'
		strb   r3, [r4, r5]
		add    r5, r5, #1

		@ code to return
		mov     r0, r5     	@ put length of buffer into r0 prior to return
		pop     {r4,r5,r6,pc}
