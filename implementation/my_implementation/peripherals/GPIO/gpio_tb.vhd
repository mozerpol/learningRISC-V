library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
   use std.env.all;
library gpio_lib;
   use gpio_lib.all;
   use gpio_lib.gpio_pkg.all;

entity gpio_tb is
end gpio_tb;

architecture tb of gpio_tb is

   component gpio is
      port (
         i_clk    : in std_logic;
         i_addr   : in std_logic_vector(31 downto 0);
         i_wdata  : in std_logic_vector(31 downto 0);
         o_gpio   : out std_logic_vector(3 downto 0)
      );
   end component gpio;

   signal clk_tb     : std_logic;
   signal addr_tb    : std_logic_vector(31 downto 0);
   signal wdata_tb   : std_logic_vector(31 downto 0);
   signal gpio_tb    : std_logic_vector(3 downto 0);


begin

   inst_gpio : component gpio
   port map (
      i_clk    => clk_tb,
      i_addr   => addr_tb,
      i_wdata  => wdata_tb,
      o_gpio   => gpio_tb
   );

   p_clk : process
   begin
      clk_tb <= '0';
      wait for 1 ns;
      clk_tb <= '1';
      wait for 1 ns;
   end process p_clk;

   p_tb : process
   begin

      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
