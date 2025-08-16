# The machine code for these instructions below is in the file gpio_input.hex

# Introduce some delay
nop
nop
nop
nop
nop
# The lw command loads the value from GPIO into x1 register.
lw    x1,  255(x0)
