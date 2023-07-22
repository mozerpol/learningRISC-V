library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;

entity mux_reg_file_tb is
end mux_reg_file_tb;

architecture tb of mux_reg_file_tb is

   component mux_reg_file is
   port (
      i_rst             : in std_logic
   );
   end component mux_reg_file;

   signal rst_tb              : std_logic;

begin

   inst_mux_reg_file : component mux_reg_file
   port map (
      i_rst             => rst_tb
   );

   p_tb : process
   begin

      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
