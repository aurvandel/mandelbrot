                .global filename, xsize, ysize, iters
                .data

filename:       .asciz  "fractal.ppm"

                .balign
xsize:          .word   8
ysize:          .word   1
iters:          .word   255
