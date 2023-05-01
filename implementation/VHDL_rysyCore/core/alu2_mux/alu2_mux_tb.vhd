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
      signal alu_in2  : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component alu2_mux_design;

   signal rs2_d_tb      : std_logic_vector(REG_LEN-1 downto 0);   
   signal imm_tb        : std_logic_vector(REG_LEN-1 downto 0); 
   signal alu2_sel_tb   : std_logic;
   signal alu_in2_tb   : std_logic_vector(REG_LEN-1 downto 0); 
   type t_val_for_rs2_d is array(0 to 4) of std_logic_vector(31 downto 0);
   signal val_for_rs2_d : t_val_for_rs2_d;
   type t_val_for_imm   is array(0 to 5) of std_logic_vector(31 downto 0);
   signal val_for_imm   : t_val_for_imm;

begin
   inst_alu2_mux : component alu2_mux_design 
   port map (
      rs2_d       => rs2_d_tb,
      imm         => imm_tb,
      alu2_sel    => alu2_sel_tb,
      alu_in2    => alu_in2_tb
   );

   p_tb : process
   begin
      val_for_rs2_d(0)   <= 32x"10";
      val_for_rs2_d(1)   <= 32x"3";
      val_for_rs2_d(2)   <= 32sx"FFF0"; -- -4
      val_for_rs2_d(3)   <= 32x"4";
      val_for_rs2_d(4)   <= 32sx"FFFC"; -- -16
      val_for_imm(0)     <= 32x"0";
      val_for_imm(1)     <= 32x"1";
      val_for_imm(2)     <= 32x"2";
      val_for_imm(3)     <= 32x"10";
      val_for_imm(4)     <= 32sx"FFFC";  -- -16
      val_for_imm(5)     <= 32sx"FFF0"; -- -4

      alu2_sel_tb        <= '0';
      for i in 0 to 4 loop
         wait for 10 ns;
         rs2_d_tb       <= val_for_rs2_d(i);
      end loop;

      wait for 10 ns;
      alu2_sel_tb       <= '1';
      for i in 0 to 5 loop
         imm_tb         <= val_for_imm(i);
      end loop;

      wait for 25 ns;
      stop(2); 
   end process p_tb;

end architecture tb;
