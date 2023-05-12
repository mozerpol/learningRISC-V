library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library select_wr_lib;
   use select_wr_lib.all;
   use select_wr_lib.select_wr_pkg.all;


entity select_wr_design is
   port (
      signal rs2_d      : in std_logic_vector(REG_LEN-1 downto 0);
      signal sel_type   : in std_logic_vector(2 downto 0);
      signal sel_addr   : in std_logic_vector(1 downto 0);
      signal be         : out std_logic_vector(3 downto 0);
      signal wdata      : out std_logic_vector(REG_LEN-1 downto 0)
   );
end entity select_wr_design;

architecture rtl of select_wr_design is

begin

   p_select_wr : process(all)
   begin
      case (sel_type) is
         when SB => 
            case (sel_addr) is
               when "00" => wdata <= 24x"000000" & rs2_d(7 downto 0);
               when "01" => wdata <= 16x"0000" & rs2_d(7 downto 0) & 8x"00";
               when "10" => wdata <= 8x"00" & rs2_d(7 downto 0) & 16x"0000";
               when "11" => wdata <= rs2_d(7 downto 0) & 24x"000000";
               when others => wdata <= 24x"000000" & rs2_d(7 downto 0);
            end case;
         when SH =>
            case (sel_addr) is
               when "00" => wdata <= 16x"0000" & rs2_d(15 downto 0);
               when "10" => wdata <= rs2_d(15 downto 0) & 16x"0000";
               when others => wdata <= 16x"0000" & rs2_d(15 downto 0);
            end case;
         when SW => wdata <= rs2_d;
         when others => wdata <= rs2_d;
      end case;
   end process p_select_wr;

   p_be : process(all)
   begin
      case (sel_type) is
         when SB => be <= "0001" sll to_integer(unsigned(sel_addr));
         when SH => be <= "0011" sll to_integer(unsigned(sel_addr));
         when SW => be <= 4b"1111";
         when others => be <= 4b"1111";
      end case;
   end process p_be;

end architecture rtl;
