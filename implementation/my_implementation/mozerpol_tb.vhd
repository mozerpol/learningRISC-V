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


      wait for 2000 ns;
      stop(2);
   end process p_tb;

end architecture tb;
