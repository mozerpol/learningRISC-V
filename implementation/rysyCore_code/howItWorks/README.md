# Table of contents <a name="tof"></a>
1. About this part of the repository
2. Repository tree
3. [Code semantics](#Code_semantics)
    1. [rysy_pkg.sv](#rysypkg)
    2. [alu.sv](#alu)
    3. [alu1_mux.sv](#alu1mux)
    4. [alu2_mux.sv](#alu2mux)
    5.  [alu_tb.sv](#alutb)

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

## 3. SystemVerilog code semantics <a name="Code_semantics"></a> [UP↑](#tof)
### 1. rysy_pkg.sv <a name="rysypkg"></a> [UP↑](#tof)
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

### 2. alu.sv <a name="alu"></a> [UP↑](#tof)
**8 line:** `` `default_nettype none `` <br/> 
It's the directive and means that, declaring variables is not required. The compiler can create a variable the first time you use it. So for example sometimes it can cause a problem if you make a typo (pol. *literówka*), then compiler will create a new variable, instead of pointing to an error. To turn it off (creating new variables without declaring) we must write this instruction. And it's very important! Good practice is on the end of file turning off this option using: `` `default_nettype wire `` (line: 59). <br/>
**10 line:** `import rysyPkg::*;` <br/>
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
**41 line:** `always_comb begin` <br/>
SystemVerilog defines four forms of always procedures: *always*, *always_comb*, *always_ff*, *always_latch*. To understand this, we must know what do *always @** in Verilog (not in SystemVerilog). *always@* blocks are used to describe events that should happen under certain conditions. Below is example of *always@* block: <br/>
```
always @( ...  sensitivity  list  ... ) begin
    // elements
end
```
The contents of the *always@* block, namely *elements* describe elements that should be set when the sensitivity list is "satisfied". So when the sensitivity list is "satisfied", the elements inside th *ealways@* block are set/updated. Elements in an *always@* block are set/updated in sequentially and in parallel, depending on the type of assignment used. There are two types of assignments: *<=* (non-blocking) and *=* (blocking). Example of always block with sensitivity list can be: *always@(posedge Clock)*. <br/>
Only *=* (blocking) assignments should be used in an *always@** block.
The definition of *always @** is: infer (pol. *wywnioskować*) my sensitivity list from the contents of the block. <br/>
So SystemVerilog fixes some of the *always@** limitations in several ways:
- *always_comb* automatically executes once at time zero, whereas *always@** waits until a change occurs on a signal in the inferred sensitivity list. 
- *always_comb* is sensitive to changes within the contents of a function, whereas *always@* is only sensitive to changes to the arguments of a function.
- Statements in an *always_comb* cannot include those that block, have blocking timing or event controls. 

*begin* - it's like brackets in C. If we have one statement in our function, it's not necessary use *begin* - *end* <br/>
**42 line:** `case (alu_op)` <br/>
This statement checks if the given expression matches one of the other expressions in the list and branches accordingly. It's typically used to implement a multiplexer. Example: <br/>
```
case (<expression>)
    case_item1 : <single_statement>
    case_item2 : <single_statement>
    case_item3 : begin
                <multiple_statements>
                end
    default : <statement>
endcase    
```
**45 line:** `aluPkg::XOR: o = alu_in1 ^ alu_in2;` <br/>
*^* - it's a reduction operator, which will perform *xor* operation. <br/>
**46 line:** `aluPkg::OR: o = alu_in1 | alu_in2;` <br/>
*^* - it's a reduction operator, which will perform *or* operation. <br/>
**47 line:** `aluPkg::AND: o = alu_in1 & alu_in2;` <br/>
*^* - it's a reduction operator, which will perform *and* operation. <br/>
**48 line:** `aluPkg::SLL: o = alu_in1 << alu_in2[4:0];` <br/>
*^* - it's a shift operator, which will perform *left shift* operation. <br/>
**45 line:** `aluPkg::SRA: o = alu_in1_s >>> alu_in2[4:0];` <br/>
*^* - it's a binary arithmetic shift. Arithmetic left shift, shift left specified number of bits, fill with zero. <br/>
**51 line:** `aluPkg::SLT: o = alu_in1_s < alu_in2_s;` <br/>
*^* - it's a relational operator, which will perform *less than* operation. <br/>
**59 line:** `` `default_nettype wire `` <br/>
It's the directive which relates to `` `default_nettype none ``. Read description of the eight line.

### 3. alu1_mux.sv <a name="alu1mux"></a> [UP↑](#tof)
**8 line:** `` `default_nettype none `` <br/>
It's the directive and means that, declaring variables is not required. The compiler can create a variable the first time you use it. So for example sometimes it can cause a problem if you make a typo (pol. *literówka*), then compiler will create a new variable, instead of pointing to an error. To turn it off (creating new variables without declaring) we must write this instruction. And it's very important! Good practice is on the end of file turning off this option using: `` `default_nettype wire `` (line: 42). <br/>
**10 line:** `import rysyPkg::*;` <br/>
Packages provide a mechanism for storing and sharing data, methods, property, parameters that can be re-used in other modules. It's something like header with **.c* functions in one file. Packages can be imported into the current scope where items in that package can be used. <br/>
All packages have to be enclosed within the `package` and `endpackage` keywords. So if we want import package into other modules just use *import* and scope resolution operator *::*, which specifies what to import. In this line of code we import everything defined in the package as indicated by the star `*` that follows *::* operator to be able to use any of the itmes. If we don't want import everything from package, we can select by using for example: `` `import rysyPkg::the_name_of_a_function; `` <br/>
**12 line:** `package alu1Pkg;` <br/>
Packages provide a mechanism for storing and sharing data, methods, property, parameters that can be re-used in other modules. It's something like header with **.c* functions in one file. Packages can be imported into the current scope where items in that package can be used. <br/>
All packages have to be enclosed within the `package` and `endpackage` keywords. <br/>
**13 line:** `typedef enum bit` <br/>
*typedef* - creating a abbreviation for an existing data type, syntax: *typedef data_type type_name [range];*. <br/>
*enum* - enumerated type defines a set of named values. For example: *enum  {RED, GREEN, BLUE} color; // it's int type, RED = 0, GREEN = 1, BLUE = 2* <br/>
*bit* - 2-state data type, it can be *0* or *1*. <br/>
**16 line:** `} alu1_sel;` <br/>
It's part of *enum* type, exactly the end of *enum*. Thanks to this we can use *0* to select *ALU1_RS* or *1* to select *ALU1_PC*.
**19 line:** `module alu1_mux` <br/>
*module* is a block which implements a certain funcionality. Modules can be embedded within other modules and a higher module can communicate with its lower level module using their input and output ports. *module* should be enclosed within *module* and *endmodule* keywords. Name of the module should be given after the *module* keyword and an optional list of *ports* may be declared as well. Example: <br/>
```
module <name> ([optional_port_list]);
    // Content of the module
endmodule
```
**20 line:** `input wire [REG_LEN-1:0] rs1_d,` <br/>
*input* - signal, that act as input to a particular module. <br/>
*wire* - data type, which require the continuous assignment of the value. Ports are by default considered as nets of type *wire*. <br/> 
*REG_LEN* - constant from *rysy_pkg* file and is equal 32. 
So, in this line we are creating a 32 bit vector net named *rs1_d*. If we want to access the net, let's use it as a typical array: <br/>
*rs1_d[3] = number* <br/>
But it is important to remember that this network is numbered in that order: 31, 30, 29, ..., 0. If we want to reverse the order (0, 1, 2, 3, ..., 31), we have to declare the net this way: <br/>
*input wire [0:REG_LEN-1]rs1_d*. <br/>
**22 line:** *input alu1Pkg::alu1_sel alu1_sel,* <br/>
Ok, it works as: import from package *alu1Pkg* type *alu1_sel* and create a variable of this type named *alu1_sel*. So, if we'll write *input alu1Pkg::alu1_sel alu_asdf*, it means: import from package *alu1Pkg* type *alu1_sel* and create a variable of this type named *alu_asdf*. Our new variable *alu_asdf* will be input to our module. <br/>
**24 line:** `output logic [REG_LEN-1:0] alu_in1` <br/>
*output* - it's output from our module. <br/>
*logic* - 4-state data type, it can be *0*, *1*, *x*, *z*. <br/>
**27 line:** `logic [REG_LEN-1:0]old_pc[1:0];` <br/>
Above code is unpacked array of two 32-bit vectors. <br/>
Verilog arrays can be *packed* or *unpacked*. *Packed* array refers to dimensions declared after the type and before the data identifier name. *Unpacked* array refers to the dimensions declared after the data identifier name. A one-dimensional packed array is also called a vector. <br/>
Packed array of bit types: <br/>
`bit [7:0] temp_var;` <br/>
| ![obraz](https://user-images.githubusercontent.com/43972902/118252980-ad021680-b4a9-11eb-83e2-71a9c01c714f.png) |
|:--:|
| source: *https://verificationguide.com/images/systemverilog/array/packed_array_systemverilog.png* [14.05.2021] |

Unpacked array of real types: <br/>
`bit temp_var [7:0];` <br/>
| ![obraz](https://user-images.githubusercontent.com/43972902/118253164-df137880-b4a9-11eb-86dc-7ae30af4e5c1.png) |
|:--:|
| source *https://verificationguide.com/images/systemverilog/array/unpacked_array_systemverilog.png* [14.05.2021]|

**29 line:** `always_ff @(posedge clk) begin`
SystemVerilog defines four forms of always procedures: *always*, *always_comb*, *always_ff*, *always_latch*. To understand this, we must know what do *always@** in Verilog (not in SystemVerilog). *always@* blocks are used to describe events that should happen under certain conditions. Below is example of *always@* block: <br/>
```
always @( ...  sensitivity  list  ... ) begin
    // elements
end
```
The contents of the *always@* block, namely *elements* describe elements that should be set when the sensitivity list is "satisfied". So when the sensitivity list is "satisfied", the elements inside th *ealways@* block are set/updated. Elements in an *always@* block are set/updated in sequentially and in parallel, depending on the type of assignment used. There are two types of assignments: *<=* (non-blocking) and *=* (blocking). Example of always block with sensitivity list can be: *always@(posedge Clock)*. <br/>
Only *=* (blocking) assignments should be used in an *always@** block.
The definition of *always @** is: infer (pol. *wywnioskować*) my sensitivity list from the contents of the block. <br/>
SystemVerilog *always_ff* procedure is used to model sequential flip-flop logic. A *always_ff* procedure adds a restriction that it can contain one and only one event control and no blocking timing controls. Variables written on the left-hand side of assignments within *always_ff*, including variables from contents of a called function, cannot be written by other processes. <br/>
*begin* - it's like brackets in C. If we have one statement in our function, it's not necessary use *begin* - *end* <br/>
**30 line:** `old_pc[1] <= pc;` <br/>
**Blocking** assignment statements are assigned using **=** and are executed one after other in a procedural block. <br/>
**Non-blocking** assignment allows assignments to be scheduleld without blocking the execution of the following statements and is specified by a **<=** symbol. The same symbol is used as a relational operator in expressions. So we can say that *<=* is non-blocking like in the nature. This means that in an *always* block, every line will be executed in parallel. This leads to the implementation of sequential elements.
**34 line:** `always_comb` <br/>
- *always_comb* automatically executes once at time zero, whereas *always@** waits until a change occurs on a signal in the inferred sensitivity list. 
- *always_comb* is sensitive to changes within the contents of a function, whereas *always@* is only sensitive to changes to the arguments of a function.
- Statements in an *always_comb* cannot include those that block, have blocking timing or event controls. 

________________________________________
**From now on, I will only describe the differences between the files. Doesn't make sense in rewriting the same things.**
________________________________________

### 4. alu2_mux.sv <a name="alu2mux"></a> [UP↑](#tof)
*alu2_mux.sv* file contains almost the same things as *alu1_mux.sv*, so there is no make any sense write once again the same things. *alu2_mux.sv* is no new stuff.

### 5. alu_tb.sv <a name="alutb"></a> [UP↑](#tof)
A test bench or testing workbench is an environment used to verify the correctness or of a design or model. <br/>
**9 line:** `` `timescale 100ns / 10ns `` <br/>
The simulation in Verilog needs a time setting. The syntax looks like: `` `timescale <time_uint>/<time_precision>`, where *time_unit* is the measurement of delays and simulation time while the *time_precision* specifies how delay values are rounded before being used in simulation. </br>
| Character | Unit |
|:--:|:--:|
| s | seconds |
| ms | miliseconds |
| us | microseconds |
| ns | nanoseconds |
| ps | picoseconds |
| fs | femtoseconds |

The integers in above table can be 1, 10 or 100. <br/>
**16 line:** `alu dut` <br/>
**DUT** is abbreviation of *device under test* also known as *equipment under test* (**EUT**) and *unit under test* (**UUT**). Also is *system under test* (**SUT**) refers to a system that is being tested for correct operation. A test bench starts off with a module declaration, in our case is *dut*. It's important to notice the test bench module does not have any inputs or outputs. It is entirely self contained (pol. *samowystarczalny*). <br/>
**17 line:** `.alu_in1(in1),` <br/>
Binding vars from test with vars from model. Inside bracket we have variable from test bench. `.var_from_model(var_from_test)` <br/>
**24 line:** `logic [31:0]in1_a[] = {32'd10, 32'd3, -32'd4, 32'd4, -32'd16};` <br/>
In this line we have example of *dynamic array*. A *dynamic array* is an unpacked array whose size can be set or changed at run time and hence (pol. *w związku z tym*) is different from a *static array* where the size is pre-determined during declaration of the array. A *dynamic array* dimensions are specified by the empty brackets *[]*. Example of a dynamic array of 8-bit vector: <br/>
`bit [7:0] array_name [];` <br/>
So, *logic [31:0]in1_a[]* is a dynamic array of 32-bit vector *logic* type. <br/>
*32'd10* is 32-bit in size decimal number. <br/>
**26 line:** `int N = ($size(in1_a) > $size(in2_a)) ? $size(in2_a) : $size(in1_a);`
*$size* returns the size of the array, shall return the number of elements in the dimension, which is equivalent to *$high* - *$low* + *1*. When used on a dynamic array, associative array or queue, it returns information about the current state of the array. <br/>
Conditional operator - **? :** - chooses, based on a first expression, between a second and third expression. The first expression is called the condition. If the condition is 1, the operator chooses the second expression. If the condition is 0, the operator chooses the third expression. *? :* is especially useful for describing a multiplexer because, based on the first input, it selects between two others. Syntax: `condition ? if_condition_is_equal_1 : if_condition_is_equal_0` <br/>
**29 line:** `for (i=0; i<N; i++) begin` <br/>
A *for* loop is primarily used to replicate hardware logic. Syntax: <br/>
```
for(<initial_condition>; <condition>; <step_assignment>) 
begin
    // Statements
end
```

**32 line:** `op = op.first;` <br/>
In line 14 we had `aluPkg::alu_op op;`, it means: import from package *aluPkg* type *alu_op* and create a variable of this type named *op*. So in this line (32) we are selecting the first argument (*AND*) and later inside *for* loop, change to the next argument `op = op.next;`. <br/>
SystemVerilog provides several methods for working with enumerated types. The synthesizable methods are: *.first*, *.last*, *.next*, *.prev* and *.num*.














