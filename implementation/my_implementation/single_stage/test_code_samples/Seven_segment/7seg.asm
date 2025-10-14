################################################################################
##                                                                            ##
##                             7 segment display                              ##
##                        Test four 7-segment displays                        ##
##                                                                            ##
################################################################################
# Save the values in registers that will be displayed later
addi  x1,  x0,   1     # x1 = 0x00000001
addi  x2,  x0,   8     # x2 = 0x00000008
addi  x3,  x0,   9     # x3 = 0x00000009
# Assign values to seven segment 1 display (units)
sw    x0,  247(x0)     # o_7segment_1 = b0111111
sw    x1,  247(x0)     # o_7segment_1 = b0000110
sw    x2,  247(x0)     # o_7segment_1 = b1111111
sw    x3,  247(x0)     # o_7segment_1 = b1101111
# Shift the stored values to create new ones
slli  x1,  x1,   8     # x1 = 0x00000100
slli  x2,  x2,   8     # x2 = 0x00000800
slli  x3,  x3,   8     # x3 = 0x00000900
# Assign values to seven segment 2 display (tens)
sw    x0,  247(x0)     # o_7segment_2 = b0111111
sw    x1,  247(x0)     # o_7segment_2 = b0000110
sw    x2,  247(x0)     # o_7segment_2 = b1111111
sw    x3,  247(x0)     # o_7segment_2 = b1101111
# Shift the stored values to create new ones
slli  x1,  x1,   8     # x1 = 0x00010000
slli  x2,  x2,   8     # x2 = 0x00080000
slli  x3,  x3,   8     # x3 = 0x00090000
# Assign values to seven segment 3 display (hundreds)
sw    x0,  247(x0)     # o_7segment_3 = b0111111
sw    x1,  247(x0)     # o_7segment_3 = b0000110
sw    x2,  247(x0)     # o_7segment_3 = b1111111
sw    x3,  247(x0)     # o_7segment_3 = b0111111
# Shift the stored values to create new ones
slli  x1,  x1,   8     # x1 = 0x01000000
slli  x2,  x2,   8     # x2 = 0x08000000
slli  x3,  x3,   8     # x3 = 0x09000000
# Assign values to seven segment 4 display (thousands)
sw    x0,  247(x0)     # o_7segment_4 = b0111111
sw    x1,  247(x0)     # o_7segment_4 = b0000110
sw    x2,  247(x0)     # o_7segment_4 = b1111111
sw    x3,  247(x0)     # o_7segment_4 = b1101111
