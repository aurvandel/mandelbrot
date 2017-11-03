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
		
@ run() -> exit code
run:
		push	{r4,r5,r7,lr}
		ldr	r0, =filename
		ldr	r1, =flags		@fd = open(filename, flags, mode)
		ldr	r2, =mode
		mov	r7, #sys_open
		svc	#0
		mov	r4, r0

		cmp	r0, #0			@if fd < 0: return 1 (use the constant fail_open)
		bge	1f
		
		mov	r0, #fail_open
		pop	{r4,r5,r7,pc}
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
		pop	{r4,r5,r7,pc}
2:		
		mov	r0, r4			@status = close(fd)
		mov	r7, #sys_close
		svc	#0
		
		cmp	r0, #0			@if status < 0: return fail_close
		bge	3f

		mov	r0, #fail_close
		pop	{r4,r5,r7,pc}
3:
		mov	r0, #0			@return 0 (success)
		pop	{r4,r5,r7,pc}
  
		.bss
buffer:         .space 64*1024
