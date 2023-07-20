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

   p_clk : process
   begin
      clk_tb   <= '1';
      wait for 1 ns;
      clk_tb   <= '0';
      wait for 1 ns;
   end process p_clk;

   p_tb : process
   begin

      rst_tb         <= '1';
      alu_result_tb  <= (others => '0');
      pc_ctrl_tb     <= (others => '0');
      wait for 5 ns;
      rst_tb         <= '0';
      pc_ctrl_tb     <= "10";
      alu_result_tb  <= 32d"16";
      wait until rising_edge(clk_tb);
      alu_result_tb  <= (others => '0');
      wait until rising_edge(clk_tb);
      pc_ctrl_tb     <= "00";
      wait until rising_edge(clk_tb);
      wait until rising_edge(clk_tb);
      wait until rising_edge(clk_tb);
      pc_ctrl_tb     <= "01";
       
      wait for 25 ns;
      stop(2); 
   end process p_tb;

end architecture tb;
