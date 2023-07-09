library ieee;
  use ieee.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
  use IEEE.math_real.all;
  
 package memory_pkg is
 
    -- constant C_NAME : std_logic_vector(N downto M) := "X";
   type t_ram is array (0 to 7) of std_logic_vector(31 downto 0);

   constant C_CODE : t_ram := (
                              x"123450b7",
                              x"67808093",
                              x"fff0f113",
                              x"00f0e193",
                              x"fff02213",
                              x"fff03293",
                              x"002001b3",
                              x"0000006f"
                           );
                               
 end;
 
 package body memory_pkg is
 
 end package body;
