library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity alu_tb is
end alu_tb;

architecture tb of alu_tb is

   component alu is
   port (
      signal alu_in1    : in std_logic_vector(REG_LEN-1 downto 0);
      signal alu_in2    : in std_logic_vector(REG_LEN-1 downto 0);
      signal alu_op     : in std_logic_vector(3 downto 0);
      signal alu_out    : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component alu;

   signal alu_in1_tb    : std_logic_vector(REG_LEN-1 downto 0);
   signal alu_in2_tb    : std_logic_vector(REG_LEN-1 downto 0);
   signal alu_op_tb     : std_logic_vector(3 downto 0);
   signal alu_out_tb    : std_logic_vector(REG_LEN-1 downto 0);

begin

   inst_alu : component alu 
   port map (
      alu_in1  => alu_in1_tb,
      alu_in2  => alu_in2_tb,
      alu_op   => alu_op_tb,
      alu_out  => alu_out_tb
   );

   p_tb : process
   begin
      wait for 25 ns;
      stop(2); 
   end process p_tb;

end architecture tb;
