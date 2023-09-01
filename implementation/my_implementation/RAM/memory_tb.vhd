library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
   use std.env.all;
library memory_lib;
   use memory_lib.all;
   use memory_lib.memory_pkg.all;

entity memory_tb is
end memory_tb;

architecture tb of memory_tb is

   component memory is
   port (
      i_rst                : in std_logic;
      i_clk                : in std_logic;
      i_ram_addr           : in std_logic_vector(7 downto 0);
      i_write_enable       : in std_logic;
      i_data               : in std_logic_vector(31 downto 0);
      i_byte_number        : in std_logic_vector(3 downto 0);
      o_ram_data           : out std_logic_vector(31 downto 0)
   );
   end component memory;

   signal rst_tb              : std_logic;
   signal clk_tb              : std_logic;
   signal ram_addr_tb         : std_logic_vector(7 downto 0);
   signal write_enable_tb     : std_logic;
   signal data_tb             : std_logic_vector(31 downto 0);
   signal bytes_number_tb     : std_logic_vector(3 downto 0);
   signal ram_data_tb         : std_logic_vector(31 downto 0);

begin

   inst_memory : component memory
   port map (
      i_rst                => rst_tb,
      i_clk                => clk_tb,
      i_ram_addr           => ram_addr_tb,
      i_write_enable       => write_enable_tb,
      i_data               => data_tb,
      i_byte_number        => bytes_number_tb,
      o_ram_data           => ram_data_tb
   );

   p_clk : process
   begin
      clk_tb            <= '1';
      wait for 1 ns;
      clk_tb            <= '0';
      wait for 1 ns;
   end process p_clk;

   p_tb : process
   begin

      ram_addr_tb       <= (others => '0');
      write_enable_tb   <= C_READ_ENABLE;
      data_tb           <= (others => '0');
      bytes_number_tb   <= "0000";
      rst_tb            <= '1';
      wait for 10 ns;
      rst_tb            <= '0';
      write_enable_tb   <= C_WRITE_ENABLE;
      ----------------------
      ---- WRITE TO RAM ----
      ----------------------
      ---- SW instruction ----
      -- RAM[0]: 78 56 34 12
      bytes_number_tb   <= "1111";
      ram_addr_tb       <= 8d"0";
      data_tb           <= 32x"12345678";
      wait for 5 ns;
      ---- SH instruction ----
      -- RAM[1]: 78 56 -- --
      bytes_number_tb   <= "0011";
      ram_addr_tb       <= 8d"4";
      data_tb           <= 32x"12345678";
      wait for 5 ns;
      ---- SB instruction ----
      -- RAM[2]: 78 -- -- --
      bytes_number_tb   <= "0001";
      data_tb           <= 32x"12345678";
      ram_addr_tb       <= 8d"8";
      wait for 5 ns;
      --- Check saving to different addresses ---
      ---- SH instruction ----
      -- RAM[3]: -- -- 78 56
      bytes_number_tb   <= "0011";
      ram_addr_tb       <= 8d"14";
      data_tb           <= 32x"12345678";
      wait for 5 ns;
      ---- SB instruction ----
      -- RAM[4]: -- 78 -- --
      bytes_number_tb   <= "0010";
      ram_addr_tb       <= 8d"17";
      data_tb           <= 32x"12345678";
      wait for 5 ns;

      -----------------------
      ---- READ FROM RAM ----
      -----------------------
      ---- LW instruction ----
      -- RAM[0]: 78 56 34 12
   --   bytes_number_tb   <= C_STORE_WORD;
   --   ram_addr_tb       <= 8d"0";
  --    data_tb           <= 32x"12345678";
  --    wait for 5 ns;

      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
