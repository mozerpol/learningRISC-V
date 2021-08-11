// Definitions for first mux.
`define PC_ALU 2'b00 // Take address from ALU.
`define PC_P4  2'b01 // Point to the next instruction.
`define PC_M4  2'b10 // point to the previous instruction.
`define PC_OLD 2'b11 // Save in PC reg its actual value.
// Definitions for second mux.
`define MEM_PC 1'b0  // Take value from PC reg. 
`define MEM_ALU 1'b1 // Take address from ALU.