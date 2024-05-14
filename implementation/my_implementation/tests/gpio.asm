##############
##   asdf    ##
##############
addi  x1,  x0,   0     # The value x1 is assigned to GPIO
addi  x2,  x0,   15    # The value x1 is compared to the value of x2. 15 = 1111
addi  x3,  x0,   0     # The value of x3 is compared to the value of x4, this
# works as a delay loop. The x3 is incremented if is not equal x4
lui   x4,  244
addi  x4,  x4,   576   # F4240 = 1000000
loop2:
addi  x1,  x1,   1
sb    x1,  0(x0)       # Assign the value of x1 to GPIO
loop1:
addi  x3,  x3,   1     # Delay loop
bne   x3,  x4,   loop1 # Is there enough delay?
addi  x3,  x0,   0     # Yes, reset delay counter
bne   x1,  x2,   loop2 # Were all the GPIOs on? If not go to loop2
# Yes, all the GPIOs were turn on, reset all counters
addi  x1,  x0,   0
addi  x3,  x0,   0
