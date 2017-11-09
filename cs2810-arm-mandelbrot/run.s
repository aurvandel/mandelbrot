                .global run

                .equ    flags, 577
                .equ    mode, 0644

                .equ    sys_write, 4
                .equ    sys_open, 5
                .equ    sys_close, 6

                .equ    fail_open, 1
                .equ    fail_writeheader, 2
                .equ    fail_writerow, 3
                .equ    fail_close, 4

                .text
		
		@r4 = fd
		@r5 = bufsize
		@r8 = col
		
@ run() -> exit code
run:
		push	{r4,r5,r7,r8,r9,r10,r11,lr}
		ldr	r0, =filename
		ldr	r1, =flags		@fd = open(filename, flags, mode)
		ldr	r2, =mode
		mov	r7, #sys_open
		svc	#0
		mov	r4, r0

		cmp	r0, #0			@if fd < 0: return 1 (use the constant fail_open)
		bge	1f
		
		mov	r0, #fail_open
		pop	{r4,r5,r7,r8,r9,r10,r11,pc}
1:
		ldr	r0, =buffer		@bufsize = writeHeader(buffer, xsize, ysize)
		ldr	r1, =xsize		@loads address of xsize
		ldr	r1, [r1]		@converts address to variables value
		ldr	r2, =ysize
		ldr	r2, [r2]
		bl	writeHeader
		
		mov	r2, r0			@status = write(fd, buffer, bufsize)
		ldr	r1, =buffer
		mov	r0, r4
		mov	r7, #sys_write
		svc	#0
		
		cmp	r0, #0			@if status < 0: return fail_writeheader
		bge	2f

		mov	r0, #fail_writeheader
		pop	{r4,r5,r7,r8,r9,r10,r11,pc}

2:		@setup for row loop
		ldr	r10, =ysize		@ysize is upper limit
		ldr	r10, [r10]
		mov	r11, #0			@r11 is row tracker
		b	6f			@goto row test

3:		@setup for column loop
		mov	r5, #0			@length = 0
		mov	r8, #0			@column = 0
		ldr	r9, =xsize		@limit of column loop is xsize
		ldr	r9, [r9]
		b	5f			@goto column test

4:						@for column from 0 to xsize inclusive:
		mov	r1, #0			@clear r1
		mov	r2, #0
		ldr	r0, =buffer
		add	r1, r8, lsl #8		@color = column << 8   @ color = column shifted left 8 bits
    		add	r2, r11, lsl #16	@color = row << 16
		add	r1, r1, r2		@color = row << 16 + column << 8 
		add	r0, r0, r5		@bufsize += writeRGB(buffer+bufsize, color)
		bl	writeRGB
		add	r5, r5, r0
    		
		mov	r1, #' '		@buffer[bufsize] = ' '
		ldr	r0, =buffer
		strb	r1, [r0, r5]
   		add	r8, r8, #1		@column += 1						
		add	r5, r5, #1		@bufsize += 1
5:						@column test
		cmp	r8, r9
		blt	4b

		@runs after column loop before the end of the row loop
		mov	r1, #'\n'
		sub	r2, r5, #1		@buffer[bufsize-1] = '\n'  @ replace last space with a newline
		strb	r1, [r0, r2]
					
		mov	r1, r0			@status = write(fd, buffer, bufsize)
		mov	r0, r4
		mov	r2, r5
		mov	r7, #sys_write
		svc	#0
		add	r11, r11, #1
		cmp	r0, #0			@if status < 0: return fail_writerow
		bge	6f
		
		mov	r0, #fail_writerow
		pop	{r4,r5,r7,r8,r9,r10,r11,pc}				
6:						@row test
		cmp	r11, r10
		blt	3b			@if less than go back to row loop
7:		
		mov	r0, r4			@status = close(fd)
		mov	r7, #sys_close
		svc	#0
		
		cmp	r0, #0			@if status < 0: return fail_close
		bge	8f

		mov	r0, #fail_close
		pop	{r4,r5,r7,r8,r9,r10,r11,pc}
8:
		mov	r0, #0			@return 0 (success)
		pop	{r4,r5,r7,r8,r9,r10,r11,pc}
  
		.bss
buffer:         .space 64*1024
