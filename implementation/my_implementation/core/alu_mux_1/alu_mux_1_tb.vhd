library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;

entity alu_mux_1_tb is
end alu_mux_1_tb;

architecture tb of alu_mux_1_tb is

   component alu_mux_1 is
   port (
      i_rst             : in std_logic;
      i_alu_mux_1_ctrl  : in std_logic;
      i_rs1_data        : in std_logic_vector(31 downto 0);
      i_pc_addr         : in std_logic_vector(31 downto 0);
      o_alu_operand_1   : out std_logic_vector(31 downto 0)
   );
   end component alu_mux_1;

   signal rst_tb              : std_logic;
   signal alu_mux_1_ctrl_tb   : std_logic;
   signal rs1_data_tb         : std_logic_vector(31 downto 0);
   signal pc_addr_tb          : std_logic_vector(31 downto 0);
   signal alu_operand_1_tb    : std_logic_vector(31 downto 0);

begin

   inst_alu_mux_1 : component alu_mux_1
   port map (
      i_rst             => rst_tb,
      i_alu_mux_1_ctrl  => alu_mux_1_ctrl_tb,
      i_rs1_data        => rs1_data_tb,
      i_pc_addr         => pc_addr_tb,
      o_alu_operand_1   => alu_operand_1_tb
   );

   p_tb : process
   begin

      rst_tb            <= '1';
      alu_mux_1_ctrl_tb <= '0';
      rs1_data_tb       <= (others => '0');
      pc_addr_tb        <= (others => '0');
      wait for 20 ns;
      rst_tb            <= '0';
      alu_mux_1_ctrl_tb <= '0';
      rs1_data_tb       <= 32d"10";
      wait for 20 ns;
      rs1_data_tb       <= 32d"4";
      wait for 20 ns;
      alu_mux_1_ctrl_tb <= '1';
      pc_addr_tb        <= 32d"8";
      wait for 20 ns;
      pc_addr_tb        <= 32d"321";

      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
