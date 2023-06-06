library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library rysy_lib;
   use rysy_lib.all;
   use rysy_lib.rysy_pkg.all;
library rysy_core_lib;
   use rysy_core_lib.all;
   use rysy_core_lib.rysy_core_pkg.all;
library bus_interconnect_lib;
   use bus_interconnect_lib.all;
   use bus_interconnect_lib.bus_interconnect_pkg.all;
library byte_enabled_simple_dual_port_ram_lib;
   use byte_enabled_simple_dual_port_ram_lib.all;
   use byte_enabled_simple_dual_port_ram_lib.byte_enabled_simple_dual_port_ram_pkg.all;
library gpio_lib;
   use gpio_lib.all;
   use gpio_lib.gpio_pkg.all;

entity rysy is
   generic (
      CODE    : string  := "ram_content_hex.txt"
   );
   port (
      i_clk   : in std_logic;
      i_rst   : in std_logic;
      o_gpio  : out std_logic_vector(3 downto 0)
   );
end entity rysy;

architecture rtl of rysy is

   signal addr       : std_logic_vector(WIDTH-1 downto 0);
   signal rdata      : std_logic_vector(WIDTH-1 downto 0);
   signal rdata_ram  : std_logic_vector(WIDTH-1 downto 0);
   signal rdata_gpio : std_logic_vector(WIDTH-1 downto 0);
   signal wdata      : std_logic_vector(WIDTH-1 downto 0);
   signal be         : std_logic_vector(3 downto 0);
   signal we         : std_logic;
   signal we_ram     : std_logic;
   signal we_gpio    : std_logic;

   component rysy_core_design is
   port(
      clk      : in std_logic;
      rst      : in std_logic;
      rdata    : in std_logic_vector (REG_LEN-1 downto 0);
      wdata    : out std_logic_vector(REG_LEN-1 downto 0);
      addr     : out std_logic_vector(REG_LEN-1 downto 0);
      we       : out std_logic;
      be       : out std_logic_vector(3 downto 0)
   );
   end component rysy_core_design;

   component bus_interconnect is
   generic (
      WIDTH : integer := 32
   );
   port (
      clk         : in std_logic;
      addr        : in std_logic_vector(WIDTH-1 downto 0);
      rdata_gpio  : in std_logic_vector(WIDTH-1 downto 0);
      rdata_ram   : in std_logic_vector(WIDTH-1 downto 0);
      we          : in std_logic;
      rdata       : out std_logic_vector(WIDTH-1 downto 0);
      we_ram      : out std_logic;
      we_gpio     : out std_logic
   );
   end component bus_interconnect;
   
   component byte_enabled_simple_dual_port_ram is
   generic (
      CODE        : string  := "ram_content_hex.txt";
      ADDR_WIDTH  : integer := 8;
      BYTE_WIDTH  : integer := 8;
      BYTES       : integer := 4;
      WIDTH       : integer := 32 -- BYTES*BYTE_WIDTH
   );
   port (
      clk   : in std_logic;
      raddr : in std_logic_vector(ADDR_WIDTH-1 downto 0);
      waddr : in std_logic_vector(ADDR_WIDTH-1 downto 0);
      be    : in std_logic_vector(BYTES-1 downto 0);
      wdata : in std_logic_vector(WIDTH-1 downto 0);
      we    : in std_logic;
      q     : out std_logic_vector(WIDTH-1 downto 0)
   );
   end component byte_enabled_simple_dual_port_ram;

   component gpio is
   port (
      addr  : in std_logic_vector(7 downto 0);
      be    : in std_logic_vector(3 downto 0);
      wdata : in std_logic_vector(31 downto 0);
      we    : in std_logic;
      clk   : in std_logic;
      rst   : in std_logic;
      gpio  : out std_logic_vector(3 downto 0);
      q     : out std_logic_vector(31 downto 0)
   );
   end component gpio;

begin

   inst_core : component rysy_core_design
   port map(
      clk   => i_clk,
      rst   => i_rst,
      rdata => rdata,
      wdata => wdata,
      addr  => addr,
      we    => we,
      be    => be
   );
   
   inst_bus_interconnect : component bus_interconnect
   generic map(
      WIDTH => WIDTH
   )
   port map(
      clk         => i_clk,
      addr        => addr,
      rdata_gpio  => rdata_gpio,
      rdata_ram   => rdata_ram,
      we          => we,
      rdata       => rdata,
      we_ram      => we_ram,   
      we_gpio     => we_gpio
   );

   inst_byte_enabled_simple_dual_port_ram : component byte_enabled_simple_dual_port_ram
   generic map(
      CODE        => "ram_content_hex.txt",
      ADDR_WIDTH  => 8,
      BYTE_WIDTH  => 8,
      BYTES       => 4,
      WIDTH       => 32
   )
   port map(
      clk   => i_clk,
      raddr => addr(9 downto 2), 
      waddr => addr(9 downto 2),
      be    => be,
      wdata => wdata,
      we    => we_ram,
      q     => rdata_ram
   );

   inst_gpio : component gpio
   port map(
      addr  => addr(9 downto 2),
      be    => be,
      wdata => wdata,
      we    => we_gpio,
      clk   => i_clk,
      rst   => i_rst,
      q     => rdata_gpio,
      gpio  => o_gpio
   );


end architecture rtl;
