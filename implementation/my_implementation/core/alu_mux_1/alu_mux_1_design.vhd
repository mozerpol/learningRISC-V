library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library alu_mux_1_lib;
   use alu_mux_1_lib.all;
   use alu_mux_1_lib.alu_mux_1_pkg.all;

entity alu_mux_1 is
   port (
      i_rst             : in std_logic;
      i_alu_mux_1_ctrl  : in std_logic;
      i_rs1_data        : in std_logic_vector(31 downto 0);    -- From reg_file
      i_pc_addr         : in std_logic_vector(31 downto 0);
      o_alu_operand_1   : out std_logic_vector(31 downto 0)
   );
end entity alu_mux_1;

architecture rtl of alu_mux_1 is

begin

   p_alu_mux_1 : process(all)
   begin
      if (i_rst = '1') then
         o_alu_operand_1 <= (others => '0');
      else
         case i_alu_mux_1_ctrl is
            when C_RS1_DATA    => o_alu_operand_1 <= i_rs1_data;
            when C_PC_ADDR    => o_alu_operand_1 <= i_pc_addr;
            when others => o_alu_operand_1 <= (others => '0');
         end case;
      end if;
   end process p_alu_mux_1;

end architecture rtl;
