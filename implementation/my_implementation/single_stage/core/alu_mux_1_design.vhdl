--------------------------------------------------------------------------------
-- File          : alu_mux_1_design.vhdl
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : This module works like a multiplexer. Only passes data to
-- arithmetic logic unit (alu_design.vhdl) that comes from program counter 
-- (program_counter_design.vhdl) or register file (register_file_design.vhdl).
-- Depending on the i_alu_mux_1_ctrl signal that comes from the control module 
-- (control_design.vhdl), the selected value is transferred.
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;
library control_lib;
   use control_lib.all;
   use control_lib.control_pkg.all;

entity alu_mux_1 is
   port (
      i_alu_mux_1_ctrl  : in std_logic;
      i_rs1_data        : in std_logic_vector(31 downto 0);
      i_pc_addr         : in std_logic_vector(31 downto 0);
      o_alu_operand_1   : out std_logic_vector(31 downto 0)
   );
end entity alu_mux_1;

architecture rtl of alu_mux_1 is

begin

   p_alu_mux_1 : process(i_alu_mux_1_ctrl, i_rs1_data, i_pc_addr)
   begin
      case i_alu_mux_1_ctrl is
         when C_RS1_DATA   => o_alu_operand_1 <= i_rs1_data;
         when C_PC_ADDR    => o_alu_operand_1 <= i_pc_addr;
         when others       => o_alu_operand_1 <= (others => '0');
      end case;
   end process p_alu_mux_1;

end architecture rtl;
