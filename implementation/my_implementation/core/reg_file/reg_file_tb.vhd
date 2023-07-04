library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;

entity reg_file_tb is
end reg_file_tb;

architecture tb of reg_file_tb is

   component reg_file is
   port (
      i_rst          : in std_logic;
      i_clk          : in std_logic;
      i_rs1_addr     : in std_logic_vector(5 downto 0); -- address of rs1
      i_rs2_addr     : in std_logic_vector(5 downto 0); -- address of rs2
      i_rd_addr      : in std_logic_vector(4 downto 0);
      i_reg_wr_ctrl  : in std_logic;
      i_alu_out      : in std_logic_vector(31 downto 0);
      o_rs1_data     : out std_logic_vector(31 downto 0);
      o_rs2_data     : out std_logic_vector(31 downto 0)
   );
   end component reg_file;

   signal rst_tb           : std_logic;
   signal clk_tb           : std_logic;
   signal rs1_addr_tb      : std_logic_vector(5 downto 0);
   signal rs2_addr_tb      : std_logic_vector(5 downto 0);
   signal rd_addr_tb       : std_logic_vector(4 downto 0);
   signal reg_wr_ctrl_tb   : std_logic;
   signal alu_out_tb       : std_logic_vector(31 downto 0);
   signal rs1_data_tb      : std_logic_vector(31 downto 0);
   signal rs2_data_tb      : std_logic_vector(31 downto 0);

begin

   inst_reg_file : component reg_file
   port map (
      i_rst          => rst_tb,
      i_clk          => clk_tb,
      i_rs1_addr     => rs1_addr_tb,
      i_rs2_addr     => rs2_addr_tb,
      i_rd_addr      => rd_addr_tb,
      i_reg_wr_ctrl  => reg_wr_ctrl_tb,
      i_alu_out      => alu_out_tb,
      o_rs1_data     => rs1_data_tb,
      o_rs2_data     => rs2_data_tb
   );

   p_clk : process
   begin
      clk_tb <= '1';
      wait for 1 ns;
      clk_tb <= '0';
      wait for 1 ns;
   end process p_clk;

   p_tb : process
   begin

      rst_tb         <= '1';
      rs1_addr_tb    <= (others => '0');
      rs2_addr_tb    <= (others => '0');
      rd_addr_tb     <= (others => '0');
      reg_wr_ctrl_tb <= '0';
      alu_out_tb     <= (others => '0');
      wait for 5 ns;
      rst_tb         <= '0';

      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
