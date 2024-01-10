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

entity mozerpol_tb is
end mozerpol_tb;

architecture tb of mozerpol_tb is


   component mozerpol is
   port (
      i_rst       : in std_logic;
      i_clk       : in std_logic
   );
   end component mozerpol;

   signal rst_tb  : std_logic;
   signal clk_tb  : std_logic;
   type t_gpr  is array(0 to 31) of std_logic_vector(31 downto 0);

begin

   inst_mozerpol : component mozerpol
   port map (
      i_rst       => rst_tb,
      i_clk       => clk_tb
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
   begin
      rst_tb   <= '1';
      wait for 20 ns;
      rst_tb   <= '0';
      wait until rising_edge(clk_tb);
      wait until rising_edge(clk_tb);
      wait until rising_edge(clk_tb);
      report "===========GPR===========: " & to_string(spy_gpr(1));

      ------------------
      --    I-type    --
      ------------------
      -- addi  x1,  x0,   -1    # x1 = 0xffffffff
      if (spy_gpr(1) /= 32x"ffffffff") then
         report "ERROR: addi  x1, x0, -1";
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x2,  x0,   -2    # x2 = 0xfffffffe
      if (spy_gpr(2) /= 32x"fffffffe") then
         report "ERROR: addi x2, x0, -2";
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x3,  x0,   -1    # x3 = 0xffffffff
      if (spy_gpr(3) /= 32x"ffffffff") then
         report "ERROR: addi x3, x0, -1";
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x3,  x3,   2     # x3 = 0x00000001
      if (spy_gpr(3) /= 32x"00000001") then
         report "ERROR: addi x3, x3, 2";
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x4,  x0,   2047  # x4 = 0x000007ff
      if (spy_gpr(4) /= 32x"000007ff") then
         report "ERROR: x4, x0, 2047";
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x5,  x0,   -2048 # x5 = 0xfffff800
      if (spy_gpr(5) /= 32x"fffff800") then
         report "ERROR: addi x5, x0, -2048";
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x5,  x5,   0     # x5 = 0x00000001
      if (spy_gpr(5) /= 32x"00000001") then
         report "ERROR: slti x5, x5, 0";
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x6,  x2,   2     # x6 = 0x00000001
      if (spy_gpr(6) /= 32x"00000001") then
         report "ERROR: slti x6, x2, 2";
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x7,  x6,   -2    # x7 = 0x00000000
      if (spy_gpr(7) /= 32x"00000000") then
         report "ERROR: slti x7, x6, -2";
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x8,  x4,   1     # x8 = 0x00000000
      if (spy_gpr(8) /= 32x"00000000") then
         report "ERROR: slti x8, x4, 1";
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x9,  x3,  2047   # x11 = 0x00000001
      if (spy_gpr(9) /= 32x"00000001") then
         report "ERROR: slti x9, x3, 2047";
      end if;
      wait until rising_edge(clk_tb);
      -- slti  x10, x3,  -2048  # x12 = 0x00000000
      if (spy_gpr(10) /= 32x"00000000") then
         report "ERROR: slti x10, x3, -2048";
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x11, x11, 0      # x11 = 0x00000000
      if (spy_gpr(11) /= 32x"00000000") then
         report "ERROR: sltiu x11, x11, 0";
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x12, x4,  2      # x12 = 0x00000000
      if (spy_gpr(12) /= 32x"00000000") then
         report "ERROR: sltiu x12, x4, 2";
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x13, x4,  -2     # x13 = 0x00000001
      if (spy_gpr(13) /= 32x"00000001") then
         report "ERROR: sltiu x13, x4, -2";
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x14, x5,  2047   # x14 = 0x00000001
      if (spy_gpr(14) /= 32x"00000001") then
         report "ERROR: sltiu x14, x5, 2047";
      end if;
      wait until rising_edge(clk_tb);
      -- sltiu x15, x5,  -2048  # x15 = 0x00000001
      if (spy_gpr(15) /= 32x"00000001") then
         report "ERROR: x15, x5, -2048";
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x16, x1,  0      # x16 = 0xffffffff
      if (spy_gpr(16) /= 32x"ffffffff") then
         report "xori x16, x1, 0";
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x17, x1,  1      # x17 = 0xfffffffe
      if (spy_gpr(17) /= 32x"fffffffe") then
         report "xori x17, x1, 1";
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x18, x4,  21     # x18 = 0x000007ea
      if (spy_gpr(18) /= 32x"000007ea") then
         report "ERROR: xori x18, x4, 21";
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x19, x4,  -21    # x19 = 0xfffff814
      if (spy_gpr(19) /= 32x"fffff814") then
         report "ERROR: xori x19, x4, -21";
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x20, x4,  2047   # x20 = 0x00000000
      if (spy_gpr(20) /= 32x"00000000") then
         report "ERROR: xori x20, x4, 2047";
      end if;
      wait until rising_edge(clk_tb);
      -- xori  x21, x4,  -2048  # x21 = 0xffffffff
      if (spy_gpr(21) /= 32x"ffffffff") then
         report "ERROR: xori x21, x4, -2048";
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x22, x4,  0      # x22 = 0x000007ff
      if (spy_gpr(22) /= 32x"000007ff") then
         report "ERR2OR: ori x22, x4, 0";
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x23, x3,  1      # x23 = 0x00000001
      if (spy_gpr(23) /= 32x"00000001") then
         report "ERROR: ori x23, x3, 1";
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x24, x3,  21     # x24 = 0x00000015
      if (spy_gpr(24) /= 32x"00000015") then
         report "ERROR: ori x24, x3, 21";
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x25, x4,  -21    # x25 = 0xffffffff 
      if (spy_gpr(25) /= 32x"ffffffff") then
         report "ERROR: ori x25, x4, -21";
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x26, x4,  2047   # x26 = 0x000007ff
      if (spy_gpr(26) /= 32x"000007ff") then
         report "ERROR: ori x26, x4, 2047";
      end if;
      wait until rising_edge(clk_tb);
      -- ori   x27, x4,  -2048  # x27 = 0xffffffff
      if (spy_gpr(27) /= 32x"ffffffff") then
         report "ERROR: ori x27, x4, -2048";
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x28, x4,  0      # x28 = 0x00000000
      if (spy_gpr(28) /= 32x"00000000") then
         report "ERROR: andi x28, x4, 0";
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x29, x4,  1      # x29 = 0x00000001
      if (spy_gpr(29) /= 32x"00000001") then
         report "ERROR: andi x29, x4, 1";
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x30, x4,  21     # x30 = 0x00000015
      if (spy_gpr(30) /= 32x"00000015") then
         report "ERROR: andi x30, x4, 21";
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x31, x4,  -21    # x31 = 0x000007eb
      if (spy_gpr(31) /= 32x"000007eb") then
         report "ERROR: andi x31, x4, -21";
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x1,  x4,  2047   # x1 = 0x000007ff
      if (spy_gpr(1) /= 32x"000007ff") then
         report "ERROR: andi x1, x4, 2047";
      end if;
      wait until rising_edge(clk_tb);
      -- andi  x2,  x4,  -2048  # x2 = 0x00000000
      if (spy_gpr(2) /= 32x"00000000") then
         report "ERROR: andi x2, x4, -2048";
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x3,  x2,  0      # x3 = 0x00000000
      if (spy_gpr(3) /= 32x"00000000") then
         report "ERROR: addi x3, x2, 0";
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x3,  x2,  -1     # x3 = 0xffffffff
      if (spy_gpr(3) /= 32x"ffffffff") then
         report "ERROR: addi x3, x2, -1";
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x4,  x1,  21     # x4 = 0x00000814
      if (spy_gpr(4) /= 32x"00000814") then
         report "ERROR: addi x4, x1, 21";
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x5,  x1,  2047   # x5 = 0x00000ffe
      if (spy_gpr(5) /= 32x"00000ffe") then
         report "ERROR: addi x5, x1, 2047";
      end if;
      wait until rising_edge(clk_tb);
      -- addi  x6,  x1,  -2048  # x6 = 0xffffffff
      if (spy_gpr(6) /= 32x"ffffffff") then
         report "ERROR: addi x6, x1, -2048";
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x7,  x2,  0      # x7 = 0x00000000
      if (spy_gpr(7) /= 32x"00000000") then
         report "ERROR: slli x7, x2, 0";
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x8,  x2,  1      # x8 = 0x00000000
      if (spy_gpr(8) /= 32x"00000000") then
         report "ERROR: slli x8, x2, 1";
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x9,  x29, 1      # x9 = 0x00000002
      if (spy_gpr(9) /= 32x"000000002") then
         report "ERROR: slli x9, x29, 1";
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x10, x29, 31     # x10 = 0x80000000
      if (spy_gpr(10) /= 32x"80000000") then
         report "ERROR: slli x10, x29, 31";
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x9,  x9,  1      # x9 = 0x00000004
      if (spy_gpr(9) /= 32x"00000004") then
         report "ERROR: slli x9, x9, 1";
      end if;
      wait until rising_edge(clk_tb);
      -- slli  x11, x27, 31     # x11 = 0x80000000
      if (spy_gpr(11) /= 32x"80000000") then
         report "ERROR: slli x11, x27, 31";
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x12, x2,  0      # x12 = 0x00000000
      if (spy_gpr(12) /= 32x"00000000") then
         report "ERROR: srli x12, x2, 0";
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x13, x2,  1      # x13 = 0x00000000
      if (spy_gpr(13) /= 32x"00000000") then
         report "ERROR: srli x13, x2, 1";
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x14, x29, 1      # x14 = 0x00000000
      if (spy_gpr(14) /= 32x"00000000") then
         report "ERROR: srli x14, x29, 1";
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x15, x29, 31     # x15 = 0x00000000
      if (spy_gpr(15) /= 32x"00000000") then
         report "ERROR: srli x15, x29, 31";
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x16, x16, 1      # x16 = 0x7fffffff
      if (spy_gpr(16) /= 32x"7fffffff") then
         report "ERROR: srli x16, x16, 1";
      end if;
      wait until rising_edge(clk_tb);
      -- srli  x17, x27, 31     # x17 = 0x00000001
      if (spy_gpr(17) /= 32x"00000001") then
         report "ERROR: srli x17, x27, 31";
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x18, x2, 0       # x18 = 0x00000000
      if (spy_gpr(18) /= 32x"00000000") then
         report "ERROR: srai x18, x2, 0";
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x19, x2, 1       # x19 = 0x00000000
      if (spy_gpr(19) /= 32x"00000000") then
         report "ERROR: srai x19, x2, 1";
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x20, x1, 1       # x20 = 0x000003ff
      if (spy_gpr(20) /= 32x"000003ff") then
         report "ERROR: srai x20, x1, 1";
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x21, x1, 31      # x21 = 0x00000000
      if (spy_gpr(21) /= 32x"00000000") then
         report "ERROR: srai x21, x1, 31";
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x22, x3, 1       # x22 = 0xffffffff
      if (spy_gpr(22) /= 32x"ffffffff") then
         report "ERROR: srai x22, x3, 1";
      end if;
      wait until rising_edge(clk_tb);
      -- srai  x23, x3, 31      # z23 = 0xffffffff
      if (spy_gpr(23) /= 32x"ffffffff") then
         report "ERROR: srai x23, x3, 31";
      end if;
      wait until rising_edge(clk_tb);
      
      wait for 10 ns;
      stop(2);
   end process p_tb;

end architecture tb;
