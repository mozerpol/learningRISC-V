library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity mem_addr_sel_tb is
end mem_addr_sel_tb;

architecture tb of mem_addr_sel_tb is

   component mem_addr_sel is
   port (
      clk      : in std_logic;
      rst      : in std_logic;
      pc_sel   : in std_logic_vector(1 downto 0);
      mem_sel  : in std_logic;
      alu_out  : in std_logic_vector(REG_LEN-1 downto 0);
      pc       : out std_logic_vector(REG_LEN-1 downto 0);
      addr     : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component mem_addr_sel;

   signal clk_tb     : std_logic;
   signal rst_tb     : std_logic;
   signal pc_sel_tb  : std_logic_vector(1 downto 0);
   signal mem_sel_tb : std_logic;
   signal alu_out_tb : std_logic_vector(REG_LEN-1 downto 0);
   signal pc_tb      : std_logic_vector(REG_LEN-1 downto 0);
   signal addr_tb    : std_logic_vector(REG_LEN-1 downto 0);

begin

   inst_mem_addr_sel : component mem_addr_sel 
   port map (
      clk      => clk_tb,
      rst      => rst_tb,
      pc_sel   => pc_sel_tb,
      mem_sel  => mem_sel_tb,
      alu_out  => alu_out_tb,
      pc       => pc_tb,
      addr     => addr_tb
   );
   
   p_clk : process
   begin
      clk_tb <= '0';
      wait for 1 ns;
      clk_tb <= '1';
      wait for 1 ns;
   end process p_clk;

   mem_addr_sel_tb : process
   begin
      rst_tb      <= '1';
      wait for 10 ns;
      rst_tb      <= '0';
      wait for 10 ns;

      pc_sel_tb   <= "00";
      wait for 10 ns;
      alu_out_tb  <= 32d"10";
      wait for 10 ns;
      alu_out_tb  <= 32d"3";
      wait for 10 ns;
      alu_out_tb  <= 32d"4";
      wait for 10 ns;
      alu_out_tb  <= 32d"16";
      wait for 10 ns;

      pc_sel_tb   <= "01";
      wait for 50 ns;
      pc_sel_tb   <= "10";
      wait for 50 ns;

      pc_sel_tb   <= "00";
      wait for 10 ns;
      alu_out_tb  <= 32d"10";
      wait for 10 ns;
      rst_tb      <= '1';
      wait for 10 ns;
      alu_out_tb  <= 32d"3";
      wait for 10 ns;
      rst_tb      <= '0';
      wait for 10 ns;
      alu_out_tb  <= 32d"4";
      wait for 10 ns;
      alu_out_tb  <= 32d"16";
      wait for 10 ns;
      
      pc_sel_tb   <= "11";
      wait for 50 ns;

      mem_sel_tb  <= '0';
      wait for 10 ns;
      alu_out_tb  <= 32d"10";
      pc_sel_tb   <= "00";
      wait for 10 ns;
      alu_out_tb  <= 32d"10";
      wait for 10 ns;
      alu_out_tb  <= 32d"3";
      wait for 10 ns;
      alu_out_tb  <= 32d"4";
      wait for 10 ns;
      alu_out_tb  <= 32d"16";
      wait for 10 ns;

      mem_sel_tb  <= '1';
      wait for 10 ns;
      alu_out_tb  <= 32d"10";
      pc_sel_tb   <= "00";
      wait for 10 ns;
      alu_out_tb  <= 32d"10";
      wait for 10 ns;
      alu_out_tb  <= 32d"3";
      wait for 10 ns;
      alu_out_tb  <= 32d"4";
      wait for 10 ns;
      alu_out_tb  <= 32d"16";
      wait for 10 ns;

      stop(2); 
   end process mem_addr_sel_tb;

end architecture tb;
