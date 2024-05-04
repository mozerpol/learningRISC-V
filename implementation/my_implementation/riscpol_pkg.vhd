--------------------------------------------------------------------------------
-- File          : riscpol_pkg.vhd
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : Package with RAM and ROM size settings and the address that
-- controls the GPIO
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;
   use IEEE.std_logic_unsigned.all;
   use IEEE.math_real.all;

package riscpol_pkg is

   constant C_RAM_LENGTH      : integer := 64;
   constant C_ROM_LENGTH      : integer := 1024;
   constant C_MMIO_ADDR_GPIO  : integer := 64; -- change name to gpio_addr

end;

package body riscpol_pkg is

end package body;
