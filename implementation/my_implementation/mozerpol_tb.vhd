--------------------------------------------------------------------------------
-- File          : mozerpol_tb.vhd
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : Test for the entire processor (mozerpol entity in
-- mozerpol_design).
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
   use std.env.all;
library mozerpol_lib;
   use mozerpol_lib.all;
   use mozerpol_lib.mozerpol_pkg.all;

entity mozerpol_tb is
end mozerpol_tb;

architecture tb of mozerpol_tb is


   component mozerpol is
   port (
      i_rst       : in std_logic;
      i_clk       : in std_logic;
      o_gpio      : out std_logic_vector(3 downto 0)
   );
   end component mozerpol;

   signal rst_tb  : std_logic;
   signal clk_tb  : std_logic;
   signal gpio_tb : std_logic_vector(3 downto 0);
   type t_gpr  is array(0 to 31) of std_logic_vector(31 downto 0);
   signal set_test_point : integer := 0;
   type word_t is array (0 to 3) of std_logic_vector(7 downto 0);
   type ram_t is array (0 to C_RAM_LENGTH - 1) of word_t;

begin

   inst_mozerpol : component mozerpol
   port map (
      i_rst       => rst_tb,
      i_clk       => clk_tb,
      o_gpio      => gpio_tb
   );

   p_clk : process
   begin
      clk_tb   <= '1';
      wait for 1 ns;
      clk_tb   <= '0';
      wait for 1 ns;
   end process;

   p_tb : process
      alias spy_gpr is <<signal .mozerpol_tb.inst_mozerpol.inst_core.inst_reg_file.gpr: t_gpr >>;
      alias spy_ram is <<signal .mozerpol_tb.inst_mozerpol.inst_memory.ram: ram_t >>;
   begin
      rst_tb   <= '1';
      wait for 20 ns;
      rst_tb   <= '0';
      wait until rising_edge(clk_tb);
      wait until rising_edge(clk_tb);
      wait until rising_edge(clk_tb);
      -- report "GPR(1): " & to_string(spy_gpr(1));
      ----------------------------------------------------------------
      --                                                            --
      --    addi, slti, sltiu, xori, ori, andi, slli, srli, srai    --
      --                                                            --
      ----------------------------------------------------------------
      --------------
      --   ADDI   --
      --------------
      -- addi  x1,  x0,   -2048 # x1 = 0xfffff800    
      if (spy_gpr(1) /= 32x"fffff800") then
         report "ERROR: addi  x1,  x0,   -2048 # x1 = 0xfffff800 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x2,  x0,   -511  # x2 = 0xfffffe01    
      if (spy_gpr(2) /= 32x"fffffe01") then
         report "ERROR: addi  x2,  x0,   -511  # x2 = 0xfffffe01 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x3,  x0,   -2    # x3 = 0xfffffffe    
      if (spy_gpr(3) /= 32x"fffffffe") then
         report "ERROR: addi  x3,  x0,   -2    # x3 = 0xfffffffe | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x4,  x0,   0     # x4 = 0x00000000    
      if (spy_gpr(4) /= 32x"00000000") then
         report "ERROR: addi  x4,  x0,   0     # x4 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x5,  x0,   1     # x5 = 0x00000001    
      if (spy_gpr(5) /= 32x"00000001") then
         report "ERROR: addi  x5,  x0,   1     # x5 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x6,  x0,   511   # x6 = 0x000001ff    
      if (spy_gpr(6) /= 32x"000001ff") then
         report "ERROR: addi  x6,  x0,   511   # x6 = 0x000001ff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x7,  x0,   2047  # x7 = 0x000007ff    
      if (spy_gpr(7) /= 32x"000007ff") then
         report "ERROR: addi  x7,  x0,   2047  # x7 = 0x000007ff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x1,  x7,   -2048 # x1 = 0xffffffff    
      if (spy_gpr(1) /= 32x"ffffffff") then
         report "ERROR: addi  x1,  x7,   -2048 # x1 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x2,  x6,   -511  # x2 = 0x00000000    
      if (spy_gpr(2) /= 32x"00000000") then
         report "ERROR: addi  x2,  x6,   -511  # x2 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x3,  x5,   -2    # x3 = 0xffffffff    
      if (spy_gpr(3) /= 32x"ffffffff") then
         report "ERROR: addi  x3,  x5,   -2    # x3 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x4,  x4,   0     # x4 = 0x00000000    
      if (spy_gpr(4) /= 32x"00000000") then
         report "ERROR: addi  x4,  x4,   0     # x4 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x5,  x3,   1     # x5 = 0x00000000    
      if (spy_gpr(5) /= 32x"00000000") then
         report "ERROR: addi  x5,  x3,   1     # x5 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x6,  x2,   511   # x6 = 0x000001ff    
      if (spy_gpr(6) /= 32x"000001ff") then
         report "ERROR: addi  x6,  x2,   511   # x6 = 0x000001ff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x7,  x1,   2047  # x7 = 0x000007fe    
      if (spy_gpr(7) /= 32x"000007fe") then
         report "ERROR: addi  x7,  x1,   2047  # x7 = 0x000007fe | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x1,  x1,   2047  # x1 = 0x000007fe    
      if (spy_gpr(1) /= 32x"000007fe") then
         report "ERROR: addi  x1,  x1,   2047  # x1 = 0x000007fe | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x1,  x1,   -2048 # x1 = 0xfffffffe    
      if (spy_gpr(1) /= 32x"fffffffe") then
         report "ERROR: addi  x1,  x1,   -2048 # x1 = 0xfffffffe | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   SLTI   --
      --------------
      -- slti  x8,  x0,   -2048 # x8 = 0x00000000    
      if (spy_gpr(8) /= 32x"00000000") then
         report "ERROR: slti  x8,  x0,   -2048 # x8 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x9,  x0,   -511  # x9 = 0x00000000    
      if (spy_gpr(9) /= 32x"00000000") then
         report "ERROR: slti  x9,  x0,   -511  # x9 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x10, x0,   -2    # x10 = 0x00000000    
      if (spy_gpr(0) /= 32x"00000000") then
         report "ERROR: slti  x10, x0,   -2    # x10 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x11, x0,   0     # x11 = 0x00000000    
      if (spy_gpr(1) /= 32x"00000000") then
         report "ERROR: slti  x11, x0,   0     # x11 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x12, x0,   1     # x12 = 0x00000001    
      if (spy_gpr(2) /= 32x"00000001") then
         report "ERROR: slti  x12, x0,   1     # x12 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x13, x0,   511   # x13 = 0x00000001    
      if (spy_gpr(3) /= 32x"00000001") then
         report "ERROR: slti  x13, x0,   511   # x13 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x14, x0,   2047  # x14 = 0x00000001    
      if (spy_gpr(4) /= 32x"00000001") then
         report "ERROR: slti  x14, x0,   2047  # x14 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x8,  x7,   -2048 # x8 = 0x00000000    
      if (spy_gpr(8) /= 32x"00000000") then
         report "ERROR: slti  x8,  x7,   -2048 # x8 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x9,  x1,   -511  # x9 = 0x00000000    
      if (spy_gpr(9) /= 32x"00000000") then
         report "ERROR: slti  x9,  x1,   -511  # x9 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x10, x12,  -2    # x10 = 0x00000000    
      if (spy_gpr(0) /= 32x"00000000") then
         report "ERROR: slti  x10, x12,  -2    # x10 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x11, x11,  0     # x11 = 0x00000000    
      if (spy_gpr(1) /= 32x"00000000") then
         report "ERROR: slti  x11, x11,  0     # x11 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x12, x10,  1     # x12 = 0x00000001    
      if (spy_gpr(2) /= 32x"00000001") then
         report "ERROR: slti  x12, x10,  1     # x12 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x13, x6,   511   # x13 = 0x00000000    
      if (spy_gpr(3) /= 32x"00000000") then
         report "ERROR: slti  x13, x6,   511   # x13 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x14, x9,   2047  # x14 = 0x00000001    
      if (spy_gpr(4) /= 32x"00000001") then
         report "ERROR: slti  x14, x9,   2047  # x14 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x14, x14,  2047  # x14 = 0x00000001    
      if (spy_gpr(4) /= 32x"00000001") then
         report "ERROR: slti  x14, x14,  2047  # x14 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x14, x14,  -2048 # x14 = 0x00000000    
      if (spy_gpr(4) /= 32x"00000000") then
         report "ERROR: slti  x14, x14,  -2048 # x14 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   SLTIU  --
      --------------
      -- sltiu x15, x0,   -2048 # x15 = 0x00000001    
      if (spy_gpr(5) /= 32x"00000001") then
         report "ERROR: sltiu x15, x0,   -2048 # x15 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x16, x0,   -511  # x16 = 0x00000001    
      if (spy_gpr(6) /= 32x"00000001") then
         report "ERROR: sltiu x16, x0,   -511  # x16 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x17, x0,   -2    # x17 = 0x00000001    
      if (spy_gpr(7) /= 32x"00000001") then
         report "ERROR: sltiu x17, x0,   -2    # x17 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x18, x0,   0     # x18 = 0x00000000    
      if (spy_gpr(8) /= 32x"00000000") then
         report "ERROR: sltiu x18, x0,   0     # x18 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x19, x0,   1     # x19 = 0x00000001    
      if (spy_gpr(9) /= 32x"00000001") then
         report "ERROR: sltiu x19, x0,   1     # x19 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x20, x0,   511   # x20 = 0x00000001    
      if (spy_gpr(0) /= 32x"00000001") then
         report "ERROR: sltiu x20, x0,   511   # x20 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x21, x0,   2047  # x21 = 0x00000001    
      if (spy_gpr(1) /= 32x"00000001") then
         report "ERROR: sltiu x21, x0,   2047  # x21 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x15, x7,   -2048 # x15 = 0x00000001    
      if (spy_gpr(5) /= 32x"00000001") then
         report "ERROR: sltiu x15, x7,   -2048 # x15 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x16, x1,   -511  # x16 = 0x00000000    
      if (spy_gpr(6) /= 32x"00000000") then
         report "ERROR: sltiu x16, x1,   -511  # x16 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x17, x19,  -2    # x17 = 0x00000001    
      if (spy_gpr(7) /= 32x"00000001") then
         report "ERROR: sltiu x17, x19,  -2    # x17 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x18, x18,  0     # x18 = 0x00000000    
      if (spy_gpr(8) /= 32x"00000000") then
         report "ERROR: sltiu x18, x18,  0     # x18 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x19, x17,  1     # x19 = 0x00000000    
      if (spy_gpr(9) /= 32x"00000000") then
         report "ERROR: sltiu x19, x17,  1     # x19 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x20, x6,   511   # x20 = 0x00000000    
      if (spy_gpr(0) /= 32x"00000000") then
         report "ERROR: sltiu x20, x6,   511   # x20 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x21, x15,  2047  # x21 = 0x00000001    
      if (spy_gpr(1) /= 32x"00000001") then
         report "ERROR: sltiu x21, x15,  2047  # x21 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x21, x21,  2047  # x21 = 0x00000001    
      if (spy_gpr(1) /= 32x"00000001") then
         report "ERROR: sltiu x21, x21,  2047  # x21 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x21, x21,  -2048 # x21 = 0x00000001    
      if (spy_gpr(1) /= 32x"00000001") then
         report "ERROR: sltiu x21, x21,  -2048 # x21 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   XORI   --
      --------------
      -- xori  x22, x0,   -2048 # x22 = 0xfffff800    
      if (spy_gpr(2) /= 32x"fffff800") then
         report "ERROR: xori  x22, x0,   -2048 # x22 = 0xfffff800 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x23, x0,   -511  # x23 = 0xfffffe01    
      if (spy_gpr(3) /= 32x"fffffe01") then
         report "ERROR: xori  x23, x0,   -511  # x23 = 0xfffffe01 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x24, x0,   -2    # x24 = 0xfffffffe    
      if (spy_gpr(4) /= 32x"fffffffe") then
         report "ERROR: xori  x24, x0,   -2    # x24 = 0xfffffffe | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x25, x0,   0     # x25 = 0x00000000    
      if (spy_gpr(5) /= 32x"00000000") then
         report "ERROR: xori  x25, x0,   0     # x25 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x26, x0,   1     # x26 = 0x00000001    
      if (spy_gpr(6) /= 32x"00000001") then
         report "ERROR: xori  x26, x0,   1     # x26 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x27, x0,   511   # x27 = 0x000001ff    
      if (spy_gpr(7) /= 32x"000001ff") then
         report "ERROR: xori  x27, x0,   511   # x27 = 0x000001ff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x28, x0,   2047  # x28 = 0x000007ff    
      if (spy_gpr(8) /= 32x"000007ff") then
         report "ERROR: xori  x28, x0,   2047  # x28 = 0x000007ff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x22, x28,  -2048 # x22 = 0xffffffff    
      if (spy_gpr(2) /= 32x"ffffffff") then
         report "ERROR: xori  x22, x28,  -2048 # x22 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x23, x27,  -511  # x23 = 0xfffffffe    
      if (spy_gpr(3) /= 32x"fffffffe") then
         report "ERROR: xori  x23, x27,  -511  # x23 = 0xfffffffe | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x24, x26,  -2    # x24 = 0xffffffff    
      if (spy_gpr(4) /= 32x"ffffffff") then
         report "ERROR: xori  x24, x26,  -2    # x24 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x25, x25,  0     # x25 = 0x00000000    
      if (spy_gpr(5) /= 32x"00000000") then
         report "ERROR: xori  x25, x25,  0     # x25 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x26, x24,  1     # x26 = 0xfffffffe    
      if (spy_gpr(6) /= 32x"fffffffe") then
         report "ERROR: xori  x26, x24,  1     # x26 = 0xfffffffe | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x27, x23,  511   # x27 = 0xfffffe01    
      if (spy_gpr(7) /= 32x"fffffe01") then
         report "ERROR: xori  x27, x23,  511   # x27 = 0xfffffe01 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x28, x22,  2047  # x28 = 0xfffff800    
      if (spy_gpr(8) /= 32x"fffff800") then
         report "ERROR: xori  x28, x22,  2047  # x28 = 0xfffff800 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x28, x28,  2047  # x28 = 0xffffffff    
      if (spy_gpr(8) /= 32x"ffffffff") then
         report "ERROR: xori  x28, x28,  2047  # x28 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x28, x28,  -2048 # x28 = 0x000007ff    
      if (spy_gpr(8) /= 32x"000007ff") then
         report "ERROR: xori  x28, x28,  -2048 # x28 = 0x000007ff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   ORI    --
      --------------
      -- ori   x29, x0,   -2048 # x29 = 0xfffff800    
      if (spy_gpr(9) /= 32x"fffff800") then
         report "ERROR: ori   x29, x0,   -2048 # x29 = 0xfffff800 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x30, x0,   -511  # x30 = 0xfffffe01    
      if (spy_gpr(0) /= 32x"fffffe01") then
         report "ERROR: ori   x30, x0,   -511  # x30 = 0xfffffe01 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x31, x0,   -2    # x31 = 0xfffffffe    
      if (spy_gpr(1) /= 32x"fffffffe") then
         report "ERROR: ori   x31, x0,   -2    # x31 = 0xfffffffe | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x1,  x0,   0     # x1 = 0x00000000    
      if (spy_gpr(1) /= 32x"00000000") then
         report "ERROR: ori   x1,  x0,   0     # x1 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x2,  x0,   1     # x2 = 0x00000001    
      if (spy_gpr(2) /= 32x"00000001") then
         report "ERROR: ori   x2,  x0,   1     # x2 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x3,  x0,   511   # x3 = 0x000001ff    
      if (spy_gpr(3) /= 32x"000001ff") then
         report "ERROR: ori   x3,  x0,   511   # x3 = 0x000001ff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x4,  x0,   2047  # x4 = 0x000007ff    
      if (spy_gpr(4) /= 32x"000007ff") then
         report "ERROR: ori   x4,  x0,   2047  # x4 = 0x000007ff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x29, x4,   -2048 # x29 = 0xffffffff    
      if (spy_gpr(9) /= 32x"ffffffff") then
         report "ERROR: ori   x29, x4,   -2048 # x29 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x30, x3,   -511  # x30 = 0xffffffff    
      if (spy_gpr(0) /= 32x"ffffffff") then
         report "ERROR: ori   x30, x3,   -511  # x30 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x31, x2,   -2    # x31 = 0xffffffff    
      if (spy_gpr(1) /= 32x"ffffffff") then
         report "ERROR: ori   x31, x2,   -2    # x31 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x1,  x1,   0     # x1 = 0x00000000    
      if (spy_gpr(1) /= 32x"00000000") then
         report "ERROR: ori   x1,  x1,   0     # x1 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x2,  x31,  1     # x2 = 0xffffffff    
      if (spy_gpr(2) /= 32x"ffffffff") then
         report "ERROR: ori   x2,  x31,  1     # x2 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x3,  x30,  511   # x3 = 0xffffffff    
      if (spy_gpr(3) /= 32x"ffffffff") then
         report "ERROR: ori   x3,  x30,  511   # x3 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x4,  x28,  2047  # x4 = 0x000007ff    
      if (spy_gpr(4) /= 32x"000007ff") then
         report "ERROR: ori   x4,  x28,  2047  # x4 = 0x000007ff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x4,  x4,   2047  # x4 = 0x000007ff    
      if (spy_gpr(4) /= 32x"000007ff") then
         report "ERROR: ori   x4,  x4,   2047  # x4 = 0x000007ff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x4,  x4,   -2048 # x4 = 0xffffffff    
      if (spy_gpr(4) /= 32x"ffffffff") then
         report "ERROR: ori   x4,  x4,   -2048 # x4 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   ANDI   --
      --------------
      -- andi  x5,  x0,   -2048 # x5 = 0x00000000    
      if (spy_gpr(5) /= 32x"00000000") then
         report "ERROR: andi  x5,  x0,   -2048 # x5 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x6,  x0,   -511  # x6 = 0x00000000    
      if (spy_gpr(6) /= 32x"00000000") then
         report "ERROR: andi  x6,  x0,   -511  # x6 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x7,  x0,   -2    # x7 = 0x00000000    
      if (spy_gpr(7) /= 32x"00000000") then
         report "ERROR: andi  x7,  x0,   -2    # x7 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x8,  x0,   0     # x8 = 0x00000000    
      if (spy_gpr(8) /= 32x"00000000") then
         report "ERROR: andi  x8,  x0,   0     # x8 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x9,  x0,   1     # x9 = 0x00000000    
      if (spy_gpr(9) /= 32x"00000000") then
         report "ERROR: andi  x9,  x0,   1     # x9 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x10, x0,   511   # x10 = 0x00000000    
      if (spy_gpr(0) /= 32x"00000000") then
         report "ERROR: andi  x10, x0,   511   # x10 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x11, x0,   2047  # x11 = 0x00000000    
      if (spy_gpr(1) /= 32x"00000000") then
         report "ERROR: andi  x11, x0,   2047  # x11 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x5,  x4,   -2048 # x5 = 0xfffff800    
      if (spy_gpr(5) /= 32x"fffff800") then
         report "ERROR: andi  x5,  x4,   -2048 # x5 = 0xfffff800 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x6,  x10,  -511  # x6 = 0x00000000    
      if (spy_gpr(6) /= 32x"00000000") then
         report "ERROR: andi  x6,  x10,  -511  # x6 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x7,  x28,  -2    # x7 = 0x000007fe    
      if (spy_gpr(7) /= 32x"000007fe") then
         report "ERROR: andi  x7,  x28,  -2    # x7 = 0x000007fe | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x8,  x27,  0     # x8 = 0x00000000    
      if (spy_gpr(8) /= 32x"00000000") then
         report "ERROR: andi  x8,  x27,  0     # x8 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x9,  x7,   1     # x9 = 0x00000000    
      if (spy_gpr(9) /= 32x"00000000") then
         report "ERROR: andi  x9,  x7,   1     # x9 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x10, x6,   511   # x10 = 0x00000000    
      if (spy_gpr(0) /= 32x"00000000") then
         report "ERROR: andi  x10, x6,   511   # x10 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x11, x5,   2047  # x11 = 0x00000000    
      if (spy_gpr(1) /= 32x"00000000") then
         report "ERROR: andi  x11, x5,   2047  # x11 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x11, x11,  2047  # x11 = 0x00000000    
      if (spy_gpr(1) /= 32x"00000000") then
         report "ERROR: andi  x11, x11,  2047  # x11 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x11, x11,  -2048 # x11 = 0x00000000    
      if (spy_gpr(1) /= 32x"00000000") then
         report "ERROR: andi  x11, x11,  -2048 # x11 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   SLLI   --
      --------------
      -- slli  x12, x0,   0     # x12 = 0x00000000    
      if (spy_gpr(2) /= 32x"00000000") then
         report "ERROR: slli  x12, x0,   0     # x12 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x13, x0,   1     # x13 = 0x00000000    
      if (spy_gpr(3) /= 32x"00000000") then
         report "ERROR: slli  x13, x0,   1     # x13 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x14, x0,   2     # x14 = 0x00000000    
      if (spy_gpr(4) /= 32x"00000000") then
         report "ERROR: slli  x14, x0,   2     # x14 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x15, x0,   10    # x15 = 0x00000000    
      if (spy_gpr(5) /= 32x"00000000") then
         report "ERROR: slli  x15, x0,   10    # x15 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x16, x0,   20    # x16 = 0x00000000    
      if (spy_gpr(6) /= 32x"00000000") then
         report "ERROR: slli  x16, x0,   20    # x16 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x17, x0,   31    # x17 = 0x00000000    
      if (spy_gpr(7) /= 32x"00000000") then
         report "ERROR: slli  x17, x0,   31    # x17 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x12, x27,  0     # x12 = 0xfffffe01    
      if (spy_gpr(2) /= 32x"fffffe01") then
         report "ERROR: slli  x12, x27,  0     # x12 = 0xfffffe01 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x13, x28,  1     # x13 = 0x00000ffe    
      if (spy_gpr(3) /= 32x"00000ffe") then
         report "ERROR: slli  x13, x28,  1     # x13 = 0x00000ffe | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x14, x21,  2     # x14 = 0x00000004    
      if (spy_gpr(4) /= 32x"00000004") then
         report "ERROR: slli  x14, x21,  2     # x14 = 0x00000004 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x15, x29,  10    # x15 = 0xfffffc00    
      if (spy_gpr(5) /= 32x"fffffc00") then
         report "ERROR: slli  x15, x29,  10    # x15 = 0xfffffc00 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x16, x5,   20    # x16 = 0x80000000    
      if (spy_gpr(6) /= 32x"80000000") then
         report "ERROR: slli  x16, x5,   20    # x16 = 0x80000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x17, x7,   31    # x17 = 0x00000000    
      if (spy_gpr(7) /= 32x"00000000") then
         report "ERROR: slli  x17, x7,   31    # x17 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x17, x17,  31    # x17 = 0x00000000    
      if (spy_gpr(7) /= 32x"00000000") then
         report "ERROR: slli  x17, x17,  31    # x17 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x17, x17,  0     # x17 = 0x00000000    
      if (spy_gpr(7) /= 32x"00000000") then
         report "ERROR: slli  x17, x17,  0     # x17 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   SRLI   --
      --------------
      -- srli  x18, x0,   0     # x18 = 0x00000000    
      if (spy_gpr(8) /= 32x"00000000") then
         report "ERROR: srli  x18, x0,   0     # x18 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x19, x0,   1     # x19 = 0x00000000    
      if (spy_gpr(9) /= 32x"00000000") then
         report "ERROR: srli  x19, x0,   1     # x19 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x20, x0,   2     # x20 = 0x00000000    
      if (spy_gpr(0) /= 32x"00000000") then
         report "ERROR: srli  x20, x0,   2     # x20 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x21, x0,   10    # x21 = 0x00000000    
      if (spy_gpr(1) /= 32x"00000000") then
         report "ERROR: srli  x21, x0,   10    # x21 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x22, x0,   20    # x22 = 0x00000000    
      if (spy_gpr(2) /= 32x"00000000") then
         report "ERROR: srli  x22, x0,   20    # x22 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x23, x0,   31    # x23 = 0x00000000    
      if (spy_gpr(3) /= 32x"00000000") then
         report "ERROR: srli  x23, x0,   31    # x23 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x18, x26,  0     # x18 = 0xfffffffe    
      if (spy_gpr(8) /= 32x"fffffffe") then
         report "ERROR: srli  x18, x26,  0     # x18 = 0xfffffffe | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x19, x27,  1     # x19 = 0x7fffff00    
      if (spy_gpr(9) /= 32x"7fffff00") then
         report "ERROR: srli  x19, x27,  1     # x19 = 0x7fffff00 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x20, x28,  2     # x20 = 0x000001ff    
      if (spy_gpr(0) /= 32x"000001ff") then
         report "ERROR: srli  x20, x28,  2     # x20 = 0x000001ff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x21, x29,  10    # x21 = 0x003fffff    
      if (spy_gpr(1) /= 32x"003fffff") then
         report "ERROR: srli  x21, x29,  10    # x21 = 0x003fffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x22, x30,  20    # x22 = 0x00000fff    
      if (spy_gpr(2) /= 32x"00000fff") then
         report "ERROR: srli  x22, x30,  20    # x22 = 0x00000fff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x23, x7,   31    # x23 = 0x00000000    
      if (spy_gpr(3) /= 32x"00000000") then
         report "ERROR: srli  x23, x7,   31    # x23 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x23, x23,  31    # x23 = 0x00000000    
      if (spy_gpr(3) /= 32x"00000000") then
         report "ERROR: srli  x23, x23,  31    # x23 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x23, x23,  0     # x23 = 0x00000000    
      if (spy_gpr(3) /= 32x"00000000") then
         report "ERROR: srli  x23, x23,  0     # x23 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   SRAI   --
      --------------
      -- srai  x24, x0,   0     # x24 = 0x00000000    
      if (spy_gpr(4) /= 32x"00000000") then
         report "ERROR: srai  x24, x0,   0     # x24 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x25, x0,   1     # x25 = 0x00000000    
      if (spy_gpr(5) /= 32x"00000000") then
         report "ERROR: srai  x25, x0,   1     # x25 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x26, x0,   2     # x26 = 0x00000000    
      if (spy_gpr(6) /= 32x"00000000") then
         report "ERROR: srai  x26, x0,   2     # x26 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x27, x0,   10    # x27 = 0x00000000    
      if (spy_gpr(7) /= 32x"00000000") then
         report "ERROR: srai  x27, x0,   10    # x27 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x28, x0,   20    # x28 = 0x00000000    
      if (spy_gpr(8) /= 32x"00000000") then
         report "ERROR: srai  x28, x0,   20    # x28 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x29, x0,   31    # x29 = 0x00000000    
      if (spy_gpr(9) /= 32x"00000000") then
         report "ERROR: srai  x29, x0,   31    # x29 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x24, x22,  0     # x24 = 0x00000fff    
      if (spy_gpr(4) /= 32x"00000fff") then
         report "ERROR: srai  x24, x22,  0     # x24 = 0x00000fff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x25, x21,  1     # x25 = 0x001fffff    
      if (spy_gpr(5) /= 32x"001fffff") then
         report "ERROR: srai  x25, x21,  1     # x25 = 0x001fffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x26, x20,  2     # x26 = 0x0000007f    
      if (spy_gpr(6) /= 32x"0000007f") then
         report "ERROR: srai  x26, x20,  2     # x26 = 0x0000007f | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x27, x19,  10    # x27 = 0x001fffff    
      if (spy_gpr(7) /= 32x"001fffff") then
         report "ERROR: srai  x27, x19,  10    # x27 = 0x001fffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x28, x18,  20    # x28 = 0xffffffff    
      if (spy_gpr(8) /= 32x"ffffffff") then
         report "ERROR: srai  x28, x18,  20    # x28 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x29, x16,  31    # x29 = 0xffffffff    
      if (spy_gpr(9) /= 32x"ffffffff") then
         report "ERROR: srai  x29, x16,  31    # x29 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x29, x29,  31    # x29 = 0xffffffff    
      if (spy_gpr(9) /= 32x"ffffffff") then
         report "ERROR: srai  x29, x29,  31    # x29 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x29, x29,  0     # x29 = 0xffffffff    
      if (spy_gpr(9) /= 32x"ffffffff") then
         report "ERROR: srai  x29, x29,  0     # x29 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      ----------------------------------------------------------------
      --                                                            --
      --      ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND      --
      --                                                            --
      ----------------------------------------------------------------
      --------------
      --   ADD    --
      --------------
          
      
      ----------------------------------------------------------------
      --                                                            --
      --                         LUI, AUIPC                         --
      --                                                            --
      ----------------------------------------------------------------    
  
      
      
      ----------------------------------------------------------------
      --                                                            --
      --              BEQ, BNE, BLT, BGE, BLTU, BGEU                --
      --                                                            --
      ----------------------------------------------------------------

      
      
      ----------------------------------------------------------------
      --                                                            --
      --                         JAL, JALR                          --
      --                                                            --
      ----------------------------------------------------------------

      
      
      ----------------------------------------------------------------
      --                                                            --
      --                         SB, SH, SW                         --
      --                                                            --
      ----------------------------------------------------------------

      
      
      ----------------------------------------------------------------
      --                                                            --
      --                         LB, LH, LW                         --
      --                                                            --
      ----------------------------------------------------------------


      
      ----------------------------------------------------------------
      --                                                            --
      --                            GPIO                            --
      --                                                            --
      ----------------------------------------------------------------


      
      ----------------------------------------------------------------
      --                                                            --
      -- Special instructions, behavior check in case of invalid    -- 
      -- opcode etc.                                                --
      --                                                            --
      ----------------------------------------------------------------
      
      wait for 100 ns;
      stop(2);
   end process p_tb;

end architecture tb;
