--------------------------------------------------------------------------------
-- File          : branch_instructions_design.vhd
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : Compares two data that come from the register file. Based on
-- the i_branch_ctrl signal, which comes from the control module, a decision is
-- made about what comparison to perform. The result as o_branch_result is sent
-- to the control module which, depending on the comparison result, decides what
-- to do next.
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library control_lib;
   use control_lib.all;
   use control_lib.control_pkg.all;

entity branch_instructions is
   port (
      i_branch_ctrl     : in std_logic_vector(2 downto 0);
      i_rs1_data        : in std_logic_vector(31 downto 0);
      i_rs2_data        : in std_logic_vector(31 downto 0);
      o_branch_result   : out std_logic
   );
end entity branch_instructions;

architecture rtl of branch_instructions is

begin

   p_branch_instructions : process( i_branch_ctrl, i_rs1_data, i_rs2_data)
   begin
      case (i_branch_ctrl) is
         when C_BEQ  =>
            if (i_rs1_data = i_rs2_data) then
               o_branch_result <= C_TAKEN;
            else
               o_branch_result <= C_NOT_TAKEN;
            end if;
         when C_BNE  =>
            if (i_rs1_data /= i_rs2_data) then
               o_branch_result <= C_TAKEN;
            else
               o_branch_result <= C_NOT_TAKEN;
            end if;
         when C_BLT  =>
            if (signed(i_rs1_data) < signed(i_rs2_data)) then
               o_branch_result <= C_TAKEN;
            else
               o_branch_result <= C_NOT_TAKEN;
            end if;
         when C_BGE  =>
            if (signed(i_rs1_data) >= signed(i_rs2_data)) then
               o_branch_result <= C_TAKEN;
            else
               o_branch_result <= C_NOT_TAKEN;
            end if;
         when C_BLTU =>
            if (unsigned(i_rs1_data) < unsigned(i_rs2_data)) then
               o_branch_result <= C_TAKEN;
            else
               o_branch_result <= C_NOT_TAKEN;
            end if;
         when C_BGEU =>
            if (unsigned(i_rs1_data) >= unsigned(i_rs2_data)) then
               o_branch_result <= C_TAKEN;
            else
               o_branch_result <= C_NOT_TAKEN;
            end if;
         when others => o_branch_result <= C_NOT_TAKEN;
      end case;
   end process p_branch_instructions;

end architecture rtl;
