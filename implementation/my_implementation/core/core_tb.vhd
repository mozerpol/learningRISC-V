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
      i_ram_data_read      : in std_logic_vector(31 downto 0);
      o_ram_data_write     : out std_logic_vector(31 downto 0);
      o_ram_addr           : out std_logic_vector(7 downto 0);
      o_write_enable       : out std_logic
   );
   end component core;

   signal rst_tb                 : std_logic;
   signal clk_tb                 : std_logic;
   signal ram_data_read_tb       : std_logic_vector(31 downto 0);
   signal ram_data_write_tb      : std_logic_vector(31 downto 0);
   signal ram_addr_tb            : std_logic_vector(7 downto 0);
   signal write_enable_tb        : std_logic;
  -- type t_gpr  is array(0 to 31) of std_logic_vector(31 downto 0);
  -- alias spy_gpr is <<signal .core_tb.inst_core.inst_reg_file.gpr: t_gpr >>;

begin

   inst_core : component core
   port map (
      i_rst                => rst_tb,
      i_clk                => clk_tb,
      i_ram_data_read      => ram_data_read_tb,
      o_ram_data_write     => ram_data_write_tb,
      o_ram_addr           => ram_addr_tb,
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

      rst_tb            <= '1';
      ram_data_read_tb  <= (others => '0');
      wait for 20 ns;
      wait until rising_edge(clk_tb);
      rst_tb            <= '0';
      wait until ram_addr_tb = d"12";
      ram_data_read_tb  <= x"0000000c";


--      -- addi x1, x0, 10      ---- x1  =  x0  +  10    = 10
--      instruction_read_tb  <= x"00a00093";
--      wait until rising_edge(clk_tb);
--      -- addi x2, x0, -667    ---- x2  =  x0  + (-667) = -667
--      instruction_read_tb  <= x"d6500113";
--      wait until rising_edge(clk_tb);
--      -- add x3, x2, x1       ---- x3  =  x2  + x1     = -657
--      instruction_read_tb  <= x"001101b3";
--      wait until rising_edge(clk_tb);
--      -- sub x3, x1, x2       ---- x3  =  x1  - x2     = 677
--      instruction_read_tb  <= x"402081b3";
--      wait until rising_edge(clk_tb);
--      -- slti x4, x2, 20      ---- x4  =  x2  > 20     = 1
--      instruction_read_tb  <= x"01412213";
--      wait until rising_edge(clk_tb);
--      -- sll x5, x4, x1       ---- x5  = x4  << x1     = 1024
--      instruction_read_tb  <= x"001212b3";
--      wait until rising_edge(clk_tb);
--      -- xori x4, x4, 1       ---- X4  = X4  xori 1    = 0
--      instruction_read_tb  <= x"00124213";
--      wait until rising_edge(clk_tb);
--      -- sra x3, x1, x2       ---- x3  = x1 >>  x2     = 0
--      instruction_read_tb  <= x"4020d1b3";
--      wait until rising_edge(clk_tb);
--      ---- LUI ----
--      -- lui x1, 0xFFFFF
--      instruction_read_tb  <= x"fffff0b7";
--      wait until rising_edge(clk_tb);
--      -- lui x1, 0x123
--      instruction_read_tb  <= x"001230b7";
--      wait until rising_edge(clk_tb);
--      -- lui x1, 0x9
--      instruction_read_tb  <= x"000090b7";
--      wait until rising_edge(clk_tb);
--      ---- STORE ----
--      -- SW
--      -- addi x1 x0 3
--      instruction_read_tb  <= x"00300093";
--      wait until rising_edge(clk_tb);
--      -- addi x2 x0 0xff
--      instruction_read_tb  <= x"0ff00113";
--      wait until rising_edge(clk_tb);
--      -- sw x2 1(x1)
--      instruction_read_tb  <= x"0020a0a3";
--      wait until rising_edge(clk_tb);
--      -- SH
--      -- addi x1 x0 3
--      instruction_read_tb  <= x"00300093";
--      wait until rising_edge(clk_tb);
--      -- lui x2, 0xfffff
--      instruction_read_tb  <= x"fffff137";
--      wait until rising_edge(clk_tb);
--      -- sh x2 1(x1)
--      instruction_read_tb  <= x"002090a3";
--      wait until rising_edge(clk_tb);

      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
