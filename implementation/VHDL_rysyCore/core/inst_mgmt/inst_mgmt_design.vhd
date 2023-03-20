library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library inst_mgmt_lib;
   use inst_mgmt_lib.all;
   use inst_mgmt_lib.inst_mgmt_pkg.all;

entity inst_mgmt is
   port (
      signal clk        : in std_logic;
      signal rst        : in std_logic;
      signal inst_sel   : in std_logic_vector(1 downto 0);
      signal rdata      : in std_logic_vector(REG_LEN-1 downto 0);
      signal inst       : out std_logic_vector(REG_LEN-1 downto 0)
   );
end entity inst_mgmt;

architecture rtl of inst_mgmt is

begin

   p_inst_mgmt : process(clk, rst)
   begin
      if (rst = '1') then
         inst <= C_NOP;
      elsif (clk'event and clk = '1') then
         case (inst_sel) is
            when INST_OLD => inst <= inst;
            when INST_NOP => inst <= C_NOP;
            when INST_MEM => inst <= rdata;
            when others => inst <= C_NOP;
         end case;
      end if;
   end process p_inst_mgmt;

end architecture rtl;
