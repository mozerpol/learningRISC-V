library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity decode_tb is
end decode_tb;

architecture tb of decode_tb is

   component decode is
   port (
   );
   end component decode;

 
begin

   inst_decode : component decode 
   port map (
   );

   decode_tb : process
   begin

      wait for 25 ns;
      stop(2); 
   end process decode_tb;

end architecture tb;
