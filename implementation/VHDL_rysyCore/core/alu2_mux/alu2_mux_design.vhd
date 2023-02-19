-- Multiplexer can take two values:
-- 1. From the PC register to pass a value to the ALU, which next calculate a
--    new address, for example to perform jump. But before passing value from PC
--    to ALU must wait two clock cycles to empty pipeline. Two lines of code do
--    this:
--    old_pc(1) <= pc;
--    old_pc(0) <= old_pc(1);
-- 2. Operand rs1_d which comes from reg_file. This operand can be simple number
--    for ALU like 12 or 3.

library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;


entity alu2_mux_design is
   port (
   );
end entity alu2_mux_design;

architecture rtl of alu2_mux_design is

begin

   p_alu2_pc : process(clk)
   begin
      if (clk'event and clk = '1') then
      end if;
   end process p_alu2_pc;

   p_alu2_sel : process(all)
   begin
   end process p_alu2_sel;

end architecture rtl;
