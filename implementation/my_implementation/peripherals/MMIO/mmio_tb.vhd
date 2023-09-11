library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
   use std.env.all;
library mmio_lib;
   use mmio_lib.all;
   use mmio_lib.mmio_pkg.all;

entity mmio_tb is
end mmio_tb;

architecture tb of mmio_tb is

   component mmio is
      port (
   );
   end component mmio;


begin

   inst_mmio : component mmio
   port map (
   );


   p_tb : process
   begin

      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
