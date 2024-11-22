# The machine code for these instructions below is in the file gpio_input.hex

addi  x1,  x0,   1     # i_gpio[0] = key
addi  x2,  x0,   2     # o_gpio[1] = LED 
# addi  x2,  x0,   4     # o_gpio[2] = LED
# addi  x2,  x0,   8     # o_gpio[3] = LED
# addi  x2,  x0,   16    # o_gpio[4] = LED

# Wait until GPIO[0] = 0, the lw command loads the value from GPIO[0] into x1,
# and the bne command compares x1 with x0.
loop:
lw    x1,  255(x0)
bne   x1,  x0    loop

# Set high state on o_gpio[1]
sb    x2,  255(x0)
