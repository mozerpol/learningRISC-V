library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;


entity alu1_mux_design is
   port (
      rs1_d    : in std_logic_vector(REG_LEN-1 downto 0);
      pc       : in std_logic_vector(REG_LEN-1 downto 0);
      alu1_sel : in std_logic;
      clk      : in std_logic;
      alu_in1  : out std_logic_vector(REG_LEN-1 downto 0)
   );
end entity alu1_mux_design;

architecture rtl of alu1_mux_design is

   signal o       : std_logic_vector(REG_LEN-1 downto 0);
   type t_old_pc  is array(1 downto 0) of std_logic_vector(REG_LEN-1 downto 0);
   signal old_pc  : t_old_pc;

begin
   alu_in1 <= o;

   p_alu1_pc : process(clk)
   begin
      if (clk'event and clk = '1') then
         old_pc(1) <= pc;
         old_pc(0) <= old_pc(1);
      end if;
   end process p_alu1_pc;

   p_alu1_sel : process(all)
   begin
      case alu1_sel is
         when '0' => o <= rs1_d;       -- ALU1_RS
         when '1' => o <= old_pc(0);   -- ALU1_PC
         when others => NULL;
     end case;
   end process p_alu1_sel;


end architecture rtl;
