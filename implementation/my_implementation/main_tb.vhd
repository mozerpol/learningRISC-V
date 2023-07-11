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
      i_rst          : in std_logic;
      i_clk          : in std_logic;
      i_wr_data      : in std_logic_vector(31 downto 0);
      i_wr_enable    : in std_logic;
      o_rd_data      : out std_logic_vector(31 downto 0)
   );
   end component main;

   signal rst_tb        : std_logic;
   signal clk_tb        : std_logic;
   signal wr_data_tb    : std_logic_vector(31 downto 0);
   signal wr_enable_tb  : std_logic;
   signal rd_data_tb    : std_logic_vector(31 downto 0);

begin

   inst_main : component main
   port map (
      i_rst          => rst_tb,
      i_clk          => clk_tb,
      i_wr_data      => wr_data_tb,
      i_wr_enable    => wr_enable_tb,
      o_rd_data      => rd_data_tb
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
