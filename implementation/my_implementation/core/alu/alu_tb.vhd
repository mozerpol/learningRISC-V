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
      i_control         : in std_logic_vector(4 downto 0);
      o_alu_out         : out std_logic_vector(31 downto 0)
   );
   end component alu;

   signal rst_tb           : std_logic;
   signal alu_operand_1_tb : std_logic_vector(31 downto 0);
   signal alu_operand_2_tb : std_logic_vector(31 downto 0);
   signal control_tb       : std_logic_vector(4 downto 0);
   signal alu_out_tb       : std_logic_vector(31 downto 0);

begin

   inst_alu : component alu 
   port map (
      i_rst             => rst_tb,
      i_alu_operand_1   => alu_operand_1_tb,
      i_alu_operand_2   => alu_operand_2_tb,
      i_control         => control_tb,
      o_alu_out         => alu_out_tb
   );

   p_tb : process
   begin
       
      wait for 25 ns;
      stop(2); 
   end process p_tb;

end architecture tb;
