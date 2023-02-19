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

   signal clk_tb        :   std_logic;
   signal rs1_d_tb      :   std_logic_vector(REG_LEN-1 downto 0);
   signal pc_tb         :   std_logic_vector(REG_LEN-1 downto 0);
   signal alu1_sel_tb   :   std_logic;
   signal alu_in1_tb    :   std_logic_vector(REG_LEN-1 downto 0);
   type t_val_for_rs1_d is array(0 to 4) of std_logic_vector(31 downto 0);
   signal val_for_rs1_d : t_val_for_rs1_d;
   type t_val_for_pc    is array(0 to 5) of std_logic_vector(31 downto 0);
   signal val_for_pc    : t_val_for_pc;

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
      val_for_rs1_d(0)  <= 32x"10";
      val_for_rs1_d(1)  <= 32x"3";
      val_for_rs1_d(2)  <= 32sx"FFFC"; -- -4
      val_for_rs1_d(3)  <= 32x"5";  
      val_for_rs1_d(4)  <= 32sx"FFF0"; -- -16 

      val_for_pc(0)     <= 32x"0";
      val_for_pc(1)     <= 32x"1"; 
      val_for_pc(2)     <= 32x"2"; 
      val_for_pc(3)     <= 32x"10"; 
      val_for_pc(4)     <= 32sx"FFFC"; -- -16
      val_for_pc(5)     <= 32sx"FFF0"; -- -4

      alu1_sel_tb       <= '0';
      for i in 0 to 4 loop
         wait for 10 ns;
         rs1_d_tb    <= val_for_rs1_d(i);
      end loop;

      alu1_sel_tb    <= '1';
      for i in 0 to 5 loop
         wait for 10 ns;
         pc_tb       <= val_for_pc(i);
      end loop;

      wait for 25 ns;
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
