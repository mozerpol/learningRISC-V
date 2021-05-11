In this file I will explain how the code written in SystemVerilog by Rafal Kozik works and I'll try translate it to Verilog language. Core written in SystemVerilog you can find in `learningRISC-V/implementation/rysyCore_code/code/` the author is Rafal Kozik and [here](https://gitlab.com/rysy_core/rysy_core) is the project page on gitlab.
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
|___implementation
|   |___alteraProject
|   |___myOwnMPU_code
|   |___rysyCore_code
|       |___code
|       |___core
|       |___documentation
|       |__howItWorks  <--- you are here
|       |___peripheral
|       |___scripts
```

## Table of contents <a name="tof"></a>
1. alu.sv


### 1. alu.sv
8 line: `default_nettype none` <br/> 
It's the directive and means that, declaring variables is not required. The compiler can create a variable the first time you use it. So for example sometimes it can cause a problem if you make a typo (pol. *literówka*), then compiler will create a new variable, instead of pointing to an error. To turn it off (creating new variables without declaring) we must write this instruction. And it's very important! Good practice is on the end of file turning off this option using: `default_nettype wire` (line: 59). 
