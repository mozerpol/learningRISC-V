library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;

entity gpio_tb is
end gpio_tb;

architecture tb of gpio_tb is

   component gpio is
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
   end component gpio;

   signal addr_tb  : std_logic_vector(7 downto 0);
   signal be_tb    : std_logic_vector(3 downto 0);
   signal wdata_tb : std_logic_vector(31 downto 0);
   signal we_tb    : std_logic;
   signal clk_tb   : std_logic;
   signal rst_tb   : std_logic;
   signal q_tb     : std_logic_vector(31 downto 0);
   signal gpio_tb  : std_logic_vector(3 downto 0);

begin
   inst_gpio : component gpio 
   port map (
      addr  => addr_tb,
      be    => be_tb,
      wdata => wdata_tb,
      we    => we_tb,
      clk   => clk_tb,
      rst   => rst_tb,
      q     => q_tb,
      gpio  => gpio_tb
   );

   p_tb : process
   begin
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
