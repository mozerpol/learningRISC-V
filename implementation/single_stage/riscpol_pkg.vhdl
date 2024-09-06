--------------------------------------------------------------------------------
-- File          : riscpol_pkg.vhdl
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : Package with RAM and ROM size settings and addresses, which
-- control access to external peripherals, e.g. at what address is access to
-- GPIO or TIMER.
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;

package riscpol_pkg is

   constant C_RAM_BYTE_WIDTH  : natural := 8;
   constant C_RAM_BYTES       : natural := 4;
   constant C_RAM_LENGTH      : integer := 64; -- RAM size in
   -- peripherals/ram.vhdl file.
   constant C_ROM_LENGTH      : integer := 1024; -- Instruction memory size that
   -- changes the size of C_CODE array in instruction_memory_design.vhdl file.
   -- Must be greater than or equal to the number of instructions and a power of
   -- number 2.
   constant C_MMIO_ADDR_GPIO  : integer := 64;
   constant C_CLK_PERIOD      : time    := 2 ns; -- Constant needed only for
   -- test purposes.

   -- Type for General-Purpose Register
   type t_gpr  is array(0 to 31) of std_logic_vector(31 downto 0);
   --  Build up 2D array to hold the data memory
   type word_t is array (0 to C_RAM_BYTES-1) of std_logic_vector(C_RAM_BYTE_WIDTH-1 downto 0);
   type ram_t is array (0 to C_RAM_LENGTH - 1) of word_t;

end;

package body riscpol_pkg is

end package body;
