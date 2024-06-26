--------------------------------------------------------------------------------
-- File          : alu_mux_1_design.vhd
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : This module works like a multiplexer. Only passes data to
-- arithmetic logic unit (ALU) that comes from program counter or register file. 
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

entity alu_mux_1 is
   port (
      i_rst             : in std_logic;
      i_alu_mux_1_ctrl  : in std_logic;
      i_rs1_data        : in std_logic_vector(31 downto 0);
      i_pc_addr         : in std_logic_vector(31 downto 0);
      o_alu_operand_1   : out std_logic_vector(31 downto 0)
   );
end entity alu_mux_1;

architecture rtl of alu_mux_1 is

begin

   p_alu_mux_1 : process(i_rst, i_alu_mux_1_ctrl, i_rs1_data, i_pc_addr)
   begin
      if (i_rst = '1') then
         o_alu_operand_1      <= (others => '0');
      else
         case i_alu_mux_1_ctrl is
            when C_RS1_DATA   => o_alu_operand_1 <= i_rs1_data;
            when C_PC_ADDR    => o_alu_operand_1 <= i_pc_addr;
            when others       => o_alu_operand_1 <= (others => '0');
         end case;
      end if;
   end process p_alu_mux_1;

end architecture rtl;
