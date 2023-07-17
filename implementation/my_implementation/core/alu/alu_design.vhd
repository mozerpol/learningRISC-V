library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library alu_lib;
   use alu_lib.all;
   use alu_lib.alu_pkg.all;

entity alu is
   port (
      i_rst             : in std_logic;
      i_alu_operand_1   : in std_logic_vector(31 downto 0);
      i_alu_operand_2   : in std_logic_vector(31 downto 0);
      i_alu_control     : in std_logic_vector(5 downto 0);
      o_alu_result      : out std_logic_vector(31 downto 0)
   );
end entity alu;

architecture rtl of alu is

begin

   p_alu : process(all)
   begin
      if (i_rst) then
         o_alu_result   <= (others => '0');
      else
         case i_alu_control is
            when C_ADD | C_ADDI => 
               o_alu_result <= i_alu_operand_1 + i_alu_operand_2; 
            when C_SUB  => 
               o_alu_result <= i_alu_operand_1 - i_alu_operand_2; 
            when C_XOR | C_XORI => 
               o_alu_result <= i_alu_operand_1 xor i_alu_operand_2; 
            when C_OR  | C_ORI  => 
               o_alu_result <= i_alu_operand_1 or i_alu_operand_2; 
            when C_AND | C_ANDI =>
               o_alu_result <= i_alu_operand_1 and i_alu_operand_2; 
            when C_SLL | C_SLLI => 
               o_alu_result <= std_logic_vector(unsigned(i_alu_operand_1) sll 
                        to_integer(unsigned(i_alu_operand_2(4 downto 0))));
            when C_SRL | C_SRLI => 
               o_alu_result <= std_logic_vector(unsigned(i_alu_operand_1) srl 
                        to_integer(unsigned(i_alu_operand_2(4 downto 0)))); 
            when C_SRA | C_SRAI => 
               o_alu_result <= std_logic_vector(signed(i_alu_operand_1) sra 
                        to_integer(unsigned(i_alu_operand_2(4 downto 0))));
            when C_SLT | C_SLTI => 
               o_alu_result <= (0 => '1', others => '0') when 
                        signed(i_alu_operand_1) < signed(i_alu_operand_2) else 
                        (others => '0');
            when C_SLTU | C_SLTIU => 
               o_alu_result <= (0 => '1', others => '0') when 
                        unsigned(i_alu_operand_1) < unsigned(i_alu_operand_2) else
                        (others => '0'); 
            when others => o_alu_result <= (others => '0');
         end case;
      end if;
   end process p_alu;

end architecture rtl;
