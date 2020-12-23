### J
**J** - jump and don't link. `J` is pseudoinstruction. `J` is similar to `JAL`, but in `JAL` instruction we can select in which register we want save program counter status. In 'J' instruction it is impossible, because our register is *x0*. <br/>
`J` under this instruction is: `jal x0, offset`.
I think that the easiest way to understand how the instruction works will be an example:
```assembly
loop:
    addi 	x5, x5, 1
    addi 	x5, x5, 1
j loop
```
The above code is equivalent:
```assembly
loop:
    addi 	x5, x5, 1
    addi 	x5, x5, 1
jal x0, loop
```
