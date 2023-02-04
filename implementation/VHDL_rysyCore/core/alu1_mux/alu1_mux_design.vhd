library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;


entity alu1_mux_design is
   port (
      rs1_d : in std_logic_vector(REG_LEN-1 downto 0);
      pc    : in std_logic_vector(REG_LEN-1 downto 0)

   );
end entity alu1_mux_design;

architecture rtl of alu1_mux_design is
begin

end architecture rtl;
