@ The code starting here is just to help you test mandel in a
@ standalone program. It is not part of the assignment.

                .global _start
                .equ    sys_exit, 1

                .text
_start:
                mov     r0, #11

                @ load the first test case below
                @ change these two lines to use a different test case
                fldd    d0, x4
                fldd    d1, y4
                bl      mandel

                @ exit system call
                @ use mandel's return value as the exit status code
                mov     r7, #sys_exit
                svc     #0

                @ this is the default test case
                @ test this first: mandel should return 2
x1:             .double -1.4
y1:             .double 1.4

                @ this is a test case inside the set
                @ test this second: mandel should return 0
x2:             .double -0.21
y2:             .double -0.62

                @ this is a test case near the edge
                @ test this third: mandel should return 68
x3:             .double 0.27
y3:             .double 0.61
		
		@failed test case on line 188, us 11 iterations
x4:		.double	-1.23
y4:		.double	-0.22

		@failed test case on line 200, 18 iterations
x5:		.double	-1.24
y5:		.double	-0.14

		@failed test case on line 212, 55 iterations
x6:		.double	0.35
y6:		.double	-0.42
