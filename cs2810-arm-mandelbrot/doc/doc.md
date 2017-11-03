Create a file with one row of pixels
====================================

In this step you will change your `run` function to write a single
row of pixels to the output file in addition to the header that you
wrote earlier.


What to write
-------------

For this first step, you will create a file, write a header to it,
generate a single row of pixels with a gradient pattern, write it to
the file, close the file, and then return.

Your code should implement this pseudo-code:

```
fd = open("fractal.ppm", flags, mode)
if fd < 0: return fail_open

bufsize = writeHeader(buffer, xsize, ysize)
status = write(fd, buffer, bufsize)
if status < 0: return fail_writeheader

bufsize = 0
for column from 0 to xsize-1 inclusive:
    color = column << 8   @ color = column shifted left 8 bits
    bufsize += writeRGB(buffer+bufsize, color)
    buffer[bufsize] = ' '
    bufsize += 1
buffer[bufsize-1] = '\n'  @ replace last space with a newline
status = write(fd, buffer, bufsize)
if status < 0: return fail_writerow

status = close(fd)
if status < 0: return fail_close

return 0 (success)
```
