library ieee;
   use ieee.std_logic_1164.all;
   use IEEE.std_logic_unsigned.all;
   use IEEE.math_real.all;

 package memory_pkg is

    -- constant C_NAME : std_logic_vector(N downto M) := "X";
  -- type t_ram is array (0 to 127) of std_logic_vector(31 downto 0);
   
   type t_ram is array (0 to 127, 0 to 3) of std_logic_vector(7 downto 0);

 end;

 package body memory_pkg is

 end package body;
