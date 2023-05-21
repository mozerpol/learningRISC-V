library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use std.textio.all;
library byte_enabled_simple_dual_port_ram_lib;
   use byte_enabled_simple_dual_port_ram_lib.all;
   use byte_enabled_simple_dual_port_ram_lib.byte_enabled_simple_dual_port_ram_pkg.all;


entity byte_enabled_simple_dual_port_ram is
   generic (
      CODE        : string  := "ram_content_hex.txt";
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

   constant WORDS : integer := 256; -- Number of rows
   type t_array is array (WORDS-1 downto 0) of 
      std_logic_vector((ADDR_WIDTH*BYTES)-1 downto 0);

   impure function init_ram_hex return t_array is
      file text_file       : text open read_mode is CODE;
      variable text_line   : line;
      variable ram_content : t_array;
   begin
      for i in 0 to 7 loop  ---------------------- UP TO NUMBER OF LINES !!!!!
         readline(text_file, text_line);
         hread(text_line, ram_content(i));
      end loop;
      return ram_content;
   end function;

   signal ram : t_array := init_ram_hex;

begin


end architecture rtl;
