library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
   use std.env.all;

entity core_tb is
end core_tb;


architecture tb of core_tb is

   component core is
   port (
      i_rst                : in std_logic;
      i_clk                : in std_logic;
      i_core_data_read     : in std_logic_vector(31 downto 0);
      o_core_data_write    : out std_logic_vector(31 downto 0);
      o_core_write_enable  : out std_logic;
      o_core_byte_enable   : out std_logic_vector(3 downto 0);
      o_core_addr_read     : out integer range 0 to 63;
      o_core_addr_write    : out integer range 0 to 63
   );
   end component core;

   signal rst_tb              : std_logic;
   signal clk_tb              : std_logic;
   signal ram_data_read_tb    : std_logic_vector(31 downto 0);
   signal ram_data_write_tb   : std_logic_vector(31 downto 0);
   signal ram_write_enable_tb : std_logic;
   signal ram_byte_enable_tb  : std_logic_vector(3 downto 0);
   signal ram_addr_read_tb    : integer range 0 to 63;
   signal ram_addr_write_tb   : integer range 0 to 63;

  -- type t_gpr  is array(0 to 31) of std_logic_vector(31 downto 0);
  -- alias spy_gpr is <<signal .core_tb.inst_core.inst_reg_file.gpr: t_gpr >>;

begin

   inst_core : component core
   port map (
      i_rst                => rst_tb,
      i_clk                => clk_tb,
      i_core_data_read     => ram_data_read_tb,
      o_core_data_write    => ram_data_write_tb,
      o_core_write_enable  => ram_write_enable_tb,
      o_core_byte_enable   => ram_byte_enable_tb,
      o_core_addr_read     => ram_addr_read_tb,
      o_core_addr_write    => ram_addr_write_tb
   );

   p_clk : process
   begin
      clk_tb   <= '1';
      wait for 1 ns;
      clk_tb   <= '0';
      wait for 1 ns;
   end process;

   p_tb : process
   begin

      rst_tb            <= '1';
      ram_data_read_tb  <= (others => '0');
      wait for 20 ns;
      rst_tb            <= '0';
      ram_data_read_tb  <= 32x"00001103";
      wait until rising_edge(clk_tb);

      wait for 35 ns;
      stop(2);
   end process p_tb;

end architecture tb;
