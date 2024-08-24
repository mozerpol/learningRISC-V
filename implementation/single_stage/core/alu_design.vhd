--------------------------------------------------------------------------------
-- File          : alu_design.vhd
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : Arithmetic logic unit. Based on the i_alu_control signal,
-- which comes from the control module (control_design.vhd), a decision is made 
-- which mathematical operation the ALU should perform.
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.numeric_std_unsigned.all;
library control_lib;
   use control_lib.all;
   use control_lib.control_pkg.all;

entity alu is
   port (
      i_alu_operand_1   : in std_logic_vector(31 downto 0);
      i_alu_operand_2   : in std_logic_vector(31 downto 0);
      i_alu_control     : in std_logic_vector(4 downto 0);
      o_alu_result      : out std_logic_vector(31 downto 0)
   );
end entity alu;

architecture rtl of alu is

begin

   p_alu : process(i_alu_operand_1, i_alu_operand_2, i_alu_control)
   begin
      case i_alu_control is
         when C_ADD | C_ADDI  =>
            o_alu_result <= i_alu_operand_1 + i_alu_operand_2;
         when C_SUB           =>
            o_alu_result <= i_alu_operand_1 - i_alu_operand_2;
         when C_XOR | C_XORI  =>
            o_alu_result <= i_alu_operand_1 xor i_alu_operand_2;
         when C_OR  | C_ORI   =>
            o_alu_result <= i_alu_operand_1 or i_alu_operand_2;
         when C_AND | C_ANDI  =>
            o_alu_result <= i_alu_operand_1 and i_alu_operand_2;
         when C_SLL | C_SLLI  =>
            o_alu_result <= std_logic_vector(unsigned(i_alu_operand_1) sll
                     to_integer(unsigned(i_alu_operand_2(4 downto 0))));
         when C_SRL | C_SRLI  =>
            o_alu_result <= std_logic_vector(unsigned(i_alu_operand_1) srl
                     to_integer(unsigned(i_alu_operand_2(4 downto 0))));
         when C_SRA | C_SRAI  =>
            o_alu_result <= std_logic_vector(shift_right(signed(i_alu_operand_1),
                            to_integer(unsigned(i_alu_operand_2(4 downto 0)))));
         when C_SLT | C_SLTI  =>
            if (signed(i_alu_operand_1) < signed(i_alu_operand_2)) then
               o_alu_result <= (0 => '1', others => '0');
            else
               o_alu_result <= (others => '0');
            end if;
         when C_SLTU | C_SLTIU =>
            if (unsigned(i_alu_operand_1) < unsigned(i_alu_operand_2)) then
               o_alu_result <= (0 => '1', others => '0');
            else
               o_alu_result <= (others => '0');
            end if;
         when C_LUI           =>
            o_alu_result(31 downto 12) <= i_alu_operand_2(19 downto 0);
            o_alu_result(11 downto 0)  <= (others => '0');
         when C_AUIPC         =>
            o_alu_result <= i_alu_operand_2(19 downto 0) &
                                          i_alu_operand_1(11 downto 0);
         when C_JAL           =>
            o_alu_result <= std_logic_vector(signed(i_alu_operand_1) +
                            signed(i_alu_operand_2));
         when C_JALR          =>
            o_alu_result <= std_logic_vector(signed(i_alu_operand_1) +
                            signed(i_alu_operand_2)) and X"FFFFFFFE";
         when others => o_alu_result <= (others => '0');
      end case;
   end process p_alu;

end architecture rtl;
