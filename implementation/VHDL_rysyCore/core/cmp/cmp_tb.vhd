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

   signal rs1_d_tb         : std_logic_vector(REG_LEN-1 downto 0);
   signal rs2_d_tb         : std_logic_vector(REG_LEN-1 downto 0); 
   signal cmp_op_tb        : std_logic_vector(2 downto 0);
   signal b_tb             : std_logic;
   type t_val_for_rs1_d is array(0 to 7) of std_logic_vector(31 downto 0);
   signal val_for_rs1_d    : t_val_for_rs1_d;
   type t_val_for_rs2_d is array(0 to 7) of std_logic_vector(31 downto 0);
   signal val_for_rs2_d    : t_val_for_rs2_d;
 
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
      val_for_rs1_d(7)   <= 32d"10";
      val_for_rs1_d(6)   <= 32d"3";
      val_for_rs1_d(5)   <= 32x"FFFFFFFC"; -- -4
      val_for_rs1_d(4)   <= 32d"4";
      val_for_rs1_d(3)   <= 32x"FFFFFFF0"; -- -16
      val_for_rs1_d(2)   <= 32d"0";
      val_for_rs1_d(1)   <= 32d"24";
      val_for_rs1_d(0)   <= 32x"FFFFFFFB"; -- -5 

      val_for_rs2_d(7)   <= 32d"2";
      val_for_rs2_d(6)   <= 32d"10";
      val_for_rs2_d(5)   <= 32d"4";
      val_for_rs2_d(4)   <= 32x"FFFFFFFC"; -- -4
      val_for_rs2_d(3)   <= 32d"2";
      val_for_rs2_d(2)   <= 32d"0";
      val_for_rs2_d(1)   <= 32d"24";
      val_for_rs2_d(0)   <= 32x"FFFFFFFB"; -- -5 

      wait for 5 ns;
         
      for j in 0 to 7 loop
        rs1_d_tb <= val_for_rs1_d(j);
        rs2_d_tb <= val_for_rs2_d(j);
        for i in 0 to 5 loop
            cmp_op_tb   <= std_logic_vector(to_unsigned(i, 3));
            wait for 5 ns;
        end loop;
      end loop;
      
      wait for 25 ns;
      stop(2); 
   end process cmp_tb;

end architecture tb;
