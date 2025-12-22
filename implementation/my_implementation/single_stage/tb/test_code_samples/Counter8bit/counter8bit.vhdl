      --------------------------------------------------------------------------
      --                                                                      --
      --                            COUNTER 8-BIT                             --
      --                                                                      --
      --------------------------------------------------------------------------
      check_gpr("addi  x1,  x0,   0x2", x"00000002", clk_tb, test_point);
      check_gpr("addi  x2,  x0,   0x212", x"00000212", clk_tb, test_point);
      check_gpr("addi  x3,  x0,   0x1", x"00000001", clk_tb, test_point);
      check_gpr("addi  x4,  x0,   0x0", x"00000000", clk_tb, test_point);
      wait until rising_edge(clk_tb); -- Have to wait one additional clock cycle
      -- the counter value will be readable (stabilized).
      check_cnt("sb    x3,  251(x0)", 1, clk_tb, test_point);
      check_cnt("sb    x0,  251(x0)", 0, clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_cnt("sb    x3,  251(x0)", 1, clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_cnt("sb    x0,  251(x0)", 0, clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_cnt("sb    x3,  251(x0)", 1, clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"00000001", clk_tb, test_point);
      for i in 0 to 1056 loop
         -- A loop while the timer is counting.
         -- bne x4, x2, -4   fe221ee3
         -- addi x4, x4, 1   00120213
         wait until rising_edge(clk_tb);
      end loop;
      check_gpr("addi  x4,  x0,   0x0", x"00000212", clk_tb, test_point);
      check_cnt("sb    x0,  251(x0)", 37, clk_tb, test_point);
      check_gpr("addi  x4,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_cnt("sb    x3,  251(x0)", 0, clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_gpr("lw    x5,  251(x0)", x"00000003", clk_tb, test_point);
      check_cnt("sb    x0,  251(x0)", 5, clk_tb, test_point);
