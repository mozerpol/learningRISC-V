library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity rysy_core_tb is
end rysy_core_tb;
  
architecture tb of rysy_core_tb is

   component rysy_core_design is
      port (
         clk      : in std_logic;
         rst      : in std_logic;
         rdata    : in std_logic_vector (REG_LEN-1 downto 0);
         wdata    : out std_logic_vector(REG_LEN-1 downto 0);
         addr     : out std_logic_vector(REG_LEN-1 downto 0);
         we       : out std_logic;
         be       : out std_logic_vector(3 downto 0)
      );
   end component rysy_core_design;

   signal clk_tb     : std_logic;
   signal rst_tb     : std_logic;
   signal rdata_tb   : std_logic_vector(REG_LEN-1 downto 0);
   signal wdata_tb   : std_logic_vector(REG_LEN-1 downto 0);
   signal addr_tb    : std_logic_vector(REG_LEN-1 downto 0);
   signal we_tb      : std_logic;
   signal be_tb      : std_logic_vector(3 downto 0);
   
begin
   inst_rysy_core : component rysy_core_design 
   port map (
      clk   => clk_tb,
      rst   => rst_tb,
      rdata => rdata_tb,
      wdata => wdata_tb,
      addr  => addr_tb,
      we    => we_tb,
      be    => be_tb
   );

   p_tb : process
   begin
      wait for 25 ns;
      stop(2); 
   end process;
   
   p_clk : process
   begin
      clk_tb <= '0';
      wait for 1 ns;
      clk_tb <= '1';
      wait for 1 ns;
   end process p_clk;

end architecture tb;
