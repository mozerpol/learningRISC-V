library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
   use std.env.all;
library select_wr_lib;
   use select_wr_lib.select_wr_pkg.all;   
  
entity select_wr_tb is
end select_wr_tb;

architecture tb of select_wr_tb is

   component select_wr_design is
      port (
         signal rs2_d      : in std_logic_vector(REG_LEN-1 downto 0);
         signal sel_type   : in std_logic_vector(2 downto 0);
         signal sel_addr   : in std_logic_vector(1 downto 0);
         signal be         : out std_logic_vector(3 downto 0);
         signal wdata      : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component select_wr_design;

   signal rs2_d_tb      : std_logic_vector(REG_LEN-1 downto 0);
   signal sel_type_tb   : std_logic_vector(2 downto 0);
   signal sel_addr_tb   : std_logic_vector(1 downto 0);
   signal be_tb         : std_logic_vector(3 downto 0);
   signal wdata_tb      : std_logic_vector(REG_LEN-1 downto 0);

begin
   inst_select_wr : component select_wr_design 
   port map (
      rs2_d       => rs2_d_tb,
      sel_type    => sel_type_tb,
      sel_addr    => sel_addr_tb,
      be          => be_tb,
      wdata       => wdata_tb
   );

   p_select_wr : process
   begin
    wait for 25 ns;
    stop(2);

   end process p_select_wr;

end architecture tb;
