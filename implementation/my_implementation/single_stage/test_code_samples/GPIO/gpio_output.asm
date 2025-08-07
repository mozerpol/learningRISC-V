# The machine code for these instructions below is in the file gpio_output.hex

# Check operation for four GPIO ports
# gpio[0] = LED
# gpio[1] = LED
# gpio[2] = LED
# gpio[3] = LED

addi  x1,  x0,   0     # The value x1 is assigned to GPIO
addi  x2,  x0,   15    # The value x1 is compared to the value of x2. 15 = 1111
addi  x3,  x0,   0     # The value of x3 is compared to the value of x4, this
# works as a delay loop. The x3 is incremented if is not equal x4
lui   x4,  0x3D0
addi  x4,  x4,   2047
addi  x4,  x4,   257   # 3D0900 = 4000000, x4 is compared with x3. For 40 MHz it
# is about 1 sec delay

loop2:
addi  x1,  x1,   1     # Increment x1
sb    x1,  255(x0)     # Assign the value of x1 to GPIO
loop1:
addi  x3,  x3,   1     # Increment x3
bne   x3,  x4,   loop1 # Is there enough delay? No: go to loop1
addi  x3,  x0,   0     # Yes: reset delay counter
bne   x1,  x2,   loop2 # Were all the GPIOs on? No: go to loop2
# Yes: all the GPIOs were turn on, reset all counters
addi  x1,  x0,   0
addi  x3,  x0,   0
