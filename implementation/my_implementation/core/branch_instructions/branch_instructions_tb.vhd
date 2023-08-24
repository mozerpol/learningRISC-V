library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;
library branch_instructions_lib;
   use branch_instructions_lib.all;
   use branch_instructions_lib.branch_instructions_pkg.all;

entity branch_instructions_tb is
end branch_instructions_tb;

architecture tb of branch_instructions_tb is

   component branch_instructions is
   port (
      i_rst             : in std_logic;
      i_branch_ctrl     : in std_logic_vector(2 downto 0);
      i_rs1_data        : in std_logic_vector(31 downto 0);
      i_rs2_data        : in std_logic_vector(31 downto 0);
      o_branch_result   : out std_logic
   );
   end component branch_instructions;

   signal rst_tb           : std_logic;
   signal branch_ctrl_tb   : std_logic_vector(2 downto 0);
   signal rs1_data_tb      : std_logic_vector(31 downto 0);
   signal rs2_data_tb      : std_logic_vector(31 downto 0);
   signal branch_result_tb : std_logic;

begin

   inst_branch_instructions : component branch_instructions
   port map (
      i_rst             => rst_tb,
      i_branch_ctrl     => branch_ctrl_tb,
      i_rs1_data        => rs1_data_tb,
      i_rs2_data        => rs2_data_tb,
      o_branch_result   => branch_result_tb
   );

   p_tb : process
   begin
      rst_tb            <= '1';
      branch_ctrl_tb    <= (others => '0');
      rs1_data_tb       <= (others => '0');
      rs2_data_tb       <= (others => '0');
      branch_result_tb  <= '0';
      wait for 10 ns;
      rst_tb            <= '0';

      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
