library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity imm_mux_tb is
end imm_mux_tb;

architecture tb of imm_mux_tb is

   component imm_mux is
   port (
   );
   end component imm_mux;
 
begin

   inst_imm_mux : component imm_mux 
   port map (
   );

   imm_mux_tb : process
   begin

      wait for 25 ns;
      stop(2); 
   end process imm_mux_tb;

end architecture tb;
