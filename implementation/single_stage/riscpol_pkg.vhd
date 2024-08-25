--------------------------------------------------------------------------------
-- File          : riscpol_pkg.vhd
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

   constant C_RAM_LENGTH      : integer := 64; -- RAM size in 
   -- peripherals/ram.vhd file.
   constant C_ROM_LENGTH      : integer := 1024; -- Instruction memory size that 
   -- changes the size of C_CODE array in instruction_memory_design.vhd file. 
   -- Must be greater than or equal to the number of instructions and a power of 
   -- number 2.
   constant C_MMIO_ADDR_GPIO  : integer := 64;
   constant C_CLK_PERIOD      : time    := 2 ns; -- Constant needed only for 
   -- test purposes.

end;

package body riscpol_pkg is

end package body;
