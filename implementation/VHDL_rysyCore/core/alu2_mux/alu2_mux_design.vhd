library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library alu2_mux_lib;
   use alu2_mux_lib.all;
   use alu2_mux_lib.alu2_mux_pkg.all;

entity alu2_mux_design is
   port (
      signal rs2_d    : in std_logic_vector(REG_LEN-1 downto 0);
      signal imm      : in std_logic_vector(REG_LEN-1 downto 0);
      signal alu2_sel : in std_logic;
      signal alu_in2  : out std_logic_vector(REG_LEN-1 downto 0)
   );
end entity alu2_mux_design;

architecture rtl of alu2_mux_design is

   signal o    : std_logic_vector(REG_LEN-1 downto 0);

begin

   alu_in2 <= o;

   p_alu2_sel : process(all)
   begin
      case alu2_sel is
         when ALU2_RS   => o <= rs2_d;
         when ALU2_IMM  => o <= imm;
         when others    => NULL;
      end case;
   end process p_alu2_sel;

end architecture rtl;
