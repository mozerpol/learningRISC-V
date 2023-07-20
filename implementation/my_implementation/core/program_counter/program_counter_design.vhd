library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library program_counter_lib;
   use program_counter_lib.all;
   use program_counter_lib.program_counter_pkg.all;

entity program_counter is
   port (
      i_rst          : in std_logic;
      i_clk          : in std_logic;
      i_alu_result   : in std_logic_vector(31 downto 0);
      i_pc_ctrl      : in std_logic_vector(1 downto 0);
      o_pc_addr      : out std_logic_vector(31 downto 0)
   );
end entity program_counter;

architecture rtl of program_counter is

begin

   p_program_counter : process(all)
   begin
   end process p_program_counter;

end architecture rtl;
