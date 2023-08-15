library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library main_lib;
   use main_lib.all;
   use main_lib.main_pkg.all;
library memory_lib;
   use memory_lib.all;
   use memory_lib.memory_pkg.all;
library core_lib;
   use core_lib.all;
   use core_lib.core_pkg.all;


entity main is
   port (
      i_rst     : in std_logic;
      i_clk     : in std_logic
      -- Maybe will be GPIO handler in the future
   );
end entity main;


architecture rtl of main is


   component core is
      port (
      i_rst                : in std_logic;
      i_clk                : in std_logic;
      i_ram_data_read      : in std_logic_vector(31 downto 0);
      o_ram_data_write     : out std_logic_vector(31 downto 0);
      o_ram_addr           : out std_logic_vector(7 downto 0);
      o_write_enable       : out std_logic
      );
   end component core;


   component memory is
      port (
      i_rst                : in std_logic;
      i_clk                : in std_logic;
      i_ram_addr           : in std_logic_vector(7 downto 0);
      i_write_enable       : in std_logic;
      i_data               : in std_logic_vector(31 downto 0);
      o_ram_data           : out std_logic_vector(31 downto 0)
      );
   end component memory;


   -- General
   signal rst                    : std_logic;
   signal clk                    : std_logic;
   -- core
   signal ram_data_read_core     : std_logic_vector(31 downto 0);
   signal ram_data_write_core    : std_logic_vector(31 downto 0);
   signal ram_addr_core          : std_logic_vector(7 downto 0);
   signal write_enable_core      : std_logic;
   -- RAM
   signal ram_addr_memory        : std_logic_vector(7 downto 0);
   signal write_enable_memory    : std_logic;
   signal data_memory            : std_logic_vector(31 downto 0);
   signal ram_data_memory        : std_logic_vector(31 downto 0);


begin

   inst_core : component core
   port map (
      i_rst             => rst,
      i_clk             => clk,
      -- TODO: remove "ram" prefix, it's confusing, add sufix core instead
      i_ram_data_read   => ram_data_read_core,
      o_ram_data_write  => ram_data_write_core,
      o_ram_addr        => ram_addr_core,
      o_write_enable    => write_enable_core
   );

   inst_memory : component memory
   port map (
      i_rst             => rst,
      i_clk             => clk,
      i_ram_addr        => ram_addr_memory,
      i_write_enable    => write_enable_memory,
      i_data            => data_memory,
      o_ram_data        => ram_data_memory
   );

   rst                  <= i_rst;
   clk                  <= i_clk;
   ram_addr_memory      <= ram_addr_core;
   write_enable_memory  <= write_enable_core;
   data_memory          <= ram_data_write_core;
   ram_data_read_core   <= ram_data_memory;



   p_main : process(all)
   begin
      if (i_rst) then

      else

      end if;
   end process p_main;

end architecture rtl;
