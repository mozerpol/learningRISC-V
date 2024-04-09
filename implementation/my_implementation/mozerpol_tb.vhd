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
      --------------
      --   XORI   --
      --------------
      --------------
      --   ORI    --
      --------------
      --------------
      --   ANDI   --
      --------------
      --------------
      --   SLLI   --
      --------------
      --------------
      --   SRLI   --
      --------------
      --------------
      --   SRAI   --
      --------------
      
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
