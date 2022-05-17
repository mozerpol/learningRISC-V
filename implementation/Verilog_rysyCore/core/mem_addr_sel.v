/*
	How this module works:
    It's "mux_mem_addr" on the core structure picture. First part is multiplexer with four inputs,
    second part is PC register and third is mux with two inputs. For the record PC register points 
    to next instruction inside main memory, The PC register contains the address of subsequent instructions. 
    First part:
    	It's multiplexer which can select what to save inside PC register, which address. We have four possibilities
        1. Take address from ALU, which calculated new address, this addres can be very very far in memory, so we can
        thanks to this create jumps.
        2. Do nothing, mean save in PC reg its actual value. So if PC reg points to address 0x1234 then save the same,
        once again address.
        3. Add to the actual PC reg value "4", thanks to this PC reg will points to the next instruction.
        4. Subtract value "4" from the current PC reg value, thanks to this PC reg will previous instruction.
	Second part:
    	It's PC register, it's  register of the processor in which the address of the current or the next instruction 
        is stored. It has one input (from mux, which determines from where the next address will be loaded).
	Third part:
    	It's multiplexer which decide about what to save to the ADDR reg. We have two possibilities:
        1. Take address from ALU, which calculated new address, this addres can be very very far in memory, so we can
        thanks to this create jumps. It's exactly the same as in first option in first mux. 
        2. Take value from PC reg. 
*/
`timescale 100ns / 10ns

`include "mem_addr_sel.vh"
`include "rysy_pkg.vh"

module mem_addr_sel(
  input wire clk,
  input wire rst,
  input wire [1:0] pc_sel, 			// First mux, select source for PC reg.
  input wire mem_sel, 				// Second mux, select the last source, ALU or PC reg.
  input wire [`REG_LEN-1:0]alu_out, // New address calculated by ALU.
  output wire [`REG_LEN-1:0]pc,		// Output for first mux.
  output wire [`REG_LEN-1:0]addr 	// Output for second mux.
);

  reg [`REG_LEN-1:0] pc_reg; // We must store somewhere current value of PC register. It's necessary, because
  // sometimes we want add "4" or subtract "4" from current value.
  assign pc = pc_reg;

  always@(posedge clk)
    begin
      case(pc_sel)
        `PC_ALU : pc_reg <= alu_out; 	// Save in PC reg value from ALU.
        `PC_P4  : pc_reg <= pc_reg + 4; // Save in PC reg address of the next instruction.
        `PC_M4  : pc_reg <= pc_reg - 4;	// Save in PC reg address of the previous instruction.
        `PC_OLD : pc_reg <= pc_reg; 	// Do nothing.
        default : pc_reg <= pc_reg;
      endcase
      if(rst) pc_reg <= 0; // Reset PC reg.
    end

  reg [`REG_LEN-1:0] addr_reg; // Because we want assign reg to output, just for Verilog purposes.
  assign addr = addr_reg;

  always@(*) // This mux determines output from "mux_mem_addr" module.
    case(mem_sel)
      `MEM_PC  : addr_reg = pc_reg; // Will be PC reg.
      `MEM_ALU : addr_reg = alu_out;// Will be value from ALU.
    endcase
  
endmodule
