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
      i_rst                : in std_logic;
      i_clk                : in std_logic;
      i_ram_read_addr      : in std_logic_vector(7 downto 0);
      i_ram_write_addr     : in std_logic_vector(7 downto 0);
      i_ram_write_data     : in std_logic_vector(31 downto 0);
      i_ram_write_enable   : in std_logic;
      o_instruction        : out std_logic_vector(31 downto 0)
   );
   end component memory;

   signal rst_tb              : std_logic;
   signal clk_tb              : std_logic;
   signal ram_read_addr_tb    : std_logic_vector(7 downto 0);
   signal ram_write_addr_tb   : std_logic_vector(7 downto 0);
   signal ram_write_data_tb   : std_logic_vector(31 downto 0);
   signal ram_write_enable_tb : std_logic;
   signal instruction_tb      : std_logic_vector(31 downto 0);

begin

   inst_memory : component memory
   port map (
      i_rst                => rst_tb,
      i_clk                => clk_tb,
      i_ram_read_addr      => ram_read_addr_tb,
      i_ram_write_addr     => ram_write_addr_tb,
      i_ram_write_data     => ram_write_data_tb,
      i_ram_write_enable   => ram_write_enable_tb,
      o_instruction        => instruction_tb
   );

   p_clk : process
   begin
      clk_tb               <= '1';
      wait for 1 ns;
      clk_tb               <= '0';
      wait for 1 ns;
   end process p_clk;

   p_tb : process
   begin
      ram_read_addr_tb     <= (others => '0');
      ram_write_addr_tb    <= (others => '0');
      ram_write_data_tb    <= (others => '0');
      ram_write_enable_tb  <= '0';
      rst_tb               <= '1';
      wait for 5 ns;
      rst_tb               <= '0';

      ram_write_enable_tb  <= '0';
      ram_read_addr_tb     <= 8d"0";
      wait for 5 ns;

      ram_read_addr_tb     <= 8d"1";
      wait for 5 ns;

      ram_read_addr_tb     <= 8d"2";
      wait for 5 ns;

      ram_read_addr_tb     <= 8d"3";
      wait for 5 ns;

      ram_write_enable_tb  <= '1';
      ram_write_data_tb    <= 32x"00000000";
      ram_write_addr_tb    <= 8d"0";
      wait for 5 ns;

      ram_write_data_tb    <= 32x"00000001";
      ram_write_addr_tb    <= 8d"1";
      wait for 5 ns;

      ram_write_data_tb    <= 32x"00000002";
      ram_write_addr_tb    <= 8d"2";
      wait for 5 ns;

      ram_write_data_tb    <= 32x"00000003";
      ram_write_addr_tb    <= 8d"3";

      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
