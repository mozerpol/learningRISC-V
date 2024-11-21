# The machine code for these instructions below is in the file counter8bit.hex

addi  x1,  x0,   2     # Delay purposes, short loop
addi  x2,  x0,   0x212 # Delay purposes, long loop
addi  x3,  x0,   1     # 1 = turn on the timer, 0 = turn off and reset the timer
addi  x4,  x0,   0     # The value of x4 is compared to the value of x1, this
                       # works as a delay loop.
# Check the timer for one clock cycle
sb    x3,  251(x0)     # 1 = turn on the timer
sb    x0,  251(x0)     # 0 = turn off the timer
addi  x0,  x0,   0     # nop
addi  x0,  x0,   0     # nop
addi  x0,  x0,   0     # nop
# Check the timer for two clock cycles
sb    x3,  251(x0)     # 1 = turn on the timer
addi  x0,  x0,   0     # nop
addi  x0,  x0,   0     # nop
sb    x0,  251(x0)     # 0 = turn off the timer
addi  x0,  x0,   0     # nop
addi  x0,  x0,   0     # nop
addi  x0,  x0,   0     # nop
# Check the timer for 212 clock cycles
sb    x3,  251(x0)     # 1 = turn on the timer
loop27:
addi  x4,  x4,   1     # Long delay loop
bne   x4,  x2,   loop27# Is there enough delay?
sb    x0,  251(x0)     # 0 = turn off the timer
addi  x4,  x0,   0     # Reset delay loop
# Read the counter value and save it in the x5 register
sb    x3,  251(x0)     # 1 = turn on the timer
addi  x0,  x0,   0     # nop
addi  x0,  x0,   0     # nop
addi  x0,  x0,   0     # nop
lw    x5,  251(x0)     # Read the counter value and save it in the x5 register
sb    x0,  251(x0)     # 0 = turn off the timer
