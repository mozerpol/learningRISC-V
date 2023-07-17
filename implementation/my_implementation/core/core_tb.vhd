library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;

entity core_tb is
end core_tb;


architecture tb of core_tb is

   component core is
   port (
      i_rst                : in std_logic;
      i_clk                : in std_logic;
      i_instruction_read   : in std_logic_vector(31 downto 0);
      o_instruction_write  : out std_logic_vector(31 downto 0);
      o_addr_read          : out std_logic_vector(7 downto 0);
      o_addr_write         : out std_logic_vector(7 downto 0);
      o_write_enable       : out std_logic
   );
   end component core;

   signal rst_tb                 : std_logic;
   signal clk_tb                 : std_logic;
   signal instruction_read_tb    : std_logic_vector(31 downto 0);
   signal instruction_write_tb   : std_logic_vector(31 downto 0);
   signal addr_read_tb           : std_logic_vector(7 downto 0);
   signal addr_write_tb          : std_logic_vector(7 downto 0);
   signal write_enable_tb        : std_logic;
   type t_gpr  is array(0 to 31) of std_logic_vector(31 downto 0);
   alias spy_gpr is <<signal .core_tb.inst_core.inst_reg_file.gpr: t_gpr >>;

begin

   inst_core : component core
   port map (
      i_rst                => rst_tb,
      i_clk                => clk_tb,
      i_instruction_read   => instruction_read_tb,
      o_instruction_write  => instruction_write_tb,
      o_addr_read          => addr_read_tb,
      o_addr_write         => addr_write_tb,
      o_write_enable       => write_enable_tb
   );

   p_clk : process
   begin
      clk_tb   <= '1';
      wait for 1 ns;
      clk_tb   <= '0';
      wait for 1 ns;
   end process;

   p_tb : process
   begin
      
      rst_tb               <= '1';
      instruction_read_tb  <= (others => '0');
      wait for 20 ns;
      wait until rising_edge(clk_tb);
      rst_tb               <= '0';
      
      -- addi x1, x0, 10 - Add x0 and 10, save 10 in x1. x1 = 10 = A
      instruction_read_tb  <= x"00a00093";
      wait until rising_edge(clk_tb);
      -- addi x2, x0, -667, x2 = -667 = FD65
      instruction_read_tb  <= x"d6500113";
      wait until rising_edge(clk_tb);
      -- add x3, x2, x1 - x3 = -657 = FD6F
      instruction_read_tb  <= x"001101b3";
      wait until rising_edge(clk_tb);
      -- 
      instruction_read_tb  <= x"";
      wait until rising_edge(clk_tb);



      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
