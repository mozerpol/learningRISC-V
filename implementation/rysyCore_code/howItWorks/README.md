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
**12 line:** `package aluPkg;` <br/>
Packages provide a mechanism for storing and sharing data, methods, property, parameters that can be re-used in other modules. It's something like header with **.c* functions in one file. Packages can be imported into the current scope where items in that package can be used. <br/>
All packages have to be enclosed within the `package` and `endpackage` keywords. <br/>
**13 line:** `typedef enum bit [3:0]` <br/>
*typedef* - creating a abbreviation for an existing data type, syntax: *typedef data_type type_name [range];*. <br/>
*enum* - enumerated type defines a set of named values. For example: *enum  {RED, GREEN, BLUE} color; // it's int type, RED = 0, GREEN = 1, BLUE = 2* <br/>
*bit* - 2-state data type, it can be *0* or *1*. <br/>
**24 line:** `} alu_op;` <br/>
It's part of *enum* type, exactly the end of *enum*. Thanks to this we can use *alu_op = 0001* (because our data type is bit [3:0]) to select second option in enum. 
**27 line:** `module alu` <br/>
*module* is a block which implements a certain funcionality. Modules can be embedded within other modules and a higher module can communicate with its lower level module using their input and output ports. *module* should be enclosed within *module* and *endmodule* keywords. Name of the module should be given after the *module* keyword and an optional list of *ports* may be declared as well. Example: <br/>
```
module <name> ([optional_port_list]);
    // Content of the module
endmodule
```
**28 line:** `input wire [REG_LEN-1:0]alu_in1,` <br/>
*input* - signal, that act as input to a particular module. <br/>
*wire* - data type, which require the continuous assignment of the value. Ports are by default considered as nets of type *wire*. <br/> 
*REG_LEN* - constant from *rysy_pkg* file and is equal 32. 
So, in this line we are creating a 32 bit vector net named *alu_in1*. If we want to access the net, let's use it as a typical array: <br/>
*alu_in1[3] = number* <br/>
But it is important to remember that this network is numbered in that order: 31, 30, 29, ..., 0. If we want to reverse the order (0, 1, 2, 3, ..., 31), we have to declare the net this way: <br/>
*input wire [0:REG_LEN-1]alu_in1*. <br/>
**30 line:** `input aluPkg::alu_op alu_op` <br/>
Ok, it works as: import from package *aluPkg* type *alu_op* and create a variable of this type named *alu_op*. So, if we'll write *input aluPkg::alu_op alu_asdf*, it means: import from package *aluPkg* type *alu_op* and create a variable of this type named *alu_asdf*. Our new variable *alu_asdf* will be input to our module. <br/>
**33 line:** `logic signed [REG_LEN-1:0] o;` <br/>
*logic* - 4-state data type, it can be *0*, *1*, *x*, *z*. <br/>
*signed* - a signed representation. <br/>
**34 line:** `assign alu_out = o;` <br/>
*assign* - it will be easiest to understand with an example, using a metaphor. Imagine breadboard in which you have *+5 V* battery and LED. As long as the battery is connected to the LED, the LED is on. Connection between LED and battery represent *assign*. We're using *assign* to the data types, which requires the continuous assignment of the value. We have also the strength and delay, but it's optional and are mostly used for dataflow modeling than synthesizing into real hardware. Delay values are useful for specifying delays for gates and are used to model timing behavior in real hardware: <br/>
*assign <net_expression = [drive_strength] [delay] <expression of different signals or constant value>* <br/>
Very important thing, we're not using *assign* inisde always blocks! So sum up, *assign* statements are also called continuous assignments and are always active. 











