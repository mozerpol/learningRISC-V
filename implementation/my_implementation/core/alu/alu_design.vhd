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
      i_control         : in std_logic_vector(5 downto 0);
      o_alu_out         : out std_logic_vector(31 downto 0)
   );
end entity alu;

architecture rtl of alu is

begin

   p_alu : process(all)
   begin
      if (i_rst) then
         o_alu_out   <= (others => '0');
      else
         case i_control is
            when C_ADD  => o_alu_out <= i_alu_operand_1 + i_alu_operand_2; 

            when others => o_alu_out <= (others => '0');
         end case;
      end if;
   end process p_alu;

end architecture rtl;
