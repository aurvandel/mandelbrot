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

@ run() -> exit code
run:
		ldr	r0, =filename
		ldr	r1, =flags		@fd = open(filename, flags, mode)
		mov	r2, #mode
		mov	r7, #sys_open
		svc	#0
		
						@if fd < 0: return 1 (use the constant fail_open)

						@bufsize = writeHeader(buffer, xsize, ysize)
						@status = write(fd, buffer, bufsize)
						@if status < 0: return fail_writeheader

						@status = close(fd)
						@if status < 0: return fail_close

						@return 0 (success)

                .bss
buffer:         .space 64*1024
