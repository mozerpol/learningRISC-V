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
            when C_BEQ  =>
               if (i_rs1_data = i_rs2_data) then
                  o_branch_result <= '1';
               else
                  o_branch_result <= '0';
               end if;
            when C_BNE  =>
               if (i_rs1_data /= i_rs2_data) then
                  o_branch_result <= '1';
               else
                  o_branch_result <= '0';
               end if;
            when C_BLT  =>
               if (signed(i_rs1_data) < signed(i_rs2_data)) then
                  o_branch_result <= '1';
               else
                  o_branch_result <= '0';
               end if;
            when C_BGE  =>
               if (signed(i_rs1_data) >= signed(i_rs2_data)) then
                  o_branch_result <= '1';
               else
                  o_branch_result <= '0';
               end if;
            when C_BLTU =>
               if (unsigned(i_rs1_data) < unsigned(i_rs2_data)) then
                  o_branch_result <= '1';
               else
                  o_branch_result <= '0';
               end if;
            when C_BGEU => 
				   if (unsigned(i_rs1_data) >= unsigned(i_rs2_data)) then
					   o_branch_result <= '1';
				   else
					   o_branch_result <= '0';
				   end if;
            when others => o_branch_result <= '0';
         end case;
      end if;
   end process p_branch_instructions;

end architecture rtl;
