library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
library byte_enabled_simple_dual_port_ram_lib;
   use byte_enabled_simple_dual_port_ram_lib.all;
   use byte_enabled_simple_dual_port_ram_lib.byte_enabled_simple_dual_port_ram_pkg.all;


entity byte_enabled_simple_dual_port_ram is
   generic (
      ADDR_WIDTH  : integer := 8;
      BYTE_WIDTH  : integer := 8;
      BYTES       : integer := 4;
      WIDTH       : integer := BYTES*BYTE_WIDTH
   );
   port (
      clk   : in std_logic;
      raddr : in std_logic_vector(ADDR_WIDTH-1 downto 0);
      waddr : in std_logic_vector(ADDR_WIDTH-1 downto 0);
      be    : in std_logic_vector(BYTES-1 downto 0);
      wdata : in t_array(BYTES-1 downto 0)(BYTE_WIDTH-1 downto 0);
      we    : in std_logic;
      q     : out std_logic_vector(WIDTH-1 downto 0)
   );
end entity byte_enabled_simple_dual_port_ram;

architecture rtl of byte_enabled_simple_dual_port_ram is

begin


end architecture rtl;
