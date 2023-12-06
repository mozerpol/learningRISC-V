library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;

entity alu_mux_2_tb is
end alu_mux_2_tb;

architecture tb of alu_mux_2_tb is

   component alu_mux_2 is
   port (
      i_rst             : in std_logic;
      i_alu_mux_2_ctrl  : in std_logic;
      i_rs2_data        : in std_logic_vector(31 downto 0);    -- From reg_file
      i_imm             : in std_logic_vector(31 downto 0);
      o_alu_operand_2   : out std_logic_vector(31 downto 0)
   );
   end component alu_mux_2;

   signal rst_tb              : std_logic;
   signal alu_mux_2_ctrl_tb   : std_logic;
   signal rs2_data_tb         : std_logic_vector(31 downto 0);
   signal imm_tb              : std_logic_vector(31 downto 0);
   signal alu_operand_2_tb    : std_logic_vector(31 downto 0);

begin
   inst_alu_mux_2 : component alu_mux_2
   port map (
      i_rst             => rst_tb,
      i_alu_mux_2_ctrl  => alu_mux_2_ctrl_tb,
      i_rs2_data        => rs2_data_tb,
      i_imm             => imm_tb,
      o_alu_operand_2   => alu_operand_2_tb
   );

   p_tb : process
   begin

      alu_mux_2_ctrl_tb <= '0';
      rs2_data_tb       <= (others => '0');
      imm_tb            <= (others => '0');
      rst_tb            <= '1';
      wait for 20 ns;
      rst_tb            <= '0';
      alu_mux_2_ctrl_tb <= '0';
      rs2_data_tb       <= 32d"22";
      wait for 20 ns;
      rs2_data_tb       <= 32d"99";
      wait for 20 ns;
      alu_mux_2_ctrl_tb <= '1';
      imm_tb            <= 32d"14";
      wait for 20 ns;
      imm_tb            <= 32d"3";

      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
