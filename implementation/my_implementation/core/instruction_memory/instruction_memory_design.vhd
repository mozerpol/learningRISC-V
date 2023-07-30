library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library instruction_memory_lib;
   use instruction_memory_lib.all;
   use instruction_memory_lib.instruction_memory_pkg.all;


entity instruction_memory is
   port (
      i_rst             : in std_logic
   );
end entity instruction_memory;

architecture rtl of instruction_memory is

begin

   p_instruction_memory : process(all)
   begin
      if (i_rst = '1') then
        NULL;
      else
        NULL;
      end if;
   end process p_instruction_memory;

end architecture rtl;
