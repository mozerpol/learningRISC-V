library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library mmio_lib;
   use mmio_lib.all;
   use mmio_lib.mmio_pkg.all;

entity mmio is
   port (
      i_addr               : in std_logic_vector(5 downto 0);
      o_write_enable_ram   : out std_logic;
      o_write_enable_gpio  : out std_logic 
   );
end mmio;

architecture rtl of mmio is

begin

   o_write_enable_gpio <= '1' when i_addr = "111111" else '0';
   -- Jesli zapiszemy do RAM[63] dane, ktore maja sterowac GPIO, wtedy tez
   -- mozemy odczytac co jest pod RAM[63] i wtedy wiemy jakie GPIO sa wysterowane.
   -- W innym przypadku nie ma mozliwosci odczytu aktywnych GPIO
   --o_write_enable_ram  <= '1' when i_addr /= "111111" else '0';

end rtl;
