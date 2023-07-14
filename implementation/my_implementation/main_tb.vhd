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
      i_instruction  : in std_logic_vector(31 downto 0);
      o_rd_data      : out std_logic_vector(31 downto 0);
      o_wr_data      : out std_logic_vector(31 downto 0);
      o_rd_addr      : out std_logic_vector(7 downto 0);
      o_wr_addr      : out std_logic_vector(7 downto 0);
      o_wr_enable    : out std_logic
   );
   end component main;

   signal rst_tb           : std_logic;
   signal clk_tb           : std_logic;
   signal instruction_tb   : std_logic_vector(31 downto 0);
   signal rd_data_tb       : std_logic_vector(31 downto 0);
   signal wr_data_tb       : std_logic_vector(31 downto 0);
   signal rd_addr_tb       : std_logic_vector(7 downto 0);
   signal wr_addr_tb       : std_logic_vector(7 downto 0);
   signal wr_enable_tb     : std_logic;

begin

   inst_main : component main
   port map (
      i_rst          => rst_tb,
      i_clk          => clk_tb,
      i_instruction  => instruction_tb,
      o_rd_data      => rd_data_tb,
      o_wr_data      => wr_data_tb,
      o_rd_addr      => rd_addr_tb,
      o_wr_addr      => wr_addr_tb,
      o_wr_enable    => wr_enable_tb
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
