library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;
library bus_interconnect_lib;
   use bus_interconnect_lib.all;
   use bus_interconnect_lib.bus_interconnect_pkg.all;

entity bus_interconnect_tb is
end bus_interconnect_tb;

architecture tb of bus_interconnect_tb is

   component bus_interconnect is
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
   end component bus_interconnect;

   constant WIDTH          : integer := 32;
   signal clk_tb           : std_logic;
   signal addr_tb          : std_logic_vector(WIDTH-1 downto 0);
   signal rdata_gpio_tb    : std_logic_vector(WIDTH-1 downto 0);
   signal rdata_ram_tb     : std_logic_vector(WIDTH-1 downto 0);
   signal we_tb            : std_logic;
   signal rdata_tb         : std_logic_vector(WIDTH-1 downto 0);
   signal we_ram_tb        : std_logic;
   signal we_gpio_tb       : std_logic;

begin
   inst_bus_interconnect : component bus_interconnect
   generic map(
      WIDTH       => 32
   )
   port map (
      clk         => clk_tb,
      addr        => addr_tb,
      rdata_gpio  => rdata_gpio_tb,
      rdata_ram   => rdata_ram_tb,
      we          => we_tb,
      rdata       => rdata_tb,
      we_ram      => we_ram_tb,
      we_gpio     => we_gpio_tb
   );

   p_tb : process
   begin
      wait for 10 ns;
      addr_tb        <= 32d"10";
      wait for 10 ns;
      rdata_gpio_tb  <= 32d"12";
      wait for 10 ns;
      addr_tb        <= (others => '0');
      wait for 10 ns;
      rdata_ram_tb   <= 32d"8";
      wait for 10 ns;
      we_tb          <= '1';
      wait for 10 ns;
      rdata_gpio_tb  <= 32d"12";
      wait for 10 ns;
      rdata_ram_tb   <= 32d"8";
      wait for 10 ns;
      rdata_ram_tb   <= 32d"1024";
      wait for 10 ns;
      we_tb          <= '0';
      wait for 10 ns;
      rdata_gpio_tb  <= 32d"12";
      wait for 10 ns;
      addr_tb        <= (others => '0');
      wait for 10 ns;
      rdata_ram_tb   <= 32d"8";
      wait for 10 ns;
      addr_tb        <= 32d"3";
      wait for 10 ns;
      rdata_gpio_tb  <= 32d"5";
      wait for 10 ns;
      rdata_ram_tb   <= 32d"2";
      wait for 10 ns;
      rdata_gpio_tb  <= 32d"4";
      wait for 10 ns;
      rdata_ram_tb   <= (others => '0');
      wait for 10 ns;
      rdata_gpio_tb  <= 32d"3";
      we_tb          <= '1';
      wait for 10 ns;
      we_tb          <= '0';
      wait for 10 ns;
      addr_tb        <= (others => '0');
      wait for 10 ns;
      rdata_gpio_tb  <= 32d"12";
      wait for 10 ns;
      addr_tb        <= (others => '0');
      we_tb          <= '1';
      wait for 20 ns;
      we_tb          <= '0';
      wait for 20 ns;
      addr_tb        <= 32d"2";
      we_tb          <= '1';
      wait for 20 ns;
      we_tb          <= '0';
      wait for 20 ns;
      addr_tb        <= 32b"00100000000000000000000000000000";
      we_tb          <= '1';
      wait for 20 ns;
      we_tb          <= '0';
      wait for 20 ns;
      addr_tb        <= (others => '0');
      we_tb          <= '1';
      wait for 20 ns;
      we_tb          <= '0';
      wait for 20 ns;

      wait for 25 ns;
      stop(2);
   end process p_tb;

   p_clock_gen : process
   begin
      clk_tb <= '0';
      wait for 5 ns;
      clk_tb <= '1';
      wait for 5 ns;
   end process p_clock_gen;

end architecture tb;
