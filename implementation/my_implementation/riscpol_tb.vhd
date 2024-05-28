--------------------------------------------------------------------------------
-- File          : riscpol_tb.vhd
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : Test for the entire processor (riscpol entity in
-- riscpol_design).
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
   use std.env.all;
library riscpol_lib;
   use riscpol_lib.all;
   use riscpol_lib.riscpol_pkg.all;

entity riscpol_tb is
end riscpol_tb;

architecture tb of riscpol_tb is


   component riscpol is
   port (
      i_rst       : in std_logic;
      i_clk       : in std_logic;
      o_gpio      : out std_logic_vector(7 downto 0)
   );
   end component riscpol;

   signal rst_tb  : std_logic;
   signal clk_tb  : std_logic;
   signal gpio_tb : std_logic_vector(7 downto 0);
   type t_gpr  is array(0 to 31) of std_logic_vector(31 downto 0);
   signal set_test_point : integer := 0;
   type word_t is array (0 to 3) of std_logic_vector(7 downto 0);
   type ram_t is array (0 to C_RAM_LENGTH - 1) of word_t;

begin

   inst_riscpol : component riscpol
   port map (
      i_rst       => rst_tb,
      i_clk       => clk_tb,
      o_gpio      => gpio_tb
   );

   p_clk : process
   begin
      clk_tb   <= '1';
      wait for C_CLK_PERIOD/2;
      clk_tb   <= '0';
      wait for C_CLK_PERIOD/2;
   end process;

   p_tb : process
      alias spy_gpr is <<signal .riscpol_tb.inst_riscpol.inst_core.inst_reg_file.gpr: t_gpr >>;
      alias spy_ram is <<signal .riscpol_tb.inst_riscpol.inst_memory.ram: ram_t >>;
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
      --    ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI    --
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
      if (spy_gpr(10) /= 32x"00000000") then
         report "ERROR: slti  x10, x0,   -2    # x10 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x11, x0,   0     # x11 = 0x00000000
      if (spy_gpr(11) /= 32x"00000000") then
         report "ERROR: slti  x11, x0,   0     # x11 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x12, x0,   1     # x12 = 0x00000001
      if (spy_gpr(12) /= 32x"00000001") then
         report "ERROR: slti  x12, x0,   1     # x12 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x13, x0,   511   # x13 = 0x00000001
      if (spy_gpr(13) /= 32x"00000001") then
         report "ERROR: slti  x13, x0,   511   # x13 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x14, x0,   2047  # x14 = 0x00000001
      if (spy_gpr(14) /= 32x"00000001") then
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
      if (spy_gpr(10) /= 32x"00000000") then
         report "ERROR: slti  x10, x12,  -2    # x10 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x11, x11,  0     # x11 = 0x00000000
      if (spy_gpr(11) /= 32x"00000000") then
         report "ERROR: slti  x11, x11,  0     # x11 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x12, x10,  1     # x12 = 0x00000001
      if (spy_gpr(12) /= 32x"00000001") then
         report "ERROR: slti  x12, x10,  1     # x12 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x13, x6,   511   # x13 = 0x00000000
      if (spy_gpr(13) /= 32x"00000000") then
         report "ERROR: slti  x13, x6,   511   # x13 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x14, x9,   2047  # x14 = 0x00000001
      if (spy_gpr(14) /= 32x"00000001") then
         report "ERROR: slti  x14, x9,   2047  # x14 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x14, x14,  2047  # x14 = 0x00000001
      if (spy_gpr(14) /= 32x"00000001") then
         report "ERROR: slti  x14, x14,  2047  # x14 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x14, x14,  -2048 # x14 = 0x00000000
      if (spy_gpr(14) /= 32x"00000000") then
         report "ERROR: slti  x14, x14,  -2048 # x14 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   SLTIU  --
      --------------
      -- sltiu x15, x0,   -2048 # x15 = 0x00000001
      if (spy_gpr(15) /= 32x"00000001") then
         report "ERROR: sltiu x15, x0,   -2048 # x15 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x16, x0,   -511  # x16 = 0x00000001
      if (spy_gpr(16) /= 32x"00000001") then
         report "ERROR: sltiu x16, x0,   -511  # x16 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x17, x0,   -2    # x17 = 0x00000001
      if (spy_gpr(17) /= 32x"00000001") then
         report "ERROR: sltiu x17, x0,   -2    # x17 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x18, x0,   0     # x18 = 0x00000000
      if (spy_gpr(18) /= 32x"00000000") then
         report "ERROR: sltiu x18, x0,   0     # x18 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x19, x0,   1     # x19 = 0x00000001
      if (spy_gpr(19) /= 32x"00000001") then
         report "ERROR: sltiu x19, x0,   1     # x19 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x20, x0,   511   # x20 = 0x00000001
      if (spy_gpr(20) /= 32x"00000001") then
         report "ERROR: sltiu x20, x0,   511   # x20 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x21, x0,   2047  # x21 = 0x00000001
      if (spy_gpr(21) /= 32x"00000001") then
         report "ERROR: sltiu x21, x0,   2047  # x21 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x15, x7,   -2048 # x15 = 0x00000001
      if (spy_gpr(15) /= 32x"00000001") then
         report "ERROR: sltiu x15, x7,   -2048 # x15 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x16, x1,   -511  # x16 = 0x00000000
      if (spy_gpr(16) /= 32x"00000000") then
         report "ERROR: sltiu x16, x1,   -511  # x16 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x17, x19,  -2    # x17 = 0x00000001
      if (spy_gpr(17) /= 32x"00000001") then
         report "ERROR: sltiu x17, x19,  -2    # x17 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x18, x18,  0     # x18 = 0x00000000
      if (spy_gpr(18) /= 32x"00000000") then
         report "ERROR: sltiu x18, x18,  0     # x18 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x19, x17,  1     # x19 = 0x00000000
      if (spy_gpr(19) /= 32x"00000000") then
         report "ERROR: sltiu x19, x17,  1     # x19 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x20, x6,   511   # x20 = 0x00000000
      if (spy_gpr(20) /= 32x"00000000") then
         report "ERROR: sltiu x20, x6,   511   # x20 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x21, x15,  2047  # x21 = 0x00000001
      if (spy_gpr(21) /= 32x"00000001") then
         report "ERROR: sltiu x21, x15,  2047  # x21 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x21, x21,  2047  # x21 = 0x00000001
      if (spy_gpr(21) /= 32x"00000001") then
         report "ERROR: sltiu x21, x21,  2047  # x21 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x21, x21,  -2048 # x21 = 0x00000001
      if (spy_gpr(21) /= 32x"00000001") then
         report "ERROR: sltiu x21, x21,  -2048 # x21 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   XORI   --
      --------------
      -- xori  x22, x0,   -2048 # x22 = 0xfffff800
      if (spy_gpr(22) /= 32x"fffff800") then
         report "ERROR: xori  x22, x0,   -2048 # x22 = 0xfffff800 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x23, x0,   -511  # x23 = 0xfffffe01
      if (spy_gpr(23) /= 32x"fffffe01") then
         report "ERROR: xori  x23, x0,   -511  # x23 = 0xfffffe01 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x24, x0,   -2    # x24 = 0xfffffffe
      if (spy_gpr(24) /= 32x"fffffffe") then
         report "ERROR: xori  x24, x0,   -2    # x24 = 0xfffffffe | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x25, x0,   0     # x25 = 0x00000000
      if (spy_gpr(25) /= 32x"00000000") then
         report "ERROR: xori  x25, x0,   0     # x25 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x26, x0,   1     # x26 = 0x00000001
      if (spy_gpr(26) /= 32x"00000001") then
         report "ERROR: xori  x26, x0,   1     # x26 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x27, x0,   511   # x27 = 0x000001ff
      if (spy_gpr(27) /= 32x"000001ff") then
         report "ERROR: xori  x27, x0,   511   # x27 = 0x000001ff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x28, x0,   2047  # x28 = 0x000007ff
      if (spy_gpr(28) /= 32x"000007ff") then
         report "ERROR: xori  x28, x0,   2047  # x28 = 0x000007ff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x22, x28,  -2048 # x22 = 0xffffffff
      if (spy_gpr(22) /= 32x"ffffffff") then
         report "ERROR: xori  x22, x28,  -2048 # x22 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x23, x27,  -511  # x23 = 0xfffffffe
      if (spy_gpr(23) /= 32x"fffffffe") then
         report "ERROR: xori  x23, x27,  -511  # x23 = 0xfffffffe | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x24, x26,  -2    # x24 = 0xffffffff
      if (spy_gpr(24) /= 32x"ffffffff") then
         report "ERROR: xori  x24, x26,  -2    # x24 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x25, x25,  0     # x25 = 0x00000000
      if (spy_gpr(25) /= 32x"00000000") then
         report "ERROR: xori  x25, x25,  0     # x25 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x26, x24,  1     # x26 = 0xfffffffe
      if (spy_gpr(26) /= 32x"fffffffe") then
         report "ERROR: xori  x26, x24,  1     # x26 = 0xfffffffe | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x27, x23,  511   # x27 = 0xfffffe01
      if (spy_gpr(27) /= 32x"fffffe01") then
         report "ERROR: xori  x27, x23,  511   # x27 = 0xfffffe01 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x28, x22,  2047  # x28 = 0xfffff800
      if (spy_gpr(28) /= 32x"fffff800") then
         report "ERROR: xori  x28, x22,  2047  # x28 = 0xfffff800 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x28, x28,  2047  # x28 = 0xffffffff
      if (spy_gpr(28) /= 32x"ffffffff") then
         report "ERROR: xori  x28, x28,  2047  # x28 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x28, x28,  -2048 # x28 = 0x000007ff
      if (spy_gpr(28) /= 32x"000007ff") then
         report "ERROR: xori  x28, x28,  -2048 # x28 = 0x000007ff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   ORI    --
      --------------
      -- ori   x29, x0,   -2048 # x29 = 0xfffff800
      if (spy_gpr(29) /= 32x"fffff800") then
         report "ERROR: ori   x29, x0,   -2048 # x29 = 0xfffff800 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x30, x0,   -511  # x30 = 0xfffffe01
      if (spy_gpr(30) /= 32x"fffffe01") then
         report "ERROR: ori   x30, x0,   -511  # x30 = 0xfffffe01 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x31, x0,   -2    # x31 = 0xfffffffe
      if (spy_gpr(31) /= 32x"fffffffe") then
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
      if (spy_gpr(29) /= 32x"ffffffff") then
         report "ERROR: ori   x29, x4,   -2048 # x29 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x30, x3,   -511  # x30 = 0xffffffff
      if (spy_gpr(30) /= 32x"ffffffff") then
         report "ERROR: ori   x30, x3,   -511  # x30 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x31, x2,   -2    # x31 = 0xffffffff
      if (spy_gpr(31) /= 32x"ffffffff") then
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
      if (spy_gpr(10) /= 32x"00000000") then
         report "ERROR: andi  x10, x0,   511   # x10 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x11, x0,   2047  # x11 = 0x00000000
      if (spy_gpr(11) /= 32x"00000000") then
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
      if (spy_gpr(10) /= 32x"00000000") then
         report "ERROR: andi  x10, x6,   511   # x10 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x11, x5,   2047  # x11 = 0x00000000
      if (spy_gpr(11) /= 32x"00000000") then
         report "ERROR: andi  x11, x5,   2047  # x11 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x11, x11,  2047  # x11 = 0x00000000
      if (spy_gpr(11) /= 32x"00000000") then
         report "ERROR: andi  x11, x11,  2047  # x11 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x11, x11,  -2048 # x11 = 0x00000000
      if (spy_gpr(11) /= 32x"00000000") then
         report "ERROR: andi  x11, x11,  -2048 # x11 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   SLLI   --
      --------------
      -- slli  x12, x0,   0     # x12 = 0x00000000
      if (spy_gpr(12) /= 32x"00000000") then
         report "ERROR: slli  x12, x0,   0     # x12 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x13, x0,   1     # x13 = 0x00000000
      if (spy_gpr(13) /= 32x"00000000") then
         report "ERROR: slli  x13, x0,   1     # x13 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x14, x0,   2     # x14 = 0x00000000
      if (spy_gpr(14) /= 32x"00000000") then
         report "ERROR: slli  x14, x0,   2     # x14 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x15, x0,   10    # x15 = 0x00000000
      if (spy_gpr(15) /= 32x"00000000") then
         report "ERROR: slli  x15, x0,   10    # x15 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x16, x0,   20    # x16 = 0x00000000
      if (spy_gpr(16) /= 32x"00000000") then
         report "ERROR: slli  x16, x0,   20    # x16 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x17, x0,   31    # x17 = 0x00000000
      if (spy_gpr(17) /= 32x"00000000") then
         report "ERROR: slli  x17, x0,   31    # x17 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x12, x27,  0     # x12 = 0xfffffe01
      if (spy_gpr(12) /= 32x"fffffe01") then
         report "ERROR: slli  x12, x27,  0     # x12 = 0xfffffe01 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x13, x28,  1     # x13 = 0x00000ffe
      if (spy_gpr(13) /= 32x"00000ffe") then
         report "ERROR: slli  x13, x28,  1     # x13 = 0x00000ffe | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x14, x21,  2     # x14 = 0x00000004
      if (spy_gpr(14) /= 32x"00000004") then
         report "ERROR: slli  x14, x21,  2     # x14 = 0x00000004 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x15, x29,  10    # x15 = 0xfffffc00
      if (spy_gpr(15) /= 32x"fffffc00") then
         report "ERROR: slli  x15, x29,  10    # x15 = 0xfffffc00 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x16, x5,   20    # x16 = 0x80000000
      if (spy_gpr(16) /= 32x"80000000") then
         report "ERROR: slli  x16, x5,   20    # x16 = 0x80000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x17, x7,   31    # x17 = 0x00000000
      if (spy_gpr(17) /= 32x"00000000") then
         report "ERROR: slli  x17, x7,   31    # x17 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x17, x17,  31    # x17 = 0x00000000
      if (spy_gpr(17) /= 32x"00000000") then
         report "ERROR: slli  x17, x17,  31    # x17 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x17, x17,  0     # x17 = 0x00000000
      if (spy_gpr(17) /= 32x"00000000") then
         report "ERROR: slli  x17, x17,  0     # x17 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   SRLI   --
      --------------
      -- srli  x18, x0,   0     # x18 = 0x00000000
      if (spy_gpr(18) /= 32x"00000000") then
         report "ERROR: srli  x18, x0,   0     # x18 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x19, x0,   1     # x19 = 0x00000000
      if (spy_gpr(19) /= 32x"00000000") then
         report "ERROR: srli  x19, x0,   1     # x19 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x20, x0,   2     # x20 = 0x00000000
      if (spy_gpr(20) /= 32x"00000000") then
         report "ERROR: srli  x20, x0,   2     # x20 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x21, x0,   10    # x21 = 0x00000000
      if (spy_gpr(21) /= 32x"00000000") then
         report "ERROR: srli  x21, x0,   10    # x21 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x22, x0,   20    # x22 = 0x00000000
      if (spy_gpr(22) /= 32x"00000000") then
         report "ERROR: srli  x22, x0,   20    # x22 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x23, x0,   31    # x23 = 0x00000000
      if (spy_gpr(23) /= 32x"00000000") then
         report "ERROR: srli  x23, x0,   31    # x23 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x18, x26,  0     # x18 = 0xfffffffe
      if (spy_gpr(18) /= 32x"fffffffe") then
         report "ERROR: srli  x18, x26,  0     # x18 = 0xfffffffe | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x19, x27,  1     # x19 = 0x7fffff00
      if (spy_gpr(19) /= 32x"7fffff00") then
         report "ERROR: srli  x19, x27,  1     # x19 = 0x7fffff00 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x20, x28,  2     # x20 = 0x000001ff
      if (spy_gpr(20) /= 32x"000001ff") then
         report "ERROR: srli  x20, x28,  2     # x20 = 0x000001ff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x21, x29,  10    # x21 = 0x003fffff
      if (spy_gpr(21) /= 32x"003fffff") then
         report "ERROR: srli  x21, x29,  10    # x21 = 0x003fffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x22, x30,  20    # x22 = 0x00000fff
      if (spy_gpr(22) /= 32x"00000fff") then
         report "ERROR: srli  x22, x30,  20    # x22 = 0x00000fff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x23, x7,   31    # x23 = 0x00000000
      if (spy_gpr(23) /= 32x"00000000") then
         report "ERROR: srli  x23, x7,   31    # x23 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x23, x23,  31    # x23 = 0x00000000
      if (spy_gpr(23) /= 32x"00000000") then
         report "ERROR: srli  x23, x23,  31    # x23 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x23, x23,  0     # x23 = 0x00000000
      if (spy_gpr(23) /= 32x"00000000") then
         report "ERROR: srli  x23, x23,  0     # x23 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   SRAI   --
      --------------
      -- srai  x24, x0,   0     # x24 = 0x00000000
      if (spy_gpr(24) /= 32x"00000000") then
         report "ERROR: srai  x24, x0,   0     # x24 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x25, x0,   1     # x25 = 0x00000000
      if (spy_gpr(25) /= 32x"00000000") then
         report "ERROR: srai  x25, x0,   1     # x25 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x26, x0,   2     # x26 = 0x00000000
      if (spy_gpr(26) /= 32x"00000000") then
         report "ERROR: srai  x26, x0,   2     # x26 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x27, x0,   10    # x27 = 0x00000000
      if (spy_gpr(27) /= 32x"00000000") then
         report "ERROR: srai  x27, x0,   10    # x27 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x28, x0,   20    # x28 = 0x00000000
      if (spy_gpr(28) /= 32x"00000000") then
         report "ERROR: srai  x28, x0,   20    # x28 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x29, x0,   31    # x29 = 0x00000000
      if (spy_gpr(29) /= 32x"00000000") then
         report "ERROR: srai  x29, x0,   31    # x29 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x24, x22,  0     # x24 = 0x00000fff
      if (spy_gpr(24) /= 32x"00000fff") then
         report "ERROR: srai  x24, x22,  0     # x24 = 0x00000fff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x25, x21,  1     # x25 = 0x001fffff
      if (spy_gpr(25) /= 32x"001fffff") then
         report "ERROR: srai  x25, x21,  1     # x25 = 0x001fffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x26, x20,  2     # x26 = 0x0000007f
      if (spy_gpr(26) /= 32x"0000007f") then
         report "ERROR: srai  x26, x20,  2     # x26 = 0x0000007f | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x27, x19,  10    # x27 = 0x001fffff
      if (spy_gpr(27) /= 32x"001fffff") then
         report "ERROR: srai  x27, x19,  10    # x27 = 0x001fffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x28, x18,  20    # x28 = 0xffffffff
      if (spy_gpr(28) /= 32x"ffffffff") then
         report "ERROR: srai  x28, x18,  20    # x28 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x29, x16,  31    # x29 = 0xffffffff
      if (spy_gpr(29) /= 32x"ffffffff") then
         report "ERROR: srai  x29, x16,  31    # x29 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x29, x29,  31    # x29 = 0xffffffff
      if (spy_gpr(29) /= 32x"ffffffff") then
         report "ERROR: srai  x29, x29,  31    # x29 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x29, x29,  0     # x29 = 0xffffffff
      if (spy_gpr(29) /= 32x"ffffffff") then
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
      -- add   x30, x0,   x28   # x30 = 0xffffffff
      if (spy_gpr(30) /= 32x"ffffffff") then
         report "ERROR: add   x30, x0,   x28   # x30 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- add   x31, x0,   x27   # x31 = 0x001fffff
      if (spy_gpr(31) /= 32x"001fffff") then
         report "ERROR: add   x31, x0,   x27   # x31 = 0x001fffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- add   x1,  x0,   x26   # x1 = 0x0000007f
      if (spy_gpr(1) /= 32x"0000007f") then
         report "ERROR: add   x1,  x0,   x26   # x1 = 0x0000007f | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- add   x2,  x0,   x25   # x2 = 0x001fffff
      if (spy_gpr(2) /= 32x"001fffff") then
         report "ERROR: add   x2,  x0,   x25   # x2 = 0x001fffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- add   x3,  x0,   x24   # x3 = 0x00000fff
      if (spy_gpr(3) /= 32x"00000fff") then
         report "ERROR: add   x3,  x0,   x24   # x3 = 0x00000fff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- add   x4,  x0,   x16   # x4 = 0x80000000
      if (spy_gpr(4) /= 32x"80000000") then
         report "ERROR: add   x4,  x0,   x16   # x4 = 0x80000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- add   x5,  x0,   x0    # x5 = 0x00000000
      if (spy_gpr(5) /= 32x"00000000") then
         report "ERROR: add   x5,  x0,   x0    # x5 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- add   x30, x5,   x30   # x30 = 0xffffffff
      if (spy_gpr(30) /= 32x"ffffffff") then
         report "ERROR: add   x30, x5,   x30   # x30 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- add   x31, x30,  x5    # x31 = 0xffffffff
      if (spy_gpr(31) /= 32x"ffffffff") then
         report "ERROR: add   x31, x30,  x5    # x31 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- add   x1,  x3,   x27   # x1 = 0x00200ffe
      if (spy_gpr(1) /= 32x"00200ffe") then
         report "ERROR: add   x1,  x3,   x27   # x1 = 0x00200ffe | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- add   x2,  x2,   x28   # x2 = 0x001ffffe
      if (spy_gpr(2) /= 32x"001ffffe") then
         report "ERROR: add   x2,  x2,   x28   # x2 = 0x001ffffe | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- add   x3,  x1,   x29   # x3 = 0x00200ffd
      if (spy_gpr(3) /= 32x"00200ffd") then
         report "ERROR: add   x3,  x1,   x29   # x3 = 0x00200ffd | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- add   x4,  x31,  x26   # x4 = 0x0000007e
      if (spy_gpr(4) /= 32x"0000007e") then
         report "ERROR: add   x4,  x31,  x26   # x4 = 0x0000007e | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- add   x5,  x30,  x25   # x5 = 0x001ffffe
      if (spy_gpr(5) /= 32x"001ffffe") then
         report "ERROR: add   x5,  x30,  x25   # x5 = 0x001ffffe | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- add   x5,  x5,   x5    # x5 = 0x003ffffc
      if (spy_gpr(5) /= 32x"003ffffc") then
         report "ERROR: add   x5,  x5,   x5    # x5 = 0x003ffffc | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- add   x5,  x5,   x5    # x5 = 0x007ffff8
      if (spy_gpr(5) /= 32x"007ffff8") then
         report "ERROR: add   x5,  x5,   x5    # x5 = 0x007ffff8 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   SUB    --
      --------------
      -- sub   x6,  x0,   x28   # x30 = 0x00000001
      if (spy_gpr(6) /= 32x"00000001") then
         report "ERROR: sub   x6,  x0,   x28   # x30 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sub   x7,  x0,   x27   # x31 = 0xffe00001
      if (spy_gpr(7) /= 32x"ffe00001") then
         report "ERROR: sub   x7,  x0,   x27   # x31 = 0xffe00001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sub   x8,  x0,   x26   # x1 = 0xffffff81
      if (spy_gpr(8) /= 32x"ffffff81") then
         report "ERROR: sub   x8,  x0,   x26   # x1 = 0xffffff81 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sub   x9,  x0,   x25   # x2 = 0xffe00001
      if (spy_gpr(9) /= 32x"ffe00001") then
         report "ERROR: sub   x9,  x0,   x25   # x2 = 0xffe00001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sub   x10, x0,   x24   # x3 = 0xfffff001
      if (spy_gpr(10) /= 32x"fffff001") then
         report "ERROR: sub   x10, x0,   x24   # x3 = 0xfffff001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sub   x11, x0,   x16   # x4 = 0x80000000
      if (spy_gpr(11) /= 32x"80000000") then
         report "ERROR: sub   x11, x0,   x16   # x4 = 0x80000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sub   x12, x0,   x0    # x5 = 0x00000000
      if (spy_gpr(12) /= 32x"00000000") then
         report "ERROR: sub   x12, x0,   x0    # x5 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sub   x6,  x15,  x6    # x6 = 0xfffffbff
      if (spy_gpr(6) /= 32x"fffffbff") then
         report "ERROR: sub   x6,  x15,  x6    # x6 = 0xfffffbff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sub   x7,  x16,  x5    # x7 = 0x7f800008
      if (spy_gpr(7) /= 32x"7f800008") then
         report "ERROR: sub   x7,  x16,  x5    # x7 = 0x7f800008 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sub   x8,  x13,  x28   # x8 = 0x00000fff
      if (spy_gpr(8) /= 32x"00000fff") then
         report "ERROR: sub   x8,  x13,  x28   # x8 = 0x00000fff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sub   x9,  x12,  x27   # x9 = 0xffe00001
      if (spy_gpr(9) /= 32x"ffe00001") then
         report "ERROR: sub   x9,  x12,  x27   # x9 = 0xffe00001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sub   x10, x10,  x26   # x10 = 0xffffef82
      if (spy_gpr(10) /= 32x"ffffef82") then
         report "ERROR: sub   x10, x10,  x26   # x10 = 0xffffef82 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sub   x11, x31,  x25   # x11 = 0xffe00000
      if (spy_gpr(11) /= 32x"ffe00000") then
         report "ERROR: sub   x11, x31,  x25   # x11 = 0xffe00000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sub   x12, x30,  x24   # x12 = 0xfffff000
      if (spy_gpr(12) /= 32x"fffff000") then
         report "ERROR: sub   x12, x30,  x24   # x12 = 0xfffff000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sub   x12, x12,  x12   # x12 = 0x00000000
      if (spy_gpr(12) /= 32x"00000000") then
         report "ERROR: sub   x12, x12,  x12   # x12 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sub   x12, x12,  x12   # x12 = 0x00000000
      if (spy_gpr(12) /= 32x"00000000") then
         report "ERROR: sub   x12, x12,  x12   # x12 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   SLL    --
      --------------
      -- sll   x13, x28,  x0    # x13 = 0xffffffff
      if (spy_gpr(13) /= 32x"ffffffff") then
         report "ERROR: sll   x13, x28,  x0    # x13 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sll   x14, x27,  x0    # x14 = 0x001fffff
      if (spy_gpr(14) /= 32x"001fffff") then
         report "ERROR: sll   x14, x27,  x0    # x14 = 0x001fffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sll   x15, x26,  x0    # x15 = 0x0000007f
      if (spy_gpr(15) /= 32x"0000007f") then
         report "ERROR: sll   x15, x26,  x0    # x15 = 0x0000007f | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sll   x16, x25,  x0    # x16 = 0x001fffff
      if (spy_gpr(16) /= 32x"001fffff") then
         report "ERROR: sll   x16, x25,  x0    # x16 = 0x001fffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sll   x17, x24,  x0    # x17 = 0x00000fff
      if (spy_gpr(17) /= 32x"00000fff") then
         report "ERROR: sll   x17, x24,  x0    # x17 = 0x00000fff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sll   x18, x16,  x0    # x18 = 0x001fffff
      if (spy_gpr(18) /= 32x"001fffff") then
         report "ERROR: sll   x18, x16,  x0    # x18 = 0x001fffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sll   x19, x0,   x0    # x19 = 0x00000000
      if (spy_gpr(19) /= 32x"00000000") then
         report "ERROR: sll   x19, x0,   x0    # x19 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sll   x13, x15,  x6    # x13 = 0x80000000
      if (spy_gpr(13) /= 32x"80000000") then
         report "ERROR: sll   x13, x15,  x6    # x13 = 0x80000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sll   x14, x16,  x5    # x14 = 0xff000000
      if (spy_gpr(14) /= 32x"ff000000") then
         report "ERROR: sll   x14, x16,  x5    # x14 = 0xff000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sll   x15, x13,  x28   # x15 = 0x00000000
      if (spy_gpr(15) /= 32x"00000000") then
         report "ERROR: sll   x15, x13,  x28   # x15 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sll   x16, x12,  x27   # x16 = 0x00000000
      if (spy_gpr(16) /= 32x"00000000") then
         report "ERROR: sll   x16, x12,  x27   # x16 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sll   x17, x10,  x26   # x17 = 0x00000000
      if (spy_gpr(17) /= 32x"00000000") then
         report "ERROR: sll   x17, x10,  x26   # x17 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sll   x18, x31,  x25   # x18 = 0x80000000
      if (spy_gpr(18) /= 32x"80000000") then
         report "ERROR: sll   x18, x31,  x25   # x18 = 0x80000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sll   x19, x30,  x24   # x19 = 0x80000000
      if (spy_gpr(19) /= 32x"80000000") then
         report "ERROR: sll   x19, x30,  x24   # x19 = 0x80000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sll   x19, x19,  x19   # x19 = 0x80000000
      if (spy_gpr(19) /= 32x"80000000") then
         report "ERROR: sll   x19, x19,  x19   # x19 = 0x80000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sll   x19, x19,  x19   # x19 = 0x80000000
      if (spy_gpr(19) /= 32x"80000000") then
         report "ERROR: sll   x19, x19,  x19   # x19 = 0x80000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   SLT    --
      --------------
      -- slt   x20, x28,  x0    # x20 = 0x00000001
      if (spy_gpr(20) /= 32x"00000001") then
         report "ERROR: slt   x20, x28,  x0    # x20 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slt   x21, x27,  x0    # x21 = 0x00000000
      if (spy_gpr(21) /= 32x"00000000") then
         report "ERROR: slt   x21, x27,  x0    # x21 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slt   x22, x26,  x0    # x22 = 0x00000000
      if (spy_gpr(22) /= 32x"00000000") then
         report "ERROR: slt   x22, x26,  x0    # x22 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slt   x23, x25,  x0    # x23 = 0x00000000
      if (spy_gpr(23) /= 32x"00000000") then
         report "ERROR: slt   x23, x25,  x0    # x23 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slt   x24, x24,  x0    # x24 = 0x00000000
      if (spy_gpr(24) /= 32x"00000000") then
         report "ERROR: slt   x24, x24,  x0    # x24 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slt   x25, x16,  x0    # x25 = 0x00000000
      if (spy_gpr(25) /= 32x"00000000") then
         report "ERROR: slt   x25, x16,  x0    # x25 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slt   x26, x0,   x0    # x26 = 0x00000000
      if (spy_gpr(26) /= 32x"00000000") then
         report "ERROR: slt   x26, x0,   x0    # x26 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slt   x20, x15,  x6    # x20 = 0x00000000
      if (spy_gpr(20) /= 32x"00000000") then
         report "ERROR: slt   x20, x15,  x6    # x20 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slt   x21, x16,  x5    # x21 = 0x00000001
      if (spy_gpr(21) /= 32x"00000001") then
         report "ERROR: slt   x21, x16,  x5    # x21 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slt   x22, x13,  x28   # x22 = 0x00000001
      if (spy_gpr(22) /= 32x"00000001") then
         report "ERROR: slt   x22, x13,  x28   # x22 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slt   x23, x12,  x27   # x23 = 0x00000001
      if (spy_gpr(23) /= 32x"00000001") then
         report "ERROR: slt   x23, x12,  x27   # x23 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slt   x24, x10,  x26   # x24 = 0x00000001
      if (spy_gpr(24) /= 32x"00000001") then
         report "ERROR: slt   x24, x10,  x26   # x24 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slt   x25, x31,  x25   # x25 = 0x00000001
      if (spy_gpr(25) /= 32x"00000001") then
         report "ERROR: slt   x25, x31,  x25   # x25 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slt   x26, x30,  x24   # x26 = 0x00000001
      if (spy_gpr(26) /= 32x"00000001") then
         report "ERROR: slt   x26, x30,  x24   # x26 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slt   x20, x20,  x20   # x20 = 0x00000000
      if (spy_gpr(20) /= 32x"00000000") then
         report "ERROR: slt   x20, x20,  x20   # x20 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- slt   x20, x20,  x20   # x20 = 0x00000000
      if (spy_gpr(20) /= 32x"00000000") then
         report "ERROR: slt   x20, x20,  x20   # x20 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   SLTU   --
      --------------
      -- sltu  x27, x1,   x0    # x27 = 0x00000000
      if (spy_gpr(27) /= 32x"00000000") then
         report "ERROR: sltu  x27, x1,   x0    # x27 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltu  x28, x2,   x0    # x28 = 0x00000000
      if (spy_gpr(28) /= 32x"00000000") then
         report "ERROR: sltu  x28, x2,   x0    # x28 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltu  x29, x3,   x0    # x29 = 0x00000000
      if (spy_gpr(29) /= 32x"00000000") then
         report "ERROR: sltu  x29, x3,   x0    # x29 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltu  x30, x4,   x0    # x30 = 0x00000000
      if (spy_gpr(30) /= 32x"00000000") then
         report "ERROR: sltu  x30, x4,   x0    # x30 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltu  x31, x5,   x0    # x31 = 0x00000000
      if (spy_gpr(31) /= 32x"00000000") then
         report "ERROR: sltu  x31, x5,   x0    # x31 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltu  x1,  x6,   x0    # x1 = 0x00000000
      if (spy_gpr(1) /= 32x"00000000") then
         report "ERROR: sltu  x1,  x6,   x0    # x1 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltu  x2,  x0,   x0    # x2 = 0x00000000
      if (spy_gpr(2) /= 32x"00000000") then
         report "ERROR: sltu  x2,  x0,   x0    # x2 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltu  x27, x1,   x6    # x27 = 0x00000001
      if (spy_gpr(27) /= 32x"00000001") then
         report "ERROR: sltu  x27, x1,   x6    # x27 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltu  x28, x2,   x5    # x28 = 0x00000001
      if (spy_gpr(28) /= 32x"00000001") then
         report "ERROR: sltu  x28, x2,   x5    # x28 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltu  x29, x3,   x28   # x29 = 0x00000000
      if (spy_gpr(29) /= 32x"00000000") then
         report "ERROR: sltu  x29, x3,   x28   # x29 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltu  x30, x4,   x27   # x30 = 0x00000000
      if (spy_gpr(30) /= 32x"00000000") then
         report "ERROR: sltu  x30, x4,   x27   # x30 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltu  x31, x5,   x26   # x31 = 0x00000000
      if (spy_gpr(31) /= 32x"00000000") then
         report "ERROR: sltu  x31, x5,   x26   # x31 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltu  x1,  x6,   x25   # x1 = 0x00000000
      if (spy_gpr(1) /= 32x"00000000") then
         report "ERROR: sltu  x1,  x6,   x25   # x1 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltu  x2,  x7,   x24   # x2 = 0x00000000
      if (spy_gpr(2) /= 32x"00000000") then
         report "ERROR: sltu  x2,  x7,   x24   # x2 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltu  x2,  x2,   x2    # x2 = 0x00000000
      if (spy_gpr(2) /= 32x"00000000") then
         report "ERROR: sltu  x2,  x2,   x2    # x2 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sltu  x2,  x2,   x2    # x2 = 0x00000000
      if (spy_gpr(2) /= 32x"00000000") then
         report "ERROR: sltu  x2,  x2,   x2    # x2 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   XOR    --
      --------------
      -- xor   x3,  x10,  x11   # x3 = 0x001fef82
      if (spy_gpr(3) /= 32x"001fef82") then
         report "ERROR: xor   x3,  x10,  x11   # x3 = 0x001fef82 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xor   x4,  x11,  x10   # x4 = 0x001fef82
      if (spy_gpr(4) /= 32x"001fef82") then
         report "ERROR: xor   x4,  x11,  x10   # x4 = 0x001fef82 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xor   x5,  x14,  x8    # x5 = 0xff000fff
      if (spy_gpr(5) /= 32x"ff000fff") then
         report "ERROR: xor   x5,  x14,  x8    # x5 = 0xff000fff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xor   x6,  x7,   x14   # x6 = 0x80800008
      if (spy_gpr(6) /= 32x"80800008") then
         report "ERROR: xor   x6,  x7,   x14   # x6 = 0x80800008 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xor   x7,  x5,   x8    # x7 = 0xff000000
      if (spy_gpr(7) /= 32x"ff000000") then
         report "ERROR: xor   x7,  x5,   x8    # x7 = 0xff000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xor   x8,  x6,   x0    # x8 = 0x80800008
      if (spy_gpr(8) /= 32x"80800008") then
         report "ERROR: xor   x8,  x6,   x0    # x8 = 0x80800008 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xor   x9,  x0,   x0    # x9 = 0x00000000
      if (spy_gpr(9) /= 32x"00000000") then
         report "ERROR: xor   x9,  x0,   x0    # x9 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xor   x3,  x6,   x6    # x3 = 0x00000000
      if (spy_gpr(3) /= 32x"00000000") then
         report "ERROR: xor   x3,  x6,   x6    # x3 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xor   x4,  x5,   x11   # x4 = 0x00e00fff
      if (spy_gpr(4) /= 32x"00e00fff") then
         report "ERROR: xor   x4,  x5,   x11   # x4 = 0x00e00fff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xor   x5,  x7,   x10   # x5 = 0x00ffef82
      if (spy_gpr(5) /= 32x"00ffef82") then
         report "ERROR: xor   x5,  x7,   x10   # x5 = 0x00ffef82 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xor   x6,  x11,  x8    # x6 = 0x7f600008
      if (spy_gpr(6) /= 32x"7f600008") then
         report "ERROR: xor   x6,  x11,  x8    # x6 = 0x7f600008 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xor   x7,  x14,  x14   # x7 = 0x00000000
      if (spy_gpr(7) /= 32x"00000000") then
         report "ERROR: xor   x7,  x14,  x14   # x7 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xor   x8,  x10,  x13   # x8 = 0x7fffef82
      if (spy_gpr(8) /= 32x"7fffef82") then
         report "ERROR: xor   x8,  x10,  x13   # x8 = 0x7fffef82 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xor   x9,  x5,   x3    # x9 = 0x00ffef82
      if (spy_gpr(9) /= 32x"00ffef82") then
         report "ERROR: xor   x9,  x5,   x3    # x9 = 0x00ffef82 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xor   x9,  x9,   x9    # x9 = 0x00000000
      if (spy_gpr(9) /= 32x"00000000") then
         report "ERROR: xor   x9,  x9,   x9    # x9 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- xor   x9,  x9,   x9    # x9 = 0x00000000
      if (spy_gpr(9) /= 32x"00000000") then
         report "ERROR: xor   x9,  x9,   x9    # x9 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   SRL    --
      --------------
      -- srl   x10, x10,  x11   # x10 = 0xffffef82
      if (spy_gpr(10) /= 32x"ffffef82") then
         report "ERROR: srl   x10, x10,  x11   # x10 = 0xffffef82 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srl   x11, x11,  x10   # x11 = 0x3ff80000
      if (spy_gpr(11) /= 32x"3ff80000") then
         report "ERROR: srl   x11, x11,  x10   # x11 = 0x3ff80000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srl   x12, x14,  x8    # x12 = 0x3fc00000
      if (spy_gpr(12) /= 32x"3fc00000") then
         report "ERROR: srl   x12, x14,  x8    # x12 = 0x3fc00000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srl   x13, x7,   x14   # x13 = 0x00000000
      if (spy_gpr(13) /= 32x"00000000") then
         report "ERROR: srl   x13, x7,   x14   # x13 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srl   x14, x5,   x8    # x14 = 0x003ffbe0
      if (spy_gpr(14) /= 32x"003ffbe0") then
         report "ERROR: srl   x14, x5,   x8    # x14 = 0x003ffbe0 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srl   x15, x6,   x0    # x15 = 0x7f600008
      if (spy_gpr(15) /= 32x"7f600008") then
         report "ERROR: srl   x15, x6,   x0    # x15 = 0x7f600008 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srl   x16, x0,   x0    # x16 = 0x00000000
      if (spy_gpr(16) /= 32x"00000000") then
         report "ERROR: srl   x16, x0,   x0    # x16 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srl   x10, x10,  x6    # x10 = 0x00ffffef
      if (spy_gpr(10) /= 32x"00ffffef") then
         report "ERROR: srl   x10, x10,  x6    # x10 = 0x00ffffef | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srl   x11, x11,  x11   # x11 = 0x3ff80000
      if (spy_gpr(11) /= 32x"3ff80000") then
         report "ERROR: srl   x11, x11,  x11   # x11 = 0x3ff80000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srl   x12, x2,   x10   # x12 = 0x00000000
      if (spy_gpr(12) /= 32x"00000000") then
         report "ERROR: srl   x12, x2,   x10   # x12 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srl   x13, x13,  x8    # x13 = 0x00000000
      if (spy_gpr(13) /= 32x"00000000") then
         report "ERROR: srl   x13, x13,  x8    # x13 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srl   x14, x14,  x14   # x14 = 0x003ffbe0
      if (spy_gpr(14) /= 32x"003ffbe0") then
         report "ERROR: srl   x14, x14,  x14   # x14 = 0x003ffbe0 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srl   x15, x15,  x13   # x15 = 0x7f600008
      if (spy_gpr(15) /= 32x"7f600008") then
         report "ERROR: srl   x15, x15,  x13   # x15 = 0x7f600008 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srl   x16, x16,  x3    # x16 = 0x00000000
      if (spy_gpr(16) /= 32x"00000000") then
         report "ERROR: srl   x16, x16,  x3    # x16 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srl   x16, x16,  x16   # x16 = 0x00000000
      if (spy_gpr(16) /= 32x"00000000") then
         report "ERROR: srl   x16, x16,  x16   # x16 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- srl   x16, x16,  x16   # x16 = 0x00000000
      if (spy_gpr(16) /= 32x"00000000") then
         report "ERROR: srl   x16, x16,  x16   # x16 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   SRA    --
      --------------
      -- sra   x17, x4,   x6    # x17 = 0x0000e00f
      if (spy_gpr(17) /= 32x"0000e00f") then
         report "ERROR: sra   x17, x4,   x6    # x17 = 0x0000e00f | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sra   x18, x6,   x4    # x18 = 0x00000000
      if (spy_gpr(18) /= 32x"00000000") then
         report "ERROR: sra   x18, x6,   x4    # x18 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sra   x19, x6,   x8    # x19 = 0x1fd80002
      if (spy_gpr(19) /= 32x"1fd80002") then
         report "ERROR: sra   x19, x6,   x8    # x19 = 0x1fd80002 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sra   x20, x7,   x9    # x20 = 0x00000000
      if (spy_gpr(20) /= 32x"00000000") then
         report "ERROR: sra   x20, x7,   x9    # x20 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sra   x21, x8,   x19   # x21 = 0x1ffffbe0
      if (spy_gpr(21) /= 32x"1ffffbe0") then
         report "ERROR: sra   x21, x8,   x19   # x21 = 0x1ffffbe0 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sra   x22, x9,   x5    # x22 = 0x00000000
      if (spy_gpr(22) /= 32x"00000000") then
         report "ERROR: sra   x22, x9,   x5    # x22 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sra   x23, x10,  x0    # x23 = 0x00ffffef
      if (spy_gpr(23) /= 32x"00ffffef") then
         report "ERROR: sra   x23, x10,  x0    # x23 = 0x00ffffef | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sra   x17, x6,   x5    # x17 = 0x1fd80002
      if (spy_gpr(17) /= 32x"1fd80002") then
         report "ERROR: sra   x17, x6,   x5    # x17 = 0x1fd80002 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sra   x18, x7,   x11   # x18 = 0x00000000
      if (spy_gpr(18) /= 32x"00000000") then
         report "ERROR: sra   x18, x7,   x11   # x18 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sra   x19, x8,   x10   # x19 = 0x0000ffff
      if (spy_gpr(19) /= 32x"0000ffff") then
         report "ERROR: sra   x19, x8,   x10   # x19 = 0x0000ffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sra   x20, x9,   x8    # x20 = 0x00000000
      if (spy_gpr(20) /= 32x"00000000") then
         report "ERROR: sra   x20, x9,   x8    # x20 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sra   x21, x14,  x14   # x21 = 0x003ffbe0
      if (spy_gpr(21) /= 32x"003ffbe0") then
         report "ERROR: sra   x21, x14,  x14   # x21 = 0x003ffbe0 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sra   x22, x15,  x13   # x22 = 0x7f600008
      if (spy_gpr(22) /= 32x"7f600008") then
         report "ERROR: sra   x22, x15,  x13   # x22 = 0x7f600008 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sra   x23, x16,  x3    # x23 = 0x00000000
      if (spy_gpr(23) /= 32x"00000000") then
         report "ERROR: sra   x23, x16,  x3    # x23 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sra   x23, x23,  x23   # x23 = 0x00000000
      if (spy_gpr(23) /= 32x"00000000") then
         report "ERROR: sra   x23, x23,  x23   # x23 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sra   x23, x23,  x23   # x23 = 0x00000000
      if (spy_gpr(23) /= 32x"00000000") then
         report "ERROR: sra   x23, x23,  x23   # x23 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   OR     --
      --------------
      -- or    x24, x4,   x8    # x24 = 0x7fffefff
      if (spy_gpr(24) /= 32x"7fffefff") then
         report "ERROR: or    x24, x4,   x8    # x24 = 0x7fffefff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- or    x25, x8,   x4    # x25 = 0x7fffefff
      if (spy_gpr(25) /= 32x"7fffefff") then
         report "ERROR: or    x25, x8,   x4    # x25 = 0x7fffefff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- or    x26, x6,   x0    # x26 = 0x7f600008
      if (spy_gpr(26) /= 32x"7f600008") then
         report "ERROR: or    x26, x6,   x0    # x26 = 0x7f600008 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- or    x27, x7,   x10   # x27 = 0x00ffffef
      if (spy_gpr(27) /= 32x"00ffffef") then
         report "ERROR: or    x27, x7,   x10   # x27 = 0x00ffffef | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- or    x28, x8,   x19   # x28 = 0x7fffffff
      if (spy_gpr(28) /= 32x"7fffffff") then
         report "ERROR: or    x28, x8,   x19   # x28 = 0x7fffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- or    x29, x10,  x5    # x29 = 0x00ffffef
      if (spy_gpr(29) /= 32x"00ffffef") then
         report "ERROR: or    x29, x10,  x5    # x29 = 0x00ffffef | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- or    x30, x11,  x0    # x30 = 0x3ff80000
      if (spy_gpr(30) /= 32x"3ff80000") then
         report "ERROR: or    x30, x11,  x0    # x30 = 0x3ff80000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- or    x24, x6,   x5    # x24 = 0x7fffef8a
      if (spy_gpr(24) /= 32x"7fffef8a") then
         report "ERROR: or    x24, x6,   x5    # x24 = 0x7fffef8a | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- or    x25, x7,   x11   # x25 = 0x3ff80000
      if (spy_gpr(25) /= 32x"3ff80000") then
         report "ERROR: or    x25, x7,   x11   # x25 = 0x3ff80000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- or    x26, x8,   x10   # x26 = 0x7fffffef
      if (spy_gpr(26) /= 32x"7fffffef") then
         report "ERROR: or    x26, x8,   x10   # x26 = 0x7fffffef | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- or    x27, x10,  x8    # x27 = 0x7fffffef
      if (spy_gpr(27) /= 32x"7fffffef") then
         report "ERROR: or    x27, x10,  x8    # x27 = 0x7fffffef | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- or    x28, x11,  x14   # x28 = 0x3ffffbe0
      if (spy_gpr(28) /= 32x"3ffffbe0") then
         report "ERROR: or    x28, x11,  x14   # x28 = 0x3ffffbe0 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- or    x29, x16,  x13   # x29 = 0x00000000
      if (spy_gpr(29) /= 32x"00000000") then
         report "ERROR: or    x29, x16,  x13   # x29 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- or    x30, x15,  x5    # x30 = 0x7fffef8a
      if (spy_gpr(30) /= 32x"7fffef8a") then
         report "ERROR: or    x30, x15,  x5    # x30 = 0x7fffef8a | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- or    x30, x30,  x30   # x30 = 0x7fffef8a
      if (spy_gpr(30) /= 32x"7fffef8a") then
         report "ERROR: or    x30, x30,  x30   # x30 = 0x7fffef8a | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- or    x30, x30,  x30   # x30 = 0x7fffef8a
      if (spy_gpr(30) /= 32x"7fffef8a") then
         report "ERROR: or    x30, x30,  x30   # x30 = 0x7fffef8a | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   AND    --
      --------------
      -- and   x31, x4,   x6    # x31 = 0x00600008
      if (spy_gpr(31) /= 32x"00600008") then
         report "ERROR: and   x31, x4,   x6    # x31 = 0x00600008 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- and   x1,  x6,   x4    # x1 = 0x00600008
      if (spy_gpr(1) /= 32x"00600008") then
         report "ERROR: and   x1,  x6,   x4    # x1 = 0x00600008 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- and   x2,  x6,   x8    # x2 = 0x7f600000
      if (spy_gpr(2) /= 32x"7f600000") then
         report "ERROR: and   x2,  x6,   x8    # x2 = 0x7f600000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- and   x3,  x10,  x9    # x3 = 0x00000000
      if (spy_gpr(3) /= 32x"00000000") then
         report "ERROR: and   x3,  x10,  x9    # x3 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- and   x4,  x8,   x19   # x4 = 0x0000ef82
      if (spy_gpr(4) /= 32x"0000ef82") then
         report "ERROR: and   x4,  x8,   x19   # x4 = 0x0000ef82 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- and   x5,  x11,  x5    # x5 = 0x00f80000
      if (spy_gpr(5) /= 32x"00f80000") then
         report "ERROR: and   x5,  x11,  x5    # x5 = 0x00f80000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- and   x31, x10,  x0    # x31 = 0x00000000
      if (spy_gpr(31) /= 32x"00000000") then
         report "ERROR: and   x31, x10,  x0    # x31 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- and   x1,  x6,   x5    # x1 = 0x00600000
      if (spy_gpr(1) /= 32x"00600000") then
         report "ERROR: and   x1,  x6,   x5    # x1 = 0x00600000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- and   x2,  x7,   x11   # x2 = 0x00000000
      if (spy_gpr(2) /= 32x"00000000") then
         report "ERROR: and   x2,  x7,   x11   # x2 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- and   x3,  x8,   x10   # x3 = 0x00ffef82
      if (spy_gpr(3) /= 32x"00ffef82") then
         report "ERROR: and   x3,  x8,   x10   # x3 = 0x00ffef82 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- and   x4,  x5,   x8    # x4 = 0x00f80000
      if (spy_gpr(4) /= 32x"00f80000") then
         report "ERROR: and   x4,  x5,   x8    # x4 = 0x00f80000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- and   x5,  x14,  x14   # x5 = 0x003ffbe0
      if (spy_gpr(5) /= 32x"003ffbe0") then
         report "ERROR: and   x5,  x14,  x14   # x5 = 0x003ffbe0 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- and   x6,  x16,  x13   # x6 = 0x00000000
      if (spy_gpr(6) /= 32x"00000000") then
         report "ERROR: and   x6,  x16,  x13   # x6 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- and   x7,  x15,  x4    # x7 = 0x00600000
      if (spy_gpr(7) /= 32x"00600000") then
         report "ERROR: and   x7,  x15,  x4    # x7 = 0x00600000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- and   x7,  x7,   x7    # x7 = 0x00600000
      if (spy_gpr(7) /= 32x"00600000") then
         report "ERROR: and   x7,  x7,   x7    # x7 = 0x00600000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- and   x7,  x7,   x7    # x7 = 0x00600000
      if (spy_gpr(7) /= 32x"00600000") then
         report "ERROR: and   x7,  x7,   x7    # x7 = 0x00600000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);

      ----------------------------------------------------------------
      --                                                            --
      --                         LUI, AUIPC                         --
      --                                                            --
      ----------------------------------------------------------------
      --------------
      --  AUIPC   --
      --------------
      -- auipc x8,  0           # x8 = ...
      wait until rising_edge(clk_tb);
      -- auipc x9,  0           # x9 = ...
      wait until rising_edge(clk_tb);
      -- sub   x10, x9,   x8    # x10 = 0x00000004
      if (spy_gpr(10) /= 32x"00000004") then
         report "ERROR: sub   x10, x9,   x8    # x10 = 0x00000004 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- auipc x11, 0           # x11 = ...
      wait until rising_edge(clk_tb);
      -- auipc x12, 1048575     # x12 = ...
      wait until rising_edge(clk_tb);
      -- sub   x13, x12,  x11   # x13 = 0xfffff004
      if (spy_gpr(13) /= 32x"fffff004") then
         report "ERROR: sub   x13, x12,  x11   # x13 = 0xfffff004 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- auipc x14, 0           # x14 = ...
      wait until rising_edge(clk_tb);
      -- auipc x15, 2048        # x15 = ...
      wait until rising_edge(clk_tb);
      -- sub   x16, x15, x14    # x16 = 0x00800004
      if (spy_gpr(16) /= 32x"00800004") then
         report "ERROR: sub   x16, x15, x14    # x16 = 0x00800004 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- auipc x17, 0           # x17 = ...
      wait until rising_edge(clk_tb);
      -- auipc x18, 1           # x18 = ...
      wait until rising_edge(clk_tb);
      -- sub   x19, x18, x17    # x19 = 0x00001004
      if (spy_gpr(19) /= 32x"00001004") then
         report "ERROR: sub   x19, x18, x17    # x19 = 0x00001004 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   LUI    --
      --------------
      -- lui   x16, 0           # x16 = 0x00000000
      if (spy_gpr(16) /= 32x"00000000") then
         report "ERROR: lui   x16, 0           # x16 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lui   x17, 1048575     # x17 = 0xfffff000
      if (spy_gpr(17) /= 32x"fffff000") then
         report "ERROR: lui   x17, 1048575     # x17 = 0xfffff000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lui   x18, 524287      # x18 = 0x7ffff000
      if (spy_gpr(18) /= 32x"7ffff000") then
         report "ERROR: lui   x18, 524287      # x18 = 0x7ffff000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lui   x19, 1024        # x19 = 0x00400000
      if (spy_gpr(19) /= 32x"00400000") then
         report "ERROR: lui   x19, 1024        # x19 = 0x00400000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lui   x20, 512         # x20 = 0x00200000
      if (spy_gpr(20) /= 32x"00200000") then
         report "ERROR: lui   x20, 512         # x20 = 0x00200000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lui   x20, 512         # x20 = 0x00200000
      if (spy_gpr(20) /= 32x"00200000") then
         report "ERROR: lui   x20, 512         # x20 = 0x00200000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lui   x21, 1           # x21 = 0x00001000
      if (spy_gpr(21) /= 32x"00001000") then
         report "ERROR: lui   x21, 1           # x21 = 0x00001000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      ----------------------------------------------------------------
      --                                                            --
      --              BEQ, BNE, BLT, BGE, BLTU, BGEU                --
      --                                                            --
      ----------------------------------------------------------------
      -- addi  x1,  x0,   1     # x1 = 0x00000001
      if (spy_gpr(1) /= 32x"00000001") then
         report "ERROR: addi  x1,  x0,   1     # x1 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x2,  x0,   2     # x2 = 0x00000002
      if (spy_gpr(2) /= 32x"00000002") then
         report "ERROR: addi  x2,  x0,   2     # x2 = 0x00000002 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x3,  x0,   -1    # x3 = 0xffffffff
      if (spy_gpr(3) /= 32x"ffffffff") then
         report "ERROR: addi  x3,  x0,   -1    # x3 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x4,  x0,   0xff  # x4 = 0x000000ff
      if (spy_gpr(4) /= 32x"000000ff") then
         report "ERROR: addi  x4,  x0,   0xff  # x4 = 0x000000ff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x5,  x0,   4     # x5 = 0x00000004
      if (spy_gpr(5) /= 32x"00000004") then
         report "ERROR: addi  x5,  x0,   4     # x5 = 0x00000004 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x7,  x0,   -4    # x7 = 0xfffffffc
      if (spy_gpr(7) /= 32x"fffffffc") then
         report "ERROR: addi  x7,  x0,   -4    # x7 = 0xfffffffc | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x8,  x0,   -8    # x8 = 0xfffffff8
      if (spy_gpr(8) /= 32x"fffffff8") then
         report "ERROR: addi  x8,  x0,   -8    # x8 = 0xfffffff8 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x9,  x0,   0     # x9 = 0x00000000
      if (spy_gpr(9) /= 32x"00000000") then
         report "ERROR: addi  x9,  x0,   0     # x9 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   BEQ    --
      --------------
      -- addi  x0,  x0,   0     # x0 = 0x00000000 1.
      if (spy_gpr(0) /= 32x"00000000") then
         report "ERROR: addi  x0,  x0,   0    x0 = 0x00000000 1. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- beq   x3,  x4,   loop1 # ... 2.
      -- The next instructions will check the correctness of this instruction
      wait until rising_edge(clk_tb);
      -- auipc x10, 0           # ... 3.
      wait until rising_edge(clk_tb);
      -- beq   x0,  x9,   loop2 # ... 4.
      wait until rising_edge(clk_tb);
      -- Below is the instruction that will never be executed, so the
      -- "wait until rising_edge(clk_tb);" line have been removed
      -- addi  x1,  x1,   1     # don't check, will never be done
      -- wait until rising_edge(clk_tb);
      -- auipc x11, 0           # ... 5.
      wait until rising_edge(clk_tb);
      -- sub   x12, x11,  x10   # x12 = 0x00000024 6.
      if (spy_gpr(12) /= 32x"00000024") then
         report "ERROR: sub   x12, x11,  x10   # x12 = 0x00000024 6. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- beq   x0,  x9,   loop4 # ... 7.
      wait until rising_edge(clk_tb);
      -- auipc x13, 0           # ... 8.
      wait until rising_edge(clk_tb);
      -- sub   x14, x13,  x11   # x14 = 0xffffffe8 9.
      if (spy_gpr(14) /= 32x"ffffffe8") then
         report "ERROR: sub  x14, x13, x11 # x14 = 0xffffffe8 9. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- beq   x5,  x7,   loop6 # ... 10.
      wait until rising_edge(clk_tb);
      -- auipc x15, 0           # ... 11.
      wait until rising_edge(clk_tb);
      -- sub   x16, x15,  x13   # x16 = 0x0000000c 12.
      if (spy_gpr(16) /= 32x"0000000c") then
         report "ERROR: sub   x16, x15,  x13   # x16 = 0x0000000c 12. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- beq   x9,  x0,   loop6 # ... 13.
      wait until rising_edge(clk_tb);
      -- auipc x17, 0           # ... 14.
      wait until rising_edge(clk_tb);
      -- sub   x18, x17,  x15   # x18 = 0x00000018 15.
      if (spy_gpr(18) /= 32x"00000018") then
         report "ERROR: sub   x18, x17,  x15   # x18 = 0x00000018 15. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x1,  x1,   1     # x1 = 0x00000002 16.
      if (spy_gpr(1) /= 32x"00000002") then
         report "ERROR: addi  x1,  x1,   1     # x1 = 0x00000002 16. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x1,  x0,   0     # x1 = 0x00000000 17.
      if (spy_gpr(1) /= 32x"00000000") then
         report "ERROR: addi  x1,  x0,   0     # x1 = 0x00000000 17. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   BNE    --
      --------------
      -- auipc x19, 0           # ... 1.
      wait until rising_edge(clk_tb);
      -- bne   x3,  x4,   loop7 # ... 2.
      wait until rising_edge(clk_tb);
      -- auipc x20, 0           # ... 3.
      wait until rising_edge(clk_tb);
      -- sub   x21, x20,  x19   # x21 = 0x00000024 4.
      if (spy_gpr(21) /= 32x"00000024") then
         report "ERROR: sub   x21, x20,  x19   # x21 = 0x00000024 4. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- bne   x5,  x7,   loop8 # ... 5.
      wait until rising_edge(clk_tb);
      -- auipc x22, 0           # ... 6.
      wait until rising_edge(clk_tb);
      -- sub   x23, x22,  x20   # x23 = 0xffffffe4 7.
      if (spy_gpr(23) /= 32x"ffffffe4") then
         report "ERROR: sub   x23, x22,  x20   # x23 = 0xffffffe4 7. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x1,  x1,   1     # x1 = 0x00000001 8.
      if (spy_gpr(1) /= 32x"00000001") then
         report "ERROR: addi  x1,  x1,   1     # x1 = 0x00000001 8. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- bne   x9,  x0,   loop9 # ... 9.
      wait until rising_edge(clk_tb);
      -- auipc x24, 0           # ... 10.
      wait until rising_edge(clk_tb);
      -- sub   x25, x24,  x22   # x25 = 0x00000010 11.
      if (spy_gpr(25) /= 32x"00000010") then
         report "ERROR: sub   x25, x24,  x22   # x25 = 0x00000010 11. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- bne   x7,  x8,   loop9 # ... 12.
      wait until rising_edge(clk_tb);
      -- auipc x26, 0           # ... 13.
      wait until rising_edge(clk_tb);
      -- sub   x27, x26,  x24   # x27 = 0x00000018 14.
      if (spy_gpr(27) /= 32x"00000018") then
         report "ERROR: sub   x27, x26,  x24   # x27 = 0x00000018 14. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x1,  x0,   0     # x1 = 0x00000000 15.
      if (spy_gpr(1) /= 32x"00000000") then
         report "ERROR: addi  x1,  x0,   0     # x1 = 0x00000000 15. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   BLT    --
      --------------
      -- auipc x28, 0           # ... 1.
      wait until rising_edge(clk_tb);
      -- blt   x3,  x4,   loop10# ... 2.
      wait until rising_edge(clk_tb);
      -- auipc x29, 0           # ... 3.
      wait until rising_edge(clk_tb);
      -- sub   x30, x29,  x28   # x30 = 0x0000001c 4.
      if (spy_gpr(30) /= 32x"0000001c") then
         report "ERROR: sub   x30, x29,  x28   # x30 = 0x0000001c 4. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- blt   x4,  x3,   loop11# ... 5.
      wait until rising_edge(clk_tb);
      -- addi  x1,  x1,   1     # x1 = 0x00000001 6.
      if (spy_gpr(1) /= 32x"00000001") then
         report "ERROR: addi  x1,  x1,   1     # x1 = 0x00000001 6. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- blt   x9,  x0,   loop11# ... 7.
      wait until rising_edge(clk_tb);
      -- addi  x1,  x1,   1     # x1 = 0x00000002 8.
      if (spy_gpr(1) /= 32x"00000002") then
         report "ERROR: addi  x1,  x1,   1     # x1 = 0x00000002 8. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- blt   x8,  x7,   loop11# ... 9.
      wait until rising_edge(clk_tb);
      -- auipc x31, 0           # ... 10.
      wait until rising_edge(clk_tb);
      -- sub   x10, x31,  x28   # x10 = 0x00000008 11.
      if (spy_gpr(10) /= 32x"00000008") then
         report "ERROR: sub   x10, x31,  x28   # x10 = 0x00000008 11. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- blt   x7,  x8,   loop12# ... 12.
      wait until rising_edge(clk_tb);
      -- addi  x1,  x1,   1     # x1 = 0x00000003 13.
      if (spy_gpr(1) /= 32x"00000003") then
         report "ERROR: addi  x1,  x1,   1     # x1 = 0x00000003 13. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- blt   x3,  x1,   loop12# ... 14.
      wait until rising_edge(clk_tb);
      -- auipc x11, 0           # ... 15.
      wait until rising_edge(clk_tb);
      -- sub   x12, x11,  x31   # x12 = 0x00000030 16.
      if (spy_gpr(12) /= 32x"00000030") then
         report "ERROR: sub   x12, x11,  x31   # x12 = 0x00000030 16. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x1,  x0,   0     # x1 = 0x00000000 17.
      if (spy_gpr(1) /= 32x"00000000") then
         report "ERROR: addi  x1,  x0,   0     # x1 = 0x00000000 17. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   BGE    --
      --------------
      -- auipc x13, 0           # ... 1.
      wait until rising_edge(clk_tb);
      -- bge   x4,  x3,   loop13# ... 2.
      wait until rising_edge(clk_tb);
      -- auipc x14, 0           # ... 3.
      wait until rising_edge(clk_tb);
      -- sub   x15, x14,  x13   # x15 = 0x0000001c 4.
      if (spy_gpr(15) /= 32x"0000001c") then
         report "ERROR: sub   x15, x14,  x13   # x15 = 0x0000001c 4. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- bge   x3,  x4,   loop14# ... 5.
      wait until rising_edge(clk_tb);
      -- addi  x1,  x1,   1     # x1 = 0x00000001 6.
      if (spy_gpr(1) /= 32x"00000001") then
         report "ERROR: addi  x1,  x1,   1     # x1 = 0x00000001 6. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- bge   x7,  x4,   loop14# ... 7.
      wait until rising_edge(clk_tb);
      -- addi  x1,  x1,   1     # x1 = 0x00000002 8.
      if (spy_gpr(1) /= 32x"00000002") then
         report "ERROR: addi  x1,  x1,   1     # x1 = 0x00000002 8. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- bge   x0,  x9,   loop14# ... 9.
      wait until rising_edge(clk_tb);
      -- auipc x16, 0           # ... 10.
      wait until rising_edge(clk_tb);
      -- sub   x17, x16,  x14   # x17 = 0xffffffec 11.
      if (spy_gpr(17) /= 32x"ffffffec") then
         report "ERROR: sub   x17, x16,  x14   # x17 = 0xffffffec 11. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- bge   x8,  x7,   loop15# ... 12.
      wait until rising_edge(clk_tb);
      -- addi  x1,  x1,   1     # x1 = 0x00000003 13.
      if (spy_gpr(1) /= 32x"00000003") then
         report "ERROR: addi  x1,  x1,   1     # x1 = 0x00000003 13. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- bge   x1,  x3,   loop15# ... 14.
      wait until rising_edge(clk_tb);
      -- auipc x18, 0           # ... 15.
      wait until rising_edge(clk_tb);
      -- sub   x12, x18,  x17   # x12 = 0x00000030 16.
      if (spy_gpr(12) /= 32x"00000030") then
         report "ERROR: sub   x12, x18,  x16   # x12 = 0x00000030 16. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x1,  x0,   0     # x1 = 0x00000000 17.
      if (spy_gpr(1) /= 32x"00000000") then
         report "ERROR: addi  x1,  x0,   0     # x1 = 0x00000000 17. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   BLTU   --
      --------------
      -- auipc x20, 0           # ... 1.
      wait until rising_edge(clk_tb);
      -- bltu  x8,  x7,   loop16# ... 2.
      wait until rising_edge(clk_tb);
      -- auipc x21, 0           # ... = 3.
      wait until rising_edge(clk_tb);
      -- sub   x22, x21,  x20   # x22 = 0x00000024 4.
      if (spy_gpr(22) /= 32x"00000024") then
         report "ERROR: sub   x22, x21,  x20   # x22 = 0x00000024 4. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- bltu  x8,  x7,   loop17# ... 5.
      wait until rising_edge(clk_tb);
      -- auipc x23, 0           # ... = 6.
      wait until rising_edge(clk_tb);
      -- sub   x24, x23,  x21   # x24 = 0xffffffe4 7.
      if (spy_gpr(24) /= 32x"ffffffe4") then
         report "ERROR: sub   x24, x23,  x21   # x24 = 0xffffffe4 7. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- bltu  x9,  x0,   loop18# ... 8.
      wait until rising_edge(clk_tb);
      -- addi  x1,  x1,   1     # x1 = 0x00000001 9.
      if (spy_gpr(1) /= 32x"00000001") then
         report "ERROR: addi  x1,  x1,   1     # x1 = 0x00000001 9. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- bltu  x3,  x4,   loop18# ... 10.
      wait until rising_edge(clk_tb);
      -- addi  x1,  x1,   1     # x1 = 0x00000002 11.
      if (spy_gpr(1) /= 32x"00000002") then
         report "ERROR: addi  x1,  x1,   1     # x1 = 0x00000002 11. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- bltu  x4,  x3,   loop18# ... 12.
      wait until rising_edge(clk_tb);
      -- auipc x25, 0           # ...  13.
      wait until rising_edge(clk_tb);
      -- sub   x26, x25,  x23   # x26 = 0x00000028 14.
      if (spy_gpr(26) /= 32x"00000028") then
         report "ERROR: sub   x26, x25,  x23   # x26 = 0x00000028 14. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x1,  x0,   0     # x1 = 0x00000000 15.
      if (spy_gpr(1) /= 32x"00000000") then
         report "ERROR: addi  x1,  x0,   0     # x1 = 0x00000000 15. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   BGEU   --
      --------------
      -- auipc x27, 0           # ... 1.
      wait until rising_edge(clk_tb);
      -- bgeu  x7,  x8,   loop19# ... 2.
      wait until rising_edge(clk_tb);
      -- auipc x30, 0           # ... = 3.
      wait until rising_edge(clk_tb);
      -- sub   x31, x30,  x27   # x31 = 0x00000024 4.
      if (spy_gpr(31) /= 32x"00000024") then
         report "ERROR: sub   x31, x30,  x27   # x31 = 0x00000024 4. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- bgeu  x7,  x8,   loop20# ... 5.
      wait until rising_edge(clk_tb);
      -- auipc x28, 0           # ... = 6.
      wait until rising_edge(clk_tb);
      -- sub   x29, x28,  x27   # x29 = 0x00000008 7.
      if (spy_gpr(29) /= 32x"00000008") then
         report "ERROR: sub   x29, x28,  x27   # x29 = 0x00000008 7. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- bgeu  x2,  x7,   loop21# ... 8.
      wait until rising_edge(clk_tb);
      -- addi  x1,  x1,   1     # x1 = 0x00000001 9.
      if (spy_gpr(1) /= 32x"00000001") then
         report "ERROR: addi  x1,  x1,   1     # x1 = 0x00000001 9. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- bgeu  x4,  x3,   loop21# ... 10.
      wait until rising_edge(clk_tb);
      -- addi  x1,  x1,   1     # x1 = 0x00000002 11.
      if (spy_gpr(1) /= 32x"00000002") then
         report "ERROR: addi  x1,  x1,   1     # x1 = 0x00000002 11. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- bgeu  x3,  x4,   loop21# ... 12.
      wait until rising_edge(clk_tb);
      -- auipc x10,  0          # ...  13.
      wait until rising_edge(clk_tb);
      -- sub   x11, x10,  x30   # x11 = 0x0000000c 14.
      if (spy_gpr(11) /= 32x"0000000c") then
         report "ERROR: sub   x11, x10,  x30   # x11 = 0x0000000c 14. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x1,  x0,   0     # x1 = 0x00000000 15.
      if (spy_gpr(1) /= 32x"00000000") then
         report "ERROR: addi  x1,  x0,   0     # x1 = 0x00000000 15. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      ----------------------------------------------------------------
      --                                                            --
      --                         JAL, JALR                          --
      --                                                            --
      ----------------------------------------------------------------
      --------------
      --   JAL    --
      --------------
      -- auipc x12,  0          # ... 1.
      wait until rising_edge(clk_tb);
      -- jal   x13,  loop22     # ... 2.
      wait until rising_edge(clk_tb);
      -- addi  x1,  x1,   1     # x1 = 0x00000001 3.
      if (spy_gpr(1) /= 32x"00000001") then
         report "ERROR: addi  x1,  x1,   1     # x1 = 0x00000001 3. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x1,  x1,   1     # x1 = 0x00000002 4.
      if (spy_gpr(1) /= 32x"00000002") then
         report "ERROR: addi  x1,  x1,   1     # x1 = 0x00000002 4. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- jal   x14,  loop23     # ... 5.
      wait until rising_edge(clk_tb);
      -- addi  x1,  x1,   1     # x1 = 0x00000003 6.
      if (spy_gpr(1) /= 32x"00000003") then
         report "ERROR: addi  x1,  x1,   1     # x1 = 0x00000003 6. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x1,  x1,   1     # x1 = 0x00000004 7.
      if (spy_gpr(1) /= 32x"00000004") then
         report "ERROR: addi  x1,  x1,   1     # x1 = 0x00000004 7. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- jal   x15,  loop24     # ... 8.
      wait until rising_edge(clk_tb);
      -- addi  x1,  x1,   1     # x1 = 0x00000005 9.
      if (spy_gpr(1) /= 32x"00000005") then
         report "ERROR: addi  x1,  x1,   1     # x1 = 0x00000005 9. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- auipc x16, 0           # ...  10.
      wait until rising_edge(clk_tb);
      -- sub   x17, x16,  x15   # x17 = 0x00000010 11.
      if (spy_gpr(17) /= 32x"00000010") then
         report "ERROR: sub   x17, x16,  x15   # x17 = 0x00000010 11. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x1,  x0,   0     # x1 = 0x00000000 12.
      if (spy_gpr(1) /= 32x"00000000") then
         report "ERROR: addi  x1,  x0,   0     # x1 = 0x00000000 12. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   JALR   --
      --------------
      -- auipc x18, 0           # ... 1.
      wait until rising_edge(clk_tb);
      -- jalr  x19, x18,  8     # ... 2.
      wait until rising_edge(clk_tb);
      -- addi  x0,  x0,   0     # x0 = 0x00000000 3.
      if (spy_gpr(0) /= 32x"00000000") then
         report "ERROR: addi  x0,  x0,   0     # x0 = 0x00000000 3. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- jalr  x20, x18,  28    # ... 4.
      wait until rising_edge(clk_tb);
      -- auipc x21, 0           # ... 5.
      wait until rising_edge(clk_tb);
      -- jalr  x22, x21,  -12   # ... 6.
      wait until rising_edge(clk_tb);
      -- addi  x0,  x0,   0     # x0 = 0x00000000 7.
      if (spy_gpr(0) /= 32x"00000000") then
         report "ERROR: addi  x0,  x0,   0     # x0 = 0x00000000 7. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- auipc x23, 0           # ... 8.
      wait until rising_edge(clk_tb);
      -- jalr  x24, x23,  16    # ... 9.
      wait until rising_edge(clk_tb);
      -- addi  x0,  x0,   0     # x9 = 0x00000000 10.
      if (spy_gpr(0) /= 32x"00000000") then
         report "ERROR: addi  x0,  x0,   0     # x9 = 0x00000000 10. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x0,  x0,   0     # x9 = 0x00000000 11.
      if (spy_gpr(0) /= 32x"00000000") then
         report "ERROR: addi  x0,  x0,   0     # x9 = 0x00000000 11. | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      ----------------------------------------------------------------
      --                                                            --
      --                         SB, SH, SW                         --
      --                                                            --
      ----------------------------------------------------------------
      -- addi  x1,  x0,   1     # x1 = 0x00000001
      if (spy_gpr(1) /= 32x"00000001") then
         report "ERROR: addi  x1,  x0,   1     # x1 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x2,  x0,   2     # x2 = 0x00000002
      if (spy_gpr(2) /= 32x"00000002") then
         report "ERROR: addi  x2,  x0,   2     # x2 = 0x00000002 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x3,  x0,   0     # x3 = 0x00000000
      if (spy_gpr(3) /= 32x"00000000") then
         report "ERROR: addi  x3,  x0,   0     # x3 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x4,  x0,   1234  # x4 = 0x000004d2
      if (spy_gpr(4) /= 32x"000004d2") then
         report "ERROR: addi  x4,  x0,   1234  # x4 = 0x000004d2 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x5,  x0,   0xAB  # x5 = 0x000000ab
      if (spy_gpr(5) /= 32x"000000ab") then
         report "ERROR: addi  x5,  x0,   0xAB  # x5 = 0x000000ab | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x6,  x0,   0xCD  # x6 = 0x000000cd
      if (spy_gpr(6) /= 32x"000000cd") then
         report "ERROR: addi  x6,  x0,   0xCD  # x6 = 0x000000cd | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x7,  x0,   -1024 # x7 = 0xfffffc00
      if (spy_gpr(7) /= 32x"fffffc00") then
         report "ERROR: addi  x7,  x0,   -1024 # x7 = 0xfffffc00 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lui   x8,  0xABCDE     # x8 = 0xabcde000
      if (spy_gpr(8) /= 32x"abcde000") then
         report "ERROR: lui   x8,  0xABCDE     # x8 = 0xabcde000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x8,  x8,   0xF1  # x8 = 0xabcde0f1
      if (spy_gpr(8) /= 32x"abcde0f1") then
         report "ERROR: addi  x8,  x8,   0xF1  # x8 = 0xabcde0f1 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lui   x9,  0x12345     # x9 = 0x12345000
      if (spy_gpr(9) /= 32x"12345000") then
         report "ERROR: lui   x9,  0x12345     # x9 = 0x12345000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x9,  x9,   0x678 # x9 = 0x12345678
      if (spy_gpr(9) /= 32x"12345678") then
         report "ERROR: addi  x9,  x9,   0x678 # x9 = 0x12345678 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   SB     --
      --------------
      -- sb   x9,  0(x0)  # 0x00000000 = 0x00000078
      if (spy_ram(0)(0) /= x"78") then
         report "ERROR: sb    x9,  0(x0)       # 0x00000000 = 0x00000078 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb   x9,  1(x0)   # 0x00000000 = 0x00007878
      if (spy_ram(0)(1) /= x"78") then
         report "ERROR: sb    x9,  1(x0)       # 0x00000000 = 0x00007878 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb   x9,  1(x1)   # 0x00000000 = 0x00787878
      if (spy_ram(0)(2) /= x"78") then
         report "ERROR: sb    x9,  1(x1)       # 0x00000000 = 0x00787878 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb   x9,  1(x2)   # 0x00000000 = 0x78787878
      if (spy_ram(0)(3) /= x"78") then
         report "ERROR: sb    x9,  1(x2)       # 0x00000000 = 0x78787878 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb   x9,  2(x2)   # 0x00000004 = 0x00000078
      if (spy_ram(1)(0) /= x"78") then
         report "ERROR: sb    x9,  2(x2)       # 0x00000004 = 0x00000078 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb   x8,  -1(x1)  # 0x00000000 = 0x787878f1
      if (spy_ram(0)(0) /= x"f1") then
         report "ERROR: sb    x8,  -1(x1)      # 0x00000000 = 0x787878f1 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb   x8,  -1(x2)  # 0x00000000 = 0x7878f1f1
      if (spy_ram(0)(1) /= x"f1") then
         report "ERROR: sb    x8,  -1(x2)      # 0x00000000 = 0x7878f1f1 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb   x8,  -2(x2)  # 0x00000000 = 0x7878f1f1
      if (spy_ram(0)(0) /= x"f1") then
         report "ERROR: sb    x8,  -2(x2)      # 0x00000000 = 0x7878f1f1 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb   x8,  10(x0)  # 0x00000008 = 0x00f10000
      if (spy_ram(2)(2) /= x"f1") then
         report "ERROR: sb    x8,  10(x0)      # 0x00000008 = 0x00f10000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb   x8,  16(x1)  # 0x00000010 = 0x0000f100
      if (spy_ram(4)(1) /= x"f1") then
         report "ERROR: sb    x8,  16(x1)      # 0x00000010 = 0x0000f100 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   SH     --
      --------------
      -- sh    x8,  0(x0)  	   # 0x00000000 = 0xf1e07878
      if (spy_ram(0)(0) /= x"f1" or spy_ram(0)(1) /= x"e0") then
         report "ERROR: sh    x8,  0(x0)       # 0x00000000 = 0xf1e07878 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sh    x8,  1(x1)  	   # 0x00000000 = 0xf1e0f1e0
      if (spy_ram(0)(2) /= x"f1" or spy_ram(0)(3) /= x"e0") then
         report "ERROR: sh    x8,  1(x1)       # 0x00000000 = 0xf1e0f1e0 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sh    x8,  2(x2)  	   # 0x00000004 = 0xf1e010e0
      if (spy_ram(1)(0) /= x"f1" or spy_ram(1)(1) /= x"e0") then
         report "ERROR: sh    x8,  2(x2)       # 0x00000004 = 0xf1e010e0 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sh    x9,  -1(x1)  	   # 0x00000000 = 0x7856f1e0
      if (spy_ram(0)(0) /= x"78" or spy_ram(0)(1) /= x"56") then
         report "ERROR: sh    x9,  -1(x1)      # 0x00000000 = 0x7856f1e0 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sh    x8,  -2(x2) 	   # 0x00000000 = 0xf1e0f1e0
      if (spy_ram(0)(0) /= x"f1" or spy_ram(0)(1) /= x"e0") then
         report "ERROR: sh    x8,  -2(x2)      # 0x00000000 = 0xf1e0f1e0 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sh    x8,  10(x0) 	   # 0x00000008 = 0x9301f1e0
      if (spy_ram(2)(2) /= x"f1" or spy_ram(2)(3) /= x"e0") then
         report "ERROR: sh    x8,  10(x0)      # 0x00000008 = 0x9301f1e0 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sh    x8,  16(x2) 	   # 0x00000010 = 0x93f1f1e0
      if (spy_ram(4)(2) /= x"f1" or spy_ram(4)(3) /= x"e0") then
         report "ERROR: sh    x8,  16(x2)      # 0x00000010 = 0x93f1f1e0 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   SW     --
      --------------
      -- sw   x7,  0(x0)   # 0x00000000 = 0x00fcffff
      if (spy_ram(0)(0) /= x"00" or spy_ram(0)(1) /= x"fc" or
      spy_ram(0)(2) /= x"ff" or spy_ram(0)(3) /= x"ff") then
         report "ERROR: sw    x7,  0(x0)       # 0x00000000 = 0x00fcffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sw   x7,  2(x2)   # 0x00000004 = 0x00fcffff
      if (spy_ram(1)(0) /= x"00" or spy_ram(1)(1) /= x"fc" or
      spy_ram(1)(2) /= x"ff" or spy_ram(1)(3) /= x"ff") then
         report "ERROR: sw    x7,  2(x2)       # 0x00000004 = 0x00fcffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sw   x8,  -1(x1)  # 0x00000000 = 0xf1e0cdab
      if (spy_ram(0)(0) /= x"f1" or spy_ram(0)(1) /= x"e0" or
      spy_ram(0)(2) /= x"cd" or spy_ram(0)(3) /= x"ab") then
         report "ERROR: sw    x8,  -1(x1)      # 0x00000000 = 0xf1e0cdab | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sw   x7,  -2(x2)  # 0x00000000 = 0x00fcffff
      if (spy_ram(0)(0) /= x"00" or spy_ram(0)(1) /= x"fc" or
      spy_ram(0)(2) /= x"ff" or spy_ram(0)(3) /= x"ff") then
         report "ERROR: sw    x7,  -2(x2)      # 0x00000000 = 0x00fcffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      ----------------------------------------------------------------
      --                                                            --
      --                    LB, LH, LW, LBU, LHU                    --
      --                                                            --
      ----------------------------------------------------------------
      --------------
      --   LB     --
      --------------
      -- lb    x3,  0(x1)       # x3 = 0xfffffffc
      if (spy_gpr(3) /= 32x"fffffffc") then
         report "ERROR: lb    x3,  0(x1)       # x3 = 0xfffffffc | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lb    x4,  0(x2)       # x4 = 0xffffffff
      if (spy_gpr(4) /= 32x"ffffffff") then
         report "ERROR: lb    x4,  0(x2)       # x4 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lb    x5,  11(x0)      # x5 = 0xffffffe0
      if (spy_gpr(5) /= 32x"ffffffe0") then
         report "ERROR: lb    x5,  11(x0)      # x5 = 0xffffffe0 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lb    x7,  -1(x2)      # x7 = 0xfffffffc
      if (spy_gpr(7) /= 32x"fffffffc") then
         report "ERROR: lb    x7,  -1(x2)      # x7 = 0xfffffffc | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lb    x8,  -2(x10)     # x8 = 0xffffffff
      if (spy_gpr(8) /= 32x"ffffffff") then
         report "ERROR: lb    x8,  -2(x10)     # x8 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lb    x12, 4(x3)       # x12 = 0x00000000
      if (spy_gpr(12) /= 32x"00000000") then
         report "ERROR: lb    x12, 4(x3)       # x12 = 0x00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lb    x13, 15(x3)      # x13 = 0xffffffe0
      if (spy_gpr(13) /= 32x"ffffffe0") then
         report "ERROR: lb    x13, 15(x3)      # x13 = 0xffffffe0 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --    LH    --
      --------------
      -- lh    x14, 0(x2)       # x14 = 0xffffffff
      if (spy_gpr(14) /= 32x"ffffffff") then
         report "ERROR: lh    x14, 0(x2)       # x14 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lh    x15, 10(x0)      # x15 = 0xffffe0f1
      if (spy_gpr(15) /= 32x"ffffe0f1") then
         report "ERROR: lh    x15, 10(x0)      # x15 = 0xffffe0f1 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lh    x16, -2(x10)     # x16 = 0xffffffff
      if (spy_gpr(16) /= 32x"ffffffff") then
         report "ERROR: lh    x16, -2(x10)     # x16 = 0xffffffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lh    x17, 4(x3)       # x17 = 0xfffffc00
      if (spy_gpr(17) /= 32x"fffffc00") then
         report "ERROR: lh    x17, 4(x3)       # x17 = 0xfffffc00 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --    LW    --
      --------------
      -- lw    x18, 2(x2)       # x18 = 0xfffffc00
      if (spy_gpr(18) /= 32x"fffffc00") then
         report "ERROR: lw    x18, 2(x2)       # x18 = 0xfffffc00 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lw    x19, 0(x10)      # x19 = 0xfffffc00
      if (spy_gpr(19) /= 32x"fffffc00") then
         report "ERROR: lw    x19, 0(x10)      # x19 = 0xfffffc00 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lw    x20, -4(x10)     # x20 = 0xfffffc00
      if (spy_gpr(20) /= 32x"fffffc00") then
         report "ERROR: lw    x20, -4(x10)     # x20 = 0xfffffc00 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lw    x21, 4(x3)       # x21 = 0xfffffc00
      if (spy_gpr(21) /= 32x"fffffc00") then
         report "ERROR: lw    x21, 4(x3)       # x21 = 0xfffffc00 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --   LBU    --
      --------------
      -- addi  x1,  x0,   1     # x1 = 0x00000001
      if (spy_gpr(1) /= 32x"00000001") then
         report "ERROR: addi  x1,  x0,   1     # x1 = 0x00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lbu   x2,  1(x0)       # x2  = 0x000000fc
      if (spy_gpr(2) /= 32x"000000fc") then
         report "ERROR: lbu   x2,  1(x0)       # x2  = 0x000000fc | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lbu   x3,  1(x1)       # x3  = 0x000000ff
      if (spy_gpr(3) /= 32x"000000ff") then
         report "ERROR: lbu   x3,  1(x1)       # x3  = 0x000000ff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      --------------
      --    LHU   --
      --------------
      -- lhu   x4,  4(x0)       # x4  = 0x0000fc00
      if (spy_gpr(4) /= 32x"0000fc00") then
         report "ERROR: lhu   x4,  4(x0)       # x4  = 0x0000fc00  | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- lhu   x5,  1(x1)       # x5  = 0x0000ffff
      if (spy_gpr(5) /= 32x"0000ffff") then
         report "ERROR: lhu   x5,  1(x1)       # x5  = 0x0000ffff | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      ----------------------------------------------------------------
      --                                                            --
      --                            GPIO                            --
      --                                                            --
      ----------------------------------------------------------------
      -- addi  x1,  x0,   1     # x1 = 0x00000001
      if (spy_gpr(1) /= 32x"00000001") then
         report "ERROR: addi  x1,  x0,   1     # x1 = 0x00000001";
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x2,  x0,   2     # x2 = 0x00000002
      if (spy_gpr(2) /= 32x"00000002") then
         report "ERROR: addi  x2,  x0,   2     # x2 = 0x00000002";
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x3,  x0,   4     # x3 = 0x00000004
      if (spy_gpr(3) /= 32x"00000004") then
         report "ERROR: addi  x3,  x0,   4     # x3 = 0x00000004";
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x4,  x0,   8     # x4 = 0x00000008
      if (spy_gpr(4) /= 32x"00000008") then
         report "ERROR: addi  x4,  x0,   8     # x4 = 0x00000008";
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x5,  x0,   0xf   # x5 = 0x0000000f
      if (spy_gpr(5) /= 32x"0000000f") then
         report "ERROR: addi  x5,  x0,   0xf   # x5 = 0x0000000f";
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x6,  x0,   251   # x6 = 0x000000fb
      if (spy_gpr(6) /= 32x"000000fb") then
         report "ERROR: addi  x6,  x0,   251   # x6 = 0x000000fb";
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x7,  x0,   0x1f  # x7 = 0x0000001f
      if (spy_gpr(7) /= 32x"0000001f") then
         report "ERROR: addi  x7,  x0,   0x1f  # x7 = 0x0000001f";
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x8,  x0,   0x2f  # x8 = 0x0000002f
      if (spy_gpr(8) /= 32x"0000002f") then
         report "ERROR: addi  x8,  x0,   0x2f  # x8 = 0x0000002f";
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x9,  x0,   0x4f  # x9 = 0x0000004f
      if (spy_gpr(9) /= 32x"0000004f") then
         report "ERROR: addi  x9,  x0,   0x4f  # x9 = 0x0000004f";
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x10, x0,   0x8f  # x10 = 0x0000008f
      if (spy_gpr(10) /= 32x"0000008f") then
         report "ERROR: addi  x10, x0,   0x8f  # x10 = 0x0000008f";
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x11, x0,   0xff  # x11 = 0x000000ff
      if (spy_gpr(11) /= 32x"000000ff") then
         report "ERROR: addi  x11, x0,   0xff  # x11 = 0x000000ff";
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x12, x0,   129   # x12 = 0x00000081
      if (spy_gpr(12) /= 32x"00000081") then
         report "ERROR: addi  x12, x0,   129   # x12 = 0x00000081";
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x13, x0,   24    # x13 = 0x00000018
      if (spy_gpr(13) /= 32x"00000018") then
         report "ERROR: addi  x13, x0,   24    # x13 = 0x00000018";
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x14, x0,   153   # x14 = 0x00000099
      if (spy_gpr(14) /= 32x"00000099") then
         report "ERROR: addi  x14, x0,   153   # x14 = 0x00000099";
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);








      -- sb    x0,  255(x0)     # gpio = 00000000
      if (gpio_tb /= "00000000") then
         report "ERROR: sb    x0,  255(x0)      # gpio = 00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb    x1,  255(x0)     # gpio = 00000001
      if (gpio_tb /= "00000001") then
         report "ERROR: sb    x1,  255(x0)     # gpio = 00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
         report "GPIO: " & to_string(gpio_tb);
      end if;
      wait until rising_edge(clk_tb);
      -- sb    x2,  4(x6)       # gpio = 00000010
      if (gpio_tb /= "00000010") then
         report "ERROR: sb    x2,  4(x6)       # gpio = 00000010 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb    x3,  255(x0)     # gpio = 00000100
      if (gpio_tb /= "00000100") then
         report "ERROR: sb    x3,  255(x0)     # gpio = 00000100 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb    x4,  255(x0)     # gpio = 00001000
      if (gpio_tb /= "00001000") then
         report "ERROR: sb    x4,  255(x0)     # gpio = 00001000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb    x5,  255(x0)     # gpio = 00001111
      if (gpio_tb /= "00001111") then
         report "ERROR: sb    x5,  255(x0)     # gpio = 00001111 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);



      -- sb    x7,  255(x0)     # gpio = 00011111
      if (gpio_tb /= "00011111") then
         report "ERROR: sb    x7,  255(x0)     # gpio = 00011111 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb    x8,  255(x0)     # gpio = 00101111
      if (gpio_tb /= "00101111") then
         report "ERROR: sb    x8,  255(x0)     # gpio = 00101111 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb    x9,  255(x0)     # gpio = 01001111
      if (gpio_tb /= "01001111") then
         report "ERROR: sb    x9,  255(x0)     # gpio = 01001111 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb    x10, 255(x0)     # gpio = 10001111
      if (gpio_tb /= "10001111") then
         report "ERROR: sb    x10, 255(x0)     # gpio = 10001111 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb    x11, 255(x0)     # gpio = 11111111
      if (gpio_tb /= "11111111") then
         report "ERROR: sb    x11, 255(x0)     # gpio = 11111111 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb    x12, 255(x0)     # gpio = 10000001
      if (gpio_tb /= "10000001") then
         report "ERROR: sb    x12, 255(x0)     # gpio = 10000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb    x13, 255(x0)     # gpio = 00011000
      if (gpio_tb /= "00011000") then
         report "ERROR: sb    x13, 255(x0)     # gpio = 00011000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb    x14, 255(x0)     # gpio = 10011001
      if (gpio_tb /= "10011001") then
         report "ERROR: sb    x14, 255(x0)     # gpio = 10011001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb    x0,  255(x0)     # gpio = 00000000
      if (gpio_tb /= "00000000") then
         report "ERROR: sb    x0,  255(x0)     # gpio = 00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      ----------------------------------------------------------------
      --                                                            --
      -- Special instructions, behavior check in case of invalid    --
      -- opcode etc.                                                --
      --                                                            --
      ----------------------------------------------------------------
      -- TODO: Change above description
      -- addi  x1,  x0,   0     # The value x1 is assigned to GPIO
      if (spy_gpr(1) /= 32x"00000000") then
         report "ERROR: addi  x1,  x0,   0  # x1 = 0x00000000";
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x2,  x0,   15    # The value x1 is compared to the value of x2
      if (spy_gpr(2) /= 32x"0000000f") then
         report "ERROR: addi  x2,  x0,   15  # x2 = 0x0000000f";
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x3,  x0,   0     # The value of x3 is compared to the value of x4
      if (spy_gpr(3) /= 32x"00000000") then
         report "ERROR: addi  x3,  x0,   0  # x3 = 0x00000000";
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x4,  x0,   10    # x4 = 10, in reality this value is too small
      if (spy_gpr(4) /= 32x"0000000a") then
         report "ERROR: addi  x4,  x0,   10  # x4 = 0x0000000a";
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x1,  x1,   1
      if (spy_gpr(1) /= 32x"00000001") then
         report "ERROR: addi  x1,  x1,   1   # x1 = 0x00000001";
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb    x1,  255(x0)     # Assign the value of x1 to GPIO
      if (gpio_tb /= "00000001") then
         report "ERROR: sb    x1,  255(x0)     # gpio = 00000001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait for C_CLK_PERIOD*24; -- This delay is required, coz the algorithm
      -- changes the GPIO state every 12 clock cycles if the GPIO change is 
      -- correct.
      -- sb    x1,  255(x0)     # Assign the value of x1 to GPIO
      if (gpio_tb /= "00000010") then
         report "ERROR: sb    x1,  255(x0)     # gpio = 00000010 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait for C_CLK_PERIOD*24;
      -- sb    x1,  255(x0)     # Assign the value of x1 to GPIO
      if (gpio_tb /= "00000011") then
         report "ERROR: sb    x1,  255(x0)     # gpio = 00000011 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait for C_CLK_PERIOD*24;
      -- sb    x1,  255(x0)     # Assign the value of x1 to GPIO
      if (gpio_tb /= "00000100") then
         report "ERROR: sb    x1,  255(x0)     # gpio = 00000100 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait for C_CLK_PERIOD*24;
      -- sb    x1,  255(x0)     # Assign the value of x1 to GPIO
      if (gpio_tb /= "00000101") then
         report "ERROR: sb    x1,  255(x0)     # gpio = 00000101 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait for C_CLK_PERIOD*24;
      -- sb    x1,  255(x0)     # Assign the value of x1 to GPIO
      if (gpio_tb /= "00000110") then
         report "ERROR: sb    x1,  255(x0)     # gpio = 00000110 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait for C_CLK_PERIOD*24;
      -- sb    x1,  255(x0)     # Assign the value of x1 to GPIO
      if (gpio_tb /= "00000111") then
         report "ERROR: sb    x1,  255(x0)     # gpio = 00000111 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait for C_CLK_PERIOD*24;
      -- sb    x1,  255(x0)     # Assign the value of x1 to GPIO
      if (gpio_tb /= "00001000") then
         report "ERROR: sb    x1,  255(x0)     # gpio = 00001000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait for C_CLK_PERIOD*24;
      -- sb    x1,  255(x0)     # Assign the value of x1 to GPIO
      if (gpio_tb /= "00001001") then
         report "ERROR: sb    x1,  255(x0)     # gpio = 00001001 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait for C_CLK_PERIOD*24;
      -- sb    x1,  255(x0)     # Assign the value of x1 to GPIO
      if (gpio_tb /= "00001010") then
         report "ERROR: sb    x1,  255(x0)     # gpio = 00001010 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait for C_CLK_PERIOD*24;
      -- sb    x1,  255(x0)     # Assign the value of x1 to GPIO
      if (gpio_tb /= "00001011") then
         report "ERROR: sb    x1,  255(x0)     # gpio = 00001011 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait for C_CLK_PERIOD*24;                  
      -- sb    x1,  255(x0)     # Assign the value of x1 to GPIO
      if (gpio_tb /= "00001100") then
         report "ERROR: sb    x1,  255(x0)     # gpio = 00001100 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait for C_CLK_PERIOD*24;
      -- sb    x1,  255(x0)     # Assign the value of x1 to GPIO
      if (gpio_tb /= "00001101") then
         report "ERROR: sb    x1,  255(x0)     # gpio = 00001101 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait for C_CLK_PERIOD*24;
      -- sb    x1,  255(x0)     # Assign the value of x1 to GPIO
      if (gpio_tb /= "00001110") then
         report "ERROR: sb    x1,  255(x0)     # gpio = 00001110 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait for C_CLK_PERIOD*24;
      -- sb    x1,  255(x0)     # Assign the value of x1 to GPIO
      if (gpio_tb /= "00001111") then
         report "ERROR: sb    x1,  255(x0)     # gpio = 00001111 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      wait for C_CLK_PERIOD*24; -- This delay is required, coz the algorithm
      -- changes the GPIO state every 12 clock cycles if the GPIO change is 
      -- correct.
      -- addi  x1,  x0,   0     # The value x1 is assigned to GPIO
      if (spy_gpr(1) /= 32x"00000000") then
         report "ERROR: addi  x1,  x0,   0  # x1 = 0x00000000";
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x3,  x0,   0     # The value x1 is assigned to GPIO
      if (spy_gpr(3) /= 32x"00000000") then
         report "ERROR: addi  x3,  x0,   0  # x3 = 0x00000000";
         set_test_point <= set_test_point + 1;
      end if;
      wait until rising_edge(clk_tb);
      -- sb    x0,  255(x0)     # Assign the value of x1 to GPIO
      if (gpio_tb /= "00000000") then
         report "ERROR: sb    x0,  255(x0)     # gpio = 00000000 | Test_point: "
         & integer'image(set_test_point+1);
         set_test_point <= set_test_point + 1;
      end if;
      -- TODO: Add test for reset

      report "Total errors: " & integer'image(set_test_point);
      wait for 1 us;
      stop(2);
   end process p_tb;

end architecture tb;
