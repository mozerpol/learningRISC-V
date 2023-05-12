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
               when "00" =>
                  rd_mem <= 24x"ffffff" & rdata(7 downto 0) 
                            when (rdata(7) = '1') else
                            24x"000000" & rdata(7 downto 0); 
               when "01" => 
                  rd_mem <= 24x"ffffff" & rdata(15 downto 8)
                            when (rdata(15) = '1') else
                            24x"000000" & rdata(15 downto 8);
               when "10" => 
                  rd_mem <= 24x"ffffff" & rdata(23 downto 16)
                            when (rdata(23) = '1') else
                            24x"000000" & rdata(23 downto 16); 
               when "11" =>
                  rd_mem <= 24x"ffffff" & rdata(31 downto 24)
                            when (rdata(31) = '1') else
                            24x"000000" & rdata(31 downto 24); 
               when others => rd_mem <= (others => '0');
            end case;
         when SH => NULL;
            case (sel_addr_old) is
               when "00" => 
                  rd_mem <= 16x"ffff" & rdata(15 downto 0) 
                            when (rdata(15) = '1') else
                            16x"0000" & rdata(15 downto 0); 
               when "10" => 
                  rd_mem <= 16x"ffff" & rdata(31 downto 16) 
                            when (rdata(31) = '1') else
                            16x"0000" & rdata(31 downto 16); 
               when others => rd_mem <= (others => '0');
            end case;
         when SW => rd_mem <= rdata;
         when SBU => 
            case (sel_addr_old) is
               when "00" => 
                  rd_mem <= 24x"000000" & rdata(7 downto 0);
               when "01" =>
                  rd_mem <= 24x"000000" & rdata(15 downto 8); 
               when "10" =>
                  rd_mem <= 24x"000000" & rdata(23 downto 16);
               when "11" =>
                  rd_mem <= 24x"000000" & rdata(31 downto 24);
               when others => rd_mem <= (others => '0');
            end case;
         when SHU =>
            case (sel_addr_old) is
               when "00" => rd_mem <= 16x"0000" & rdata(15 downto 0);
               when "10" => rd_mem <= 16x"0000" & rdata(31 downto 16);
               when others => rd_mem <= (others => '0');
            end case;
         when others => rd_mem <= (others => '0');
      end case;
   end process p_select_rd;

end architecture rtl;
