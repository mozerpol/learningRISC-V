library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;

entity decoder_tb is
end decoder_tb;

architecture tb of decoder_tb is

   component decoder is
   port (
   );
   end component decoder;

begin

   inst_decoder : component decoder
   port map (
   );

   p_tb : process
   begin

      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
