library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library imm_mux_lib;
   use imm_mux_lib.all;
   use imm_mux_lib.imm_mux_pkg.all;

entity imm_mux is
   port (
      imm_type    : in std_logic_vector(2 downto 0);
      imm_J       : in std_logic_vector(REG_LEN-1 downto 0);
      imm_U       : in std_logic_vector(REG_LEN-1 downto 0);
      imm_B       : in std_logic_vector(REG_LEN-1 downto 0);
      imm_S       : in std_logic_vector(REG_LEN-1 downto 0);
      imm_I       : in std_logic_vector(REG_LEN-1 downto 0);
      imm         : out std_logic_vector(REG_LEN-1 downto 0)
   );
end entity imm_mux;

architecture rtl of imm_mux is

begin

   p_imm_mux : process(all)
   begin
      case (imm_type) is
         when C_IMM_J => imm    <= imm_J;
         when C_IMM_U => imm    <= imm_U;
         when C_IMM_B => imm    <= imm_B;
         when C_IMM_S => imm    <= imm_S;
         when C_IMM_I => imm    <= imm_I;
         when others => imm   <= (others => '0');
      end case;
   end process p_imm_mux;

end architecture rtl;
