library ieee;
   use ieee.std_logic_1164.all;
   use IEEE.std_logic_unsigned.all;
   use IEEE.math_real.all;

 package memory_pkg is

    -- constant C_NAME : std_logic_vector(N downto M) := "X";
   constant C_RAM_DEPTH    : integer                        := 127;
   constant C_READ_ENABLE  : std_logic                      := '0';
   constant C_WRITE_ENABLE : std_logic                      := '1';   
   constant C_STORE_WORD   : std_logic_vector(1 downto 0)   := "00";
   constant C_STORE_HALF   : std_logic_vector(1 downto 0)   := "01";
   constant C_STORE_BYTE   : std_logic_vector(1 downto 0)   := "10";
   type t_ram is array (0 to C_RAM_DEPTH-1, 0 to 3) of std_logic_vector(7 downto 0);

 end;

 package body memory_pkg is

 end package body;
