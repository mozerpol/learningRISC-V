library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library rd_mux_lib;
   use rd_mux_lib.all;
   use rd_mux_lib.rd_mux_pkg.all;

entity rd_mux_design is
   port (
      signal imm        : in std_logic_vector(REG_LEN-1 downto 0);
      signal pc         : in std_logic_vector(REG_LEN-1 downto 0);
      signal alu_out    : in std_logic_vector(REG_LEN-1 downto 0);
      signal rd_mem     : in std_logic_vector(REG_LEN-1 downto 0);
      signal clk        : in std_logic;
      signal rd_sel     : in std_logic_vector(1 downto 0);
      signal rd_d       : out std_logic_vector(REG_LEN-1 downto 0)
   );
end entity rd_mux_design;

architecture rtl of rd_mux_design is

   signal old_pc : std_logic_vector(REG_LEN-1 downto 0);

begin
   p_old_pc : process(clk)
   begin
      if (clk'event and clk = '1') then
         old_pc <= pc;
      end if;
   end process p_old_pc;

   p_pc :process (all)
   begin
      case (rd_sel) is
         when RD_IMM  => rd_d <= imm;
         when RD_PCP4 => rd_d <= old_pc;
         when RD_ALU  => rd_d <= alu_out;
         when "11"    => rd_d <= rd_mem; -- change to RD_MEM
         when others  => NULL;
      end case;
   end process p_pc;

end architecture rtl;
