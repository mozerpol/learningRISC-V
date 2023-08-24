library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library branch_instructions_lib;
   use branch_instructions_lib.all;
   use branch_instructions_lib.branch_instructions_pkg.all;

entity branch_instructions is
   port (
      i_rst : in std_logic
   );
end entity branch_instructions;

architecture rtl of branch_instructions is

begin

   p_branch_instructions : process(all)
   begin
      if (i_rst) then
      else
      end if;
   end process p_branch_instructions;

end architecture rtl;
