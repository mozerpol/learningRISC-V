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
library gpio_lib;
   use gpio_lib.all;
   use gpio_lib.gpio_pkg.all;
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
      i_core_data_read     : in std_logic_vector(31 downto 0);
      o_core_data_write    : out std_logic_vector(31 downto 0);
      o_core_write_enable  : out std_logic;
      o_core_byte_enable   : out std_logic_vector(3 downto 0);
      o_core_addr_read     : out std_logic_vector (5 downto 0);
      o_core_addr_write    : out std_logic_vector (5 downto 0)
      );
   end component core;


   component memory is
      port (
         clk   : in  std_logic;
         raddr : in  std_logic_vector (5 downto 0); -- address width = 6
         waddr : in  std_logic_vector (5 downto 0);
         we    : in  std_logic;
         wdata : in  std_logic_vector(31 downto 0); -- width = 32
         be    : in  std_logic_vector (3 downto 0); -- 4 bytes per word
         q     : out std_logic_vector(31 downto 0)
      );
   end component memory;
   
   
component gpio is
   port (
      i_clk    : in std_logic;
      i_addr   : in std_logic_vector(5 downto 0);
      i_wdata  : in std_logic_vector(31 downto 0);
      o_gpio   : out std_logic_vector(3 downto 0)
);
end component gpio;


   -- General
   signal rst                 : std_logic;
   signal clk                 : std_logic;
   -- core
   signal core_data_read      : std_logic_vector(31 downto 0);
   signal core_data_write     : std_logic_vector(31 downto 0);
   signal core_write_enable   : std_logic;
   signal core_byte_enable    : std_logic_vector(3 downto 0);
   signal core_addr_read      : std_logic_vector (5 downto 0);
   signal core_addr_write     : std_logic_vector (5 downto 0);
   -- RAM
   signal ram_raddr           : std_logic_vector (5 downto 0); -- address width = 6
   signal ram_waddr           : std_logic_vector (5 downto 0);
   signal ram_we              : std_logic;
   signal ram_wdata           : std_logic_vector(31 downto 0); -- width = 32
   signal ram_be              : std_logic_vector (3 downto 0); -- 4 bytes per word
   signal ram_q               : std_logic_vector(31 downto 0);
   -- GPIO
   signal gpio_addr   : std_logic_vector(5 downto 0);
   signal gpio_wdata  : std_logic_vector(31 downto 0);
   signal gpio_gpio   : std_logic_vector(3 downto 0);


begin

   inst_core : component core
   port map (
      i_rst                => rst,
      i_clk                => clk,
      i_core_data_read     => core_data_read,
      o_core_data_write    => core_data_write,
      o_core_write_enable  => core_write_enable,
      o_core_byte_enable   => core_byte_enable,
      o_core_addr_read     => core_addr_read,
      o_core_addr_write    => core_addr_write
   );

   inst_memory : component memory
   port map (
      clk   => clk,
      raddr => ram_raddr,
      waddr => ram_waddr,
      we    => ram_we,
      wdata => ram_wdata,
      be    => ram_be,
      q     => ram_q
   );
   
    inst_gpio : component gpio
    port map(
    i_clk  => clk,
    i_addr    =>gpio_addr,
    i_wdata  =>gpio_wdata,
    o_gpio    =>gpio_gpio
    );

   rst            <= i_rst;
   clk            <= i_clk;
   core_data_read <= ram_q;
   ram_raddr      <= core_addr_read;
   ram_waddr      <= core_addr_write;
   ram_we         <= core_write_enable;
   ram_wdata      <= core_data_write;
   ram_be         <= core_byte_enable;
   gpio_addr      <= core_addr_write;
   gpio_wdata     <= core_data_write;
   --gpio           <= 

end architecture rtl;
