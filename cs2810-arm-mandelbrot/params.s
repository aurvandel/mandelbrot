                .global filename
                .global xcenter, ycenter, mag
                .global xsize, ysize, iters, antialias

                .data
filename:       .asciz  "fractal.ppm"

                .balign 8
xcenter:        .double -0.743643135
ycenter:        .double 0.131825963
mag:            .double 91152.0
xsize:          .word   1980
ysize:          .word   1024
iters:          .word   1000
