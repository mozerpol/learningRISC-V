--------------------------------------------------------------------------------
-- File          : instruction_memory_design.vhdl
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : The module receives an address (i_instruction_addr signal)
-- that comes from the program_counter (program_counter_design.vhdl) module.
-- Based on this address, the appropriate instruction from the ROM is read and
-- sent to the decoder (decoder_design.vhdl).
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------


library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
library instruction_memory_lib;
   use instruction_memory_lib.all;
   use instruction_memory_lib.rom.all;


entity instruction_memory is
   port (
      i_instruction_addr   : in std_logic_vector(31 downto 0);
      o_instruction        : out std_logic_vector(31 downto 0)
   );
end entity instruction_memory;


architecture rtl of instruction_memory is


begin


   o_instruction  <= C_CODE(to_integer(unsigned(i_instruction_addr(11 downto 2))));


         -- The program counter module (program_counter_design.vhdl) controls
         -- the order of instructions to be executed using the
         -- i_instruction_addr signal coming into this module. The program
         -- counter module does not  change the i_instruction_addr value by 1,
         -- but by 4. So the i_instruction_addr value can only be a multiple of
         -- 4, e.g. 0, 4, 8, 12, 16, 20, ...
         -- 00000 - 0
         -- 00100 - 4
         -- 01000 - 8
         -- 01100 - 12
         -- 10000 - 16
         -- If you read the instruction memory with unchanged i_instruction_addr
         -- values, you would only read every 4. For this reason, the two lowest
         -- significant bits are not read:
         -- 000 - 0
         -- 001 - 1
         -- 010 - 2
         -- 011 - 3
         -- 100 - 4
         -- Thanks to this, the instructions  in the C_CODE array are read in
         -- the correct order, without being skipped.


end architecture rtl;
