--------------------------------------------------------------------------------
-- File          : mozerpol_design.vhd
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : It connects all the modules together, such as the core and
-- peripherals. The ports of this module need to be connected to the physical
-- pins of the FPGA to ensure the operation of the entire processor.
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library mozerpol_lib;
   use mozerpol_lib.all;
   use mozerpol_lib.mozerpol_pkg.all;
library ram_lib;
library gpio_lib;
library core_lib;
   use core_lib.all;


entity mozerpol is
   port (
      i_rst    : in std_logic;
      i_clk    : in std_logic;
      o_gpio   : out std_logic_vector(3 downto 0)
   );
end entity mozerpol;


architecture rtl of mozerpol is


   component core is
      port (
         i_rst                : in std_logic;
         i_clk                : in std_logic;
         i_core_data_read     : in std_logic_vector(31 downto 0);
         o_core_data_write    : out std_logic_vector(31 downto 0);
         o_core_write_enable  : out std_logic;
         o_core_byte_enable   : out std_logic_vector(3 downto 0);
         o_core_addr_read     : out integer range 0 to C_RAM_LENGTH-1;
         o_core_addr_write    : out integer range 0 to C_RAM_LENGTH-1
      );
   end component core;


   component byte_enabled_simple_dual_port_ram is
      generic (
         ADDR_WIDTH : natural := C_RAM_LENGTH;
         BYTE_WIDTH : natural := 8;
         BYTES      : natural := 4
      );
      port (
         we, clk : in  std_logic;
         be      : in  std_logic_vector (BYTES - 1 downto 0);
         wdata   : in  std_logic_vector(BYTES*BYTE_WIDTH-1 downto 0);
         waddr   : in  integer range 0 to ADDR_WIDTH-1;
         raddr   : in  integer range 0 to ADDR_WIDTH-1;
         q       : out std_logic_vector(BYTES*BYTE_WIDTH-1 downto 0)
      );
   end component byte_enabled_simple_dual_port_ram;


   component gpio is
      port (
         i_clk    : in std_logic;
         i_addr   : in integer range 0 to C_RAM_LENGTH-1;
         i_wdata  : in std_logic_vector(31 downto 0);
         o_gpio   : out std_logic_vector(3 downto 0)
      );
   end component gpio;


   -- General
   signal rst                 : std_logic;
   signal clk                 : std_logic;
   -- core
   signal core_data_write     : std_logic_vector(31 downto 0);
   signal core_write_enable   : std_logic;
   signal core_byte_enable    : std_logic_vector(3 downto 0);
   signal core_addr_read      : integer range 0 to C_RAM_LENGTH-1;
   signal core_addr_write     : integer range 0 to C_RAM_LENGTH-1;
   -- RAM
   signal ram_q               : std_logic_vector(31 downto 0);

begin

   inst_core : component core
   port map (
      i_rst                => rst,
      i_clk                => clk,
      i_core_data_read     => ram_q,
      o_core_data_write    => core_data_write,
      o_core_write_enable  => core_write_enable,
      o_core_byte_enable   => core_byte_enable,
      o_core_addr_read     => core_addr_read,
      o_core_addr_write    => core_addr_write
   );

   inst_memory : component byte_enabled_simple_dual_port_ram
   port map (
      clk   => clk,
      raddr => core_addr_read,
      waddr => core_addr_write,
      we    => core_write_enable,
      wdata => core_data_write,
      be    => core_byte_enable,
      q     => ram_q
   );

    inst_gpio : component gpio
    port map (
       i_clk   => clk,
       i_addr  => core_addr_write,
       i_wdata => core_data_write,
       o_gpio  => o_gpio
    );

   rst <= i_rst;
   clk <= i_clk;

end architecture rtl;
