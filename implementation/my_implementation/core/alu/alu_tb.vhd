library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;

entity alu_tb is
end alu_tb;

architecture tb of alu_tb is

   component alu is
   port (
      i_rst             : in std_logic;
      i_alu_operand_1   : in std_logic_vector(31 downto 0);
      i_alu_operand_2   : in std_logic_vector(31 downto 0);
      i_alu_control     : in std_logic_vector(5 downto 0);
      o_alu_result      : out std_logic_vector(31 downto 0)
   );
   end component alu;

   signal rst_tb           : std_logic;
   signal alu_operand_1_tb : std_logic_vector(31 downto 0);
   signal alu_operand_2_tb : std_logic_vector(31 downto 0);
   signal alu_control_tb   : std_logic_vector(5 downto 0);
   signal alu_result_tb    : std_logic_vector(31 downto 0);

begin

   inst_alu : component alu 
   port map (
      i_rst             => rst_tb,
      i_alu_operand_1   => alu_operand_1_tb,
      i_alu_operand_2   => alu_operand_2_tb,
      i_alu_control     => alu_control_tb,
      o_alu_result      => alu_result_tb
   );

   p_tb : process
   begin

      alu_operand_1_tb  <= (others => '0');
      alu_operand_2_tb  <= (others => '0');
      alu_control_tb    <= (others => '0');
      rst_tb            <= '1';
      wait for 20 ns;
      rst_tb            <= '0';
      -- ADD instruction
      alu_control_tb    <= "000000";
      alu_operand_1_tb  <= 32d"2";
      alu_operand_2_tb  <= 32d"11";
      wait for 20 ns;
      alu_operand_1_tb  <= 32d"4";
      alu_operand_2_tb  <= 32d"4";
      wait for 20 ns;
      alu_operand_1_tb  <= 32d"10";
      alu_operand_2_tb  <= 32x"FFFFFFFC"; -- -4
      wait for 20 ns;
      alu_operand_1_tb  <= 32d"20";
      alu_operand_2_tb  <= 32x"FFFFFFF0"; -- -16
      wait for 20 ns;

      wait for 25 ns;
      stop(2); 
   end process p_tb;

end architecture tb;
