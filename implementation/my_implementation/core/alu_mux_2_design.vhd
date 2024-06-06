--------------------------------------------------------------------------------
-- File          : alu_mux_2_design.vhd
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : This module works like a multiplexer. Only passes data to
-- arithmetic logic unit (ALU) that comes from register file or constant value.
-- Depending on the i_alu_mux_1_ctrl signal that comes from the control module,
-- the selected value is transferred.
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

entity alu_mux_2 is
   port (

      i_alu_mux_2_ctrl  : in std_logic;
      i_rs2_data        : in std_logic_vector(31 downto 0);
      i_imm             : in std_logic_vector(31 downto 0);
      o_alu_operand_2   : out std_logic_vector(31 downto 0)
   );
end entity alu_mux_2;

architecture rtl of alu_mux_2 is

begin

   p_alu_mux_2 : process(i_alu_mux_2_ctrl, i_rs2_data, i_imm)
   begin

         case i_alu_mux_2_ctrl is
            when C_RS2_DATA   => o_alu_operand_2 <= i_rs2_data;
            when C_IMM        => o_alu_operand_2 <= i_imm;
            when others       => o_alu_operand_2 <= (others => '0');
         end case;

   end process p_alu_mux_2;

end architecture rtl;
