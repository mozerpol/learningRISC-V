library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library select_rd_lib;
   use select_rd_lib.all;
   use select_rd_lib.select_rd_pkg.all;


entity select_rd_design is
   port (
      signal rdata         : in std_logic_vector(REG_LEN-1 downto 0);
      signal sel_type      : in std_logic_vector(2 downto 0);
      signal sel_addr_old  : in std_logic_vector(1 downto 0);
      signal rd_mem        : out std_logic_vector(REG_LEN-1 downto 0)
   );
end entity select_rd_design;

architecture rtl of select_rd_design is

begin

   p_select_rd : process(all)
   begin
      case (sel_type) is
         when SB => 
            case (sel_addr_old) is
               when "00" => rd_mem(REG_LEN-1 downto 0) <= (rdata(7 downto 0) & 
                  (24x"ffffff" when rdata(7) = '1' else
                   24x"000000"));
               when "01" => NULL;
               when "10" => NULL;
               when "11" => NULL;
               when others => NULL;
            end case;
         when SH => NULL;
         when SW => NULL;
         when SBU => NULL;
         when SHU => NULL;
         when others => NULL;
      end case;
   end process p_select_rd;

end architecture rtl;
