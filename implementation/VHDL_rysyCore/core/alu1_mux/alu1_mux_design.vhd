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


entity alu1_mux_design is
   port (
      rs1_d    : in std_logic_vector(REG_LEN-1 downto 0);
      pc       : in std_logic_vector(REG_LEN-1 downto 0);
      alu1_sel : in std_logic;
      clk      : in std_logic;
      alu_in1  : out std_logic_vector(REG_LEN-1 downto 0)
   );
end entity alu1_mux_design;

architecture rtl of alu1_mux_design is

   type t_old_pc  is array(1 downto 0) of std_logic_vector(REG_LEN-1 downto 0);
   signal old_pc  : t_old_pc;

begin

   p_alu1_pc : process(clk)
   begin
      if (clk'event and clk = '1') then
         old_pc(1) <= pc;
         old_pc(0) <= old_pc(1);
      end if;
   end process p_alu1_pc;

   p_alu1_sel : process(all)
   begin
      case alu1_sel is
         when '0' => alu_in1 <= rs1_d;       -- ALU1_RS
         when '1' => alu_in1 <= old_pc(0);   -- ALU1_PC
         when others => NULL;
     end case;
   end process p_alu1_sel;


end architecture rtl;
