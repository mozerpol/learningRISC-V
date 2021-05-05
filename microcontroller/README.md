So far, in this repo I described a little bit about RISC-V, now it's time to implement my own MCU on PFGA. Unfortunately I am too inexperienced with FPGA, RISC-V and computer architecture, so for this reason I'll base my work on someone else's. <br/>
My help will be work of Rafał Kozik. [Here](https://gitlab.com/rysy_core/rysy_core) is the project page on gitlab. His project was released under the *BSD 3-clause license*. <br/>
Rafał Kozik named his processor *Rysy Core* and he implemented it using SystemVerilog language. I'll be different, I'll use Verilog ;p <br/>
Rysy Core is microcontroller core based on subset of RISC-V RV32I ISA (without SYSTEM instruction). <br/>
In this part of repo you can find my implementation in Verilog (*myOwnMPU_code* folder) and Rafał Kozik (*rysyCore_code* folder), which I downloaded directly from the project gitlab 05.05.2021. <br/>
In *alteraProject* folder I'll put everything what Quartus generated also with bitstream. 

Repository tree: <br/>
```
learningRISC-V
|___instructions
|   |___ADD
|   |___ADDI
|   |___ANDI
|     .
|     .
|     . 
|   |___SW
|___microcontroller
|   |___code   <--- you are here
|       |___alteraProject
|       |___myOwnMPU_code
|       |___rysyCore_code
|           |___code
|           |___core
|           |___documentation
|           |___peripheral
|           |___scripts
```

