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
library core_lib;
   use core_lib.all;
library ram_lib;
library gpio_lib;
library counter1_lib;
library mmio_lib;
library uart_lib;
library seven_segment_lib;
library spi_lib;


entity riscpol is
   port (
      i_rst_n                 : in std_logic;
      i_clk                   : in std_logic;
      io_gpio                 : inout std_logic_vector(C_NUMBER_OF_GPIO - 1 downto 0);
      i_uart_rx               : in std_logic;
      o_uart_tx               : out std_logic;
      o_7segment_1            : out std_logic_vector(6 downto 0);
      o_7segment_2            : out std_logic_vector(6 downto 0);
      o_7segment_3            : out std_logic_vector(6 downto 0);
      o_7segment_4            : out std_logic_vector(6 downto 0);
      o_7segment_anodes       : out std_logic_vector(3 downto 0);
      i_spi_miso              : in std_logic;
      o_spi_mosi              : out std_logic;
      o_spi_ss_n              : out std_logic;
      o_spi_sclk              : out std_logic
   );
end entity riscpol;


architecture rtl of riscpol is


   component core is
      port (
         i_rst_n              : in std_logic;
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
         i_mmio_q_gpio        : in std_logic_vector(31 downto 0);
         i_mmio_q_cnt1        : in integer range 0 to C_COUNTER1_VALUE - 1;
         i_mmio_data_ram      : in std_logic_vector(31 downto 0);
         i_mmio_data_uart     : in std_logic_vector(31 downto 0);
         i_mmio_status_uart   : in std_logic_vector(31 downto 0);
         i_mmio_data_spi      : in std_logic_vector(31 downto 0);
         i_mmio_status_spi    : in std_logic_vector(31 downto 0);
         o_mmio_we_ram        : out std_logic;
         o_mmio_we_gpio       : out std_logic;
         o_mmio_re_gpio       : out std_logic;
         o_mmio_we_cnt1       : out std_logic;
         o_mmio_we_uart       : out std_logic;
         o_mmio_we_7seg       : out std_logic;
         o_mmio_we_spi        : out std_logic;
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
         i_rst_n              : in std_logic;
         i_clk                : in std_logic;
         i_gpio_wdata         : in std_logic_vector(31 downto 0);
         i_gpio_we            : in std_logic;
         i_gpio_re            : in std_logic;
         o_gpio_q             : out std_logic_vector(31 downto 0)
      );
   end component gpio;


   component counter1 is
      generic(
         G_COUNTER1_VALUE     : positive := C_COUNTER1_VALUE - 1
      );
      port(
         i_rst_n              : in std_logic;
         i_clk                : in std_logic;
         i_cnt1_we            : in std_logic;
         i_cnt1_set_reset     : in std_logic;
         o_cnt1_overflow      : out std_logic;
         o_cnt1_q             : out integer range 0 to C_COUNTER1_VALUE - 1
   );
   end component counter1;


   component seven_segment is
      port (
         i_rst_n           : in std_logic;
         i_clk             : in std_logic;
         i_7segment_wdata  : in std_logic_vector(31 downto 0);
         i_7segment_we     : in std_logic;
         o_7segment_1      : out std_logic_vector(6 downto 0);
         o_7segment_2      : out std_logic_vector(6 downto 0);
         o_7segment_3      : out std_logic_vector(6 downto 0);
         o_7segment_4      : out std_logic_vector(6 downto 0);
         o_7segment_anodes : out std_logic_vector(3 downto 0)
   );
   end component seven_segment;


   component uart is
      generic(
         G_BAUD               : positive := C_BAUD
      );
      port(
         i_rst_n              : in std_logic;
         i_clk                : in std_logic;
         i_uart_wdata         : in std_logic_vector(31 downto 0);
         i_uart_rx            : in std_logic;
         i_uart_we            : in std_logic;
         o_uart_data          : out std_logic_vector(31 downto 0);
         o_uart_status        : out std_logic_vector(31 downto 0);
         o_uart_tx            : out std_logic
   );
   end component uart;


   component spi is
      generic(
         G_SPI_FREQUENCY_HZ   : positive := C_SPI_FREQUENCY_HZ
      );
      port (
         i_rst_n              : in std_logic;
         i_clk                : in std_logic;
         i_spi_wdata          : in std_logic_vector(31 downto 0);
         i_spi_we             : in std_logic;
         i_spi_control        : in std_logic_vector(7 downto 0);
         i_spi_miso           : in std_logic;  -- master in, slave out
         o_spi_ss_n           : out std_logic; -- slave select / chip select
         o_spi_mosi           : out std_logic; -- master out, slave in
         o_spi_sclk           : out std_logic;
         o_spi_data           : out std_logic_vector(31 downto 0);
         o_spi_status         : out std_logic_vector(31 downto 0)
   );
   end component spi;


   -- General
   signal rst_n               : std_logic;
   signal clk                 : std_logic;
   -- MMIO
   signal s_mmio_we_ram       : std_logic;
   signal s_mmio_we_gpio      : std_logic;
   signal s_mmio_re_gpio      : std_logic;
   signal s_mmio_we_cnt1      : std_logic;
   signal s_mmio_we_spi       : std_logic;
   signal s_mmio_data         : std_logic_vector(31 downto 0);
   signal s_mmio_data_uart    : std_logic_vector(31 downto 0);
   signal s_mmio_status_uart  : std_logic_vector(31 downto 0);
   signal s_mmio_data_spi     : std_logic_vector(31 downto 0);
   signal s_mmio_status_spi   : std_logic_vector(31 downto 0);
   signal s_mmio_we_uart      : std_logic;
   signal s_mmio_we_7seg      : std_logic;
   -- Core
   signal s_core_data_write   : std_logic_vector(31 downto 0);
   signal s_core_write_enable : std_logic;
   signal s_core_byte_enable  : std_logic_vector(3 downto 0);
   signal s_core_addr_read    : integer range 0 to C_RAM_LENGTH-1;
   signal s_core_addr_write   : integer range 0 to C_RAM_LENGTH-1;
   -- RAM
   signal s_ram_q             : std_logic_vector(31 downto 0);
   -- Counter1
   signal s_cnt1_q            : integer range 0 to C_COUNTER1_VALUE - 1;
   signal s_cnt1_overflow     : std_logic;
   -- GPIO
   signal s_q_gpio            : std_logic_vector(31 downto 0);
   -- UART
   signal s_uart_tx           : std_logic;
   signal s_uart_data         : std_logic_vector(31 downto 0);
   signal s_uart_status       : std_logic_vector(31 downto 0);
   -- 7 segment
   signal s_7segment_1        : std_logic_vector(6 downto 0);
   signal s_7segment_2        : std_logic_vector(6 downto 0);
   signal s_7segment_3        : std_logic_vector(6 downto 0);
   signal s_7segment_4        : std_logic_vector(6 downto 0);
   signal s_7segment_anodes   : std_logic_vector(3 downto 0);
   -- SPI
   signal s_spi_ss_n          : std_logic;
   signal s_spi_mosi          : std_logic;
   signal s_spi_miso          : std_logic;
   signal s_spi_sclk          : std_logic;


begin


   inst_core        : component core
   port map (
      i_rst_n              => rst_n,
      i_clk                => clk,
      i_core_data_read     => s_mmio_data,
      o_core_data_write    => s_core_data_write,
      o_core_write_enable  => s_core_write_enable,
      o_core_byte_enable   => s_core_byte_enable,
      o_core_addr_read     => s_core_addr_read,
      o_core_addr_write    => s_core_addr_write
   );


   inst_mmio        : component mmio
   port map (
      i_mmio_write_enable  => s_core_write_enable,
      i_mmio_waddr         => s_core_addr_write,
      i_mmio_raddr         => s_core_addr_read,
      i_mmio_q_gpio(31 downto C_NUMBER_OF_GPIO)   => (others => '0'),
      i_mmio_q_gpio(C_NUMBER_OF_GPIO -1 downto 0) =>
                                       io_gpio(C_NUMBER_OF_GPIO - 1 downto 0),
      i_mmio_q_cnt1        => s_cnt1_q,
      i_mmio_data_ram      => s_ram_q,
      i_mmio_data_uart     => s_uart_data,
      i_mmio_status_uart   => s_uart_status,
      i_mmio_data_spi      => s_mmio_data_spi,
      i_mmio_status_spi    => s_mmio_status_spi,
      o_mmio_we_ram        => s_mmio_we_ram,
      o_mmio_we_gpio       => s_mmio_we_gpio,
      o_mmio_re_gpio       => s_mmio_re_gpio,
      o_mmio_we_cnt1       => s_mmio_we_cnt1,
      o_mmio_we_uart       => s_mmio_we_uart,
      o_mmio_we_7seg       => s_mmio_we_7seg,
      o_mmio_we_spi        => s_mmio_we_spi,
      o_mmio_data          => s_mmio_data
   );


   inst_ram         : component byte_enabled_simple_dual_port_ram
   port map (
      i_clk                => clk,
      i_ram_raddr          => s_core_addr_read,
      i_ram_waddr          => s_core_addr_write,
      i_ram_we             => s_mmio_we_ram,
      i_ram_wdata          => s_core_data_write,
      i_ram_be             => s_core_byte_enable,
      o_ram_data           => s_ram_q
   );


   inst_gpio        : component gpio
   port map (
      i_rst_n              => rst_n,
      i_clk                => clk,
      i_gpio_wdata         => s_core_data_write,
      i_gpio_we            => s_mmio_we_gpio,
      i_gpio_re            => s_mmio_re_gpio,
      o_gpio_q             => s_q_gpio
   );


   inst_counter1    : component counter1
   port map (
      i_rst_n              => rst_n,
      i_clk                => clk,
      i_cnt1_we            => s_mmio_we_cnt1,
      i_cnt1_set_reset     => s_core_data_write(24),
      o_cnt1_overflow      => open,
      o_cnt1_q             => s_cnt1_q
   );


   inst_uart        : component uart
   port map (
      i_rst_n              => rst_n,
      i_clk                => clk,
      i_uart_wdata         => s_core_data_write,
      i_uart_rx            => i_uart_rx,
      i_uart_we            => s_mmio_we_uart,
      o_uart_data          => s_uart_data,
      o_uart_status        => s_uart_status,
      o_uart_tx            => s_uart_tx
   );


   inst_seven_segment : component seven_segment
   port map (
      i_rst_n              => rst_n,
      i_clk                => clk,
      i_7segment_wdata     => s_core_data_write,
      i_7segment_we        => s_mmio_we_7seg,
      o_7segment_1         => s_7segment_1,
      o_7segment_2         => s_7segment_2,
      o_7segment_3         => s_7segment_3,
      o_7segment_4         => s_7segment_4,
      o_7segment_anodes    => s_7segment_anodes
   );


   inst_spi          : component spi
   port map (
      i_rst_n              => rst_n,
      i_clk                => clk,
      i_spi_wdata          => s_core_data_write,
      i_spi_we             => s_mmio_we_spi,
      i_spi_miso           => s_spi_miso,
      i_spi_control        => s_core_data_write(7 downto 0),
      o_spi_ss_n           => s_spi_ss_n,
      o_spi_mosi           => s_spi_mosi,
      o_spi_sclk           => s_spi_sclk,
      o_spi_data           => s_mmio_data_spi,
      o_spi_status         => s_mmio_status_spi
   );


   rst_n                   <= i_rst_n;
   clk                     <= i_clk;
   io_gpio                 <= s_q_gpio(C_NUMBER_OF_GPIO - 1 downto 0);
   o_uart_tx               <= s_uart_tx;
   o_7segment_1            <= s_7segment_1;
   o_7segment_2            <= s_7segment_2;
   o_7segment_3            <= s_7segment_3;
   o_7segment_4            <= s_7segment_4;
   o_7segment_anodes       <= s_7segment_anodes;
   o_spi_mosi              <= s_spi_mosi;
   o_spi_ss_n              <= s_spi_ss_n;
   o_spi_sclk              <= s_spi_sclk;


end architecture rtl;
