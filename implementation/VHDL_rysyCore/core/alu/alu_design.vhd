library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
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

   signal o          : std_logic_vector(REG_LEN-1 downto 0);
   signal alu_in1_s  : std_logic_vector(REG_LEN-1 downto 0);
   signal alu_in2_s  : std_logic_vector(REG_LEN-1 downto 0);

begin

   --alu_out     <= o;
   alu_in1_s   <= alu_in1;
   alu_in2_s   <= alu_in2;

   p_alu : process(all)
   begin
      alu_out <= (others => '1');
   end process p_alu;

end architecture rtl;
