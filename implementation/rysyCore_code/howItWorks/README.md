# Table of contents <a name="tof"></a>
1. About this part of the repository
2. Repository tree
3. Code semantics
    1. rysy_pkg.sv
    2. alu.sv

## 1. About this part of the repository
In this file I will explain how the code written in SystemVerilog by Rafal Kozik works and I'll try translate it to Verilog language. Core written in SystemVerilog you can find in `learningRISC-V/implementation/rysyCore_code/code/` the author is Rafal Kozik and [here](https://gitlab.com/rysy_core/rysy_core) is the project page on gitlab.

## 2. Repository tree
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

## 3. SystemVerilog code semantics
### 1. rysy_pkg.sv
**8 line:** `` `default_nettype none `` <br/>
It's the directive and means that, declaring variables is not required. The compiler can create a variable the first time you use it. So for example sometimes it can cause a problem if you make a typo (pol. *literówka*), then compiler will create a new variable, instead of pointing to an error. To turn it off (creating new variables without declaring) we must write this instruction. And it's very important! Good practice is on the end of file turning off this option using: `` `default_nettype wire `` (line: 19). <br/>
**10 line:** `package rysyPkg;` <br/>
Packages provide a mechanism for storing and sharing data, methods, property, parameters that can be re-used in other modules. It's something like header with **.c* functions in one file. Packages can be imported into the current scope where items in that package can be used. <br/>
All packages have to be enclosed within the `package` and `endpackage` keywords. <br/>
**12 line:** `localparam int REG_LEN = 32;` <br/>
*Localparam* prevents the values to be overwritten (directly) from outside the module. Once the variables are declared with *localparam* the values stays constant. <br/>
*int* - two-state, integer, 32 bits, signed data type. SystemVerilog introduces new two-state data types, where each bit is *0* or *1* only (not variable value, but representation of this value), other states are *X* and *Z*. <br/>
**16 line:** `localparam NOP = 32'h00000013;` <br/>
*32* - size 32 bit. <br/>
*h* - hexadecimal format. 00000013 in hex means 19 in dec. <br/>
**17 line:** `endpackage : rysyPkg` <br/>
Endpackage *rysyPkg*, is like brackets in C. We can also write only `endpackage` <br/>
**19 line:** `` `default_nettype wire `` <br/>
The end of `` `default_nettype none `` directive. It means, that from now undefined variables will be automatically declared by compiler. The default type will be *wire*.

### 2. alu.sv
**8 line:** `` `default_nettype none `` <br/> 
It's the directive and means that, declaring variables is not required. The compiler can create a variable the first time you use it. So for example sometimes it can cause a problem if you make a typo (pol. *literówka*), then compiler will create a new variable, instead of pointing to an error. To turn it off (creating new variables without declaring) we must write this instruction. And it's very important! Good practice is on the end of file turning off this option using: `` `default_nettype wire `` (line: 59). <br/>
**10 line:** `` `import rysyPkg::*; `` <br/>
Packages provide a mechanism for storing and sharing data, methods, property, parameters that can be re-used in other modules. It's something like header with **.c* functions in one file. Packages can be imported into the current scope where items in that package can be used. <br/>
All packages have to be enclosed within the `package` and `endpackage` keywords. So if we want import package into other modules just use *import* and scope resolution operator *::*, which specifies what to import. In this line of code we import everything defined in the package as indicated by the star `*` that follows *::* operator to be able to use any of the itmes. If we don't want import everything from package, we can select by using for example: `` `import rysyPkg::the_name_of_a_function; `` <br/>













