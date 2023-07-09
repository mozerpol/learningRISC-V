library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;

entity memory_tb is
end memory_tb;

architecture tb of memory_tb is

   component memory is
   port (
      i_rst       : in std_logic;
      i_clk       : in std_logic;
      i_rd_addr   : in std_logic_vector(7 downto 0);
      i_wr_addr   : in std_logic_vector(7 downto 0);
      i_wr_data   : in std_logic_vector(31 downto 0);
      i_wr_enable : in std_logic;
      o_q         : out std_logic_vector(31 downto 0)
   );
   end component memory;

      signal rst_tb        : std_logic;
      signal clk_tb        : std_logic;
      signal rd_addr_tb    : std_logic_vector(7 downto 0);
      signal wr_addr_tb    : std_logic_vector(7 downto 0);
      signal wr_data_tb    : std_logic_vector(31 downto 0);
      signal wr_enable_tb  : std_logic;
      signal q_tb          : std_logic_vector(31 downto 0);

begin

   inst_memory : component memory
   port map (
      i_rst       => rst_tb,
      i_clk       => clk_tb,
      i_rd_addr   => rd_addr_tb,
      i_wr_addr   => wr_addr_tb,
      i_wr_data   => wr_data_tb,
      i_wr_enable => wr_enable_tb,
      o_q         => q_tb
   );

   p_clk : process
   begin
      clk_tb <= '1';
      wait for 1 ns;
      clk_tb <= '0';
      wait for 1 ns;
   end process p_clk;

   p_tb : process
   begin
      rst_tb   <= '1';
      wait for 5 ns;
      rst_tb   <= '0';

      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
