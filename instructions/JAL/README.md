### JAL
**JAL** - jump and link. <br/>
JAL perform jump to the selected adress and save in chosen register how many steps you want to go back. I think that the easiest way to understand how the instruction works will be an example:
``` assembly
loop:
	addi 	x5, x5, 1
    addi 	x5, x5, 1
jal 	x4, loop
```
