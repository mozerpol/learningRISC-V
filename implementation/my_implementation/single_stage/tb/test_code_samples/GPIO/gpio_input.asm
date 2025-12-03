################################################################################
##                                                                            ##
##                                 GPIO input                                 ##
##                                                                            ##
################################################################################
# Introduce some delay
nop
nop
nop
nop
nop
# The lw command loads the value from GPIO into x1 register.
lw    x1,  255(x0)
