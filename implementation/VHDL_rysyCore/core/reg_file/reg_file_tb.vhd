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
   signal wr         : std_logic;
   signal rs1_addr   : std_logic_vector(ADDR_LEN-1 downto 0);
   signal rs2_addr   : std_logic_vector(ADDR_LEN-1 downto 0);
   signal rd_addr    : std_logic_vector(ADDR_LEN-1 downto 0);
   signal rd_data    : std_logic_vector(REG_LEN-1 downto 0);
   signal rs1_data   : std_logic_vector(REG_LEN-1 downto 0);
   signal rs2_data   : std_logic_vector(REG_LEN-1 downto 0);
   
begin
   inst_reg_file : component reg_file_design 
   generic map (
      ADDR_LEN => 5
   )
   port map (
      clk      => clk_tb,
      reg_wr   => wr,
      rs1      => rs1_addr,
      rs2      => rs2_addr,
      rd       => rd_addr,
      rd_d     => rd_data,
      rs1_d    => rs1_data,
      rs2_d    => rs2_data
   );
   
   p_tb : process
   begin
      rs1_addr  <= (others => '0');
      rs2_addr  <= (others => '0');
      rd_addr   <= (others => '0');
      rd_data   <= (others => '0');
      wr        <= '0';
      wait for 30 ns;
      rd_data   <= 32x"00000001";
      rd_addr   <= 5x"01";
      wr        <= '1';
      wait for 30 ns;
      wr        <= '0';
      rd_data   <= 32x"00000002";
      rd_addr  <= 5x"03";
      wait for 5 ns;
      wr        <= '1';
      wait for 5 ns;
      wr        <= '0';
      rs1_addr  <= 5x"01";
      wait for 10 ns;
      rs2_addr  <= 5x"03";
      wait for 10 ns;
      rd_addr   <= 5x"00";
      wr        <= '1';
      rs2_addr  <= 5x"00";
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
