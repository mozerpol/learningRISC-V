      --------------------------------------------------------------------------
      --                                                                      --
      --                              LB, LH, LW                              --
      --                                                                      --
      --------------------------------------------------------------------------
      -------------------------------------
      --         Prepare registers       --
      -------------------------------------
      check_gpr("addi  x1,  x0,   1", x"00000001", clk_tb, test_point);
      check_gpr("addi  x2,  x0,   2", x"00000002", clk_tb, test_point);
      check_gpr("addi  x3,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x7,  x0,   -1024", x"fffffc00", clk_tb, test_point);
      check_gpr("lui   x8,  0xE", x"0000e000", clk_tb, test_point);
      check_gpr("addi  x8,  x8,   0xF1", x"0000e0f1", clk_tb, test_point);
      -------------------------------------
      --          Prepare memory         --
      -------------------------------------
      check_ram("sw   x7,  0(x0)", x"fffffc00", 0, 0, clk_tb, test_point);
      check_ram("sw   x7,  2(x2)", x"fffffc00", 0, 0, clk_tb, test_point);
      check_ram("sh    x8,  10(x0)", x"0000e0f1", 2, 2, clk_tb, test_point);
      -------------------------------------
      --                LB               --
      -------------------------------------
      check_gpr("lb    x3,  0(x1)", x"fffffffc", clk_tb, test_point);
      check_gpr("lb    x4,  0(x2)", x"ffffffff", clk_tb, test_point);
      check_gpr("lb    x5,  11(x0)", x"ffffffe0", clk_tb, test_point);
      check_gpr("lb    x7,  -1(x2)", x"fffffffc", clk_tb, test_point);
      check_gpr("lb    x8,  -2(x2)", x"00000000", clk_tb, test_point);
      check_gpr("lb    x12, 4(x3)", x"00000000", clk_tb, test_point);
      check_gpr("lb    x13, 15(x3)", x"ffffffe0", clk_tb, test_point);
      -------------------------------------
      --                LH               --
      -------------------------------------
      check_gpr("lh    x14, 0(x2)", x"ffffffff", clk_tb, test_point);
      check_gpr("lh    x15, 10(x0)", x"ffffe0f1", clk_tb, test_point);
      check_gpr("lh    x17, 4(x3)", x"fffffc00", clk_tb, test_point);
      -------------------------------------
      --                LW               --
      -------------------------------------
      check_gpr("lw    x18, 2(x2)", x"fffffc00", clk_tb, test_point);
      check_gpr("lw    x21, 4(x3)", x"fffffc00", clk_tb, test_point);
      -------------------------------------
      --               LBU               --
      -------------------------------------
      check_gpr("addi  x1,  x0,   1", x"00000001", clk_tb, test_point);
      check_gpr("lbu   x2,  1(x0)", x"000000fc", clk_tb, test_point);
      check_gpr("lbu   x3,  1(x1)", x"000000ff", clk_tb, test_point);
      -------------------------------------
      --               LHU               --
      -------------------------------------
      check_gpr("lhu   x4,  4(x0)", x"0000fc00", clk_tb, test_point);
      check_gpr("lhu   x5,  1(x1)", x"0000ffff", clk_tb, test_point);
