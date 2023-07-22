library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library mux_reg_file_lib;
   use mux_reg_file_lib.all;
   use mux_reg_file_lib.mux_reg_file_pkg.all;

entity mux_reg_file is
   port (
      i_rst             : in std_logic
   );
end entity mux_reg_file;

architecture rtl of mux_reg_file is

begin

end architecture rtl;
