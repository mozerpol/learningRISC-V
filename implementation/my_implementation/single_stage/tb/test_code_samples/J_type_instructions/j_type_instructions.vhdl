      --------------------------------------------------------------------------
      --                                                                      --
      --                               JAL, JALR                              --
      --                                                                      --
      --------------------------------------------------------------------------
      -------------------------------------
      --        Prepare registers        --
      -------------------------------------
      check_gpr("addi  x1,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x12,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x13,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x14,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x16,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x17,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x18,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x19,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x20,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x21,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x22,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x23,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x24,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x25,  x0,   0", x"00000000", clk_tb, test_point);
      -------------------------------------
      --               JAL               --
      -------------------------------------
      wait until rising_edge(clk_tb); -- auipc x12, 0
      wait until rising_edge(clk_tb); -- jal   x13, loop22
      check_gpr("addi  x1,  x1,   1", x"00000001", clk_tb, test_point);
      check_gpr("sub   x14, x13,  x12", x"00000008", clk_tb, test_point);
      wait until rising_edge(clk_tb); -- jal   x14, loop23
      check_gpr("addi  x1,  x1,   1", x"00000002", clk_tb, test_point);
      check_gpr("addi  x1,  x1,   1", x"00000003", clk_tb, test_point);
      wait until rising_edge(clk_tb); -- jal   x16, loop24
      check_gpr("addi  x1,  x1,   1", x"00000004", clk_tb, test_point);
      check_gpr("sub   x17, x16,  x14", x"fffffff4", clk_tb, test_point);
      check_gpr("addi  x1,  x0,   0", x"00000000", clk_tb, test_point);
      -------------------------------------
      --               JALR              --
      -------------------------------------
      wait until rising_edge(clk_tb); -- auipc x18, 0
      wait until rising_edge(clk_tb); -- jalr  x19, x18,  8
      check_gpr("sub   x20, x19,  x18", x"00000008", clk_tb, test_point);
      wait until rising_edge(clk_tb); -- jalr  x20, x18,  32
      wait until rising_edge(clk_tb); -- auipc x21, 0
      check_gpr("sub   x21, x21,  x20", x"00000010", clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x21,  0
      wait until rising_edge(clk_tb); -- jalr  x22, x21,  -24
      check_gpr("addi  x1,  x1,   1", x"00000001", clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x23,  0
      check_gpr("sub   x24, x22,  x21", x"00000008", clk_tb, test_point);
      wait until rising_edge(clk_tb); -- jalr  x24, x23,  28
      check_gpr("addi  x1,  x1,   1", x"00000002", clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x25,  0
      check_gpr("sub   x25, x25,  x24", x"00000014", clk_tb, test_point);
