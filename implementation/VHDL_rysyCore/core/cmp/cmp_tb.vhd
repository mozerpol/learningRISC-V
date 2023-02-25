library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity cmp_tb is
end cmp_tb;

architecture tb of cmp_tb is

   component cmp is
   port (
      rs1_d    : in std_logic_vector(REG_LEN-1 downto 0);
      rs2_d    : in std_logic_vector(REG_LEN-1 downto 0);
      cmp_op   : in std_logic_vector(2 downto 0);
      b        : out std_logic
   );
   end component cmp;

   signal rs1_d_tb   : std_logic_vector(REG_LEN-1 downto 0);
   signal rs2_d_tb   : std_logic_vector(REG_LEN-1 downto 0); 
   signal cmp_op_tb  : std_logic_vector(2 downto 0);
   signal b_tb       : std_logic;
 
begin

   inst_cmp : component cmp 
   port map (
      rs1_d    => rs1_d_tb,
      rs2_d    => rs2_d_tb,
      cmp_op   => cmp_op_tb,
      b        => b_tb
   );

   cmp_tb : process
   begin
       
      wait for 25 ns;
      stop(2); 
   end process cmp_tb;

end architecture tb;
