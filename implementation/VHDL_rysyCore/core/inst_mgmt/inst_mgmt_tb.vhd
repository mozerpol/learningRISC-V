library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;
library inst_mgmt_lib;
   use inst_mgmt_lib.all;
   use inst_mgmt_lib.inst_mgmt_pkg.all;

entity inst_mgmt_tb is
end inst_mgmt_tb;

architecture tb of inst_mgmt_tb is

   component inst_mgmt is
   port (
      signal clk        : in std_logic;
      signal rst        : in std_logic;
      signal inst_sel   : in std_logic_vector(1 downto 0);
      signal rdata      : in std_logic_vector(REG_LEN-1 downto 0);
      signal inst       : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component inst_mgmt;
   
   signal clk_tb        : std_logic;
   signal rst_tb        : std_logic;
   signal inst_sel_tb   : std_logic_vector(1 downto 0);
   signal rdata_tb      : std_logic_vector(REG_LEN-1 downto 0);
   signal inst_tb       : std_logic_vector(REG_LEN-1 downto 0);

begin

   inst_inst_mgmt : component inst_mgmt 
   port map (
      clk      => clk_tb,
      rst      => rst_tb,
      inst_sel => inst_sel_tb,
      rdata    => rdata_tb,
      inst     => inst_tb
   );
   
   inst_clk_gen : process
   begin
      clk_tb <= '0';
      wait for 1 ns;
      clk_tb <= '1';
      wait for 1 ns;
   end process inst_clk_gen;

   inst_mgmt_tb : process
   begin
      rst_tb       <= '1';
      wait for 10 ns;
      rst_tb       <= '0';
      wait for 10 ns;
      inst_sel_tb  <= INST_MEM;
      rdata_tb     <= 32d"11";
      wait for 10 ns;
      rdata_tb     <= 32d"3";
      wait for 10 ns;
      rdata_tb     <= 32d"4";
      wait for 10 ns;
      rdata_tb     <= 32d"16";
      wait for 10 ns;

      inst_sel_tb <= INST_OLD;
      wait for 10 ns;
      inst_sel_tb <= INST_NOP;
      wait for 10 ns;
      inst_sel_tb <= INST_NOP;
      wait for 10 ns;
      inst_sel_tb <= INST_MEM;
      rdata_tb    <= 32d"11";
      wait for 10 ns;
      rdata_tb    <= 32d"3";
      wait for 10 ns;
      rdata_tb    <= 32d"0";
      wait for 10 ns;
      rdata_tb    <= 32d"1";
      wait for 10 ns;
      rdata_tb    <= 32d"0";
      wait for 10 ns;
      rdata_tb    <= 32d"4";
      wait for 10 ns;
      rdata_tb    <= 32d"16";

      wait for 25 ns;
      stop(2); 
   end process inst_mgmt_tb;

end architecture tb;
