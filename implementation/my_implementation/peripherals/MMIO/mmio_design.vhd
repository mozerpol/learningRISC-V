library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library mmio_lib;
   use mmio_lib.all;
   use mmio_lib.mmio_pkg.all;

entity mmio is
   port (
      i_addr               : in integer range 0 to 63;
      o_write_enable_ram   : out std_logic;
      o_write_enable_gpio  : out std_logic 
   );
end mmio;

architecture rtl of mmio is

begin

   o_write_enable_gpio <= '1' when i_addr = 63 else '0';
   o_write_enable_ram  <= '1' when i_addr /= 63 else '0';

end rtl;
