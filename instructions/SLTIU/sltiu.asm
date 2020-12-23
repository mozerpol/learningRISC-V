addi	x1, x0, 3 # set number 3 in x1
sltiu	x2, x1, 4 # compare number 4 with x1. 4 is greater than 3 so set 1 in x2
sltiu	x2, x1, -2048 # compare abs(-2048) with x1. abs(-2048) is greater than 3
                      # so set 1 in x2

