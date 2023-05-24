library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_lib;
   use rysy_lib.all;
   use rysy_lib.rysy_pkg.all;
library bus_interconnect_lib;
   use bus_interconnect_lib.all;
   use bus_interconnect_lib.bus_interconnect_pkg.all;
library byte_enabled_simple_dual_port_ram_lib;
   use byte_enabled_simple_dual_port_ram_lib.all;
   use byte_enabled_simple_dual_port_ram_lib.byte_enabled_simple_dual_port_ram_pkg.all;
library gpio_lib;
   use gpio_lib.all;
   use gpio_lib.gpio_pkg.all;

entity rysy is
   port (
      clk   : in std_logic;
      rst   : in std_logic;
      gpio  : out std_logic_vector(3 downto 0)
   );
end entity rysy;

architecture rtl of rysy is


begin

   p_rysy : process(clk)
   begin
   end process p_rysy;


end architecture rtl;
