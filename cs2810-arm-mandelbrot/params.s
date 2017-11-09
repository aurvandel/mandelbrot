                .global filename, xsize, ysize, iters
                .data

filename:       .asciz  "fractal.ppm"

                .balign
xsize:          .word   8
ysize:          .word   8
iters:          .word   255
