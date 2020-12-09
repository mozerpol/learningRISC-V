# learningRISC-V
![logo](https://riscv.org/wp-content/uploads/2018/06/RISC-V-Logo-2.png)
_________________
In this project I'll put everything related to RISC-V. I learn this technology from scratch, so there may be a lot of simple things. I hope to avoid mistakes due to being inexperienced.

### Useful links:

1. Very important tutorial for me. Why? Because it's in my mother language and I had easy access to it :) This tutorial has four parts. The first two describe what a RISC-V is, the basics of assembly language and how instructions work. The third part is discussed how to write own siple soft core using SystemVerilog language. The last part is describe implementation RISC-V on FPGA board (based on MAX10). This tutorial was published in the *Elektronika Praktyczna* magazine. Fortunately, however, the first part is available online for free:

    [08.12.2020] https://ep.com.pl/podzespoly/12992-risc-v-budujemy-wlasny-mikrokontroler-1

    The second part of the course is available in the issue from: 10.2019, pages 116-123/140

    The third part of the course is available in the issue from: 11.2019, pages 131-137/140

    The last part part (fourth) of the course is available in the issue from: 12.2019, pages 123-124/140
2.

#### Simulator
For learning assembly language, I highly recommend using this simulator:
[08.12.2020] https://www.kvakil.me/venus/
This simulator has two parts:
- Editor - here we can write our code
When you click "Simulator" the code will be compiled[?] automatically.
- Simulator - here you can test the code and check the results
In `Editor`  part I entered the code:
```
addi x1, x1, 0x1
addi x2, x1, 0x1
```
In the screenshot, you can see at the top `Editor` and `Simulator`. 
![venus](https://user-images.githubusercontent.com/43972902/101664067-b34c1c80-3a4b-11eb-83a7-e17bc51d1271.png)
If you click `Run`  all code will be executed. In this case, the x1 and x2 registers will change:
![venus_memory](https://user-images.githubusercontent.com/43972902/101665262-0e324380-3a4d-11eb-80f6-ef268bbe9608.png)
If you click `Reset`, the effect will be the same as a page refresh [?]. 
`Step` is of course next code line, `Prev` means previous code line. 
If you click `Dump` then at the bottom of the page in the` console output` field will appear machine code, that is executed by the processor.
```
00108093
00108113
```







