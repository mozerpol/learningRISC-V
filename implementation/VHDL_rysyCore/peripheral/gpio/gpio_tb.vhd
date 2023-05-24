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

      rst_tb     <='1';
      wait for 10 ns;
      rst_tb     <= '0';
      addr_tb    <= 8b"10010101";
      -- addi x2, x1, 0x5
      we_tb      <='1';
      wdata_tb   <= 32b"000000000101_00001_000_00010_0010011";
      wait for 10 ns;
      we_tb      <= '0';
      wait for 10 ns;
      we_tb      <='1';
      addr_tb    <= 8b"11111111";
      -- andi x1, x0, 0b010101010101
      wdata_tb   <= 32b"010101010101_00000_111_00001_0010011";
      wait for 10 ns;
      addr_tb    <= 8b"00000000";
      wait for 10 ns;
      rst_tb     <='1';
      addr_tb    <= 8b"10010101";
      wait for 10 ns;
      rst_tb     <= '0';
      we_tb      <='1';
      -- slti x2, x1, 4
      wdata_tb   <= 32b"000000000100_00001_010_00010_0010011";
      wait for 10 ns;
      addr_tb    <= 8b"00000000";
      -- ADD x3, x1, x2
      wdata_tb   <= 32b"0000000_00010_00001_000_00011_0110011";
      wait for 10 ns;
      -- auipc x5, 0xfffff
      we_tb      <= '0';
      wdata_tb   <= 32b"11111111111111111111_00101_0010111";
      wait for 10 ns;
      -- sltiu x2, x1, -2048
      wdata_tb   <= 32b"100000000000_00001_011_00010_0010011";

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
