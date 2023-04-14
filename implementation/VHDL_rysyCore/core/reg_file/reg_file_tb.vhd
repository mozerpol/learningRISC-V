library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity reg_file_tb is
end reg_file_tb;

architecture tb of reg_file_tb is

   component reg_file_design is
      generic (
         ADDR_LEN : integer := 5
      );
      port (
         signal clk     : in std_logic;
         signal reg_wr  : in std_logic;
         signal rs1     : in std_logic_vector(ADDR_LEN-1 downto 0);
         signal rs2     : in std_logic_vector(ADDR_LEN-1 downto 0);
         signal rd      : in std_logic_vector(ADDR_LEN-1 downto 0);
         signal rd_d    : in std_logic_vector(REG_LEN-1 downto 0);
         signal rs1_d   : out std_logic_vector(REG_LEN-1 downto 0);
         signal rs2_d   : out std_logic_vector(REG_LEN-1 downto 0)
      );
   end component reg_file_design;

   signal clk_tb     : std_logic;
   signal reg_wr_tb  : std_logic;
   signal rs1_tb     : std_logic_vector(ADDR_LEN-1 downto 0);
   signal rs2_tb     : std_logic_vector(ADDR_LEN-1 downto 0);
   signal rd_tb      : std_logic_vector(ADDR_LEN-1 downto 0);
   signal rd_d_tb    : std_logic_vector(REG_LEN-1 downto 0);
   signal rs1_d_tb   : std_logic_vector(REG_LEN-1 downto 0);
   signal rs2_d_tb   : std_logic_vector(REG_LEN-1 downto 0);
   
begin
   inst_reg_file : component reg_file_design 
   generic map (
      ADDR_LEN => 5
   )
   port map (
      clk      => clk_tb,
      reg_wr   => reg_wr_tb,
      rs1      => rs1_tb,
      rs2      => rs2_tb,
      rd       => rd_tb,
      rd_d     => rd_d_tb,
      rs1_d    => rs1_d_tb,
      rs2_d    => rs2_d_tb
   );

   p_tb : process
   begin
      rs1_tb      <= (others => '0');
      rs2_tb      <= (others => '0');
      rd_tb       <= (others => '0');
      rd_d_tb     <= (others => '0');
      reg_wr_tb   <= '0';
      wait for 30 ns;
      rd_d_tb     <= 32x"1";
      rs1_tb      <= (others => '0');
      reg_wr_tb   <= '1';
      wait for 30 ns;
      rs1_tb      <= 5x"3";
      rd_tb       <= 5x"2";
      reg_wr_tb   <= '0';
      wait for 30 ns;
      reg_wr_tb   <= '1';
      wait for 30 ns;
      reg_wr_tb   <= '0';
      rs1_tb      <= 5x"4";
      wait for 25 ns;
      stop(2); 
   end process p_tb;

   p_clk : process
   begin
      clk_tb <= '0';
      wait for 1 ns;
      clk_tb <= '1';
      wait for 1 ns;
   end process p_clk;

end architecture tb;
