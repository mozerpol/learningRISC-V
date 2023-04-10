library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity rd_mux_tb is
end rd_mux_tb;

architecture tb of rd_mux_tb is

   component rd_mux_design is
   port (
      signal imm        : in std_logic_vector(REG_LEN-1 downto 0);
      signal pc         : in std_logic_vector(REG_LEN-1 downto 0);
      signal alu_out    : in std_logic_vector(REG_LEN-1 downto 0);
      signal rd_mem     : in std_logic_vector(REG_LEN-1 downto 0);
      signal clk        : in std_logic;
      signal rd_sel     : in std_logic_vector(1 downto 0);
      signal rd_d       : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component rd_mux_design;

   signal imm_tb     : std_logic_vector(REG_LEN-1 downto 0);
   signal pc_tb      : std_logic_vector(REG_LEN-1 downto 0);
   signal alu_out_tb : std_logic_vector(REG_LEN-1 downto 0);
   signal rd_mem_tb  : std_logic_vector(REG_LEN-1 downto 0);
   signal clk_tb     : std_logic;
   signal rd_sel_tb  : std_logic_vector(1 downto 0);
   signal rd_d_tb    : std_logic_vector(REG_LEN-1 downto 0);

begin
   inst_rd_mux : component rd_mux_design 
   port map (
      imm      => imm_tb,
      pc       => pc_tb,
      alu_out  => alu_out_tb,
      rd_mem   => rd_mem_tb,
      clk      => clk_tb,
      rd_sel   => rd_sel_tb,
      rd_d     => rd_d_tb
   );

   p_tb : process
   begin
   
      wait for 25 ns;
      stop(2); 
   end process p_tb;

end architecture tb;
