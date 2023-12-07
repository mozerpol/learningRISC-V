library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library control_lib;
   use control_lib.all;
   use control_lib.control_pkg.all;

entity alu_mux_2 is
   port (
      i_rst             : in std_logic;
      i_alu_mux_2_ctrl  : in std_logic;
      i_rs2_data        : in std_logic_vector(31 downto 0);
      i_imm             : in std_logic_vector(31 downto 0);
      o_alu_operand_2   : out std_logic_vector(31 downto 0)
   );
end entity alu_mux_2;

architecture rtl of alu_mux_2 is

begin

   p_alu_mux_2 : process(all)
   begin
      if (i_rst = '1') then
         o_alu_operand_2      <= (others => '0');
      else
         case i_alu_mux_2_ctrl is
            when C_RS2_DATA   => o_alu_operand_2 <= i_rs2_data;
            when C_IMM        => o_alu_operand_2 <= i_imm;
            when others       => o_alu_operand_2 <= (others => '0');
         end case;
      end if;
   end process p_alu_mux_2;

end architecture rtl;