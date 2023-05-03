library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library alu_lib;
   use alu_lib.all;
   use alu_lib.alu_pkg.all;

entity alu is
   port (
      signal alu_in1    : in std_logic_vector(REG_LEN-1 downto 0);
      signal alu_in2    : in std_logic_vector(REG_LEN-1 downto 0);
      signal alu_op     : in std_logic_vector(3 downto 0);
      signal alu_out    : out std_logic_vector(REG_LEN-1 downto 0)
   );
end entity alu;

architecture rtl of alu is

begin

   p_alu : process(all)
   begin
      case alu_op is
         when ADD    => alu_out <= alu_in1 + alu_in2;
         when "0001" => alu_out <= alu_in1 - alu_in2;   -- SUB
         when "0010" => alu_out <= alu_in1 xor alu_in2; -- XOR
         when "0011" => alu_out <= alu_in1 or alu_in2;  -- OR
         when "0100" => alu_out <= alu_in1 and alu_in2; -- AND
         when "0101" => alu_out <= std_logic_vector(unsigned(alu_in1) sll 
            to_integer(unsigned(alu_in2)));             -- SLL
         when "0110" => alu_out <= std_logic_vector(unsigned(alu_in1) srl 
            to_integer(unsigned(alu_in2)));             -- SRL
         when "0111" => alu_out <= std_logic_vector(unsigned(alu_in1) sra
            to_integer(unsigned(alu_in2)));             -- SRA
         when SLT    => alu_out <= alu_in1 when alu_in1 > alu_in2 else alu_in2;
         when SLTU   => alu_out <= alu_in1 when alu_in1 > alu_in2 else alu_in2; 
         when others => alu_out <= (others => '0');
      end case;
   end process p_alu;

end architecture rtl;
