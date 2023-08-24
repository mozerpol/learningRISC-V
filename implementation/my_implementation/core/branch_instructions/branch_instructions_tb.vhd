library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;
library branch_instructions_lib;
   use branch_instructions_lib.all;
   use branch_instructions_lib.branch_instructions_pkg.all;

entity branch_instructions_tb is
end branch_instructions_tb;

architecture tb of branch_instructions_tb is

   component branch_instructions is
   port (
      i_rst : in std_logic
   );
   end component branch_instructions;

   signal rst_tb : std_logic;

begin

   inst_branch_instructions : component branch_instructions
   port map (
      i_rst => rst_tb
   );

   p_tb : process
   begin

      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
