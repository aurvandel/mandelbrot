Reverse itoa
============

Write a function in ARM assembly language to convert an integer
value (non-negative) to text. The function should follow normal
calling conventions. The text produced will be in reverse order,
e.g., 138 will be written as "831".

The function is called `itoa` and takes two parameters. The first is
the address of a buffer in memory where the output should be
written. The second is the value to be written. The function should
return the number of bytes that were written. Note that it does NOT
print anything to the screen or make any system calls--it just
writes the ASCII representation of the number (in base 10) to the
buffer.

For example, if called with these parameters:

* r0: 0x121210
* r1: 397

The function should return 3 in r0 (because 397 is a 3-digit
number), and the following values should be in the given memory
locations:

* 0x121212: 55 (ASCII code for '7')
* 0x121211: 57 (ASCII code for '9')
* 0x121210: 51 (ASCII code for '3')

The code to implement this is given in class.


Testing
-------

To test your code as a standalone program, use the `_start` block
included in `start.s`. Change the value of the parameter to `itoa`
in that file to test it with different inputs. Note that the
`start.s` file will be ignored when unit tests are run for grading,
so you can modify it freely to perform additional tests.
