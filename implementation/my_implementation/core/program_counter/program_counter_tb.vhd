library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;

entity program_counter_tb is
end program_counter_tb;

architecture tb of program_counter_tb is

   component program_counter is
   port (
      i_rst          : in std_logic;
      i_clk          : in std_logic;
      i_alu_result   : in std_logic_vector(31 downto 0);
      i_pc_ctrl      : in std_logic_vector(1 downto 0);
      o_pc_addr      : out std_logic_vector(31 downto 0)
   );
   end component program_counter;

   signal rst_tb        : std_logic;
   signal clk_tb        : std_logic;
   signal alu_result_tb : std_logic_vector(31 downto 0);
   signal pc_ctrl_tb    : std_logic_vector(1 downto 0);
   signal pc_addr_tb    : std_logic_vector(31 downto 0);

begin

   inst_program_counter : component program_counter 
   port map (
      i_rst         => rst_tb,
      i_clk         => clk_tb,
      i_alu_result  => alu_result_tb,
      i_pc_ctrl     => pc_ctrl_tb,
      o_pc_addr     => pc_addr_tb
   );

   p_tb : process
   begin
       
      wait for 25 ns;
      stop(2); 
   end process p_tb;

end architecture tb;
