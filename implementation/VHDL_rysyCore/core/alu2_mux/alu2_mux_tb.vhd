library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity alu2_mux_tb is
end alu2_mux_tb;

architecture tb of alu2_mux_tb is

   component alu2_mux_design is
   port (
      signal rs2_d    : in std_logic_vector(REG_LEN-1 downto 0);
      signal imm      : in std_logic_vector(REG_LEN-1 downto 0); 
      signal alu2_sel : in std_logic;
      signal alu2_in2  : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component alu2_mux_design;

   signal rs2_d_tb      : std_logic_vector(REG_LEN-1 downto 0);   
   signal imm_tb        : std_logic_vector(REG_LEN-1 downto 0); 
   signal alu2_sel_tb   : std_logic;
   signal alu2_in2_tb    : std_logic_vector(REG_LEN-1 downto 0); 

begin
   inst_alu2_mux : component alu2_mux_design 
   port map (
      rs2_d       => rs2_d_tb,
      imm         => imm_tb,
      alu2_sel    => alu2_sel_tb,
      alu2_in2    => alu2_in2_tb
   );

   p_tb : process
   begin
      wait for 25 ns;
      stop(2); 
   end process p_tb;

end architecture tb;
