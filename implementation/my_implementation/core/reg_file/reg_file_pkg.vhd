library ieee;
   use ieee.std_logic_1164.all;
   use IEEE.std_logic_unsigned.all;
   use IEEE.math_real.all;
  
package reg_file_pkg is
 
   constant C_READ_ENABLE     : std_logic := '0';
   constant C_WRITE_ENABLE    : std_logic := '1';
   constant C_DATA_REG_FILE   : std_logic := '0';
   constant C_ALU_RESULT      : std_logic := '1';

end;
 
package body reg_file_pkg is
 
end package body;
