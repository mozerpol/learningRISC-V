library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;
  
entity select_rd_tb is
end select_rd_tb;

architecture tb of select_rd_tb is

   component select_rd_design is
      port (
         signal rdata         : in std_logic_vector(REG_LEN-1 downto 0);
         signal sel_type      : in std_logic_vector(2 downto 0);
         signal sel_addr_old  : in std_logic_vector(1 downto 0);
         signal rd_mem        : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component select_rd_design;

   signal rdata_tb         : std_logic_vector(REG_LEN-1 downto 0);
   signal sel_type_tb      : std_logic_vector(2 downto 0);
   signal sel_addr_old_tb  : std_logic_vector(1 downto 0);
   signal rd_mem_tb        : std_logic_vector(REG_LEN-1 downto 0);

   
begin
   inst_select_rd : component select_rd_design 
   port map (
      rdata          => rdata_tb,
      sel_type       => sel_type_tb,
      sel_addr_old   => sel_addr_old_tb,
      rd_mem         => rd_mem_tb
   );

end architecture tb;
