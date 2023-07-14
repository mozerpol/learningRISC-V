library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;

entity main_tb is
end main_tb;

architecture tb of main_tb is

   component main is
   port (
      i_rst                : in std_logic;
      i_clk                : in std_logic;
      i_instruction        : in std_logic_vector(31 downto 0);
      o_ram_read_data      : out std_logic_vector(31 downto 0);
      o_ram_write_data     : out std_logic_vector(31 downto 0);
      o_ram_read_addr      : out std_logic_vector(7 downto 0);
      o_ram_write_addr     : out std_logic_vector(7 downto 0);
      o_ram_write_enable   : out std_logic
   );
   end component main;

   signal rst_tb              : std_logic;
   signal clk_tb              : std_logic;
   signal instruction_tb      : std_logic_vector(31 downto 0);
   signal ram_read_data_tb    : std_logic_vector(31 downto 0);
   signal ram_write_data_tb   : std_logic_vector(31 downto 0);
   signal ram_read_addr_tb    : std_logic_vector(7 downto 0);
   signal ram_write_addr_tb   : std_logic_vector(7 downto 0);
   signal ram_write_enable_tb : std_logic;

begin

   inst_main : component main
   port map (
      i_rst                => rst_tb,
      i_clk                => clk_tb,
      i_instruction        => instruction_tb,
      o_ram_read_data      => ram_read_data_tb,
      o_ram_write_data     => ram_write_data_tb,
      o_ram_read_addr      => ram_read_addr_tb,
      o_ram_write_addr     => ram_write_addr_tb,
      o_ram_write_enable   => ram_write_enable_tb
   );

   p_tb : process
   begin

      rst_tb            <= '1';
      wait for 20 ns;
      rst_tb            <= '0';

      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
