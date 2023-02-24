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

   type t_val_for_in1   is array(0 to 4) of std_logic_vector(31 downto 0);
   signal val_for_in1   : t_val_for_in1;
   type t_val_for_in2   is array(0 to 4) of std_logic_vector(31 downto 0);
   signal val_for_in2   : t_val_for_in2;
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
      val_for_in1(0) <= 32x"10";
      val_for_in1(1) <= 32x"3";
      val_for_in1(2) <= 32x"4";
      val_for_in1(3) <= 32x"5";
      val_for_in1(4) <= 32x"6";

      val_for_in2(0) <= 32x"2";
      val_for_in2(1) <= 32x"10";
      val_for_in2(2) <= 32x"4";
      val_for_in2(3) <= 32x"5";
      val_for_in2(4) <= 32x"2";

      for i in 0 to 10 loop
         alu_op_tb <= std_logic_vector(to_unsigned(i, 4));
         report "Current operation: " & integer'image(i);
         wait for 10 ns;
         for j in 0 to 4 loop
            alu_in1_tb <= val_for_in1(j);
            alu_in2_tb <= val_for_in2(j);
            report "i: " & integer'image(i) & " val_for_in1: " &
               integer'image(to_integer(unsigned(val_for_in1(j)))) &
               " val_for_in2: " &
               integer'image(to_integer(unsigned(val_for_in2(j)))) & 
               " alu_out_tb: " &
               integer'image(to_integer(unsigned(alu_out_tb)));
            wait for 10 ns;
         end loop;
      end loop;
       
      wait for 25 ns;
      stop(2); 
   end process p_tb;

end architecture tb;
