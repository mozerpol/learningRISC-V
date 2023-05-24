library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library gpio_lib;
   use gpio_lib.all;
   use gpio_lib.gpio_pkg.all;


entity gpio is
   port (
      addr  : in std_logic_vector(7 downto 0);
      be    : in std_logic_vector(3 downto 0);
      wdata : in std_logic_vector(31 downto 0);
      we    : in std_logic;
      clk   : in std_logic;
      rst   : in std_logic;
      q     : out std_logic_vector(31 downto 0);
      gpio  : out std_logic_vector(3 downto 0)
   );
end entity gpio;

architecture rtl of gpio is
begin


end architecture rtl;
