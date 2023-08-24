library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library branch_instructions_lib;
   use branch_instructions_lib.all;
   use branch_instructions_lib.branch_instructions_pkg.all;

entity branch_instructions is
   port (
      i_rst             : in std_logic;
      i_branch_ctrl     : in std_logic_vector(2 downto 0);
      i_rs1_data        : in std_logic_vector(31 downto 0);
      i_rs2_data        : in std_logic_vector(31 downto 0);
      o_branch_result   : out std_logic
   );
end entity branch_instructions;

architecture rtl of branch_instructions is

begin

   p_branch_instructions : process(all)
   begin
      if (i_rst) then
         o_branch_result <= '0';
      else
         case (i_branch_ctrl) is
            when C_BEQ  => o_branch_result <= '1' when i_rs1_data = i_rs2_data else '0';
            when C_BNE  => o_branch_result <= '1' when i_rs1_data /= i_rs2_data else '0';
            when C_BLT  => o_branch_result <= '1' when signed(i_rs1_data) <
                                                       signed(i_rs2_data) else '0';
            when C_BGE  => o_branch_result <= '1' when signed(i_rs1_data) >=
                                                       signed(i_rs2_data) else '0';
            when C_BLTU => o_branch_result <= '1' when unsigned(i_rs1_data) <
                                                       unsigned(i_rs2_data) else '0';
            when C_BGEU => o_branch_result <= '1' when unsigned(i_rs1_data) >=
                                                       unsigned(i_rs2_data) else '0';
            when others => o_branch_result <= '0';
         end case;
      end if;
   end process p_branch_instructions;

end architecture rtl;
