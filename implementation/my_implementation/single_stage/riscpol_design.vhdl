--------------------------------------------------------------------------------
-- File          : riscpol_design.vhdl
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : Main module. It connects all the modules together, such as 
-- the core and peripherals. The input and output ports of this module need to 
-- be connected to the physical pins of the FPGA to ensure the operation of the 
-- entire processor.
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;
library riscpol_lib;
   use riscpol_lib.all;
   use riscpol_lib.riscpol_pkg.all;
library ram_lib;
library gpio_lib;
library counter8bit_lib;
library mmio_lib;
library core_lib;
   use core_lib.all;


entity riscpol is
   port (
      i_rst                   : in std_logic;
      i_clk                   : in std_logic;
      o_gpio                  : out std_logic_vector(7 downto 0)
   );
end entity riscpol;


architecture rtl of riscpol is


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

   component mmio is
      port (
         i_mmio_write_enable  : in std_logic;
         i_mmio_waddr         : in integer range 0 to C_RAM_LENGTH-1;
         i_mmio_raddr         : in integer range 0 to C_RAM_LENGTH-1;
         i_mmio_data_gpio     : in std_logic_vector(7 downto 0);
         i_mmio_data_counter8 : in integer range 0 to 255;--G_COUNTER_VALUE - 1;
         i_mmio_data_ram      : in std_logic_vector(31 downto 0);
         o_mmio_we_ram        : out std_logic;
         o_mmio_we_gpio       : out std_logic;
         o_mmio_we_cnt8bit    : out std_logic;
         o_mmio_data          : out std_logic_vector(31 downto 0)
   );
   end component mmio;

   component byte_enabled_simple_dual_port_ram is
      generic (
         ADDR_WIDTH           : natural := C_RAM_LENGTH;
         BYTE_WIDTH           : natural := C_RAM_BYTE_WIDTH;
         BYTES                : natural := C_RAM_BYTES
      );
      port (
         i_clk                : in  std_logic;
         i_ram_we             : in  std_logic;
         i_ram_be             : in  std_logic_vector (BYTES - 1 downto 0);
         i_ram_wdata          : in  std_logic_vector(BYTES*BYTE_WIDTH-1 downto 0);
         i_ram_waddr          : in  integer range 0 to ADDR_WIDTH - 1;
         i_ram_raddr          : in  integer range 0 to ADDR_WIDTH - 1;
         o_ram_data           : out std_logic_vector(BYTES*BYTE_WIDTH-1 downto 0)
      );
   end component byte_enabled_simple_dual_port_ram;


   component gpio is
      port (
         i_clk                : in std_logic;
         i_gpio_addr          : in integer range 0 to C_RAM_LENGTH-1;
         i_gpio_wdata         : in std_logic_vector(31 downto 0);
         i_gpio_we            : in std_logic;
         o_gpio_q             : out std_logic_vector(7 downto 0)
      );
   end component gpio;
   
   
   component counter8 is
      generic(
         G_COUNTER_VALUE      : positive := 256
      ); port(
         i_clk                : in std_logic;
         i_rst                : in std_logic;
         i_cnt8_addr          : in integer range 0 to C_RAM_LENGTH-1;
         i_cnt8_we            : in std_logic;
         o_cnt8_q             : out integer range 0 to G_COUNTER_VALUE - 1
   );
   end component counter8;

   -- General
   signal rst                 : std_logic;
   signal clk                 : std_logic;
   -- MMIO
   signal s_mmio_we_ram       : std_logic;
   signal s_mmio_we_gpio      : std_logic;
   signal s_mmio_we_cnt8bit   : std_logic;
   signal s_mmio_data         : std_logic_vector(31 downto 0);
   -- Core
   signal s_core_data_write   : std_logic_vector(31 downto 0);
   signal s_core_write_enable : std_logic;
   signal s_core_byte_enable  : std_logic_vector(3 downto 0);
   signal s_core_addr_read    : integer range 0 to C_RAM_LENGTH-1;
   signal s_core_addr_write   : integer range 0 to C_RAM_LENGTH-1;
   -- RAM
   signal s_ram_q             : std_logic_vector(31 downto 0);
   -- Counter
   signal s_cnt8_q            : integer range 0 to 256 - 1; -- Try with constant
   -- GPIO
   signal q_gpio              : std_logic_vector(7 downto 0);

begin

   inst_core : component core
   port map (
      i_rst                => rst,
      i_clk                => clk,
      i_core_data_read     => s_mmio_data,
      o_core_data_write    => s_core_data_write,
      o_core_write_enable  => s_core_write_enable,
      o_core_byte_enable   => s_core_byte_enable,
      o_core_addr_read     => s_core_addr_read,
      o_core_addr_write    => s_core_addr_write
   );

   inst_mmio : component mmio
   port map (
      i_mmio_write_enable  => s_core_write_enable,
      i_mmio_waddr         => s_core_addr_write,
      i_mmio_raddr         => s_core_addr_read,
      o_mmio_we_ram        => s_mmio_we_ram,
      o_mmio_we_gpio       => s_mmio_we_gpio,
      o_mmio_we_cnt8bit    => s_mmio_we_cnt8bit,
      o_mmio_data          => s_mmio_data,
      i_mmio_data_gpio     => q_gpio,
      i_mmio_data_counter8 => s_cnt8_q,
      i_mmio_data_ram      => s_ram_q
   );

   inst_ram : component byte_enabled_simple_dual_port_ram
   port map (
      i_clk                => clk,
      i_ram_raddr          => s_core_addr_read,
      i_ram_waddr          => s_core_addr_write,
      i_ram_we             => s_mmio_we_ram,
      i_ram_wdata          => s_core_data_write,
      i_ram_be             => s_core_byte_enable,
      o_ram_data           => s_ram_q
   );

   inst_gpio : component gpio
   port map (
      i_clk                => clk,
      i_gpio_addr          => s_core_addr_write,
      i_gpio_wdata         => s_core_data_write,
      i_gpio_we            => s_mmio_we_gpio,
      o_gpio_q             => q_gpio
   );
    
   inst_counter8bit : component counter8
   generic map(
      G_COUNTER_VALUE      => 256
   )
   port map (
      i_clk                => clk,
      i_rst                => rst,
      i_cnt8_addr          => s_core_addr_write,
      i_cnt8_we            => s_mmio_we_cnt8bit,
      o_cnt8_q             => s_cnt8_q
   );

   o_gpio   <= q_gpio;
   rst      <= (i_rst);
   clk      <= i_clk;

end architecture rtl;
