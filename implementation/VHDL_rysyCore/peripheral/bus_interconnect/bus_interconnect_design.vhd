library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library bus_interconnect_lib;
   use bus_interconnect_lib.all;
   use bus_interconnect_lib.bus_interconnect_pkg.all;

entity bus_interconnect is
   generic (
      WIDTH : integer := 32
   );
   port (
      clk         : in std_logic;
      addr        : in std_logic_vector(WIDTH-1 downto 0);
      rdata_gpio  : in std_logic_vector(WIDTH-1 downto 0);
      rdata_ram   : in std_logic_vector(WIDTH-1 downto 0);
      we          : in std_logic;
      rdata       : out std_logic_vector(WIDTH-1 downto 0);
      we_ram      : out std_logic;
      we_gpio     : out std_logic
   );
end entity bus_interconnect;

architecture rtl of bus_interconnect is

begin

    rdata <= (others => '0');

end architecture rtl;
