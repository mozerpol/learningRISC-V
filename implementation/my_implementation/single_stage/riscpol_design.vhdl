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
library core_lib;
   use core_lib.all;


entity riscpol is
   port (
      i_rst    : in std_logic;
      i_clk    : in std_logic;
      o_gpio   : out std_logic_vector(7 downto 0)
      -- TODO: Add o_ov_t8bit to ports, as a one bit, only for overflow
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


   component byte_enabled_simple_dual_port_ram is
      generic (
         ADDR_WIDTH : natural := C_RAM_LENGTH;
         BYTE_WIDTH : natural := C_RAM_BYTE_WIDTH;
         BYTES      : natural := C_RAM_BYTES
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
         i_we     : in std_logic;
         o_gpio   : out std_logic_vector(7 downto 0)
      );
   end component gpio;
   
   
   component counter8 is
      generic(
         G_COUNTER_VALUE : positive := 255
      ); port(
         i_clk          : in std_logic;
         i_rst          : in std_logic;
         i_addr         : in integer range 0 to C_RAM_LENGTH-1;
         i_ce           : in std_logic;
         o_q_counter8   : out std_logic_vector(7 downto 0)
   );
   end component counter8;

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
   -- Counter
   signal q_counter8          : std_logic_vector(7 downto 0);

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
       i_we    => core_write_enable,
       o_gpio  => o_gpio
    );
    
    inst_counter8bit : component counter8
    generic map(
      G_COUNTER_VALUE => 255
    )
    port map (
       i_clk         => clk,
       i_rst         => rst,
       i_addr        => core_addr_write,
       i_ce          => core_data_write(24),
       o_q_counter8  => open
    );


   rst <= (i_rst);
   clk <= i_clk;

end architecture rtl;
