library ieee;
 use ieee.std_logic_1164.all;
 use IEEE.std_logic_unsigned.all;
 use IEEE.math_real.all;
 
package instruction_memory_pkg is

    -- constant C_NAME : std_logic_vector(N downto M) := "X";
   type t_instruction_memory is array (0 to 10) of std_logic_vector(31 downto 0);

   constant C_CODE : t_instruction_memory := (
                              x"00200093", -- addi x1 x0 2           x1  =  x0  +  2     = 2
                              x"00a00213", -- addi x4 x0 10          x4  =  x0  +  10    = 10
                              x"0040a183", -- lw x3, 4(x1)           x3  =  data from memory addres 0x6
                              x"00200113", -- addi x2 x0 2           x1  =  x0  +  2     = 2
                              x"00500293", -- addi x5 x0 5           x4  =  x0  +  10    = 10
                              x"00000000",
                              x"11111111",
                              x"00000000",
                              x"00000000",
                              x"00000000",
                              x"00000000"
                           );
end;

package body instruction_memory_pkg is
   
end package body;
