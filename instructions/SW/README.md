### SW
**SW** - store word, it's a pseudoinstruction. This instruction saves value from any register to any address in memory. he easiest way to explain how it works will be an example. Imagine this code:
``` assembly
sw x1, 0x20, x8
```
This instruction will be converted to:
``` assembly
sw x1 32(x8)
```
And means: take value from *x1* and write all eigth bytes of that value to memory address at *0x20*.
