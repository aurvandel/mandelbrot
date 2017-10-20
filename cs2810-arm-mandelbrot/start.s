@ The code in this file is just for testing purposes to help you make a
@ standalone program. It is not part of the assignment.

                .global _start
                .equ    stdout, 1
                .equ    sys_write, 4
                .equ    sys_exit, 1

                .bss
buffer:         .space  100

                .text
_start:
                @ call itoa
                ldr     r0, =buffer
                ldr     r1, =1357924680
                bl      itoa

                @ write the buffer to stdout
                @ you should see 0864297531 printed to stdout
                mov     r2, r0
                mov     r0, #stdout
                ldr     r1, =buffer
                mov     r7, #sys_write
                svc     #0

                @ exit system call
                mov     r0, #0
                mov     r7, #sys_exit
                svc     #0
