library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
   use std.env.all;
library mmio_lib;
   use mmio_lib.all;
   use mmio_lib.mmio_pkg.all;

entity mmio_tb is
end mmio_tb;

architecture tb of mmio_tb is

   component mmio is
      port (
         i_addr               : in std_logic_vector(5 downto 0);
         o_write_enable_ram   : out std_logic;
         o_write_enable_gpio  : out std_logic
   );
   end component mmio;

   signal addr_tb                : std_logic_vector(5 downto 0);
   signal write_enable_ram_tb    : std_logic;
   signal write_enable_gpio_tb   : std_logic;

begin

   inst_mmio : component mmio
   port map (
      i_addr               => addr_tb,
      o_write_enable_ram   => write_enable_ram_tb,
      o_write_enable_gpio  => write_enable_gpio_tb
   );


   p_tb : process
   begin
      addr_tb <= (others => '0');
      wait for 5 ns;
      addr_tb <= 6d"63";
      wait for 5 ns;
      addr_tb <= 6d"60";

      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
