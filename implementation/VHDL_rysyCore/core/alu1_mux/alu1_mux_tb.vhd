library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity alu1_mux_tb is
end alu1_mux_tb;

architecture tb of alu1_mux_tb is

   component alu1_mux_design is
   port (
      rs1_d    : in std_logic_vector(REG_LEN-1 downto 0);
      pc       : in std_logic_vector(REG_LEN-1 downto 0);
      alu1_sel : in std_logic;
      clk      : in std_logic;
      alu_in1  : out std_logic_vector(REG_LEN-1 downto 0)

   );
   end component alu1_mux_design;

   signal clk_tb      :   std_logic;
   signal rs1_d_tb    :   std_logic_vector(REG_LEN-1 downto 0);
   signal pc_tb       :   std_logic_vector(REG_LEN-1 downto 0);
   signal alu1_sel_tb :   std_logic;
   signal alu_in1_tb  :   std_logic_vector(REG_LEN-1 downto 0);

begin
   inst_alu1_mux : component alu1_mux_design 
   port map (
      rs1_d    => rs1_d_tb,
      pc       => pc_tb,
      alu1_sel => alu1_sel_tb,
      clk      => clk_tb,
      alu_in1  => alu_in1_tb
   );

   p_tb : process
   begin
      wait for 100 ns;
      stop(2); 
   end process p_tb;

   p_clock_gen : process
   begin
      clk_tb <= '0';
      wait for 5 ns;
      clk_tb <= '1';
      wait for 5 ns;
   end process p_clock_gen;

end architecture tb;
